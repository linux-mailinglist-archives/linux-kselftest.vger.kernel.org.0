Return-Path: <linux-kselftest+bounces-37923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C11F9B1009B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D1137A12E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 06:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35F7246BA5;
	Thu, 24 Jul 2025 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="olGVS6Xh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+hfSEUaV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA62E23ABBD;
	Thu, 24 Jul 2025 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338444; cv=none; b=dTuC+ok1KvhcNldiDhzAAJN1ysYGJqopPO79+6gl9K3EabvU+ZdV5OTOlUZOwg1pzAqDu/9p2naXaAEPolQvPkkHxjHo7OSiR5g81Lw3G9F0BEWC3AG30eXe9kT4/c/PYrfEJuBSnJyYX50lEFNQRwAiHOReIQDQFZLIJKjSVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338444; c=relaxed/simple;
	bh=Y6M/Dc0FZBj80nG5zGFZobavKx7lhX9RB9UpQJ8f6Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFbnLj6jgyAKkqxXPvHOj/998hjZ2EkUntB0bXH89jwhRVp4EDBsRmiAqb5YyFG6U/X5TIaF9wVwbgqOjEc3o7U9cc8lkZrh97CdJjbDL9OSsL55l4nEBhxs8iG0+M+v9vnQOglxPv8SaghJjFZY5SXjXF41irtUKyxAYiAZBy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=olGVS6Xh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+hfSEUaV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753338441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXeyczDo9DH2kvMYh8pqbFFU0887oaxfqSrotCzP+To=;
	b=olGVS6XhuYXY76lPmDWlGmWwyLbtJKr3QgKZMthEjkAdx5U72X1EnS0JkKhnYpFvQ4jGdM
	l+fEpTy6FVTaQm75tDSBFMkO6zoji6riD5A3HR3tCxTjknJetLHthHi1SWFohxBQwMGsci
	zSqmuAp/kUQIcfjDEQrUH1iHV6JpS4cmRvMsDvDJOX/Xgti2vruMfOIJ1zIDF1qyhwf2/T
	zIBsLY/3Xlkr9AZ+2ifi3SGr10pEOuxpRRVHxB7FMPl9Eq+SZu/HYTQ9DI1LQOwxYDWkva
	XM66FNmtcH7ty1joji4TET+C5BDY4Mmat6Xh5ldBuPN5ZstQMDz92lcKN7QijQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753338441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXeyczDo9DH2kvMYh8pqbFFU0887oaxfqSrotCzP+To=;
	b=+hfSEUaVPlZxXO0S1DtDQh4X32gzvQIl6pl6NWvISCZaFMwghTFboKsr7dsZQvwTT4Bx4K
	U9guu8It+9QVwqCw==
Date: Thu, 24 Jul 2025 08:27:03 +0200
Subject: [PATCH RFC 13/14] sparc64: vdso: Implement clock_gettime64()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250724-vdso-sparc64-generic-2-v1-13-e376a3bd24d1@linutronix.de>
References: <20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de>
In-Reply-To: <20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753338429; l=1520;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Y6M/Dc0FZBj80nG5zGFZobavKx7lhX9RB9UpQJ8f6Io=;
 b=Ma2pmJ9VBLW5jX4YfrPE3MDCh/AJzbMLDSc0sqti4FeSXMP2TDlPeWW1u4YzKRP2s6lJnx6AX
 G96tJlGrNBeC17M0j3RbdL+B5YuOWSVuk0Xdbu3/ueE5QPeHZfinoT3
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To be y2038-safe, 32-bit userspace needs to explicitly call the 64-bit safe
time APIs.

Implement clock_gettime64() in the 32-bit vDSO.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/vdso/vclock_gettime.c    | 8 ++++++++
 arch/sparc/vdso/vdso32/vdso32.lds.S | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 093a7ff4dafce1cf0af5af4c303bef86e159858a..1d9859392e4cfd285349cf9155ca1fc25d3a7b41 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -48,4 +48,12 @@ int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 int clock_gettime(clockid_t, struct old_timespec32 *)
 	__weak __alias(__vdso_clock_gettime);
 
+int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int clock_gettime64(clockid_t, struct __kernel_timespec *)
+	__weak __alias(__vdso_clock_gettime64);
+
 #endif
diff --git a/arch/sparc/vdso/vdso32/vdso32.lds.S b/arch/sparc/vdso/vdso32/vdso32.lds.S
index 53575ee154c492f9503efdd8f995ac2a035203c7..a14e4f77e6f2222b855df27cc7a0d0a4f98bd4ac 100644
--- a/arch/sparc/vdso/vdso32/vdso32.lds.S
+++ b/arch/sparc/vdso/vdso32/vdso32.lds.S
@@ -17,6 +17,8 @@ VERSION {
 	global:
 		clock_gettime;
 		__vdso_clock_gettime;
+		clock_gettime64;
+		__vdso_clock_gettime64;
 		gettimeofday;
 		__vdso_gettimeofday;
 	local: *;

-- 
2.50.1


