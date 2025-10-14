Return-Path: <linux-kselftest+bounces-43078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8864BD7A24
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A786E4EFD5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 06:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F86A305979;
	Tue, 14 Oct 2025 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dw1K3Wwc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KZAbUXMJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF6F2D0C92;
	Tue, 14 Oct 2025 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424557; cv=none; b=L8gMt9HJjXNxUr1wDwPBvkLwUNASF1D8RgDBHjdByzNhbB9lkLvWuOpeACzAY12Z0Q61OnZ9rEQBrRoO5Rrs9FZGrKXrkYzdsYMdSXFekv81OmjfpjkYqoa4vKuAZ8Sykr8uUlBmC2QHMPyxjvb1x67anD/ke0dlD84klhIBzpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424557; c=relaxed/simple;
	bh=V9tDNcYgJIt9GytAgrSszi/+I+38Gq3Tgc4R1PI5n6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q5tlpxf7VKixCz5USKvkAunL814xqZEw43v3a+6UOlyV3ArcScWHazycDKpdGWpxMNruiVKQW3ulQwLSrUOVgLBVNEvZEo8SUCs82wh8G9mxse6x8EZd/3vDS8W8kseIrErMl8pxLvUZCpaY6ffNswJHH77dFfcAGY6en6YAyvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dw1K3Wwc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KZAbUXMJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AA1RaYevhVsm4UU0YhUEK/PYFHQA4HTGOnbLyC3tUCM=;
	b=dw1K3Wwc3DlbfASokc9Ng+BP6e8KH4qpOqoMYtQfgv6od0ERv2O/5Q6yJzx3ZGna7O7MNa
	ep7Kr9FJ+QgcJv6v1BJGtXA8Y+SJ8CfzPzznloO4wO1ZYb3j7ItKmBvwuCaFJpe84QIqgp
	iDetZBu7DPjqeENLUT+RFkuGMuCT3O3Df8H3lLEjKwxOZRhDe6O0PUiu2XgbG9mOOG49RB
	sJfO8Dq5GG8PfnEuFyRrBmHnbDiZW+izDeo4f4mAcp0AAsTrhUHctxmcGQINiPNNL/s+r+
	mUhMWTG+LXjl17X/ubCIl1cE4R/fYhiBgHArsyDkOdJu53DsJnpxdKmreaklwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AA1RaYevhVsm4UU0YhUEK/PYFHQA4HTGOnbLyC3tUCM=;
	b=KZAbUXMJaZVSA1LGpkyoLlcVsBr5HGeTNun4s+qb4nRA04oeOCi/McwPA3up3+QoGhJhW0
	4y5Z/yiTFXqd71Cg==
Date: Tue, 14 Oct 2025 08:48:50 +0200
Subject: [PATCH v4 04/35] arm64: vDSO: compat_gettimeofday: Add explicit
 includes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-4-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
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
 Sven Schnelle <svens@linux.ibm.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Shannon Nelson <sln@onemain.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=1077;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=V9tDNcYgJIt9GytAgrSszi/+I+38Gq3Tgc4R1PI5n6s=;
 b=O6sdJZ6+xsZw+9772TYvJMS+FktucaD4NMhv75qVXAsnEqDi52ZmzGJHQa9JNzfFOirVVsZJL
 A4w+O6aHQm2Bq5Yx8u4Xh+LTZn1INmM4znwFHui8E+jHpz6QaxYylAv
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The reference to VDSO_CLOCKMODE_ARCHTIMER requires vdso/clocksource.h and
'struct old_timespec32' requires vdso/time32.h. Currently these headers
are included transitively, but those transitive inclusions are about to go
away.

Explicitly include the headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index 7d1a116549b1b98d6eb7a78d053958c6a71799ec..2eb116d91235fea8362a11f3644619dbeb8201de 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -7,6 +7,9 @@
 
 #ifndef __ASSEMBLY__
 
+#include <vdso/clocksource.h>
+#include <vdso/time32.h>
+
 #include <asm/barrier.h>
 #include <asm/unistd_compat_32.h>
 #include <asm/errno.h>

-- 
2.51.0


