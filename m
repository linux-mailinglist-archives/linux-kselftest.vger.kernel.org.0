Return-Path: <linux-kselftest+bounces-34822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B62AD74C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 16:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298792C3CD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8F627145C;
	Thu, 12 Jun 2025 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oy9ANiMI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R5UGhGr5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B946E26A1D9;
	Thu, 12 Jun 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740055; cv=none; b=ObmLFvxTJtO4x8QuOKvIagBUHbpF6lyaUhyoVMKGK1+mv98OuntLqbofXD/McIecL8ryHLN31S9ytKn2uvwU6k4LBZhpNbS//7T35F0KRUJ1mL8VINxZWaau7krhBwgNYtyDnIwSQr7ZStDR//FY0Xecq8PYQjtl34CB5ET0rIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740055; c=relaxed/simple;
	bh=niUiIhtws9P5qDIKT0S/3drsqD7/xl/LcWtmDLJi/NI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dDrHfX6ivDQbfhmJ3mbjlM31X0B+pOgRzYlTwC9lVsYv0lfDz+Jhe/7xdBgyC6LerDgneVw486ZkToB8V9fKcdYhWGZvGVF55YZw+D+JGZBwtZKO4SZCyhhMOHP/MoqmIUCi2dGIH7j9P9RQkH+1DwJYPRBkyizWc2gZ2KsZTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oy9ANiMI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R5UGhGr5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749740052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M24rIsRf5aigxupTSgbptaAyROm7Nd6+w9ly1F0mS5k=;
	b=oy9ANiMIG5veIDzL047etxRtm96pYq3QBFHxKZjwjV5sdBy2HVcMG1L3EJhTgFjOofL5zZ
	jsYY8t5y4fKuscZSMii2Fu3SqVP6rDXi/0zTcPDZoId9Y+ozNPZ3A5EX6N3d9c+MZhXDot
	JYr/wv0F+srKJu31upCW5nyS7ySo87+EYWl/TlSb8g5cBQwKfqb2FOz5XAhDC/aYn8OCSO
	mAtljeMECuFIQeumVUg8x/NrnZyt9UJhuunC8Xwqg2o5z7UPZXFKZmvHHu6ORdl0I2xE9q
	ctI0B/Rsf2p9f3ymCaDfPl7S51NG866qdgIT+xa4cqGDipywfcwt0gC3WVDGwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749740052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M24rIsRf5aigxupTSgbptaAyROm7Nd6+w9ly1F0mS5k=;
	b=R5UGhGr59lmgZQvwCODHBySnzl8unM4TTBfCF3I3b5E/vb/k9qrhi4B862MdoEF4A1MvoP
	iHWTJiBI8XwARwDw==
Date: Thu, 12 Jun 2025 16:53:55 +0200
Subject: [PATCH 2/3] module: make structure definitions always visible
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250612-kunit-ifdef-modules-v1-2-fdccd42dcff8@linutronix.de>
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
In-Reply-To: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749740050; l=2463;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=niUiIhtws9P5qDIKT0S/3drsqD7/xl/LcWtmDLJi/NI=;
 b=mI8ymmHwWtFqx8BjRr2nnmxAs9BR0y5m8Eo8Ni11pCMju++icqXM4L3yfheyutVqS4Lxtwwwe
 pTtj8nGAEnMA7w0Vn5n5xELf7ZRmUEQd0+LXkJSvmWCYZ2Hv6ekcQfV
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
---
 include/linux/module.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 52f7b0487a2733c56e2531a434887e56e1bf45b2..7f783e71636542b99db3dd869a9387d14992df45 100644
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
@@ -598,6 +587,18 @@ struct module {
 	struct _ddebug_info dyndbg_info;
 #endif
 } ____cacheline_aligned __randomize_layout;
+
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
 #ifndef MODULE_ARCH_INIT
 #define MODULE_ARCH_INIT {}
 #endif

-- 
2.49.0


