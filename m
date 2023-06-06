Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03A87244A0
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbjFFNii (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 09:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbjFFNih (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 09:38:37 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AE512D;
        Tue,  6 Jun 2023 06:38:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9786c0cbfdcso18082466b.1;
        Tue, 06 Jun 2023 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686058710; x=1688650710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJx15k7wXJsUwHqwMd+uxvkX+XR+QcYC0wI4xX3ITa0=;
        b=ANEkgy05Dlqn2E+ugpnAbj2KreRfhJZRYdf6BUJ27F7V3CW/Ven0XwPmJS6ntnFCIB
         /cc+n4hZW3lX/K1xXfNxSvOgmsqoh5eCKX6Q9cSdG4D/wLrMwUBWPIm8BLEjNHXTteC4
         PRQD2w5zp7RfDeDeIXDHRPvaGdfSrm4jo8eEoxzTrOKRT8A/5zvYO71PpVNCHpRn+CCN
         gJ3teQfpeQ8nW19I1zpCeC5zYKPBw+7COHpSvPmZngBbwc520usNcjBG0+HCraUGtmlS
         4MGo6N1fXs6CB4/aiY/Eb1WKvcGA1/ZOf/7wbjTslx7FYlfeXUZCakAyNVjDmsOUu5Ts
         b7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686058710; x=1688650710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJx15k7wXJsUwHqwMd+uxvkX+XR+QcYC0wI4xX3ITa0=;
        b=dc8I74VnRWjmoW860/807OYA+9hJ17MKcPidXqU9Y4UZs3n852ET7br/4N1UaEkYi2
         WeaFXYfy6KK48B3rWoRWuRXKqHIAZWLe5MoH4OF6daHHy/GLyL49ABJFHz4GbDuIxt1n
         yYHqMpeo0bXX8oFuoedFsRhTpjM7tpDpS/sTzTuSgWXjxwyZLGVuO9t55ZoHSAJCql+K
         O+jxFhPzeAg6W0kwDU/LGv1ZQyjLEeJiN5trbCBQ+0W4ftsxUglX0DUGlopIM5EmaV98
         0Xz4suZJ0YlIAV7WTx4zLZ049GNgR10Sca3UQLmRtRUIYfKUTh1Q0i+AIUuusDXFVH30
         y+Zg==
X-Gm-Message-State: AC+VfDyQKzSA5YpAPjKYmrwP7bzWGY915afNGvHE+db9sDkkXhvWIsUH
        FzDvhc+9p9GPrgaIgOaUaBQ=
X-Google-Smtp-Source: ACHHUZ6LapeA7gTb+7iBvaN5fVnP7NC3smAO3ADqLFs83+DfY8Mi/BD2uLv1EyM4LIsA5W8JgHxSyw==
X-Received: by 2002:a17:906:7a08:b0:974:5480:6270 with SMTP id d8-20020a1709067a0800b0097454806270mr2093707ejo.0.1686058710349;
        Tue, 06 Jun 2023 06:38:30 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([178.160.196.94])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709066d0800b00977d7ccd9fdsm2837775ejr.95.2023.06.06.06.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:38:30 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, corbet@lwn.net, broonie@kernel.org,
        skhan@linuxfoundation.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, gregkh@linuxfoundation.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 3/3] selftests: ALSA: Add test for the 'pcmtest' driver
Date:   Tue,  6 Jun 2023 17:38:07 +0400
Message-Id: <20230606133807.14089-3-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606133807.14089-1-ivan.orlov0322@gmail.com>
References: <20230606133807.14089-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This test covers the new Virtual PCM Test Driver, including the capturing,
playback and ioctl redefinition functionalities for both interleaved and
non-interleaved access modes. This test is also helpful as an usage example
of the 'pcmtest' driver.

We have a lot of different virtual media drivers, which can be used for
testing of the userspace applications and media subsystem middle layer.
However, all of them are aimed at testing the video functionality and
simulating the video devices. For audio devices we have only snd-dummy
module, which is good in simulating the correct behavior of an ALSA device.
I decided to write a tool, which would help to test the userspace ALSA
programs (and the PCM middle layer as well) under unusual circumstances
to figure out how they would behave. So I came up with this Virtual PCM
Test Driver.

This new Virtual PCM Test Driver has several features which can be useful
during the userspace ALSA applications testing/fuzzing, or testing/fuzzing
of the PCM middle layer. Not all of them can be implemented using the
existing virtual drivers (like dummy or loopback). Here is what can this
driver do:

- Simulate both capture and playback processes
- Generate random or pattern-based capture data
- Check the playback stream for containing the looped pattern
- Inject delays into the playback and capturing processes
- Inject errors during the PCM callbacks

Also, this driver can check the playback stream for containing the
predefined pattern, which is used in the corresponding selftest to check
the PCM middle layer data transferring functionality. Additionally, this
driver redefines the default RESET ioctl, and the selftest covers this PCM
API functionality as well.

The driver supports both interleaved and non-interleaved access modes, and
have separate pattern buffers for each channel. The driver supports up to
4 channels and up to 8 substreams.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:

- Rename the driver from from 'valsa' to 'pcmtest'.
- Implement support for interleaved and non-interleaved access modes
- Add support for 8 substreams and 4 channels
- Extend supported formats
- Extend and rewrite in C the selftest for the driver

V2 -> V3:

- Add separate pattern buffers for each channel
- Speed up the capture data generation when using interleaved access mode
- Extend the corresponding selftest to cover the multiple channels
capturing and playback functionalities when using interleaved access mode.
- Fix documentation issues

 tools/testing/selftests/alsa/Makefile         |   2 +-
 .../selftests/alsa/test-pcmtest-driver.c      | 333 ++++++++++++++++++
 2 files changed, 334 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/alsa/test-pcmtest-driver.c

diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
index 901949db80ad..5af9ba8a4645 100644
--- a/tools/testing/selftests/alsa/Makefile
+++ b/tools/testing/selftests/alsa/Makefile
@@ -12,7 +12,7 @@ LDLIBS+=-lpthread
 
 OVERRIDE_TARGETS = 1
 
-TEST_GEN_PROGS := mixer-test pcm-test
+TEST_GEN_PROGS := mixer-test pcm-test test-pcmtest-driver
 
 TEST_GEN_PROGS_EXTENDED := libatest.so
 
diff --git a/tools/testing/selftests/alsa/test-pcmtest-driver.c b/tools/testing/selftests/alsa/test-pcmtest-driver.c
new file mode 100644
index 000000000000..4d51dae11ad6
--- /dev/null
+++ b/tools/testing/selftests/alsa/test-pcmtest-driver.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This is the test which covers PCM middle layer data transferring using
+ * the virtual pcm test driver (snd-pcmtest).
+ *
+ * Copyright 2023 Ivan Orlov <ivan.orlov0322@gmail.com>
+ */
+#include <string.h>
+#include <alsa/asoundlib.h>
+#include "../kselftest_harness.h"
+
+#define CH_NUM 4
+
+struct pattern_buf {
+	char buf[1024];
+	int len;
+};
+
+struct pattern_buf patterns[CH_NUM];
+
+struct pcmtest_test_params {
+	unsigned long buffer_size;
+	unsigned long period_size;
+	unsigned long channels;
+	unsigned int rate;
+	snd_pcm_access_t access;
+	size_t sec_buf_len;
+	size_t sample_size;
+	int time;
+	snd_pcm_format_t format;
+};
+
+static int read_patterns(void)
+{
+	FILE *fp, *fpl;
+	int i;
+	char pf[64];
+	char plf[64];
+
+	for (i = 0; i < CH_NUM; i++) {
+		sprintf(plf, "/sys/kernel/debug/pcmtest/fill_pattern%d_len", i);
+		fpl = fopen(plf, "r");
+		if (!fpl)
+			return -1;
+		fscanf(fpl, "%u", patterns[i].len);
+		fclose(fpl);
+
+		sprintf(pf, "/sys/kernel/debug/pcmtest/fill_pattern%d", i);
+		fp = fopen(pf, "r");
+		if (!fp) {
+			fclose(fpl);
+			return -1;
+		}
+		fread(patterns[i].buf, 1, patterns[i].len, fp);
+		fclose(fp);
+	}
+
+	return 0;
+}
+
+static int get_test_results(char *debug_name)
+{
+	int result;
+	FILE *f;
+	char fname[128];
+
+	sprintf(fname, "/sys/kernel/debug/pcmtest/%s", debug_name);
+
+	f = fopen(fname, "r");
+	if (!f) {
+		printf("Failed to open file\n");
+		return -1;
+	}
+	fscanf(f, "%d", &result);
+	fclose(f);
+
+	return result;
+}
+
+static size_t get_sec_buf_len(unsigned int rate, unsigned long channels, snd_pcm_format_t format)
+{
+	return rate * channels * snd_pcm_format_physical_width(format) / 8;
+}
+
+static int setup_handle(snd_pcm_t **handle, snd_pcm_sw_params_t *swparams,
+			snd_pcm_hw_params_t *hwparams, struct pcmtest_test_params *params,
+			int card, snd_pcm_stream_t stream)
+{
+	char pcm_name[32];
+	int err;
+
+	sprintf(pcm_name, "hw:%d,0,0", card);
+	err = snd_pcm_open(handle, pcm_name, stream, 0);
+	if (err < 0)
+		return err;
+	snd_pcm_hw_params_any(*handle, hwparams);
+	snd_pcm_hw_params_set_rate_resample(*handle, hwparams, 0);
+	snd_pcm_hw_params_set_access(*handle, hwparams, params->access);
+	snd_pcm_hw_params_set_format(*handle, hwparams, params->format);
+	snd_pcm_hw_params_set_channels(*handle, hwparams, params->channels);
+	snd_pcm_hw_params_set_rate_near(*handle, hwparams, &params->rate, 0);
+	snd_pcm_hw_params_set_period_size_near(*handle, hwparams, &params->period_size, 0);
+	snd_pcm_hw_params_set_buffer_size_near(*handle, hwparams, &params->buffer_size);
+	snd_pcm_hw_params(*handle, hwparams);
+	snd_pcm_sw_params_current(*handle, swparams);
+
+	snd_pcm_hw_params_set_rate_resample(*handle, hwparams, 0);
+	snd_pcm_sw_params_set_avail_min(*handle, swparams, params->period_size);
+	snd_pcm_hw_params_set_buffer_size_near(*handle, hwparams, &params->buffer_size);
+	snd_pcm_hw_params_set_period_size_near(*handle, hwparams, &params->period_size, 0);
+	snd_pcm_sw_params(*handle, swparams);
+	snd_pcm_hw_params(*handle, hwparams);
+
+	return 0;
+}
+
+FIXTURE(pcmtest) {
+	int card;
+	snd_pcm_sw_params_t *swparams;
+	snd_pcm_hw_params_t *hwparams;
+	struct pcmtest_test_params params;
+};
+
+FIXTURE_TEARDOWN(pcmtest) {
+}
+
+FIXTURE_SETUP(pcmtest) {
+	char *card_name;
+	int err;
+
+	if (geteuid())
+		SKIP(exit(-1), "This test needs root to run!");
+
+	err = read_patterns();
+	if (err)
+		SKIP(exit(-1), "Can't read patterns. Probably, module isn't loaded");
+
+	card_name = malloc(127);
+	ASSERT_NE(card_name, NULL);
+	self->params.buffer_size = 16384;
+	self->params.period_size = 4096;
+	self->params.channels = CH_NUM;
+	self->params.rate = 8000;
+	self->params.access = SND_PCM_ACCESS_RW_INTERLEAVED;
+	self->params.format = SND_PCM_FORMAT_S16_LE;
+	self->card = -1;
+	self->params.sample_size = snd_pcm_format_physical_width(self->params.format) / 8;
+
+	self->params.sec_buf_len = get_sec_buf_len(self->params.rate, self->params.channels,
+						   self->params.format);
+	self->params.time = 4;
+
+	while (snd_card_next(&self->card) >= 0) {
+		if (self->card == -1)
+			break;
+		snd_card_get_name(self->card, &card_name);
+		if (!strcmp(card_name, "PCM-Test"))
+			break;
+	}
+	free(card_name);
+	ASSERT_NE(self->card, -1);
+}
+
+/*
+ * Here we are trying to send the looped monotonically increasing sequence of bytes to the driver.
+ * If our data isn't corrupted, the driver will set the content of 'pc_test' debugfs file to '1'
+ */
+TEST_F(pcmtest, playback) {
+	snd_pcm_t *handle;
+	unsigned char *it;
+	size_t write_res;
+	int test_results;
+	int i, cur_ch, pos_in_ch;
+	void *samples;
+	struct pcmtest_test_params *params = &self->params;
+
+	samples = calloc(self->params.sec_buf_len * self->params.time, 1);
+	ASSERT_NE(samples, NULL);
+
+	snd_pcm_sw_params_alloca(&self->swparams);
+	snd_pcm_hw_params_alloca(&self->hwparams);
+
+	ASSERT_EQ(setup_handle(&handle, self->swparams, self->hwparams, params,
+			       self->card, SND_PCM_STREAM_PLAYBACK), 0);
+	snd_pcm_format_set_silence(params->format, samples,
+				   params->rate * params->channels * params->time);
+	it = samples;
+	for (i = 0; i < self->params.sec_buf_len * params->time; i++) {
+		cur_ch = (i / params->sample_size) % CH_NUM;
+		pos_in_ch = i / params->sample_size / CH_NUM * params->sample_size
+			    + (i % params->sample_size);
+		it[i] = patterns[cur_ch].buf[pos_in_ch % patterns[cur_ch].len];
+	}
+	write_res = snd_pcm_writei(handle, samples, params->rate * params->time);
+	ASSERT_GE(write_res, 0);
+
+	snd_pcm_close(handle);
+	free(samples);
+	test_results = get_test_results("pc_test");
+	ASSERT_EQ(test_results, 1);
+}
+
+/*
+ * Here we test that the virtual alsa driver returns looped and monotonically increasing sequence
+ * of bytes. In the interleaved mode the buffer will contain samples in the following order:
+ * C0, C1, C2, C3, C0, C1, ...
+ */
+TEST_F(pcmtest, capture) {
+	snd_pcm_t *handle;
+	unsigned char *it;
+	size_t read_res;
+	int i, cur_ch, pos_in_ch;
+	void *samples;
+	struct pcmtest_test_params *params = &self->params;
+
+	samples = calloc(self->params.sec_buf_len * self->params.time, 1);
+	ASSERT_NE(samples, NULL);
+
+	snd_pcm_sw_params_alloca(&self->swparams);
+	snd_pcm_hw_params_alloca(&self->hwparams);
+
+	ASSERT_EQ(setup_handle(&handle, self->swparams, self->hwparams,
+			       params, self->card, SND_PCM_STREAM_CAPTURE), 0);
+	snd_pcm_format_set_silence(params->format, samples,
+				   params->rate * params->channels * params->time);
+	read_res = snd_pcm_readi(handle, samples, params->rate * params->time);
+	ASSERT_GE(read_res, 0);
+	snd_pcm_close(handle);
+	it = (unsigned char *)samples;
+	for (i = 0; i < self->params.sec_buf_len * self->params.time; i++) {
+		cur_ch = (i / params->sample_size) % CH_NUM;
+		pos_in_ch = i / params->sample_size / CH_NUM * params->sample_size
+			    + (i % params->sample_size);
+		ASSERT_EQ(it[i], patterns[cur_ch].buf[pos_in_ch % patterns[cur_ch].len]);
+	}
+	free(samples);
+}
+
+// Test capture in the non-interleaved access mode. The are buffers for each recorded channel
+TEST_F(pcmtest, ni_capture) {
+	snd_pcm_t *handle;
+	struct pcmtest_test_params params = self->params;
+	char **chan_samples;
+	size_t i, j, read_res;
+
+	chan_samples = calloc(CH_NUM, sizeof(*chan_samples));
+	ASSERT_NE(chan_samples, NULL);
+
+	snd_pcm_sw_params_alloca(&self->swparams);
+	snd_pcm_hw_params_alloca(&self->hwparams);
+
+	params.access = SND_PCM_ACCESS_RW_NONINTERLEAVED;
+
+	ASSERT_EQ(setup_handle(&handle, self->swparams, self->hwparams,
+			       &params, self->card, SND_PCM_STREAM_CAPTURE), 0);
+
+	for (i = 0; i < CH_NUM; i++)
+		chan_samples[i] = calloc(params.sec_buf_len * params.time, 1);
+
+	for (i = 0; i < 1; i++) {
+		read_res = snd_pcm_readn(handle, (void **)chan_samples, params.rate * params.time);
+		ASSERT_GE(read_res, 0);
+	}
+	snd_pcm_close(handle);
+
+	for (i = 0; i < CH_NUM; i++) {
+		for (j = 0; j < params.rate * params.time; j++)
+			ASSERT_EQ(chan_samples[i][j], patterns[i].buf[j % patterns[i].len]);
+		free(chan_samples[i]);
+	}
+	free(chan_samples);
+}
+
+TEST_F(pcmtest, ni_playback) {
+	snd_pcm_t *handle;
+	struct pcmtest_test_params params = self->params;
+	char **chan_samples;
+	size_t i, j, read_res;
+	int test_res;
+
+	chan_samples = calloc(CH_NUM, sizeof(*chan_samples));
+	ASSERT_NE(chan_samples, NULL);
+
+	snd_pcm_sw_params_alloca(&self->swparams);
+	snd_pcm_hw_params_alloca(&self->hwparams);
+
+	params.access = SND_PCM_ACCESS_RW_NONINTERLEAVED;
+
+	ASSERT_EQ(setup_handle(&handle, self->swparams, self->hwparams,
+			       &params, self->card, SND_PCM_STREAM_PLAYBACK), 0);
+
+	for (i = 0; i < CH_NUM; i++) {
+		chan_samples[i] = calloc(params.sec_buf_len * params.time, 1);
+		for (j = 0; j < params.sec_buf_len * params.time; j++)
+			chan_samples[i][j] = patterns[i].buf[j % patterns[i].len];
+	}
+
+	for (i = 0; i < 1; i++) {
+		read_res = snd_pcm_writen(handle, (void **)chan_samples, params.rate * params.time);
+		ASSERT_GE(read_res, 0);
+	}
+
+	snd_pcm_close(handle);
+	test_res = get_test_results("pc_test");
+	ASSERT_EQ(test_res, 1);
+
+	for (i = 0; i < CH_NUM; i++)
+		free(chan_samples[i]);
+	free(chan_samples);
+}
+
+/*
+ * Here we are testing the custom ioctl definition inside the virtual driver. If it triggers
+ * successfully, the driver sets the content of 'ioctl_test' debugfs file to '1'.
+ */
+TEST_F(pcmtest, reset_ioctl) {
+	snd_pcm_t *handle;
+	unsigned char *it;
+	int test_res;
+	struct pcmtest_test_params *params = &self->params;
+
+	snd_pcm_sw_params_alloca(&self->swparams);
+	snd_pcm_hw_params_alloca(&self->hwparams);
+
+	ASSERT_EQ(setup_handle(&handle, self->swparams, self->hwparams, params,
+			       self->card, SND_PCM_STREAM_CAPTURE), 0);
+	snd_pcm_reset(handle);
+	test_res = get_test_results("ioctl_test");
+	ASSERT_EQ(test_res, 1);
+	snd_pcm_close(handle);
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1

