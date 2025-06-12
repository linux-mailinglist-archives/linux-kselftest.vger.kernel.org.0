Return-Path: <linux-kselftest+bounces-34823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB8BAD74D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 16:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBCF3B9886
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E419272E42;
	Thu, 12 Jun 2025 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gnawKIoi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sqRGwTU/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6395227144E;
	Thu, 12 Jun 2025 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740056; cv=none; b=VqozNoTuzVUdX2rWRN34ghtmHOlQvQKcDAmYvxphZ+T9mYt0yhpgoUDXC5239I+qhSqDX9kSA0UR+bHzioFxoZ6h7bEZzpLMMDMEnrZb49FPLRCucAykgxH24pXXvMcZgruOsAoh7tAxJUHNOzsoPVxTtkXo7Pv7g26biQFNOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740056; c=relaxed/simple;
	bh=wyQyoFVIz9BNAQTEup4OQAAq6QCYbrbFSp/A4F/wb34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hfLGVAvSqM3GK/FBxeLEAzrSi0voYmLGTcNbIolG29Cyx1UzTaDtUo2GiTkYFd8DLAbUERg5cYf0BiiNydPIvtVkR3XDZiYx/qtcJ9UXnjdS9B5AtrPx1AfkNRB6zWcqvePLc3ZcRWpgUK2hW0Y09t4XIW2B9iNfPlkt5tqbSFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gnawKIoi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sqRGwTU/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749740052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOK9i9v6BbXwcr/v2FjrIUA6OPZXWQvQuwVmq69EkK0=;
	b=gnawKIoiwmwJeVsV8wsFarTqW0Qm/BPcxZl0rLbjeUwh9cYRYdAjdiv9idVbQHdGcUDmTk
	6d7SYgHyDkJwmamVoeO1bEFTBWfdyusSSCZJk+iXCos7oKz4K6IiyNcDsG1m8JvGtNc6Es
	/sfNijqj4xegyT1ZTXy7ygcbdBixrbNsBc+24ZvmcnXwaTUDusQfXBudfb+1PtwvqigSlS
	g92oi1VRhTKHgyX6UarLaC7ieztKhX4kvG/qBjo/a8zGEKzqMpHXk2VxjfOOGWjJAm04a8
	EDM26lFfnleD7PHiyqgLt9OJN/528+um39fncB6t5VsEhDkR2tXKlfdV7LBuDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749740052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOK9i9v6BbXwcr/v2FjrIUA6OPZXWQvQuwVmq69EkK0=;
	b=sqRGwTU/00UaOrXhO1I0UX9W03zYXmPPOBIpQWRN9phMzBdzjqLD6M0GtI4J3BCNVK5fq2
	1Wy3l5tdbxzyqyDQ==
Date: Thu, 12 Jun 2025 16:53:56 +0200
Subject: [PATCH 3/3] kunit: test: Drop CONFIG_MODULE ifdeffery
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250612-kunit-ifdef-modules-v1-3-fdccd42dcff8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749740050; l=1571;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=wyQyoFVIz9BNAQTEup4OQAAq6QCYbrbFSp/A4F/wb34=;
 b=yrzQAGCyeN2NDV3FvRNsBSGrtj0yxPu0Ps2H4BamdaD79p/ifpI8CVNjq5fONgvs2MKpWCQej
 yUZxNK9bT5TBnWCBCkmPQKYu88T0LJZYof42i2sqmLjcu1Es9ob7Vml
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The function stubs exposed by module.h allow the code to compile properly
without the ifdeffery. The generated object code stays the same, as the
compiler can optimize away all the dead code.
As the code is still typechecked developer errors can be detected faster.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/kunit/test.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 146d1b48a0965e8aaddb6162928f408bbb542645..019b2ac9c8469021542b610278f8842e100d57ad 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -759,7 +759,6 @@ void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites)
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 
-#ifdef CONFIG_MODULES
 static void kunit_module_init(struct module *mod)
 {
 	struct kunit_suite_set suite_set, filtered_set;
@@ -847,7 +846,6 @@ static struct notifier_block kunit_mod_nb = {
 	.notifier_call = kunit_module_notify,
 	.priority = 0,
 };
-#endif
 
 KUNIT_DEFINE_ACTION_WRAPPER(kfree_action_wrapper, kfree, const void *)
 
@@ -938,20 +936,14 @@ static int __init kunit_init(void)
 	kunit_debugfs_init();
 
 	kunit_bus_init();
-#ifdef CONFIG_MODULES
 	return register_module_notifier(&kunit_mod_nb);
-#else
-	return 0;
-#endif
 }
 late_initcall(kunit_init);
 
 static void __exit kunit_exit(void)
 {
 	memset(&kunit_hooks, 0, sizeof(kunit_hooks));
-#ifdef CONFIG_MODULES
 	unregister_module_notifier(&kunit_mod_nb);
-#endif
 
 	kunit_bus_shutdown();
 

-- 
2.49.0


