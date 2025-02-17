Return-Path: <linux-kselftest+bounces-26782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F996A3853C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 15:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A855D3AAB48
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E58944E;
	Mon, 17 Feb 2025 14:00:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238D533DF;
	Mon, 17 Feb 2025 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800828; cv=none; b=mktNbTnvf3JZu8i54CDGyjO+l+PUfMldgrKcozd8ULiWDRfjbSUQiuwdcyE2Tc/Qy2AheHxxtClSppSm8qCjggbBRpOWI58BRcdfTO7B7ew7vjc0eoHVKXtEs6+z6nxTC/fYwvLy6dXVSAlBbks+eHZyE/qXimsCNfTS5O8YPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800828; c=relaxed/simple;
	bh=AtEqx9QGTWktOsZgYPLB/2CcwL4t2IRHK+54r66qrMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYWUIMxbTTM4oHU4w7UMWIAWuo3T3Eo5LoPYS1nrd+NBkaZexsQ5ER/WOenXnhAvDaZtsmZqqTNDy5FQWx8meSdoYOWlHdE4/2GG/q5pm9kTo2N/UStCGXQClqY1wkbgxawFjQXlv7wc6n2qJQBmuU3kl1HPnRtQkfZtQStcov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A029152B;
	Mon, 17 Feb 2025 06:00:44 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B50D3F6A8;
	Mon, 17 Feb 2025 06:00:23 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: kunit-dev@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] kunit: Clarify kunit_skip() argument name
Date: Mon, 17 Feb 2025 14:00:08 +0000
Message-ID: <20250217140008.1941287-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kunit_skip() and kunit_mark_skipped() can only be passed a pointer
to a struct kunit, not struct kunit_suite (only kunit_log() actually
supports both). Rename their first argument accordingly.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org
---
 include/kunit/test.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 58dbab60f853..0ffb97c78566 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -553,9 +553,9 @@ void kunit_cleanup(struct kunit *test);
 void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt, ...);
 
 /**
- * kunit_mark_skipped() - Marks @test_or_suite as skipped
+ * kunit_mark_skipped() - Marks @test as skipped
  *
- * @test_or_suite: The test context object.
+ * @test: The test context object.
  * @fmt:  A printk() style format string.
  *
  * Marks the test as skipped. @fmt is given output as the test status
@@ -563,18 +563,18 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
  *
  * Test execution continues after kunit_mark_skipped() is called.
  */
-#define kunit_mark_skipped(test_or_suite, fmt, ...)			\
+#define kunit_mark_skipped(test, fmt, ...)				\
 	do {								\
-		WRITE_ONCE((test_or_suite)->status, KUNIT_SKIPPED);	\
-		scnprintf((test_or_suite)->status_comment,		\
+		WRITE_ONCE((test)->status, KUNIT_SKIPPED);		\
+		scnprintf((test)->status_comment,			\
 			  KUNIT_STATUS_COMMENT_SIZE,			\
 			  fmt, ##__VA_ARGS__);				\
 	} while (0)
 
 /**
- * kunit_skip() - Marks @test_or_suite as skipped
+ * kunit_skip() - Marks @test as skipped
  *
- * @test_or_suite: The test context object.
+ * @test: The test context object.
  * @fmt:  A printk() style format string.
  *
  * Skips the test. @fmt is given output as the test status
@@ -582,10 +582,10 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
  *
  * Test execution is halted after kunit_skip() is called.
  */
-#define kunit_skip(test_or_suite, fmt, ...)				\
+#define kunit_skip(test, fmt, ...)					\
 	do {								\
-		kunit_mark_skipped((test_or_suite), fmt, ##__VA_ARGS__);\
-		kunit_try_catch_throw(&((test_or_suite)->try_catch));	\
+		kunit_mark_skipped((test), fmt, ##__VA_ARGS__);		\
+		kunit_try_catch_throw(&((test)->try_catch));		\
 	} while (0)
 
 /*

base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
-- 
2.47.0


