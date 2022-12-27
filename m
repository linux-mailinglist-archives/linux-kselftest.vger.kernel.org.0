Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D44656D36
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 18:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiL0RHY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 12:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiL0RHX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 12:07:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD68BD0;
        Tue, 27 Dec 2022 09:07:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B9A8611B3;
        Tue, 27 Dec 2022 17:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8D5C433F2;
        Tue, 27 Dec 2022 17:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672160841;
        bh=GT0ib72WyJtF+L2c/Gx69hmpwfVEAu1SUy6Sba1vebw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=armwAVD8T9mnAHhKri3M65L6kE3DC7P4+9S9GX2v5Uad6JYCmDmaDcfQqt/lHDlMo
         0U7u8r7JydEhiBVKgQE6MiXgfLD1NmTkBEq3pRNlJ1v4j1e42cn/RE/uzihYlDNDYW
         fX5QgJqAf1WG6iPPpJFCQAz2G/DnkgWiorsbtmAOB6H0akio09KSpUY9F4uzCC/Lt+
         Ar+z43jE31St23utVgVv8bUowLjhjWxXJcU/flt6IbGdefoayoWASJMDnvdLKKqzkR
         3hpIvKNaQLQ7zki+4Sy3wa7O8lxkhNjROWefL5F9cNN9Q6M/qJSFcT6ch18tm82gTS
         DEoruS8nSxScQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 17:06:46 +0000
Subject: [PATCH v4 1/7] kselftest/alsa: pcm - Drop recent coverage improvement changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-alsa-pcm-test-hacks-v4-1-5a152e65b1e1@kernel.org>
References: <20221208-alsa-pcm-test-hacks-v4-0-5a152e65b1e1@kernel.org>
In-Reply-To: <20221208-alsa-pcm-test-hacks-v4-0-5a152e65b1e1@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=9518; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GT0ib72WyJtF+L2c/Gx69hmpwfVEAu1SUy6Sba1vebw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqyZAbqPyo20g/crzqVyXwv4m9w1ElysCONNEpBgI
 bgiBg2CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6smQAAKCRAk1otyXVSH0C7rB/
 43TCyZavNZeBUCukQZ0aKXxemyrt9wIDijRAIMMLKWAPw+PmZCLnKwER/fYBIjqRoO/L27Xj2ynJQb
 5Qh1u2jkqIDgj6597uylgyy0O9NRncJYUBCWm2C6Fvia7E9ZsPeIPvMsvgZsvmyESA30ccsAmp7Aio
 t6XC95XqZhUBzFL0DmQ4XF4MnNy8J08g+GlJ04P9YJVrU7pC+MfAqLliwXZ5tYZzgrc5pEgQAK6+Qw
 YLNyhN+/XwEjtnahY9w+3ohRMQl0dZX1sEGEYZlJcBr0szzUWcyfX74qkzfphzStoRcHp7vdJCmmin
 N/xb5kdCTsDRercTKaCBtauObfEh6w
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

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf       | 35 ++++-----
 tools/testing/selftests/alsa/pcm-test.c            | 88 +++++++------------
---
 .../alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf       | 35 ++++-----
 tools/testing/selftests/alsa/pcm-test.c            | 88 +++++++---------------
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
