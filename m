Return-Path: <linux-kselftest+bounces-47916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18417CD84FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 07:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6AB73019E2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 06:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CEA3090CB;
	Tue, 23 Dec 2025 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hkw+tEB2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mBU157Fk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E5B3054EC;
	Tue, 23 Dec 2025 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473168; cv=none; b=TeFBi/MybV+IzzmHVeVjGft/pADMKocZDwEazIZQRZYUgzQ3Jxuc+TBvVCbNDg0j2azWK1F51UjJlYTG1WfzyEU1lq9eDUhAdNl3XwyklqsfV7vDfOcDVLn7T9tRUPIBJ/kUcyVBJwL2yzP+rRUu5Fky6UqOLeEZOACPKIrpR8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473168; c=relaxed/simple;
	bh=3oEs5t8kcw4pff3/fxmwVbbNr3F+8kVWQ5JxjTLWNN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0jGngT3iAcLQZ+zesEJNey/gk1Y2gO8jhLcWfwKt9zC/GfCc9rZvWQzquwtCFtdnKcnv/T211xAs2yVhTYtctwpKBnxsnc7VBU8fS2YZuHoyb93HdD7OOXpWb/dXZL7zc72IeAW7skdJXFdO1pIhFLrPcKaQd0xlEmDRLoWtnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hkw+tEB2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mBU157Fk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boeLpF9WDhdBW8/8XalkGVrMMM8dMtfSsPcLznvCp14=;
	b=Hkw+tEB2yMUUE6Mor+NRnWTO0lwB6U+Ba3sAzEYTuRKnupzAYPIH6BRmkgoo0ecwGvfYrs
	tGPWb2S594YNkvwPrnN1nJDOseOc0/88vej2lrYBAdg2d53H9N/N9M5FVrCyFy59tuu3qg
	FRAnlCQzx1Q14Z2WYZHXnNe/Dhu6wJkF27rYxRrxaijiVueExSnumvro92bgcADtPxKdg0
	CGS8ghn7jLmUniHi/JAaYoHv9Ht0gvxRPtfbtVtgA93B85PTp6HnH4zEPOpXRNtokVIWi1
	5aexoGYjotxYzJ4Nuqq9eW6jQKE8gDj8LkdFQxKEjcPIL+2zCYGcqeDkNpAesQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boeLpF9WDhdBW8/8XalkGVrMMM8dMtfSsPcLznvCp14=;
	b=mBU157FkcpYw23skKX2BNcGNQT5kMr8gUgG4EhHPJxACEsVAFlSteTQrgL8962Oie8hOgy
	R/BgvRtaO3hvKOAg==
Date: Tue, 23 Dec 2025 07:59:13 +0100
Subject: [PATCH 2/9] selftests: vDSO: vdso_config: Add configurations for
 clock_getres_time64()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-vdso-compat-time32-v1-2-97ea7a06a543@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473161; l=1154;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3oEs5t8kcw4pff3/fxmwVbbNr3F+8kVWQ5JxjTLWNN0=;
 b=94S1aojsIz+AvSGGvP1+uQ1Zn56fqN2xhvjTe0sHg67LZ5VHZkqwK0z23deRKcNZ1SoS5v8Fw
 Ufc9DZKFW58C2L1JCrLIuXrIys4yvbKrvf0TcJfCs7YcnyjPWpawoQQ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some architectures will start to implement this function.
Make sure that tests can be written for it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_config.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
index 50c261005111..5da223731b81 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -66,7 +66,7 @@ static const char *versions[7] = {
 };
 
 __attribute__((unused))
-static const char *names[2][7] = {
+static const char *names[2][8] = {
 	{
 		"__kernel_gettimeofday",
 		"__kernel_clock_gettime",
@@ -75,6 +75,7 @@ static const char *names[2][7] = {
 		"__kernel_getcpu",
 		"__kernel_clock_gettime64",
 		"__kernel_getrandom",
+		"__kernel_clock_getres_time64",
 	},
 	{
 		"__vdso_gettimeofday",
@@ -84,6 +85,7 @@ static const char *names[2][7] = {
 		"__vdso_getcpu",
 		"__vdso_clock_gettime64",
 		"__vdso_getrandom",
+		"__vdso_clock_getres_time64",
 	},
 };
 

-- 
2.52.0


