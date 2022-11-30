Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A704463CC29
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 01:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiK3AHM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 19:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiK3AG5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 19:06:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720AE7045B
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 16:06:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5AF06188A
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 00:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BC7C43470;
        Wed, 30 Nov 2022 00:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669766815;
        bh=441OKhiJgVCddtFNAx9Epxfx+yKvkKD9MnnbzjxJBFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sww73/2lJHu91+zcY3fgythvMBaW0QXhLKwVXQyD3QLrzAC0xhJSOfH6wkxxU/+s/
         ktT8B2zlPWPMpnSEhC+GGqHSysk3yq0eBNC4IDXE21Q+j+ohEf5dOYZMsH59JXmsnl
         8Y9bOa+J3Q+vYrmdJpi7sdcVJGQjF+3Cus6lAEQFCRSaRzsj8RLwTIG7gIbv/jj8gx
         LBKAfjlfrawnSf8vF5Ehu3VA0P2AljlDEl1AwZlv8nfmXtIDDPBQlDChDQHVymBf3m
         wDirIjzhpdPyikTGvTWcgbPWHT0M0OMGZq5QAVT15+Jz9do0XSijzuIt6D2ke4nFe1
         flHLOcpgO9s2Q==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/6] kselftest/alsa: Refactor pcm-test to list the tests to run in a struct
Date:   Wed, 30 Nov 2022 00:06:03 +0000
Message-Id: <20221130000608.519574-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221130000608.519574-1-broonie@kernel.org>
References: <20221130000608.519574-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5316; i=broonie@kernel.org; h=from:subject; bh=441OKhiJgVCddtFNAx9Epxfx+yKvkKD9MnnbzjxJBFo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjhp5rGwhQdFbiniftIokUorQjjrV1ranWwhmL5ru6 nZQqrk+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4aeawAKCRAk1otyXVSH0LifB/ oCrFFsdd9oQg3cpDBQszgz4t/u2B7OZU1yvoKwDkRAc24mjA9HMfRMZWmhbpN5P+yYsiUgny/b1GfI n1rWjB6ACmfetUFagcQDQRujtdfa7id09aRq+6mt5DpoJrysXLkd3fQhGo+aY6T1aCfd9IC1b9AOVC WxOCViGfbUmDtXXwhad3fovW6VWtBOTwWzdB9lUa/oP5iJZXCsXDDfXm7rGBNpustrTxl5+JcLGgak eehbj/d1fiOHnfM7nGwmHioLH9S45bQiMev8pWqa2YFcEV3mkKnE/HympA1lIn+o3Azsedf+3Euja3 MeD1xX6Rm0DhkLUImB2xubdt5WPjfu
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

In order to help make the list of tests a bit easier to maintain refactor
things so we pass the tests around as a struct with the parameters in,
enabling us to add new tests by adding to a table with comments saying
what each of the number are. We could also use named initializers if we get
more parameters.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.c | 53 +++++++++++++++----------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index 2814d8f74f82..b8923e494e50 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -57,6 +57,15 @@ struct pcm_data *pcm_list = NULL;
 int num_missing = 0;
 struct pcm_data *pcm_missing = NULL;
 
+struct time_test_def {
+	const char *cfg_prefix;
+	const char *format;
+	long rate;
+	long channels;
+	long period_size;
+	long buffer_size;
+};
+
 void timestamp_now(timestamp_t *tstamp)
 {
 	if (clock_gettime(CLOCK_MONOTONIC_RAW, tstamp))
@@ -290,9 +299,7 @@ static void find_pcms(void)
 }
 
 static void test_pcm_time1(struct pcm_data *data,
-			   const char *cfg_prefix, const char *sformat,
-			   long srate, long schannels,
-			   long speriod_size, long sbuffer_size)
+			   const struct time_test_def *test)
 {
 	char name[64], key[128], msg[256];
 	const char *cs;
@@ -314,20 +321,20 @@ static void test_pcm_time1(struct pcm_data *data,
 	snd_pcm_hw_params_alloca(&hw_params);
 	snd_pcm_sw_params_alloca(&sw_params);
 
-	cs = conf_get_string(data->pcm_config, cfg_prefix, "format", sformat);
+	cs = conf_get_string(data->pcm_config, test->cfg_prefix, "format", test->format);
 	format = snd_pcm_format_value(cs);
 	if (format == SND_PCM_FORMAT_UNKNOWN)
 		ksft_exit_fail_msg("Wrong format '%s'\n", cs);
-	rate = conf_get_long(data->pcm_config, cfg_prefix, "rate", srate);
-	channels = conf_get_long(data->pcm_config, cfg_prefix, "channels", schannels);
-	period_size = conf_get_long(data->pcm_config, cfg_prefix, "period_size", speriod_size);
-	buffer_size = conf_get_long(data->pcm_config, cfg_prefix, "buffer_size", sbuffer_size);
+	rate = conf_get_long(data->pcm_config, test->cfg_prefix, "rate", test->rate);
+	channels = conf_get_long(data->pcm_config, test->cfg_prefix, "channels", test->channels);
+	period_size = conf_get_long(data->pcm_config, test->cfg_prefix, "period_size", test->period_size);
+	buffer_size = conf_get_long(data->pcm_config, test->cfg_prefix, "buffer_size", test->buffer_size);
 
-	automatic = strcmp(sformat, snd_pcm_format_name(format)) == 0 &&
-			srate == rate &&
-			schannels == channels &&
-			speriod_size == period_size &&
-			sbuffer_size == buffer_size;
+	automatic = strcmp(test->format, snd_pcm_format_name(format)) == 0 &&
+			test->rate == rate &&
+			test->channels == channels &&
+			test->period_size == period_size &&
+			test->buffer_size == buffer_size;
 
 	samples = malloc((rate * channels * snd_pcm_format_physical_width(format)) / 8);
 	if (!samples)
@@ -363,7 +370,7 @@ static void test_pcm_time1(struct pcm_data *data,
 		if (automatic && format == SND_PCM_FORMAT_S16_LE) {
 			format = SND_PCM_FORMAT_S32_LE;
 			ksft_print_msg("%s.%d.%d.%d.%s.%s format S16_LE -> S32_LE\n",
-					 cfg_prefix,
+					 test->cfg_prefix,
 					 data->card, data->device, data->subdevice,
 					 snd_pcm_stream_name(data->stream),
 					 snd_pcm_access_name(access));
@@ -432,7 +439,7 @@ static void test_pcm_time1(struct pcm_data *data,
 	}
 
 	ksft_print_msg("%s.%d.%d.%d.%s hw_params.%s.%s.%ld.%ld.%ld.%ld sw_params.%ld\n",
-			 cfg_prefix,
+			 test->cfg_prefix,
 			 data->card, data->device, data->subdevice,
 			 snd_pcm_stream_name(data->stream),
 			 snd_pcm_access_name(access),
@@ -481,7 +488,7 @@ static void test_pcm_time1(struct pcm_data *data,
 	pass = true;
 __close:
 	ksft_test_result(pass, "%s.%d.%d.%d.%s%s%s\n",
-			 cfg_prefix,
+			 test->cfg_prefix,
 			 data->card, data->device, data->subdevice,
 			 snd_pcm_stream_name(data->stream),
 			 msg[0] ? " " : "", msg);
@@ -490,11 +497,16 @@ static void test_pcm_time1(struct pcm_data *data,
 		snd_pcm_close(handle);
 }
 
-#define TESTS_PER_PCM 2
+static const struct time_test_def time_tests[] = {
+	/* name          format     rate   chan  period  buffer */
+	{ "test.time1",  "S16_LE",  48000, 2,      512,    4096 },
+	{ "test.time2",  "S16_LE",  48000, 2,    24000,  192000 },
+};
 
 int main(void)
 {
 	struct pcm_data *pcm;
+	int i;
 
 	ksft_print_header();
 
@@ -502,7 +514,7 @@ int main(void)
 
 	find_pcms();
 
-	ksft_set_plan(num_missing + num_pcms * TESTS_PER_PCM);
+	ksft_set_plan(num_missing + num_pcms * ARRAY_SIZE(time_tests));
 
 	for (pcm = pcm_missing; pcm != NULL; pcm = pcm->next) {
 		ksft_test_result(false, "test.missing.%d.%d.%d.%s\n",
@@ -511,8 +523,9 @@ int main(void)
 	}
 
 	for (pcm = pcm_list; pcm != NULL; pcm = pcm->next) {
-		test_pcm_time1(pcm, "test.time1", "S16_LE", 48000, 2, 512, 4096);
-		test_pcm_time1(pcm, "test.time2", "S16_LE", 48000, 2, 24000, 192000);
+		for (i = 0; i < ARRAY_SIZE(time_tests); i++) {
+			test_pcm_time1(pcm, &time_tests[i]);
+		}
 	}
 
 	conf_free();
-- 
2.30.2

