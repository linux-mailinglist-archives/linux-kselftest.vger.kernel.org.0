Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0181656D41
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 18:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiL0RIN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 12:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiL0RHk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 12:07:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5CCBF6A;
        Tue, 27 Dec 2022 09:07:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E202611D1;
        Tue, 27 Dec 2022 17:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E40C433AF;
        Tue, 27 Dec 2022 17:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672160852;
        bh=uxaBKlEBdgL2vH6RIInA6fuLSoTpmrLUhjWBaHzLQMY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=B0vvlwYeBFVsH5dzWcS9zGctixO+BcVewUGdlEbOSaTLz6q4UGTMnJfw5wtWPC8Ki
         Z//pmIfDhIzmK9aBnkuh2SLvCJnSrzzjX+h/JxoW+h6XHL0aOecAWUC+te1OVgBEmU
         KkAlT0XTbuomePlmuHknbIuoG7N6GWr5hClA9oXnDOuzJQrXP7D+21w6h57Vea2BMM
         x4c9/BMJ0LyOWy6X+nvuR2HaonZKqwJPUKhlQ4b9aeU2vPJR4VokQ/5+kzLQEdEcgV
         /yRcqvwCYLrJFYPJseOWvfSqhtWTIZOQgfyLeybXhOo9khAAeF+1SDbFcQdmbwKt2X
         omC8FY3PycjcQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 17:06:52 +0000
Subject: [PATCH v4 7/7] kselftest/alsa: pcm - Add more coverage by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-alsa-pcm-test-hacks-v4-7-5a152e65b1e1@kernel.org>
References: <20221208-alsa-pcm-test-hacks-v4-0-5a152e65b1e1@kernel.org>
In-Reply-To: <20221208-alsa-pcm-test-hacks-v4-0-5a152e65b1e1@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uxaBKlEBdgL2vH6RIInA6fuLSoTpmrLUhjWBaHzLQMY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqyZF4AynULWOON7IsKhfOyuMp8d1cKEzp28jmiLn
 bAKabXmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6smRQAKCRAk1otyXVSH0L4CB/
 9Y/IcV/hbQxayzYQsUYnwl4bcP73J3w9Q8D4DLLlcycEy9+CT7NbYvB17FUeibbOMc4XoojPKLTSpV
 qcaYQ9DSDtHboeRb70V7brVMWPnWDKiDXL2U84cDKqt2TFa7PJu8LnutT2N5ko/3UAu3UtAgA8/akI
 wiOevp+bm+amAgoHMuqFVwh2XVDuVWRZr60Ib2HsLDYgImHhSgudVrxvzF4sgpyg5u2xKHqFPUcWc+
 Y5Oi2RMVA0FwgMYR78oZeUYPqOwdHWzIuqCueNshnmMhCy+k11lLh8Y9rsuQq4eoW/lNRzohzQUIzE
 Co6Kr1lvBNNjZEbIhPZEOM8aaV1Elv
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
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

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.conf | 47 +++++++++++++++++++++++++++++-
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
