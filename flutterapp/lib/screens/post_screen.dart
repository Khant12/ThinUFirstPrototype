import 'package:flutter/material.dart';
import 'package:flutter_app/constant.dart';
import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/post.dart';
import 'package:flutter_app/services/post_service.dart';
import 'package:flutter_app/services/user_service.dart';
import 'package:readmore/readmore.dart';

import 'login.dart';
import 'post_form.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<dynamic> _postList = [];
  int userId = 0;
  bool _loading = true;

  // get all posts
  Future<void> retrievePosts() async {
    userId = await getUserId();
    ApiResponse response = await getPosts();

    if (response.error == null) {
      setState(() {
        _postList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  void _handleDeletePost(int postId) async {
    ApiResponse response = await deletePost(postId);
    if (response.error == null) {
      retrievePosts();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  // post like dislik
  void _handlePostLikeDislike(int postId) async {
    ApiResponse response = await likeUnlikePost(postId);

    if (response.error == null) {
      retrievePosts();
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  @override
  void initState() {
    retrievePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () {
              return retrievePosts();
            },
            child: ListView.builder(
                itemCount: _postList.length,
                itemBuilder: (BuildContext context, int index) {
                  Post post = _postList[index];
                  return Card(
                      color: Colors.white,
                      elevation: 6,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            12), // Adjust the border radius as needed
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Image.asset(
                              'images/uc.png',
                              width: 75,
                              height: 75,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Image.asset(
                              'images/articlebg.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            image: post.user!.image != null
                                                ? DecorationImage(
                                                    image: NetworkImage(
                                                        '${post.user!.image}'))
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                              color: Colors
                                                  .lightBlue, // Border color
                                              width: 2, // Border width
                                            ),
                                          ),
                                          child: const CircleAvatar(
                                            radius:
                                                20, // Adjust the radius to increase the size
                                            backgroundColor: Colors
                                                .grey, // Background color for the CircleAvatar
                                            child: Icon(
                                              Icons
                                                  .person, // You can replace this with your profile picture
                                              color: Colors.white, // Icon color
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${post.user!.name}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17),
                                        )
                                      ],
                                    ),
                                  ),
                                  post.user!.id == userId
                                      ? PopupMenuButton(
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.more_vert,
                                                color: Colors.black,
                                              )),
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                                child: Text('Edit'),
                                                value: 'edit'),
                                            PopupMenuItem(
                                                child: Text('Delete'),
                                                value: 'delete')
                                          ],
                                          onSelected: (val) {
                                            if (val == 'edit') {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PostForm(
                                                            title: 'Edit Post',
                                                            post: post,
                                                          )));
                                            } else {
                                              _handleDeletePost(post.id ?? 0);
                                            }
                                          },
                                        )
                                      : SizedBox()
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 5),
                                child: ReadMoreText(
                                  '${post.body}  ',
                                  colorClickableText: Colors.blueGrey,
                                  trimLength: 200,
                                  trimMode: TrimMode.Length,
                                  trimCollapsedText: 'Read more',
                                  trimExpandedText: 'Read less',
                                  moreStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  lessStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              post.image != null
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 280,
                                      margin: const EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage('${post.image}'),
                                              fit: BoxFit.cover)),
                                    )
                                  : SizedBox(
                                      height: post.image != null ? 0 : 10,
                                    ),
                              ButtonBar(
                                alignment: MainAxisAlignment.start,
                                children: [
                                  kLikeAndComment(
                                      post.likesCount ?? 0,
                                      post.selfLiked == true
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                      post.selfLiked == true
                                          ? Colors.red
                                          : Colors.black54, () {
                                    _handlePostLikeDislike(post.id ?? 0);
                                  }),
                                  Container(
                                    height: 25,
                                    width: 0.5,
                                    color: Colors.black38,
                                  ),
                                  // kLikeAndComment(post.commentsCount ?? 0,
                                  //     Icons.bookmark, Colors.black54, () {
                                  //   Navigator.of(context).push(MaterialPageRoute(
                                  //       builder: (context) => CommentScreen(
                                  //             postId: post.id,
                                  //           )));
                                  // }),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ));
                }),
          );
  }
}
