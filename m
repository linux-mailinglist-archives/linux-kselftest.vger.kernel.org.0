Return-Path: <linux-kselftest+bounces-41693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0A0B7FB5D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639E0621093
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7992C08DC;
	Wed, 17 Sep 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O6ypTniF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ALmMcsI6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9832F277807;
	Wed, 17 Sep 2025 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117720; cv=none; b=P5wmeAry1/G3z2oZd1ofUMzXTYlkkNf/sMMRXkesS5u7Rcr9HuHJylr2TVJIVlaZMOTx8/FJIztcjF/usxvTYZ8mc21UiVebNffeUpELkpVts2G0xmv1TBXEXIrYfrxbK/mTX+IJTyfLNvlfiIIbgvezqN1MXINO+4PRALFVy/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117720; c=relaxed/simple;
	bh=rfKtf9heKLtEUEDnlkSQVygVQl+5EpVRNxTXAkEx/gY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZpFqIBOYyR/swojRyO+aCYzp1rd4TENl+dXsHarwWUtPXsICkc4lc8/WZynz+RUcbkzAxCSeds/Wio1ePtLqx6U//lzTb7rcZKK/inUBZDA+pp8PSYJXLUgWMujkFpYk0iwmrj/2MmKG3vwSUtoHxOKqJxUpGZ0Sxp4No7R+WRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O6ypTniF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ALmMcsI6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9I4X5FNFHkpHwdsY06ph5hLTjT+SMU6vgehVk/iWDIk=;
	b=O6ypTniFI7Di61PIULY/cofJr2peM8xs+/YzzQazO5FVmpHo2AJuiCT7yh6H7n9/MpErwj
	6YHAZnZlpL2aw+mk+BNrimRmoJPwKPPDOMPvCEtsmifAtByJDP8Slf30PJWTCqC5uNf+5c
	3+4ib4nHhxeoVJKhIVBM0X1lzroVlrJRz5GAZs/GahS0vxjRUXcVHy0aB2hERzf1cJFoPu
	0RWeqccFFr40KPmJq5BotVukacsP0fZFUaS3kV4r8BCZsxVQ103PlirQ2yHZ5oNO7XlxU+
	MQl4/Uyyv7gwUM3n7DC4jeChlwNJBCfssec1a6MnkhENmMk9nmfm9lCfi9lG2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9I4X5FNFHkpHwdsY06ph5hLTjT+SMU6vgehVk/iWDIk=;
	b=ALmMcsI6R2lu2eACK3Is8/JD5T8hjZPJz9/RHGicJ5xK81OKhBIOstkXZ6aS/8b5BkR07G
	Zcnajvwb85het+CQ==
Date: Wed, 17 Sep 2025 16:00:07 +0200
Subject: [PATCH v3 05/36] ARM: vdso: gettimeofday: Add explicit includes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-5-3679b1bc8ee8@linutronix.de>
References: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
In-Reply-To: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=955;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=rfKtf9heKLtEUEDnlkSQVygVQl+5EpVRNxTXAkEx/gY=;
 b=6YkiODMY3Hk/wVlPgvgqoTfDwjWKygY4yAZ7hjPS134bBs1j8xPibaMf+DFvcRegsXhlWVmkR
 ydKAKQi7UUMCWIayMtMyxqsKiOohPDUrYMQtclT1AKkG3q8gP3dOVs0
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The reference to VDSO_CLOCKMODE_NONE requires vdso/clocksource.h and
'struct old_timespec32' requires vdso/time32.h. Currently these headers
are included transitively, but those transitive inclusions are about to go
away.

Explicitly include the headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm/include/asm/vdso/gettimeofday.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
index 1e9f81639c88cc23cae7cf267bf4674c6d6acec0..26da5d8621cc938f9fdb57fc4b8d240c71e950be 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -11,6 +11,8 @@
 #include <asm/errno.h>
 #include <asm/unistd.h>
 #include <asm/vdso/cp15.h>
+#include <vdso/clocksource.h>
+#include <vdso/time32.h>
 #include <uapi/linux/time.h>
 
 #define VDSO_HAS_CLOCK_GETRES		1

-- 
2.51.0


