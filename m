Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B7B63FD04
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 01:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiLBA1T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 19:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiLBA01 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 19:26:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2950BAC
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 16:21:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7891B82042
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 00:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0804BC433B5;
        Fri,  2 Dec 2022 00:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669940486;
        bh=VjJcFh/HJTKeoERtrWYk8wR4SBvW6e/w/fSZ2fzzO9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nFDtMqMFuOT3pNWTE4JvGeBVXVKn48m4FOrEzhsuZa8Kim1ENlVn0QsKGgRCGyMKr
         mVZxffkt6nEBZifglTyMoOcWpx86xLCyWCx+0oMptvAGuO0aZnoXHiiopEL2HRZfW2
         eNsKvffHLD7pTZZaw7z28EkoFa8DzpwX3TsF5ONi/i6j5mAwxsTgn0K92wMSN8wMMA
         An+mVsA+xgegCLPUPStnUrg87tpXGV7En05yWmPcAl/FJH6n+NEZmJ0Om8VX0yh4nj
         FNHN82dvH/vag6nt681oNP/vqx5miT/KokFEcaOmQEVXDuYezs9x3hupyteiBlj7II
         9qCSjYxbm/1ww==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 3/7] kselftest/alsa: pcm - Always run the default set of tests
Date:   Fri,  2 Dec 2022 00:17:45 +0000
Message-Id: <20221202001749.3321187-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202001749.3321187-1-broonie@kernel.org>
References: <20221202001749.3321187-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5457; i=broonie@kernel.org; h=from:subject; bh=VjJcFh/HJTKeoERtrWYk8wR4SBvW6e/w/fSZ2fzzO9g=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjiUQomFHuneC4OAE/C8y+DXPHDcAVGpoOXSRz4+hL Omb4IEmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4lEKAAKCRAk1otyXVSH0OQgB/ wPNvQK8q2z/XmM++1/kWVLS5UiodZim0MuxTbIBQJfrBPPTXi9X6MGkx22FJ70yPUFln8D3zS1JR0Y H2AgBhzzOHQfXAQ4yPZXf3LqYztBVVkOgjkgQnSkbBsD2LH+61F3GqzSreYFnh3Jrj2f+NT7q4jtmK sUGa0Jj3mWJoDZdM9nLmmFM5UxULx/Ud2P9TjQr/R2QFawu69QXZtZTSQhyqCyanh81BJiu3e6FqFB XpxWmOIUw56tUwo0dXmpsqHojMcWMbMG56aDmA7/pJTb5I3HQaccfxcgW5YzvjBqp/ttBbZqTIJNAQ o0dZdttXK9Psd3LSmPq47BSXS1WiRA
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

Rather than allowing the system specific tests to replace the default set
of tests instead run them in addition to the standard set of tests. In
order to avoid name collisions in the reported tests we add an additional
test class element to the reported tests. Doing this means we always get a
consistent baseline of coverage no matter what card we run on but retain
the ability to specify specific coverage for a given system.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.c | 83 +++++++++++++++++--------
 1 file changed, 58 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index e973b03ae1fd..afc616ddc820 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -36,6 +36,11 @@ struct pcm_data *pcm_list = NULL;
 int num_missing = 0;
 struct pcm_data *pcm_missing = NULL;
 
+enum test_class {
+	TEST_CLASS_DEFAULT,
+	TEST_CLASS_SYSTEM,
+};
+
 void timestamp_now(timestamp_t *tstamp)
 {
 	if (clock_gettime(CLOCK_MONOTONIC_RAW, tstamp))
@@ -217,7 +222,8 @@ static void find_pcms(void)
 	snd_config_delete(config);
 }
 
-static void test_pcm_time(struct pcm_data *data, const char *test_name, snd_config_t *pcm_cfg)
+static void test_pcm_time(struct pcm_data *data, enum test_class class,
+			  const char *test_name, snd_config_t *pcm_cfg)
 {
 	char name[64], key[128], msg[256];
 	const char *cs;
@@ -236,6 +242,19 @@ static void test_pcm_time(struct pcm_data *data, const char *test_name, snd_conf
 	bool pass = false;
 	snd_pcm_hw_params_t *hw_params;
 	snd_pcm_sw_params_t *sw_params;
+	const char *test_class_name;
+
+	switch (class) {
+	case TEST_CLASS_DEFAULT:
+		test_class_name = "default";
+		break;
+	case TEST_CLASS_SYSTEM:
+		test_class_name = "system";
+		break;
+	default:
+		ksft_exit_fail_msg("Unknown test class %d\n", class);
+		break;
+	}
 
 	snd_pcm_hw_params_alloca(&hw_params);
 	snd_pcm_sw_params_alloca(&sw_params);
@@ -366,8 +385,8 @@ static void test_pcm_time(struct pcm_data *data, const char *test_name, snd_conf
 		goto __close;
 	}
 
-	ksft_print_msg("%s.%d.%d.%d.%s hw_params.%s.%s.%ld.%ld.%ld.%ld sw_params.%ld\n",
-			 test_name,
+	ksft_print_msg("%s.%s.%d.%d.%d.%s hw_params.%s.%s.%ld.%ld.%ld.%ld sw_params.%ld\n",
+		         test_class_name, test_name,
 			 data->card, data->device, data->subdevice,
 			 snd_pcm_stream_name(data->stream),
 			 snd_pcm_access_name(access),
@@ -415,8 +434,9 @@ static void test_pcm_time(struct pcm_data *data, const char *test_name, snd_conf
 	msg[0] = '\0';
 	pass = true;
 __close:
-	ksft_test_result(pass, "%s.%d.%d.%d.%s%s%s\n",
-			 test_name,
+
+	ksft_test_result(pass, "%s.%s.%d.%d.%d.%s%s%s\n",
+			 test_class_name, test_name,
 			 data->card, data->device, data->subdevice,
 			 snd_pcm_stream_name(data->stream),
 			 msg[0] ? " " : "", msg);
@@ -425,13 +445,37 @@ static void test_pcm_time(struct pcm_data *data, const char *test_name, snd_conf
 		snd_pcm_close(handle);
 }
 
+void run_time_tests(struct pcm_data *pcm, enum test_class class,
+		    snd_config_t *cfg)
+{
+	const char *test_name, *test_type;
+	snd_config_t *pcm_cfg;
+	snd_config_iterator_t i, next;
+
+	if (!cfg)
+		return;
+
+	cfg = conf_get_subtree(cfg, "test", NULL);
+	if (cfg == NULL)
+		return;
+
+	snd_config_for_each(i, next, cfg) {
+		pcm_cfg = snd_config_iterator_entry(i);
+		if (snd_config_get_id(pcm_cfg, &test_name) < 0)
+			ksft_exit_fail_msg("snd_config_get_id\n");
+		test_type = conf_get_string(pcm_cfg, "type", NULL, "time");
+		if (strcmp(test_type, "time") == 0)
+			test_pcm_time(pcm, class, test_name, pcm_cfg);
+		else
+			ksft_exit_fail_msg("unknown test type '%s'\n", test_type);
+	}
+}
+
 int main(void)
 {
 	struct pcm_data *pcm;
 	snd_config_t *global_config, *default_pcm_config, *cfg, *pcm_cfg;
-	snd_config_iterator_t i, next;
-	int num_pcm_tests = 0, num_tests;
-	const char *test_name, *test_type;
+	int num_pcm_tests = 0, num_tests, num_std_pcm_tests;
 
 	ksft_print_header();
 
@@ -444,10 +488,13 @@ int main(void)
 
 	find_pcms();
 
+	num_std_pcm_tests = conf_get_count(default_pcm_config, "test", NULL);
+
 	for (pcm = pcm_list; pcm != NULL; pcm = pcm->next) {
+		num_pcm_tests += num_std_pcm_tests;
 		cfg = pcm->pcm_config;
 		if (cfg == NULL)
-			cfg = default_pcm_config;
+			continue;
 		num_tests = conf_get_count(cfg, "test", NULL);
 		if (num_tests > 0)
 			num_pcm_tests += num_tests;
@@ -462,22 +509,8 @@ int main(void)
 	}
 
 	for (pcm = pcm_list; pcm != NULL; pcm = pcm->next) {
-		cfg = pcm->pcm_config;
-		if (cfg == NULL)
-			cfg = default_pcm_config;
-		cfg = conf_get_subtree(cfg, "test", NULL);
-		if (cfg == NULL)
-			continue;
-		snd_config_for_each(i, next, cfg) {
-			pcm_cfg = snd_config_iterator_entry(i);
-			if (snd_config_get_id(pcm_cfg, &test_name) < 0)
-				ksft_exit_fail_msg("snd_config_get_id\n");
-			test_type = conf_get_string(pcm_cfg, "type", NULL, "time");
-			if (strcmp(test_type, "time") == 0)
-				test_pcm_time(pcm, test_name, pcm_cfg);
-			else
-				ksft_exit_fail_msg("unknown test type '%s'\n", test_type);
-		}
+		run_time_tests(pcm, TEST_CLASS_DEFAULT, default_pcm_config);
+		run_time_tests(pcm, TEST_CLASS_SYSTEM, pcm->pcm_config);
 	}
 
 	snd_config_delete(global_config);
-- 
2.30.2

