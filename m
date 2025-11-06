Return-Path: <linux-kselftest+bounces-44908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5E0C3A0CC
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 11:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5D11A4418D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 10:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3AD30C639;
	Thu,  6 Nov 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Koq81XN4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NebslIGC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D630E844;
	Thu,  6 Nov 2025 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423343; cv=none; b=G1PK14TbkYONDTNJS+ynd2Qqh9f0IJeBU8t1U5HKtu6eeS6SEbCgbKcNzOveNk6oD8UAmxGFS09WKNDvTUERW4w1Jze4RwQyqNS/jknEHDjh1gtIjhjpXE3k3DmhpvjUJMSOOXxgWD/PIcwhE6TR9WbLUj2whd051EQ+Y9+RFLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423343; c=relaxed/simple;
	bh=4Cu28HtGZeNZ2tWXY+8GZcEypzFGKNdtzWDHnoy4D9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NZ+OcOYhVjJ7FSPnmHAWfE7/yhura4buW09Gnhgo4tpmnHlqlCCY834P2OtZjEZVhlNhnynX7HoHpz8Xrv3Me6cuKYeyKSF+UIFVY1+IWEpZnca5btOEVS9ewRgK1eDMkmmFFoluLk59Bsag5cWiPCRfLlvPM47MqOcHQ0pSWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Koq81XN4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NebslIGC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762423337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+bQGGgEleKR6qKcL7e+IzIL4DEdxuTbcX+pJZvo9tw=;
	b=Koq81XN4V8ajlEgOf1GpsEXnRwjdINGxTEzarRe+pvGWi3AxnBOuWGx7BKVC5ZsknjofI/
	//bs8dPiQLq8cy47ZPN5f8O3DChhE/qUhNoKVj1WulDSr0P3aSE2cU9bPXX8KuNlHdhPwn
	9YtIo/CkMnnC4iHzy75BZCDSDZJdol823RZJKpBAR7lxwQvMEhU0xn1DiJTbO6mCnvlwCc
	x1ocowmXLfAngvQWItIQNKrol6CYme1w71LKP7se2xcMLvA+NjfSjFo2vg9TG+lk7IxvEj
	6/U8GMGYP+bR42PNCl8GAk/Bq4flCRBXp9dlF+NKeAHv6VjBLUZgHEFzYFBLIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762423337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+bQGGgEleKR6qKcL7e+IzIL4DEdxuTbcX+pJZvo9tw=;
	b=NebslIGCP/0XBY+t6xRTaJURoXZKSjWZFHf8pSrAWZ3The6aG2X+Qt9lmqbkSzAXevxSQX
	nu3akSQUYoAcRQCw==
Date: Thu, 06 Nov 2025 11:02:07 +0100
Subject: [PATCH v5 14/34] vdso/datapage: Remove inclusion of gettimeofday.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251106-vdso-sparc64-generic-2-v5-14-97ff2b6542f7@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762423327; l=1995;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=4Cu28HtGZeNZ2tWXY+8GZcEypzFGKNdtzWDHnoy4D9o=;
 b=wgfZC8v12n5R65IRKOFb/E4l4M/8XCUDoIsKPpV04GCQ82zd29+fO6qo2g7MRa/a7nzUf2+c7
 F09BjOCS+zkBhCF0FslbeiK0EA0nAZIK7R42CgRjbARl3mrrIE55iOg
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

vdso/datapage.h is useful without pulling in the architecture-specific
gettimeofday() helpers.

Move the include to the only users which needs it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 include/vdso/datapage.h | 11 -----------
 lib/vdso/gettimeofday.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 23c39b96190fdfc2f31bf76a8614d69a3a98017c..752856b36a3abf82b849451e5d5233b1067b86f2 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -184,17 +184,6 @@ enum vdso_pages {
 	VDSO_NR_PAGES
 };
 
-/*
- * The generic vDSO implementation requires that gettimeofday.h
- * provides:
- * - __arch_get_hw_counter(): to get the hw counter based on the
- *   clock_mode.
- * - gettimeofday_fallback(): fallback for gettimeofday.
- * - clock_gettime_fallback(): fallback for clock_gettime.
- * - clock_getres_fallback(): fallback for clock_getres.
- */
-#include <asm/vdso/gettimeofday.h>
-
 #else /* !__ASSEMBLY__ */
 
 #ifdef CONFIG_VDSO_GETRANDOM
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 7b3fbae85544c2f2f6b9abd5437f130706fb6ec6..9dddf6c23913e87a62bdaa50c5e32d2951c92760 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -12,6 +12,17 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
+/*
+ * The generic vDSO implementation requires that gettimeofday.h
+ * provides:
+ * - __arch_get_hw_counter(): to get the hw counter based on the
+ *   clock_mode.
+ * - gettimeofday_fallback(): fallback for gettimeofday.
+ * - clock_gettime_fallback(): fallback for clock_gettime.
+ * - clock_getres_fallback(): fallback for clock_getres.
+ */
+#include <asm/vdso/gettimeofday.h>
+
 /* Bring in default accessors */
 #include <vdso/vsyscall.h>
 

-- 
2.51.0


