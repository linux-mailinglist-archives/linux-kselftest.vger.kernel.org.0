Return-Path: <linux-kselftest+bounces-37108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F9FB01D9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 15:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F781CC0579
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B922D3EDC;
	Fri, 11 Jul 2025 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PMidT7Do";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AlepBclI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB192E4244;
	Fri, 11 Jul 2025 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240712; cv=none; b=EkN3TvtiMRR6hhSC/i7MwdNKo8MEQijjJey/qIe165xgYii0Nfst4mjVkoZaiWB/6p00SYM9UTaBkWu1g92e/hFPb88vCB/LNMKjJ5f/gmcF7e/RkI7tMG2pQZ6O47gXCXxF0/er4U1Z/IS41l3Vc7IBMT27oN8Vc14k3gfjFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240712; c=relaxed/simple;
	bh=fsxqqU+GLFfZRByMUIDTR587S6mamorI8y49+UvR7Co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1weS7l+PZe9hCBO42QoCvW9xkIr+uTl7JcC2w/7UCTrrXN2ntFT9yQVc7TnoDTNc/nKSpA+eU8ZNI1KZeMMg5E7TLTP0acNG8MadMHv+wwS/BMv+J8BtZV3II8iODa9TDi6+wJ1+mVuC+IGU3Hmnx6pjZM96bc031rz6w+uJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PMidT7Do; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AlepBclI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752240702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+3GmPUOZalI+XpNA7GfwdtSSuOK+L0NbsBb1GYhI/E=;
	b=PMidT7Doe6OV7izlRlc6I3t/EhZI9/wziv0NTgsjKnsG3pCJBqdtaNDF1m6JWt9Vu6J7iG
	KypOHQvZy7oLOXZr/sB0YIXStxwg5m4N13c9Wh9RLlBf0zTTHxSIMzjq8uiFg6w+uH869j
	NZhUvMnki0iPhJlhn/x+kFEq7u28//N2SB8VoGeGw2gSKI6viIcUqb0ZPxba9ZSLORE+xj
	OVqGXRKQSGxQTtt3lAL+4G3GskcdC4JbEf0aXySZrbe6o3Cx19X3s5chjnyElOs0FC9mfV
	x985COiZHLhACGN/MC97neFv/oBXXyuT1qaRbjn98Pken2vmv+r7vSwDuSXWVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752240702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+3GmPUOZalI+XpNA7GfwdtSSuOK+L0NbsBb1GYhI/E=;
	b=AlepBclIUbYNNnp/ev8B0H6onWObfDp4kkGH7fGwngwclXccuudBHm2+PIhL0jBZPD6XXM
	hGDvjwD6cqi4VdBw==
Date: Fri, 11 Jul 2025 15:31:38 +0200
Subject: [PATCH v2 3/3] kunit: test: Drop CONFIG_MODULE ifdeffery
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250711-kunit-ifdef-modules-v2-3-39443decb1f8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752240698; l=1664;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=fsxqqU+GLFfZRByMUIDTR587S6mamorI8y49+UvR7Co=;
 b=dPp4lDVDZrzsIt8xJPMdVqN3cVGDPoE7LnfmjqbH/+YD05b9u4sCuAEalOBqwcy1eqPxeqCOE
 7LXfN8QtuATCqN/5yc6VNFzsmswVmShH2nno6AfBGE0yHRW77e/5D8h
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The function stubs exposed by module.h allow the code to compile properly
without the ifdeffery. The generated object code stays the same, as the
compiler can optimize away all the dead code.
As the code is still typechecked developer errors can be detected faster.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
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
2.50.0


