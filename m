Return-Path: <linux-kselftest+bounces-44896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0047C3A0C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 11:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF3A24FDEAB
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514FF30CD85;
	Thu,  6 Nov 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tFcEZ+F2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dv4aXHzL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3902E03F1;
	Thu,  6 Nov 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423337; cv=none; b=bZughbX5XgAWswYCiLMc82OLQX29ixAV0EeR4WWzuSFMyUsMUGrnE5M4cZ8ubDQBfdONMSekBjfiGqmD/bBG8UlCuQv65fA9XJkCc8AG1vHJr5AK1zz91fcVqxn5SYHTH/UvG7yKC33FALnQnec3js7bn1i1a+2nTDj7ZB6DohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423337; c=relaxed/simple;
	bh=V9tDNcYgJIt9GytAgrSszi/+I+38Gq3Tgc4R1PI5n6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cY9rWgJP140TWkYpH41JCa427LIQnnQM5Ndor52dNtD52xWye2buKvyKdcXC/XE0xq4q9hD2eZh9QI0lLJF0fClsQYcbtN1+444hsMFNvwllQpbFGGyihAD0cIlSpSj0QB3Wp/u/e6mnIUuulN08UZinmTVOVvKcZjLPq1OgBDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tFcEZ+F2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dv4aXHzL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762423331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AA1RaYevhVsm4UU0YhUEK/PYFHQA4HTGOnbLyC3tUCM=;
	b=tFcEZ+F2McnQR/yj4fr2Xzl/qH8/6ms9DrGJJEA7fL7kXcqCX8hv4zyKd2otBfY37FGEMv
	2KoqENjQKbobna/HhKzV0a13m+kQAUyNfbgCcNeMvJwrxOwp4UUkJ5GB31sKEvK26EuVcZ
	J2nsupkTFncr4BO3FtqqAHgRyL9zPra2lX0RBt7EvpZmeaeHQoP8DGBinFIHBZ9exbk2mq
	NylqCM6rngQh4QiSqsBmuIdgwx+l77BtrybXZDDzcxnTxiRrQxzTKsgC7LJWm4+DZEOjyZ
	Anyou1cfZ4co6SXagzJZoC5bQwao2fnYT4x/M9WSE8oOxNat5twRj+yM8uqeiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762423331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AA1RaYevhVsm4UU0YhUEK/PYFHQA4HTGOnbLyC3tUCM=;
	b=dv4aXHzL1Xjk+ugiHKiKHn4Zai+gBXRbTJznV37UCpAZWEQ/PoCZgmqHL6C2cMjGwpvgUK
	J8M/KPUkt2+qRbBg==
Date: Thu, 06 Nov 2025 11:01:57 +0100
Subject: [PATCH v5 04/34] arm64: vDSO: compat_gettimeofday: Add explicit
 includes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251106-vdso-sparc64-generic-2-v5-4-97ff2b6542f7@linutronix.de>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
In-Reply-To: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762423327; l=1077;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=V9tDNcYgJIt9GytAgrSszi/+I+38Gq3Tgc4R1PI5n6s=;
 b=dCws47IlDG0vkiaRQIxj8kTBcuayHBXpMon0coy1Y4wHv/D0Q6Ui17Yiv8DDkmnY/1KURKs7c
 RGT4PVlUYpJAvwj7qQeBdadKVIk+g7V23dttIV94IhYzkt9QxeQF/cD
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


