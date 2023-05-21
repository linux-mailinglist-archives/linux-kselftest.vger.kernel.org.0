Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B6070AF9C
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 May 2023 20:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjEUSdL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 May 2023 14:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjEUScy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 May 2023 14:32:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F154115;
        Sun, 21 May 2023 11:32:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9659dee48edso38932766b.0;
        Sun, 21 May 2023 11:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684693964; x=1687285964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJyNPSTUUMs7c0Obxl2iPIkMqeFcBT3JyMI/OJTExCU=;
        b=oeRP94lmPulozu6xqgST0HHsh50XkoJI9n4qE1bIWCh6jzYkr0N9NXExuGmniBYAPX
         ZRKojyQHqCtykyyhW67rgGWuG69ji5zTpG9sXciU5W67in4bMVzGQ3+mvoP4qilldF7M
         qAPtnXkcBle1gINtmWl0H6k47GolhPMrlHRgiR/AXd4wDlyrosCgttywKoKP6iVOA577
         vcq+MeuJyzz+mt489EyLamaXEOhUn/QjzwnY34UDAOqi5UScKK0cToA05tOz0RmOsUTh
         P5WbvjErp1zf+R8ZtQ2JMAsm7Et0Nu1quGf/0WINsDUOpcxwrkGZZi5s90oJ1hWCp8wE
         09bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684693964; x=1687285964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJyNPSTUUMs7c0Obxl2iPIkMqeFcBT3JyMI/OJTExCU=;
        b=Bbzu72SUdHQe+FECz7QT+4T4u8EprK+l8Xo0U1MN7pvtMgoCxl9H+JgTSMrMgqmln/
         tmQPpX7hhy89lRje9rWwymyx9Sr9amwOhB/UynC+HRkzwcgEYxfGRoL74sQD69HHhWPb
         85e74ZSQRHeZmneKkXtI2puNoOTWjoEFmMKWVFaih1tcMKempCQNvceAqwG63d5pfo8z
         zkHeO0G2PDIIANd6O2NzAh2uxHsIKHjE/4l5h9tj8z8lfbwwDW9Z1MIUVDYH1eb/9cuV
         KEV8lciWGzpfN+O/z9V8R/p2yTGMeuwg5ij2juHsp2fGe3Vx0v/gf9evbxnBlTcgGkOj
         hfIw==
X-Gm-Message-State: AC+VfDxRSvrNP0A6/mRL9V7DKV3B0IcwMesgkCGIfOa/c5dzSzt8otVW
        ENa9AZuG5ODZECJ+95CHh4M=
X-Google-Smtp-Source: ACHHUZ5tZW02l7qh1zYz1oas2FtUVTMTsN9MEpoDHXP7SP6vSX/umWDeP7xhLcIi562KWZV15xQR5A==
X-Received: by 2002:a17:906:6495:b0:8d2:78c5:1d4e with SMTP id e21-20020a170906649500b008d278c51d4emr8723407ejm.5.1684693964448;
        Sun, 21 May 2023 11:32:44 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.87])
        by smtp.gmail.com with ESMTPSA id mc20-20020a170906eb5400b0096f803afbe3sm2194252ejb.66.2023.05.21.11.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 11:32:44 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, corbet@lwn.net, broonie@kernel.org,
        skhan@linuxfoundation.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, gregkh@linuxfoundation.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 3/3] selftests: ALSA: Add test for the 'pcmtest' driver
Date:   Sun, 21 May 2023 22:32:18 +0400
Message-Id: <20230521183218.9641-3-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230521183218.9641-1-ivan.orlov0322@gmail.com>
References: <20230521183218.9641-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

After all, I think this driver would be a good start, and I believe in the
future we will see more virtual sound drivers.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:

- Rename the driver from 'valsa' to 'pcmtest'.
- Implement support for interleaved and non-interleaved access modes
- Add support for 8 substreams and 4 channels
- Extend supported formats
- Extend and rewrite in C the selftest for the driver

 tools/testing/selftests/alsa/Makefile         |   2 +-
 .../selftests/alsa/test-pcmtest-driver.c      | 323 ++++++++++++++++++
 2 files changed, 324 insertions(+), 1 deletion(-)
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
index 000000000000..47256e58db93
--- /dev/null
+++ b/tools/testing/selftests/alsa/test-pcmtest-driver.c
@@ -0,0 +1,323 @@
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
+#define NI_CH 4
+
+static char pattern_buf[4096];
+static unsigned int pattern_len;
+
+struct pcmtest_test_params {
+	unsigned long buffer_size;
+	unsigned long period_size;
+	unsigned long channels;
+	unsigned int rate;
+	snd_pcm_access_t access;
+	size_t sample_len;
+	int time;
+	snd_pcm_format_t format;
+};
+
+static int read_pattern(void)
+{
+	FILE *fp, *fpl;
+
+	fpl = fopen("/sys/kernel/debug/pcmtest/pattern_len", "r");
+	if (!fpl)
+		return -1;
+	fscanf(fpl, "%u", &pattern_len);
+	fclose(fpl);
+
+	fp = fopen("/sys/kernel/debug/pcmtest/fill_pattern", "r");
+	if (!fp) {
+		fclose(fpl);
+		return -1;
+	}
+	fread(pattern_buf, 1, pattern_len, fp);
+	fclose(fp);
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
+static size_t get_sample_len(unsigned int rate, unsigned long channels, snd_pcm_format_t format)
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
+	err = read_pattern();
+	if (err)
+		SKIP(exit(-1), "Can't read pattern. Probably, module isn't loaded");
+
+	card_name = malloc(127);
+	ASSERT_NE(card_name, NULL);
+	self->params.buffer_size = 16384;
+	self->params.period_size = 4096;
+	self->params.channels = 1;
+	self->params.rate = 8000;
+	self->params.access = SND_PCM_ACCESS_RW_INTERLEAVED;
+	self->params.format = SND_PCM_FORMAT_S16_LE;
+	self->card = -1;
+
+	self->params.sample_len = get_sample_len(self->params.rate, self->params.channels,
+						 self->params.format);
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
+	int i;
+	unsigned short *rsamples;
+	void *samples;
+	struct pcmtest_test_params *params = &self->params;
+
+	samples = calloc(self->params.sample_len * self->params.time, 1);
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
+	for (i = 0; i < self->params.sample_len * params->time; i++)
+		it[i] = pattern_buf[i % pattern_len];
+	rsamples = samples;
+	for (i = 0; i < params->time; i++) {
+		write_res = snd_pcm_writei(handle, rsamples, params->rate);
+		rsamples += params->rate;
+		ASSERT_GE(write_res, 0);
+	}
+
+	snd_pcm_close(handle);
+	free(samples);
+	test_results = get_test_results("pc_test");
+	ASSERT_EQ(test_results, 1);
+}
+
+/*
+ * Here we test that the virtual alsa driver returns looped and monotonically increasing sequence
+ * of bytes
+ */
+TEST_F(pcmtest, capture) {
+	snd_pcm_t *handle;
+	unsigned char *it;
+	size_t read_res;
+	int i;
+	void *samples;
+	unsigned short *rsamples;
+	struct pcmtest_test_params *params = &self->params;
+
+	samples = calloc(self->params.sample_len * self->params.time, 1);
+	ASSERT_NE(samples, NULL);
+
+	snd_pcm_sw_params_alloca(&self->swparams);
+	snd_pcm_hw_params_alloca(&self->hwparams);
+
+	ASSERT_EQ(setup_handle(&handle, self->swparams, self->hwparams,
+			       params, self->card, SND_PCM_STREAM_CAPTURE), 0);
+	snd_pcm_format_set_silence(params->format, samples,
+				   params->rate * params->channels * params->time);
+	rsamples = samples;
+	for (i = 0; i < params->time; i++) {
+		read_res = snd_pcm_readi(handle, rsamples, params->rate);
+		rsamples += params->rate;
+		ASSERT_GE(read_res, 0);
+	}
+	snd_pcm_close(handle);
+	it = (unsigned char *)samples;
+	for (i = 0; i < self->params.sample_len * self->params.time; i++)
+		ASSERT_EQ(it[i], pattern_buf[i % pattern_len]);
+	free(samples);
+}
+
+// Test capture in the non-interleaved access mode.
+TEST_F(pcmtest, ni_capture) {
+	snd_pcm_t *handle;
+	struct pcmtest_test_params params = self->params;
+	char **chan_samples;
+	size_t i, j, read_res;
+
+	params.channels = NI_CH;
+	chan_samples = calloc(NI_CH, sizeof(*chan_samples));
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
+	for (i = 0; i < NI_CH; i++)
+		chan_samples[i] = calloc(params.sample_len * params.time, 1);
+
+	for (i = 0; i < 1; i++) {
+		read_res = snd_pcm_readn(handle, (void **)chan_samples, params.rate * params.time);
+		ASSERT_GE(read_res, 0);
+	}
+	snd_pcm_close(handle);
+
+	for (i = 0; i < NI_CH; i++) {
+		for (j = 0; j < params.rate * params.time; j++)
+			ASSERT_EQ(chan_samples[i][j], pattern_buf[j % pattern_len]);
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
+	params.channels = NI_CH;
+	chan_samples = calloc(NI_CH, sizeof(*chan_samples));
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
+	for (i = 0; i < NI_CH; i++) {
+		chan_samples[i] = calloc(params.sample_len * params.time, 1);
+		for (j = 0; j < params.sample_len * params.time; j++)
+			chan_samples[i][j] = pattern_buf[j % pattern_len];
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
+	for (i = 0; i < NI_CH; i++)
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

