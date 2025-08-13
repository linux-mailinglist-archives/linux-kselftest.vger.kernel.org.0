Return-Path: <linux-kselftest+bounces-38825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E12B24187
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 08:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C7AA7BB0EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 06:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166332D46C3;
	Wed, 13 Aug 2025 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PozzU8Tn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MwlOunu5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0872D29C3;
	Wed, 13 Aug 2025 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066517; cv=none; b=WY9+AFjpF2bmWIQAB5rXK2YohWjLe7gzEGoY+82hSCsk9eDo9f3k8SgddZdCAqK6rabheop2obHZVgQsZhXOMIv9SBaisRxC/jVzvOt/eJSIEm7Cu1BcEGL4wx2qE11IdRfVl9DZ1kpmeGEToXjR1XyRdKiUws9MyNXTHdRlHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066517; c=relaxed/simple;
	bh=/QBKFj04E0wLKqCYCfxHnknbQqtSSJTjVtaBdYn4nAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h0idVKESFKXELHqSVPBw+ENlMfElyJXMPazEtgfCHqGVa3wEHqW69B1oT7XZWNKIoDV7ormBL7/4QoZMyc0XtIJA3zlBGZ5ulmT3tH7Z2CHuZIOrfEKek02QpmuTK/gYWovUjhKG1XL0GN4ECNYGSFI1aH93KAk1jqAGqf4wDiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PozzU8Tn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MwlOunu5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755066513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mptAofYf1fHnXCj4lf2XrfrxrCV++6Ygk82lhhc9fPc=;
	b=PozzU8TnhMzaf0pTaB+OA2nR0YX3CNwEoLUSnBWN5dhxSzhLQIptZjAppRP7k1og/DNSIt
	BYu+ezU/Vv8V49LxTroRRaXTV9GIhG7AcnhLFsGAaRvZwFkRVPwFa0JGsmBrUEN3N3W9NO
	OZZxMDlKKssWLLls9+EjEPdKbHA6bzkCVxKs7BlHQBWdEO22Ly2nXadxOw7afkfioMk58L
	CK8vZb5OBMf1odzRIJa9v+I+KtK9e8hdXFQGgeLaEQ5tl0Ebbd8vdLIWe7CDCjJHVqViDR
	EJ4PcmEG96Fcs7bTIbkoFkhKAkv4xqFW1d3Uk0XJr084eD0pTU4WcA9K5KA3VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755066513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mptAofYf1fHnXCj4lf2XrfrxrCV++6Ygk82lhhc9fPc=;
	b=MwlOunu5uO/iw2XIroZQcjHRyZMETuZxWdNcLNOxxqoZ1A/N72sNJIkEnkkoIGvPbiCfJO
	6i6hRFK/qfynGlBg==
Date: Wed, 13 Aug 2025 08:28:30 +0200
Subject: [PATCH] kunit: Always descend into kunit directory during build
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250813-kunit-always-descend-v1-1-7bbd387ff13b@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAI0wnGgC/x3MTQ5AMBBA4avIrE1SbSS4iliUDiakpOM34u4ay
 2/x3gNCgUmgSh4IdLDw4iOyNIFutH4gZBcNWulcFZnBafe8oZ1Pews6ko68Q1NSrrQtWt2WENM
 1UM/Xv62b9/0Af8E+DGYAAAA=
X-Change-ID: 20250813-kunit-always-descend-39e502a8b2b9
To: Andrew Morton <akpm@linux-foundation.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755066513; l=2171;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=/QBKFj04E0wLKqCYCfxHnknbQqtSSJTjVtaBdYn4nAg=;
 b=gSnEBKFLfxTTMVAW2PgCUTcUev6b3EHUOzCHNc1Cqla18nJxjrNZnUfj62J8Dil9MEaPh597W
 AZtBTrg9RseAeX+7ox2t+I+Ee6go7qJr1XjO4MNdKiOrfakaM7jTmku
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

For kbuild to properly clean up these build artifacts in the subdirectory,
even after CONFIG_KUNIT changed do disabled, the directory needs to be
processed always.

Pushing the special logic for hook.o into the kunit Makefile also makes the
logic easier to understand.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
This patch was originally part of my series "kunit: Introduce UAPI
testing framework" [0], but that isn't going anywhere right now and the
patch is useful on its own.

Changes to the original series:
* Make the commit message more general, the same issue affects all build
  artifacts.
    
[0] https://lore.kernel.org/lkml/20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de/
---
 lib/Makefile       | 4 ----
 lib/kunit/Makefile | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 392ff808c9b90210849e397356d1aa435a47bd07..15a03f4c16e2cd6c75297005e71fa2108c1f41f2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -109,11 +109,7 @@ test_fpu-y := test_fpu_glue.o test_fpu_impl.o
 CFLAGS_test_fpu_impl.o += $(CC_FLAGS_FPU)
 CFLAGS_REMOVE_test_fpu_impl.o += $(CC_FLAGS_NO_FPU)
 
-# Some KUnit files (hooks.o) need to be built-in even when KUnit is a module,
-# so we can't just use obj-$(CONFIG_KUNIT).
-ifdef CONFIG_KUNIT
 obj-y += kunit/
-endif
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 5aa51978e456ab3bb60c12071a26cf2bdcb1b508..656f1fa35abcc635e67d5b4cb1bc586b48415ac5 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -17,7 +17,7 @@ kunit-objs +=				debugfs.o
 endif
 
 # KUnit 'hooks' are built-in even when KUnit is built as a module.
-obj-y +=				hooks.o
+obj-$(if $(CONFIG_KUNIT),y) +=		hooks.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 obj-$(CONFIG_KUNIT_TEST) +=		platform-test.o

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250813-kunit-always-descend-39e502a8b2b9

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


