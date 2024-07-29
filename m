Return-Path: <linux-kselftest+bounces-14364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA9A93F071
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 10:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342A51C2189E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 08:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A866B13D61D;
	Mon, 29 Jul 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB+joxwX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83D284A2B;
	Mon, 29 Jul 2024 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243561; cv=none; b=rx+RmWw4xLCoJgRclxCBAKSW1lg/ZSfWwvm57eXmBcn1UxlF3jqnRe7v5AmkRtM+hOFi8YdoiCaCsmIodQBFrnkq+mWx+/bIVe8dc9h9StJRPTroEgmr5yK6L5LRV+KpInn/7bXU39rr8Hg2fSRrwYZLo988W8nTxTbqdLn1qo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243561; c=relaxed/simple;
	bh=Tw/L9dgnMW3xX+rhBCNZSP/Kl1aUWPNQ+jQpDW4QRVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I0A3zMhDAD2hT4Ho9t1sczF5WoheBcoCDkDZBDVQo0a83RkBzUVQS0HnRhv4MEmwS83Yso07lpXVwxmMXELuWwQe3J/GvaVI2EEtcRVIkM95tDS7+ivR4zXt+CyuZVusK12Dv3375BZYgBJYT5cfQaG1vBkHo9avjH4Jg2PFRHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB+joxwX; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3684c05f7afso309494f8f.2;
        Mon, 29 Jul 2024 01:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722243558; x=1722848358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mlCrO/LKK5FH/hDGrTiQhEEZ/OeJfZqD6OtApt7y+Cg=;
        b=bB+joxwX+eTHpTziWdBshwYM9jQ9agtRJEOVeL68DOtZaUs2UDQDWjzVwas1mzEBSC
         cwwioEqW0VCztcw6v1ys2wRFgcLQvjGCoFtWovGRT7dLpR+4NkuKN3AtyqBoBHgdsT0d
         VSUiuOktOxrd0iTzMZClkgtVJzDvcraq2P1wAcCihvyFxzAhqNAANFrVAJzfL36UIJSV
         8tkeLd7EceDB85Urm9PQPSHcXMHp5MybfzlxKXfLvxZ5NdEevcCMD6cE5v1r7/V9Q1Ve
         yLXfxlN8rFCo8GTLCwnDyV7z+IwZKkPR1qnk89Xu4CXJoeTHKzQez5u/rxqqzkUn9MRW
         rX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722243558; x=1722848358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlCrO/LKK5FH/hDGrTiQhEEZ/OeJfZqD6OtApt7y+Cg=;
        b=iK4LIp8Rf14ZYEITAwrBrbpmWAUeN6mZqNyz9l3eifhIEixSYzUouZ58fW64LQ4izR
         QwgEJw0Nqoii0rOR1sss/u5Aku9vvU9624gdVR7TXr4WnHrl0gYMxdwV3S/LKkk9ww7a
         wR2fL3Atm0ezIlgmNCKgeIi8PpTg8Nl79gzDaqsQaVeBvwwCG+LkmXB0Uek3p04/ROmv
         6F91Lc7YXdrimrpEl12qxyahkB8U5RR95x80FQ9WnFTa//7MRImGWxrChQFHX5uwZUzs
         3qu5kp1pN6XPXIJ18Jsf8Y4D6/XHCuq7Xbq9S7wRiYQbzecWtwuCV35h+gtgD+ymWMWB
         YYlw==
X-Forwarded-Encrypted: i=1; AJvYcCUXlB9QvpWCn3u7IFlZY3XAVncYx+uKfSh3GSGXUy8kzd+knQWQqpS16jf3NNjUfGRPTYsqTc3sV6NdfvU=@vger.kernel.org, AJvYcCVKDn6BsxKjhskUBVDfTyvShg3RT9Ts2ToV/z1xxjGWk+3udhmIPpkXOPhzExYvoSDZWYvqKA5aIUBeU7FUGA1M@vger.kernel.org, AJvYcCW179B5GOdivk1m5fjmYTDOg1RtCHmm0KsKq39RuYZ7DEckwlKoBF4mKKRhJ4KXLAXWcEsvsuN8qXM=@vger.kernel.org, AJvYcCWdjg5nqnUkjcFv3wIRQrfMLneJkfyDfaL+pJxIedSbRNaCnmasYH8IECRyuJwpHVCZYlf0rhMPOccB72a5@vger.kernel.org
X-Gm-Message-State: AOJu0YzFuXMtbzdW7KFqD8lnMri6tDkf0KC6wO+ImKtkmrusX8hPtwHt
	vB7eOrWEQHgwYCMvIueGXD8Lk2EbF/GFL7symnRlo71g69E4/nSV
X-Google-Smtp-Source: AGHT+IEfMmjTdTfRv1TjWfkhgvQ5OexbQMmJwTiiiqUm3xUm0v9gmv5VviK0q9zHnLb0NG5QolFycA==
X-Received: by 2002:a5d:5f53:0:b0:368:aa2:2b4e with SMTP id ffacd0b85a97d-36b34d23accmr5244715f8f.4.1722243557886;
        Mon, 29 Jul 2024 01:59:17 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([31.94.28.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857e46sm11715337f8f.67.2024.07.29.01.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:59:17 -0700 (PDT)
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
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v2 0/4] Introduce userspace-driven ALSA timers
Date: Mon, 29 Jul 2024 09:59:01 +0100
Message-Id: <20240729085905.6602-1-ivan.orlov0322@gmail.com>
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

V2 of this patch series fixes some problems found by Christophe Jaillet
<christophe.jaillet@wanadoo.fr>. Please, find the patch-specific
changelog in the following patches.

Ivan Orlov (4):
  ALSA: aloop: Allow using global timers
  Docs/sound: Add documentation for userspace-driven ALSA timers
  ALSA: timer: Introduce virtual userspace-driven timers
  selftests: ALSA: Cover userspace-driven timers with test

 Documentation/sound/index.rst               |   1 +
 Documentation/sound/utimers.rst             | 120 +++++++++++
 include/uapi/sound/asound.h                 |  17 ++
 sound/core/Kconfig                          |  10 +
 sound/core/timer.c                          | 213 ++++++++++++++++++++
 sound/drivers/aloop.c                       |   2 +
 tools/testing/selftests/alsa/Makefile       |   2 +-
 tools/testing/selftests/alsa/global-timer.c |  87 ++++++++
 tools/testing/selftests/alsa/utimer-test.c  | 137 +++++++++++++
 9 files changed, 588 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/sound/utimers.rst
 create mode 100644 tools/testing/selftests/alsa/global-timer.c
 create mode 100644 tools/testing/selftests/alsa/utimer-test.c

-- 
2.34.1


