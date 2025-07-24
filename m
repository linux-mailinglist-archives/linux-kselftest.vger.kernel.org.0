Return-Path: <linux-kselftest+bounces-37914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28391B10087
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554E11C280EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 06:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7A6221F34;
	Thu, 24 Jul 2025 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RkTYOUs9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="54etbo06"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B9121504E;
	Thu, 24 Jul 2025 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338439; cv=none; b=Q1khXouN4gVHh8ujDc4GilYZIJDc7STCx4135+yWoOTMR6/er+afWPs6RX87jpG3+CfkqcMdYv91u9yp1qnHfNQm9m30nKc5PXykpVIzFgyGkm4W4i7aDC7SVGRPDOrGLkjObT+4KpJhH3+A/YVY1Cy3CEIshQN/2Pqmgr0iiN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338439; c=relaxed/simple;
	bh=koyIeZfuhbvrzWK2wsblmJg2PU9c5PYkmwnbRsFnRPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n85JRBBcTdqxqtsQ7sQ3A7EO+lYQv6kUI0tS5Gq0rk52RMwSHCEwzdjmgMS32f/NlP7Nn3M07SSxnij17E/wNeq29Vf7LlHw8AJavqQFmOw0BcRgFx1GP04NvrOSKa5jnTkOEh9bKh20Ko9KKjKdXIpYjkRYqTdUfMWWLW5hgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RkTYOUs9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=54etbo06; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753338435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yG0avGJtBE/XALYu4LOkcH56INWLCuN3/17FOrM97YQ=;
	b=RkTYOUs9gAxn5OdGA3i8vBcbafRI70Yz07+LjXNo+nhUsNafKycD+7T3VLFdSdJXWOAyML
	VC+qiPvKbgrsnPRM+fgLa8LlRUz4mgNdt/d51VvjzH0mHT0FphdlhFdJSIpsMKylekHJdU
	olDbEoOhsEhdMMbl+Neic/6jGbRWG51HdPbcZCTdwWvb3/1oy9T+s2xtaeI5hKpiRIhxUg
	TPwLFvk4xBEPlZ/A9PwAnTCbwIOTm8DEv33RtGgcvcCicVM1x0BYBJMqVJlmxtPGnXTsMf
	ARJNlvaoJONQdGCAO1F+AUcg4Odt5cWWhyfDxV8K8Svuq0h1DyRUqEqKdcZO9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753338435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yG0avGJtBE/XALYu4LOkcH56INWLCuN3/17FOrM97YQ=;
	b=54etbo06eGj5k9NSeaHjwQ9xD+fzBnXqjehsGsdo6k62vatyAU71gBneRRy8wjdEDc1KGR
	pw53IdQttxmPMiDA==
Date: Thu, 24 Jul 2025 08:26:53 +0200
Subject: [PATCH RFC 03/14] clocksource: remove ARCH_CLOCKSOURCE_DATA
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250724-vdso-sparc64-generic-2-v1-3-e376a3bd24d1@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753338429; l=1684;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=WmxKokfq5txCP+WEVDEJYUDojXWBwhmOqD/hoAeQczk=;
 b=IB8R+UA250pFZzMQJRgXtxKdqC1vmAtAoqg2Iu3uzCHnpoj082MKqPZoiP3ubMo47ZeyGSGR3
 2mhsdq7AGZsBrgowJm/veuD3uwsNpMD43lhS4LDnUMSplaDM4NJaVcs
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Arnd Bergmann <arnd@arndb.de>

After sparc64, there are no remaining users of ARCH_CLOCKSOURCE_DATA
and it can just be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: John Stultz <jstultz@google.com>
[Thomas: drop sparc64 bits from the patch]
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/clocksource.h | 6 +-----
 kernel/time/Kconfig         | 4 ----
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 65b7c41471c390463770c2da13694e58e83b84ea..12d853b1883265cb47d93e33d8370e3957e7e695 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -25,8 +25,7 @@ struct clocksource_base;
 struct clocksource;
 struct module;
 
-#if defined(CONFIG_ARCH_CLOCKSOURCE_DATA) || \
-    defined(CONFIG_GENERIC_GETTIMEOFDAY)
+#if defined(CONFIG_GENERIC_GETTIMEOFDAY)
 #include <asm/clocksource.h>
 #endif
 
@@ -106,9 +105,6 @@ struct clocksource {
 	u64			max_idle_ns;
 	u32			maxadj;
 	u32			uncertainty_margin;
-#ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
-	struct arch_clocksource_data archdata;
-#endif
 	u64			max_cycles;
 	u64			max_raw_delta;
 	const char		*name;
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 5b47f9247d52023901b44eba4327a4b5f524b031..c950a8c832c172be36cc9943c4191c08cb121f56 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -9,10 +9,6 @@
 config CLOCKSOURCE_WATCHDOG
 	bool
 
-# Architecture has extra clocksource data
-config ARCH_CLOCKSOURCE_DATA
-	bool
-
 # Architecture has extra clocksource init called from registration
 config ARCH_CLOCKSOURCE_INIT
 	bool

-- 
2.50.1


