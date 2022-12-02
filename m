Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8240863FD06
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 01:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiLBA1V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 19:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiLBA0f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 19:26:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D5FD78DE
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 16:21:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56B85621D2
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 00:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6066EC433B5;
        Fri,  2 Dec 2022 00:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669940493;
        bh=IS7rd7rcz6gVpwRJ0tJXC7rhdgZaY2/fgyU9ObJPI5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KWdLTbyZw6FD2y1dEc0h4hUfAw8464ePoanpcVIdyrak4PprQq8PxsPn1UUcrc8Sc
         Q9f7PApwg5oS/44kZo9xNhUVZoDfig2BV4mrEPgycamJTz/5j4w/LYT4qzv1pva5T4
         XuWyJZ53ebqkEQxhV2nN57oezbGJuNAQFjjZlMQorXzZJQ/52TLOuW+869yh+6m3dT
         gRYBUu5WpdXEzcK+1/2MtjQXNypRcirjhPZwpSfL1Ut+oIC8M5mrDla9oS49UAjVvG
         7XXEnhr88ICj6O8Gdxle+wE7l9Vh/8J6B30mAwPDYrVLZqdepUGHEDyzfHFVfwUz6S
         dFo7TwUUqXJgg==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 7/7] kselftest/alsa: pcm - Add more coverage by default
Date:   Fri,  2 Dec 2022 00:17:49 +0000
Message-Id: <20221202001749.3321187-8-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202001749.3321187-1-broonie@kernel.org>
References: <20221202001749.3321187-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2103; i=broonie@kernel.org; h=from:subject; bh=IS7rd7rcz6gVpwRJ0tJXC7rhdgZaY2/fgyU9ObJPI5Q=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjiUQsmgfNGHKOyR2nQQ0g8wGVV9lgyN9d+BfKhoRB DB3xuZaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4lELAAKCRAk1otyXVSH0PtDB/ 4gY8OkdnwpR37jPZrDF0R/dLp0g3ttzwQz0tuLDVznS8yA3Mo4Mf82os5jYW27sKRp6h0m6Ok25Q4R z4EV0mSsg9TVhikFfGZ46cDGtIY255Lx5sTxymEBPxXWn8NqoGpNrCkKVf7ek2dAnPnHuor8wJsm3S r8kRHRgnxoiypLVvapPXg20t8WoO93oFixEC/wTiX6wnhyVmjp6zdSaWYMGLA9oVVDNh4Q68rwlgwA KpigtY/fdow0SZOsJ06ZTrehq6XH5yzHSFhPnk/r9/R508sEZKYU9vllaswIrQLPf3wcM5OgXFGBtP RcNDRE8WHC4H9dvJdtUJ5VvQFe1VcZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add more coverage to our standard test cases:

 - 8kHz mono and stereo to verify that the most common mono format is
   clocked correctly.
 - 44.1kHz stereo to verify that this different clock base is generated
   accurately.
 - 48kHz 6 channel to verify that 6 channel is clocked correctly.
 - 96kHz stereo since that is a common audiophile rate.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.conf | 47 +++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.conf b/tools/testing/selftests/alsa/pcm-test.conf
index 1662a8c7073e..71bd3f78a6f2 100644
--- a/tools/testing/selftests/alsa/pcm-test.conf
+++ b/tools/testing/selftests/alsa/pcm-test.conf
@@ -1,4 +1,31 @@
 pcm.test.time1 {
+	description "8kHz mono large periods"
+	format S16_LE
+	alt_formats [ S32_LE ]
+	rate 8000
+	channels 1
+	period_size 8000
+	buffer_size 32000
+}
+pcm.test.time2 {
+	description "8kHz stereo large periods"
+	format S16_LE
+	alt_formats [ S32_LE ]
+	rate 8000
+	channels 2
+	period_size 8000
+	buffer_size 32000
+}
+pcm.test.time3 {
+	description "44.1kHz stereo large periods"
+	format S16_LE
+	alt_formats [ S32_LE ]
+	rate 44100
+	channels 2
+	period_size 22500
+	buffer_size 192000
+}
+pcm.test.time4 {
 	description "48kHz stereo small periods"
 	format S16_LE
 	alt_formats [ S32_LE ]
@@ -7,7 +34,7 @@ pcm.test.time1 {
 	period_size 512
 	buffer_size 4096
 }
-pcm.test.time2 {
+pcm.test.time5 {
 	description "48kHz stereo large periods"
 	format S16_LE
 	alt_formats [ S32_LE ]
@@ -16,3 +43,21 @@ pcm.test.time2 {
 	period_size 24000
 	buffer_size 192000
 }
+pcm.test.time6 {
+	description "48kHz 6 channel large periods"
+	format S16_LE
+	alt_formats [ S32_LE ]
+	rate 48000
+	channels 2
+	period_size 48000
+	buffer_size 576000
+}
+pcm.test.time7 {
+	description "96kHz stereo large periods"
+	format S16_LE
+	alt_formats [ S32_LE ]
+	rate 96000
+	channels 2
+	period_size 48000
+	buffer_size 192000
+}
-- 
2.30.2

