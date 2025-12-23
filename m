Return-Path: <linux-kselftest+bounces-47923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6078CD853E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 08:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E18B3021E9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 06:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B514130E838;
	Tue, 23 Dec 2025 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XC+dlZEx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aQcdd4oK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFAD30B524;
	Tue, 23 Dec 2025 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473172; cv=none; b=m9s3bfrWQLTmOTu3sggrRoD1dQuE28FItByfkElHh+i7FE6zZn/IL/ZiWlSZt5vfIZbRjXUrVh6slkQn4fvoeGBWE2mi+gKUP3YD6v8wt3LVWg+bJYiY2g0c9dlO7Ter8gjWS25UMTtyvgVbs0labMum/jH1ccEYbzDSgvynaFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473172; c=relaxed/simple;
	bh=RMI5k+F7krRakVS3hHkFucei6uZny6MTPLu5777RVD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V1hT3Ym3SK1iqeLgzw7VKcc9mN+HFQknMjFrVGD8pNZKbfse9Nn3OUMTF+WE7kKOzfg9i8SzHrC4uo/BNZE2nMpbAITbsBgHMBlWvEtkBaa7tZISJtqL5Yo0WllWsd5sxyR1fLuCteTfVCuulQQR9FuDbJwdsehmqze1avPpU8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XC+dlZEx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aQcdd4oK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mM2FUnSVD45WvsERcA4Tj2tAAZnWuUSteOTQa2M4nbc=;
	b=XC+dlZEx0hOWtTVhdiY1gIT200+4orY4OLW8hMT+k7m18wWJVaCcoQKTHEKQyuIyAF+rzr
	ykEATKYYMNDUSqd1YHXYZsTw45sBhGZ5hwPRiRygEq1bjNb9SHg2hyUe1OYZDmD0UM60wG
	+bsmBC5tDjIhvyl0fRDM5G6kvu7hbC7xLuw08kzbrP+Es9gCB9ZlXUpk9jebL/E1JvQbot
	B+Ma3layleeKbj0lFMowyi4gWvp09XSOQHKDgcN8/+9SzauRdohUwdlMf3bcPlOWgxXNp2
	2ZR1xfSYHw2BNUHOXBrF/fCOqJ6vGlkitwtnwi0+HZwvoPHjKUEaIvI6h8fMEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mM2FUnSVD45WvsERcA4Tj2tAAZnWuUSteOTQa2M4nbc=;
	b=aQcdd4oK6OqxKV0iUCrlWPMUZ5iWlq0R4haZuSns4MDs+JY4k89d4sUXTdM13mP8NgkUja
	f74MfFbCgkiLkaBg==
Date: Tue, 23 Dec 2025 07:59:20 +0100
Subject: [PATCH 9/9] MIPS: vdso: Provide getres_time64() for 32-bit ABIs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-vdso-compat-time32-v1-9-97ea7a06a543@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473161; l=1324;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=RMI5k+F7krRakVS3hHkFucei6uZny6MTPLu5777RVD0=;
 b=FByXLnZDtqFeAsI04xGLObUsOOvjQRML1ATRv1MT5GgR20btjHvIoffIcSRS07gaXJejOb1Ou
 U7yhvSnzbP0AqwbnejJr7AWQjsKwDDviO1gh3dDeEK9TMplIHHd665C
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

For consistency with __vdso_clock_gettime64() there should also be a
64-bit variant of clock_getres(). This will allow the extension of
CONFIG_COMPAT_32BIT_TIME to the vDSO and finally the removal of 32-bit
time types from the kernel and UAPI.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/mips/vdso/vdso.lds.S      | 1 +
 arch/mips/vdso/vgettimeofday.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
index c8bbe56d89cb..5d08be3a6b85 100644
--- a/arch/mips/vdso/vdso.lds.S
+++ b/arch/mips/vdso/vdso.lds.S
@@ -103,6 +103,7 @@ VERSION
 		__vdso_clock_getres;
 #if _MIPS_SIM != _MIPS_SIM_ABI64
 		__vdso_clock_gettime64;
+		__vdso_clock_getres_time64;
 #endif
 #endif
 	local: *;
diff --git a/arch/mips/vdso/vgettimeofday.c b/arch/mips/vdso/vgettimeofday.c
index 604afea3f336..59627f2f51b7 100644
--- a/arch/mips/vdso/vgettimeofday.c
+++ b/arch/mips/vdso/vgettimeofday.c
@@ -46,6 +46,12 @@ int __vdso_clock_gettime64(clockid_t clock,
 	return __cvdso_clock_gettime(clock, ts);
 }
 
+int __vdso_clock_getres_time64(clockid_t clock,
+			       struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_getres(clock, ts);
+}
+
 #else
 
 int __vdso_clock_gettime(clockid_t clock,

-- 
2.52.0


