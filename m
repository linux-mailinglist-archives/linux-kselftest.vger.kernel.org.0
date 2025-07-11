Return-Path: <linux-kselftest+bounces-37107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F3BB01D9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 15:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E13D166F75
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 13:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3162E4992;
	Fri, 11 Jul 2025 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YdaY3ujT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8xiXc1fn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808612D8385;
	Fri, 11 Jul 2025 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240711; cv=none; b=Y2CDIqrf2/VT3SwT9c0ghqW3F8URyt1+HaamIB3yg/EAB80MjQxkfjQldVZxwXiMfHkjy+i+4oeYQZZuF3JjOEAfbzRDO/0HzZT6lJjqcirgZRR4ZZARUxjJmJE9RBSHBuze/JG0JJfNaeEoguWFDH7mTzpBzQCKVeBBK6R3shI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240711; c=relaxed/simple;
	bh=uyQVNtFYubQWqnDxz8kwDvaTLDSgf0EX5hdLciiSLgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GgLA+WHQWfe5A3t0R3E0zo0HbwvNpwGfuWn0tKnydQDD41KVuGwTK96DFKp4gUIGD/7xmvA7P+T12mKCUY7AjP2wfq05ZxjFTemt1pEMMiFp7ZgwGB4HsC8GMnSX6yj7ho4TicqbWDS54HgS+OSWZFBrKnd7quVXasQ9VjF/+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YdaY3ujT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8xiXc1fn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752240701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Btm723Tj3GSfpvyvzYy+PcO2md/tGoRn5TD3OxPHpsU=;
	b=YdaY3ujTe2EdXCWh1KPbR6S+yhC7CxtCq7v0mT31WoBpboSFB3tSPoGFq+xL09VLsyRNm0
	2Pd0gWTsZaodKhwcjfw9c+j29hjwzMKqwVgIsq8MksGVC5fJQfhnXmYHdMSme4fuGL4GOV
	sAO98ml/cJWhdG6q7TUtVusGoaPn8jFIAH2JnaYPkx8PCrmIP05wOh2Zj7jbIvmVxubDSH
	I6f49PR3XyVTztEf+BCSQ/7Zlv42ruoBrHxSa9z+M/tJGmC3tlKXWeyC8jve/VaIfLYJeQ
	wHXc86zc+6b5lwEIe3V7m+3wdb3KD5dvjEk8irh160bp1TIIZuan36T+gWJ6eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752240701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Btm723Tj3GSfpvyvzYy+PcO2md/tGoRn5TD3OxPHpsU=;
	b=8xiXc1fnbLnfJc5l/qLnjuBUMsPJ8ZRlrNgpvbfFKDAoaC4A4YIgUM7UZ4DTnEcjl9XeZf
	YnZMYlptbpVSrdBw==
Date: Fri, 11 Jul 2025 15:31:37 +0200
Subject: [PATCH v2 2/3] module: make structure definitions always visible
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250711-kunit-ifdef-modules-v2-2-39443decb1f8@linutronix.de>
References: <20250711-kunit-ifdef-modules-v2-0-39443decb1f8@linutronix.de>
In-Reply-To: <20250711-kunit-ifdef-modules-v2-0-39443decb1f8@linutronix.de>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752240698; l=2512;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=uyQVNtFYubQWqnDxz8kwDvaTLDSgf0EX5hdLciiSLgY=;
 b=lb+pts3Y3LJpQdZfpzs2v9mvidtFNqDyrDtmzD6zcdlj3ZqRRBaFhn6h6I/wLMh2mkMCZBVCq
 /3RmzO1fTe/B+K5cx3upAxr3tQvaZYdTUJ2NePubK6AXGRQ1XIlpEv8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To write code that works with both CONFIG_MODULES=y and CONFIG_MODULES=n
it is convenient to use "if (IS_ENABLED(CONFIG_MODULES))" over raw #ifdef.
The code will still fully typechecked but the unreachable parts are
discarded by the compiler. This prevents accidental breakage when a certain
kconfig combination was not specifically tested by the developer.
This pattern is already supported to some extend by module.h defining
empty stub functions if CONFIG_MODULES=n.
However some users of module.h work on the structured defined by module.h.

Therefore these structure definitions need to be visible, too.

Many structure members are still gated by specific configuration settings.
The assumption for those is that the code using them will be gated behind
the same configuration setting anyways.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
---
 include/linux/module.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 52f7b0487a2733c56e2531a434887e56e1bf45b2..2f330e60a7420a144abeed6d357ac93c39a705e9 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -302,17 +302,6 @@ static typeof(name) __mod_device_table__##type##__##name		\
 
 struct notifier_block;
 
-#ifdef CONFIG_MODULES
-
-extern int modules_disabled; /* for sysctl */
-/* Get/put a kernel symbol (calls must be symmetric) */
-void *__symbol_get(const char *symbol);
-void *__symbol_get_gpl(const char *symbol);
-#define symbol_get(x)	({ \
-	static const char __notrim[] \
-		__used __section(".no_trim_symbol") = __stringify(x); \
-	(typeof(&x))(__symbol_get(__stringify(x))); })
-
 enum module_state {
 	MODULE_STATE_LIVE,	/* Normal state. */
 	MODULE_STATE_COMING,	/* Full formed, running module_init. */
@@ -602,6 +591,17 @@ struct module {
 #define MODULE_ARCH_INIT {}
 #endif
 
+#ifdef CONFIG_MODULES
+
+extern int modules_disabled; /* for sysctl */
+/* Get/put a kernel symbol (calls must be symmetric) */
+void *__symbol_get(const char *symbol);
+void *__symbol_get_gpl(const char *symbol);
+#define symbol_get(x)	({ \
+	static const char __notrim[] \
+		__used __section(".no_trim_symbol") = __stringify(x); \
+	(typeof(&x))(__symbol_get(__stringify(x))); })
+
 #ifndef HAVE_ARCH_KALLSYMS_SYMBOL_VALUE
 static inline unsigned long kallsyms_symbol_value(const Elf_Sym *sym)
 {

-- 
2.50.0


