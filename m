Return-Path: <linux-kselftest+bounces-16346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B031495FCA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 00:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28FA1C2281C
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 22:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2303F19D082;
	Mon, 26 Aug 2024 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdenyUOS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED4913A899
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710845; cv=none; b=shmb/qfqy+UwqWG5HcJlsxK1dkWXiLDX3FeCvxanO8jfT0ZEmu3nuH/0J+O+CnZMAYVA5iX9tEWel1go158+J8EnjwqaaKLLjSNPAzjE3cOTRQS0huNHFRIRRe/SJVoptVa4Jl1JE7mE7niPXe25FTlienYiysLNSKEAYvPLzuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710845; c=relaxed/simple;
	bh=WYmBj/QZma2j2gocEAvAsVAeyeb4B+d4i/LCUcUluzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSPMx41RehB3HsFpkapWOXiz2kuKJUvj8Y127wcL/ozyiYPsR2sF06YggnfYmbn94xrM+8CDYDuZ3oIKEYS/qXiiUQmVhUNUjUuhYAgfJls8h6EtX6ZjvUuNBXFBQ4jUke2ZmQtdjIbMEtjyxHi0nRtdcdDyy0YVMeHeNFe4IRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdenyUOS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724710844; x=1756246844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WYmBj/QZma2j2gocEAvAsVAeyeb4B+d4i/LCUcUluzw=;
  b=CdenyUOS6xhfEPW/7V3KMZEnJV7MI1wUYhlxMDAOW+wMBnVh67cZprzt
   Hyix4o8OHIHGSEXS6cRuBCallbczcnFNxUCjb+Ebu/PKG76+SoeZVBIfi
   MTDCMAS+vMXMJfu4pO4g/7HwzKeE6AvgP+xlpCXt/SLSzCxAVVO0B9OAw
   olz/W+gwwnCq8n/8BgeHT62CtbbDEi8UQhJ0RG6AvmhjEuOsxmkDawKzH
   KSRl0uWSyYoLPO0SYsVJ9K18PGAvueh4tcRYxsSQ8K4LJ2ovVOWK0Veq9
   jYQx5VR9jaKpLCAD+TMFKwsk3LQjCZJcidBw8wC+f8I0145T7goaWR1YG
   A==;
X-CSE-ConnectionGUID: Uvw6tMlPS4y7puUoKKbMhg==
X-CSE-MsgGUID: 3qnNtFN6TKCbpBdnThHRJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34537410"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="34537410"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:20:43 -0700
X-CSE-ConnectionGUID: Bw3sv9MESLmGsdD0yJAZnw==
X-CSE-MsgGUID: D9NLSc3qSWCaNRrvXId5MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66992257"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.1.253])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:20:41 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>,
	Daniel Latypov <dlatypov@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v2 5/6] kunit: Add example with alternate function redirection method
Date: Tue, 27 Aug 2024 00:20:14 +0200
Message-Id: <20240826222015.1484-6-michal.wajdeczko@intel.com>
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

Add example how to use KUNIT_FIXED_STUB_REDIRECT and compare its
usage with the KUNIT_STATIC_STUB_REDIRECT. Also show how the
DECLARE_IF_KUNIT macro could be helpful in declaring test data in
the non-test data structures.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Rae Moar <rmoar@google.com> #v1
Reviewed-by: David Gow <davidgow@google.com> #v1
---
Cc: Daniel Latypov <dlatypov@google.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
---
v2: add missing testcase description (Rae) and rebase
---
 lib/kunit/kunit-example-test.c | 67 ++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 3056d6bc705d..146935a16883 100644
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
+	/* fixed stub redirection works for KUnit and other threads */
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


