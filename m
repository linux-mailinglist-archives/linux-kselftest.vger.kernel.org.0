Return-Path: <linux-kselftest+bounces-15860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B1E95A037
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 16:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10EF41C226C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2FF1B2502;
	Wed, 21 Aug 2024 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnIOP87p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB5D19993B
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251409; cv=none; b=a6hQ6wz1UyMBAWGyTa8S96DqXOJsgKummVIZLvD+7cbFaIR5bl0LOLqQfJo4PY117yQz/9iFfuNowPygebc623hQPCunCuvzp63sOHZ/r46ClAJOzvp1PRy3J6gHPrqmZ8bGPsdeBsyPW3XRfMJfn6wZzzYFnWDeHUetOibp5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251409; c=relaxed/simple;
	bh=3SZx5oLD0aJ4PvapkZ0DRAstmTMAUxI9TaLjFWCmy2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pbMLr2zykcGhW0lOsfshBN4VM2+f7qe8hg5NtCNi5n7hhrJR5hzd8w2mKGx4Ws+g6rJyvAaKZNDv/wqYEptR1h2UfS8zC3/3MshRivhRaIzKvjQBPZJJPPA9VbYjIPT9b9R3WFV3Sxlh54VX44piqlBxcYgFjiix3IEeXl/u9gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnIOP87p; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724251408; x=1755787408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3SZx5oLD0aJ4PvapkZ0DRAstmTMAUxI9TaLjFWCmy2w=;
  b=CnIOP87pm62v0ad5QNP9jTlW+QdmQHo8TzHj4ph3TFXRTu4M22AAFQzo
   v3B/gD28oIhvndBgUk9pMOxDFF416kSGmObjfjhHadfER3b+PG32QmcJ8
   NsnbLSqYBDHJyizujxT/Zslt20QyRLBZUl2yeA2YsF1WEeeoTBkUlV8UH
   cx1VmLK06W22g/3ZHTXrffP/kg1Crk5gKszF4uiba7QVWkFR6aiGwNOgH
   PHo2BSalqKIQ906soLSC08Xtt5ViLQS9eM2UZNAcN3I56b1YQGvxdF2ct
   EDUXljAZ3p0eG3mL0aNXDy1sGs/ciOeOCKbnlJfyuQj8Ej808oLX5j+2+
   Q==;
X-CSE-ConnectionGUID: /ym2HqV0TzqxJIaDUbV1CA==
X-CSE-MsgGUID: EuFk4/OnQo6bFTJL15FMSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22750554"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22750554"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 07:43:27 -0700
X-CSE-ConnectionGUID: U7uf/UzeRmiV/mASgTS2jQ==
X-CSE-MsgGUID: 5mnxGtHHRQqudF/94NwybQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65316532"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.19.248])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 07:43:25 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	David Gow <davidgow@google.com>,
	Daniel Latypov <dlatypov@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 3/4] kunit: Allow function redirection outside of the KUnit thread
Date: Wed, 21 Aug 2024 16:43:04 +0200
Message-Id: <20240821144305.1958-4-michal.wajdeczko@intel.com>
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

Currently, the 'static stub' API only allows function redirection
for calls made from the kthread of the current test, which prevents
the use of this functionalty when the tested code is also used by
other threads, outside of the KUnit test, like from the workqueue.

Add another set of macros to allow redirection to the replacement
functions, which, unlike the KUNIT_STATIC_STUB_REDIRECT, will
affect all calls done during the test execution.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: David Gow <davidgow@google.com>
Cc: Daniel Latypov <dlatypov@google.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
---
 include/kunit/static_stub.h | 80 +++++++++++++++++++++++++++++++++++++
 lib/kunit/static_stub.c     | 21 ++++++++++
 2 files changed, 101 insertions(+)

diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
index bf940322dfc0..3dd98c8f3f1f 100644
--- a/include/kunit/static_stub.h
+++ b/include/kunit/static_stub.h
@@ -12,6 +12,7 @@
 
 /* If CONFIG_KUNIT is not enabled, these stubs quietly disappear. */
 #define KUNIT_STATIC_STUB_REDIRECT(real_fn_name, args...) do {} while (0)
+#define KUNIT_FIXED_STUB_REDIRECT(stub, args...) do {} while (0)
 
 #else
 
@@ -109,5 +110,84 @@ void __kunit_activate_static_stub(struct kunit *test,
  */
 void kunit_deactivate_static_stub(struct kunit *test, void *real_fn_addr);
 
+/**
+ * KUNIT_FIXED_STUB_REDIRECT() - Call a fixed function stub if activated.
+ * @stub: The location of the function stub pointer
+ * @args: All of the arguments passed to this stub
+ *
+ * This is a function prologue which is used to allow calls to the current
+ * function to be redirected if a KUnit is running. If the stub is NULL or
+ * the KUnit is not running the function will continue execution as normal.
+ *
+ * The function stub pointer must be stored in a place that is accessible both
+ * from the test code that will activate this stub and from the function where
+ * we will do the redirection.
+ *
+ * Unlike the KUNIT_STATIC_STUB_REDIRECT(), this redirection will work
+ * even if the caller is not in a KUnit context (like a worker thread).
+ *
+ * Example:
+ *
+ * .. code-block:: c
+ *
+ *	static int (*func_stub)(int n);
+ *
+ *	int real_func(int n)
+ *	{
+ *		KUNIT_FIXED_STUB_REDIRECT(func_stub, n);
+ *		return n + 1;
+ *	}
+ *
+ *	int replacement_func(int n)
+ *	{
+ *		return n + 100;
+ *	}
+ *
+ *	void example_test(struct kunit *test)
+ *	{
+ *		KUNIT_EXPECT_EQ(test, real_func(1), 2);
+ *		func_stub = replacement_func;
+ *		KUNIT_EXPECT_EQ(test, real_func(1), 101);
+ *	}
+ */
+#define KUNIT_FIXED_STUB_REDIRECT(stub, args...) do {					\
+	typeof(stub) replacement = (stub);						\
+	if (kunit_is_running()) {							\
+		if (unlikely(replacement)) {						\
+			pr_info(KUNIT_SUBTEST_INDENT "# %s: calling stub %ps\n",	\
+				__func__, replacement);					\
+			return replacement(args);					\
+		}									\
+	}										\
+} while (0)
+
+void __kunit_activate_fixed_stub(struct kunit *test, void *stub_ptr, void *replacement_func);
+
+/**
+ * kunit_activate_fixed_stub() - Setup a fixed function stub.
+ * @test: Test case that wants to activate a fixed function stub
+ * @stub: The location of the function stub pointer
+ * @replacement: The replacement function
+ *
+ * This helper setups a function stub with the replacement function.
+ * It will also automatically restore stub to NULL at the test end.
+ */
+#define kunit_activate_fixed_stub(test, stub, replacement) do {				\
+	typecheck_pointer(stub);							\
+	typecheck_fn(typeof(stub), replacement);					\
+	typeof(stub) *stub_ptr = &(stub);						\
+	__kunit_activate_fixed_stub((test), stub_ptr, (replacement));			\
+} while (0)
+
+/**
+ * kunit_deactivate_fixed_stub() - Disable a fixed function stub.
+ * @test: Test case that wants to deactivate a fixed function stub (unused for now)
+ * @stub: The location of the function stub pointer
+ */
+#define kunit_deactivate_fixed_stub(test, stub) do {					\
+	typecheck(struct kunit *, (test));						\
+	(stub) = NULL;									\
+} while (0)
+
 #endif
 #endif
diff --git a/lib/kunit/static_stub.c b/lib/kunit/static_stub.c
index 92b2cccd5e76..1b50cf457e89 100644
--- a/lib/kunit/static_stub.c
+++ b/lib/kunit/static_stub.c
@@ -121,3 +121,24 @@ void __kunit_activate_static_stub(struct kunit *test,
 	}
 }
 EXPORT_SYMBOL_GPL(__kunit_activate_static_stub);
+
+static void nullify_stub_ptr(void *data)
+{
+	void **ptr = data;
+
+	*ptr = NULL;
+}
+
+/*
+ * Helper function for kunit_activate_static_stub(). The macro does
+ * typechecking, so use it instead.
+ */
+void __kunit_activate_fixed_stub(struct kunit *test, void *stub_ptr, void *replacement_func)
+{
+	void **stub = stub_ptr;
+
+	KUNIT_ASSERT_NOT_NULL(test, stub_ptr);
+	*stub = replacement_func;
+	KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, nullify_stub_ptr, stub_ptr));
+}
+EXPORT_SYMBOL_GPL(__kunit_activate_fixed_stub);
-- 
2.43.0


