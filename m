Return-Path: <linux-kselftest+bounces-41692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7B3B7FAE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C13D7BC82E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4512BE635;
	Wed, 17 Sep 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f19Yghef";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="alrnW0Hc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFA4274FEF;
	Wed, 17 Sep 2025 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117720; cv=none; b=qcjYmKMfdGOP2HDhZ9vENfYU9Dz9T0LHugMzqRTeaD5K/dt+vG1JKEqEMbHqeA7n1Q79Ods8xWFXIrUG2yieVybkDp76Sy1YO5shU2cfziG1TV9PBLxcStUB7FM7QBAczPGqYv8oH1Bwidl3uoS+vR32j8FCMPrGYCERf2bAD8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117720; c=relaxed/simple;
	bh=LMkWpOTw9lADoOsp4TmEwFW4rvUBNCxbmJSGcfJb6YM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kHP3OZUJLxsNEz/Qg2TQ+1wKGd2qeUSrjJZKert33b1FzWpimTu93XIeLpADuLtyvLYXU8GrNOBxY44ZzX8YihDGMOXs6oonMNkw681qo8xOJg3CMxSeI6pi2T6hSf5yx0vcsZePuAk1Vio0zr1aYavJuok3IYrk+qo5b34iOHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f19Yghef; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=alrnW0Hc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758117716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4DOdImq59E9vd6o2J/MK1XL5DEzKfcDc89YEUvACic=;
	b=f19YghefwPeafQWeCFbX0YZOLAIHumtgce71KdWDpFOhmAFAX2faxmwEnmG64fBDksyRlq
	/Bjb92DbfzVLk8brehzt4Hos/R9gbTZ9j0DlltAhq8rMXrSx/gtTZrys8WbMpPStZuTVkO
	QlzaFfLk7vog8mh5qAXqJH6ApWuSd2BU+itoOo8AFIFQYj4okenmfZGezrJKk3/c4Mwxl4
	4xjmFDkCB5Wx3YBtqpxHtTCLcrrGTBLyvBlasMT/RnIgi9DzJT0c1wOQW2VqqOvFaCl51U
	m45wWVek8m2R3xdq3Uw4ecB0Yzo4jXIr/B3p2Zjb0/NoxTGkKAepxfuxeWsOrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758117716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4DOdImq59E9vd6o2J/MK1XL5DEzKfcDc89YEUvACic=;
	b=alrnW0Hcf7IH3q/nICDsThe736Bprgj652QQqNKaTZSYppq8xl4P5EbOWX/RzgIHcoyPe2
	OkPBF5IxHsnXEwDQ==
Date: Wed, 17 Sep 2025 16:00:08 +0200
Subject: [PATCH v3 06/36] powerpc/vdso/gettimeofday: Explicitly include
 vdso/time32.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-vdso-sparc64-generic-2-v3-6-3679b1bc8ee8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758117712; l=851;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=LMkWpOTw9lADoOsp4TmEwFW4rvUBNCxbmJSGcfJb6YM=;
 b=+TCNDPw9BR06tBfki8D75N3Iiat/8tlG5IlbjjUVxYgbx9Xqg0W5kO4uwi00dbCD+YhHEbWpW
 yYC9jRMoF1BAakAYZWVhjKOpbicCqAkOHLMYjeEde54Aiv9UFqMVCol
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The usage of 'struct old_timespec32' requires vdso/time32.h. Currently
this header is included transitively, but that transitive inclusion is
about to go away.

Explicitly include the header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/powerpc/include/asm/vdso/gettimeofday.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index 99c9d6f43fde2efaf92d4777d3a5510677da7c92..2921ce98a3ae2d99041e3b51a2ad4ef677e6f9a4 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -8,6 +8,7 @@
 #include <asm/barrier.h>
 #include <asm/unistd.h>
 #include <uapi/linux/time.h>
+#include <vdso/time32.h>
 
 #define VDSO_HAS_CLOCK_GETRES		1
 

-- 
2.51.0


