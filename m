Return-Path: <linux-kselftest+bounces-44907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F94C3A16B
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 11:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F243D5021AA
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D9430F812;
	Thu,  6 Nov 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qp3l3VYN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l5WTT4o8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6A130E0DC;
	Thu,  6 Nov 2025 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423343; cv=none; b=nkirNUpmyznC2kmeuVqq6SK+pbQVgOssmPFJx3gWCcN7gHye7mXtPTyiJuJzQQm64ioytkqs8CPMHBolNmV8TV1Ms1mKZhl+v3TOCp5BxUXqwXAXb68Ianz83l+52o1Su9hy8WDrCQeyAAt8hkFKBZRdW/aRNfDQZYB3l8dhlXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423343; c=relaxed/simple;
	bh=pWSgr9LF0PVimD93prkaQ1gUly1gwK+GgmvcantsbHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fCOzzEmBpVs/+Me6mdHrGfFbE0rLC5plwkQUDhYH6FhJftQc4wXDKXkGW3caPmDiY/iFSXfia87dOBRvnUECDOaNC1CTbg0NeDku44OaoX4xoPmYDFWBq4FxaQ3+1YHgcyzF1YzyYPW6/tBtmh+ZX4cLEqUHaQF+uWEXr9tG7ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qp3l3VYN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l5WTT4o8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762423337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfNwuY9Nbo9A8Jz5YapUcUJT7RvIIqIGIu7ip/76FOw=;
	b=qp3l3VYNka5s1nY6eDnzOvG4BsEZVzoBbsrxfkDwCfjHvYy/cVdQgyWaX/hwKzCNyKhxeC
	IWLaRz2GgmYwypKQSt6Wi/n8Se0eWsYB5V4gYoRYLjwC4jOazBDWadM84vi6vm9QMHt4X1
	UZ3gAeF4pEuJtLd7XSBJtOC7htJfBDVwTDrJGBKyByLBsGJpmwqdMhCwLhyoHwlaXRdYVs
	9ENvfTx/rK9ThPrwb/zWvkOEdN+/VEN44A/83N1eln/M5vw+e/JvEHnTcXkMn8wdYOja0y
	z9MHXzkNFFGMZTSiRM4NJGa/Ur6QRxr6y13U7LqnKkCYKycOV4nr1n/mt6RHRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762423337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfNwuY9Nbo9A8Jz5YapUcUJT7RvIIqIGIu7ip/76FOw=;
	b=l5WTT4o8blJG4zOeiHHjP50+OheD82E7UKUeJOMOuthXCXGMrZEdjnhyqqf2V4QFxa8XyT
	LCrwDM/5KloiOeDg==
Date: Thu, 06 Nov 2025 11:02:06 +0100
Subject: [PATCH v5 13/34] vdso/helpers: Explicitly include vdso/processor.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251106-vdso-sparc64-generic-2-v5-13-97ff2b6542f7@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762423327; l=852;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=pWSgr9LF0PVimD93prkaQ1gUly1gwK+GgmvcantsbHs=;
 b=FPc0jcTkM7lq8Xc6yadEp5IxwO9p/vtzhZuFOC/A71JdPZwDstZAyXmpfOJA4TmN2dNozEnnc
 eOzFcFg6z7DCn2Se6NHdpbuY/KU0V/s1o9E8EFmrIPUUeklAyMKOzMv
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The usage of cpu_relax() requires vdso/processor.h. Currently
this header is included transitively, but that transitive inclusion is
about to go away.

Explicitly include the header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 include/vdso/helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 1a5ee9d9052c38553c0cdf413e0030286f884d53..a1c995af4696351e55cd870c7c4211b0984fe9ab 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -6,6 +6,7 @@
 
 #include <asm/barrier.h>
 #include <vdso/datapage.h>
+#include <vdso/processor.h>
 
 static __always_inline u32 vdso_read_begin(const struct vdso_clock *vc)
 {

-- 
2.51.0


