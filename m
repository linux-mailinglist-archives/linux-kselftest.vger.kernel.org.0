Return-Path: <linux-kselftest+bounces-37911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED144B1007E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18424E70A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 06:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A4B21771C;
	Thu, 24 Jul 2025 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Qq14tzp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ykve/r8/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4323E28F4;
	Thu, 24 Jul 2025 06:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338437; cv=none; b=qjOAc6RtxS758dQklWV0bxKW6IleAXltv1K/qRUFp3AmPcO/MHa2hGosr7VuNrjk7UFaVIAK3NcjkwVf+bGoBblb6a+p6EJ0z8HRmzTiDV7RebJ3tCC3vdLZkIpkWVA7M9h/ShvJkD4YQqREid48DJPOQykWgvuiw/jkXG2RoXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338437; c=relaxed/simple;
	bh=TrF4xqUZK+Vd+evJ92Dgw+rUH50oTc3RMh2IxgmrhVI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lPqzQrlAyW13mkZ2t9PWLM4FA0DfvpfflU7hFM3wiwarWDAGuNpnZ6AXUSoINAg7HUP3wTTF671vwt9xjBKcvSdiOezyBk/vQxq0DzGtujMNjqKDFL8MB729iPHqvPR5+wK1sy7Kgrf1pxhXhmMv4BEjkf47th9l5V1L/dF6h4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Qq14tzp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ykve/r8/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753338433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AiArhoSmKUNPfWncPfQ/ZyOLrROsp75F0zcISuEVl48=;
	b=2Qq14tzpMNRSVeBIQypPEnJDr/FpR/cA8LlJgX+RQvLmkRznkWTroFKU8+Ha42LNU+TOqC
	pwCFoHVL5rmmba0FG6CD9FIIXKA71CUDdOzNnxWnqgbEBDkKGc78xSlX4rIQCEgzdp5XLf
	vIWm0RpZvgW4FF8gLUwtLomcT+iaqeinfZvuZJ1Jq2TJ4mZ7Zp0w4QnZJICi3uzP+D0AMp
	fSBfd+blzim0o1oL7P4RVILpoZYn6Ql0ZaH/pStqlZuAu18xgkC5js6Q+mA+559rsH3gfa
	xmqDi9oi8+RI5vTEIuJNYf0XKkg9OZJOstDAPTy3hTGD0XV00rJJq2ueTJQpvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753338433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AiArhoSmKUNPfWncPfQ/ZyOLrROsp75F0zcISuEVl48=;
	b=Ykve/r8/C3UX5kqSrbZpkowkYYj9zISinOrumxjJK2yTUxqb3ruRnNtTsdDwCSa19gB9yd
	Off3atHvxUSbYWBg==
Subject: [PATCH RFC 00/14] sparc64: vdso: Switch to generic vDSO library
Date: Thu, 24 Jul 2025 08:26:50 +0200
Message-Id: <20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACrSgWgC/x3MPQqAMAxA4atIZgM1WP9WwQO4ioPUqFmqNFAE8
 e4Wxzd87wHlIKzQZQ8EjqJy+hRFnoE7Fr8zypoayJA1NRHGVU/UawmuKnFnn7hDQrIbsbENt+Q
 g4SvwJvc/nmAcepjf9wOOGCjTbQAAAA==
X-Change-ID: 20250722-vdso-sparc64-generic-2-25f2e058e92c
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Arnd Bergmann <arnd@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753338429; l=3092;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=TrF4xqUZK+Vd+evJ92Dgw+rUH50oTc3RMh2IxgmrhVI=;
 b=flHfdy6fiBk+6xeD1ylLvgL5s7I1iuV/Sq11RK1dj7dzmDnJVtzpCISCg7mwusE5AdCSr5Ysl
 oM22DsB3c/ICDFQd9JSHc5OFUsqwfmzprEfmtG3hUXEmsiaNTXBbocD
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic vDSO provides a lot common functionality shared between
different architectures. SPARC is the last architecture not using it,
preventing some necessary code cleanup.

Make use of the generic infrastructure.

Follow-up to and replacement for Arnd's SPARC vDSO removal patches:
https://lore.kernel.org/lkml/20250707144726.4008707-1-arnd@kernel.org/

Only tested on QEMU.
Based von v6.16-rc1.
Marked as RFC for testing and review only.
Will be properly resubmitted after v6.17-rc1.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Arnd Bergmann (1):
      clocksource: remove ARCH_CLOCKSOURCE_DATA

Thomas Weißschuh (13):
      vdso: add struct __kernel_old_timeval forward declaration to gettime.h
      sparc64: time: Remove architecture-specific clocksource data
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
      sparc64: vdso: Implement clock_getres()

 arch/sparc/Kconfig                         |   5 +-
 arch/sparc/include/asm/clocksource.h       |   9 -
 arch/sparc/include/asm/processor.h         |   3 +
 arch/sparc/include/asm/processor_32.h      |   2 -
 arch/sparc/include/asm/processor_64.h      |  25 --
 arch/sparc/include/asm/vdso.h              |   2 -
 arch/sparc/include/asm/vdso/clocksource.h  |  10 +
 arch/sparc/include/asm/vdso/gettimeofday.h | 208 ++++++++++++++++
 arch/sparc/include/asm/vdso/processor.h    |  41 ++++
 arch/sparc/include/asm/vdso/vsyscall.h     |  10 +
 arch/sparc/include/asm/vvar.h              |  75 ------
 arch/sparc/kernel/Makefile                 |   1 -
 arch/sparc/kernel/time_64.c                |   6 +-
 arch/sparc/kernel/vdso.c                   |  69 ------
 arch/sparc/vdso/Makefile                   |   8 +-
 arch/sparc/vdso/vclock_gettime.c           | 382 +++--------------------------
 arch/sparc/vdso/vdso-layout.lds.S          |  26 +-
 arch/sparc/vdso/vdso.lds.S                 |   4 +-
 arch/sparc/vdso/vdso2c.c                   |  24 --
 arch/sparc/vdso/vdso2c.h                   |  45 +---
 arch/sparc/vdso/vdso32/vdso32.lds.S        |   6 +-
 arch/sparc/vdso/vma.c                      | 274 ++-------------------
 include/linux/clocksource.h                |   6 +-
 include/vdso/gettime.h                     |   1 +
 kernel/time/Kconfig                        |   4 -
 25 files changed, 344 insertions(+), 902 deletions(-)
---
base-commit: eaa6313d2ceb2a3f1c870866621058ad6081f028
change-id: 20250722-vdso-sparc64-generic-2-25f2e058e92c

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


