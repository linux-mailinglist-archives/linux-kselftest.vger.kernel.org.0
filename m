Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A8163F5F7
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 18:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLARLB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 12:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLARLA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 12:11:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFF2A897B
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 09:10:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49FA662095
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 17:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD28C433D6;
        Thu,  1 Dec 2022 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669914658;
        bh=pnwhTaL4cklkLrb4nD4efWonXmmY0uhDdK7dG34JuoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HuyGnrfESgnWeThOwodXT6+gB97jtrTzxfMgqTyGAUL+8f5hUa7y5ksGNZRfNzn9x
         o682f0c8S6FauPCkdNNAeye3HYwI8kLzZId/sfOpVTydTSxbCAHlveZBbvfC7rYUv5
         IwzWkD8hrzrgayzb/6L7I8AvZKB6wb4UYSubRS+UUdE9LQtITmMiTUYvXOy+79ZZsl
         rzeYPs7niBLtAa+kPqi4+smfIeVIdy0erKwWrJec/rWZxD2+6dJjPqUcyxj5exbO5X
         M7QJYp8c40tQYeh38CQoMW7Fa2XpQ72qv7SJt0mDjDmbr5bcj+Iez63wlBMWMHysRJ
         kCv4ZoFxIDjXw==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/6] kselftest/alsa: Report failures to set the requested sample rate as skips
Date:   Thu,  1 Dec 2022 17:07:41 +0000
Message-Id: <20221201170745.1111236-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201170745.1111236-1-broonie@kernel.org>
References: <20221201170745.1111236-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2201; i=broonie@kernel.org; h=from:subject; bh=pnwhTaL4cklkLrb4nD4efWonXmmY0uhDdK7dG34JuoY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjiN9d+nbh+A0A7qkli2I8bk2WGKpIqwgz2FKcpvFJ iTWyxCWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4jfXQAKCRAk1otyXVSH0EBiB/ 0ZMRMnkhJIG249GtRBPM1Z+78KAI8+3h6ezqBLuHtuOfrtRBPMuZ9E2+sLUJ92jigMHNx2ykJqZBef bqOZkGgx9mxPR3hO0iYW2chNmnp5zgiSLtMRChhCocrEVsEYzeCvRFwB5Q1axb6Zz9l01PWv/nGhhd raik7W/e+BcfnA/luI28EZ0xaoxK41+PNtrfRvrA/t4ySDKeicUxnpY3JdvGDo/LS/yq1aOZP6xRvZ dihe8tZdtQyyQ1Omz9jXEw25NNYiHoEdEhWD31wDM0e2tTSHUKTcCk5VNDvvK1CI8kBeaJ4uZNHCLS B1eDLXgni833r2EZPg2WbHWk05DqWZ
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
index dc36f4099954..edb820fe2ee6 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -247,6 +247,7 @@ static void test_pcm_time1(struct pcm_data *data,
 	bool pass = false, automatic = true;
 	snd_pcm_hw_params_t *hw_params;
 	snd_pcm_sw_params_t *sw_params;
+	bool skip = false;
 
 	snd_pcm_hw_params_alloca(&hw_params);
 	snd_pcm_sw_params_alloca(&sw_params);
@@ -321,7 +322,8 @@ static void test_pcm_time1(struct pcm_data *data,
 		goto __close;
 	}
 	if (rrate != rate) {
-		snprintf(msg, sizeof(msg), "rate mismatch %ld != %ld", rate, rrate);
+		snprintf(msg, sizeof(msg), "rate unsupported %ld != %ld", rate, rrate);
+		skip = true;
 		goto __close;
 	}
 	rperiod_size = period_size;
@@ -417,11 +419,20 @@ static void test_pcm_time1(struct pcm_data *data,
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

