Return-Path: <linux-kselftest+bounces-47920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA00ACD854A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 08:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11A9F303F2BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 06:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C1F30BF6F;
	Tue, 23 Dec 2025 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bjH9bAf0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WGVAL1uj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694FA3093BF;
	Tue, 23 Dec 2025 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473171; cv=none; b=VwtM4V3Fzqd03U+JnsCM0gd7YU173mNSkvKieHr7v9FR3hzq79UnuJjAqMgJbwVvXXt0GijlzAYKo93HDc1A7XSruXAFMk0thAEWWBWWExgJcl3MKkhyB3E4JbpddJXzJGUpovSh41fgmw3VLSBr15NrXD4JLqha6/T2jSccXBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473171; c=relaxed/simple;
	bh=LdmbtEljOlFyOZ6OrGxnqW75nza0HGI8PoT+uoNSI7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lSmq/Xc9QI2m6C+3ZWQ85epYcZCMMwJldBEIyaBY0AbYnM2fpigVqPdKxQT3KDAQ8TduDEEsch1Y2NNKRgHrztQIE8goDtz4ZYdDf9QizKSFtV1sbTeBT6Mm4HZL20+PAn0qQfaFrulcPaRurcq1TAhxhq+YaOg9uFv34IJ3lqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bjH9bAf0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WGVAL1uj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeL+wNwtwp13/IriifZjEinyNYsN2WU00+W+l3D3JKc=;
	b=bjH9bAf08zKh3tAojpWoL3lwE4aziyDxCSkUkVIhCye/CcVYT7mR6MCF5e98jTHn0xdotd
	b0IyYodFLpYFw6/2+8ivpw3fA2h0+NVcXbekaet3Dt7F15oPF0Ho1jq1bpbW8HpSDjwdeL
	r/FPNWtEWkOIhuRFaslDfreIILE96n5JOQtWmL8iA5Of3rfQd3/bKk1v/kanAnFDOn/kv0
	Jguykck40SqjdphGGu4eTnXXJgpXp6w8dKIgR0LzLvP5N9tP4APpm7UP03QfAIwMRXIzx7
	xaG1aR7RUPMQJnonfu5ynB+lrqJ2lZoKg9Uff8TEjEKa38AihhEvtX8v8ttYsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeL+wNwtwp13/IriifZjEinyNYsN2WU00+W+l3D3JKc=;
	b=WGVAL1ujmSWzDJFGCarIiVPBmebqrKoHBbZ/8WEH9BEyDbQX4f26hDbVfoL91hJOG6z4tE
	KGZ/I0SZ+VV4xKCg==
Date: Tue, 23 Dec 2025 07:59:17 +0100
Subject: [PATCH 6/9] ARM: VDSO: also patch out __vdso_clock_getres() if
 unavailable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-vdso-compat-time32-v1-6-97ea7a06a543@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473161; l=814;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=LdmbtEljOlFyOZ6OrGxnqW75nza0HGI8PoT+uoNSI7M=;
 b=wlCQXSEJCoro5/Gj9o6p9RQLUD8hyzOugG9AocBBzD5Jh/2OlROC1hfuz+G7GHz2eosk52Ypr
 Aetv2oFKV1kDXvVyOyKB+fVpgD/q+Z3ndRGByNySeJ4yOjtX5I9z+4l
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The vDSO code hides symbols which are non-functional.
__vdso_clock_getres() was not added to this list when it got introduced.

Fixes: 052e76a31b4a ("ARM: 8931/1: Add clock_getres entry point")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm/kernel/vdso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index e38a30477f3d..566c40f0f7c7 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -161,6 +161,7 @@ static void __init patch_vdso(void *ehdr)
 		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime64");
+		vdso_nullpatch_one(&einfo, "__vdso_clock_getres");
 	}
 }
 

-- 
2.52.0


