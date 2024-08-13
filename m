Return-Path: <linux-kselftest+bounces-15214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A455295047F
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 14:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264DA1F238E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97EB19AA63;
	Tue, 13 Aug 2024 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSiSPBac"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23941993BA;
	Tue, 13 Aug 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550964; cv=none; b=RdQt/ZbVq879eZCR4Y18CEsvyEzDokYLj0MFBDl6XKqep72ikGSUhiFe+jaPa2e9ZlhTL2ZqXKDRTRSdXG/T40KGhP4BbPiEHKtV/9o5XoksRw35qX5q7Lvw2oixw7lsDEPiot79xzYZjWh9Y2l7PAPbW/6ZPDajTHkaFzpt8r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550964; c=relaxed/simple;
	bh=zPOlmDyB0Iv0QO3qjZms9fPLVKRcW2RG3rpVq636pho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bKXrAHtRu41gKIQKvFh05cP4luJlFEZWO9Gpip9+JuaTnFEzQEdOwlBPmHM1Xnc05YJdBOcNyt54OSnuiUVBJCz32JMqRo5rbUxcHA3vmqFpJJg/c+Wk3aIsXq0IiF5mIizVmpUIfRguLHtM6Bre74p/tJTD4steG+k7mckg27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSiSPBac; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3684c05f7afso676714f8f.2;
        Tue, 13 Aug 2024 05:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723550961; x=1724155761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bSotfMSQCGGIsHK/cvkS8SgqeLiOHujBAkVUYHsKaQ=;
        b=dSiSPBacLck9nwonBQ/qQz7yE1sGDTE86dgGhT5PjOKwKW/v/urKOcOX2Z2r80OTV1
         +oj64OtVDhTDf6w/GDoPcP1TVkFN1i5y9QV/oR5awDzupqAYNO9tB4TiCYHnpKAAF2Se
         sCVLblG0F0K3gMpvevw1m8b3pV8WfTEGarhu1z4gXq5w94BydsdpL48zGSV08t97dOuo
         tgByPWUgEkey/SYqnKBlBGYu8L3vMvlrRwTzgQgjcrf1OzsnX41HumRiTAmmsWYUUeZk
         SJdoKgIe8Nwi65PCogyEr3gGVf+k3lHYeT82Ty7zkP5zFeK4cmZfXIe6o/8iu2X+33wi
         ut3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550961; x=1724155761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bSotfMSQCGGIsHK/cvkS8SgqeLiOHujBAkVUYHsKaQ=;
        b=lXFUwW5h0vLaBCy0UPABGenCGHpWaQvWFSoRX2eEVyJdzTceMrbD6vQFVqrkUTP5Fx
         vnIfd0naCwhVqtb3h+2PPEXb2H6DmE5DpZWoUhIMZ2VaWwhSU6t9xK9xvOegjtxsiTSm
         h2FbSoc4ACHc0Ca2ANovnb4X0DjN2Wx8n83K6zLvxMCx14v/6oXs2rYrBgW6cgsTOPbP
         qxpXISBMAe6ENPkZ8GD4fgIkSuIcyCMO11YPGj0hkVd/4MZd7sXEET2epIE2QJfDosxH
         ANP9B32t5Lw18iIwzp3P5BH+gE3tqR1HGYlPvzrwXCuxRZ/m2IWaW/UupX2qyT5g/tHC
         Z1+w==
X-Forwarded-Encrypted: i=1; AJvYcCWMx4WM7CFXVisQA/Kez+zfLtF3UWe7cITO8/mt4rEtgIxWSbIPAjeUasw7CIJLkLOgc7aMMJCcgm4rUCzr@vger.kernel.org, AJvYcCX02vpUztoFIgOVii0G04Af0g2vkjoHBy2QiyZfJjqTSvfeFqmH6u3y1w8KrBJFmY0k9kA9+vHJIFshRFqTbZMP@vger.kernel.org, AJvYcCXu42cIlevyfSOUMVken2MwfV4XgDEzlsFQywhoYZmrabFgiPqlzbgFNpH59TOIpAfWL32eqGWm4Ic=@vger.kernel.org, AJvYcCXyGybcan9XWAuBaxQxLB1ymxWhJwVkWqRPqy2GUwxEIAywAWvwmMzc8g9izPZ7jSQoPbAfHml37xiDHMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiEHTLq99OM2Z2uILmi2P94RJGnaCgwS+5F27TqQnGCvLSQEJh
	oFD5UMiXhbvLO62h65lrNsjthTtazDSWPlqPLde4MANWAQYFfLo5
X-Google-Smtp-Source: AGHT+IEEe4VF8pKijctdFjRxGWW1ScN8+RzojLgMD2C/ctKp/m79y0YyrADWgh44LSqllBM0kbYOUg==
X-Received: by 2002:a5d:64a4:0:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-37170173c4emr855545f8f.2.1723550960595;
        Tue, 13 Aug 2024 05:09:20 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:6db6:f2bf:8865:5d31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb52sm10204590f8f.74.2024.08.13.05.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:09:20 -0700 (PDT)
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
Subject: [PATCH v5 3/4] ALSA: timer: Introduce virtual userspace-driven timers
Date: Tue, 13 Aug 2024 13:07:00 +0100
Message-Id: <20240813120701.171743-4-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813120701.171743-1-ivan.orlov0322@gmail.com>
References: <20240813120701.171743-1-ivan.orlov0322@gmail.com>
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
snd_timer_uinfo struct as a parameter and puts a file descriptor of a
virtual timer into the `fd` field of the snd_timer_unfo structure. It
also updates the `id` field of the snd_timer_uinfo struct, which
provides a unique identifier for the timer (basically, the subdevice
number which can be used when creating timer instances).

This patch also introduces a tiny id allocator for the userspace-driven
timers, which guarantees that we don't have more than 128 of them in the
system.

Another ioctl is SNDRV_TIMER_IOCTL_TRIGGER, which allows us to trigger
the virtual timer (and calls snd_timer_interrupt for the timer under
the hood), causing all of the timer instances binded to this timer to
execute their callbacks.

The maximum amount of ticks available for the timer is 1 for the sake of
simplicity of the userspace API. 'start', 'stop', 'open' and 'close'
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
V3 -> V4:
- Remove pcm-specific fields (frame_rate, period_size) from the
userspace-driven ALSA timer info structure. Replace them with
a timer-specific `resolution` field
- Rename the structure to `snd_timer_uinfo`
- Remove a part of sanity checks and resolution calculation from the
timer creating function. It should be done in userspace instead
V4 -> V5:
- Add missing error processing for the anon_inode_getfd structure
- Return the timer file descriptor in one of the fields of
the snd_timer_uinfo structure instead of passing it as a return value
from ioctl. This is a more standard way of using ioctl interface, where
the return value of ioctl is either 0 or an error code.

 include/uapi/sound/asound.h |  17 ++-
 sound/core/Kconfig          |  10 ++
 sound/core/timer.c          | 225 ++++++++++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 8bf7e8a0eb6f..4cd513215bcd 100644
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
@@ -974,6 +975,18 @@ struct snd_timer_status {
 };
 #endif
 
+/*
+ * This structure describes the userspace-driven timer. Such timers are purely virtual,
+ * and can only be triggered from software (for instance, by userspace application).
+ */
+struct snd_timer_uinfo {
+	/* To pretend being a normal timer, we need to know the resolution in ns. */
+	__u64 resolution;
+	int fd;
+	unsigned int id;
+	unsigned char reserved[16];
+};
+
 #define SNDRV_TIMER_IOCTL_PVERSION	_IOR('T', 0x00, int)
 #define SNDRV_TIMER_IOCTL_NEXT_DEVICE	_IOWR('T', 0x01, struct snd_timer_id)
 #define SNDRV_TIMER_IOCTL_TREAD_OLD	_IOW('T', 0x02, int)
@@ -990,6 +1003,8 @@ struct snd_timer_status {
 #define SNDRV_TIMER_IOCTL_CONTINUE	_IO('T', 0xa2)
 #define SNDRV_TIMER_IOCTL_PAUSE		_IO('T', 0xa3)
 #define SNDRV_TIMER_IOCTL_TREAD64	_IOW('T', 0xa4, int)
+#define SNDRV_TIMER_IOCTL_CREATE	_IOWR('T', 0xa5, struct snd_timer_uinfo)
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
index d104adc75a8b..ccbed2520ac8 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -13,6 +13,8 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/sched/signal.h>
+#include <linux/anon_inodes.h>
+#include <linux/idr.h>
 #include <sound/core.h>
 #include <sound/timer.h>
 #include <sound/control.h>
@@ -109,6 +111,16 @@ struct snd_timer_status64 {
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
@@ -2009,6 +2021,217 @@ enum {
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
+static int snd_utimer_create(struct snd_timer_uinfo *utimer_info,
+			     struct snd_utimer **r_utimer)
+{
+	struct snd_utimer *utimer;
+	struct snd_timer *timer;
+	struct snd_timer_id tid;
+	int utimer_id;
+	int err = 0;
+
+	if (!utimer_info || utimer_info->resolution == 0)
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
+	timer->hw.resolution = utimer_info->resolution;
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
+				   struct snd_timer_uinfo __user *_utimer_info)
+{
+	struct snd_utimer *utimer;
+	struct snd_timer_uinfo *utimer_info __free(kfree) = NULL;
+	int err, timer_fd;
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
+	timer_fd = anon_inode_getfd(utimer->name, &snd_utimer_fops, utimer, O_RDWR | O_CLOEXEC);
+	if (timer_fd < 0) {
+		snd_utimer_free(utimer);
+		return timer_fd;
+	}
+
+	utimer_info->fd = timer_fd;
+
+	err = copy_to_user(_utimer_info, utimer_info, sizeof(*utimer_info));
+	if (err) {
+		/*
+		 * "Leak" the fd, as there is nothing we can do about it.
+		 * It might have been closed already since anon_inode_getfd
+		 * makes it available for userspace.
+		 *
+		 * We have to rely on the process exit path to do any
+		 * necessary cleanup (e.g. releasing the file).
+		 */
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+#else
+
+static int snd_utimer_ioctl_create(struct file *file,
+				   struct snd_timer_uinfo __user *_utimer_info)
+{
+	return -ENOTTY;
+}
+
+#endif
+
 static long __snd_timer_user_ioctl(struct file *file, unsigned int cmd,
 				 unsigned long arg, bool compat)
 {
@@ -2053,6 +2276,8 @@ static long __snd_timer_user_ioctl(struct file *file, unsigned int cmd,
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


