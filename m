Return-Path: <linux-kselftest+bounces-15213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EE295047A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 14:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50373286EC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 12:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589DD199E92;
	Tue, 13 Aug 2024 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzBhYXXP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD3199392;
	Tue, 13 Aug 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550963; cv=none; b=KtgDET3JTZrEUHe7lxlNZkSD6XoDrN1FRAt8H7wxMQ7z1b2sbVc1Qs30etYGc+I9rafiHiEzRveT1nZSqI/7duLLWsc2UcxKhzQpg83R/43kP5ylCnOuBFhN3nwFK4hTo5vNO9LXPOwWwUp//UGRKW2sjgjxpL8affvUP8B9FPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550963; c=relaxed/simple;
	bh=DmnNpD3fRGZH9HjXNQfZroyFbQbkpv3OG3z+xEEOOao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqBhlgX0zDgHcovHO0tBXbO6IAD9WQv8INMe8jRiKPAFzoARoVeVB98MEgPfMTQMGDbFIjCMqPaxIgf17AnIiHB4GHTR+LrrAJRzvsar+CKLELTmQuyrnPGVNRHB0NjV0qwm8kHk+XGVoCks9gLKLs0TATxVmgR4CFrDS5Q3EZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzBhYXXP; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3684e2d0d8bso155947f8f.2;
        Tue, 13 Aug 2024 05:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723550960; x=1724155760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBeY7lqT2pR79KKk/zdzcK1k5HWtLQmlqrEUjPH8nTA=;
        b=EzBhYXXPRoDCBd/piYSaMU9ZzaW0C91Cyep6zG6eFWlR8yXGAGFOVNJFSz3LFsSYrS
         Xs4xxMJUfJJwVh2ng2IhkaypibRBhs/Hnp2s5NPD05y8GWMF74rJRdiKPWvl3g0RVomG
         1aWzTYYfDFSFLXA0Dh0x5/CF7JGRwp+Oc4yuZkZqi19PrqEABwJYOKBsMTZ3xgtSg+5t
         6n9xEjtNoQx4BWih4IUY+Je0+RzfweslscEDxUREE3AcG5B4LjGFGKQgPwn2nXllx8je
         tAitb8ZMrkkJOS7xfSBYgU38TYUnDypMwzWkcNRQ/QzFV3cvubCVc8yUw2mnp9D4Mfvc
         nkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550960; x=1724155760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBeY7lqT2pR79KKk/zdzcK1k5HWtLQmlqrEUjPH8nTA=;
        b=PoJVMmk3/ollAUgoYJd4o76Nyo7WzZQwElmFyhLyKYFPCxbgRzxv5chvTStUI2dyUj
         LmrC5nZkm1zoLofgxHXQmAoRQZ1a5/A7I8DkvNBLQujsR4occbu33QCVgSVykqzH1Mza
         ed3wn//NmJGyrXctXDFVCmBkhAa9KbloRfNayK7LuN5IJshLFWPtoZ21hE2t4wKGTvL9
         6V8aGxFSRwk4j+2UURaCDyas9Zs1Vj3SU9gkiY2sX7TCtq2qQgd/WcIyeJ9vZpyrDkpO
         T+MGGDCl71ByXuJ+XFkjg5drCuJ07q3g1hbVRvGS4UdoHAHP9iI5VRIZtrU7kMKR9aDv
         sSsg==
X-Forwarded-Encrypted: i=1; AJvYcCUdFCC8cPugs4gMz3GNh1kjBzfG8CmlqfloF4ZnYf/VuH05nErsDazM6zYe1lx0ZrZXUrTeODk0LolPUQ2T@vger.kernel.org, AJvYcCVtwjtIHO2koch+8VRTGtzNYIzGDmYVTBK8ASmW0xG1QzEc/WkxX5bwHXgyczqIKb+Iq/vn8vKBNYqEDgI=@vger.kernel.org, AJvYcCWLfSxP7eOxsugCn3ese8txg10MBuGkIsm3XC2RW7rgzLHioUzNIc5WZ4DpJSOnSf087CXX10d14U8T2YVdwMaH@vger.kernel.org, AJvYcCWsCCfLKOWuiUDUuF8m4M4J9skSpYmcdr5xyxqF62jsKQ5lLXv/ungDN0Qtz+dj9Bi7OOlGWJf8Zf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv4WipD8tTGmsRyaQ1LY2N3xUDLAdx4MgqsqQaL9SNBZIFUjQj
	+r15U5bHtFsjA9Iw24KaC1/IwhLSlecThMd+0ejOcz+5gY7VFysK
X-Google-Smtp-Source: AGHT+IGZCdraOMpa6/1PvKyrUuxYbtxg8umd+vtUMMscAW8e0xxQDYGCt7QYQIZXY/SPiMjitIX/xw==
X-Received: by 2002:a05:6000:188c:b0:367:9cf7:6df8 with SMTP id ffacd0b85a97d-3716fbf3416mr913426f8f.2.1723550959054;
        Tue, 13 Aug 2024 05:09:19 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:6db6:f2bf:8865:5d31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb52sm10204590f8f.74.2024.08.13.05.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:09:18 -0700 (PDT)
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
Subject: [PATCH v5 2/4] Docs/sound: Add documentation for userspace-driven ALSA timers
Date: Tue, 13 Aug 2024 13:06:59 +0100
Message-Id: <20240813120701.171743-3-ivan.orlov0322@gmail.com>
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
V2 -> V3:
- No changes
V3 -> V4:
- Update the userspace-driver ALSA timer structure name and fields
in correspondence with the latest changes (remove pcm-specific
fields from the structure description)
- Update the snd-aloop paragraph to provide a way to calculate the timer
resolution from frame rate and period size
V4 -> V5:
- Update the documentation in correspondence with snd_timer_uinfo struct
change (timer file descriptor is now returned in one of the fields of
the userspace-driven timer info structure).

 Documentation/sound/index.rst   |   1 +
 Documentation/sound/utimers.rst | 126 ++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)
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
index 000000000000..ec21567d3f72
--- /dev/null
+++ b/Documentation/sound/utimers.rst
@@ -0,0 +1,126 @@
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
+``/dev/snd/timer`` device file descriptor. The ``snd_timer_uinfo``
+structure should be passed as an ioctl argument:
+
+::
+
+    struct snd_timer_uinfo {
+        __u64 resolution;
+        int fd;
+        unsigned int id;
+        unsigned char reserved[16];
+    }
+
+The ``resolution`` field sets the desired resolution in nanoseconds for
+the virtual timer. ``resolution`` field simply provides an information
+about the virtual timer, but does not affect the timing itself. ``id``
+field gets overwritten by the ioctl, and the identifier you get in this
+field after the call can be used as a timer subdevice number when
+passing the timer to ``snd-aloop`` kernel module or other userspace
+applications. There could be up to 128 userspace-driven timers in the
+system at one moment of time, thus the id value ranges from 0 to 127.
+
+Besides from overwriting the ``snd_timer_uinfo`` struct, ioctl stores
+a timer file descriptor, which can be used to trigger the timer, in the
+``fd`` field of the ``snd_timer_uinfo`` struct. Allocation of a file
+descriptor for the timer guarantees that the timer can only be triggered
+by the process which created it. The timer then can be triggered with
+``SNDRV_TIMER_IOCTL_TRIGGER`` ioctl call on the timer file descriptor.
+
+So, the example code for creating and triggering the timer would be:
+
+::
+
+    static struct snd_timer_uinfo utimer_info = {
+        /* Timer is going to tick (presumably) every 1000000 ns */
+        .resolution = 1000000ULL,
+        .id = -1,
+    };
+
+    int timer_device_fd = open("/dev/snd/timer",  O_RDWR | O_CLOEXEC);
+
+    if (ioctl(timer_device_fd, SNDRV_TIMER_IOCTL_CREATE, &utimer_info)) {
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
+    ioctl(utimer_info.fd, SNDRV_TIMER_IOCTL_TRIGGER, NULL);
+
+    ...
+
+    /* Now, destroy the timer */
+    close(timer_info.fd);
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
+``resolution`` for the userspace-driven ALSA timer used with snd-aloop
+should be calculated as ``1000000000ULL / frame_rate * period_size`` as
+the timer is going to tick every time a new period of frames is ready.
+
+After that, each time you trigger the timer with
+``SNDRV_TIMER_IOCTL_TRIGGER`` the new period of data will be transferred
+from one snd-aloop device to another.
-- 
2.34.1


