Return-Path: <linux-kselftest+bounces-25536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23141A25546
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73C3163111
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6812940F;
	Mon,  3 Feb 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BM1GBrcV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PSgoz+LE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFA710FD;
	Mon,  3 Feb 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573521; cv=none; b=F42iUWm6vmuF9QWNE00laIDGlD0yITVN/aC6vDGfgLhM1h3UnOwAVVKIRuyY5Z2MDWEhT1+/84uvFNBrT+ShpfJ18xJiUqzctnewwYTT/XbxM/4qbtJah1X6s726hWl95LESV5ztWlOBNlTmSHkEy9IeV8y55UgVTnvPenhmyYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573521; c=relaxed/simple;
	bh=qtkd2hdCgBubVpgZ1f1WoWHy4juewr1fhnt4HoOoStA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NuemHs6ylqzWRmHPYl//MjFmSb2cwJl+erhfuBosSKAQklSxpyt5dC8Q6NLDW9sfLGxcDXCipyHNV/p5hmruXgRWICTy1kt//5lWKOayfO2YORgsoJm94BJBHvRRM9l5xsjDbTQELksqsfAMXrqFtBiRtzmk+SLT992AyvW1neQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BM1GBrcV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PSgoz+LE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738573518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9svjg41Pcb4q95Hb5VGVK6lEZkIdj5uSqvXSpwTfMMw=;
	b=BM1GBrcVmwsrWLB5GL/P7R2WZVy4r1YQMh38SOtwBzuTh3DrDOBx5Yhdfk4X1+Ra3ITZvB
	r6O9ETIO6uY1dbP+UcxA4jfZoQBHmM7jXzAACBzv0QqXhgg/x6RToCBLVkUrDd2knqautK
	ihpEG8+1j/QWtTjdCBwCn0NBPppzLwwuVW1W1aYjD3lx38dV+efbGq7roO85bV/Rz2pd+N
	Agqco1X35M/6QHIJGYlbOWBAr21Y0muexY72TsI+8SYFZcgNBYz7ZyMPFHfVWW6MjiylaS
	K5r+9XZin+kI9ze5DmIf+Sd3KymyDwj4xtWJrFF9cu76GOLfiueb5HoVgpH83g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738573518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9svjg41Pcb4q95Hb5VGVK6lEZkIdj5uSqvXSpwTfMMw=;
	b=PSgoz+LEZ7QYWOCfE3g0Yk/sneAv7deJOU9lK8CtdBb0YbUVRbW9sjJQOu8Wqre3b4M+h9
	BshUpUhKGHAvqDDA==
Subject: [PATCH 00/16] selftests: vDSO: parse_vdso: Make compatible with
 nolibc
Date: Mon, 03 Feb 2025 10:05:01 +0100
Message-Id: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL2GoGcC/22NQQqDMBBFryKzbkpG0lq76j2KlMRM6oAkkthgE
 e/e6LrL9+C/v0KiyJTgXq0QKXPi4AvgqYJ+0P5Ngm1hqGWtUGIjJh0TvbJNQfgwsukFyWtrtG6
 cUzcouymS4+VoPrvCA6c5xO9xkXG3e+0isZZ/ahmFFMZZQtMqrXp8jOw/cwyel7Ml6LZt+wFYQ
 wXjtgAAAA==
X-Change-ID: 20241017-parse_vdso-nolibc-e069baa7ff48
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738573516; l=2806;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=qtkd2hdCgBubVpgZ1f1WoWHy4juewr1fhnt4HoOoStA=;
 b=LD5lsmGmNqSYedmVbHeUuJTWpDkVvxKJxLsowMuVyi/7+rXSPvYRp5crdhi93iVtgj2kyZqyb
 GfzR9bRQ3uyDePHXT4ZnkkKadNUFjRZDuQDFZiqWo3mPIt0XCT5CnTm
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

For testing the functionality of the vDSO, it is necessary to build
userspace programs for multiple different architectures.
It is additional work to acquire matching userspace cross-compilers with
full C libraries and then building root images out of those.
The kernel tree already contains nolibc, a small, header-only C library.
By using it, it is possible to build userspace programs without any
additional dependencies.
For example the kernel.org crosstools or multi-target clang can be used
to build test programs for a multitude of architectures.
While nolibc is very limited, it is enough for many selftests.
With some minor adjustments it is possible to make parse_vdso.c
compatible with nolibc.
As an example, vdso_standalone_test_x86 is now built from the same C
code as the regular vdso_test_gettimeofday, while still being completely
standalone.

This should probably go through the kselftest tree.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (16):
      MAINTAINERS: Add vDSO selftests
      elf, uapi: Add definition for STN_UNDEF
      elf, uapi: Add definition for DT_GNU_HASH
      elf, uapi: Add definitions for VER_FLG_BASE and VER_FLG_WEAK
      elf, uapi: Add type ElfXX_Versym
      elf, uapi: Add types ElfXX_Verdef and ElfXX_Veraux
      tools/include: Add uapi/linux/elf.h
      selftests: Add headers target
      selftests: vDSO: vdso_standalone_test_x86: Use vdso_init_form_sysinfo_ehdr
      selftests: vDSO: parse_vdso: Drop vdso_init_from_auxv()
      selftests: vDSO: parse_vdso: Use UAPI headers instead of libc headers
      selftests: vDSO: parse_vdso: Test __SIZEOF_LONG__ instead of ULONG_MAX
      selftests: vDSO: parse_vdso: Make compatible with nolibc
      selftests: vDSO: vdso_test_gettimeofday: Clean up includes
      selftests: vDSO: vdso_test_gettimeofday: Make compatible with nolibc
      selftests: vDSO: vdso_standalone_test_x86: Switch to nolibc

 MAINTAINERS                                        |   1 +
 include/uapi/linux/elf.h                           |  38 ++
 tools/include/uapi/linux/elf.h                     | 524 +++++++++++++++++++++
 tools/testing/selftests/lib.mk                     |   5 +-
 tools/testing/selftests/vDSO/Makefile              |  11 +-
 tools/testing/selftests/vDSO/parse_vdso.c          |  21 +-
 tools/testing/selftests/vDSO/parse_vdso.h          |   1 -
 .../selftests/vDSO/vdso_standalone_test_x86.c      | 143 +-----
 .../selftests/vDSO/vdso_test_gettimeofday.c        |   4 +-
 9 files changed, 584 insertions(+), 164 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20241017-parse_vdso-nolibc-e069baa7ff48

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


