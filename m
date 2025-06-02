Return-Path: <linux-kselftest+bounces-34141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 579CDACB687
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 17:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7E419472EC
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 15:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C32722D4FF;
	Mon,  2 Jun 2025 14:51:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48822259C;
	Mon,  2 Jun 2025 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875909; cv=none; b=AaqnDDADnlKSnhZZCOV0S9AWqF1W6KDr8PliSQACFF1Knt0UKz8d/kOk0Uqpzmxg8+Hv4R2B8ejO85FCZ24+nGuhQCOvCJHf+8hCivyYvacaXDsdkE51F5FxIxJ2dJqio05CQSyfTtd1wI7wXMXnMdTdwb2eKZ0xysTQxhlr6aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875909; c=relaxed/simple;
	bh=QbU08Oxgch8EyUJdjnd4rKfu/28BROHfTCaJAwOypcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XX5JT1Fay9VnS+9XpmnA80/Pgl0zFZ3+nrhJ0bhKs1TEoS142CdGliUXZJKh0ll5mLvIiUDZowXsFcFwBU/qa/Rg2KV2xYMsCrG0mQLCVwZLUUPtIjbK3Aa2ENve7SAbpYe9HB9WMWt/dga15TOM3Mz0ljoLkw5qD5DoZj5ujfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B762C4CEF2;
	Mon,  2 Jun 2025 14:51:46 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>
Cc: linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] lib/tests: Make FORTIFY_KUNIT_TEST depend on FORTIFY_SOURCE
Date: Mon,  2 Jun 2025 16:51:44 +0200
Message-ID: <e36d5e6996a7ea4dc694c4b8dedd15943952d33d.1748875801.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_FORTIFY_SOURCE is not enabled, all fortify tests are
skipped.  Move this logic from run-time to config-time, to avoid people
building and running tests that do not do anything.

This basically reverts commit 1a78f8cb5daac774 ("fortify: Allow KUnit
test to build without FORTIFY") in v6.9, which was v3 of commit
a9dc8d0442294b42 ("fortify: Allow KUnit test to build without FORTIFY")
in v6.5, which was quickly reverted in commit 5e2956ee46244ffb ("Revert
"fortify: Allow KUnit test to build without FORTIFY"").

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Let's keep on playing whack-a-mole ;-)
---
 lib/Kconfig.debug         | 1 +
 lib/tests/fortify_kunit.c | 8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 407f2ed7fcb3e94c..ca5afd192c9fbf51 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2912,6 +2912,7 @@ config STACKINIT_KUNIT_TEST
 config FORTIFY_KUNIT_TEST
 	tristate "Test fortified str*() and mem*() function internals at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	depends on FORTIFY_SOURCE
 	default KUNIT_ALL_TESTS
 	help
 	  Builds unit tests for checking internals of FORTIFY_SOURCE as used
diff --git a/lib/tests/fortify_kunit.c b/lib/tests/fortify_kunit.c
index 29ffc62a71e3f968..10b0e1b12cdc3ae2 100644
--- a/lib/tests/fortify_kunit.c
+++ b/lib/tests/fortify_kunit.c
@@ -48,11 +48,6 @@ void fortify_add_kunit_error(int write);
 #include <linux/string.h>
 #include <linux/vmalloc.h>
 
-/* Handle being built without CONFIG_FORTIFY_SOURCE */
-#ifndef __compiletime_strlen
-# define __compiletime_strlen __builtin_strlen
-#endif
-
 static struct kunit_resource read_resource;
 static struct kunit_resource write_resource;
 static int fortify_read_overflows;
@@ -1071,9 +1066,6 @@ static void fortify_test_kmemdup(struct kunit *test)
 
 static int fortify_test_init(struct kunit *test)
 {
-	if (!IS_ENABLED(CONFIG_FORTIFY_SOURCE))
-		kunit_skip(test, "Not built with CONFIG_FORTIFY_SOURCE=y");
-
 	fortify_read_overflows = 0;
 	kunit_add_named_resource(test, NULL, NULL, &read_resource,
 				 "fortify_read_overflows",
-- 
2.43.0


