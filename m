Return-Path: <linux-kselftest+bounces-15861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E895495A038
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 16:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBEB284431
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE331B1D50;
	Wed, 21 Aug 2024 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ji/oo6lh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A90E1B250D
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251411; cv=none; b=QrwK5U6usshtL20WmLSw+l916jCE662hyo+HA3HMouk9HlCCMP6wjumlttrHHrB31sLP4aSq/at+EZ1mdL8Hhmxc+rN8TheuMwlhcy7tvgJtQAYLXsYe9jmVwXLA9iRRRbBUpVxHbZDfhbKnxuOmGd9mGq7M4ZA4KXZqPvagEEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251411; c=relaxed/simple;
	bh=BSD73sM2L6z9u+zRHPMws6dQC0WsD14nix7MPD6WDSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eGqntBOlkkqB4b3FIERtKGv2Ur4qnGPX6WdAqXWjboaFu/urT844fMlJAkQ2FsTwmDYutQOTfJaA8TUFarjiS5r1a/sIFTSZfvk2YJN/dBf+1yDqCPnww7NfRFNph/cZlZ7UAuOsgjPLAMHOyu6IvW8q+J/uHbV+whXX2IID8ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ji/oo6lh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724251410; x=1755787410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BSD73sM2L6z9u+zRHPMws6dQC0WsD14nix7MPD6WDSs=;
  b=Ji/oo6lhb3l86Ujev7gU5JE2r+NNgTacurOqrgKferulj+NV1HB4f9fY
   EH8JMgdP0ePwb6WtBUDaeXwqhKhbvXgjWvQe+BPLi6bb2/43GgrfRPbnK
   O862JwvRvHitYwy+ot1ODMXPdJ1KUrkTE/9H30MeUXgognLpKDZy0SGs5
   a+Lbk8xpKHif+7vbyAD1ZlpR79r0DE7uimgJdTMKjM2+IeuZlJ4WpNiWK
   dna8meVA1oFgaPxgRlolG37covmRghY39j0zdVIDwJ83wkazZQOBBIGGd
   eyQXtigtgGvCsZVAjvYXAUntqEAVniAYpkevS/J6bTHUqm74Xx7uXZyhR
   w==;
X-CSE-ConnectionGUID: /VjX3t2iRkSc/FbtqK0hsg==
X-CSE-MsgGUID: zDf/FF63Rk+LRtyPkuViYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22750560"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22750560"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 07:43:29 -0700
X-CSE-ConnectionGUID: xyJBUGMJSj6ukId+akVnDQ==
X-CSE-MsgGUID: qiRKFl01TE+fQcSz/bl/sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65316542"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.19.248])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 07:43:27 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	David Gow <davidgow@google.com>,
	Daniel Latypov <dlatypov@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 4/4] kunit: Add example with alternate function redirection method
Date: Wed, 21 Aug 2024 16:43:05 +0200
Message-Id: <20240821144305.1958-5-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240821144305.1958-1-michal.wajdeczko@intel.com>
References: <20240821144305.1958-1-michal.wajdeczko@intel.com>
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
---
Cc: David Gow <davidgow@google.com>
Cc: Daniel Latypov <dlatypov@google.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
---
 lib/kunit/kunit-example-test.c | 63 ++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 3056d6bc705d..120e08d8899b 100644
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
@@ -221,6 +223,66 @@ static void example_static_stub_using_fn_ptr_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, add_one(1), 2);
 }
 
+/* This could be a location of various fixed stub functions. */
+static struct {
+	DECLARE_IF_KUNIT(int (*add_two)(int i));
+} stubs;
+
+/* This is a function we'll replace with stubs. */
+static int add_two(int i)
+{
+	/* This will trigger the stub if active. */
+	KUNIT_STATIC_STUB_REDIRECT(add_two, i);
+	KUNIT_FIXED_STUB_REDIRECT(stubs.add_two, i);
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
+ */
+static void example_fixed_stub_test(struct kunit *test)
+{
+	/* static stub redirection works only for KUnit thread */
+	kunit_activate_static_stub(test, add_two, subtract_one);
+	KUNIT_EXPECT_EQ(test, add_two(1), subtract_one(1));
+	KUNIT_EXPECT_NE_MSG(test, add_two_async(1), subtract_one(1),
+			    "stub shouldn't be active outside KUnit thread!");
+	kunit_deactivate_static_stub(test, add_two);
+	KUNIT_EXPECT_EQ(test, add_two(1), add_two(1));
+
+	/* fixed stub redirection works for KUnit and other threads */
+	kunit_activate_fixed_stub(test, stubs.add_two, subtract_one);
+	KUNIT_EXPECT_EQ(test, add_two(1), subtract_one(1));
+	KUNIT_EXPECT_EQ(test, add_two_async(1), subtract_one(1));
+	kunit_deactivate_fixed_stub(test, stubs.add_two);
+	KUNIT_EXPECT_EQ(test, add_two(1), add_two(1));
+}
+
 static const struct example_param {
 	int value;
 } example_params_array[] = {
@@ -294,6 +356,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_all_expect_macros_test),
 	KUNIT_CASE(example_static_stub_test),
 	KUNIT_CASE(example_static_stub_using_fn_ptr_test),
+	KUNIT_CASE(example_fixed_stub_test),
 	KUNIT_CASE(example_priv_test),
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
 	KUNIT_CASE_SLOW(example_slow_test),
-- 
2.43.0


