Return-Path: <linux-kselftest+bounces-47922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F53CD8536
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 08:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E68A8302DA63
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 06:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AF630E0D9;
	Tue, 23 Dec 2025 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v0XPcIRJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mjcx9Ik8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9C30AD02;
	Tue, 23 Dec 2025 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473172; cv=none; b=XlqIz756tUczrdW5/K3UBmQ7C+C6IIiJ4/xeh8AWfCvzSszoaKbRKyvzscKMxcuO0UmueWigcZsEeCOI1HN3XlHPVR/E8SHegZ3x23724Mu9HIBExiAP4fMQLkaWuWrnMVLrTNu/kFtAHYR903bnQ16aYjzN61W5ZZIf3OcMdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473172; c=relaxed/simple;
	bh=Z9yCCabeK7jaWFUWKtoNtsuOTpJwxt6wFaVjSU0iZHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ca4tMfhlP3qqHx6blKTwFJAIFtGzZzba2wQrFgB2Ud98ti2aYcHH1UKM7wsXGuyZzNifdDQJM6oE2f+Bu7xckT7fvX5LDKo05KjKJPViH8fjWdY678QdQfsCRcX+6xBXqfW0oebbwpAmuWJB62jtB7cAfUM6PwoIuxNAsYyoxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v0XPcIRJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mjcx9Ik8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIQm5LcPW4i4G7+h/utBT1F7s6FgqfydzlSs5Y7YPiM=;
	b=v0XPcIRJ1Se9VWcrfikZ8SiUMqYy3NIC9jGeLIKDjV+4S8qjjReSNxUZdjLmIeXDlSB8HG
	6woEZ7kPsqJG2LZluOjiYMxc0FxtIRWYm2iPmYblur8Rpnu7LE8AABtlXMABxHcrBalDjp
	pMEfdwJ13TOmbV4sw/Rnp/Y1E+4h0yBXm81lzNDIRMQeExLQsuyc0j1FiMvE+GrKm2ZJbK
	qk8D/WFRyppCewOe0hPRhJ1mK5u+5+2t9jg5WC/RF1M7yNa2csSwbBJCqsQcVM5Hwt1vC1
	qBZmMBIbVU5OQBWql3z73dicscAhvNP/5366gNjKEXr6RhyaLg5PTRJtt42ocA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIQm5LcPW4i4G7+h/utBT1F7s6FgqfydzlSs5Y7YPiM=;
	b=mjcx9Ik8vkbaK6t0OpQYxk1r9PLVVep7H1cDDK24He2cDIuq9wrtzQv0/Rk9mL2FxKeVzk
	rpElHTWJVOY61jBw==
Date: Tue, 23 Dec 2025 07:59:19 +0100
Subject: [PATCH 8/9] arm64: vdso32: Provide clock_getres_time64()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-vdso-compat-time32-v1-8-97ea7a06a543@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473161; l=1457;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Z9yCCabeK7jaWFUWKtoNtsuOTpJwxt6wFaVjSU0iZHI=;
 b=8IHbebF9ZQt0Il3apsZmxynrbfbdJv1ROO2ft36v1vYuVLRlXzwnOY562A9kyn3RCXEsfyJFR
 cuMTyK0BTyID8hPsdYaw2hU185R2LxwVSs3mOhjbSNQPY8dCpBhEUMy
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

For consistency with __vdso_clock_gettime64() there should also be a
64-bit variant of clock_getres(). This will allow the extension of
CONFIG_COMPAT_32BIT_TIME to the vDSO and finally the removal of 32-bit
time types from the kernel and UAPI.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/kernel/vdso32/vdso.lds.S      | 1 +
 arch/arm64/kernel/vdso32/vgettimeofday.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
index e02b27487ce8..c374fb0146f3 100644
--- a/arch/arm64/kernel/vdso32/vdso.lds.S
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -86,6 +86,7 @@ VERSION
 		__vdso_gettimeofday;
 		__vdso_clock_getres;
 		__vdso_clock_gettime64;
+		__vdso_clock_getres_time64;
 	local: *;
 	};
 }
diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
index 29b4d8f61e39..d7b39b0a9668 100644
--- a/arch/arm64/kernel/vdso32/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
@@ -32,6 +32,12 @@ int __vdso_clock_getres(clockid_t clock_id,
 	return __cvdso_clock_getres_time32(clock_id, res);
 }
 
+int __vdso_clock_getres_time64(clockid_t clock_id,
+			       struct __kernel_timespec *res)
+{
+	return __cvdso_clock_getres(clock_id, res);
+}
+
 /* Avoid unresolved references emitted by GCC */
 
 void __aeabi_unwind_cpp_pr0(void)

-- 
2.52.0


