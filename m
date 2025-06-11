Return-Path: <linux-kselftest+bounces-34654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7B6AD4D45
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8811BC171A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E6D241671;
	Wed, 11 Jun 2025 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtyzkTdI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oZ2SorEm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0317D239E60;
	Wed, 11 Jun 2025 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749627519; cv=none; b=fi110kfmMuU4U1c84p++Vtc69HPaOsUwFiud3bnI9MVHrt3E+WUGpgTDktd0kwCFz+aPpkVDvGkdlsDgqsjHQ4/OJ8z3zhuN1tSNBDrTLevmLPHdhizwCzT+e7zlzoZ+R3NbEpL5zhRDuAHMzKC6EkzzvmNmn5ToNV91GAbEUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749627519; c=relaxed/simple;
	bh=hoA7a97F0nHmzoK4uqkonciDyfelXXtJw3EAVaFoPK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUcjrNlSbxDxYHk6P7T7ZrFpYh2BGtMxeawMc+R3Yg+PBe0quoGqEWcPoeSTRNXcqTk4BvA4GDKj+QhYeULJ9LJSUX8MK7Pn9rQSlsvQdjGyYR68SbpKC4sL0jYDkWcqQ84EJiQtWmucg2++pNvnw+rCV9162Q9LHzSNCDfPZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtyzkTdI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oZ2SorEm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749627516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jf+qTdJjsAtA+bB5leI4PJTuwlXOlpIX5ZJo2P0ZrRA=;
	b=rtyzkTdI4GnKlQy8FN0jWBCti8GM9cjAY4EaL0AVuEJ93q4rewugfqVCWCxMA13xPwVpnb
	Jv7Uas8YsyShnN6b1dugWzdwFWu6vjUMehLDoNRgBz9/vI+JyHvfNuI0gjLWO6OFxGmbBw
	/H4zgXqAgVwwHbpJWgCgWiQcgOw+KJUeIWr5+2lpjvW6SU2NEZek3Eno1Ww6oOdAE0toGO
	COQb7uoVM5cnifhwLsEnl9P/Ymkv7HkV4C6te8Nblte9PyD4NZNpIUzoBB4Ht55oZGezeE
	zo4QMc4P24bWpBZ0/9r1T3Xtelh+N1WUwvIOxBea0YW1CQdPbyUwflgN7DIXGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749627516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jf+qTdJjsAtA+bB5leI4PJTuwlXOlpIX5ZJo2P0ZrRA=;
	b=oZ2SorEmLMjdu7q+yki1JdD+B3tmZrXFV36vdUQFb7NaR26cMuYlhNKzBL3fO+wGYmAdnP
	bBc4CPNEeC8dBtBg==
Date: Wed, 11 Jun 2025 09:38:17 +0200
Subject: [PATCH v3 11/16] kunit: Always descend into kunit directory during
 build
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-kunit-kselftests-v3-11-55e3d148cbc6@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749627510; l=1555;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=hoA7a97F0nHmzoK4uqkonciDyfelXXtJw3EAVaFoPK4=;
 b=7XCG/h4e3mcUAjfa8Aj+npyCUw3MngEOW9PZ10TGYegk+rYvn7jRHXImmwGjIDh8ysh0FSRVG
 BGs07a1PUmiDcgBOvjkKKcDKLVtVaI6WGVnyGxP8YNWPsVPqhYjU4ID
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

An upcoming change will add 'userprogs' to the kunit subdirectory.
For kbuild to properly clean up these build artifacts the subdirectory
needs to be always processed.

Pushing the special logic for hook.o into the kunit Makefile also makes the
logic easier to understand.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/Makefile       | 4 ----
 lib/kunit/Makefile | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index c38582f187dd81916113319072e5cfef26f26c84..698566135091cc3bf0054f1954b434dc3325364a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -108,11 +108,7 @@ test_fpu-y := test_fpu_glue.o test_fpu_impl.o
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

-- 
2.49.0


