Return-Path: <linux-kselftest+bounces-31766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B74A9F0F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6058A171B47
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7043269CFA;
	Mon, 28 Apr 2025 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHG2QpPl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cPmn7BHM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21691262FD9;
	Mon, 28 Apr 2025 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844012; cv=none; b=RuLOxvpq4uTAwdN7c99iKcD1cjT38AZeTmgEVekPmIhzDiQYIxCBQJzFaZzWVtfFTPB24pUbV5eOeT8dNPkoUtAoqTcNHy4wOJKtuzUB8sYpUSbYNbalzFEn3pg0FPZCkvrbBSV726elCOH0ktLraTAJHFIqJEbCQQ862RIFROs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844012; c=relaxed/simple;
	bh=6+1wE/rDVGwb0zByatbK820UomdrOqcUZVOhk1n2Upg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BZTnKjagjBn112AJoX9bY6Bp6yxNO5gzMDK+qHbJxPsr908jwV5K04S+A8UY091wf14b16M4ZzQlHgFgpE0zSbqneoEhWft7p2YvvdMVg69914aBYOuaS27XxcBnU3WtGzs0LqhfvQ/5eSf0KRfKYfBH+7XxFeo/QUtQnJI98MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHG2QpPl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cPmn7BHM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A89t9NwmZgyjxocPG+k4LYkN3pxNO1DzYtqfbEeToIo=;
	b=GHG2QpPlEyQrIYfHRTF1WeAa4x1pVhZr7ThF7+pf+4nJKdoatsSbDOAjNVA9iLPICYIQ+S
	YY/jTJ79gfiJzL44ZkGcKYx22wYfT3QmjeefPGOdnLm3ASNduTyhl8RlhY1uipIaGTtpzI
	xf3UPYd2SK59gzq5OgU5dCp+c4g343j77ggdXsGLWvEwX2To1xMLUpr2OrCwYfEGTwHE7N
	aHBSgHqqy89cCawad3ubEAFoLNv4SNNQnMfRJuKhm3A3PKR7jB1OzdT7KicZGIP3IZDnRR
	58HR+NGUJ4JIe9kypPe8/KMHFJyq7DIcjkIzM8vZA84QUpurKbXQK/ZMpmJlkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A89t9NwmZgyjxocPG+k4LYkN3pxNO1DzYtqfbEeToIo=;
	b=cPmn7BHMCPaIESNxGWsT2OuHnSggh0o+3cK326EJ7792ZMwD73QS+C4M71KEBUO33O6nzu
	6mxYERp6B6byQgDQ==
Subject: [PATCH v2 00/15] tools/nolibc: various new functions
Date: Mon, 28 Apr 2025 14:40:01 +0200
Message-Id: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACF3D2gC/1XMQQ6CMBCF4auQWVvTjjSKK+9hWNBhkEmwJS0SD
 OHuVuLG5f+S962QOAonuBYrRJ4lSfA58FAA9Y1/sJI2N6BGq0tjlQ+DOFJPSaQ6tOWFiCyxgfw
 YI3ey7Nq9zt1LmkJ87/hsvuvPwdOfMxulVVOhdV2psTq72yD+NcXgZTm2DPW2bR8FErMSqgAAA
 A==
X-Change-ID: 20250415-nolibc-misc-f2548ccc5ce1
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=2714;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=6+1wE/rDVGwb0zByatbK820UomdrOqcUZVOhk1n2Upg=;
 b=PGkhWbZQZ/6k2LXhU8DRuWwRhLnl5enHVaEfRd1dWG646AmlZUloetKjYzhw1H8YiiF13ye+T
 AKLchE1zy6CCN3rqIHPl2/pYkNrA7pBSXgkBioMHUk/UkSNnRuHORJP
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

A few functions used by different selftests.
Adding them now avoids later conflicts between different selftest serieses.

Also add full support for nolibc-test.c on riscv32.
All unsupported syscalls have been replaced.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Rebase onto latest nolibc next branch
- Move #include "nolibc.h" to the top of the headers
- Include linux/random.h from sys/random.h
- Don't block on missing entropy in getrandom() selftest
- Also test negative result of difftime()
- Simplify fopen()
- Link to v1: https://lore.kernel.org/r/20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de

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
      tools/nolibc: fall back to sys_clock_gettime() in gettimeofday()
      tools/nolibc: implement wait() in terms of waitpid()

 tools/include/nolibc/Makefile                |   4 +
 tools/include/nolibc/math.h                  |  31 ++++
 tools/include/nolibc/nolibc.h                |   4 +
 tools/include/nolibc/sched.h                 |  50 +++++
 tools/include/nolibc/stdio.h                 |  27 +++
 tools/include/nolibc/stdlib.h                |  18 ++
 tools/include/nolibc/string.h                |  20 ++
 tools/include/nolibc/sys/mman.h              |  19 ++
 tools/include/nolibc/sys/random.h            |  34 ++++
 tools/include/nolibc/sys/stat.h              |  25 ++-
 tools/include/nolibc/sys/time.h              |  15 +-
 tools/include/nolibc/sys/timerfd.h           |  87 +++++++++
 tools/include/nolibc/sys/wait.h              |  12 +-
 tools/include/nolibc/time.h                  | 185 ++++++++++++++++++
 tools/include/nolibc/types.h                 |   3 +
 tools/include/nolibc/unistd.h                |  28 +++
 tools/testing/selftests/nolibc/Makefile      |   2 +
 tools/testing/selftests/nolibc/nolibc-test.c | 268 ++++++++++++++++++++++++++-
 18 files changed, 820 insertions(+), 12 deletions(-)
---
base-commit: 2051d3b830c0889ae55e37e9e8ff0d43a4acd482
change-id: 20250415-nolibc-misc-f2548ccc5ce1

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


