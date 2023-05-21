Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C90D70AF98
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 May 2023 20:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjEUSc6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 May 2023 14:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjEUScx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 May 2023 14:32:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63013FA;
        Sun, 21 May 2023 11:32:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94ea38c90ccso38271766b.1;
        Sun, 21 May 2023 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684693960; x=1687285960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAwX0QH9k1Rs1HFfmX8CB0cGrsTVWrWqbNiwVJkp9sY=;
        b=Yc4gl/h++75T31XbVUzwPJkinMY6f4meWxHbExdhGe59wwIBCge9DNrjL/yDyKYhC+
         549Xkzwt3ewMozDDjw3jeWM+ZGWk59xmbMhrXhG01R2cQcgxWVDvgW+Pn5daJ99gGf/t
         iRq3nWl4IPYbJwynu56F5LN1j38h7vfIbimzGlQeQ0FgpBRejIEyH3T6fQwgOgzktaJb
         OUzt00bdvkTuNl3e9LHPfkajCeQyr6k9cfn4p4Fg+Op6wvjzLlM6VLZC/CVKBauM5LK2
         aCAKifKcPBsSPVqja2f2spr9MWlkvNt6/UEpMChzrN02PwGsXl8yEH17Rp26Nck7GU1N
         mkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684693960; x=1687285960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAwX0QH9k1Rs1HFfmX8CB0cGrsTVWrWqbNiwVJkp9sY=;
        b=XG3gk94sXoVsYKebjPLluqANI6cr/2M8c/eER1BRhJ8hxaPW8UavXhL67imO1qc2Uk
         hmn2IkzRWGrcbu690mc9xB4JcXAYsxf82qEAKEpNK0kJBD5dCT1s10GfH1R3etIpCHAD
         Bn3YSAfowpnq1I+3XdSPkKgZzceZ2BJA+1n9u/DHsOTcJxZTgNhPecIUFDpYzRtLVwum
         OhLnUaNqhzHdWeUeKYQQy/ZmxhN6EVIMLLo+n18GI5BergR0jXsNUi/eT2ToBsbsRc9r
         95I0rD9d4oB+yXW09ZPqKD1i2FCdKlSpCu6kFCRoGuTmNWTThCoUtqZvzmJocotJagsm
         q9Og==
X-Gm-Message-State: AC+VfDxMWD7L+NnE9LEa7jVtukHrZ+0f+y2/yhs1Z3EawBjKrC1KXIUS
        yxqlCYMHogzS5T7s1dO8dqw=
X-Google-Smtp-Source: ACHHUZ6pj/2n1eHVmCtCbDC+rhgpm6pdFARPGDbn/s2PYDhHYshM6XXjgP+rFmw3Z4FoE2+CaGcIQQ==
X-Received: by 2002:a17:906:739d:b0:965:9db5:3821 with SMTP id f29-20020a170906739d00b009659db53821mr7730565ejl.7.1684693959482;
        Sun, 21 May 2023 11:32:39 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.87])
        by smtp.gmail.com with ESMTPSA id mc20-20020a170906eb5400b0096f803afbe3sm2194252ejb.66.2023.05.21.11.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 11:32:39 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, corbet@lwn.net, broonie@kernel.org,
        skhan@linuxfoundation.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, gregkh@linuxfoundation.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 2/3] ALSA: Implement the new Virtual PCM Test Driver
Date:   Sun, 21 May 2023 22:32:17 +0400
Message-Id: <20230521183218.9641-2-ivan.orlov0322@gmail.com>
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
- Inject delays into the playback and capturing processes
- Inject errors during the PCM callbacks

Also, this driver can check the playback stream for containing the
predefined pattern, which is used in the corresponding selftest to check
the PCM middle layer data transferring functionality. Additionally, this
driver redefines the default RESET ioctl, and the selftest covers this PCM
API functionality as well.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:

- Rename the driver from 'valsa' to 'pcmtest'.
- Implement support for interleaved and non-interleaved access modes
- Add support for 8 substreams and 4 channels
- Extend supported formats
- Extend and rewrite in C the selftest for the driver

 MAINTAINERS             |   8 +
 sound/drivers/Kconfig   |  16 +
 sound/drivers/Makefile  |   2 +
 sound/drivers/pcmtest.c | 659 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 685 insertions(+)
 create mode 100644 sound/drivers/pcmtest.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ef11624748..a16ab62ff975 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22419,6 +22419,14 @@ L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/vboxsf/*
 
+VIRTUAL PCM TEST DRIVER
+M:	Ivan Orlov <ivan.orlov0322@gmail.com>
+L:	alsa-devel@alsa-project.org
+S:	Maintained
+F:	Documentation/sound/cards/pcmtest.rst
+F:	sound/drivers/pcmtest.c
+F:	tools/testing/selftests/alsa/test-pcmtest-driver.c
+
 VIRTUAL SERIO DEVICE DRIVER
 M:	Stephen Chandler Paul <thatslyude@gmail.com>
 S:	Maintained
diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index be3009746f3a..7a0f9f409642 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -109,6 +109,22 @@ config SND_ALOOP
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-aloop.
 
+config SND_PCMTEST
+	tristate "Virtual PCM test driver"
+	select SND_PCM
+	help
+	  Say 'Y' or 'M' to include support for the Virtual PCM test driver.
+	  This driver is aimed at extended testing of the userspace applications
+	  which use the ALSA API, as well as the PCM middle layer testing.
+
+	  It can generate random or pattern-based data into the capture stream,
+	  check the playback stream for containing the selected pattern, inject
+	  time delays during capture/playback, redefine the RESET ioctl operation
+	  to perform the PCM middle layer testing and inject errors during the
+	  PCM callbacks. It supports both interleaved and non-interleaved access
+	  modes. You can find the corresponding selftest in the 'alsa'
+	  selftests folder.
+
 config SND_VIRMIDI
 	tristate "Virtual MIDI soundcard"
 	depends on SND_SEQUENCER
diff --git a/sound/drivers/Makefile b/sound/drivers/Makefile
index b60303180a1b..2c0c7092d396 100644
--- a/sound/drivers/Makefile
+++ b/sound/drivers/Makefile
@@ -8,6 +8,7 @@ snd-dummy-objs := dummy.o
 snd-aloop-objs := aloop.o
 snd-mtpav-objs := mtpav.o
 snd-mts64-objs := mts64.o
+snd-pcmtest-objs := pcmtest.o
 snd-portman2x4-objs := portman2x4.o
 snd-serial-u16550-objs := serial-u16550.o
 snd-serial-generic-objs := serial-generic.o
@@ -17,6 +18,7 @@ snd-virmidi-objs := virmidi.o
 obj-$(CONFIG_SND_DUMMY) += snd-dummy.o
 obj-$(CONFIG_SND_ALOOP) += snd-aloop.o
 obj-$(CONFIG_SND_VIRMIDI) += snd-virmidi.o
+obj-$(CONFIG_SND_PCMTEST) += snd-pcmtest.o
 obj-$(CONFIG_SND_SERIAL_U16550) += snd-serial-u16550.o
 obj-$(CONFIG_SND_SERIAL_GENERIC) += snd-serial-generic.o
 obj-$(CONFIG_SND_MTPAV) += snd-mtpav.o
diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
new file mode 100644
index 000000000000..7b46eb415796
--- /dev/null
+++ b/sound/drivers/pcmtest.c
@@ -0,0 +1,659 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Virtual ALSA driver for PCM testing/fuzzing
+ *
+ * Copyright 2023 Ivan Orlov <ivan.orlov0322@gmail.com>
+ *
+ * This is a simple virtual ALSA driver, which can be used for audio applications/PCM middle layer
+ * testing or fuzzing.
+ * It can:
+ *	- Simulate 'playback' and 'capture' actions
+ *	- Generate random or pattern-based capture data
+ *	- Check playback buffer for containing looped template, and notify about the results
+ *	through the debugfs entry
+ *	- Inject delays into the playback and capturing processes. See 'inject_delay' parameter.
+ *	- Inject errors during the PCM callbacks.
+ *	- Register custom RESET ioctl and notify when it is called through the debugfs entry
+ *	- Work in interleaved and non-interleaved modes
+ *	- Support up to 8 substreams
+ *	- Support up to 4 channels
+ *	- Support framerates from 8 kHz to 48 kHz
+ *
+ * When driver works in the capture mode with multiple channels, it duplicates the looped
+ * pattern to each separate channel. For example, if we have 2 channels, format = U8, interleaved
+ * access mode and pattern 'abacaba', the DMA buffer will look like aabbccaabbaaaa..., so buffer for
+ * each channel will contain abacabaabacaba... Same for the non-interleaved mode.
+ *
+ * However, it may break the capturing on the higher framerates with small period size, so it is
+ * better to choose larger period sizes.
+ *
+ * You can find the corresponding selftest in the 'alsa' selftests folder.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <sound/pcm.h>
+#include <sound/core.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/timer.h>
+#include <linux/random.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+
+#define DEVNAME "pcmtestd"
+#define CARD_NAME "pcm-test-card"
+#define TIMER_PER_SEC 5
+#define TIMER_INTERVAL (HZ / TIMER_PER_SEC)
+#define DELAY_JIFFIES HZ
+#define PLAYBACK_SUBSTREAM_CNT	8
+#define CAPTURE_SUBSTREAM_CNT	8
+#define MAX_CHANNELS_NUM	4
+
+#define FILL_MODE_RAND	0
+#define FILL_MODE_PAT	1
+
+#define MAX_PATTERN_LEN 4096
+
+static int index = -1;
+static char *id = "pcmtest";
+static bool enable = true;
+static int inject_delay;
+static bool inject_hwpars_err;
+static bool inject_prepare_err;
+static bool inject_trigger_err;
+
+static short fill_mode = FILL_MODE_PAT;
+static char fill_pattern[MAX_PATTERN_LEN] = "abacaba";
+static u32 pattern_len = 7;
+
+static u8 playback_capture_test;
+static u8 ioctl_reset_test;
+static struct dentry *driver_debug_dir;
+
+module_param(index, int, 0444);
+MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard");
+module_param(id, charp, 0444);
+MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard");
+module_param(enable, bool, 0444);
+MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
+module_param(fill_mode, short, 0600);
+MODULE_PARM_DESC(fill_mode, "Buffer fill mode: rand(0) or pattern(1)");
+module_param(inject_delay, int, 0600);
+MODULE_PARM_DESC(inject_delay, "Inject delays during playback/capture (in jiffies)");
+module_param(inject_hwpars_err, bool, 0600);
+MODULE_PARM_DESC(inject_hwpars_err, "Inject EBUSY error in the 'hw_params' callback");
+module_param(inject_prepare_err, bool, 0600);
+MODULE_PARM_DESC(inject_prepare_err, "Inject EINVAL error in the 'prepare' callback");
+module_param(inject_trigger_err, bool, 0600);
+MODULE_PARM_DESC(inject_trigger_err, "Inject EINVAL error in the 'trigger' callback");
+
+struct pcmtst {
+	struct snd_pcm *pcm;
+	struct snd_card *card;
+	struct platform_device *pdev;
+};
+
+struct pcmtst_buf_iter {
+	size_t buf_pos;				// position in the DMA buffer
+	size_t period_pos;			// period-relative position
+	size_t b_rw;				// Bytes to write on every timer tick
+	unsigned int sample_bytes;		// sample_bits / 8
+	bool is_buf_corrupted;			// playback test result indicator
+	size_t period_bytes;			// bytes in a one period
+	bool interleaved;			// Interleaved/Non-interleaved mode
+	size_t total_bytes;			// Total bytes read/written
+	size_t chan_block;			// Bytes in one channel buffer when non-interleaved
+	struct snd_pcm_substream *substream;
+	struct timer_list timer_instance;
+};
+
+static struct pcmtst *pcmtst;
+
+static struct snd_pcm_hardware snd_pcmtst_hw = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED |
+		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_NONINTERLEAVED |
+		 SNDRV_PCM_INFO_MMAP_VALID),
+	.formats =		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_8000_48000,
+	.rate_min =		8000,
+	.rate_max =		48000,
+	.channels_min =		1,
+	.channels_max =		MAX_CHANNELS_NUM,
+	.buffer_bytes_max =	128 * 1024,
+	.period_bytes_min =	4096,
+	.period_bytes_max =	32768,
+	.periods_min =		1,
+	.periods_max =		1024,
+};
+
+static inline void inc_buf_pos(struct pcmtst_buf_iter *v_iter, size_t by, size_t bytes)
+{
+	v_iter->total_bytes += by;
+	v_iter->buf_pos += by;
+	v_iter->buf_pos %= bytes;
+}
+
+/*
+ * Position in the DMA buffer when we are in the non-interleaved mode. We increment buf_pos
+ * every time we write a byte to any channel, so the position in the current channel buffer is
+ * (position in the DMA buffer) / count_of_channels + size_of_channel_buf * current_channel
+ */
+static inline size_t buf_pos_n(struct pcmtst_buf_iter *v_iter, unsigned int channels,
+			       unsigned int chan_num)
+{
+	return v_iter->buf_pos / channels + v_iter->chan_block * chan_num;
+}
+
+/*
+ * Get the count of bytes written for the current channel in the interleaved mode.
+ * This is (count of samples written for the current channel) * bytes_in_sample +
+ * (relative position in the current sample)
+ */
+static inline size_t ch_pos_i(size_t b_total, unsigned int channels, unsigned int b_sample)
+{
+	return b_total / channels / b_sample * b_sample + b_total % b_sample;
+}
+
+static void check_buf_block_i(struct pcmtst_buf_iter *v_iter, struct snd_pcm_runtime *runtime)
+{
+	size_t i;
+	u8 current_byte;
+
+	for (i = 0; i < v_iter->b_rw; i++) {
+		current_byte = runtime->dma_area[v_iter->buf_pos];
+		if (!current_byte)
+			break;
+		if (current_byte != fill_pattern[ch_pos_i(v_iter->total_bytes, runtime->channels,
+							  v_iter->sample_bytes) % pattern_len]) {
+			v_iter->is_buf_corrupted = true;
+			break;
+		}
+		inc_buf_pos(v_iter, 1, runtime->dma_bytes);
+	}
+	// If we broke during the loop, add remaining bytes to the buffer position.
+	inc_buf_pos(v_iter, v_iter->b_rw - i, runtime->dma_bytes);
+}
+
+static void check_buf_block_ni(struct pcmtst_buf_iter *v_iter, struct snd_pcm_runtime *runtime)
+{
+	unsigned int channels = runtime->channels;
+	size_t i;
+	u8 current_byte;
+
+	for (i = 0; i < v_iter->b_rw; i++) {
+		current_byte = runtime->dma_area[buf_pos_n(v_iter, channels, i % channels)];
+		if (!current_byte)
+			break;
+		if (current_byte != fill_pattern[(v_iter->total_bytes / channels)
+						 % pattern_len]) {
+			v_iter->is_buf_corrupted = true;
+			break;
+		}
+		inc_buf_pos(v_iter, 1, runtime->dma_bytes);
+	}
+	inc_buf_pos(v_iter, v_iter->b_rw - i, runtime->dma_bytes);
+}
+
+/*
+ * Check one block of the buffer. Here we iterate the buffer until we find '0'. This condition is
+ * necessary because we need to detect when the reading/writing ends, so we assume that the pattern
+ * doesn't contain zeros.
+ */
+static void check_buf_block(struct pcmtst_buf_iter *v_iter, struct snd_pcm_runtime *runtime)
+{
+	if (v_iter->interleaved)
+		check_buf_block_i(v_iter, runtime);
+	else
+		check_buf_block_ni(v_iter, runtime);
+}
+
+/*
+ * Fill buffer in the non-interleaved mode. The order of samples is C0, ..., C0, C1, ..., C1, C2...
+ * The channel buffers lay in the DMA buffer continuously (see default copy_user and copy_kernel
+ * handlers in the pcm_lib.c file).
+ *
+ * Here we increment the DMA buffer position every time we write a byte to any channel 'buffer'.
+ * We need this to simulate the correct hardware pointer moving.
+ */
+static void fill_block_pattern_n(struct pcmtst_buf_iter *v_iter, struct snd_pcm_runtime *runtime)
+{
+	size_t i;
+	unsigned int channels = runtime->channels;
+
+	for (i = 0; i < v_iter->b_rw; i++) {
+		runtime->dma_area[buf_pos_n(v_iter, channels, i % channels)] =
+			fill_pattern[(v_iter->total_bytes / channels) % pattern_len];
+		inc_buf_pos(v_iter, 1, runtime->dma_bytes);
+	}
+}
+
+// Fill buffer in the interleaved mode. The order of samples is C0, C1, C2, C0, C1, C2, ...
+static void fill_block_pattern_i(struct pcmtst_buf_iter *v_iter, struct snd_pcm_runtime *runtime)
+{
+	size_t i;
+	size_t pos_in_ch;
+
+	for (i = 0; i < v_iter->b_rw; i++) {
+		pos_in_ch = ch_pos_i(v_iter->total_bytes, runtime->channels,
+				     v_iter->sample_bytes);
+
+		runtime->dma_area[v_iter->buf_pos] = fill_pattern[pos_in_ch % pattern_len];
+		inc_buf_pos(v_iter, 1, runtime->dma_bytes);
+	}
+}
+
+static void fill_block_pattern(struct pcmtst_buf_iter *v_iter, struct snd_pcm_runtime *runtime)
+{
+	if (v_iter->interleaved)
+		fill_block_pattern_i(v_iter, runtime);
+	else
+		fill_block_pattern_n(v_iter, runtime);
+}
+
+static void fill_block_rand_n(struct pcmtst_buf_iter *v_iter, struct snd_pcm_runtime *runtime)
+{
+	unsigned int channels = runtime->channels;
+	// Remaining space in all channel buffers
+	size_t bytes_remain = runtime->dma_bytes - v_iter->buf_pos;
+	unsigned int i;
+
+	for (i = 0; i < channels; i++) {
+		if (v_iter->b_rw <= bytes_remain) {
+			//b_rw - count of bytes must be written for all channels at each timer tick
+			get_random_bytes(runtime->dma_area + buf_pos_n(v_iter, channels, i),
+					 v_iter->b_rw / channels);
+		} else {
+			// Write to the end of buffer and start from the beginning of it
+			get_random_bytes(runtime->dma_area + buf_pos_n(v_iter, channels, i),
+					 bytes_remain / channels);
+			get_random_bytes(runtime->dma_area + v_iter->chan_block * i,
+					 (v_iter->b_rw - bytes_remain) / channels);
+		}
+	}
+	inc_buf_pos(v_iter, v_iter->b_rw, runtime->dma_bytes);
+}
+
+static void fill_block_rand_i(struct pcmtst_buf_iter *v_iter, struct snd_pcm_runtime *runtime)
+{
+	size_t in_cur_block = runtime->dma_bytes - v_iter->buf_pos;
+
+	if (v_iter->b_rw <= in_cur_block) {
+		get_random_bytes(&runtime->dma_area[v_iter->buf_pos], v_iter->b_rw);
+	} else {
+		get_random_bytes(&runtime->dma_area[v_iter->buf_pos], in_cur_block);
+		get_random_bytes(runtime->dma_area, v_iter->b_rw - in_cur_block);
+	}
+	inc_buf_pos(v_iter, v_iter->b_rw, runtime->dma_bytes);
+}
+
+static void fill_block_random(struct pcmtst_buf_iter *v_iter, struct snd_pcm_runtime *runtime)
+{
+	if (v_iter->interleaved)
+		fill_block_rand_i(v_iter, runtime);
+	else
+		fill_block_rand_n(v_iter, runtime);
+}
+
+static void fill_block(struct pcmtst_buf_iter *v_iter, struct snd_pcm_runtime *runtime)
+{
+	switch (fill_mode) {
+	case FILL_MODE_RAND:
+		fill_block_random(v_iter, runtime);
+		break;
+	case FILL_MODE_PAT:
+		fill_block_pattern(v_iter, runtime);
+		break;
+	}
+}
+
+/*
+ * Here we iterate through the buffer by (buffer_size / iterates_per_second) bytes.
+ * The driver uses timer to simulate the hardware pointer moving, and notify the PCM middle layer
+ * about period elapsed.
+ */
+static void timer_timeout(struct timer_list *data)
+{
+	struct pcmtst_buf_iter *v_iter;
+	struct snd_pcm_substream *substream;
+
+	v_iter = from_timer(v_iter, data, timer_instance);
+	substream = v_iter->substream;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK && !v_iter->is_buf_corrupted)
+		check_buf_block(v_iter, substream->runtime);
+	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		fill_block(v_iter, substream->runtime);
+	else
+		inc_buf_pos(v_iter, v_iter->b_rw, substream->runtime->dma_bytes);
+
+	v_iter->period_pos += v_iter->b_rw;
+	if (v_iter->period_pos >= v_iter->period_bytes) {
+		v_iter->period_pos %= v_iter->period_bytes;
+		snd_pcm_period_elapsed(substream);
+	}
+
+	mod_timer(&v_iter->timer_instance, jiffies + TIMER_INTERVAL + inject_delay);
+}
+
+static int snd_pcmtst_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct pcmtst_buf_iter *v_iter;
+
+	v_iter = kzalloc(sizeof(*v_iter), GFP_KERNEL);
+	if (!v_iter)
+		return -ENOMEM;
+
+	runtime->hw = snd_pcmtst_hw;
+	runtime->private_data = v_iter;
+	v_iter->substream = substream;
+	v_iter->buf_pos = 0;
+	v_iter->is_buf_corrupted = false;
+	v_iter->period_pos = 0;
+	v_iter->total_bytes = 0;
+
+	playback_capture_test = 0;
+	ioctl_reset_test = 0;
+
+	timer_setup(&v_iter->timer_instance, timer_timeout, 0);
+	mod_timer(&v_iter->timer_instance, jiffies + TIMER_INTERVAL);
+	return 0;
+}
+
+static int snd_pcmtst_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct pcmtst_buf_iter *v_iter = substream->runtime->private_data;
+
+	timer_shutdown_sync(&v_iter->timer_instance);
+	v_iter->substream = NULL;
+	playback_capture_test = !v_iter->is_buf_corrupted;
+	kfree(v_iter);
+	return 0;
+}
+
+static int snd_pcmtst_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct pcmtst_buf_iter *v_iter = runtime->private_data;
+
+	if (inject_trigger_err)
+		return -EINVAL;
+
+	v_iter->sample_bytes = runtime->sample_bits / 8;
+	v_iter->period_bytes = frames_to_bytes(runtime, runtime->period_size);
+	if (runtime->access == SNDRV_PCM_ACCESS_RW_NONINTERLEAVED ||
+	    runtime->access == SNDRV_PCM_ACCESS_MMAP_NONINTERLEAVED) {
+		v_iter->chan_block = runtime->dma_bytes / runtime->channels;
+		v_iter->interleaved = false;
+	} else {
+		v_iter->interleaved = true;
+	}
+	// We want to record RATE * ch_cnt samples per sec, it is rate * sample_bytes * ch_cnt bytes
+	v_iter->b_rw = runtime->rate * runtime->sample_bits / 8 / TIMER_PER_SEC * runtime->channels;
+
+	return 0;
+}
+
+static snd_pcm_uframes_t snd_pcmtst_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct pcmtst_buf_iter *v_iter = substream->runtime->private_data;
+
+	return bytes_to_frames(substream->runtime, v_iter->buf_pos);
+}
+
+static int snd_pcmtst_free(struct pcmtst *pcmtst)
+{
+	if (!pcmtst)
+		return 0;
+	kfree(pcmtst);
+	return 0;
+}
+
+// These callbacks are required, but empty - all freeing occurs in pdev_remove
+static int snd_pcmtst_dev_free(struct snd_device *device)
+{
+	return 0;
+}
+
+static void pcmtst_pdev_release(struct device *dev)
+{
+}
+
+static int snd_pcmtst_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	if (inject_prepare_err)
+		return -EINVAL;
+	return 0;
+}
+
+static int snd_pcmtst_pcm_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params)
+{
+	if (inject_hwpars_err)
+		return -EBUSY;
+	return 0;
+}
+
+static int snd_pcmtst_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static int snd_pcmtst_ioctl(struct snd_pcm_substream *substream, unsigned int cmd, void *arg)
+{
+	switch (cmd) {
+	case SNDRV_PCM_IOCTL1_RESET:
+		ioctl_reset_test = 1;
+		break;
+	}
+	return snd_pcm_lib_ioctl(substream, cmd, arg);
+}
+
+static const struct snd_pcm_ops snd_pcmtst_playback_ops = {
+	.open =		snd_pcmtst_pcm_open,
+	.close =	snd_pcmtst_pcm_close,
+	.trigger =	snd_pcmtst_pcm_trigger,
+	.hw_params =	snd_pcmtst_pcm_hw_params,
+	.ioctl =	snd_pcmtst_ioctl,
+	.hw_free =	snd_pcmtst_pcm_hw_free,
+	.prepare =	snd_pcmtst_pcm_prepare,
+	.pointer =	snd_pcmtst_pcm_pointer,
+};
+
+static const struct snd_pcm_ops snd_pcmtst_capture_ops = {
+	.open =		snd_pcmtst_pcm_open,
+	.close =	snd_pcmtst_pcm_close,
+	.trigger =	snd_pcmtst_pcm_trigger,
+	.hw_params =	snd_pcmtst_pcm_hw_params,
+	.hw_free =	snd_pcmtst_pcm_hw_free,
+	.ioctl =	snd_pcmtst_ioctl,
+	.prepare =	snd_pcmtst_pcm_prepare,
+	.pointer =	snd_pcmtst_pcm_pointer,
+};
+
+static int snd_pcmtst_new_pcm(struct pcmtst *pcmtst)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	err = snd_pcm_new(pcmtst->card, "PCMTest", 0, PLAYBACK_SUBSTREAM_CNT,
+			  CAPTURE_SUBSTREAM_CNT, &pcm);
+	if (err < 0)
+		return err;
+	pcm->private_data = pcmtst;
+	strcpy(pcm->name, "PCMTest");
+	pcmtst->pcm = pcm;
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_pcmtst_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_pcmtst_capture_ops);
+
+	err = snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV, &pcmtst->pdev->dev,
+					     0, 128 * 1024);
+	return err;
+}
+
+static int snd_pcmtst_create(struct snd_card *card, struct platform_device *pdev,
+			     struct pcmtst **r_pcmtst)
+{
+	struct pcmtst *pcmtst;
+	int err;
+	static const struct snd_device_ops ops = {
+		.dev_free = snd_pcmtst_dev_free,
+	};
+
+	pcmtst = kzalloc(sizeof(*pcmtst), GFP_KERNEL);
+	if (!pcmtst)
+		return -ENOMEM;
+	pcmtst->card = card;
+	pcmtst->pdev = pdev;
+
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, pcmtst, &ops);
+	if (err < 0)
+		goto _err_free_chip;
+
+	err = snd_pcmtst_new_pcm(pcmtst);
+	if (err < 0)
+		goto _err_free_chip;
+
+	*r_pcmtst = pcmtst;
+	return 0;
+
+_err_free_chip:
+	snd_pcmtst_free(pcmtst);
+	return err;
+}
+
+static int pcmtst_probe(struct platform_device *pdev)
+{
+	struct snd_card *card;
+	int err;
+
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (err)
+		return err;
+
+	err = snd_devm_card_new(&pdev->dev, index, id, THIS_MODULE, 0, &card);
+	if (err < 0)
+		return err;
+	err = snd_pcmtst_create(card, pdev, &pcmtst);
+	if (err < 0)
+		return err;
+
+	strcpy(card->driver, "PCM-TEST Driver");
+	strcpy(card->shortname, "PCM-Test");
+	strcpy(card->longname, "PCM-Test virtual driver");
+
+	err = snd_card_register(card);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int pdev_remove(struct platform_device *dev)
+{
+	snd_pcmtst_free(pcmtst);
+	return 0;
+}
+
+static struct platform_device pcmtst_pdev = {
+	.name =		"pcmtest",
+	.dev.release =	pcmtst_pdev_release,
+};
+
+static struct platform_driver pcmtst_pdrv = {
+	.probe =	pcmtst_probe,
+	.remove =	pdev_remove,
+	.driver =	{
+		.name = "pcmtest",
+	},
+};
+
+static ssize_t pattern_write(struct file *file, const char __user *buff, size_t len, loff_t *off)
+{
+	ssize_t to_write = len;
+
+	if (*off + to_write > MAX_PATTERN_LEN)
+		to_write = MAX_PATTERN_LEN - *off;
+
+	// Crop silently everything over the buffer
+	if (to_write <= 0)
+		return len;
+
+	if (copy_from_user(fill_pattern + *off, buff, to_write))
+		return -EFAULT;
+	pattern_len = *off + to_write;
+	*off += to_write;
+
+	return to_write;
+}
+
+static ssize_t pattern_read(struct file *file, char __user *buff, size_t len, loff_t *off)
+{
+	ssize_t to_read = len;
+
+	if (*off + to_read >= MAX_PATTERN_LEN)
+		to_read = MAX_PATTERN_LEN - *off;
+	if (to_read <= 0)
+		return 0;
+
+	if (copy_to_user(buff, fill_pattern + *off, to_read))
+		to_read = 0;
+	else
+		*off += to_read;
+
+	return to_read;
+}
+
+static const struct file_operations fill_pattern_fops = {
+	.read = pattern_read,
+	.write = pattern_write,
+};
+
+static int init_debug_files(void)
+{
+	driver_debug_dir = debugfs_create_dir("pcmtest", NULL);
+	if (IS_ERR(driver_debug_dir))
+		return PTR_ERR(driver_debug_dir);
+	debugfs_create_u8("pc_test", 0444, driver_debug_dir, &playback_capture_test);
+	debugfs_create_u32("pattern_len", 0444, driver_debug_dir, &pattern_len);
+	debugfs_create_u8("ioctl_test", 0444, driver_debug_dir, &ioctl_reset_test);
+	debugfs_create_file("fill_pattern", 0600, driver_debug_dir, NULL, &fill_pattern_fops);
+
+	return 0;
+}
+
+static void clear_debug_files(void)
+{
+	debugfs_remove_recursive(driver_debug_dir);
+}
+
+static int __init mod_init(void)
+{
+	int err = 0;
+
+	err = init_debug_files();
+	if (err)
+		return err;
+	err = platform_device_register(&pcmtst_pdev);
+	if (err)
+		return err;
+	err = platform_driver_register(&pcmtst_pdrv);
+	if (err)
+		platform_device_unregister(&pcmtst_pdev);
+	return err;
+}
+
+static void __exit mod_exit(void)
+{
+	clear_debug_files();
+
+	platform_driver_unregister(&pcmtst_pdrv);
+	platform_device_unregister(&pcmtst_pdev);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ivan Orlov");
+module_init(mod_init);
+module_exit(mod_exit);
-- 
2.34.1

