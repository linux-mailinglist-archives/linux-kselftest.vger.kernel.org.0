Return-Path: <linux-kselftest+bounces-29870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD42A73657
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 17:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1124A188D8AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273EB1A3A8A;
	Thu, 27 Mar 2025 16:07:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A141946C8
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Mar 2025 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743091648; cv=none; b=Vz6zMsiNwkhYq3Rs4YmvRmUPdbOVCApXWVP8++q6UmPtPMW+/hNJSZRdJwJDpiiiAInhbIxyqb6nmoDBhFTutSVyE7djP4588I0apw2S1f1Sm6M+NYFJD5mTadq0ujK7eHbz3QuAMPSm+vtGSQkN8zMe+qrXACk80amOCboFwEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743091648; c=relaxed/simple;
	bh=3NHdB2+UGT7HfIY9ccBV/ZQxF/lf50lsjoSnnFB4jIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNnE9hxD27YNV9K3eESGhDR+Q3MwxIiSQepPYJcZn98dqVtITmItKUgFgNNfmV2oV4IzKt3U1o0PWqamKOAL4Ejll/pH03Y8WQTrQ49e0MB45Wtz+MKLPq493ys1kcneGBSL4s/6uJI9GC5TPl8Z+kloJGp/I3iwIbPwPb0H9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b1ef:107c:7814:6642])
	by michel.telenet-ops.be with cmsmtp
	id Vs7G2E0095Szt1p06s7Gzd; Thu, 27 Mar 2025 17:07:16 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1txplD-0000000FsoA-3a7N;
	Thu, 27 Mar 2025 17:07:16 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1txplE-00000006E5W-1V1l;
	Thu, 27 Mar 2025 17:07:16 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/RFC] kunit/rtc: Add real support for very slow tests
Date: Thu, 27 Mar 2025 17:07:15 +0100
Message-ID: <49d57ab512c47f01d6c374d533f1752871ea4246.1743091573.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running rtc_lib_test ("lib_test" before my "[PATCH] rtc: Rename
lib_test to rtc_lib_test") on m68k/ARAnyM:

    KTAP version 1
    1..1
	KTAP version 1
	# Subtest: rtc_lib_test_cases
	# module: rtc_lib_test
	1..2
	# rtc_time64_to_tm_test_date_range_1000: Test should be marked slow (runtime: 3.222371420s)
	ok 1 rtc_time64_to_tm_test_date_range_1000
	# rtc_time64_to_tm_test_date_range_160000: try timed out
	# rtc_time64_to_tm_test_date_range_160000: test case timed out
	# rtc_time64_to_tm_test_date_range_160000.speed: slow
	not ok 2 rtc_time64_to_tm_test_date_range_160000
    # rtc_lib_test_cases: pass:1 fail:1 skip:0 total:2
    # Totals: pass:1 fail:1 skip:0 total:2
    not ok 1 rtc_lib_test_cases

Commit 02c2d0c2a84172c3 ("kunit: Add speed attribute") added the notion
of "very slow" tests, but this is further unused and unhandled.

Hence:
  1. Introduce KUNIT_CASE_VERY_SLOW(),
  2. Increase timeout by ten; ideally this should only be done for very
     slow tests, but I couldn't find how to access kunit_case.attr.case
     from kunit_try_catch_run(),
  3. Mark rtc_time64_to_tm_test_date_range_1000 slow,
  4. Mark rtc_time64_to_tm_test_date_range_160000 very slow.

Afterwards:

    KTAP version 1
    1..1
	KTAP version 1
	# Subtest: rtc_lib_test_cases
	# module: rtc_lib_test
	1..2
	# rtc_time64_to_tm_test_date_range_1000.speed: slow
	ok 1 rtc_time64_to_tm_test_date_range_1000
	# rtc_time64_to_tm_test_date_range_160000.speed: very_slow
	ok 2 rtc_time64_to_tm_test_date_range_160000
    # rtc_lib_test_cases: pass:2 fail:0 skip:0 total:2
    # Totals: pass:2 fail:0 skip:0 total:2
    ok 1 rtc_lib_test_cases

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/rtc/rtc_lib_test.c |  4 ++--
 include/kunit/test.h       | 11 +++++++++++
 lib/kunit/try-catch.c      |  3 ++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc_lib_test.c b/drivers/rtc/rtc_lib_test.c
index c30c759662e39b48..fd3210e39d37dbc6 100644
--- a/drivers/rtc/rtc_lib_test.c
+++ b/drivers/rtc/rtc_lib_test.c
@@ -85,8 +85,8 @@ static void rtc_time64_to_tm_test_date_range_1000(struct kunit *test)
 }
 
 static struct kunit_case rtc_lib_test_cases[] = {
-	KUNIT_CASE(rtc_time64_to_tm_test_date_range_1000),
-	KUNIT_CASE_SLOW(rtc_time64_to_tm_test_date_range_160000),
+	KUNIT_CASE_SLOW(rtc_time64_to_tm_test_date_range_1000),
+	KUNIT_CASE_VERY_SLOW(rtc_time64_to_tm_test_date_range_160000),
 	{}
 };
 
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9b773406e01f3c43..4e3c1cae5b41466e 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -183,6 +183,17 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
 		{ .run_case = test_name, .name = #test_name,	\
 		  .attr.speed = KUNIT_SPEED_SLOW, .module_name = KBUILD_MODNAME}
 
+/**
+ * KUNIT_CASE_VERY_SLOW - A helper for creating a &struct kunit_case
+ * with the very slow attribute
+ *
+ * @test_name: a reference to a test case function.
+ */
+
+#define KUNIT_CASE_VERY_SLOW(test_name)			\
+		{ .run_case = test_name, .name = #test_name,	\
+		  .attr.speed = KUNIT_SPEED_VERY_SLOW, .module_name = KBUILD_MODNAME}
+
 /**
  * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
  *
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 6bbe0025b0790bd2..92099c67bb21d0a4 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -56,7 +56,8 @@ static unsigned long kunit_test_timeout(void)
 	 * If tests timeout due to exceeding sysctl_hung_task_timeout_secs,
 	 * the task will be killed and an oops generated.
 	 */
-	return 300 * msecs_to_jiffies(MSEC_PER_SEC); /* 5 min */
+	// FIXME times ten for KUNIT_SPEED_VERY_SLOW?
+	return 10 * 300 * msecs_to_jiffies(MSEC_PER_SEC); /* 5 min */
 }
 
 void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
-- 
2.43.0


