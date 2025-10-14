Return-Path: <linux-kselftest+bounces-43082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5506BD7A61
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 08:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C17554F10E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 06:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC29C30E0D3;
	Tue, 14 Oct 2025 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bAt9euk0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="esfzR2Bk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23F430ACF6;
	Tue, 14 Oct 2025 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424560; cv=none; b=Rrs2zGuGWdWmZUafTRCuNQBFKuqHHcjFUHULJFkW+3U+Ev7fY5RRVcFfYBA28V0pjbkK1wfF3WRLyBB14C0NfRaKdqPnYDz4IoknweA82bZ/nW3XdHrkesmQDolyrM06OwxV6eSjjr7oypIGvMi1hbSK4HfCXoLtsM43lriJTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424560; c=relaxed/simple;
	bh=pWSgr9LF0PVimD93prkaQ1gUly1gwK+GgmvcantsbHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GApl6Exbo9dnkAA0M1H5flOaPqR+IQokw9bhtDocg4oXsD0LSY46TyntWUEq+hG9ISkdPBQAg64UhwYv2P2cF1BCOll5YQYtfaibNpXLGKz2F82xbQ6NLOTi6K9FrnhdgxVuVv8FMqmGELgyKjmVsnXXes96yRi+gTsaLLd5x3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bAt9euk0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=esfzR2Bk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760424554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfNwuY9Nbo9A8Jz5YapUcUJT7RvIIqIGIu7ip/76FOw=;
	b=bAt9euk0Gmfcxq+1sPRKr0+Z9KV4nDi5abBHzVx+PmfhX5M8UcXyKLYlz1RqAipn6Jh/O2
	NvI0WQeuDc6JUulIDet6DSUEkHjMzVt5wQsIVCLQBw1V7DpbV8H37mwx8s4FL9j+omQW0j
	b7/ozB8cBrT+A0EYsNAX/SZWLXq2RLlCvePi7nUJedgAkpbxv4XxQe1OECDJmxtJoEkW5G
	7ECmMbuBOz1FLoGs1wUocoDRPUA7aOv0yPPvAanmiOqrmrG9mOBnP0AUnh/VxgTm88DR50
	KB/yYOLGq1xLJ15hkQjZ5nf+aBxZqGgGCbN1aCkbilVgFxlZ+neev1qBgjiTww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760424554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfNwuY9Nbo9A8Jz5YapUcUJT7RvIIqIGIu7ip/76FOw=;
	b=esfzR2Bkxo2Am6QrNXPkK62SV3u0qeZUqxgG9f45AHxPFpnkxj0m2u9CgK15zrEzW1UR3w
	mzkDyBFdEo9KqDBw==
Date: Tue, 14 Oct 2025 08:48:59 +0200
Subject: [PATCH v4 13/35] vdso/helpers: Explicitly include vdso/processor.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-vdso-sparc64-generic-2-v4-13-e0607bf49dea@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760424546; l=852;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=pWSgr9LF0PVimD93prkaQ1gUly1gwK+GgmvcantsbHs=;
 b=5CvSNsNvaTcLjW++rQpMme843bzIkkTG1SlgYXdtHg1f8BR19OEsteb5hyQkz7+vWc90VEFWD
 w/4AnwpYHxKB/tfilZa2RyjB+Fjj4hyln+qNLpcvU5wxi/iSPlUding
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


