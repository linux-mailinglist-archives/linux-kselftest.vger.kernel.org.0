Return-Path: <linux-kselftest+bounces-47914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9803FCD84E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 07:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A137A3019E08
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 06:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095DF3043C8;
	Tue, 23 Dec 2025 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qx2emp6A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UZajqyzo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6200428980E;
	Tue, 23 Dec 2025 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473166; cv=none; b=ZfX0jOwrLT3uPcNq1OpS5jWr9YALDgHW4ymOfNOXnVAw/3gXLx/kQWhnTX898JzDOrsQb0pZor9/ZZjAhUK++dbVvdIAPpIzcpbgf82S+J6rPJwe0ZU9lVd7G7VbzfuRQzrsz9miyfIqtCKARGBpT+JOjvkVaw42IOBqJtH+nkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473166; c=relaxed/simple;
	bh=nczjxV6OWmkuLcjHG5boJWDUJPQIgRFXouBDrj7029I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ASM3PQ0yfxWAkWLjq8w2wI1ZRfQy04/lT120iwBLeKi0hr1ckUdmhwrPfMBYB15LNa11SJzivSfxlXlMUKJ1PYJcTNeeoPE12vSjI8zRnt4XVZHUrIC6K1CuLmSDG2IcIywSR6wZEbEWPT0UiElyBUza2y/+lQno9gTYwjvTzDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qx2emp6A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UZajqyzo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ayp3i9s7BDC9x4hTxnXWfTHnVTIsFOQvLKmvn+jnTBA=;
	b=qx2emp6AcoE/iRZCF+AQjiQqiaSI+h7BIY7Pz0OQRJsiPryNMbPcf5NQKo/4UfUhpEkrXi
	XR30A48OOgBD6gG4UL0k7wkfD7A16I/z1MlzssLS9HWYAkF9/GMg+MKqYe0Yy4e6lK5AQO
	R1xszn+I24MPGO2sxE/aHUmJ50OBwwsiDNuKr+cy9ykdEBZgNxixDCk7iIWinj41bmv9t9
	BNi9f6TeQ2cM2PwuVpJkP3zrcEfIbiJCc5IRXzuxkNxwalxU0c7Gkyt1MqnqzeNqAKF+Xe
	0iVbZu4+eTJX2EOKHjnlXnBBS8rRxshu0ZuM+2T3cGnt3ABL4/eQz0g/i+wrmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ayp3i9s7BDC9x4hTxnXWfTHnVTIsFOQvLKmvn+jnTBA=;
	b=UZajqyzonuVXLs77wufO/1MI8Geqjmdsrf08ZX5xkMboDv++CueqOZlv61m8wAeiZgTgUT
	O1OoIRhKsGjggDDw==
Subject: [PATCH 0/9] vDSO: Provide clock_getres_time64() where applicable
Date: Tue, 23 Dec 2025 07:59:11 +0100
Message-Id: <20251223-vdso-compat-time32-v1-0-97ea7a06a543@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL89SmkC/x3MQQqAIBBA0avErBvQySK6SrSwGmsWZWhIEN49a
 fkW/78QOQhHGKoXAieJ4s8CXVew7PbcGGUtBlLUak0K0xo9Lv647I23HNwQOtP1xjlq1WyhhFd
 gJ88/HaecPz6ntL5kAAAA
X-Change-ID: 20251120-vdso-compat-time32-f4684ff250ba
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Russell King <rmk+kernel@armlinux.org.uk>, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473161; l=1852;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=nczjxV6OWmkuLcjHG5boJWDUJPQIgRFXouBDrj7029I=;
 b=dvS9VqwRf71JdTyUUAt28L6LmZMazumZQNFfHH+8CiP0yKRfXkcnMbBFJvirOmlZ2u9wcrJiU
 fi0kJwWB4X0BPHUUkrP5+ntjOjHCHFIli44DVRgaSeTsxCD2jeobF5Q
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

For consistency with __vdso_clock_gettime64() there should also be a
64-bit variant of clock_getres(). This will allow the extension of
CONFIG_COMPAT_32BIT_TIME to the vDSO and finally the removal of 32-bit
time types from the kernel and UAPI.
    

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (9):
      vdso: Add prototype for __vdso_clock_getres_time64()
      selftests: vDSO: vdso_config: Add configurations for clock_getres_time64()
      selftests: vDSO: vdso_test_abi: Use UAPI system call numbers
      selftests: vDSO: vdso_test_abi: Add test for clock_getres_time64()
      x86/vdso: Provide clock_getres_time64() for x86-32
      ARM: VDSO: also patch out __vdso_clock_getres() if unavailable
      ARM: VDSO: provide clock_getres_time64()
      arm64: vdso32: Provide clock_getres_time64()
      MIPS: vdso: Provide getres_time64() for 32-bit ABIs

 arch/arm/kernel/vdso.c                       |  2 +
 arch/arm/vdso/vdso.lds.S                     |  1 +
 arch/arm/vdso/vgettimeofday.c                |  6 +++
 arch/arm64/kernel/vdso32/vdso.lds.S          |  1 +
 arch/arm64/kernel/vdso32/vgettimeofday.c     |  6 +++
 arch/mips/vdso/vdso.lds.S                    |  1 +
 arch/mips/vdso/vgettimeofday.c               |  6 +++
 arch/x86/entry/vdso/vclock_gettime.c         |  8 ++++
 arch/x86/entry/vdso/vdso32/vdso32.lds.S      |  1 +
 include/vdso/gettime.h                       |  1 +
 tools/testing/selftests/vDSO/vdso_config.h   |  4 +-
 tools/testing/selftests/vDSO/vdso_test_abi.c | 55 +++++++++++++++++++++++++++-
 12 files changed, 89 insertions(+), 3 deletions(-)
---
base-commit: 15a11f3ffb629cbbf6efd272239c04a9eb3180e2
change-id: 20251120-vdso-compat-time32-f4684ff250ba

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


