Return-Path: <linux-kselftest+bounces-47915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 968A7CD84F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 07:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14C43301DE08
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 06:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E601E306490;
	Tue, 23 Dec 2025 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EoXm8aC5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NsAYVGKe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510442F747D;
	Tue, 23 Dec 2025 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473167; cv=none; b=BTdYXEmWjSnQZdeRT5yhvyqS1lD7Svxc7wxo2FFjBKN/4BsNkXVY6TpWp3tQWnGyPtHqPzQSN8UVWLhdZnQFqfyn8XYlQuom7DEoVfZXcMjFjKX0fYimFj3t1Xe6mlCMcITQ6fsoG8sw1XNuVvVpt0FGk5ZZ/63LFdqrpseCtMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473167; c=relaxed/simple;
	bh=K4wy0s4CBq0/Oz/7KIB2b4pnhTCd4YJf0KADDSnMZSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LdLfZLh2csnpSrzdZtyg/iwlVi5A1CNfnnehP2JjJTnMDkfr6zzrJOubDZyXc1tmbCsEcuzR7vvgHUT6wqLadYo6ducIdoWJV5qyDHDR38yzo6O1wKUI5p9XH48DFDoXEq9KU3a2Cn5NRqCU+K77DGA6jhdZWIgeC+NwDS702Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EoXm8aC5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NsAYVGKe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8E8Ivu99/HVuC0LZwh9B42Hwzqh7mGm8g9MZgjeErS0=;
	b=EoXm8aC55tPTBXK/gCo2lxmTsv/A6ohpOKDAsy2GpS6bsMK0F8g4blnpIr9npv3ziGeTYN
	CL6vT5zL208usp8hRLLHVLGZ2NdMnRYibOlqqKrLQGaA70fxf3WiXmdPvLRJRaH8ub7PhM
	rAW8ByxEH5Fz6uSNkhQdZfUE/6SNYnDHOA/3Hu06rH3TPnRdyV2ZfLLm5Mp4zpDbZy9LU/
	Pca3jvTqBYnJtd/2UXHGd8itL2yL9WUhIf4XfTpBz6YBMahB8fHWzmfZjt0bc5v0h6zw4q
	qN/QTyYslcJ7F8jbOBRkdCGN+zmzcWc6V4d7m6vo2MOzccaxmp5hkjyYGXYhlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8E8Ivu99/HVuC0LZwh9B42Hwzqh7mGm8g9MZgjeErS0=;
	b=NsAYVGKe6DQvVeQdirLy9LxIA1vyd6cesbtD3Xkk2DJhNBvdNXzQryrumcjnwNTy6UTqZK
	b4R6zZBReHFT4UDA==
Date: Tue, 23 Dec 2025 07:59:12 +0100
Subject: [PATCH 1/9] vdso: Add prototype for __vdso_clock_getres_time64()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-vdso-compat-time32-v1-1-97ea7a06a543@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473161; l=1264;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=K4wy0s4CBq0/Oz/7KIB2b4pnhTCd4YJf0KADDSnMZSU=;
 b=Ipjk/byTy8QYXnH5TqmDxb6BDi4gwx7RLw3Nonfnjc2lw/87OQyuJRuYaYanY8bb3n/Fth7bO
 WA1HeouZqZxCr4cvwyepl0r4aycsRVwYkSUrUlijSIWlwZ4y4bJ5QyE
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

For consistency with __vdso_clock_gettime64() there should also be a
64-bit variant of clock_getres(). This will allow the extension of
CONFIG_COMPAT_32BIT_TIME to the vDSO and finally the removal of 32-bit
time types from the kernel and UAPI. The generic vDSO library already
provides nearly all necessary building blocks for architectures to
provide this function. Only a prototype is missing.

Add the prototype to the generic header so architectures can start
providing this function.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/vdso/gettime.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/vdso/gettime.h b/include/vdso/gettime.h
index 9ac161866653..16a0a0556b86 100644
--- a/include/vdso/gettime.h
+++ b/include/vdso/gettime.h
@@ -20,5 +20,6 @@ int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
 __kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
 int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts);
+int __vdso_clock_getres_time64(clockid_t clock, struct __kernel_timespec *ts);
 
 #endif

-- 
2.52.0


