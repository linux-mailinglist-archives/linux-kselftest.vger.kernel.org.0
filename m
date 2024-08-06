Return-Path: <linux-kselftest+bounces-14849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3317948F84
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125831C20E61
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 12:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164EA1C2321;
	Tue,  6 Aug 2024 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZa1j2QK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932E1DDE9;
	Tue,  6 Aug 2024 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948771; cv=none; b=KZFDrOEhSg2JXHzfEND8SavAMnul5eBQHfD7YVYDCLdWS1J/S+JKfibB+QYufHIKCNWmjnGAtc8COW/j/Qp37en4qN4suGQ6Lr4mWZKivspPs/wSqfgGNQZAlH5ThkAnph200rmluf2+zPoXSde9O5IIvGOQjxYv5GUC5ljR25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948771; c=relaxed/simple;
	bh=XCUyjKV+4WCLNTZyX/VgSzrT52E+iaAR5TRzoM5QI/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NgABqxzZLeX1UXNXYeTb9ma8T94kXXgZw7Uv6ppefQJw+B3XSo3BBI3nkQaV0AOxZApLC4Lv05I7QGBZzdfl6ZWY0rb+gNLMO4QIUXsrpAtMS5HapAinvvw+v5WvWj8LKX9zp8BwZHihIefYZB7QlOfJr8numWyOZz1dV+rdCeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZa1j2QK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4281e715904so300105e9.0;
        Tue, 06 Aug 2024 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722948767; x=1723553567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jqDxoQp4BOQP53+6L9ROSS9A2LeV1Vg9EkuWNnmpg8w=;
        b=EZa1j2QKjjGEuqLbLZryLK3LVHa9lNIqNGAfRFUiktybgNQsNqGl9WvzV9hldG3oea
         Dg9vANDTy4ZaDEEBznTKd7qjpSSeYx38aeytjzuzNYjsr110Sudniq8U9iHw8vPzfCPJ
         uZvWeilwrDQVcxR7i6wzg+aRmxkUShwtpsYpFqPXteC/cCBGXxE6yrqfqkCYiR9FAHw8
         k9qRvNKg2ofPa40BzxEX2l4ChdiZfKSV56+U30ZWY2QsXhVXt4pYowowAmbQG46EZigO
         u5Py0YXcZ3k6tMpMA/GBdJzuJBIz/NpLY61V2I4i0qA9a2N5u8+TZ6bTTrjHee0TEgK7
         Y8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948767; x=1723553567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqDxoQp4BOQP53+6L9ROSS9A2LeV1Vg9EkuWNnmpg8w=;
        b=VXEg40Y9yTCKIx4tew8W07Z2lDQEAYIXRkM/39ORRKyF8Vb076PESihwxbdA891xby
         HYJYRr5PZez8cSlaZ+wzE899tcd3k93EbGZHfwUUVmDdX5Ice1snp5bw7FT6zpzvXwgu
         8yJAlsfJSazugPPU/3njOegMi2CqANLWKr5BzDAaSQF7/U9LsTXk2L4Aig1Is8MXGuWW
         TaNJDHzlr99L272to4nHXZ7xYK0ehxubJHBuzyOjo02nxzGnZqlT3/39A0/mOTqqsIh6
         rWMBgczwRF5VSHxWsJuAeTV/bhPIL4WwzAnwCqHUu/3f6QfJk7bPSzp4OqaM+u/unwvi
         G8Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWMTuUZe3tc0WoAoMjR+wLJ3ax4C+CfMOVs/B8roTIvfqjxbYu/95U+hEK+icdzJEiFezyhEOMqAttMQQdlc3CdwIM4tKUPjdv82QJ16mCBSTswGTrcQWz7KnHtw4onrFSj3HQoGQeFvInoHq3YmpiBjPvW9DlwAptjPiQ5SWTmrd2D5jEPtPmSHbPakuYY7VcNFflyBVh8e7oikIyzQBnWrIenQN4=
X-Gm-Message-State: AOJu0YzoQc62XUjq6xApVCLKOUD3ol0wPE7ELHe7Of91TfdXa4MeSVkL
	jwzZFkzNEK3cOs50g9KUMSbDsTeDP1m3YsEU0u/X9c9U6NEM7kYivscbuA==
X-Google-Smtp-Source: AGHT+IFVOcJgwMnCsAeqQiZdTZs0AWrij7s+j6kS/5GzLBAoTaFQvQo/XUT/labHKgaPPOl3vXnwhQ==
X-Received: by 2002:a05:600c:3b92:b0:426:5dd5:f245 with SMTP id 5b1f17b1804b1-428e6af8117mr70070985e9.2.1722948767137;
        Tue, 06 Aug 2024 05:52:47 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:b50e:24fa:fd17:c835])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6d648a0sm179487255e9.10.2024.08.06.05.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:52:46 -0700 (PDT)
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
Subject: [PATCH v3 0/4] Introduce userspace-driven ALSA timers
Date: Tue,  6 Aug 2024 13:52:39 +0100
Message-Id: <20240806125243.449959-1-ivan.orlov0322@gmail.com>
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

Please, find the patch-specific changelog in the following patches.

Ivan Orlov (4):
  ALSA: aloop: Allow using global timers
  Docs/sound: Add documentation for userspace-driven ALSA timers
  ALSA: timer: Introduce virtual userspace-driven timers
  selftests: ALSA: Cover userspace-driven timers with test

 Documentation/sound/index.rst               |   1 +
 Documentation/sound/utimers.rst             | 120 +++++++++++
 include/uapi/sound/asound.h                 |  20 +-
 sound/core/Kconfig                          |  10 +
 sound/core/timer.c                          | 221 ++++++++++++++++++++
 sound/drivers/aloop.c                       |   2 +
 tools/testing/selftests/alsa/Makefile       |   2 +-
 tools/testing/selftests/alsa/global-timer.c |  87 ++++++++
 tools/testing/selftests/alsa/utimer-test.c  | 170 +++++++++++++++
 9 files changed, 631 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/sound/utimers.rst
 create mode 100644 tools/testing/selftests/alsa/global-timer.c
 create mode 100644 tools/testing/selftests/alsa/utimer-test.c

-- 
2.34.1


