Return-Path: <linux-kselftest+bounces-14851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05007948F8A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FBB1F22FC3
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 12:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315D31C57B2;
	Tue,  6 Aug 2024 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaLqlEnw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7601C4637;
	Tue,  6 Aug 2024 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948774; cv=none; b=C9CfQ2imLDY8JliHINLt9TTkQrQyFGqpSmxKqbuLjgLopjIY4FX8oFJQji/N1/TSt0xXXQYml21kP3azwKdtX8oKXQDCo7Hr6t9vvn5wcite5xqCYBGGPutTbFxhyczSrVwnmYV4X78UDnbAYYiEvsblUJzaK6t7ZRWJqLM3ezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948774; c=relaxed/simple;
	bh=GCNFC7auJJqaDNuW5opBT/6lfQ+oFG3olC81IwBnExI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bkYSCza+OMCAEdQPxqZcND5r3jLmx6WQ+7kIN9gZ/VREf1whq+e8pWUh9QCWmapFxN/tlBFKscLW7f3jqUdcdgDag4S6S98W1AhQZBiYCKhbUxIsOyvThRzerGqdzl+mzvVWPl3dDmAVM3nbbRf0oHbEl83UEz1wVsB73Q1/G0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaLqlEnw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4281da2cdaeso710925e9.2;
        Tue, 06 Aug 2024 05:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722948770; x=1723553570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3X+WYBsqooASrWd1IFXIS6RBNTRAxxwAyqlkCuR7pzo=;
        b=CaLqlEnwSDd1UWq6K6hGwObuGLs1UbG6acBOb+cZoBR9fGF1s9ii333ZfBOyIw5DGV
         QvrJ+FB8dBVwcxFYrT3ASjO5zMlZCtAAoywYTib+VAof95FgGl5yryMDkcaibEWG6mnh
         0cvDh/Z6ofC1UCYu7U+cPoFbJlPpAn6x3ap2WrDt8/fB/z9e7rnXMQzkQ0K2icXtDRAY
         3FEjmKxbbAJczois3HMrOw1xXCLfFif3KmQiZKdoX5EBLnI3+Q+Yqf53BVQLV6KCKEgv
         jwy7CK+73xhW5Dsc5gEyrURsllkPGhJUQUGuMLSdWR3ZwYhKdnwRlHeQ+sqYE0BAV+x/
         aPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948770; x=1723553570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3X+WYBsqooASrWd1IFXIS6RBNTRAxxwAyqlkCuR7pzo=;
        b=EX9+3Ff33+ZiWQ6FHI/aVPlWlX0fmTzPtV+WmlMDMKOiAh2ouRFZKXz4jX4UFRcW45
         v1QSruZBxNkP1Kx1Tdh0vmjZQHT8YdGMggBB3ovuex5PVEp9Ii7Jc37fBQlUkj1d9GPf
         pVEhomoZ+ZN9MxptyYVuabq/Jwn3hCQWPa5/Mny/5pEMUUqzy7JHUdDkJnFFG9QOSp6O
         VAP/2UPfMoDqEHdJVFAda/JavXDx1k0ilZsNQBgE3oBbny8ESup1gU/83GVFDUISP2qK
         ssECiOoMHARsAnnxIxgLZgXDe4DqPtzVMb8hbcyBHiPVGsGYvryry2lsHh5Z/0mqLWcG
         Wocg==
X-Forwarded-Encrypted: i=1; AJvYcCUbvd5dEQlHjsRwlQo8uz7SDWOktc7Vrq2zXAYQDCxUIMvPpV84QLRQDCiGeHFKGqYYpWhgusqBtZFvHDw=@vger.kernel.org, AJvYcCVQixp3os0QBoeNlTQDC2c9aXw74NF8/L0wxogZ41y/t3GjicWZyc/gpw6QBXYRCJkb4ZhRisZA4MaqMGdWFsOc@vger.kernel.org, AJvYcCXI45tlhUVooSg3ulaQqgE6YH8hDzl+ki9hlWV9Tvl+rnwlg0fy3kMD4USLtdrDVHCednx3oarK1T8=@vger.kernel.org, AJvYcCXpgAOAv9g/8tEAYziY2PEkRomtwzVkUsfh5c6Lr4NQqGhBZDjprkLby3AFhZBaQ4uo1erzg0VpwMenty9l@vger.kernel.org
X-Gm-Message-State: AOJu0YzaOGb0vW3He9/bU6m777NNNbKtF8TqX3U/PfM8px0ALMcJIdm3
	uOf21Bq/bTBJZOdfwYBrA3JEVpKIK1slpKv6JMLkdCslempPL0tC
X-Google-Smtp-Source: AGHT+IGMjLgYiYdwxMuO7WLiimK30JfH+11Z4zn7OZktuSTfV7OzBfE8MFnsjVKFvIcRFOHSOQD7Bg==
X-Received: by 2002:a5d:59ab:0:b0:367:9cf7:6df8 with SMTP id ffacd0b85a97d-36bbc0a002fmr6205184f8f.2.1722948770033;
        Tue, 06 Aug 2024 05:52:50 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:b50e:24fa:fd17:c835])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6d648a0sm179487255e9.10.2024.08.06.05.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:52:49 -0700 (PDT)
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
Subject: [PATCH v3 2/4] Docs/sound: Add documentation for userspace-driven ALSA timers
Date: Tue,  6 Aug 2024 13:52:41 +0100
Message-Id: <20240806125243.449959-3-ivan.orlov0322@gmail.com>
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


