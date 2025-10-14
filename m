Return-Path: <linux-kselftest+bounces-43105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0812FBD7C04
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93E3F4F9091
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 06:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99EA3126D2;
	Tue, 14 Oct 2025 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cyjIQis5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L0DUBYri"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D823115A7;
	Tue, 14 Oct 2025 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424574; cv=none; b=HrqDV3fgLaFG9ZEBC/bzsfqbxxC9tDciKQGXWR7NQT0n1W0LdXeiHxG9czWpTLzR4IQit4NirUTbSTtqp+ye05tlWsLAxCiWZFWmKD+xYXhT1XpxVfTK4jMeimE2zvsLD6Fkk7tUR4+LKbGPC1u9e9POgfr3p07r5Svbf52L9+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424574; c=relaxed/simple;
	bh=xwcj3q/CdIriTySoC7OX6peFSSoIsXzZXvpqY2dDPDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRXkHgUObIlfWy1oOC3pYO5Gi9MrjD8EA07w6JLaYZuMznbU7xazEhwLoqXgVNOFgMX3zILYNNlVL1KnhxuFeyjG8PATaSpuD8g8YTJdTILVtx9aE0hXeExzUsT0cwoQT40Zh15G6lFor9p69qad3P85fBseKL52W7dCw9lk95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cyjIQis5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L0DUBYri; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjJXMHE/nZ0JgqIfSCrtFNclnrKwtH1lYk/BfThnBk0=;
	b=cyjIQis5Lq49kZRSLFJObznqTl2NJHMwJRa1sfBbn2LJcuyAn/YguMqGwLvfeiLau0r8kY
	yzJRJn4JM+a7CQnXQU32VW+q864qhgGPrJG3iKWXGRemZ1DImcOY2W28G9Ub/A90K+Hpcq
	E1H8zuT/umsVYZw/BcexRNK3KRwIduKq5ygEY1C/alFYNP3JAPHCvKTbYtTa0hGKfj/wm/
	7PC2GC73IlMFR9Jjq9qZ0aakqcONGqtYzxBlgtUCJ1IiK8Ga6ZgJ/S2k8S09hSePitzSsD
	T/aQpccq8UbC+xFEIeuGKScYwsEI/MgifqSNTCFpbycVf0EO91UleuEkVs2s2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjJXMHE/nZ0JgqIfSCrtFNclnrKwtH1lYk/BfThnBk0=;
	b=L0DUBYriuxVBe03Xsxo8OhUoaOQ5w/HeYc+gQ0AQcfr2exNerIBIWelXMXPHV88vLYPqVy
	lnEW2pyZKTXb1ZAg==
Date: Tue, 14 Oct 2025 08:49:18 +0200
Subject: [PATCH v4 32/35] sparc64: vdso2c: Drop sym_vvar_start handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-32-e0607bf49dea@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=2109;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xwcj3q/CdIriTySoC7OX6peFSSoIsXzZXvpqY2dDPDE=;
 b=hv2Xvu+2ElaFJ/9EkRp1sTFVapiThoAGkswOE/ZngtL2d5HFkcdasbSoaWSCkf+rpAlubc6Ab
 MN20xLrKar/D7CKcyrF+ydnwRpw5/Y3b3/ON7vCFlpCi1rFJWABMC/9
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

After the adoption of the generic vDSO library this symbol does not exist.

The alignment invariant is now guaranteed by the generic code.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/vdso.h | 2 --
 arch/sparc/vdso/vdso2c.c      | 6 ------
 arch/sparc/vdso/vdso2c.h      | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/arch/sparc/include/asm/vdso.h b/arch/sparc/include/asm/vdso.h
index 59e79d35cd7384e2dd752e92d20bc599e38cb8b0..f08562d10215bd3e9a2d4eaa0aadc8400b40e256 100644
--- a/arch/sparc/include/asm/vdso.h
+++ b/arch/sparc/include/asm/vdso.h
@@ -8,8 +8,6 @@
 struct vdso_image {
 	void *data;
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
-
-	long sym_vvar_start;  /* Negative offset to the vvar area */
 };
 
 #ifdef CONFIG_SPARC64
diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
index b97af5ec9f35c01f2a976b6213b1768b677ad231..70b14a436fe2297ab446f778ab0d43155c272421 100644
--- a/arch/sparc/vdso/vdso2c.c
+++ b/arch/sparc/vdso/vdso2c.c
@@ -58,18 +58,12 @@
 
 const char *outfilename;
 
-/* Symbols that we need in vdso2c. */
-enum {
-	sym_vvar_start,
-};
-
 struct vdso_sym {
 	const char *name;
 	int export;
 };
 
 struct vdso_sym required_syms[] = {
-	[sym_vvar_start] = {"vvar_start", 1},
 };
 
 __attribute__((format(printf, 1, 2))) __attribute__((noreturn))
diff --git a/arch/sparc/vdso/vdso2c.h b/arch/sparc/vdso/vdso2c.h
index 60d69acc748f2401156a730027fe34abfb9fb6bc..ba0794659eb5af53b8c86b24f3221a5d0b3f74ab 100644
--- a/arch/sparc/vdso/vdso2c.h
+++ b/arch/sparc/vdso/vdso2c.h
@@ -104,10 +104,6 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		}
 	}
 
-	/* Validate mapping addresses. */
-	if (syms[sym_vvar_start] % 8192)
-		fail("vvar_begin must be a multiple of 8192\n");
-
 	if (!name) {
 		fwrite(stripped_addr, stripped_len, 1, outfile);
 		return;

-- 
2.51.0


