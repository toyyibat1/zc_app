import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zurichat/constants/app_strings.dart';
import 'package:zurichat/general_widgets/no_connection_widget.dart';
import 'package:zurichat/models/channel_model.dart';
import 'package:zurichat/ui/shared/zuri_appbar.dart';
import 'package:zurichat/ui/view/channel/channel_view/widgets/channel_intro.dart';
import 'package:zurichat/ui/view/expandable_textfield/expandable_textfield_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import '../../../shared/shared.dart';

import 'channel_page_viewmodel.dart';
import 'widgets/channel_chat.dart';
import 'channel_page_view.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'channelMessages'),
  ],
)
class ChannelPageView extends StatelessWidget with $ChannelPageView {
  ChannelPageView({
    Key? key,
    required this.channelName,
    required this.channelId,
    required this.membersCount,
    required this.public,
  }) : super(key: key);
  final String? channelName;
  final String? channelId;
  final int? membersCount;
  final bool? public;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChannelPageViewModel>.reactive(
      onModelReady: (model) {
        model.getDraft(channelId);
        model.initialise('$channelId');
        if (model.storedDraft.isNotEmpty) {
          channelMessagesController.text = model.storedDraft;
        }
        model.showNotificationForOtherChannels('$channelId', '$channelName');
      },
      //this parameter allows us to reuse the view model to persist the state
      viewModelBuilder: () => ChannelPageViewModel(),
      builder: (context, model, child) {
        if (model.scrollController.hasClients) {
          model.scrollController
              .jumpTo(model.scrollController.position.maxScrollExtent);
        }

        return Scaffold(
          appBar: ZuriAppBar(
            leading: Icons.arrow_back_ios,
            leadingPress: () => model.goBack(
                channelId,
                channelMessagesController.text,
                channelName,
                membersCount,
                public),
            whiteBackground: true,
            isDarkMode: Theme.of(context).brightness == Brightness.dark,
            actions: [
              // TODO FOR FUTURE
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(
              //     Icons.search,
              //     color: AppColors.textLight10,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: () => model.deleteChannel(
                    ChannelModel(id: channelId!, name: channelName!),
                  ),
                  child: SvgPicture.asset(
                    Log_Out,
                    color: AppColors.unreadMessageColor,
                    width: 20,
                    height: 20,
                  ),
                ),
                // child: IconButton(
                //   onPressed: () => model.navigateToChannelInfoScreen(
                //       membersCount!,
                //       ChannelModel(id: channelId!, name: channelName!),
                //       channelName!),
                //   icon: const Icon(
                //     Icons.info_outlined,
                //     color: AppColors.textLight10,
                //   ),
                // ),
              ),
            ],
            title: "#$channelName",
            subtitle:
                "${model.channelMembers.length} member${model.channelMembers.length == 1 ? "" : "s"}",
          ),
          body: ExpandableTextFieldScreen(
            usercheck: model.checkUser,
            channelName: '$channelName',
            channelId: '$channelId',
            channelID: channelId.toString(),
            textController: channelMessagesController,
            hintText: AddReply,
            sendMessage: model.sendMessage,
            widget: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: model.scrollController,
              reverse: false,
              child: Column(
                children: [
                  ChannelIntro(
                    channelName: channelName!,
                    channelId: channelId!,
                  ),
                  ChannelChat(
                    channelId: channelId,
                  ),
                  const NoConnectionWidget(Icons.wifi),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
