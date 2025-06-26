Return-Path: <linux-kselftest+bounces-35825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C60AE95DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86054A3C17
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 06:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EE025F7BC;
	Thu, 26 Jun 2025 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v4++KhTn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tvtEqPYg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F8F25B30F;
	Thu, 26 Jun 2025 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918227; cv=none; b=HuP3783K7vx37OoTsvE0VnsJRdk6A0qavfldnHL5rQK2US4DQ7s70N7bbIX/w5JPIGAvXUDa0IFW94kqeW8iPQAuGQzUKSc8KBztqG4dcANbcDbVdLk87EM8xo7n5w3EiSml7dj9CQDGj7qOieFB2RGgTOOArASHcQYNixyQ3hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918227; c=relaxed/simple;
	bh=uYbDX0tuhfBybp4zBtjmC97SEQNiCLwjFQ5JZf0se98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LF/owQSlFnPr/ifGAWSL4/6y43Giqf2sxi3CqZMOWKGs2uy6bCtZX58p2ujOUQQNnZdefUCO+e4KZd4PSsy7dxgFr9Vf3Ust8p6EUSVeq60i8H0oY1U56Tfs3UC72DM0eIf6pc1fUR6yGHuh9OvsYOSFwiseMEEIo3KfHMBsIDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v4++KhTn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tvtEqPYg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750918223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3coL6itBSAQiKwOZXEjAxfGw4ky2lWtS9inL/ixAlLY=;
	b=v4++KhTnPPFuPM9Ey/EmHXx78bsZhsVnFmix4Js0ZXIz9El+jb+2FkdDpikYs8KweXtdOE
	lbJVEHgZDz00XeW3zB4u2fI9Ef4SRrAtzxwP5F6fRouY6XglqJfAVc0b/1YNvrh5PANy69
	avbRO2l4/9XWyHkyEoo1J67Qv/s7BoRIn3qbW3KHJcr8MD7o5KIzp6+FczyxEEUjkz5Spk
	Ofz/Val5jS3NtIq8yABzAmhAHIRcY83x40RAtZeGpF+BS2viF+dCbjlC8t75K6rND1nTQZ
	pIIaL4TiT879o1B1KamrQE8qHu04IFwwGLg0qzb2L5q2GZgbvxCvZ+Dj9zwWuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750918223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3coL6itBSAQiKwOZXEjAxfGw4ky2lWtS9inL/ixAlLY=;
	b=tvtEqPYgruJkmvyuACoyC4MeTc51hxk2+VrxAhb0PnKtfTNVZYE/opPti94cdtpx35qUBT
	dteDwLOErJPWiLCQ==
Date: Thu, 26 Jun 2025 08:10:18 +0200
Subject: [PATCH v4 10/15] kunit: Always descend into kunit directory during
 build
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-kunit-kselftests-v4-10-48760534fef5@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750918216; l=1601;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=uYbDX0tuhfBybp4zBtjmC97SEQNiCLwjFQ5JZf0se98=;
 b=ntnAXJQ4+rKGjO3MSQAGD41KuCNgl3I6S4GaNRn9BPS5Ax88aMAwmHuszxIGFnGmMUyIgw8HS
 xO7SWYvAeJJCQXs87k/fDCf3Pv1ArKlXVgGvDeO8uT43wBHBQuldAmi
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

An upcoming change will add 'userprogs' to the kunit subdirectory.
For kbuild to properly clean up these build artifacts the subdirectory
needs to be always processed.

Pushing the special logic for hook.o into the kunit Makefile also makes the
logic easier to understand.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
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
2.50.0


