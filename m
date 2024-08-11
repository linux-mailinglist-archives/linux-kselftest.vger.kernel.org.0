Return-Path: <linux-kselftest+bounces-15124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D220E94E2E8
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 22:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32E21C20431
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 20:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F7C15854F;
	Sun, 11 Aug 2024 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrMzbyQe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD220158529;
	Sun, 11 Aug 2024 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723407824; cv=none; b=QN5KYuzzFcvYbzPqDPuWUClo9YFwHlspJSYBaWDIwtZ26/Hs/EfJ7VcV1H9d+gNm1QUPktotGST7ue8Pjsn36sYoUHqpUFBgzsmPxtfZPQ2eLyyAPtowkKYz7WS9BIs4JZYM68L5xr9Wxutbopar2uR9LP+Y89LIUMU8bHmNQbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723407824; c=relaxed/simple;
	bh=MPiMKSoZeosakybH2aURFkagWI7uL0lgDyo8mZHR2JI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U5ULPj9DKfAi05UGDKt/9XYai38ez7dB/VkpKg5h44tQzqVZPVOucl5HE70fq20FcO494nGZgsM6bautnZxqO/ldEXlbPFhRJbyv25diW3zTO4xip8vB5Nh2wruCdfPB/F0sD72KPSmcZ0RTtHI9HrvKWSJFMEOAnTqBFPU2l1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrMzbyQe; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428098e2b3bso4713685e9.3;
        Sun, 11 Aug 2024 13:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723407821; x=1724012621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MWE5xyAUeQcXJJ3bA6JVUD9msyw5uchmR9stcH8e+z0=;
        b=JrMzbyQeGz5A6jutSGBkAFMl3reLhTX/5S7NRrgfBhHgVMmdoDlVDz1O+aXJazOmy0
         mZ2kgakqwqnsgoQ7594+Yj8zxfZphNJ4ewJzI4k2V/eImU9LXKF1CzzCeuxy5/Xv/m8B
         Bs2IGxrpccNDpi7ZoIzU3vLw3VZfEGy1l8TM0Q5L9xkzSXtz+ejaSJUPE5n9vJQ7gwHN
         lv3800XQ4CN+MMiw/NtzEWwGiDMYUyLtn7QHhJD1dtky62ZlEbJqtn9iICekYwaQtpMA
         1vXMqNfgwQ06vRuNGroYQvMYPFHwVEwQ+Q8OnQ6swUlLKs7WNN6PyNus7XYJ+mtT8jcO
         1Syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723407821; x=1724012621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWE5xyAUeQcXJJ3bA6JVUD9msyw5uchmR9stcH8e+z0=;
        b=TzRsAMPoLhByi6fOwQrgfviJuB/n75XPlAbYTnht1Mh6OcYINsewJ+IogXxO+tWLwv
         LkyYj2xavMlWVJKHO06NVYoglSs7ftNv0ikMCSM51jgP1kiuNV979VKxZdQBuKXUM8aQ
         5UOWFnMkwJz4eY9oZtZqS/aU9DjI3wqUHo24iF2mHvym4kfPX54aZwXcdLQzDvDfcjO1
         u6DnGFMaROy/Eu+YpDjQw7s2WoUZ4EtCQ6WIYIUJqYUZqo261J0edwyRPTKmi1RaBm5e
         YmgI/mDSpy2DmQebtsA4kfrD3TX8B1bz10QQw5N1lWezfjhcmqmEmdaZQOYEeMy6rDeD
         2Cng==
X-Forwarded-Encrypted: i=1; AJvYcCV3/34FXAq2Oql8VGy7QrEfbVSTg+OXM/ycxkKAnEoBiRaB7u3aerYC1CV6u8iKl4xImOKkvvLQxDniGVsXsSBMMZzHJaLFHrTZ6C6DmCgBebcZ6+rEKkjVFDTfzcG2cg2q/EGcFY0gzG1LGE1Xwa1FEfZsx4wTbqq+UU/+PlDWJVjV0hjJhTlpi/+CFmokv/HEHGY8MvPskBcjj7uV0jRGzXiK95M=
X-Gm-Message-State: AOJu0YyQB93gVyijuUatoWvLMn/k+Mx6yq7jeVZ1YuZHm6s06ZLnkgKg
	VrIBdaUgxNSaYi5JHbto24untTQIY4jIjwE31kqWqoBn7g5s6+ey
X-Google-Smtp-Source: AGHT+IFNSQXPYQ8clX3x0+E4DCc1n8ScEo458gp2OLRmqqwHHQoLRVsTZB0rtltcHSbj0Hgmv/3qiA==
X-Received: by 2002:a5d:64a1:0:b0:36b:b2a1:ef74 with SMTP id ffacd0b85a97d-36d60355417mr3738140f8f.8.1723407820773;
        Sun, 11 Aug 2024 13:23:40 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:24a1:28fd:3a06:5636])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd31edsm5553305f8f.98.2024.08.11.13.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 13:23:40 -0700 (PDT)
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
Subject: [PATCH v4 0/4] Introduce userspace-driven ALSA timers
Date: Sun, 11 Aug 2024 21:23:33 +0100
Message-Id: <20240811202337.48381-1-ivan.orlov0322@gmail.com>
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

V1 -> V2:
- Fix some problems found by Christophe Jaillet
<christophe.jaillet@wanadoo.fr>
V2 -> V3:
- Add improvements suggested by Takashi Iwai <tiwai@suse.de>
V3 -> V4:
- Address comments from Jaroslav Kysela <perex@perex.cz> and Mark Brown
<broonie@kernel.org>

Please, find the patch-specific changelog in the following patches.

Ivan Orlov (4):
  ALSA: aloop: Allow using global timers
  Docs/sound: Add documentation for userspace-driven ALSA timers
  ALSA: timer: Introduce virtual userspace-driven timers
  selftests: ALSA: Cover userspace-driven timers with test

 Documentation/sound/index.rst               |   1 +
 Documentation/sound/utimers.rst             | 125 ++++++++++++
 include/uapi/sound/asound.h                 |  16 +-
 sound/core/Kconfig                          |  10 +
 sound/core/timer.c                          | 210 ++++++++++++++++++++
 sound/drivers/aloop.c                       |   2 +
 tools/testing/selftests/alsa/Makefile       |   4 +-
 tools/testing/selftests/alsa/global-timer.c |  87 ++++++++
 tools/testing/selftests/alsa/utimer-test.c  | 164 +++++++++++++++
 9 files changed, 616 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/sound/utimers.rst
 create mode 100644 tools/testing/selftests/alsa/global-timer.c
 create mode 100644 tools/testing/selftests/alsa/utimer-test.c

-- 
2.34.1


