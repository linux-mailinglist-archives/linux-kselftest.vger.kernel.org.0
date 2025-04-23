Return-Path: <linux-kselftest+bounces-31406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335C7A98F7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537BD5A732C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACC028540E;
	Wed, 23 Apr 2025 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pa4zyvLy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B9356qdh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B028469E;
	Wed, 23 Apr 2025 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420503; cv=none; b=tIWke4z4m0EA+M/BE57GvNIbTAAAId2DaTCCp3r4NZ/4WdnAu1YwVF7FDI0m8Oz09m6Cf7OkLsgtM5w9Q1IZv0XsZHccphEDAbD4B/9OwQbNNjQAWgbiDqsPw1ZAC8wqVNlQVhrTR0qYysexpzAEqKGri6WKp7IbB8tVLG0rM7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420503; c=relaxed/simple;
	bh=hQ2b6646ySA6SY1fU7pM29KKP/mxFAlDV118VMCkMhA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aES6RgTLIXHva9h5ZOhRhDzOH7y2EL9+MUNZl8P/cNIuK8PlMR1xzpilTvsdnxunOCFzFqEVKmijtOEQvNKLTM1sJuATXPNp0Ub6pBoPU7K9t06yHBZh9V6ax068iD3lBSGXvFKoG77lejc0OCTAAIgKtxJYYfLelXCqdZj1tzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pa4zyvLy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B9356qdh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EGW7n8vgR4SKmGcwLl0NN4irjHrS1VJiwV5JhVh9NKk=;
	b=Pa4zyvLy8dZnZJQe1eQecvaELd1oc91s+Bw5MZssd68I3hi6/he3yXj+J0DxEGRghgi4wi
	/oBxwJD6cG1gmxSy1MaBldvIgoLqvaJdtY33BOReQFf6JY8241YfXLUY45udrbfatUBjHy
	gevl5QegoXEOrT7Gw8vKVPqsOifiq6Y8CPVWTakR6aqTl7+FbupQmGRgwslYiFLaCpHlbv
	CNDLIAYq7ZnDRYl4F3pvyrRM+rHbywV/FC762tFBBx1AMAZEjlELK2M6d83H0515+CBZJ4
	N9HyklFNkFztYE1ROhRSYHbQs3dcofbVjY21MYBqFkTRasy10KeohB3xL0GdfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EGW7n8vgR4SKmGcwLl0NN4irjHrS1VJiwV5JhVh9NKk=;
	b=B9356qdhulGxIQbF3f079bX/1OfyH0qeCIbiB7Dv6j6A7ImsdPSBLLiSEGKmAJyXzb33Bx
	9mDvPFmu1QID32DA==
Subject: [PATCH 00/15] tools/nolibc: various new functions
Date: Wed, 23 Apr 2025 17:01:30 +0200
Message-Id: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMoACWgC/x3MQQqAIBBA0avErBNUHIiuEi1qGmugNBQiEO+et
 HyL/wtkTsIZxq5A4keyxNBg+g7oWMLOSrZmsNqidgZViKespC7JpLxFNxAREhtoxZ3Yy/vfprn
 WDyMFXqZdAAAA
X-Change-ID: 20250415-nolibc-misc-f2548ccc5ce1
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=2351;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=hQ2b6646ySA6SY1fU7pM29KKP/mxFAlDV118VMCkMhA=;
 b=AIDaAGL2sE3IH5mVQ3d64VfjQfKXTYEi6vc9wnsGY+qWXqK6BwlnlIepSbCpL4zwK8tI3DVka
 LZr07QW651LA0/NPmyaRou1CjMsnUYl9T6Dwo0frsD3frpcGSDKRAKd
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

A few functions used by different selftests.
Adding them now avoids later conflicts between different selftest serieses.

Also add full support for nolibc-test.c on riscv32.
All unsupported syscalls have been replaced.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (15):
      tools/nolibc: add strstr()
      tools/nolibc: add %m printf format
      tools/nolibc: add more stat() variants
      tools/nolibc: add mremap()
      tools/nolibc: add getrandom()
      tools/nolibc: add abs() and friends
      tools/nolibc: add support for access() and faccessat()
      tools/nolibc: add clock_getres(), clock_gettime() and clock_settime()
      tools/nolibc: add timer functions
      tools/nolibc: add timerfd functionality
      tools/nolibc: add difftime()
      tools/nolibc: add namespace functionality
      tools/nolibc: add fopen()
      tools/nolibc: implement fall back to sys_clock_gettime() in gettimeofday()
      tools/nolibc: implement wait() in terms of waitpid()

 tools/include/nolibc/Makefile                |   4 +
 tools/include/nolibc/math.h                  |  31 ++++
 tools/include/nolibc/nolibc.h                |   4 +
 tools/include/nolibc/sched.h                 |  50 ++++++
 tools/include/nolibc/stdio.h                 |  34 ++++
 tools/include/nolibc/stdlib.h                |  18 ++
 tools/include/nolibc/string.h                |  20 +++
 tools/include/nolibc/sys/mman.h              |  19 ++
 tools/include/nolibc/sys/random.h            |  32 ++++
 tools/include/nolibc/sys/stat.h              |  25 ++-
 tools/include/nolibc/sys/time.h              |  15 +-
 tools/include/nolibc/sys/timerfd.h           |  87 +++++++++
 tools/include/nolibc/sys/wait.h              |  12 +-
 tools/include/nolibc/time.h                  | 185 +++++++++++++++++++
 tools/include/nolibc/types.h                 |   3 +
 tools/include/nolibc/unistd.h                |  28 +++
 tools/testing/selftests/nolibc/Makefile      |   2 +
 tools/testing/selftests/nolibc/nolibc-test.c | 254 ++++++++++++++++++++++++++-
 18 files changed, 811 insertions(+), 12 deletions(-)
---
base-commit: e90ce42e81381665dbcedc5fa12e74759ee89639
change-id: 20250415-nolibc-misc-f2548ccc5ce1

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


