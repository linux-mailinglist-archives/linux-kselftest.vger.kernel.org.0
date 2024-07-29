Return-Path: <linux-kselftest+bounces-14366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C7E93F077
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 10:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEE71C21F62
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 08:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FC913DB92;
	Mon, 29 Jul 2024 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUcVfLmx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF513D8A2;
	Mon, 29 Jul 2024 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243572; cv=none; b=bAC72bivYx19pUjEPCLx2Cfqd/YIiFSGCemqX5z7XmkSNvKrHdCScptN4I/wcw7MlRbiHA5Zun9Uys4iDv+AJhRTjzMPl2uPps0j3Kcrv+t1+V/XgceOaWOKd/XKbvP59oBCMvhQPfFVzQGRMxV7hiehIIpPF63O98a+uQLFl6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243572; c=relaxed/simple;
	bh=1ITLH7WZTXYHLb8vO8Qu8TyaVRGYFlY83qJu+QsdetA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SwcWuxjLb0oP9SfWgJjGla4FxaYbrqquuqvi70Yr3KLyI5dmy6bxBMBwQz51/ja0k+vxlQHa5/80Slac6GemkwCsEZ4kWlkV8iAKsDLxb/RiKwS4omygXf1JRp6wTPDhAuSOrn3bstOHqU5eIZy8GfRoiDEOfo7L2vZqcS8ln94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUcVfLmx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36872b6d9bcso66043f8f.3;
        Mon, 29 Jul 2024 01:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722243569; x=1722848369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Encnxu5bo2KYPGeU7l1IOtPLycNQoJe8lNlB67W9ohs=;
        b=AUcVfLmxg5iqtbpfUAsRW2H4CYLMPxXZDea1psyrRA4nfR6UI6CfzoMOSBTt5jDRtz
         gUPW1VWmpSee6tfRV/vGHyFhR9GYJ3JPL7U1DrbVHqgpLjOBV4w+MBGTTGk24rRq6tD5
         dNDU19B1HVtnMGKsvocNXAQ069wbJQ9aR7QmqBeJvnVCRWCu+q3Knzd8iSnENdLmjOkV
         UlHFwvYsfiui/Uhn5F0MEyeJxTGPbB9pWLdOXDLm2rE183iJNeEs6RUDKizR9MZf+clf
         HG4TYmh2xetsljgAXxsII6W81j5rxmayZalBXW17eE/hnBlNWM2muIm6T6xe4UQazTdU
         sGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722243569; x=1722848369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Encnxu5bo2KYPGeU7l1IOtPLycNQoJe8lNlB67W9ohs=;
        b=mCVuujpPSgQsvdjxvFT3vSGEczEXelzRoKriCavThDnRsr1ybL2QTVweac6Zan0FRE
         VOs31cSKGYkN+KKC6E+SECB/Un2Guk5hWD04cSQ13X5gnfUbxJ5ZzuyMFf1yVFZib41g
         fvwu/Vjqvab/+51kvP3bh4b8HNXakZpqX/N2/PcC6hl+OFzs7MFdFfqSx5EZFiG0QqI7
         8udCPIRym2E4Ts/66aSsFGnLQLWtkpM0vFvJ/mnM538AeqEhPvgjHKM9stHl7k/pIv23
         rDc54Nwf+3oDrcmiuGaHqWv5Qs7++AeOv9o/Kuto/HLdr6ETuWtvOV46En/HPKMDjg3C
         RETg==
X-Forwarded-Encrypted: i=1; AJvYcCXMEAs0KDfHBS7J5iWmTIJEplDtJYXipDsV+3utickAZL+j+FE6NDKrLlrpGznPJB2eZRRM0RVxRSDdM/rusKC/kyyEdLYWyswahhHlOYoWu0fnmJ37gVe+Pyn9/jwS2K8I58KwNTna/hzg7QtWPDxjdOSAS/dIrxgbkz+y+/q1lTNO632gUjVxPLm4kjXFnQcjQvdr6Cn1SRUxlzttXu3F1A9Hz3Y=
X-Gm-Message-State: AOJu0YzoK/2g8wBgVZF/+PdHRIFmUI9besSWCRys8kl0WaaegX8bnWA7
	JyuJhMmm7bDpnsj2zz5C44DaLjOSzoEbDjPLdMX5Xb/RhGS2/UBH
X-Google-Smtp-Source: AGHT+IGLquqQFEebe7H0zV2X2QmqWfA3O598xFQWgBOpRugP4/tIrCWhReegzIRGtJh8KT/76ECx+g==
X-Received: by 2002:a05:6000:178c:b0:368:4e52:5877 with SMTP id ffacd0b85a97d-36b34e30238mr5755386f8f.9.1722243568742;
        Mon, 29 Jul 2024 01:59:28 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([31.94.28.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857e46sm11715337f8f.67.2024.07.29.01.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:59:28 -0700 (PDT)
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
	Axel Holzinger <aholzinger@gmx.de>
Subject: [PATCH v2 2/4] Docs/sound: Add documentation for userspace-driven ALSA timers
Date: Mon, 29 Jul 2024 09:59:03 +0100
Message-Id: <20240729085905.6602-3-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729085905.6602-1-ivan.orlov0322@gmail.com>
References: <20240729085905.6602-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the documentation which describes the new userspace-driven timers
API introduced in this patch series. The documentation contains:

- Description of userspace-driven ALSA timers, what they are for
- Description of the timers API
- Example of how the timers can be created and triggered
- How the timers can be used as a timer sources for snd-aloop module

Suggested-by: Axel Holzinger <aholzinger@gmx.de>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- No changes

 Documentation/sound/index.rst   |   1 +
 Documentation/sound/utimers.rst | 120 ++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 Documentation/sound/utimers.rst

diff --git a/Documentation/sound/index.rst b/Documentation/sound/index.rst
index 7e67e12730d3..c437f2a4bc85 100644
--- a/Documentation/sound/index.rst
+++ b/Documentation/sound/index.rst
@@ -13,6 +13,7 @@ Sound Subsystem Documentation
    alsa-configuration
    hd-audio/index
    cards/index
+   utimers
 
 .. only::  subproject and html
 
diff --git a/Documentation/sound/utimers.rst b/Documentation/sound/utimers.rst
new file mode 100644
index 000000000000..0bd875ea9986
--- /dev/null
+++ b/Documentation/sound/utimers.rst
@@ -0,0 +1,120 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Userspace-driven timers
+=======================
+
+:Author: Ivan Orlov <ivan.orlov0322@gmail.com>
+
+Preface
+=======
+
+This document describes the userspace-driven timers: virtual ALSA timers
+which could be created and controlled by userspace applications using
+IOCTL calls. Such timers could be useful when synchronizing audio
+stream with timer sources which we don't have ALSA timers exported for
+(e.g. PTP clocks), and when synchronizing the audio stream going through
+two virtual sound devices using ``snd-aloop`` (for instance, when
+we have a network application sending frames to one snd-aloop device,
+and another sound application listening on the other end of snd-aloop).
+
+Enabling userspace-driven timers
+================================
+
+The userspace-driven timers could be enabled in the kernel using the
+``CONFIG_SND_UTIMER`` configuration option. It depends on the
+``CONFIG_SND_TIMER`` option, so it also should be enabled.
+
+Userspace-driven timers API
+===========================
+
+Userspace application can create a userspace-driven ALSA timer by
+executing the ``SNDRV_TIMER_IOCTL_CREATE`` ioctl call on the
+``/dev/snd/timer`` device file descriptor. The ``snd_utimer_info``
+structure should be passed as an ioctl argument:
+
+::
+
+    struct snd_utimer_info {
+        snd_pcm_uframes_t frame_rate;
+        snd_pcm_uframes_t period_size;
+        unsigned int id;
+    }
+
+``frame_rate`` and ``period_size`` set the desired frame rate and period
+size emulated by the virtual timer respectively. ``id`` field gets
+overwritten by the ioctl, and the identifier you get in this field after
+the call can be used as a timer subdevice number when passing the timer
+to ``snd-aloop`` kernel module or other userspace applications. There
+could be up to 128 userspace-driven timers in the system at one moment
+of time, thus the id value ranges from 0 to 127.
+
+Besides from overwriting the ``snd_utimer_info`` struct, ioctl returns
+a timer file descriptor, which can be used to trigger the timer. This
+guarantees that the timer can only be triggered by the process which
+created it. The timer then can be triggered with
+``SNDRV_TIMER_IOCTL_TRIGGER`` ioctl call on the timer file descriptor.
+
+So, the example code for creating and triggering the timer would be:
+
+::
+
+    static const struct snd_utimer_info utimer_info = {
+        .frame_rate = 8000,
+        .period_size = 4410,
+        .id = -1,
+    };
+
+    int timer_device_fd = open("/dev/snd/timer",  O_RDWR | O_CLOEXEC);
+    int utimer_fd = ioctl(timer_device_fd, SNDRV_TIMER_IOCTL_CREATE, &utimer_info);
+
+    if (utimer_fd < 0) {
+        perror("Failed to create the timer");
+        return -1;
+    }
+
+    ...
+
+    /*
+     * Now we want to trigger the timer. Callbacks of all of the
+     * timer instances binded to this timer will be executed after
+     * this call.
+     */
+    ioctl(utimer_fd, SNDRV_TIMER_IOCTL_TRIGGER, NULL);
+
+    ...
+
+    /* Now, destroy the timer */
+    close(utimer_fd);
+
+
+More detailed example of creating and ticking the timer could be found
+in the utimer ALSA selftest.
+
+Userspace-driven timers and snd-aloop
+-------------------------------------
+
+Userspace-driven timers could be easily used with ``snd-aloop`` module
+when synchronizing two sound applications on both ends of the virtual
+sound loopback. For instance, if one of the applications receives sound
+frames from network and sends them to snd-aloop pcm device, and another
+application listens for frames on the other snd-aloop pcm device, it
+makes sense that the ALSA middle layer should initiate a data
+transaction when the new period of data is received through network, but
+not when the certain amount of jiffies elapses. Userspace-driven ALSA
+timers could be used to achieve this.
+
+To use userspace-driven ALSA timer as a timer source of snd-aloop, pass
+the following string as the snd-aloop ``timer_source`` parameter:
+
+::
+
+  # modprobe snd-aloop timer_source="-1.4.<utimer_id>"
+
+Where ``utimer_id`` is the id of the timer you created with
+``SNDRV_TIMER_IOCTL_CREATE``, and ``4`` is the number of
+userspace-driven timers device (``SNDRV_TIMER_GLOBAL_UDRIVEN``).
+
+After that, each time you trigger the timer with
+``SNDRV_TIMER_IOCTL_TRIGGER`` the new period of data will be transferred
+from one snd-aloop device to another.
-- 
2.34.1


