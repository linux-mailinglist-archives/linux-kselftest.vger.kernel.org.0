Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE0563CC2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 01:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiK3AHN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 19:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiK3AG7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 19:06:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDD670466
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 16:06:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABF0661982
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 00:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21CAC433B5;
        Wed, 30 Nov 2022 00:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669766817;
        bh=wqpaOP9IsZBH4xn9d7qF8ePQ5O6RD8RKVwSH35DW6JU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzg9LrsvWEBJN7bAuXvrptbKPXn+k3MOzdQsc03W0U2yB7xE1wLAZSqd5zWe9v11g
         utn/GeuyqrvWNjUms+nVCNonG2oPraHksmVqfZ8NN84/e+tSlKsMGUQnuv6DBY97vA
         gQslbLlamDGy8GArqCHjFZsqnZitPD4045N7sOGYgFx3W4SEFm7xSo/bFD3HJDoh8h
         q6+dbmsWzetI5tnt0af3YxNDarXv2Otove+RUvKFbw/y/+OVhq/9HLZlfM2wOsgGrF
         0SAdkPdTcz4r3We+7yIKtwFONN5R/rsnfeeCCh2qYY4Ih0gCvnJBXHClfn4K37qyaY
         s1nVYZkNp0AqA==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/6] kselftest/alsa: Report failures to set the requested sample rate as skips
Date:   Wed, 30 Nov 2022 00:06:04 +0000
Message-Id: <20221130000608.519574-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221130000608.519574-1-broonie@kernel.org>
References: <20221130000608.519574-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2201; i=broonie@kernel.org; h=from:subject; bh=wqpaOP9IsZBH4xn9d7qF8ePQ5O6RD8RKVwSH35DW6JU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjhp5sBJwm+lWb68cs/Kqx+6TVtUwnlH1Z4xrws870 u3bklPeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4aebAAKCRAk1otyXVSH0Lw2B/ 0SOPiFYC3iUaqOGezP5DUzGqUqe4Z68//nb3p1BMeDnELLkK7eIj12TGHaewlYHfKGkXUKcuDMHkAd UWRER1A+GZfGVwQidHIDV1ZhWjL0KC/YrpcKxsH+/ODtUy1KOzw4IazeZNHhNl0APY1PJvYmk/Epmv 3JjUmZR7RsXJCEmo8GmmTBGxGutXsocHwAIou3UWzvgW8EuW3kDkDqAxaZvlrbYwJvE+awd9OlrBYA HQReQvrOnS5leguzyjYi2TUbcj3PSaFPCAQb2syWOcXmDqNq3Zq4LCxERxYZbDlD3duYx35BXh3qk0 OHO3Zcf3Dqin5dKUUWXYQYo6PRWcFW
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

If constraint selection gives us a sample rate other than the one that we
asked for that isn't a failure, that is the device implementing sample
rate constraints and advertising that it can't support whatever we asked
for. Report such cases as a test skip rather than failure so we don't have
false positives.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index b8923e494e50..6a9e4af828ee 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -317,6 +317,7 @@ static void test_pcm_time1(struct pcm_data *data,
 	bool pass = false, automatic = true;
 	snd_pcm_hw_params_t *hw_params;
 	snd_pcm_sw_params_t *sw_params;
+	bool skip = false;
 
 	snd_pcm_hw_params_alloca(&hw_params);
 	snd_pcm_sw_params_alloca(&sw_params);
@@ -391,7 +392,8 @@ static void test_pcm_time1(struct pcm_data *data,
 		goto __close;
 	}
 	if (rrate != rate) {
-		snprintf(msg, sizeof(msg), "rate mismatch %ld != %ld", rate, rrate);
+		snprintf(msg, sizeof(msg), "rate unsupported %ld != %ld", rate, rrate);
+		skip = true;
 		goto __close;
 	}
 	rperiod_size = period_size;
@@ -487,11 +489,20 @@ static void test_pcm_time1(struct pcm_data *data,
 	msg[0] = '\0';
 	pass = true;
 __close:
-	ksft_test_result(pass, "%s.%d.%d.%d.%s%s%s\n",
-			 test->cfg_prefix,
-			 data->card, data->device, data->subdevice,
-			 snd_pcm_stream_name(data->stream),
-			 msg[0] ? " " : "", msg);
+	if (!skip) {
+		ksft_test_result(pass, "%s.%d.%d.%d.%s%s%s\n",
+				 test->cfg_prefix,
+				 data->card, data->device, data->subdevice,
+				 snd_pcm_stream_name(data->stream),
+				 msg[0] ? " " : "", msg);
+	} else {
+		ksft_test_result_skip("%s.%d.%d.%d.%s%s%s\n",
+				      test->cfg_prefix,
+				      data->card, data->device,
+				      data->subdevice,
+				      snd_pcm_stream_name(data->stream),
+				      msg[0] ? " " : "", msg);
+	}
 	free(samples);
 	if (handle)
 		snd_pcm_close(handle);
-- 
2.30.2

