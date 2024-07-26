Return-Path: <linux-kselftest+bounces-14259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF57E93CF08
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 09:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1401CB23500
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 07:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AFD178362;
	Fri, 26 Jul 2024 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpyqBd0U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067F17798F;
	Fri, 26 Jul 2024 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980121; cv=none; b=ZZ7FN8daYo5xNgbihIEB31g0+VNGbemjBPw0Ji9kTGQSM3ZQFCKip8nSGpFYU6D8YMWtcyJh9sJG5ViL2yPUVuVdoAjnoKz5pQ/qMPtYFiDUrwlFGRY5ZfHIsiSyTQxvmVnIJ8X+ZBpJCD6Qvl/9vZbBaohxqglXmagK+uZI59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980121; c=relaxed/simple;
	bh=J9FeETbiYz+R2KKHgItwezLUc2C5GbIPQT6+lobOoeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANTxO3heGrI8Ka6PaJl45p2dhahlnRTN7Y4W4M+kLS2ejHVywTkllocG28JZ9RMhoap7jRaww09+zXerh5/3/U27zl7RVIVTvEbmqSv3il89D9GrlwXtj89NAqtgN4KTASyvOE5hH2QCoL5E3ZbakwyVE9vtD45Rb8aDqSDGaDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpyqBd0U; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42803adb420so1935195e9.2;
        Fri, 26 Jul 2024 00:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721980118; x=1722584918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWNyK7TFqpMhl65pxENZEHKJLP9zS5hMQv5wykzr7PA=;
        b=PpyqBd0U8gvSvLMD8iXCZkBKBUlOW8eggSx3l9ruMfdSiNQ0JHGfYj5SjGEvq6XO2b
         HyMlM306j3VYpAQuIRlkI6PT6vePpRTw3qU+YUA+HLm0u/El8quggY1gYJM4GBWuPlZa
         agsy05RkbaKunIWgxyBUGas1OZkicbrXfgFNJysAM4nMw14yQ3HkynEtGa1DyIslDUwr
         ughOcBrZtOZDFS9Bc+KEXOLyyF55XcLPtp9u8ko06gXZayhMnDriY0dpU4uAopQ9aXsV
         kQuXIPyRgYpyNxHJyF6JVRRpcWEe9g8iDvU1eeW+UXEUZpcTP3PCNpTpp6gdk1zpKh7j
         lb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721980118; x=1722584918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWNyK7TFqpMhl65pxENZEHKJLP9zS5hMQv5wykzr7PA=;
        b=YdS6bHNeuxQuvZJpBk06jYRWLmEKZFCu3fsKQQFXPP4b79vy/I9QCQqo2Hsb8mSwNv
         TRRogXSV04GIo9WfLJik7bK3LLHdAXFpDVYSbn1jVQ4DL2PInmF1VlQjDyahUKe4KXhb
         Cu2Xfnd0lG82ruiJKA5dlosCb84+T0JA9LoU6RWnrpkekGgD05DLAPX3sndXe97u8bVy
         IAPv10YR0NeOe+CxNTiUMrjcF5E8omj7tWfTJoETrMgBjOgTJFU4zqAIH8QDPyyQiDam
         qLVU7gEcu2ug35tMekEBeevdCPrvIsPuBHtTqnwOpddoF5YplVpRp3Xzxmb47DbhT6TV
         uZFw==
X-Forwarded-Encrypted: i=1; AJvYcCXncb2EkU3zi+wovcOo0QDRrYerq8eBt4A8MIzS+hKvAZRl3psw5B/3iIPftP7UMaYGMGXnc4KToTcf/SKgLJgPfA4zZo7pNmBHfOWA4Aq0GTw1dK5WOwOC+4jVRT8vO5li1HtBgSmuY023IiulfPkT++oiL5HOcoyJQ8S87fgOPHrKzDrk7zOdgL/6mk67JC5SH4LPT8IgfYoNJMFgGXVUuLnwk1g=
X-Gm-Message-State: AOJu0YxMK5WosmB6ZyBA0O7WvhoDK6UJR/YHBho3lvhtEbkKMCxyjQsa
	DppoKMEEYRsF4fvEMqj7d+PbuLiN1lEk5M75IZk0au64/zHFxIEn
X-Google-Smtp-Source: AGHT+IHJwuaJ6Ozk3wmGblgFKGrzQdEz6rLVRXwRCGzxq1EZ3dEH7DkM2tcBlBahUQAxshS/X15vkQ==
X-Received: by 2002:a05:600c:3c89:b0:426:6ea6:383d with SMTP id 5b1f17b1804b1-4280543f1c8mr19906585e9.2.1721980118005;
        Fri, 26 Jul 2024 00:48:38 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:68e5:11ce:4d88:9958])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a6368sm66045565e9.38.2024.07.26.00.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:48:37 -0700 (PDT)
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
	aholzinger@gmx.de
Subject: [PATCH 3/4] ALSA: timer: Introduce virtual userspace-driven timers
Date: Fri, 26 Jul 2024 08:47:48 +0100
Message-Id: <20240726074750.626671-4-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726074750.626671-1-ivan.orlov0322@gmail.com>
References: <20240726074750.626671-1-ivan.orlov0322@gmail.com>
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
 include/uapi/sound/asound.h |  17 +++
 sound/core/Kconfig          |  11 ++
 sound/core/timer.c          | 226 ++++++++++++++++++++++++++++++++++++
 3 files changed, 254 insertions(+)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 8bf7e8a0eb6f..ade952a54edd 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -894,6 +894,7 @@ enum {
 #define SNDRV_TIMER_GLOBAL_RTC		1	/* unused */
 #define SNDRV_TIMER_GLOBAL_HPET		2
 #define SNDRV_TIMER_GLOBAL_HRTIMER	3
+#define SNDRV_TIMER_GLOBAL_UDRIVEN	4
 
 /* info flags */
 #define SNDRV_TIMER_FLG_SLAVE		(1<<0)	/* cannot be controlled */
@@ -974,6 +975,20 @@ struct snd_timer_status {
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
+	snd_pcm_uframes_t frame_rate;
+	snd_pcm_uframes_t period_size;
+	unsigned int id;
+};
+
 #define SNDRV_TIMER_IOCTL_PVERSION	_IOR('T', 0x00, int)
 #define SNDRV_TIMER_IOCTL_NEXT_DEVICE	_IOWR('T', 0x01, struct snd_timer_id)
 #define SNDRV_TIMER_IOCTL_TREAD_OLD	_IOW('T', 0x02, int)
@@ -990,6 +1005,8 @@ struct snd_timer_status {
 #define SNDRV_TIMER_IOCTL_CONTINUE	_IO('T', 0xa2)
 #define SNDRV_TIMER_IOCTL_PAUSE		_IO('T', 0xa3)
 #define SNDRV_TIMER_IOCTL_TREAD64	_IOW('T', 0xa4, int)
+#define SNDRV_TIMER_IOCTL_CREATE	_IOWR('T', 0xa5, struct snd_utimer_info)
+#define SNDRV_TIMER_IOCTL_TRIGGER	_IO('T', 0xa6)
 
 #if __BITS_PER_LONG == 64
 #define SNDRV_TIMER_IOCTL_TREAD SNDRV_TIMER_IOCTL_TREAD_OLD
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index b970a1734647..3cf82641fc67 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -251,6 +251,17 @@ config SND_JACK_INJECTION_DEBUG
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
+
 config SND_VMASTER
 	bool
 
diff --git a/sound/core/timer.c b/sound/core/timer.c
index d104adc75a8b..177bd06f7b60 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -13,6 +13,8 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/sched/signal.h>
+#include <linux/anon_inodes.h>
+#include <linux/units.h>
 #include <sound/core.h>
 #include <sound/timer.h>
 #include <sound/control.h>
@@ -109,6 +111,17 @@ struct snd_timer_status64 {
 	unsigned char reserved[64];	/* reserved */
 };
 
+#ifdef CONFIG_SND_UTIMER
+#define SNDRV_UTIMERS_MAX_COUNT 128
+#define SNDRV_UTIMER_NAME_LEN 20
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
@@ -2009,6 +2022,217 @@ enum {
 	SNDRV_TIMER_IOCTL_PAUSE_OLD = _IO('T', 0x23),
 };
 
+#ifdef CONFIG_SND_UTIMER
+/*
+ * Since userspace-driven timers are passed to userspace, we need to have an identifier
+ * which will allow us to use them (basically, the subdevice number of udriven timer).
+ *
+ * We have a pool of SNDRV_UTIMERS_MAX_COUNT ids from 0 to (SNDRV_UTIMERS_MAX_COUNT - 1).
+ * When we take one of them, the corresponding entry in snd_utimer_ids becomes true.
+ */
+static bool snd_utimer_ids[SNDRV_UTIMERS_MAX_COUNT];
+
+static void snd_utimer_put_id(struct snd_utimer *utimer)
+{
+	int timer_id = utimer->id;
+
+	snd_BUG_ON(timer_id < 0 || timer_id >= SNDRV_UTIMERS_MAX_COUNT);
+	snd_utimer_ids[timer_id] = false;
+}
+
+static int snd_utimer_take_id(void)
+{
+	size_t i;
+
+	for (i = 0; i < SNDRV_UTIMERS_MAX_COUNT; i++) {
+		if (!snd_utimer_ids[i]) {
+			snd_utimer_ids[i] = true;
+			return i;
+		}
+	}
+
+	return -EBUSY;
+}
+
+static void snd_utimer_free(struct snd_utimer *utimer)
+{
+	snd_timer_free(utimer->timer);
+	snd_utimer_put_id(utimer);
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
+	char *timer_name;
+
+	utimer = kzalloc(sizeof(*utimer), GFP_KERNEL);
+	if (!utimer)
+		return -ENOMEM;
+
+	timer_name = kzalloc(SNDRV_UTIMER_NAME_LEN, GFP_KERNEL);
+	if (!timer_name) {
+		kfree(utimer);
+		return -ENOMEM;
+	}
+
+	/* We hold the ioctl lock here so we won't get a race condition when allocating id */
+	utimer_id = snd_utimer_take_id();
+	if (utimer_id < 0) {
+		err = utimer_id;
+		goto err_take_id;
+	}
+
+	sprintf(timer_name, "snd-utimer%d", utimer_id);
+	utimer->name = timer_name;
+	utimer->id = utimer_id;
+
+	tid.dev_sclass = SNDRV_TIMER_SCLASS_APPLICATION;
+	tid.dev_class = SNDRV_TIMER_CLASS_GLOBAL;
+	tid.card = -1;
+	tid.device = SNDRV_TIMER_GLOBAL_UDRIVEN;
+	tid.subdevice = utimer_id;
+
+	err = snd_timer_new(NULL, timer_name, &tid, &timer);
+	if (err < 0) {
+		pr_err("Can't create userspace-driven timer\n");
+		goto err_timer_new;
+	}
+
+	timer->module = THIS_MODULE;
+	timer->hw = timer_hw;
+	timer->hw.resolution = NANO / utimer_info->frame_rate * utimer_info->period_size;
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
+	snd_utimer_put_id(utimer);
+err_take_id:
+	kfree(timer_name);
+	kfree(utimer);
+
+	return err;
+}
+
+static int snd_utimer_ioctl_create(struct file *file,
+				   struct snd_utimer_info __user *_utimer_info)
+{
+	struct snd_utimer *utimer;
+	struct snd_utimer_info *utimer_info;
+	int err;
+
+	utimer_info = memdup_user(_utimer_info, sizeof(*utimer_info));
+	if (IS_ERR(utimer_info))
+		return PTR_ERR(no_free_ptr(utimer_info));
+
+	err = snd_utimer_create(utimer_info, &utimer);
+	if (err < 0) {
+		kfree(utimer_info);
+		return err;
+	}
+
+	utimer_info->id = utimer->id;
+
+	err = copy_to_user(_utimer_info, utimer_info, sizeof(*utimer_info));
+	if (err) {
+		snd_utimer_free(utimer);
+		kfree(utimer_info);
+		return -EFAULT;
+	}
+
+	kfree(utimer_info);
+
+	return anon_inode_getfd(utimer->name, &snd_utimer_fops, utimer, O_RDWR | O_CLOEXEC);
+}
+
+#else
+
+static int snd_utimer_ioctl_create(struct file *file,
+				   struct snd_utimer_info __user *_utimer_info)
+{
+	return -EINVAL;
+}
+
+#endif
+
 static long __snd_timer_user_ioctl(struct file *file, unsigned int cmd,
 				 unsigned long arg, bool compat)
 {
@@ -2053,6 +2277,8 @@ static long __snd_timer_user_ioctl(struct file *file, unsigned int cmd,
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


