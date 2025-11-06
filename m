Return-Path: <linux-kselftest+bounces-44898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0279C3A035
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 11:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B9B189A2A5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 10:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96E730DD11;
	Thu,  6 Nov 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rNvfheX1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DOWu3kEq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5232E284A;
	Thu,  6 Nov 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423337; cv=none; b=fqhSDgZrnnAHW/jCaLdM18Xe4ZsNkFcIXUIhEsTdTItOnAreVucoHpwzuuUzZdjNZL+UBHsO4J+xfVF97Z5TFXvYRkg3kphK5ZCl7AzR8Uve1/uo6C/ngrf9iH35gPQk34yH0uuJ96rIBfM/egZvgD/TwqcrxEVuPKJsQdovtvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423337; c=relaxed/simple;
	bh=6fe5s/8WXt8LDR1x1k083tpK7z5zoUWlL2PJcCJcAEw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hlQECERhiE2Cui3mRRe5G16jrgMLfiNJTXPJKVA59wX/vWQ/pD9s/MM/t7pQOZQCgTcQMnhRCMMuXCS36KKjOvXKB29jNljs0XyOHVwe+Hu/Ha39MqOj6v7SyD5uK/HPivo1q2Zs5/dd895nuMQ5KqJO8Oim9cIUnMGCDOjkL0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rNvfheX1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DOWu3kEq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762423329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Xf1oeyZG1ZKuwhbZo2PyJCzRemXmJJv42128shNqao=;
	b=rNvfheX1EV1aGgCBXYREO1AE3dBkrvMh7lQkLkDVFLIbsHNNwskDM3tD4J+isZ6YJM1Fc8
	yV7QTeJIm00gwhP9xT4Doc37juDV2L8xyl2yCMSV31xfF2XSRrj/upGwE/PC5/NYy4D+KZ
	T3dlhyrUOF4xiwQKVCi1rnDlWXFn3Pywsay6obbIH3o6VarXQgLohrx2qse6GEjEf851XP
	9zs0xWU7nYJDuphFpfs59n4p/++mn00jz76DkvXPFGC1mO9YJJz3hDOkPZNq8s/g1rfeiO
	gUVj8Qq3jGOgOsrf3W6L8uSPvKWapWZZ7c8kuixCJv4XYaC53rvdX09bJBL6oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762423329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Xf1oeyZG1ZKuwhbZo2PyJCzRemXmJJv42128shNqao=;
	b=DOWu3kEqoRIllLk+F51f/k3q3NnyXpuXoJyXij8n9lLnQZxlfacIga6q8FDbG4UyRy8Exc
	dXeOolc1PDMyWVBw==
Subject: [PATCH v5 00/34] sparc64: vdso: Switch to the generic vDSO library
Date: Thu, 06 Nov 2025 11:01:53 +0100
Message-Id: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABJyDGkC/3XPTYoCMRAF4KtI1hNJKr/tynvILDpJRQNDWhINi
 vTdJy3MCGIvX8H7ivcgFUvCSnabBynYUk1T7kF9bYg/jfmINIWeCTBQzADQFupE63ksXkt6xNz
 rngIFFQGZsjiAJ718LhjT7Qkfvns+pXqZyv35p/Hl+kfKNbJxyigKo0fhAsjA9z8pXy9lyum2D
 UgWtsGLslytUtApp2K0TBsQ0nyixIsauFmlRKeENoPjzltE+4mS/xRnfH2gXAYyzYyLcgg4vlP
 zPP8C9gA4QKEBAAA=
X-Change-ID: 20250722-vdso-sparc64-generic-2-25f2e058e92c
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Shuah Khan <shuah@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Shannon Nelson <sln@onemain.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Arnd Bergmann <arnd@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762423327; l=7494;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=6fe5s/8WXt8LDR1x1k083tpK7z5zoUWlL2PJcCJcAEw=;
 b=rCuKSMr6iJrvIuN8HAr9NkC+5G1piq0o1jjz4q0RyKSUW0yPa4W0eF4Ciut3f9pmozkQphTjR
 6O/EemPcZ2GAsAcXeyi0kkML8xnkho/tNgVP3ZMddFBB/oPyCJw0Zd4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic vDSO provides a lot common functionality shared between
different architectures. SPARC is the last architecture not using it,
preventing some necessary code cleanup.

Make use of the generic infrastructure.

Follow-up to and replacement for Arnd's SPARC vDSO removal patches:
https://lore.kernel.org/lkml/20250707144726.4008707-1-arnd@kernel.org/

SPARC64 can not map .bss into userspace, so the vDSO datapages are
switched over to be allocated dynamically. This requires changes to the
s390 and random subsystem vDSO initialization as preparation.
The random subsystem changes in turn require some cleanup of the vDSO
headers to not end up as ugly #ifdef mess.

Tested on a Niagara T4 and QEMU.

This has a semantic conflict with my series "vdso: Reject absolute
relocations during build" [0]. The last patch of this series expects all
users of the generic vDSO library to use the vdsocheck tool.
This is not the case (yet) for SPARC64. I do have the patches for the
integration, the specifics will depend on which series is applied first.

Based on v6.18-rc1.

[0] https://lore.kernel.org/lkml/20250812-vdso-absolute-reloc-v4-0-61a8b615e5ec@linutronix.de/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v5:
- Merge the patches for 'struct page' mapping and dynamic allocation
- Zero out newly-allocated data pages
- Pick up review tags
- Link to v4: https://lore.kernel.org/r/20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de

Changes in v4:
- Rebase on v6.18-rc1.
- Keep inclusion of asm/clocksource.h from linux/clocksource.h
- Reword description of "s390/time: Set up vDSO datapage later"
- Link to v3: https://lore.kernel.org/r/20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de

Changes in v3:
- Allocate vDSO data pages dynamically (and lots of preparations for that)
- Drop clock_getres()
- Fix 32bit clock_gettime() syscall fallback
- Link to v2: https://lore.kernel.org/r/20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de

Changes in v2:
- Rebase on v6.17-rc1
- Drop RFC state
- Fix typo in commit message
- Drop duplicate 'select GENERIC_TIME_VSYSCALL'
- Merge "sparc64: time: Remove architecture-specific clocksource data" into the
  main conversion patch. It violated the check in __clocksource_register_scale()
- Link to v1: https://lore.kernel.org/r/20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de

---
Arnd Bergmann (1):
      clocksource: remove ARCH_CLOCKSOURCE_DATA

Thomas Weißschuh (33):
      selftests: vDSO: vdso_test_correctness: Handle different tv_usec types
      arm64: vDSO: getrandom: Explicitly include asm/alternative.h
      arm64: vDSO: gettimeofday: Explicitly include vdso/clocksource.h
      arm64: vDSO: compat_gettimeofday: Add explicit includes
      ARM: vdso: gettimeofday: Add explicit includes
      powerpc/vdso/gettimeofday: Explicitly include vdso/time32.h
      powerpc/vdso: Explicitly include asm/cputable.h and asm/feature-fixups.h
      LoongArch: vDSO: Explicitly include asm/vdso/vdso.h
      MIPS: vdso: Add include guard to asm/vdso/vdso.h
      MIPS: vdso: Explicitly include asm/vdso/vdso.h
      random: vDSO: Add explicit includes
      vdso/gettimeofday: Add explicit includes
      vdso/helpers: Explicitly include vdso/processor.h
      vdso/datapage: Remove inclusion of gettimeofday.h
      vdso/datapage: Trim down unnecessary includes
      random: vDSO: trim vDSO includes
      random: vDSO: remove ifdeffery
      random: vDSO: split out datapage update into helper functions
      random: vDSO: only access vDSO datapage after random_init()
      s390/time: Set up vDSO datapage later
      vdso/datastore: Reduce scope of some variables in vvar_fault()
      vdso/datastore: Drop inclusion of linux/mmap_lock.h
      vdso/datastore: Allocate data pages dynamically
      sparc64: vdso: Link with -z noexecstack
      sparc64: vdso: Remove obsolete "fake section table" reservation
      sparc64: vdso: Replace code patching with runtime conditional
      sparc64: vdso: Move hardware counter read into header
      sparc64: vdso: Move syscall fallbacks into header
      sparc64: vdso: Introduce vdso/processor.h
      sparc64: vdso: Switch to the generic vDSO library
      sparc64: vdso2c: Drop sym_vvar_start handling
      sparc64: vdso2c: Remove symbol handling
      sparc64: vdso: Implement clock_gettime64()

 arch/arm/include/asm/vdso/gettimeofday.h           |   2 +
 arch/arm64/include/asm/vdso/compat_gettimeofday.h  |   3 +
 arch/arm64/include/asm/vdso/gettimeofday.h         |   2 +
 arch/arm64/kernel/vdso/vgetrandom.c                |   2 +
 arch/loongarch/kernel/process.c                    |   1 +
 arch/loongarch/kernel/vdso.c                       |   1 +
 arch/mips/include/asm/vdso/vdso.h                  |   5 +
 arch/mips/kernel/vdso.c                            |   1 +
 arch/powerpc/include/asm/vdso/gettimeofday.h       |   1 +
 arch/powerpc/include/asm/vdso/processor.h          |   3 +
 arch/s390/kernel/time.c                            |   4 +-
 arch/sparc/Kconfig                                 |   3 +-
 arch/sparc/include/asm/clocksource.h               |   9 -
 arch/sparc/include/asm/processor.h                 |   3 +
 arch/sparc/include/asm/processor_32.h              |   2 -
 arch/sparc/include/asm/processor_64.h              |  25 --
 arch/sparc/include/asm/vdso.h                      |   2 -
 arch/sparc/include/asm/vdso/clocksource.h          |  10 +
 arch/sparc/include/asm/vdso/gettimeofday.h         | 184 ++++++++++
 arch/sparc/include/asm/vdso/processor.h            |  41 +++
 arch/sparc/include/asm/vdso/vsyscall.h             |  10 +
 arch/sparc/include/asm/vvar.h                      |  75 ----
 arch/sparc/kernel/Makefile                         |   1 -
 arch/sparc/kernel/time_64.c                        |   6 +-
 arch/sparc/kernel/vdso.c                           |  69 ----
 arch/sparc/vdso/Makefile                           |   8 +-
 arch/sparc/vdso/vclock_gettime.c                   | 380 ++-------------------
 arch/sparc/vdso/vdso-layout.lds.S                  |  26 +-
 arch/sparc/vdso/vdso.lds.S                         |   2 -
 arch/sparc/vdso/vdso2c.c                           |  24 --
 arch/sparc/vdso/vdso2c.h                           |  45 +--
 arch/sparc/vdso/vdso32/vdso32.lds.S                |   4 +-
 arch/sparc/vdso/vma.c                              | 274 +--------------
 drivers/char/random.c                              |  71 ++--
 include/linux/clocksource.h                        |   6 +-
 include/linux/vdso_datastore.h                     |   6 +
 include/vdso/datapage.h                            |  23 +-
 include/vdso/helpers.h                             |   1 +
 init/main.c                                        |   2 +
 kernel/time/Kconfig                                |   4 -
 lib/vdso/datastore.c                               |  74 ++--
 lib/vdso/getrandom.c                               |   3 +
 lib/vdso/gettimeofday.c                            |  17 +
 .../testing/selftests/vDSO/vdso_test_correctness.c |   8 +-
 44 files changed, 449 insertions(+), 994 deletions(-)
---
base-commit: 28b1ac5ccd8d4900a8f53f0e6e84d517a7ccc71f
change-id: 20250722-vdso-sparc64-generic-2-25f2e058e92c

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


