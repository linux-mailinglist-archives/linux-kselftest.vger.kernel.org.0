Return-Path: <linux-kselftest+bounces-15211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C61950475
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 14:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F718286778
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5EA199221;
	Tue, 13 Aug 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdekcDFO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D12198E71;
	Tue, 13 Aug 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550960; cv=none; b=H22w5dX3GlT1BBSBuend7dSaqB8K2TIKtUHXXxTSJ2etnEkNw5EvblT75Pg/6dWHoRVBlqCcuYh6Wz+mJxa69al8P+gbD4nK0dCne9UOvYgOGl4erf7Q2Wy5U9+zrzCzc6wex3nKbv1hee84usXOQ0UadNK6FR3mv/HxlRzonGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550960; c=relaxed/simple;
	bh=dVKFCnEHQj907r8w6DUNC/hFfSLgWVedEBIn+MI3g3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GNpTMwpwyjHUXTieavYdP50eYFL4CFOeV0LXbc/RbFzAEij7srNfEO2wNagVv7jbv30jMa6gijYRAZsZBR/0RcuQSCbvvhYFFvwEgNU/T0kz0jhQqw25FsiYe9QHIz+pyr3Q8hhOR1IRLwP2WkQgumaYep5S1Da4G1MPdEaOsT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdekcDFO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280ef642fbso6104615e9.1;
        Tue, 13 Aug 2024 05:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723550957; x=1724155757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=95nZPeNDVusw7hJQ2/3QSrV1/eH9G+qFzPCkFd7zD+U=;
        b=GdekcDFOvFjTMJfuamLhI2C++oQ1buBAGQIyUI2vPm0R+VN7vVT58R4M2tMUfNhEiL
         rowam3tjuyrk6HGisuGCrcMDsdGfBJiNwZMv40wrKcM/I4X6/yjioB8LP781d73OBtws
         9hsSITgEfWOxvd7ayBFvOpGebHe6cKigkhKZTO5GUh1EtzF851KkrSPrOEO0VFXZj+Dq
         ZcMhJ/IeMMj6FknETiomkSPZNsuVj6J1Qh/9BbIBK5cPrDSjnTVcoiN/vVMB1t/6De9b
         TGM96t2GIqLUVAMrMDJHI03Be3my5bfWxQMfKzhnD257lp6qMqkGC1pxa3PDprGP8X5v
         JspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550957; x=1724155757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95nZPeNDVusw7hJQ2/3QSrV1/eH9G+qFzPCkFd7zD+U=;
        b=XAtJhcc0w+0ER79GJcJa91fOc42A7McGlGE5JK370HFzFNvoVap6bRXvgXxO0Q7be1
         OkUoFSa68Q1T/HFIMJ62CKVsildFnGxpaezir3vsUYeHW10C5RiVBTyOHI8RLiQ7qV+d
         ujUon+FCh8aKxDjCGKXVa7l4rJr+27qZGvij4sYKae7hLxYUSX9bJYICe3LG4mXcuw4N
         ZD0nVGDPfCV+gTZetq34eLyAkzerV1UBQ505nf9tvunwJUUqhyrSU8poJukogpOqGQ5q
         ZcCrHi1o+snlM3wTdACPSRrbKsxEYZ7B21BcdDTDrpV3oBELD1++7JzZNE4TG2ZEkpxm
         Y6KA==
X-Forwarded-Encrypted: i=1; AJvYcCXKOT5aXEca+Dsvw7czgkfHzOu6rrCi+fogWIxo3cHhkXq4/uAJbcv1TYBwQIgZCVsXrcunccCPZRc6bfgQRukOJyM0gVZSJQQieTV9SzecZheycviKWFjiaKduVIGgOShs9rTsjkVvsi9rmA6hea07GwhVHnYo0aiHhqLCGLf+iSHKNyACRW0q56TcfbZvM4NVrfMbamHOgZK/QeU3whHpnx1CBkE=
X-Gm-Message-State: AOJu0YynGo2qLoubOfzxPqAyDdYYwJgPp9Wmg+cb/0qiL/rjRfkcd2vM
	w42PQAqYpu48zWOC2hbnfRJOQ+ePe1X8rALjomVEEZLUiKara1Q23n9cxg==
X-Google-Smtp-Source: AGHT+IEeFZAjMrRFLpsu92UAlKILN8B22ultw43i95rDRVfs5PROELoxXFmSuEpUHo+HUo+RNgW2qw==
X-Received: by 2002:a5d:6d8d:0:b0:366:eb60:bcf2 with SMTP id ffacd0b85a97d-3716fbf30d6mr906591f8f.4.1723550956592;
        Tue, 13 Aug 2024 05:09:16 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:6db6:f2bf:8865:5d31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb52sm10204590f8f.74.2024.08.13.05.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:09:16 -0700 (PDT)
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
Subject: [PATCH v5 0/4] Introduce userspace-driven ALSA timers
Date: Tue, 13 Aug 2024 13:06:57 +0100
Message-Id: <20240813120701.171743-1-ivan.orlov0322@gmail.com>
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
V4 -> V5:
- Add missing error processing noticed by Takashi Iwai <tiwai@suse.de>
- Return timer file descriptor as part of the snd_timer_uinfo structure.
This is a more standard way of using ioctl interface, where the return
value of the ioctl is either 0 or an error code.

Please, find the patch-specific changelog in the following patches.

Ivan Orlov (4):
  ALSA: aloop: Allow using global timers
  Docs/sound: Add documentation for userspace-driven ALSA timers
  ALSA: timer: Introduce virtual userspace-driven timers
  selftests: ALSA: Cover userspace-driven timers with test

 Documentation/sound/index.rst               |   1 +
 Documentation/sound/utimers.rst             | 126 +++++++++++
 include/uapi/sound/asound.h                 |  17 +-
 sound/core/Kconfig                          |  10 +
 sound/core/timer.c                          | 225 ++++++++++++++++++++
 sound/drivers/aloop.c                       |   2 +
 tools/testing/selftests/alsa/Makefile       |   4 +-
 tools/testing/selftests/alsa/global-timer.c |  87 ++++++++
 tools/testing/selftests/alsa/utimer-test.c  | 164 ++++++++++++++
 9 files changed, 633 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/sound/utimers.rst
 create mode 100644 tools/testing/selftests/alsa/global-timer.c
 create mode 100644 tools/testing/selftests/alsa/utimer-test.c

-- 
2.34.1


