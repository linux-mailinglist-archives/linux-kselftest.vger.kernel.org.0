Return-Path: <linux-kselftest+bounces-16711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1AF964D86
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 20:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3EB71F20F0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 18:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C871B81C6;
	Thu, 29 Aug 2024 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lF7wmtgR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB271B5EC8
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955253; cv=none; b=un2swNFldWrqsSrvEzDYEnANtuLQxKeiFCj7GcZu4bcGGIDS39l28li6j4woxknyQjaZmNrJYjdWb1J0nAqjcAiadwgrjkl9tP773y0sKdW0uiFlZPP8V2bA/Pjf7X9XRVPDKZz8H8W0cczQSpD4rCjeLozEGwoGCtJvDW8a/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955253; c=relaxed/simple;
	bh=gu6yIHIg1ZLpGbyyL4EVKcRKYlbwSg0WzmfwB5AX4Jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TTDIts2z9j8IfbPumZI39/kSFyKJ6Erem0Y4EqQnEKSFktD3mxP7X/RsrsIQTeSdmqqecOPA+lHiYtQSdEXJifKKJVh0TvjvmfuzFIIpDDnpMm/JR0DtfQyyvDn9U5e6ShjmHAI2qk4+VC4J0Uyl5KHrjrw8GA7AZ9ShSUM2zUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lF7wmtgR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724955251; x=1756491251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gu6yIHIg1ZLpGbyyL4EVKcRKYlbwSg0WzmfwB5AX4Jo=;
  b=lF7wmtgRgJ0+SJNUCfTvbw6HUxiU+cf5w/yaMAef/DKjCG1qb/4qzXQP
   iPoxk8uMzoOLnZz/tG8mx5NPVAPxvvMR7E1BmkQDhqzzXCbIZPfDn9zDh
   n2jukFWss0EVWB32I1JTqpdmRY2zqRsArVafFEZ5AfIYfgORgYwGqLXJa
   8Zfh/Qg7Uk/tS+m1dsvIU78akWbDmtdqpmcvHUk4UJfhMWvAY03JY7aZy
   yJgBNN4bncD/zil8FlBLBuxu/uiix3CtFm+ouvjBCyCQs52NKZDzi9zzL
   gdblbbkiCdXCrSdifjQ4ZldZlUfiuUgeCYqIEfJ0FTP7X8A77Ga3MMev+
   A==;
X-CSE-ConnectionGUID: 1Rf6RXBEQWSYNQAcJXQr7A==
X-CSE-MsgGUID: pZsXEd8QTWiNe3zl7QwuqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34238450"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34238450"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:14:10 -0700
X-CSE-ConnectionGUID: pYn9Jd2ESUyFCeigI4fHpg==
X-CSE-MsgGUID: Oic0d2DsSKu5vXgCnLqZZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63353254"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.245.120.199])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:14:07 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Daniel Latypov <dlatypov@google.com>
Subject: [PATCH v3 5/6] kunit: Add example with alternate function redirection method
Date: Thu, 29 Aug 2024 20:13:47 +0200
Message-Id: <20240829181348.1572-6-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240829181348.1572-1-michal.wajdeczko@intel.com>
References: <20240829181348.1572-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add example how to use KUNIT_GLBAL_STUB_REDIRECT and compare its
usage with the KUNIT_STATIC_STUB_REDIRECT.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Rae Moar <rmoar@google.com> #v1
Reviewed-by: David Gow <davidgow@google.com> #v1
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
Cc: Daniel Latypov <dlatypov@google.com>
---
v2: add missing testcase description (Rae) and rebase
v3: fix s/fixed/global (Lucas)
    drop stale comment in commit message (Michal)
---
 lib/kunit/kunit-example-test.c | 67 ++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 3056d6bc705d..0a64f9c17b24 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -6,8 +6,10 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
+#include <linux/workqueue.h>
 #include <kunit/test.h>
 #include <kunit/static_stub.h>
+#include <kunit/visibility.h>
 
 /*
  * This is the most fundamental element of KUnit, the test case. A test case
@@ -221,6 +223,70 @@ static void example_static_stub_using_fn_ptr_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, add_one(1), 2);
 }
 
+/* This could be a location of various global stub functions. */
+static struct {
+	KUNIT_DECLARE_GLOBAL_STUB(add_two, int (*)(int i));
+} stubs;
+
+/* This is a function we'll replace with stubs. */
+static int add_two(int i)
+{
+	/* This will trigger the stub if active. */
+	KUNIT_STATIC_STUB_REDIRECT(add_two, i);
+	KUNIT_GLOBAL_STUB_REDIRECT(stubs.add_two, i);
+
+	return i + 2;
+}
+
+struct add_two_async_work {
+	struct work_struct work;
+	int param;
+	int result;
+};
+
+static void add_two_async_func(struct work_struct *work)
+{
+	struct add_two_async_work *w = container_of(work, typeof(*w), work);
+
+	w->result = add_two(w->param);
+}
+
+static int add_two_async(int i)
+{
+	struct add_two_async_work w = { .param = i };
+
+	INIT_WORK_ONSTACK(&w.work, add_two_async_func);
+	schedule_work(&w.work);
+	flush_work(&w.work);
+	destroy_work_on_stack(&w.work);
+
+	return w.result;
+}
+
+/*
+ * This test shows how to use KUNIT_GLOBAL_STUB_REDIRECT and compares its
+ * usage with the KUNIT_STATIC_STUB_REDIRECT.
+ */
+static void example_global_stub_test(struct kunit *test)
+{
+	/* static stub redirection works only for KUnit thread */
+	kunit_activate_static_stub(test, add_two, subtract_one);
+	KUNIT_EXPECT_EQ(test, add_two(1), subtract_one(1));
+	KUNIT_EXPECT_NE_MSG(test, add_two_async(1), subtract_one(1),
+			    "stub shouldn't be active outside KUnit thread!");
+
+	kunit_deactivate_static_stub(test, add_two);
+	KUNIT_EXPECT_EQ(test, add_two(1), add_two(1));
+
+	/* global stub redirection works for KUnit and other threads */
+	kunit_activate_global_stub(test, stubs.add_two, subtract_one);
+	KUNIT_EXPECT_EQ(test, add_two(1), subtract_one(1));
+	KUNIT_EXPECT_EQ(test, add_two_async(1), subtract_one(1));
+
+	kunit_deactivate_global_stub(test, stubs.add_two);
+	KUNIT_EXPECT_EQ(test, add_two(1), add_two(1));
+}
+
 static const struct example_param {
 	int value;
 } example_params_array[] = {
@@ -294,6 +360,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_all_expect_macros_test),
 	KUNIT_CASE(example_static_stub_test),
 	KUNIT_CASE(example_static_stub_using_fn_ptr_test),
+	KUNIT_CASE(example_global_stub_test),
 	KUNIT_CASE(example_priv_test),
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
 	KUNIT_CASE_SLOW(example_slow_test),
-- 
2.43.0


