Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1012970199E
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 May 2023 22:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjEMUVV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 May 2023 16:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEMUVU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 May 2023 16:21:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF62F26B5;
        Sat, 13 May 2023 13:21:17 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bcd46bf47so2562316a12.0;
        Sat, 13 May 2023 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684009276; x=1686601276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7vo6BvW2H1vdB7sMH0xHmduoG7LKDTk7q43+7gCjYM=;
        b=QsOK8sM1+RcCQPn/F+LeLnhD2jkarLmEL8vto4eeeg5vJc5g2NhEpuvfC0ZP60VOAM
         gtSV+xeiMO5WYN1Jet6h3LhASDIwK3L3toK+dKlVcfNHOxvMmr9pfzSTHN/Vj/MK4GfH
         TlpodxL/3sx6Tz/eBwGarMWWu3scLpqedLcf4ibX4WEn2m6ZgEPKQbKH218/w/vV98X5
         ktZAwaKB39/duWH50VbB+V3saawtmBGKOjRUb/Xb5lG8rWrFcoME6XPPXaRFyB4MN0pk
         NCqk24lI6kl5SSS997iHIAdDfMmwNf3ihWyC+1iPmj+LdzXr+6SC2jFM5imCzGdz0o4r
         tzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684009276; x=1686601276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7vo6BvW2H1vdB7sMH0xHmduoG7LKDTk7q43+7gCjYM=;
        b=ZNjJagYQSW95eegMAmVikaaxHkQapH23EhMt77TuZddap61NUPUqpeH+0CEYX8G817
         Rdw7hNaG+JeuxMjJSouWcyAYnA/Z/yNaOfC8aci2wKuvNMqornUOIvO1DWZq3eH/swId
         WgD6ZdbVbcpizZYAKrCDHWQX035cpoY0wDdLOMZXrJxi3e9FeADgSQPYwAsutf5ARr94
         iTtiL6SMSfs5b/DZexYf5oEegr+IQlub3TRw9CVMEfmw2UnJRQfHgjm6UCZ5nkWk0BXg
         lOW2zREvIsFLt5TSZqyytcwmjYctm3A9ICQw2GSm6zh7dTI4NYqBZHQRuH0niSxC0dW5
         YXDA==
X-Gm-Message-State: AC+VfDysNw9U3nwZjU+6cCKzk4zPO15DAJFs9tToZ45laEzNei68DrLA
        dl9vrjbwa0BUPzODCn6FzGI=
X-Google-Smtp-Source: ACHHUZ5hid9I++hBx0EwKI6R2injk6s4YAQ2g6slhk/csvD/qpe6PMhL33RI0WDCORk/E8+PeNv6dA==
X-Received: by 2002:a05:6402:510c:b0:50d:a9bb:356c with SMTP id m12-20020a056402510c00b0050da9bb356cmr18973011edd.0.1684009275640;
        Sat, 13 May 2023 13:21:15 -0700 (PDT)
Received: from ivan-B550MH.. ([37.252.94.55])
        by smtp.gmail.com with ESMTPSA id d14-20020a50fb0e000000b0050bc6d0e880sm5109637edq.61.2023.05.13.13.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 13:21:15 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     corbet@lwn.net, akpm@linux-foundation.org, perex@perex.cz,
        tiwai@suse.com, broonie@kernel.org, skhan@linuxfoundation.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org, gregkh@linuxfoundation.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 2/3] ALSA: Implement the new virtual driver
Date:   Sun, 14 May 2023 00:20:36 +0400
Message-Id: <20230513202037.158777-2-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230513202037.158777-1-ivan.orlov0322@gmail.com>
References: <20230513202037.158777-1-ivan.orlov0322@gmail.com>
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

We have a lot of different virtual media drivers, which can be used for
testing of the userspace applications and media subsystem middle layer.
However, all of them are aimed at testing the video functionality and
simulating the video devices. For audio devices we have only snd-dummy
module, which is good in simulating the correct behavior of an ALSA device.
I decided to write a tool, which would help to test the userspace ALSA
programs (and the PCM middle layer as well) under unusual circumstances
to figure out how they would behave. So I came up with this Virtual ALSA
Driver.

This new Virtual ALSA Driver has several features which can be useful
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

Pattern-based capture stream data generation works in the following way:
user can set the pattern by writing to the 'fill_pattern' debugfs file.
After that, the capture stream in case of reading will be filled with this
pattern (for example, if the pattern is 'abc', the capture stream will
contain 'abcabcabc...'). The pattern itself can be up to 4096 bytes long.

After all, I think this driver would be a good start, and I believe in the
future we will see more virtual sound drivers.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 MAINTAINERS            |   7 +
 sound/drivers/Kconfig  |  15 ++
 sound/drivers/Makefile |   2 +
 sound/drivers/valsa.c  | 508 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 532 insertions(+)
 create mode 100644 sound/drivers/valsa.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..6dcb09d5f3d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22411,6 +22411,13 @@ S:	Maintained
 F:	drivers/nvdimm/virtio_pmem.c
 F:	drivers/nvdimm/nd_virtio.c
 
+VIRTUAL ALSA DRIVER
+M:	Ivan Orlov <ivan.orlov0322@gmail.com>
+S:	Maintained
+F:	Documentation/admin-guide/valsa.rst
+F:	sound/drivers/valsa.c
+F:	tools/testing/selftests/alsa/valsa-test.sh
+
 VIRTUAL BOX GUEST DEVICE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 M:	Arnd Bergmann <arnd@arndb.de>
diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index be3009746f3a..fa7d6f22ff06 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -109,6 +109,21 @@ config SND_ALOOP
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-aloop.
 
+config SND_VALSA
+	tristate "Virtual ALSA driver"
+	select SND_PCM
+	help
+	  Say 'Y' or 'M' to include support for the Virtual ALSA driver. This
+	  driver is aimed at extended testing of the userspace applications
+	  which use the ALSA API, as well as the ALSA middle layer testing.
+
+	  It can generate random or pattern-based data into the capture stream,
+	  check the playback stream for containing the selected pattern, inject
+	  time delays during capture/playback, inject errors into the PCM
+	  callbacks, redefine the RESET ioctl operation to perform the PCM middle
+	  layer testing and inject errors during the PCM callbacks. You can find
+	  the corresponding selftest in the 'alsa' selftests folder.
+
 config SND_VIRMIDI
 	tristate "Virtual MIDI soundcard"
 	depends on SND_SEQUENCER
diff --git a/sound/drivers/Makefile b/sound/drivers/Makefile
index b60303180a1b..229eeb788995 100644
--- a/sound/drivers/Makefile
+++ b/sound/drivers/Makefile
@@ -8,6 +8,7 @@ snd-dummy-objs := dummy.o
 snd-aloop-objs := aloop.o
 snd-mtpav-objs := mtpav.o
 snd-mts64-objs := mts64.o
+snd-valsa-objs := valsa.o
 snd-portman2x4-objs := portman2x4.o
 snd-serial-u16550-objs := serial-u16550.o
 snd-serial-generic-objs := serial-generic.o
@@ -17,6 +18,7 @@ snd-virmidi-objs := virmidi.o
 obj-$(CONFIG_SND_DUMMY) += snd-dummy.o
 obj-$(CONFIG_SND_ALOOP) += snd-aloop.o
 obj-$(CONFIG_SND_VIRMIDI) += snd-virmidi.o
+obj-$(CONFIG_SND_VALSA) += snd-valsa.o
 obj-$(CONFIG_SND_SERIAL_U16550) += snd-serial-u16550.o
 obj-$(CONFIG_SND_SERIAL_GENERIC) += snd-serial-generic.o
 obj-$(CONFIG_SND_MTPAV) += snd-mtpav.o
diff --git a/sound/drivers/valsa.c b/sound/drivers/valsa.c
new file mode 100644
index 000000000000..62f05271cbad
--- /dev/null
+++ b/sound/drivers/valsa.c
@@ -0,0 +1,508 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ALSA virtual driver
+ *
+ * Copyright 2023 Ivan Orlov <ivan.orlov0322@gmail.com>
+ *
+ * This is a simple virtual ALSA driver, which can be used for audio applications/ALSA middle layer
+ * testing or fuzzing.
+ * It can:
+ *	- Simulate 'playback' and 'capture' actions
+ *	- Generate random or pattern-based capture data
+ *	- Check playback buffer for containing looped template, and notify about the results
+ *	through the debugfs entry
+ *	- Inject delays into the playback and capturing processes. See 'inject_delay' parameter.
+ *	- Inject errors during the PCM callbacks.
+ *	- Register custom RESET ioctl and notify when it is called through the debugfs entry
+ *
+ * The driver supports framerates from 8 kHz to 48 kHz. At the moment, only one substream
+ * is supported.
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
+#define DEVNAME "valsad"
+#define CARD_NAME "virtualcard"
+#define TIMER_PER_SEC 5
+#define TIMER_INTERVAL (HZ / TIMER_PER_SEC)
+#define DELAY_JIFFIES HZ
+
+#define FILL_MODE_RAND	0
+#define FILL_MODE_PAT	1
+
+#define MAX_PATTERN_LEN 4096
+
+static int index = -1;
+static char *id = "valsa";
+static bool enable = true;
+static int inject_delay;
+static bool inject_hwpars_err;
+static bool inject_prepare_err;
+static bool inject_trigger_err;
+
+static short fill_mode = FILL_MODE_PAT;
+static char fill_pattern[MAX_PATTERN_LEN] = "abacaba";
+static ssize_t pattern_len = 7;
+static struct timer_list timer;
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
+struct valsa {
+	struct snd_pcm_substream *substream;
+	struct snd_pcm *pcm;
+	size_t buf_pos;
+	size_t period_pos;
+	size_t b_rw;
+	bool is_buf_corrupted;
+	size_t period_bytes;
+	size_t total_bytes;
+	struct platform_device *pdev;
+	struct snd_card *card;
+};
+
+static struct valsa *valsa;
+
+static struct snd_pcm_hardware snd_valsa_hw = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED |
+		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP_VALID),
+	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_8000_48000,
+	.rate_min =		8000,
+	.rate_max =		48000,
+	.channels_min =		1,
+	.channels_max =		2,
+	.buffer_bytes_max =	32768,
+	.period_bytes_min =	4096,
+	.period_bytes_max =	32768,
+	.periods_min =		1,
+	.periods_max =		1024,
+};
+
+static inline void inc_buf_pos(size_t by, size_t bytes)
+{
+	valsa->total_bytes += by;
+	valsa->buf_pos += by;
+	valsa->buf_pos %= bytes;
+}
+
+/*
+ * Check one block of the buffer. Here we iterate the buffer until we find '0'. This condition is
+ * necessary because we need to detect when the reading/writing ends, so we assume that the pattern
+ * doesn't contain zeros.
+ */
+static void check_buf_block(struct valsa *valsa, struct snd_pcm_runtime *runtime)
+{
+	size_t i;
+	u8 current_byte;
+
+	for (i = 0; i < valsa->b_rw; i++) {
+		current_byte = runtime->dma_area[valsa->buf_pos];
+		if (!current_byte)
+			break;
+		if (current_byte != fill_pattern[valsa->total_bytes % pattern_len]) {
+			valsa->is_buf_corrupted = true;
+			break;
+		}
+		inc_buf_pos(1, runtime->dma_bytes);
+	}
+	inc_buf_pos(valsa->b_rw - i, runtime->dma_bytes);
+}
+
+static void fill_block_pattern(struct valsa *valsa, struct snd_pcm_runtime *runtime)
+{
+	size_t i;
+
+	for (i = 0; i < valsa->b_rw; i++) {
+		runtime->dma_area[valsa->buf_pos] = fill_pattern[valsa->total_bytes % pattern_len];
+		inc_buf_pos(1, runtime->dma_bytes);
+	}
+}
+
+static void fill_block_random(struct valsa *valsa, struct snd_pcm_runtime *runtime)
+{
+	size_t in_cur_block = runtime->dma_bytes - valsa->buf_pos;
+
+	if (valsa->b_rw <= in_cur_block) {
+		get_random_bytes(&runtime->dma_area[valsa->buf_pos], valsa->b_rw);
+	} else {
+		get_random_bytes(&runtime->dma_area[valsa->buf_pos], in_cur_block);
+		get_random_bytes(runtime->dma_area, valsa->b_rw - in_cur_block);
+	}
+	inc_buf_pos(valsa->b_rw, runtime->dma_bytes);
+}
+
+static void fill_block(struct valsa *valsa, struct snd_pcm_runtime *runtime)
+{
+	switch (fill_mode) {
+	case FILL_MODE_RAND:
+		fill_block_random(valsa, runtime);
+		break;
+	case FILL_MODE_PAT:
+		fill_block_pattern(valsa, runtime);
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
+	struct snd_pcm_runtime *runtime;
+
+	if (!valsa->substream)
+		return;
+	runtime = valsa->substream->runtime;
+
+	if (valsa->substream->stream == SNDRV_PCM_STREAM_PLAYBACK && !valsa->is_buf_corrupted)
+		check_buf_block(valsa, runtime);
+	else if (valsa->substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		fill_block(valsa, runtime);
+	else
+		inc_buf_pos(valsa->b_rw, runtime->dma_bytes);
+
+	valsa->period_pos += valsa->b_rw;
+	if (valsa->period_pos >= valsa->period_bytes) {
+		valsa->period_pos %= valsa->period_bytes;
+		snd_pcm_period_elapsed(valsa->substream);
+	}
+
+	mod_timer(&timer, jiffies + TIMER_INTERVAL + inject_delay);
+}
+
+static int snd_valsa_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct valsa *valsa = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw = snd_valsa_hw;
+	valsa->substream = substream;
+	valsa->buf_pos = 0;
+	valsa->is_buf_corrupted = false;
+	valsa->period_pos = 0;
+	valsa->total_bytes = 0;
+
+	playback_capture_test = 0;
+	ioctl_reset_test = 0;
+
+	timer_shutdown_sync(&timer);
+	timer_setup(&timer, timer_timeout, 0);
+	mod_timer(&timer, jiffies + TIMER_INTERVAL);
+	return 0;
+}
+
+static int snd_valsa_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct valsa *valsa = snd_pcm_substream_chip(substream);
+
+	timer_shutdown_sync(&timer);
+	valsa->substream = NULL;
+	playback_capture_test = !valsa->is_buf_corrupted;
+	return 0;
+}
+
+static int snd_valsa_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	if (inject_trigger_err)
+		return -EINVAL;
+
+	valsa->period_bytes = frames_to_bytes(runtime, runtime->period_size);
+	// We want to record RATE samples per sec, it is rate * sample_bytes bytes
+	valsa->b_rw = runtime->rate * runtime->sample_bits / 8 / TIMER_PER_SEC;
+	return 0;
+}
+
+static snd_pcm_uframes_t snd_valsa_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	return bytes_to_frames(substream->runtime, valsa->buf_pos);
+}
+
+static int snd_valsa_free(struct valsa *valsa)
+{
+	if (!valsa)
+		return 0;
+	kfree(valsa);
+	return 0;
+}
+
+// These callbacks are required, but empty - all freeing occurs in pdev_remove
+static int snd_valsa_dev_free(struct snd_device *device)
+{
+	return 0;
+}
+
+static void valsa_pdev_release(struct device *dev)
+{
+}
+
+static int snd_valsa_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	if (inject_prepare_err)
+		return -EINVAL;
+	return 0;
+}
+
+static int snd_valsa_pcm_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	if (inject_hwpars_err)
+		return -EBUSY;
+	return 0;
+}
+
+static int snd_valsa_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static int snd_valsa_ioctl(struct snd_pcm_substream *substream, unsigned int cmd, void *arg)
+{
+	switch (cmd) {
+	case SNDRV_PCM_IOCTL1_RESET:
+		ioctl_reset_test = 1;
+		break;
+	}
+	return snd_pcm_lib_ioctl(substream, cmd, arg);
+}
+
+static const struct snd_pcm_ops snd_valsa_playback_ops = {
+	.open =		snd_valsa_pcm_open,
+	.close =	snd_valsa_pcm_close,
+	.trigger =	snd_valsa_pcm_trigger,
+	.hw_params =	snd_valsa_pcm_hw_params,
+	.ioctl =	snd_valsa_ioctl,
+	.hw_free =	snd_valsa_pcm_hw_free,
+	.prepare =	snd_valsa_pcm_prepare,
+	.pointer =	snd_valsa_pcm_pointer,
+};
+
+static const struct snd_pcm_ops snd_valsa_capture_ops = {
+	.open =		snd_valsa_pcm_open,
+	.close =	snd_valsa_pcm_close,
+	.trigger =	snd_valsa_pcm_trigger,
+	.hw_params =	snd_valsa_pcm_hw_params,
+	.hw_free =	snd_valsa_pcm_hw_free,
+	.ioctl =	snd_valsa_ioctl,
+	.prepare =	snd_valsa_pcm_prepare,
+	.pointer =	snd_valsa_pcm_pointer,
+};
+
+static int snd_valsa_new_pcm(struct valsa *valsa)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	err = snd_pcm_new(valsa->card, "VirtualAlsa", 0, 1, 1, &pcm);
+	if (err < 0)
+		return err;
+	pcm->private_data = valsa;
+	strcpy(pcm->name, "VirtualAlsa");
+	valsa->pcm = pcm;
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_valsa_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_valsa_capture_ops);
+
+	err = snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV, &valsa->pdev->dev,
+					     64 * 1024, 64 * 1024);
+	return err;
+}
+
+static int snd_valsa_create(struct snd_card *card, struct platform_device *pdev,
+			    struct valsa **r_valsa)
+{
+	struct valsa *valsa;
+	int err;
+	static const struct snd_device_ops ops = {
+		.dev_free = snd_valsa_dev_free,
+	};
+
+	valsa = kzalloc(sizeof(*valsa), GFP_KERNEL);
+	if (!valsa)
+		return -ENOMEM;
+	valsa->card = card;
+	valsa->pdev = pdev;
+	valsa->buf_pos = 0;
+	valsa->period_pos = 0;
+
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, valsa, &ops);
+	if (err < 0)
+		goto _err_free_chip;
+
+	err = snd_valsa_new_pcm(valsa);
+	if (err < 0)
+		goto _err_free_chip;
+
+	*r_valsa = valsa;
+	return 0;
+
+_err_free_chip:
+	snd_valsa_free(valsa);
+	return err;
+}
+
+static int valsa_probe(struct platform_device *pdev)
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
+	err = snd_valsa_create(card, pdev, &valsa);
+	if (err < 0)
+		return err;
+
+	strcpy(card->driver, "VirtualALSA");
+	strcpy(card->shortname, "VirtualALSA");
+	strcpy(card->longname, "Virtual ALSA card");
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
+	snd_valsa_free(valsa);
+	return 0;
+}
+
+static struct platform_device valsa_pdev = {
+	.name =		"valsa",
+	.dev.release =	valsa_pdev_release,
+};
+
+static struct platform_driver valsa_pdrv = {
+	.probe =	valsa_probe,
+	.remove =	pdev_remove,
+	.driver =	{
+		.name = "valsa",
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
+	driver_debug_dir = debugfs_create_dir("valsa", NULL);
+	if (IS_ERR(driver_debug_dir))
+		return PTR_ERR(driver_debug_dir);
+	debugfs_create_u8("pc_test", 0444, driver_debug_dir, &playback_capture_test);
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
+	err = platform_device_register(&valsa_pdev);
+	if (err)
+		return err;
+	err = platform_driver_register(&valsa_pdrv);
+	if (err)
+		platform_device_unregister(&valsa_pdev);
+	return err;
+}
+
+static void __exit mod_exit(void)
+{
+	clear_debug_files();
+
+	platform_driver_unregister(&valsa_pdrv);
+	platform_device_unregister(&valsa_pdev);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ivan Orlov");
+module_init(mod_init);
+module_exit(mod_exit);
-- 
2.34.1

