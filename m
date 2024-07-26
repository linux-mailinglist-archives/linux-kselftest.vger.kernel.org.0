Return-Path: <linux-kselftest+bounces-14258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E94BC93CF05
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 09:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 486F0B23200
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 07:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE75177980;
	Fri, 26 Jul 2024 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjytJU5R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059F176FA3;
	Fri, 26 Jul 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980119; cv=none; b=OTR/mrECPeTCFH0ooPxsIgUGZ2J5YLZEsvv/h0Hz3znJshLbqhSSObp+kiJrWAbvdoRqKfR3xGsoN+JKuwy2TGDyRtRpr20q4UeSQv0TBUgblM4w8l934XuGqkrUTMCHXMuNdL+oUKNq+8t5+Ppj7RXCCdzbShX8XMzf8EndxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980119; c=relaxed/simple;
	bh=H4At4M13uRafZlqVGHQsroqoL+dPlGrEZQQyGwNzqm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9+qlO8dO2aDaTAkjBY2aMAmXVuemDhtf2eal4zPR2qxRMNzdY4DL3gEEqt31JjZiivWgDzL7QPEgIccNUCjefIdefXjvqeYN/ypHJ7T6KxS1f+P7FS8FRVtIcHzBRaasIVtp8d+JEl0uPCKkr5XjHSz4lpHdb1HkAhYBcVF+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjytJU5R; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280921baa2so1151095e9.2;
        Fri, 26 Jul 2024 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721980116; x=1722584916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gJ0CUNxfGK2z8AcFjE8q288bxQjTn3hGIQmPeBvjys=;
        b=kjytJU5RUW7VoP0leyqCGr3GyrfWFTQjZg7JU8hVRvAObJFzs4aZuxH9RoC9u73ibg
         LVqnCVzoN334+8K224zIvdOq9cMxo2DVEdMuWL0Pi5aaOAIdr0ocFXbEGl1zlFsIVz8F
         L2UapBbzVxc1ctIaloHYp7yCY+cZ+upnY3X3dFlpHnZjiMgCeqN/4SvOf/VXYLOCpNi0
         zMn6FD6Tz2ZDFp20QnsU9yoeESM1xtQSqB5o/qYBld6cgy92AiFJAeqCSlcDacQ3ICK8
         wGlp2ZgldhH4mjs2NZ+sQWGlsIdy5xmDz5542Lo/f2Mu5f8nBapuN7lhPuKUxTHnGiVv
         GiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721980116; x=1722584916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gJ0CUNxfGK2z8AcFjE8q288bxQjTn3hGIQmPeBvjys=;
        b=KSvXa7kvCju+S/q1MO30QhpmdPnsehZTfj1fsy1HU/5XyxW7mdb6ysUm1v9Lf+7rzn
         auhsSAuGEe+iStWVKwv+L9Dgog5vz/91XGXAI33nygmrIimymcJjEskZ78E5dm0iwGg4
         oCWY04/qvR2F7p8OocNSbqU0mihnZObCvSyCW+uWeZ3pZDWsnFItf4cvYAz+qyHin1GB
         +BfGcAPQqH3mIk0L4LYbK/lkTvDnpnLurq94gOocOJ/pFEwPapItNRnIfmbzgpGedlZU
         hOH92MTtp6EPWDqx8FjWqtFt9Ycy+IFVXH4bqEnO9DvGcv8dYQRCoFLS8aSO3X6gWnWH
         33eA==
X-Forwarded-Encrypted: i=1; AJvYcCXm83kjlMZPA04NW6x1Q9n5YbyY8/w1B+zJ8Rm2Xhhw8IyVJIH/OYI1RpgMZ/FCR1wbLQOOCjskdLnSv926l5kMmuw7ZGcYzRbklybneAkp0bhdbznjU8mKF9GTzAZdh0E2xfCtw2W8mXZ8jbdigTsm9qbXYwq3iOheTFF66STkOMeS2hj1i/HNlV4WZIDnqOHjUOpPR/B2upJtj7AhPlQO0fTkrIo=
X-Gm-Message-State: AOJu0Yzlb7GvqZU4dka/HzBZvFGVg/vgfyTx0gPrBBZg8VmCrzsvPPUU
	dp4CZfAbksaXAYyA+Z7Vlxuegh6P6/iWUr9rlHw3fHKnaGCQAvCZ
X-Google-Smtp-Source: AGHT+IEdYENEW/t4zamjv55B73YjvHs7KxtJclVtPR6jjvVCwn31cIN51u5W1DnkXyzVbPP1kvc0+w==
X-Received: by 2002:a05:600c:3b05:b0:426:6cd1:d116 with SMTP id 5b1f17b1804b1-42805741f8cmr20636295e9.3.1721980116000;
        Fri, 26 Jul 2024 00:48:36 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:68e5:11ce:4d88:9958])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a6368sm66045565e9.38.2024.07.26.00.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:48:35 -0700 (PDT)
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
Subject: [PATCH 2/4] Docs/sound: Add documentation for userspace-driven ALSA timers
Date: Fri, 26 Jul 2024 08:47:47 +0100
Message-Id: <20240726074750.626671-3-ivan.orlov0322@gmail.com>
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

Add the documentation which describes the new userspace-driven timers
API introduced in this patch series. The documentation contains:

- Description of userspace-driven ALSA timers, what they are for
- Description of the timers API
- Example of how the timers can be created and triggered
- How the timers can be used as a timer sources for snd-aloop module

Suggested-by: Axel Holzinger <aholzinger@gmx.de>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
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


