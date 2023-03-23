Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52226C707F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 19:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjCWSsx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 14:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjCWSst (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 14:48:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7870C1EBFB
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Mar 2023 11:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E31C8B8220B
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Mar 2023 18:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47367C433D2;
        Thu, 23 Mar 2023 18:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679597314;
        bh=0hW7ou4yKKzkx7XuuV6id7JupKItK72eoKHvINXaR/g=;
        h=From:Date:Subject:To:Cc:From;
        b=HqPjcFMXRRGfmNZl9SbWgq2UXbQeJguo7vNCSJgukRxSzyvtqDNFAMquWswFmBzKH
         xKjxAVul3SMHdelFUoroEgCTEup8RqTfB6AuIJhZD7V99jT7m7uZj6gHB9xyaibfke
         16yOKZbQwh7/DcFD8S54E532ry0wKtfa47xkzA763w3wVtzJXmqoSnJTNP5XLLItVD
         +vMRp/P9gYE/gxlaTunFfOW3f5Jrz11gJsPImNvorSwCgM8jWmzazl5TurI1KHMSZp
         SsaZ01uswqS9vp5kYb/mZ3RBmvU0qZ6mB8cEPPj/dYTlYZ8IcKRjYKH8NUqvSNCgb7
         vo5SKiIcvIQSQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 23 Mar 2023 18:48:28 +0000
Subject: [PATCH] kselftest/alsa - pcm-test: Don't include diagnostic
 message in test name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230323-alsa-pcm-test-names-v1-1-8be67a8885ff@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPueHGQC/x2NQQqDQAwAvyI5N6C7WNp+pfSQjWkNraskYgvi3
 117nIFhVnAxFYdbtYLJoq5jLtCcKuCe8ktQu8IQ6hDrGCLSxwknHnAWnzHTII6Ju9ik9nJmukI
 pE7lgMsrcH+13tPehJ5On/v6z+2PbdtOTZcx8AAAA
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0hW7ou4yKKzkx7XuuV6id7JupKItK72eoKHvINXaR/g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkHJ8ArrjYNOz4WBOk/FnbKxWklUcuQ1FG7p5o1Iov
 0w94Y92JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZByfAAAKCRAk1otyXVSH0KVpB/
 95WrxkkhbtiPCEmm8bG8RydT5ktpFzt1qrLZy0inaBl/htzrlxQVvFAbskJnSTO6BUx9CXLR+NSe0/
 GM6PZaRs9gxNBbJbDUYodigTluRSTvwOmS0veoiCrftnGSquU2nEIgy8N5A0oBFM4/LE9iUI/d8vr/
 XFKowdpqHGO4vWuzrY1AN/xrFpngzgysx7TfGtZDRtEOc+or0zKV6LbFz3WVSsU6XgTZaOPxIjHAhM
 exjLO7OwyMT1RfMUbagFY/QcrBZ+RuiTgL3jtGed5of0fl+ShKjWlNxQxRF9hvOdbryCEMrOWdgz+B
 3x+p8HCg5WPf8VSeyUK9chcrcBai/D
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When reporting errors or skips we currently include the diagnostic message
indicating why we're failing or skipping. This isn't ideal since KTAP
defines the entire print as the test name, so if there's an error then test
systems won't detect the test as being the same one as a passing test. Move
the diagnostic to a separate ksft_print_msg() to avoid this issue, the test
name part will always be the same for passes, fails and skips and the
diagnostic information is still displayed.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index 58b525a4a32c..bab56ea67e89 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -489,17 +489,18 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 	}
 
 	if (!skip)
-		ksft_test_result(pass, "%s.%s.%d.%d.%d.%s%s%s\n",
+		ksft_test_result(pass, "%s.%s.%d.%d.%d.%s\n",
 				 test_class_name, test_name,
 				 data->card, data->device, data->subdevice,
-				 snd_pcm_stream_name(data->stream),
-				 msg[0] ? " " : "", msg);
+				 snd_pcm_stream_name(data->stream));
 	else
-		ksft_test_result_skip("%s.%s.%d.%d.%d.%s%s%s\n",
+		ksft_test_result_skip("%s.%s.%d.%d.%d.%s\n",
 				 test_class_name, test_name,
 				 data->card, data->device, data->subdevice,
-				 snd_pcm_stream_name(data->stream),
-				 msg[0] ? " " : "", msg);
+				 snd_pcm_stream_name(data->stream));
+
+	if (msg[0])
+		ksft_print_msg("%s\n", msg);
 
 	pthread_mutex_unlock(&results_lock);
 

---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230323-alsa-pcm-test-names-bcd31b586ca9

Best regards,
-- 
Mark Brown <broonie@kernel.org>

