Return-Path: <linux-kselftest+bounces-47918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE7ACD852C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 08:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B81C3035A5F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 06:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6844D309EFA;
	Tue, 23 Dec 2025 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dMbBbCtJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MSy4y5aY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43293081CA;
	Tue, 23 Dec 2025 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473170; cv=none; b=dw5vCEoQil4VemITkajUbAalpr2CELff/JhqeUxrfBZa8DhgsKylysM0zt/2i0VMO/3N+mfmPgbEFGRuuSwnB0CO3PzZrbYjT2vw9bLc4B8rByZAFrCc5V8i9Ba4RwGa36sim2VUS+nMgUyaWR9c9gDDkpLkjeba4KzQR0R9YEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473170; c=relaxed/simple;
	bh=IvA+uiMrAr9HqJqYohodphYTHFiPNDzZlCh3LmEVNwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q5PhnwuPZZQxZd2uKfeOkJPGd+u78ZPMdRpDxmf3lPUzOjzkRJuf9ahJc1SyHMHyAt3TM2/aLhDAgMk4HuEJMTyECJYVLgDEtvt4qU++iONZApT9fAp5ul9NYnUCSDNebARes7hJMvYqFnz278ZVrDOuMJsjFOYQ3tQFE8fjWiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dMbBbCtJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MSy4y5aY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fal5Lt8Ujjh98Cvo/iVl7Sv7IWHmGFZ2hmLaXyUcQ9c=;
	b=dMbBbCtJPAN363V9bWHRKHal43sPznzFhzguiLQR5kee2VlsH5FzeRxZeeBhNUGoVIFJXy
	JiAeERtfEIYgpNdmpjibcyJAsKSBkMhHCo7pORZ4dwpun8hTLvs4QIdNSLFrEQfLUrp0n3
	UVjmYt97DuX4FFA//5/ZJp3sVnt9c8lQnmeaYC1ikX7Eu3+K2ugpFaqAozZXHF58Vo5leq
	VcJ63NqyPJ8hmR//naAyOOhFco5wr0DmVlJy8UEGjGmwrWHtanQSX9H1Pt6RvZeoqX8FN4
	4mLFD3B8JNW4xquc4VEh9/HYon71GqK+N5+SlhakcOXJmilzWrxZ6AXUj2KNHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fal5Lt8Ujjh98Cvo/iVl7Sv7IWHmGFZ2hmLaXyUcQ9c=;
	b=MSy4y5aYk0luzcuZ5fml8H0+lOtatthm2+rP7QBlAp6WCW01J2hsOahTjqzGZ2z2NMzdcC
	kp+W7OhQWnWIP6Cw==
Date: Tue, 23 Dec 2025 07:59:16 +0100
Subject: [PATCH 5/9] x86/vdso: Provide clock_getres_time64() for x86-32
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-vdso-compat-time32-v1-5-97ea7a06a543@linutronix.de>
References: <20251223-vdso-compat-time32-v1-0-97ea7a06a543@linutronix.de>
In-Reply-To: <20251223-vdso-compat-time32-v1-0-97ea7a06a543@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473161; l=1562;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=IvA+uiMrAr9HqJqYohodphYTHFiPNDzZlCh3LmEVNwY=;
 b=ryWMVgZE7OSgfUee0YnHDNFjRmfEX2J4YH5AvG6em4P29DD8b0MhuVsHOGOzVC6aJ6yp48/du
 u7hWc6Xkk4pAd8nIUvH/QKa/qTWBKThZk5+4uhx+GvgXI6Pv/BWqrXT
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

For consistency with __vdso_clock_gettime64() there should also be a
64-bit variant of clock_getres(). This will allow the extension of
CONFIG_COMPAT_32BIT_TIME to the vDSO and finally the removal of 32-bit
time types from the kernel and UAPI.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c    | 8 ++++++++
 arch/x86/entry/vdso/vdso32/vdso32.lds.S | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 0debc194bd78..027b7e88d753 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -74,4 +74,12 @@ int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res)
 
 int clock_getres(clockid_t, struct old_timespec32 *)
 	__attribute__((weak, alias("__vdso_clock_getres")));
+
+int __vdso_clock_getres_time64(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_getres(clock, ts);
+}
+
+int clock_getres_time64(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_getres_time64")));
 #endif
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
index 8a3be07006bb..6f977c103584 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -28,6 +28,7 @@ VERSION
 		__vdso_time;
 		__vdso_clock_getres;
 		__vdso_clock_gettime64;
+		__vdso_clock_getres_time64;
 		__vdso_getcpu;
 	};
 

-- 
2.52.0


