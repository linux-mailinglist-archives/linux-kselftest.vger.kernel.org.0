Return-Path: <linux-kselftest+bounces-14852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9BD948F90
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3032D1C20F08
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E591C6891;
	Tue,  6 Aug 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZdgCSM+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534931C579A;
	Tue,  6 Aug 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948775; cv=none; b=M1Ht13n6msVfbctpvWi3/hJIU1ytuFvoxwE8ky7oXrpruO6yjWIM0gguR09Q5brksMgi06JuHv0/W7w1PEodrgEmXsIkR/ahuybC5Mqwo94de0x2wCsoWjS0kwKErsj1a0xYFsGJx6sQTF1Im5DmGbZpCermr1iODzr/88RPU5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948775; c=relaxed/simple;
	bh=kZ/dS9zA6Yv25DR45SNBuMw11IO3/X2XTvC9C6KrC8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O4MljPYBGdvxttY8idCJ/DTGTmBEAjTMjkRP8M4KdrZwsbN7mkZgE4wfUW6cB0zVrGOhYJjrFa6iyVpjHRyMsScjxjUDetTiGBNBYF4y329NFtYuN8111rpjl7Lp7thvk5GKT3pV6wiHV/G2060QXHeDahO/elfGQBo8ymfkuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZdgCSM+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280692835dso711625e9.1;
        Tue, 06 Aug 2024 05:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722948771; x=1723553571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQjmlCUBejzKZiEwYpQ1B7ebPDsGm04pP5yqUdZh+5E=;
        b=QZdgCSM+U2pc5nmvrluOJcORlxHuyWL1+ri3JBXEoscBTs+q4jq86ODag9dmS4Gc7Z
         CC+I6TdFX2R7Q4If15tdoIU9SQ384sBFcK1qfV99r7WEpxgp/2cZaD7+OF785Z2N/5Yc
         u/UqJ9KkzGZHtxZL62dqarw67CQjKr++JklepSXreuOZUt168SzcIY0WPGAFkGP8L4Z2
         yWQucJugQlysJr/k6H6qqNJB67VUPURCAQbn8tR5kcoGtoFnhrlV/LMLBm+Lct/2EOkG
         sUMTppGH4gp2sy/URkwO6SptEmGSwNjuDCDo0nrcvCI/JRcjr2TEzvda9kgA5cGDUYaf
         4uLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948771; x=1723553571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQjmlCUBejzKZiEwYpQ1B7ebPDsGm04pP5yqUdZh+5E=;
        b=kKf4i6jyULPJnWfCh04Hyx/0iDRFGoboUDb2M3E1qrxZde71T1topDaV1rYwCGYZXs
         Q6Mj43cw/eG3X7+ZWsSCmMbtnHOdETvSEZIavdAlf1hMAX5xRlpBALgfN6BryeHeBfhe
         DAT3+9Kc/V9SKOnNp6x/NOFw583tg6XQ5Qg2e9RTvLQKhM9VS14EyEb78U8UvznBgoDF
         hJoEsraTCaAf83eKY+FesnXUcZLalgVL/vneTTEI06c5x+SycYrsgFKJeMPoS3Krr10n
         FZzwJIYrdnFxDaca1qEeCkAs+WYfFrs7W+OQp+piclfTB4UfGSonrbqk8jI3hF2I15w5
         TfJA==
X-Forwarded-Encrypted: i=1; AJvYcCWsfIU2Z9vXi1gYRsaGPbxhJ9yew801YaFFVWHiywKSOKS6SSnissMTuCuQg9bRBcruLDhIsQmNOT+mfDu3@vger.kernel.org, AJvYcCXUgXenIo1M827ufhc2Odl+I8ArmEqdGQ5tfuuX83rfjlmZ1+yqCQIuNWG9TsxXBeEvLDPrxrwoi/M=@vger.kernel.org, AJvYcCXZltVE4MV/qC+KHLXOMO02dLZUMKtQn0I/fLtGnZ4+yuWhDUBvQExKYBFuxLH4eVrfV2pp7Gq4uwJHTgN6ax5b@vger.kernel.org, AJvYcCXm8K8A+5i9PYgXUlliFT+rA5PgEQcxmEA2pItekozbjChrS0G/0z6gb0UVHs5/+KrlfgzQVXljYubdtg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeO7C6pqIm6LZjOHmroWDUz4T7WcXQnX2LcbVr0iJbLf+NX4Tb
	pL88Wmzi9k5cvxRak7Ch1lCfkXdHhSwFrJ4llXPji4SDZs9nFRaY
X-Google-Smtp-Source: AGHT+IGF8+5DkZ6JTcKYMnxPdk3Wd9/3E8xsogY0Z5XLzLGUf8tGaE4fyz6gguvBT7F6a6HJEsHE3w==
X-Received: by 2002:a05:600c:3592:b0:427:9f6c:e4bd with SMTP id 5b1f17b1804b1-428e6ba7ec3mr64604415e9.6.1722948771447;
        Tue, 06 Aug 2024 05:52:51 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:b50e:24fa:fd17:c835])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6d648a0sm179487255e9.10.2024.08.06.05.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:52:51 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net,
	broonie@kernel.org,
	shuah@kernel.org
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr,
	aholzinger@gmx.de
Subject: [PATCH v3 3/4] ALSA: timer: Introduce virtual userspace-driven timers
Date: Tue,  6 Aug 2024 13:52:42 +0100
Message-Id: <20240806125243.449959-4-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125243.449959-1-ivan.orlov0322@gmail.com>
References: <20240806125243.449959-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement two ioctl calls in order to support virtual userspace-driven
ALSA timers.

The first ioctl is SNDRV_TIMER_IOCTL_CREATE, which gets the
snd_utimer_info struct as a parameter and returns a file descriptor of
a virtual timer. It also updates the `id` field of the snd_utimer_info
struct, which provides a unique identifier for the timer (basically,
the subdevice number which can be used when creating timer instances).

This patch also introduces a tiny id allocator for the userspace-driven
timers, which guarantees that we don't have more than 128 of them in the
system.

Another ioctl is SNDRV_TIMER_IOCTL_TRIGGER, which allows us to trigger
the virtual timer (and calls snd_timer_interrupt for the timer under
the hood), causing all of the timer instances binded to this timer to
execute their callbacks.

The maximum amount of ticks available for the timer is 1 for the sake of
simplification of the userspace API. 'start', 'stop', 'open' and 'close'
callbacks for the userspace-driven timers are empty since we don't
really do any hardware initialization here.

Suggested-by: Axel Holzinger <aholzinger@gmx.de>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Add missing kfree for the utimer name in snd_utimer_free
- Remove extra newline in sound core Kconfig
- Use IDA allocator API to allocate utimer ids
- Use kasprintf for the timer name instead of kzalloc + sprintf
V2 -> V3:
- Use __u64 instead of snd_pcm_uframes_t in snd_utimer_info struct
- Add 16 reserved bytes to snd_utimer_info struct just in case we decide
to add some other fields to this struct
- Bump the timer protocol version in SNDRV_TIMER_VERSION to 2.0.8
- Make the 'snd_utimer_ids' variable static
- Add sanity checks to the 'snd_utimer_create' function: 0-check for
period size and frame rate, overflow and 0- checks for resolution
- Use automatic cleanup in 'snd_utimer_ioctl_create'
- Return -ENOTTY instead of -EINVAL from ioctl if userspace-driven
timers are disabled

 include/uapi/sound/asound.h |  20 +++-
 sound/core/Kconfig          |  10 ++
 sound/core/timer.c          | 221 ++++++++++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 8bf7e8a0eb6f..cdd9cf8f71c1 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -869,7 +869,7 @@ struct snd_ump_block_info {
  *  Timer section - /dev/snd/timer
  */
 
-#define SNDRV_TIMER_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 7)
+#define SNDRV_TIMER_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 8)
 
 enum {
 	SNDRV_TIMER_CLASS_NONE = -1,
@@ -894,6 +894,7 @@ enum {
 #define SNDRV_TIMER_GLOBAL_RTC		1	/* unused */
 #define SNDRV_TIMER_GLOBAL_HPET		2
 #define SNDRV_TIMER_GLOBAL_HRTIMER	3
+#define SNDRV_TIMER_GLOBAL_UDRIVEN	4
 
 /* info flags */
 #define SNDRV_TIMER_FLG_SLAVE		(1<<0)	/* cannot be controlled */
@@ -974,6 +975,21 @@ struct snd_timer_status {
 };
 #endif
 
+/*
+ * This structure describes the userspace-driven timer. Such timers are purely virtual,
+ * and can only be triggered from software (for instance, by userspace application).
+ */
+struct snd_utimer_info {
+	/*
+	 * To pretend being a normal timer, we need to know the frame rate and
+	 * the period size in frames.
+	 */
+	__u64 frame_rate;
+	__u64 period_size;
+	unsigned int id;
+	unsigned char reserved[16];
+};
+
 #define SNDRV_TIMER_IOCTL_PVERSION	_IOR('T', 0x00, int)
 #define SNDRV_TIMER_IOCTL_NEXT_DEVICE	_IOWR('T', 0x01, struct snd_timer_id)
 #define SNDRV_TIMER_IOCTL_TREAD_OLD	_IOW('T', 0x02, int)
@@ -990,6 +1006,8 @@ struct snd_timer_status {
 #define SNDRV_TIMER_IOCTL_CONTINUE	_IO('T', 0xa2)
 #define SNDRV_TIMER_IOCTL_PAUSE		_IO('T', 0xa3)
 #define SNDRV_TIMER_IOCTL_TREAD64	_IOW('T', 0xa4, int)
+#define SNDRV_TIMER_IOCTL_CREATE	_IOWR('T', 0xa5, struct snd_utimer_info)
+#define SNDRV_TIMER_IOCTL_TRIGGER	_IO('T', 0xa6)
 
 #if __BITS_PER_LONG == 64
 #define SNDRV_TIMER_IOCTL_TREAD SNDRV_TIMER_IOCTL_TREAD_OLD
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index b970a1734647..670b26cf3065 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -251,6 +251,16 @@ config SND_JACK_INJECTION_DEBUG
 	  Say Y if you are debugging via jack injection interface.
 	  If unsure select "N".
 
+config SND_UTIMER
+	bool "Enable support for userspace-controlled virtual timers"
+	depends on SND_TIMER
+	help
+	  Say Y to enable the support of userspace-controlled timers. These
+	  timers are purely virtual, and they are supposed to be triggered
+	  from userspace. They could be quite useful when synchronizing the
+	  sound timing with userspace applications (for instance, when sending
+	  data through snd-aloop).
+
 config SND_VMASTER
 	bool
 
diff --git a/sound/core/timer.c b/sound/core/timer.c
index d104adc75a8b..dabb925625f1 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -13,6 +13,9 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/sched/signal.h>
+#include <linux/anon_inodes.h>
+#include <linux/idr.h>
+#include <linux/units.h>
 #include <sound/core.h>
 #include <sound/timer.h>
 #include <sound/control.h>
@@ -109,6 +112,16 @@ struct snd_timer_status64 {
 	unsigned char reserved[64];	/* reserved */
 };
 
+#ifdef CONFIG_SND_UTIMER
+#define SNDRV_UTIMERS_MAX_COUNT 128
+/* Internal data structure for keeping the state of the userspace-driven timer */
+struct snd_utimer {
+	char *name;
+	struct snd_timer *timer;
+	unsigned int id;
+};
+#endif
+
 #define SNDRV_TIMER_IOCTL_STATUS64	_IOR('T', 0x14, struct snd_timer_status64)
 
 /* list of timers */
@@ -2009,6 +2022,212 @@ enum {
 	SNDRV_TIMER_IOCTL_PAUSE_OLD = _IO('T', 0x23),
 };
 
+#ifdef CONFIG_SND_UTIMER
+/*
+ * Since userspace-driven timers are passed to userspace, we need to have an identifier
+ * which will allow us to use them (basically, the subdevice number of udriven timer).
+ */
+static DEFINE_IDA(snd_utimer_ids);
+
+static void snd_utimer_put_id(struct snd_utimer *utimer)
+{
+	int timer_id = utimer->id;
+
+	snd_BUG_ON(timer_id < 0 || timer_id >= SNDRV_UTIMERS_MAX_COUNT);
+	ida_free(&snd_utimer_ids, timer_id);
+}
+
+static int snd_utimer_take_id(void)
+{
+	return ida_alloc_max(&snd_utimer_ids, SNDRV_UTIMERS_MAX_COUNT - 1, GFP_KERNEL);
+}
+
+static void snd_utimer_free(struct snd_utimer *utimer)
+{
+	snd_timer_free(utimer->timer);
+	snd_utimer_put_id(utimer);
+	kfree(utimer->name);
+	kfree(utimer);
+}
+
+static int snd_utimer_release(struct inode *inode, struct file *file)
+{
+	struct snd_utimer *utimer = (struct snd_utimer *)file->private_data;
+
+	snd_utimer_free(utimer);
+	return 0;
+}
+
+static int snd_utimer_trigger(struct file *file)
+{
+	struct snd_utimer *utimer = (struct snd_utimer *)file->private_data;
+
+	snd_timer_interrupt(utimer->timer, utimer->timer->sticks);
+	return 0;
+}
+
+static long snd_utimer_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
+{
+	switch (ioctl) {
+	case SNDRV_TIMER_IOCTL_TRIGGER:
+		return snd_utimer_trigger(file);
+	}
+
+	return -ENOTTY;
+}
+
+static const struct file_operations snd_utimer_fops = {
+	.llseek = noop_llseek,
+	.release = snd_utimer_release,
+	.unlocked_ioctl = snd_utimer_ioctl,
+};
+
+static int snd_utimer_start(struct snd_timer *t)
+{
+	return 0;
+}
+
+static int snd_utimer_stop(struct snd_timer *t)
+{
+	return 0;
+}
+
+static int snd_utimer_open(struct snd_timer *t)
+{
+	return 0;
+}
+
+static int snd_utimer_close(struct snd_timer *t)
+{
+	return 0;
+}
+
+static const struct snd_timer_hardware timer_hw = {
+	.flags = SNDRV_TIMER_HW_AUTO | SNDRV_TIMER_HW_WORK,
+	.open = snd_utimer_open,
+	.close = snd_utimer_close,
+	.start = snd_utimer_start,
+	.stop = snd_utimer_stop,
+};
+
+static int snd_utimer_create(struct snd_utimer_info *utimer_info,
+			     struct snd_utimer **r_utimer)
+{
+	struct snd_utimer *utimer;
+	struct snd_timer *timer;
+	struct snd_timer_id tid;
+	int utimer_id;
+	int err = 0;
+	u64 resolution;
+
+	if (!utimer_info || utimer_info->frame_rate == 0 || utimer_info->period_size == 0)
+		return -EINVAL;
+
+	/* Let's check that we won't get an overflow in the resolution */
+	if (NANO / utimer_info->frame_rate > U64_MAX / utimer_info->period_size)
+		return -EINVAL;
+
+	resolution = NANO / utimer_info->frame_rate * utimer_info->period_size;
+
+	if (resolution == 0)
+		return -EINVAL;
+
+	utimer = kzalloc(sizeof(*utimer), GFP_KERNEL);
+	if (!utimer)
+		return -ENOMEM;
+
+	/* We hold the ioctl lock here so we won't get a race condition when allocating id */
+	utimer_id = snd_utimer_take_id();
+	if (utimer_id < 0) {
+		err = utimer_id;
+		goto err_take_id;
+	}
+
+	utimer->name = kasprintf(GFP_KERNEL, "snd-utimer%d", utimer_id);
+	if (!utimer->name) {
+		err = -ENOMEM;
+		goto err_get_name;
+	}
+
+	utimer->id = utimer_id;
+
+	tid.dev_sclass = SNDRV_TIMER_SCLASS_APPLICATION;
+	tid.dev_class = SNDRV_TIMER_CLASS_GLOBAL;
+	tid.card = -1;
+	tid.device = SNDRV_TIMER_GLOBAL_UDRIVEN;
+	tid.subdevice = utimer_id;
+
+	err = snd_timer_new(NULL, utimer->name, &tid, &timer);
+	if (err < 0) {
+		pr_err("Can't create userspace-driven timer\n");
+		goto err_timer_new;
+	}
+
+	timer->module = THIS_MODULE;
+	timer->hw = timer_hw;
+	timer->hw.resolution = resolution;
+	timer->hw.ticks = 1;
+	timer->max_instances = MAX_SLAVE_INSTANCES;
+
+	utimer->timer = timer;
+
+	err = snd_timer_global_register(timer);
+	if (err < 0) {
+		pr_err("Can't register a userspace-driven timer\n");
+		goto err_timer_reg;
+	}
+
+	*r_utimer = utimer;
+	return 0;
+
+err_timer_reg:
+	snd_timer_free(timer);
+err_timer_new:
+	kfree(utimer->name);
+err_get_name:
+	snd_utimer_put_id(utimer);
+err_take_id:
+	kfree(utimer);
+
+	return err;
+}
+
+static int snd_utimer_ioctl_create(struct file *file,
+				   struct snd_utimer_info __user *_utimer_info)
+{
+	struct snd_utimer *utimer;
+	struct snd_utimer_info *utimer_info __free(kfree) = NULL;
+	int err;
+
+	utimer_info = memdup_user(_utimer_info, sizeof(*utimer_info));
+	if (IS_ERR(utimer_info))
+		return PTR_ERR(no_free_ptr(utimer_info));
+
+	err = snd_utimer_create(utimer_info, &utimer);
+	if (err < 0)
+		return err;
+
+	utimer_info->id = utimer->id;
+
+	err = copy_to_user(_utimer_info, utimer_info, sizeof(*utimer_info));
+	if (err) {
+		snd_utimer_free(utimer);
+		return -EFAULT;
+	}
+
+	return anon_inode_getfd(utimer->name, &snd_utimer_fops, utimer, O_RDWR | O_CLOEXEC);
+}
+
+#else
+
+static int snd_utimer_ioctl_create(struct file *file,
+				   struct snd_utimer_info __user *_utimer_info)
+{
+	return -ENOTTY;
+}
+
+#endif
+
 static long __snd_timer_user_ioctl(struct file *file, unsigned int cmd,
 				 unsigned long arg, bool compat)
 {
@@ -2053,6 +2272,8 @@ static long __snd_timer_user_ioctl(struct file *file, unsigned int cmd,
 	case SNDRV_TIMER_IOCTL_PAUSE:
 	case SNDRV_TIMER_IOCTL_PAUSE_OLD:
 		return snd_timer_user_pause(file);
+	case SNDRV_TIMER_IOCTL_CREATE:
+		return snd_utimer_ioctl_create(file, argp);
 	}
 	return -ENOTTY;
 }
-- 
2.34.1


