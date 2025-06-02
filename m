Return-Path: <linux-kselftest+bounces-34140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469E9ACB5BA
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 17:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA30168D74
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD74D229B36;
	Mon,  2 Jun 2025 14:49:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD014229B1E;
	Mon,  2 Jun 2025 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875796; cv=none; b=aJLZy0HnslXNF7v1AZ4jTkn1J6NdL1qgs4WcFxYJZgfsXhQkfFL+Teioftb5UmGuqvMYmfEhF2I75z5wbY4+0gk4gF9vT/XrfbZ0XVCnH9uYe3FAl/77WTf9s7Bl5a9v/QCX8JVOyhnul4POOtlOf7QWRfhZ4HxERKIeIH8wFUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875796; c=relaxed/simple;
	bh=UM3C4cwYFnomaoOmG+MOnC3qVnLRE4Eqmt0i5bm7r7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5W8/xnXuMQuCBr0LCkorjWdolmv2cGTEpThdX/pXoHTjm5c/z5v6r1+rO5eeoyT1vmzqmDneDln8QxBCg5FWNwIa+ezWbFxmio+vGo39FWUzHClTCOmRRcIv7macXqM3A0F3unBu9EeqJBqNODY8OP1uoWGp2GgQ2DISK30xmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC05C4CEEB;
	Mon,  2 Jun 2025 14:49:54 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>
Cc: linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] lib/tests: Make RANDSTRUCT_KUNIT_TEST depend on RANDSTRUCT
Date: Mon,  2 Jun 2025 16:49:51 +0200
Message-ID: <22d9c2fa9e751a9de3c599aa082be588ea82a7a0.1748875640.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_RANDSTRUCT is not enabled, all randstruct tests are skipped.
Move this logic from run-time to config-time, to avoid people building
and running tests that do not do anything.

Fixes: b370f7eacdcfe1dd ("lib/tests: Add randstruct KUnit test")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
FTR, after adding "select HAVE_GCC_PLUGINS" to arch/m68k/Kconfig and
installing gcc-13-plugin-dev-m68k-linux-gnu, I could enable
CONFIG_RANDSTRUCT_FULL and run the tests (all passed!), so probably I
should send a patch to select HAVE_GCC_PLUGINS?
---
 lib/Kconfig.debug            | 4 ++--
 lib/tests/randstruct_kunit.c | 9 ---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a8b4febad716a4be..407f2ed7fcb3e94c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2895,10 +2895,10 @@ config OVERFLOW_KUNIT_TEST
 config RANDSTRUCT_KUNIT_TEST
 	tristate "Test randstruct structure layout randomization at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	depends on RANDSTRUCT
 	default KUNIT_ALL_TESTS
 	help
-	  Builds unit tests for the checking CONFIG_RANDSTRUCT=y, which
-	  randomizes structure layouts.
+	  Builds unit tests for checking structure layout randomization.
 
 config STACKINIT_KUNIT_TEST
 	tristate "Test level of stack variable initialization" if !KUNIT_ALL_TESTS
diff --git a/lib/tests/randstruct_kunit.c b/lib/tests/randstruct_kunit.c
index f3a2d63c4cfbe7dc..2c95eca76d2411bc 100644
--- a/lib/tests/randstruct_kunit.c
+++ b/lib/tests/randstruct_kunit.c
@@ -305,14 +305,6 @@ static void randstruct_initializers(struct kunit *test)
 #undef init_members
 }
 
-static int randstruct_test_init(struct kunit *test)
-{
-	if (!IS_ENABLED(CONFIG_RANDSTRUCT))
-		kunit_skip(test, "Not built with CONFIG_RANDSTRUCT=y");
-
-	return 0;
-}
-
 static struct kunit_case randstruct_test_cases[] = {
 	KUNIT_CASE(randstruct_layout_same),
 	KUNIT_CASE(randstruct_layout_mixed),
@@ -324,7 +316,6 @@ static struct kunit_case randstruct_test_cases[] = {
 
 static struct kunit_suite randstruct_test_suite = {
 	.name = "randstruct",
-	.init = randstruct_test_init,
 	.test_cases = randstruct_test_cases,
 };
 
-- 
2.43.0


