Return-Path: <linux-kselftest+bounces-47921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9AFCD850B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 08:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D9D43014D57
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 06:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC83330C62F;
	Tue, 23 Dec 2025 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IjVn5f6A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QpVdPWBa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D626A3043D6;
	Tue, 23 Dec 2025 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473171; cv=none; b=i8EkqcldOLbnT20j8g9VCPKMqHUyT0YJiy1OazTiGK7PCk8YVGJDMgJ6eQlr/F5XYkBPXt19fxahwo+wpmwrwXUedyaAjCW1pv5sVqK0DBHSCFkH7bSdBFzp3VrrRUlNHTMo3fJxeJNemsCCRTlFlSyji5JETtHu1Hl0rFjbpEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473171; c=relaxed/simple;
	bh=nldWa4kQ886kbFTIL9sYV2DTnWNpLETSHelHafpckaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=skP9Qk/t2LGbhCXcH5dPFZKr4QtiKmOHXX1LLNggqEOayVr16fTK7CbgeQwUcxAIByolbbpwOURVr3zpne4SUa0gs4kNAxCoG9fN8dns9+JWBk85eJ1Yb4QsSFCJYagcX2Jnf8a+vguvBabkD0NlzJoJuf98jwQkHIU3QWZUSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IjVn5f6A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QpVdPWBa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvs5Ig22q3GUo5N50D+zEpwy+yzRC74cy8bQ/BN/E5s=;
	b=IjVn5f6AgLOlQfCHqp5GJzD65PArhFv7j8tFOSrZFyFjtHhdHgGxHCjFO2TIOdIGVLHFbN
	06/dTedixnpJhwXuj8Ez+fhs2n0GZfNsHk8FV/jeqg5/xNHDf9W1mBKEW+l92KuIkMLqgS
	uApAoSv4xORbWiLCJYYLjBjGev4WDji4CEqG8/xRAIh0E9ghPKLfrWbAIbhVRztlaYzAfC
	9IHp0O1AVqo3QRJUK3+UQHs2GRpKEFT//IZo6FOsfTsRILuID50rdfYJt6dEIfQM55nDZ0
	jKMIdZPsjJNRcvvXyMZSfaKT2g0ePAKdc6jo17vFnZtMzcMnzAW3L7IzgQSNPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvs5Ig22q3GUo5N50D+zEpwy+yzRC74cy8bQ/BN/E5s=;
	b=QpVdPWBaPRZhT8wSESJZpjGlGAynxMrdY3o0+Ym4QaYxBDrB9hbYm4kqWxhtAxjFnpqTck
	4ibmJ2Q5RxcrYwAg==
Date: Tue, 23 Dec 2025 07:59:18 +0100
Subject: [PATCH 7/9] ARM: VDSO: provide clock_getres_time64()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-vdso-compat-time32-v1-7-97ea7a06a543@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473161; l=1854;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=nldWa4kQ886kbFTIL9sYV2DTnWNpLETSHelHafpckaI=;
 b=vNEJ/cyb1VaiaSFk+v0znP7UhHkc4mdRjK0VM30s+Pybx74RtyeUjLXYWr8QgB0B4rHpxCTuJ
 Cwfk3P1kGexBdd4oc+78w1+EcqgakcjUzBwj7H6xYdzY9xDY4h0YVsc
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

For consistency with __vdso_clock_gettime64() there should also be a
64-bit variant of clock_getres(). This will allow the extension of
CONFIG_COMPAT_32BIT_TIME to the vDSO and finally the removal of 32-bit
time types from the kernel and UAPI.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm/kernel/vdso.c        | 1 +
 arch/arm/vdso/vdso.lds.S      | 1 +
 arch/arm/vdso/vgettimeofday.c | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 566c40f0f7c7..0108f33d6bed 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -162,6 +162,7 @@ static void __init patch_vdso(void *ehdr)
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime64");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_getres");
+		vdso_nullpatch_one(&einfo, "__vdso_clock_getres_time64");
 	}
 }
 
diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 7c08371f4400..74d8d8bc8a40 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -74,6 +74,7 @@ VERSION
 		__vdso_gettimeofday;
 		__vdso_clock_getres;
 		__vdso_clock_gettime64;
+		__vdso_clock_getres_time64;
 	local: *;
 	};
 }
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 3554aa35f1ba..2874dde7e6cf 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -34,6 +34,12 @@ int __vdso_clock_getres(clockid_t clock_id,
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


