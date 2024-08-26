Return-Path: <linux-kselftest+bounces-16347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB0895FCAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 00:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6661E283033
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 22:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1603F19D07D;
	Mon, 26 Aug 2024 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmY7cBFG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EFA19D090
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710847; cv=none; b=dUyGoa9zLMLDWjpVzvpIr/muZSs5fydDVYQgHaZs5CJEn8E87ZxpY3URsiygA9Z4ggVnkX6C6SSd0MLtpg8VkIyCCt5rKWQkfD3whgWXf/uM8jtK90nBhp7Q7xLTyf0BMfeh50+TUM2fj+99D4A6XyZspksPUOhJ6318T1hhXGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710847; c=relaxed/simple;
	bh=j17FxC2q9JsZ5Sd6M61sTCz1rZvBj8On6+3nC7HiN0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G2wcC6QIxlh2FvhZX7flonwW5lIovk3MFCzS3THx21G4vqjKvFv4qIVI67jmdK5NtX3kLlRh1KOyvKjmPaplMTdPnFMu4Ae33xnuSV88elAAN8LWrrG1Ff6PbjnAIRNoOoToGG4vsc7FdhXGHXUGtUOrefscJrqg60e3k+o+SHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmY7cBFG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724710846; x=1756246846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j17FxC2q9JsZ5Sd6M61sTCz1rZvBj8On6+3nC7HiN0M=;
  b=RmY7cBFGUmOLbAQRCbe2USXjEnj9XTtS5UyUg+XSuUojgS/ffB69v71X
   31ZsJD94kEsQJadSBi/joA6w9f9CtSdDw8q89Ka0fBFgytyTbTx3c1hjV
   bgB3+Kh5UaW70T8d2W+NXyuXxxn9j1lv8HAtSDkaMQcw88W2GjK1ytb5Z
   mffyxiTdoZal+xib1DuHQhN1/HVVs69ykKgiFOGj1iwkP0ful+7jhW+sr
   bDCMa6geCR42s0kf3XRAuWOTMlmlo8bZ1RSaBcEOhxqEuxorcirvIKq8m
   jnrr4s0/bcyL4KAxvPt7P/qT8LvQlV5W0F0+aq6gBVWT58hDP3htp+xfy
   g==;
X-CSE-ConnectionGUID: 5KVEkVjtQs+LGQeTLk/RFA==
X-CSE-MsgGUID: dXddBe/tTg6bIXf7AVEwAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34537414"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="34537414"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:20:45 -0700
X-CSE-ConnectionGUID: +0gMUt+tT0eejWL6066L1A==
X-CSE-MsgGUID: QnwiZ+WBQ/ya18SEtKPudQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66992274"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.1.253])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:20:44 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v2 6/6] kunit: Add some selftests for global stub redirection macros
Date: Tue, 27 Aug 2024 00:20:15 +0200
Message-Id: <20240826222015.1484-7-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240826222015.1484-1-michal.wajdeczko@intel.com>
References: <20240826222015.1484-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While we already have few ASSERT() within the implementation,
it's always better to have dedicated test cases. Add tests for:
 - automatic deactivation of the stubs at the test end
 - blocked deactivation until all active stub calls finish
 - blocked stub change until all active stub calls finish
 - safe abuse (deactivation without activation)

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: Rae Moar <rmoar@google.com>
Cc: David Gow <davidgow@google.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
---
 lib/kunit/kunit-test.c | 254 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 253 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 37e02be1e710..eb1bb312ad71 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -6,8 +6,10 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 #include "linux/gfp_types.h"
+#include <kunit/static_stub.h>
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
+#include <kunit/visibility.h>
 
 #include <linux/device.h>
 #include <kunit/device.h>
@@ -866,10 +868,260 @@ static struct kunit_suite kunit_current_test_suite = {
 	.test_cases = kunit_current_test_cases,
 };
 
+static struct {
+	/* this stub matches the real function */
+	KUNIT_DECLARE_GLOBAL_STUB(first_stub, int (*)(int i));
+	/* this stub matches only return type of the real function */
+	KUNIT_DECLARE_GLOBAL_STUB(second_stub, int (*)(int bit, int data));
+	/* this is an example stub that returns void */
+	KUNIT_DECLARE_GLOBAL_STUB(void_stub, void (*)(void));
+	/* this is an example how to store additional data for use by stubs */
+	DECLARE_IF_KUNIT(int data);
+	DECLARE_IF_KUNIT(int counter);
+} stubs = {
+	DECLARE_IF_KUNIT(.data = 3),
+};
+
+static int real_func(int i)
+{
+	KUNIT_GLOBAL_STUB_REDIRECT(stubs.first_stub, i);
+	KUNIT_GLOBAL_STUB_REDIRECT(stubs.second_stub, BIT(i), stubs.data);
+
+	return i;
+}
+
+struct real_work {
+	struct work_struct work;
+	int param;
+	int result;
+};
+
+static void real_work_func(struct work_struct *work)
+{
+	struct real_work *w = container_of(work, typeof(*w), work);
+
+	w->result = real_func(w->param);
+}
+
+static int real_func_async(int i)
+{
+	struct real_work w = { .param = i, .result = -EINPROGRESS };
+
+	INIT_WORK_ONSTACK(&w.work, real_work_func);
+	schedule_work(&w.work);
+	flush_work(&w.work);
+	destroy_work_on_stack(&w.work);
+
+	return w.result;
+}
+
+static int replacement_func(int i)
+{
+	return i + 1;
+}
+
+static int other_replacement_func(int i)
+{
+	return i + 10;
+}
+
+static int super_replacement_func(int bit, int data)
+{
+	return bit * data;
+}
+
+static int slow_replacement_func(int i)
+{
+	schedule_timeout_interruptible(HZ / 20);
+	return replacement_func(i);
+}
+
+static void real_void_func(void)
+{
+	KUNIT_GLOBAL_STUB_REDIRECT(stubs.void_stub);
+	DECLARE_IF_KUNIT(stubs.counter++);
+}
+
+static void replacement_void_func(void)
+{
+	stubs.counter--;
+}
+
+static void expect_deactivated(void *data)
+{
+	struct kunit *test = kunit_get_current_test();
+
+	KUNIT_EXPECT_NULL(test, stubs.first_stub.base.owner);
+	KUNIT_EXPECT_NULL(test, stubs.first_stub.base.replacement);
+	KUNIT_EXPECT_NULL(test, stubs.second_stub.base.owner);
+	KUNIT_EXPECT_NULL(test, stubs.second_stub.base.replacement);
+	KUNIT_EXPECT_NULL(test, stubs.void_stub.base.owner);
+	KUNIT_EXPECT_NULL(test, stubs.void_stub.base.replacement);
+}
+
+static void kunit_global_stub_test_deactivate(struct kunit *test)
+{
+	/* make sure everything will be deactivated */
+	KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, expect_deactivated, test));
+
+	/* deactivate without activate */
+	kunit_deactivate_global_stub(test, stubs.first_stub);
+
+	/* deactivate twice */
+	kunit_deactivate_global_stub(test, stubs.first_stub);
+
+	/* allow to skip deactivation (will be tested by expect_deactivated action) */
+	kunit_activate_global_stub(test, stubs.first_stub, replacement_func);
+}
+
+static void kunit_global_stub_test_activate(struct kunit *test)
+{
+	int real, replacement, other, super, i = 2;
+
+	/* prerequisites */
+	real_void_func();
+	KUNIT_ASSERT_EQ(test, stubs.counter, 1);
+	replacement_void_func();
+	KUNIT_ASSERT_EQ(test, stubs.counter, 0);
+
+	/* prerequisites cont'd */
+	KUNIT_ASSERT_EQ(test, real_func(i), real = real_func_async(i));
+	KUNIT_ASSERT_NE(test, real_func(i), replacement = replacement_func(i));
+	KUNIT_ASSERT_NE(test, real_func(i), other = other_replacement_func(i));
+	KUNIT_ASSERT_NE(test, real_func(i), super = super_replacement_func(BIT(i), stubs.data));
+
+	/* make sure everything will be deactivated */
+	KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, expect_deactivated, test));
+
+	/* allow to activate replacement */
+	kunit_activate_global_stub(test, stubs.void_stub, replacement_void_func);
+	real_void_func();
+	KUNIT_ASSERT_EQ(test, stubs.counter, -1);
+
+	/* allow to activate replacement */
+	kunit_activate_global_stub(test, stubs.first_stub, replacement_func);
+	KUNIT_EXPECT_EQ(test, real_func(i), replacement);
+	KUNIT_EXPECT_EQ(test, real_func_async(i), replacement);
+
+	/* allow to change replacement */
+	kunit_activate_global_stub(test, stubs.first_stub, other_replacement_func);
+	KUNIT_EXPECT_EQ(test, real_func(i), other);
+	KUNIT_EXPECT_EQ(test, real_func_async(i), other);
+
+	/* allow to deactivate replacement */
+	kunit_deactivate_global_stub(test, stubs.first_stub);
+	KUNIT_EXPECT_EQ(test, real_func(i), real);
+	KUNIT_EXPECT_EQ(test, real_func_async(i), real);
+
+	/* allow to activate replacement with different arguments */
+	kunit_activate_global_stub(test, stubs.second_stub, super_replacement_func);
+	KUNIT_EXPECT_EQ(test, real_func(i), super);
+	KUNIT_EXPECT_EQ(test, real_func_async(i), super);
+
+	/* allow to deactivate twice */
+	kunit_deactivate_global_stub(test, stubs.second_stub);
+	kunit_deactivate_global_stub(test, stubs.second_stub);
+	KUNIT_EXPECT_EQ(test, real_func_async(i), real);
+	KUNIT_EXPECT_EQ(test, real_func(i), real);
+}
+
+static void flush_real_work(void *data)
+{
+	struct real_work *w = data;
+
+	flush_work(&w->work);
+}
+
+static void __kunit_global_stub_test_slow(struct kunit *test, bool replace)
+{
+	int real, replacement, other, i = replace ? 3 : 5;
+	struct real_work *w;
+
+	/* prerequisites */
+	KUNIT_ASSERT_EQ(test, real_func(i), real = real_func_async(i));
+	KUNIT_ASSERT_NE(test, real_func(i), replacement = slow_replacement_func(i));
+	KUNIT_ASSERT_NE(test, real_func(i), other = other_replacement_func(i));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, w = kunit_kzalloc(test, sizeof(*w), GFP_KERNEL));
+	INIT_WORK(&w->work, real_work_func);
+	KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, flush_real_work, w));
+	KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, expect_deactivated, test));
+
+	/* allow to activate replacement */
+	kunit_activate_global_stub(test, stubs.first_stub, slow_replacement_func);
+	KUNIT_EXPECT_EQ(test, real_func_async(i), replacement);
+
+	w->param = i;
+	w->result = 0;
+	queue_work(system_long_wq, &w->work);
+
+	/* wait until work starts */
+	while (work_pending(&w->work))
+		schedule_timeout_interruptible(HZ / 100);
+	KUNIT_EXPECT_NE(test, work_busy(&w->work), 0);
+
+	/* wait until work enters the stub */
+	while (atomic_read(&stubs.first_stub.base.busy) < 2)
+		schedule_timeout_interruptible(HZ / 100);
+
+	/* stub should be still busy(2) at this point */
+	KUNIT_EXPECT_EQ(test, 2, atomic_read(&stubs.first_stub.base.busy));
+	KUNIT_EXPECT_EQ(test, w->result, 0);
+
+	if (replace) {
+		/* try replace the stub, it should be just activated(1) */
+		kunit_activate_global_stub(test, stubs.first_stub, other_replacement_func);
+		KUNIT_EXPECT_EQ(test, 1, atomic_read(&stubs.first_stub.base.busy));
+	} else {
+		/* try to deactivate the stub, it should be disabled(0) */
+		kunit_deactivate_global_stub(test, stubs.first_stub);
+		KUNIT_EXPECT_EQ(test, 0, atomic_read(&stubs.first_stub.base.busy));
+	}
+
+	/* and results from the worker should be available */
+	KUNIT_EXPECT_EQ(test, w->result, replacement);
+	KUNIT_EXPECT_NE(test, w->result, real);
+	KUNIT_EXPECT_NE(test, w->result, other);
+
+	if (replace)
+		KUNIT_EXPECT_EQ(test, real_func_async(i), other);
+	else
+		KUNIT_EXPECT_EQ(test, real_func_async(i), real);
+}
+
+static void kunit_global_stub_test_slow_deactivate(struct kunit *test)
+{
+	__kunit_global_stub_test_slow(test, false);
+}
+
+static void kunit_global_stub_test_slow_replace(struct kunit *test)
+{
+	__kunit_global_stub_test_slow(test, true);
+}
+
+static int kunit_global_stub_test_init(struct kunit *test)
+{
+	stubs.counter = 0;
+	return 0;
+}
+
+static struct kunit_case kunit_global_stub_test_cases[] = {
+	KUNIT_CASE(kunit_global_stub_test_activate),
+	KUNIT_CASE(kunit_global_stub_test_deactivate),
+	KUNIT_CASE_SLOW(kunit_global_stub_test_slow_deactivate),
+	KUNIT_CASE_SLOW(kunit_global_stub_test_slow_replace),
+	{}
+};
+
+static struct kunit_suite kunit_global_stub_suite = {
+	.name = "kunit_global_stub",
+	.init = kunit_global_stub_test_init,
+	.test_cases = kunit_global_stub_test_cases,
+};
+
 kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
 		  &kunit_log_test_suite, &kunit_status_test_suite,
 		  &kunit_current_test_suite, &kunit_device_test_suite,
-		  &kunit_fault_test_suite);
+		  &kunit_fault_test_suite, &kunit_global_stub_suite);
 
 MODULE_DESCRIPTION("KUnit test for core test infrastructure");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0


