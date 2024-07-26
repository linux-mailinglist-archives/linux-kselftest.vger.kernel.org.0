Return-Path: <linux-kselftest+bounces-14256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6082D93CEFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 09:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83EC11C218A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 07:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927A217623E;
	Fri, 26 Jul 2024 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXoczIPf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44631741FB;
	Fri, 26 Jul 2024 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980115; cv=none; b=HIFCFU7K3/IYN4U3o33UFDETcTg6qr6yC3M3aNI8vkqX4uigZvcbtdOu9ZqSQ8ib5r3Fb55bvP7+cFVuuefYsrvjl65IDHw64cQzEikMA6uQ6HGxXu9Zumns7zMZInLTPLV+iHmEW0TIrrx9+rPpREVUj14YtBT1BShIS7WHDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980115; c=relaxed/simple;
	bh=5ON6IusU5v7qrydb7czcU0yYORsRRJri7xK6Rr4x24w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a0gmZHMBHWH10N/CP3hm9fikjg2C6kRSht8q4Iv/ESzobhbljkA56X19V6IRWmBf1riV4vOYTbiR899Pz/RBnK3UfTWsUs/bbUYp6jP0ZL77bYRbvEuQ9u6nJyK32+5i0QX8ZgJ/N5hgd49k70Ef8ceNVgxOgEEQjTFMS2ZO964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXoczIPf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428098e2b3bso1037035e9.3;
        Fri, 26 Jul 2024 00:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721980112; x=1722584912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j7STCBcMZoBcNkHRG9IYlvtYZY+jcGZj/eZGXSHCEQA=;
        b=NXoczIPfgrrxY+fNWFPXGIqj3dPGK1CAAzlAutSHM6kNEulthaMoZyOZp9pYcSv5nj
         fvTKULweCEC9UeY8b0AIoxNc+PZXZD642VYvI2bo2xvFbHGeENcjEqdaslVRyfDJ2h8R
         X3GXjVPicxwFdhFkoYqyxaixrqHTZ9g5jJdjFgNN35N7rx8nW9sfFov0N8RyuFcANRCC
         g3eSrOXMqEz2Db0FdyJyBpRUtqjxa1Fw8C6RehR8ubWvKdLgSbKD9QVjJARYakCh2jZE
         00zlSZsPAhn5aHgmyfMrRolYXc0lhHGuvCt6lI/rgoHcaCI9T+DpqwERNzwSQuVHiWvj
         KFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721980112; x=1722584912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7STCBcMZoBcNkHRG9IYlvtYZY+jcGZj/eZGXSHCEQA=;
        b=ckYufXy/vzPKKasjtDTSbqmyCrzY8p2oigix6gBiLAhgbKuFKHOqs9VUUr1zyXTgxP
         +yFYXPCVa6vcCHmyhGDGIjILorrppbhLQ01s9eCkcyAmqg4PkTJPSjUaJBILGRag75XK
         /oKSLu2CWOy8lGKlSArxbeNJHl069vJSV9g4p5IZP9x6vmnTJ/EFppUMK7sL/khKNusR
         4yOigqt0bfB3MWDlOHi/xR+jlyWBWGReRhSa1bXAiO5fvNbL91X7ew848/+T8e6OX91K
         rX4/oGlKwX+/CBypMD1IDefEfwxvxcuUFF4GoQ43eoYJmCB/uLZzQ1flJec7bwv6IKPi
         Wpeg==
X-Forwarded-Encrypted: i=1; AJvYcCWxqxc4LxOE67FT3wcwuXSwo0G+e3rYa2b575zNyXt4Hv+ZW7NWmMgT7sa1xF+8TaoN9XLsVR6nhO+Y/WDqlnxjtv8+BZGrZvi5CiUdwG21Brg5Xvi0iQuP9ByYZwZSauxQkT5+YTzh4bDugHSTbfPpFJrbp1mDKlhAwGSY5ICmd3S1daP3JPziBXN97VZ8eX9UTpzT51rHjNcGTRfaMPSXmyTb8V8=
X-Gm-Message-State: AOJu0YyT02eHFgP765fgplrefUa/QRCsNwwCy/+dZhEHh+RgOnCFdPA+
	NxDZIj8/oQxvSfxpgKBGFHrfdgB78dUxQVkkR1eCWOCECVC3jZga
X-Google-Smtp-Source: AGHT+IFjpz/7j0G/aN/7uXAqlqfX5pso/gmcLd8tUV2EhE7wpv7H5UoFFdvgPWnhdAQIGAJFn+acLA==
X-Received: by 2002:a05:600c:3b87:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-428053c9c55mr20937075e9.0.1721980111737;
        Fri, 26 Jul 2024 00:48:31 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:68e5:11ce:4d88:9958])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a6368sm66045565e9.38.2024.07.26.00.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:48:31 -0700 (PDT)
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
Subject: [PATCH 0/4] Introduce userspace-driven ALSA timers
Date: Fri, 26 Jul 2024 08:47:45 +0100
Message-Id: <20240726074750.626671-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are multiple possible timer sources which could be useful for
the sound stream synchronization: hrtimers, hardware clocks (e.g. PTP),
timer wheels (jiffies). Currently, using one of them to synchronize
the audio stream of snd-aloop module would require writing a
kernel-space driver which exports an ALSA timer through the
snd_timer interface.

However, it is not really convenient for application developers, who may
want to define their custom timer sources for audio synchronization.

For instance, we could have a network application which receives frames
and sends them to snd-aloop pcm device, and another application
listening on the other end of snd-aloop. It makes sense to transfer a
new period of data only when certain amount of frames is received
through the network, but definitely not when a certain amount of jiffies
on a local system elapses. Since all of the devices are purely virtual
it won't introduce any glitches and will help the application developers
to avoid using sample-rate conversion.

This patch series introduces userspace-driven ALSA timers: virtual
timers which are created and controlled from userspace. The timer can
be created from the userspace using the new ioctl SNDRV_TIMER_IOCTL_CREATE.
After creating a timer, it becomes available for use system-wide, so it
can be passed to snd-aloop as a timer source (timer_source parameter
would be "-1.SNDRV_TIMER_GLOBAL_UDRIVEN.{timer_id}"). When the userspace
app decides to trigger a timer, it calls another ioctl
SNDRV_TIMER_IOCTL_TRIGGER on the file descriptor of a timer. It
initiates a transfer of a new period of data.

Userspace-driven timers are associated with file descriptors. If the
application wishes to destroy the timer, it can simply release the file
descriptor of a virtual timer.

I believe introducing new ioctl calls is quite inconvenient (as we have
a limited amount of them), but other possible ways of app <-> kernel
communication (like virtual FS) seem completely inappropriate for this
task (but I'd love to discuss alternative solutions).

This patch series also updates the snd-aloop module so the global timers
can be used as a timer_source for it (it allows using userspace-driven
timers as timer source).

Ivan Orlov (4):
  ALSA: aloop: Allow using global timers
  Docs/sound: Add documentation for userspace-driven ALSA timers
  ALSA: timer: Introduce virtual userspace-driven timers
  selftests: ALSA: Cover userspace-driven timers with test

 Documentation/sound/index.rst               |   1 +
 Documentation/sound/utimers.rst             | 120 +++++++++++
 include/uapi/sound/asound.h                 |  17 ++
 sound/core/Kconfig                          |  11 +
 sound/core/timer.c                          | 226 ++++++++++++++++++++
 sound/drivers/aloop.c                       |   2 +
 tools/testing/selftests/alsa/Makefile       |   2 +-
 tools/testing/selftests/alsa/global-timer.c |  87 ++++++++
 tools/testing/selftests/alsa/utimer-test.c  | 133 ++++++++++++
 9 files changed, 598 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/sound/utimers.rst
 create mode 100644 tools/testing/selftests/alsa/global-timer.c
 create mode 100644 tools/testing/selftests/alsa/utimer-test.c

-- 
2.34.1


