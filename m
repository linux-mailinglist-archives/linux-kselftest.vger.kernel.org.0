Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5405C63FD00
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 01:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiLBA0w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 19:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiLBA0W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 19:26:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2154AF31
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 16:21:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C0CF621D2
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 00:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E36C43143;
        Fri,  2 Dec 2022 00:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669940482;
        bh=JGit28yz6CC6oZb1du0CbibcaHGYu5uCjor59093aOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ARJDOOPEPFht0dKd8mh4l9PABRNUfX2EGXtbgsGxDwBj/A0LHV/v3svHI5fX4IWoG
         fNM8B+0XgcH11n9i2VWJAzkdS/DosSU7FFiGte3XfpeMYkvn3N7TSkHB0wxzuOsATk
         F/v904NAXxfDXIlo+dd7j5egoFkD0ecpgCR4pzWK5ida6ZT06cnJlmBXAoEWkOp50F
         NPu8/T7VXZUZ80E/PCX8ZOtIo2XtTNbYLLckhTPzmQyspVf4bwPNxqHypnjkyi+997
         3DIciRsGdDq1L1ci7aXZZciWCG5sz4Cq9q+bwFLtF62Mf+6mpePexh3/8BdGmjNtPm
         ciQpenVbnU2NA==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 1/7] kselftest/alsa: pcm - Drop recent coverage improvement changes
Date:   Fri,  2 Dec 2022 00:17:43 +0000
Message-Id: <20221202001749.3321187-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202001749.3321187-1-broonie@kernel.org>
References: <20221202001749.3321187-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9304; i=broonie@kernel.org; h=from:subject; bh=JGit28yz6CC6oZb1du0CbibcaHGYu5uCjor59093aOM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjiUQmtf5o+v0gO1F4W2C/actNiHIawWOeVmexKRan MzRucvCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4lEJgAKCRAk1otyXVSH0OWwB/ 41p/7Ib6MxBnMl/4RbAfOZBfspMCfAFoHIO4PMrP2IjknBfwxAtkwzksNEiNix7bnsBEJi2zHjs3bI 0F0I90bSkHdcQYB7EiEJoQF7XxJAd+SvUP68wRx6wPs6YQsoRV13ThFyRasjEZiVirEZtD0HA9Q1pX rT8v3RZ+cxuwXOpLEANx3165DtLV5tpstIE9hcys1fwNp8Jfs2KMBbvmpBP77dolHvSShCDl3raZQQ ktPbwqJLRT93CmEbVz6slAKMTtIMtxev0RHR4c4jEQIslcJZOwUyUp8Lh8Mr1gUcbl0H/DKaJwqjsR INckvWHZfKuP+Eyxnb+5+2i3+X48JS
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

In preparation to adopting a better, more comprehensive approach to
adding the coverage that was just added using some changes from Jaroslav
which were sent at the same time the recently added improvements were
being applied drop what was applied.  This reverts:

  7d721baea138 "kselftest/alsa: Add more coverage of sample rates and channel counts"
  ee12040dd53a "kselftest/alsa: Provide more meaningful names for tests"
  ae95efd9754c "kselftest/alsa: Don't any configuration in the sample config"
  8370d9b00c92 Revert "kselftest/alsa: Report failures to set the requested channels as skips"
  f944f8b539ea "kselftest/alsa: Report failures to set the requested sample rate as skips"
  22eeb8f531c1 "kselftest/alsa: Refactor pcm-test to list the tests to run in a struct"

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf  | 35 ++++----
 tools/testing/selftests/alsa/pcm-test.c       | 88 ++++++-------------
 2 files changed, 42 insertions(+), 81 deletions(-)

diff --git a/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf b/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf
index 9eca985e0c08..0a83f35d43eb 100644
--- a/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf
+++ b/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf
@@ -39,25 +39,22 @@ card.hda {
 	#
 	pcm.0.0 {
 		PLAYBACK {
-			#
-			# Uncomment to override values for specific tests
-			#
-			#test_name1 {
-			#	access RW_INTERLEAVED
-			#	format S16_LE
-			#	rate 48000
-			#	channels 2
-			#	period_size 512
-			#	buffer_size 4096
-			#}
-			#test_name2 {
-			#	access RW_INTERLEAVED
-			#	format S16_LE
-			#	rate 48000
-			#	channels 2
-			#	period_size 24000
-			#	buffer_size 192000
-			#}
+			test.time1 {
+				access RW_INTERLEAVED	# can be omitted - default
+				format S16_LE		# can be omitted - default
+				rate 48000		# can be omitted - default
+				channels 2		# can be omitted - default
+				period_size 512
+				buffer_size 4096
+			}
+			test.time2 {
+				access RW_INTERLEAVED
+				format S16_LE
+				rate 48000
+				channels 2
+				period_size 24000
+				buffer_size 192000
+			}
 		}
 		CAPTURE {
 			# use default tests, check for the presence
diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index f293c7d81009..6e7dfc395b98 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -37,15 +37,6 @@ struct pcm_data *pcm_list = NULL;
 int num_missing = 0;
 struct pcm_data *pcm_missing = NULL;
 
-struct time_test_def {
-	const char *cfg_prefix;
-	const char *format;
-	long rate;
-	long channels;
-	long period_size;
-	long buffer_size;
-};
-
 void timestamp_now(timestamp_t *tstamp)
 {
 	if (clock_gettime(CLOCK_MONOTONIC_RAW, tstamp))
@@ -229,7 +220,9 @@ static void find_pcms(void)
 }
 
 static void test_pcm_time1(struct pcm_data *data,
-			   const struct time_test_def *test)
+			   const char *cfg_prefix, const char *sformat,
+			   long srate, long schannels,
+			   long speriod_size, long sbuffer_size)
 {
 	char name[64], key[128], msg[256];
 	const char *cs;
@@ -241,32 +234,30 @@ static void test_pcm_time1(struct pcm_data *data,
 	snd_pcm_sframes_t frames;
 	long long ms;
 	long rate, channels, period_size, buffer_size;
-	unsigned int rchannels;
 	unsigned int rrate;
 	snd_pcm_uframes_t rperiod_size, rbuffer_size, start_threshold;
 	timestamp_t tstamp;
 	bool pass = false, automatic = true;
 	snd_pcm_hw_params_t *hw_params;
 	snd_pcm_sw_params_t *sw_params;
-	bool skip = false;
 
 	snd_pcm_hw_params_alloca(&hw_params);
 	snd_pcm_sw_params_alloca(&sw_params);
 
-	cs = conf_get_string(data->pcm_config, test->cfg_prefix, "format", test->format);
+	cs = conf_get_string(data->pcm_config, cfg_prefix, "format", sformat);
 	format = snd_pcm_format_value(cs);
 	if (format == SND_PCM_FORMAT_UNKNOWN)
 		ksft_exit_fail_msg("Wrong format '%s'\n", cs);
-	rate = conf_get_long(data->pcm_config, test->cfg_prefix, "rate", test->rate);
-	channels = conf_get_long(data->pcm_config, test->cfg_prefix, "channels", test->channels);
-	period_size = conf_get_long(data->pcm_config, test->cfg_prefix, "period_size", test->period_size);
-	buffer_size = conf_get_long(data->pcm_config, test->cfg_prefix, "buffer_size", test->buffer_size);
+	rate = conf_get_long(data->pcm_config, cfg_prefix, "rate", srate);
+	channels = conf_get_long(data->pcm_config, cfg_prefix, "channels", schannels);
+	period_size = conf_get_long(data->pcm_config, cfg_prefix, "period_size", speriod_size);
+	buffer_size = conf_get_long(data->pcm_config, cfg_prefix, "buffer_size", sbuffer_size);
 
-	automatic = strcmp(test->format, snd_pcm_format_name(format)) == 0 &&
-			test->rate == rate &&
-			test->channels == channels &&
-			test->period_size == period_size &&
-			test->buffer_size == buffer_size;
+	automatic = strcmp(sformat, snd_pcm_format_name(format)) == 0 &&
+			srate == rate &&
+			schannels == channels &&
+			speriod_size == period_size &&
+			sbuffer_size == buffer_size;
 
 	samples = malloc((rate * channels * snd_pcm_format_physical_width(format)) / 8);
 	if (!samples)
@@ -302,7 +293,7 @@ static void test_pcm_time1(struct pcm_data *data,
 		if (automatic && format == SND_PCM_FORMAT_S16_LE) {
 			format = SND_PCM_FORMAT_S32_LE;
 			ksft_print_msg("%s.%d.%d.%d.%s.%s format S16_LE -> S32_LE\n",
-					 test->cfg_prefix,
+					 cfg_prefix,
 					 data->card, data->device, data->subdevice,
 					 snd_pcm_stream_name(data->stream),
 					 snd_pcm_access_name(access));
@@ -311,17 +302,11 @@ static void test_pcm_time1(struct pcm_data *data,
 					   snd_pcm_format_name(format), snd_strerror(err));
 		goto __close;
 	}
-	rchannels = channels;
-	err = snd_pcm_hw_params_set_channels_near(handle, hw_params, &rchannels);
+	err = snd_pcm_hw_params_set_channels(handle, hw_params, channels);
 	if (err < 0) {
 		snprintf(msg, sizeof(msg), "snd_pcm_hw_params_set_channels %ld: %s", channels, snd_strerror(err));
 		goto __close;
 	}
-	if (rchannels != channels) {
-		snprintf(msg, sizeof(msg), "channels unsupported %ld != %ld", channels, rchannels);
-		skip = true;
-		goto __close;
-	}
 	rrate = rate;
 	err = snd_pcm_hw_params_set_rate_near(handle, hw_params, &rrate, 0);
 	if (err < 0) {
@@ -329,8 +314,7 @@ static void test_pcm_time1(struct pcm_data *data,
 		goto __close;
 	}
 	if (rrate != rate) {
-		snprintf(msg, sizeof(msg), "rate unsupported %ld != %ld", rate, rrate);
-		skip = true;
+		snprintf(msg, sizeof(msg), "rate mismatch %ld != %ld", rate, rrate);
 		goto __close;
 	}
 	rperiod_size = period_size;
@@ -378,7 +362,7 @@ static void test_pcm_time1(struct pcm_data *data,
 	}
 
 	ksft_print_msg("%s.%d.%d.%d.%s hw_params.%s.%s.%ld.%ld.%ld.%ld sw_params.%ld\n",
-			 test->cfg_prefix,
+			 cfg_prefix,
 			 data->card, data->device, data->subdevice,
 			 snd_pcm_stream_name(data->stream),
 			 snd_pcm_access_name(access),
@@ -426,40 +410,21 @@ static void test_pcm_time1(struct pcm_data *data,
 	msg[0] = '\0';
 	pass = true;
 __close:
-	if (!skip) {
-		ksft_test_result(pass, "%s.%d.%d.%d.%s%s%s\n",
-				 test->cfg_prefix,
-				 data->card, data->device, data->subdevice,
-				 snd_pcm_stream_name(data->stream),
-				 msg[0] ? " " : "", msg);
-	} else {
-		ksft_test_result_skip("%s.%d.%d.%d.%s%s%s\n",
-				      test->cfg_prefix,
-				      data->card, data->device,
-				      data->subdevice,
-				      snd_pcm_stream_name(data->stream),
-				      msg[0] ? " " : "", msg);
-	}
+	ksft_test_result(pass, "%s.%d.%d.%d.%s%s%s\n",
+			 cfg_prefix,
+			 data->card, data->device, data->subdevice,
+			 snd_pcm_stream_name(data->stream),
+			 msg[0] ? " " : "", msg);
 	free(samples);
 	if (handle)
 		snd_pcm_close(handle);
 }
 
-static const struct time_test_def time_tests[] = {
-	/* name          format     rate   chan  period  buffer */
-	{ "8k.1.big",    "S16_LE",   8000, 2,     8000,   32000 },
-	{ "8k.2.big",    "S16_LE",   8000, 2,     8000,   32000 },
-	{ "44k1.2.big",  "S16_LE",  44100, 2,    22050,  192000 },
-	{ "48k.2.small", "S16_LE",  48000, 2,      512,    4096 },
-	{ "48k.2.big",   "S16_LE",  48000, 2,    24000,  192000 },
-	{ "48k.6.big",   "S16_LE",  48000, 6,    48000,  576000 },
-	{ "96k.2.big",   "S16_LE",  96000, 2,    48000,  192000 },
-};
+#define TESTS_PER_PCM 2
 
 int main(void)
 {
 	struct pcm_data *pcm;
-	int i;
 
 	ksft_print_header();
 
@@ -467,7 +432,7 @@ int main(void)
 
 	find_pcms();
 
-	ksft_set_plan(num_missing + num_pcms * ARRAY_SIZE(time_tests));
+	ksft_set_plan(num_missing + num_pcms * TESTS_PER_PCM);
 
 	for (pcm = pcm_missing; pcm != NULL; pcm = pcm->next) {
 		ksft_test_result(false, "test.missing.%d.%d.%d.%s\n",
@@ -476,9 +441,8 @@ int main(void)
 	}
 
 	for (pcm = pcm_list; pcm != NULL; pcm = pcm->next) {
-		for (i = 0; i < ARRAY_SIZE(time_tests); i++) {
-			test_pcm_time1(pcm, &time_tests[i]);
-		}
+		test_pcm_time1(pcm, "test.time1", "S16_LE", 48000, 2, 512, 4096);
+		test_pcm_time1(pcm, "test.time2", "S16_LE", 48000, 2, 24000, 192000);
 	}
 
 	conf_free();
-- 
2.30.2

