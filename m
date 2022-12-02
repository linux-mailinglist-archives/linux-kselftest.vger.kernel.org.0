Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FFD63FD01
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 01:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiLBA0x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 19:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiLBA0W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 19:26:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6E7391D2
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 16:21:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEE01B8206B
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 00:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081CDC433D7;
        Fri,  2 Dec 2022 00:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669940484;
        bh=g2bkD9YybNj5zNsXnfABUyKEqPyOz8E9uybTHnDResM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nn0xo/iCrSQXbI9gJ0J6WGIDAMqohoCsx4hgE18vXLIOt33BhWBkmOjQNruFguL8M
         GI8VYj6opQ7VqYa5jN1zbsuFl6qQBb+5lyNwJ62ir4gmTSjwkQc3Zqxne2F6KlINFJ
         DgR7VojWg6ncfEO9tn//UaGd6Hp2Y7dLo7J1HxlECMvm6cdiq16OoJN9UncukoV/Ud
         B9aFM2BDyBj7x0SKV9tZALPgGpld29DNnkwHA0sePzUKKQU89Uhw6zSC8S8HPKmJMt
         WD9eDYTzotQrb+8htH9Fus1jshb1nb1GZFeorHb9PHooL9cF2SYS09FNKccPO/xPyT
         9DSRR3UjvHRXQ==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 2/7] kselftest/alsa: pcm - move more configuration to configuration files
Date:   Fri,  2 Dec 2022 00:17:44 +0000
Message-Id: <20221202001749.3321187-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202001749.3321187-1-broonie@kernel.org>
References: <20221202001749.3321187-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12611; i=broonie@kernel.org; h=from:subject; bh=TXdjz7Mb1AMDWf05+sWmuwu8cnSWjWNo88B5FHMTbBQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjiUQncnT/M7zVyPxmfpw0/Xj7dIvi0xuPJOFFtiQZ ok0V13GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4lEJwAKCRAk1otyXVSH0H/tB/ 4l2HIJbF21P1YZydKB3oBWjks+R7uTxZ5AKebmuMvkw5zxQHqIptzaWnxV+coCFa1sUonp91AZCOLL vlkl/z+P75PdzKWY5fpsrbZfO4f1oCZHcLRWeP+Fw5ker3vvRgJpK0CdbTHGYOqlUugTEVhC8hgGJU KJEBYXtBsiVtIpnHbYuqqBQ5KMc/In2QnBwo9rWetmkJ0sq+ghMr1+8myUzw3mtedgPdFrt5/LvAbs vy59SEv3tr5WtQSH89rSuEmQYdMoskZhYh5Q3ZesTz9eSmDWNV1mfwuLHSaGyxOoAod4pSzTVqrhG0 gUPI+9DiT88P2hvtIWGqLtY8+y6ZfX
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

From: Jaroslav Kysela <perex@perex.cz>

Obtain all test parameters from the configuration files. The defaults
are defined in the pcm-test.conf file. The test count and parameters
may be variable per specific hardware.

Also, handle alt_formats field now (with the fixes in the format loop).
It replaces the original "automatic" logic which is not so universal.

The code may be further extended to skip various tests based
on the configuration hints, if the exact PCM hardware parameters
are not available for the given hardware.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/Makefile         |   2 +-
 tools/testing/selftests/alsa/alsa-local.h     |   3 +
 tools/testing/selftests/alsa/conf.c           |  26 ++++-
 .../alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf  |   8 ++
 tools/testing/selftests/alsa/pcm-test.c       | 102 ++++++++++++------
 tools/testing/selftests/alsa/pcm-test.conf    |  16 +++
 6 files changed, 121 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/alsa/pcm-test.conf

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index a8c0383878d3..77fba3e498cc 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -14,7 +14,7 @@ TEST_GEN_PROGS := mixer-test pcm-test
 
 TEST_GEN_PROGS_EXTENDED := libatest.so
 
-TEST_FILES := conf.d
+TEST_FILES := conf.d pcm-test.conf
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/alsa/alsa-local.h b/tools/testing/selftests/alsa/alsa-local.h
index 65f197ea9773..de030dc23bd1 100644
--- a/tools/testing/selftests/alsa/alsa-local.h
+++ b/tools/testing/selftests/alsa/alsa-local.h
@@ -12,6 +12,7 @@
 
 snd_config_t *get_alsalib_config(void);
 
+snd_config_t *conf_load_from_file(const char *filename);
 void conf_load(void);
 void conf_free(void);
 snd_config_t *conf_by_card(int card);
@@ -20,5 +21,7 @@ int conf_get_count(snd_config_t *root, const char *key1, const char *key2);
 const char *conf_get_string(snd_config_t *root, const char *key1, const char *key2, const char *def);
 long conf_get_long(snd_config_t *root, const char *key1, const char *key2, long def);
 int conf_get_bool(snd_config_t *root, const char *key1, const char *key2, int def);
+void conf_get_string_array(snd_config_t *root, const char *key1, const char *key2,
+			   const char **array, int array_size, const char *def);
 
 #endif /* __ALSA_LOCAL_H */
diff --git a/tools/testing/selftests/alsa/conf.c b/tools/testing/selftests/alsa/conf.c
index c7ffc8f04195..d7aafe5a1993 100644
--- a/tools/testing/selftests/alsa/conf.c
+++ b/tools/testing/selftests/alsa/conf.c
@@ -125,7 +125,7 @@ static int dump_config_tree(snd_config_t *top)
 	snd_output_close(out);
 }
 
-static snd_config_t *load(const char *filename)
+snd_config_t *conf_load_from_file(const char *filename)
 {
 	snd_config_t *dst;
 	snd_input_t *input;
@@ -235,7 +235,7 @@ static bool test_filename1(int card, const char *filename, const char *sysfs_car
 	snd_config_t *config, *sysfs_config, *card_config, *sysfs_card_config, *node;
 	snd_config_iterator_t i, next;
 
-	config = load(filename);
+	config = conf_load_from_file(filename);
 	if (snd_config_search(config, "sysfs", &sysfs_config) ||
 	    snd_config_get_type(sysfs_config) != SND_CONFIG_TYPE_COMPOUND)
 		ksft_exit_fail_msg("Missing global sysfs block in filename %s\n", filename);
@@ -446,3 +446,25 @@ int conf_get_bool(snd_config_t *root, const char *key1, const char *key2, int de
 		ksft_exit_fail_msg("key '%s'.'%s' is not an bool\n", key1, key2);
 	return !!ret;
 }
+
+void conf_get_string_array(snd_config_t *root, const char *key1, const char *key2,
+			   const char **array, int array_size, const char *def)
+{
+	snd_config_t *cfg;
+	char buf[16];
+	int ret, index;
+
+	ret = conf_get_by_keys(root, key1, key2, &cfg);
+	if (ret == -ENOENT)
+		cfg = NULL;
+	else if (ret < 0)
+		ksft_exit_fail_msg("key '%s'.'%s' search error: %s\n", key1, key2, snd_strerror(ret));
+	for (index = 0; index < array_size; index++) {
+		if (cfg == NULL) {
+			array[index] = def;
+		} else {
+			sprintf(buf, "%i", index);
+			array[index] = conf_get_string(cfg, buf, NULL, def);
+		}
+	}
+}
diff --git a/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf b/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf
index 0a83f35d43eb..5b40a916295d 100644
--- a/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf
+++ b/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf
@@ -55,6 +55,14 @@ card.hda {
 				period_size 24000
 				buffer_size 192000
 			}
+			test.time3 {
+				access RW_INTERLEAVED
+				format S16_LE
+				rate 44100
+				channels 2
+				period_size 24000
+				buffer_size 192000
+			}
 		}
 		CAPTURE {
 			# use default tests, check for the presence
diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index 6e7dfc395b98..e973b03ae1fd 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -31,7 +31,6 @@ struct pcm_data {
 	struct pcm_data *next;
 };
 
-int num_pcms = 0;
 struct pcm_data *pcm_list = NULL;
 
 int num_missing = 0;
@@ -200,7 +199,6 @@ static void find_pcms(void)
 					pcm_data->pcm_config = conf_get_subtree(card_config, key, NULL);
 					pcm_data->next = pcm_list;
 					pcm_list = pcm_data;
-					num_pcms++;
 				}
 			}
 		}
@@ -219,17 +217,15 @@ static void find_pcms(void)
 	snd_config_delete(config);
 }
 
-static void test_pcm_time1(struct pcm_data *data,
-			   const char *cfg_prefix, const char *sformat,
-			   long srate, long schannels,
-			   long speriod_size, long sbuffer_size)
+static void test_pcm_time(struct pcm_data *data, const char *test_name, snd_config_t *pcm_cfg)
 {
 	char name[64], key[128], msg[256];
 	const char *cs;
 	int i, err;
 	snd_pcm_t *handle = NULL;
 	snd_pcm_access_t access = SND_PCM_ACCESS_RW_INTERLEAVED;
-	snd_pcm_format_t format;
+	snd_pcm_format_t format, old_format;
+	const char *alt_formats[8];
 	unsigned char *samples = NULL;
 	snd_pcm_sframes_t frames;
 	long long ms;
@@ -237,27 +233,23 @@ static void test_pcm_time1(struct pcm_data *data,
 	unsigned int rrate;
 	snd_pcm_uframes_t rperiod_size, rbuffer_size, start_threshold;
 	timestamp_t tstamp;
-	bool pass = false, automatic = true;
+	bool pass = false;
 	snd_pcm_hw_params_t *hw_params;
 	snd_pcm_sw_params_t *sw_params;
 
 	snd_pcm_hw_params_alloca(&hw_params);
 	snd_pcm_sw_params_alloca(&sw_params);
 
-	cs = conf_get_string(data->pcm_config, cfg_prefix, "format", sformat);
+	cs = conf_get_string(pcm_cfg, "format", NULL, "S16_LE");
 	format = snd_pcm_format_value(cs);
 	if (format == SND_PCM_FORMAT_UNKNOWN)
 		ksft_exit_fail_msg("Wrong format '%s'\n", cs);
-	rate = conf_get_long(data->pcm_config, cfg_prefix, "rate", srate);
-	channels = conf_get_long(data->pcm_config, cfg_prefix, "channels", schannels);
-	period_size = conf_get_long(data->pcm_config, cfg_prefix, "period_size", speriod_size);
-	buffer_size = conf_get_long(data->pcm_config, cfg_prefix, "buffer_size", sbuffer_size);
-
-	automatic = strcmp(sformat, snd_pcm_format_name(format)) == 0 &&
-			srate == rate &&
-			schannels == channels &&
-			speriod_size == period_size &&
-			sbuffer_size == buffer_size;
+	conf_get_string_array(pcm_cfg, "alt_formats", NULL,
+				alt_formats, ARRAY_SIZE(alt_formats), NULL);
+	rate = conf_get_long(pcm_cfg, "rate", NULL, 48000);
+	channels = conf_get_long(pcm_cfg, "channels", NULL, 2);
+	period_size = conf_get_long(pcm_cfg, "period_size", NULL, 4096);
+	buffer_size = conf_get_long(pcm_cfg, "buffer_size", NULL, 16384);
 
 	samples = malloc((rate * channels * snd_pcm_format_physical_width(format)) / 8);
 	if (!samples)
@@ -287,16 +279,29 @@ static void test_pcm_time1(struct pcm_data *data,
 					   snd_pcm_access_name(access), snd_strerror(err));
 		goto __close;
 	}
+	i = -1;
 __format:
 	err = snd_pcm_hw_params_set_format(handle, hw_params, format);
 	if (err < 0) {
-		if (automatic && format == SND_PCM_FORMAT_S16_LE) {
-			format = SND_PCM_FORMAT_S32_LE;
-			ksft_print_msg("%s.%d.%d.%d.%s.%s format S16_LE -> S32_LE\n",
-					 cfg_prefix,
-					 data->card, data->device, data->subdevice,
-					 snd_pcm_stream_name(data->stream),
-					 snd_pcm_access_name(access));
+		i++;
+		if (i < ARRAY_SIZE(alt_formats) && alt_formats[i]) {
+			old_format = format;
+			format = snd_pcm_format_value(alt_formats[i]);
+			if (format != SND_PCM_FORMAT_UNKNOWN) {
+				ksft_print_msg("%s.%d.%d.%d.%s.%s format %s -> %s\n",
+						 test_name,
+						 data->card, data->device, data->subdevice,
+						 snd_pcm_stream_name(data->stream),
+						 snd_pcm_access_name(access),
+						 snd_pcm_format_name(old_format),
+						 snd_pcm_format_name(format));
+				samples = realloc(samples, (rate * channels *
+							    snd_pcm_format_physical_width(format)) / 8);
+				if (!samples)
+					ksft_exit_fail_msg("Out of memory\n");
+				snd_pcm_format_set_silence(format, samples, rate * channels);
+				goto __format;
+			}
 		}
 		snprintf(msg, sizeof(msg), "snd_pcm_hw_params_set_format %s: %s",
 					   snd_pcm_format_name(format), snd_strerror(err));
@@ -362,7 +367,7 @@ static void test_pcm_time1(struct pcm_data *data,
 	}
 
 	ksft_print_msg("%s.%d.%d.%d.%s hw_params.%s.%s.%ld.%ld.%ld.%ld sw_params.%ld\n",
-			 cfg_prefix,
+			 test_name,
 			 data->card, data->device, data->subdevice,
 			 snd_pcm_stream_name(data->stream),
 			 snd_pcm_access_name(access),
@@ -411,7 +416,7 @@ static void test_pcm_time1(struct pcm_data *data,
 	pass = true;
 __close:
 	ksft_test_result(pass, "%s.%d.%d.%d.%s%s%s\n",
-			 cfg_prefix,
+			 test_name,
 			 data->card, data->device, data->subdevice,
 			 snd_pcm_stream_name(data->stream),
 			 msg[0] ? " " : "", msg);
@@ -420,19 +425,35 @@ static void test_pcm_time1(struct pcm_data *data,
 		snd_pcm_close(handle);
 }
 
-#define TESTS_PER_PCM 2
-
 int main(void)
 {
 	struct pcm_data *pcm;
+	snd_config_t *global_config, *default_pcm_config, *cfg, *pcm_cfg;
+	snd_config_iterator_t i, next;
+	int num_pcm_tests = 0, num_tests;
+	const char *test_name, *test_type;
 
 	ksft_print_header();
 
+	global_config = conf_load_from_file("pcm-test.conf");
+	default_pcm_config = conf_get_subtree(global_config, "pcm", NULL);
+	if (default_pcm_config == NULL)
+		ksft_exit_fail_msg("default pcm test configuration (pcm compound) is missing\n");
+
 	conf_load();
 
 	find_pcms();
 
-	ksft_set_plan(num_missing + num_pcms * TESTS_PER_PCM);
+	for (pcm = pcm_list; pcm != NULL; pcm = pcm->next) {
+		cfg = pcm->pcm_config;
+		if (cfg == NULL)
+			cfg = default_pcm_config;
+		num_tests = conf_get_count(cfg, "test", NULL);
+		if (num_tests > 0)
+			num_pcm_tests += num_tests;
+	}
+
+	ksft_set_plan(num_missing + num_pcm_tests);
 
 	for (pcm = pcm_missing; pcm != NULL; pcm = pcm->next) {
 		ksft_test_result(false, "test.missing.%d.%d.%d.%s\n",
@@ -441,10 +462,25 @@ int main(void)
 	}
 
 	for (pcm = pcm_list; pcm != NULL; pcm = pcm->next) {
-		test_pcm_time1(pcm, "test.time1", "S16_LE", 48000, 2, 512, 4096);
-		test_pcm_time1(pcm, "test.time2", "S16_LE", 48000, 2, 24000, 192000);
+		cfg = pcm->pcm_config;
+		if (cfg == NULL)
+			cfg = default_pcm_config;
+		cfg = conf_get_subtree(cfg, "test", NULL);
+		if (cfg == NULL)
+			continue;
+		snd_config_for_each(i, next, cfg) {
+			pcm_cfg = snd_config_iterator_entry(i);
+			if (snd_config_get_id(pcm_cfg, &test_name) < 0)
+				ksft_exit_fail_msg("snd_config_get_id\n");
+			test_type = conf_get_string(pcm_cfg, "type", NULL, "time");
+			if (strcmp(test_type, "time") == 0)
+				test_pcm_time(pcm, test_name, pcm_cfg);
+			else
+				ksft_exit_fail_msg("unknown test type '%s'\n", test_type);
+		}
 	}
 
+	snd_config_delete(global_config);
 	conf_free();
 
 	ksft_exit_pass();
diff --git a/tools/testing/selftests/alsa/pcm-test.conf b/tools/testing/selftests/alsa/pcm-test.conf
new file mode 100644
index 000000000000..473a19251b49
--- /dev/null
+++ b/tools/testing/selftests/alsa/pcm-test.conf
@@ -0,0 +1,16 @@
+pcm.test.time1 {
+	format S16_LE
+	alt_formats [ S32_LE ]
+	rate 48000
+	channels 2
+	period_size 512
+	buffer_size 4096
+}
+pcm.test.time2 {
+	format S16_LE
+	alt_formats [ S32_LE ]
+	rate 48000
+	channels 2
+	period_size 24000
+	buffer_size 192000
+}
-- 
2.30.2

