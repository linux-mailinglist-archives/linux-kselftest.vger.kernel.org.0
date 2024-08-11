Return-Path: <linux-kselftest+bounces-15126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC5794E2EE
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 22:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892E82812B1
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 20:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6206515C152;
	Sun, 11 Aug 2024 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnYMmnCL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7A1B7E9;
	Sun, 11 Aug 2024 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723407826; cv=none; b=Ddg1cIhkjfF3h5iMb2e2zY+De8aqRQflBK+iXcnKpJK86R/Gi4/ZB3b2wKKKma4pjOrI3X4G82g/hRQFEMOEq3efoxdxmDYZWitQ5iJ+7V5y2h0jjgjonQ7HOYRZ/BMjqfFZvqGsiDHquukpiQ1oDLWO1TUTU1qf7/ulzhBbuoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723407826; c=relaxed/simple;
	bh=ka5rScFuV7mhqnmKZuL8W/DQzBeeB+34ltjCME/4bQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRylhgbYoE0IazKnnH7u4aaPRGzhCsO+Gmpo1xycS9pHsUf6PNQzQvkrrHT3lN/2rHKcjZ1IgL7uVTpcwK/Fjuu+hLwtBFPPBH9Z7hF3sDMS+IMu+h7yp9+6JwQg7gZOp0Fyu2DIdzdhIR6UABDpf/Nx7jZxqXXLKacqw6fkXU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnYMmnCL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36874d7f70bso478373f8f.1;
        Sun, 11 Aug 2024 13:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723407823; x=1724012623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7Af9ukq2OSEb+9txteTECRncZyiobdlgeg54DZVHAc=;
        b=JnYMmnCL2mYSDpn0Rp2N5MhTtNgHp22QJZwuQ+mRWuJM4vVPC5ACipePdZ2nO/7gc6
         3WoU204CSTCCGlm+hW7FOzUPpEC0RRDFMyOLZIlwnkXgqVjupIdOM9dsPoJ9VuhSrlPv
         0ePwIWgTS2A9Fsrw4iop2ABwSrGuVxLWu1QYT0xV6Y9IRTWovg8hb/XEFQ3M0A3O3Hi1
         yJhsAx1kFe2vxVyC7yVPrBNS5ny8lcDDtKOPOEiBsIVgGMYEbK3JlkqDwn2ytggf9Vso
         T/fJwO06QR5PYosxg7kMcOz7NXW0neX2hMCIe7qMXk9gRBB2XXB2Ylol0r9++eGAHIj6
         4RbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723407823; x=1724012623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7Af9ukq2OSEb+9txteTECRncZyiobdlgeg54DZVHAc=;
        b=K/mjWIL/u1dYNFF8h0Q/xRbh6Xd0gSTP+dSUKGQd3uT+S9jmkZFkGnELyWvqNDU4I0
         Qj5YnVIVQ2KqqFkVIv8XjFYlQXFs6/dl7KRSLEWtO78fPeuMasZ0EfknMVtTYFuuhxiZ
         Bsj/+Dt2u+dKPJ6IW6M3XEK9yk29byPm2Y6Fo26hMrweZALwaD8ivs2q8AhY4mub+icN
         GaoN6dtVUCqh7k63OtU4qh4ZzaGnH6MoTeONKVqpVfrhGdu/SphmacqbB06xVI+Bq8GE
         Nrr212GG9GhhXWxvbfjf25B0W0bX7zYjqG2qoHKSJTJ4Ser8vExwNm2GOGk5SliCXwGH
         ZDVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbbKLZbmKCyuBFvh5sCbKeymW1SHr6mG3z1p+b/ISos0aRhzdoTwqKa7oDoLvnLtQ7NG1THhRVUg+eKPrY@vger.kernel.org, AJvYcCVbQavsuTH001ByMiK5gy8xfNxMFat5od8aqXtAc0YHsYr3IM35GCnRbUGRGznn427qrcszsCylBuM5VAonj459@vger.kernel.org, AJvYcCWrdJaGQsR+ITdtMkYUyPL94SiHXY3qzz/EMmqi6yk+tQZw7xO1qSYmPTjd85bceTcF9lY4suceE6PZH0A=@vger.kernel.org, AJvYcCXTMfKEkHplKYKY+iGNZzySIdZiZOzgtKaDFhJTrgtgyWkuLfzG9FAaZyKYFCEKBUQhkpcfLrGGAMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3PrXlYDPJ6gWvZMveRiJh/7VY3YFHuBvf2vNNbOSKJJCgZT/O
	eKVUF3mxHQkZrh9OPLl7Aw6De4V26tdoo6KyhP11DuKrGQHJiOZ6
X-Google-Smtp-Source: AGHT+IFnGd2ApbXkaAY0OHvDsVTuxideFfv4i0437dtZVNqWCEYaab3QnqbN/vOls+CMF3ycX4cRxQ==
X-Received: by 2002:a5d:5989:0:b0:368:aa2:2b4e with SMTP id ffacd0b85a97d-36d5e4d0686mr2913491f8f.4.1723407822861;
        Sun, 11 Aug 2024 13:23:42 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:24a1:28fd:3a06:5636])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd31edsm5553305f8f.98.2024.08.11.13.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 13:23:42 -0700 (PDT)
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
Subject: [PATCH v4 2/4] Docs/sound: Add documentation for userspace-driven ALSA timers
Date: Sun, 11 Aug 2024 21:23:35 +0100
Message-Id: <20240811202337.48381-3-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811202337.48381-1-ivan.orlov0322@gmail.com>
References: <20240811202337.48381-1-ivan.orlov0322@gmail.com>
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

 Documentation/sound/index.rst   |   1 +
 Documentation/sound/utimers.rst | 125 ++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)
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
index 000000000000..df1aeccd3285
--- /dev/null
+++ b/Documentation/sound/utimers.rst
@@ -0,0 +1,125 @@
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
+Besides from overwriting the ``snd_timer_uinfo`` struct, ioctl returns
+a timer file descriptor, which can be used to trigger the timer. This
+guarantees that the timer can only be triggered by the process which
+created it. The timer then can be triggered with
+``SNDRV_TIMER_IOCTL_TRIGGER`` ioctl call on the timer file descriptor.
+
+So, the example code for creating and triggering the timer would be:
+
+::
+
+    static const struct snd_timer_uinfo utimer_info = {
+        /* Timer is going to tick (presumably) every 1000000 ns */
+        .resolution = 1000000ULL,
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
+``resolution`` for the userspace-driven ALSA timer used with snd-aloop
+should be calculated as ``1000000000ULL / frame_rate * period_size`` as
+the timer is going to tick every time a new period of frames is ready.
+
+After that, each time you trigger the timer with
+``SNDRV_TIMER_IOCTL_TRIGGER`` the new period of data will be transferred
+from one snd-aloop device to another.
-- 
2.34.1


