Return-Path: <linux-kselftest+bounces-44895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5BDC3A0B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 11:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0769B4FDC99
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 10:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423DD30C62B;
	Thu,  6 Nov 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CZq9Wu29";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d8Y4q6xG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4282E11D7;
	Thu,  6 Nov 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423337; cv=none; b=Or3FvvkqUxGv5sU5wgp/phBFiLmlDQsRM7DLylDp3l59WLegu9p4J6LKy1lGsaryrYkUZMOX3Knr8PlGvE6Kae3njXo/cPlFGCc6BJq+uW/kJytwJ48p7Q8up0c4xJagiURUFF5/aJLyXkUTOuhrTLmi2JYa3y69IV5AEqpoEF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423337; c=relaxed/simple;
	bh=XfbRCZJaIPPL9RqG5I4uWuUiOvFF0sMMnDdDPpO0Deo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cljTLa5jDFdYcbeoIybtAK+DTeN6vx/qTaKAE18twUn9MrwrdsPOCDb3eeZIT4tmLUzR1+thj1ZpGPHzhVbjQh9zNUAA/kxz0mAI+jL+/BuOSV9NawP+Lqok2xBwnm2wI+pm9U/el8NTugTZTH/qo2r9IlPxxACBmxQq2XLkTZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CZq9Wu29; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d8Y4q6xG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762423331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d61fN+YsBbfOpc/TI9xXXEgh8u4ram9nD50U99mHlYE=;
	b=CZq9Wu29/BJLN8xesS+fKvmG1nv36JlDSJ08JYmTChRiPH3pFjjoTZVsuEHtE7/NjtI9YA
	YJMEFbkvYTBVSFiTI5rExiIWya8v7PZ5xFs38uZHp2RQKD5RuPIvvxUbt5ByzazItDNu3L
	mAATXLbZEBLRAKhRfsUTkIfyb8OnQSzlJ1EhzuA7arp2ROcXTteWn9ravQGD5ERyklNRe1
	QlUUaNbtCO5xem0Y2pgdj0nAlkOoialkJGgIMCLPp2RTu4WKwAah2lKOLYd+kDV5HcZ7kk
	xc+QO2kvkbD5clIRDuiddBhx7teFC6hrCM+l+CaNWS4/3hUpjSXTeK+W5ZiHWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762423331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d61fN+YsBbfOpc/TI9xXXEgh8u4ram9nD50U99mHlYE=;
	b=d8Y4q6xGHeWZSFTaw6xKwtX2QEMXFsfEkbUXtkn6AAQuREvr9ASttKf2YQISbUxSOyht3Q
	cJYdpKIJ9okV3tAA==
Date: Thu, 06 Nov 2025 11:01:56 +0100
Subject: [PATCH v5 03/34] arm64: vDSO: gettimeofday: Explicitly include
 vdso/clocksource.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251106-vdso-sparc64-generic-2-v5-3-97ff2b6542f7@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762423327; l=950;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=XfbRCZJaIPPL9RqG5I4uWuUiOvFF0sMMnDdDPpO0Deo=;
 b=3GS8tpkvgHKiJsfgHWm5ubVV3I9cKnKzRWQdI3BUDk0saE9EvuDLjaf1Hnk6AktCIMkBuZ3PL
 IRavzTBjoL5CCZ57tc9RUOnuLxLNp3A1Z6w12JRbI6JL0LWjT+ZOfVN
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The reference to VDSO_CLOCKMODE_NONE requires vdso/clocksource.h. Currently
this header is included transitively, but that transitive inclusion is
about to go away.

Explicitly include the header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/arm64/include/asm/vdso/gettimeofday.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index c59e84105b43cdb0c823da3dd793a83781f84302..909780bcadae92109b175e23cb05e966683731d4 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -9,6 +9,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <vdso/clocksource.h>
+
 #include <asm/alternative.h>
 #include <asm/arch_timer.h>
 #include <asm/barrier.h>

-- 
2.51.0


