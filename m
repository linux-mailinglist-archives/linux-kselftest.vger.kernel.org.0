Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7940E2A9C0F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 19:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgKFS2b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 13:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgKFS2b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 13:28:31 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55862C0613CF;
        Fri,  6 Nov 2020 10:28:31 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t14so1599721pgg.1;
        Fri, 06 Nov 2020 10:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y0xdAAjZhCp5YBC30Sadccu5lL30+thrR4UIgGvtXzw=;
        b=bf1DvkLSTv/nCbBKzvozxn7OAGwQWfROMqCWQhMzy0VvSZOuy0fETvvrkI+fXDNiLX
         2LogSlnbDI20NS267zPaYiyZhlcclVAC1R1+75nsG8yxz1oabSpHwtBNV1i4u+ZixErR
         7agv4jM13gVLdADFyjruZXRfWkzfSbSLUYD6W/wBIYd2KRyUxt1ZqaVPqVcKL5iXa8cd
         iYyBn7hXvRD1QqGrWmdMWcgchGFUAVowYfOin5HTgbBqHrCJ09yx09T080NlHOohYvCm
         gaS5/JFxry/LmkC9QlbY8jqjz0NGgn9X2IzjDRg3fD0qmm9mo9Y9Dhy40FDn+6fMnb2P
         3mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y0xdAAjZhCp5YBC30Sadccu5lL30+thrR4UIgGvtXzw=;
        b=DFo2MQ+8EUYuZt64L8spNGzuszHNaRs2+WubmDrW5qD4De8GOzOkzeAnicexW4ub3v
         oSprxDa1w473pZtFZh4M4GSl4TTQLVGKDzMzCYXjpSXZoMQEfYZjCH4rzNvG5+LdMUvq
         cKnrFbYRbG97CnCjRAAjc6zilxEHEVs/xrp7qOndDrf60ONhTiqQj+5gXlvzt/JEzuGl
         xKTVhSEyplMxxH3VjAUb2MtoFOuoXQm2xhRoZGOnJnbdlDm3ncUqihI0tSMA2DUA0+tm
         OTgXeCGb7bOGN6F6ow8cxtEUO3wLrk3CkuPEbYLviISA92GTT+q1VsN9SBa+yuO5t49p
         9y7w==
X-Gm-Message-State: AOAM531SjdQtNGcUIdGEx/ssJZXo+uTPjuZVYRT0p0GOWRX8vUFaS4+5
        NApICxGXkf9VqsyyyDcYYnQ=
X-Google-Smtp-Source: ABdhPJw9cNHWfzCXKiwHO+wDn9pBuAH15Gs2Rh69HF2+rToOj+3FWJWnsE4QiMADH+bjNOFQTtZTYg==
X-Received: by 2002:a05:6a00:88d:b029:164:5a00:29b8 with SMTP id q13-20020a056a00088db02901645a0029b8mr3185444pfj.10.1604687310723;
        Fri, 06 Nov 2020 10:28:30 -0800 (PST)
Received: from arpitha-Inspiron-7570.lan ([106.51.243.217])
        by smtp.gmail.com with ESMTPSA id e6sm2961334pfn.190.2020.11.06.10.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:28:29 -0800 (PST)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        elver@google.com, yzaikin@google.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH v5 1/2] kunit: Support for Parameterized Testing
Date:   Fri,  6 Nov 2020 23:56:57 +0530
Message-Id: <20201106182657.30492-1-98.arpi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Implementation of support for parameterized testing in KUnit.
This approach requires the creation of a test case using the
KUNIT_CASE_PARAM macro that accepts a generator function as input.
This generator function should return the next parameter given the
previous parameter in parameterized tests. It also provides
a macro to generate common-case generators.

Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
Co-developed-by: Marco Elver <elver@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
Changes v4->v5:
- Update kernel-doc comments.
- Use const void* for generator return and prev value types.
- Add kernel-doc comment for KUNIT_ARRAY_PARAM.
- Rework parameterized test case execution strategy: each parameter is executed
  as if it was its own test case, with its own test initialization and cleanup
  (init and exit are called, etc.). However, we cannot add new test cases per TAP
  protocol once we have already started execution. Instead, log the result of
  each parameter run as a diagnostic comment.
Changes v3->v4:
- Rename kunit variables
- Rename generator function helper macro
- Add documentation for generator approach
- Display test case name in case of failure along with param index
Changes v2->v3:
- Modifictaion of generator macro and method
Changes v1->v2:
- Use of a generator method to access test case parameters

 include/kunit/test.h | 36 ++++++++++++++++++++++++++++++++++
 lib/kunit/test.c     | 46 +++++++++++++++++++++++++++++++-------------
 2 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9197da792336..ae5488a37e48 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -107,6 +107,7 @@ struct kunit;
  *
  * @run_case: the function representing the actual test case.
  * @name:     the name of the test case.
+ * @generate_params: the generator function for parameterized tests.
  *
  * A test case is a function with the signature,
  * ``void (*)(struct kunit *)``
@@ -141,6 +142,7 @@ struct kunit;
 struct kunit_case {
 	void (*run_case)(struct kunit *test);
 	const char *name;
+	const void* (*generate_params)(const void *prev);
 
 	/* private: internal use only. */
 	bool success;
@@ -163,6 +165,22 @@ static inline char *kunit_status_to_string(bool status)
  */
 #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
 
+/**
+ * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
+ *
+ * @test_name: a reference to a test case function.
+ * @gen_params: a reference to a parameter generator function.
+ *
+ * The generator function ``const void* gen_params(const void *prev)`` is used
+ * to lazily generate a series of arbitrarily typed values that fit into a
+ * void*. The argument @prev is the previously returned value, which should be
+ * used to derive the next value; @prev is set to NULL on the initial generator
+ * call.  When no more values are available, the generator must return NULL.
+ */
+#define KUNIT_CASE_PARAM(test_name, gen_params)			\
+		{ .run_case = test_name, .name = #test_name,	\
+		  .generate_params = gen_params }
+
 /**
  * struct kunit_suite - describes a related collection of &struct kunit_case
  *
@@ -208,6 +226,10 @@ struct kunit {
 	const char *name; /* Read only after initialization! */
 	char *log; /* Points at case log after initialization */
 	struct kunit_try_catch try_catch;
+	/* param_value is the current parameter value for a test case. */
+	const void *param_value;
+	/* param_index stores the index of the parameter in parameterized tests. */
+	int param_index;
 	/*
 	 * success starts as true, and may only be set to false during a
 	 * test case; thus, it is safe to update this across multiple
@@ -1742,4 +1764,18 @@ do {									       \
 						fmt,			       \
 						##__VA_ARGS__)
 
+/**
+ * KUNIT_ARRAY_PARAM() - Define test parameter generator from an array.
+ * @name:  prefix for the test parameter generator function.
+ * @array: array of test parameters.
+ *
+ * Define function @name_gen_params which uses @array to generate parameters.
+ */
+#define KUNIT_ARRAY_PARAM(name, array)								\
+	static const void *name##_gen_params(const void *prev)					\
+	{											\
+		typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
+		return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;			\
+	}
+
 #endif /* _KUNIT_TEST_H */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 750704abe89a..b8b63aeda504 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -325,29 +325,25 @@ static void kunit_catch_run_case(void *data)
  * occur in a test case and reports them as failures.
  */
 static void kunit_run_case_catch_errors(struct kunit_suite *suite,
-					struct kunit_case *test_case)
+					struct kunit_case *test_case,
+					struct kunit *test)
 {
 	struct kunit_try_catch_context context;
 	struct kunit_try_catch *try_catch;
-	struct kunit test;
 
-	kunit_init_test(&test, test_case->name, test_case->log);
-	try_catch = &test.try_catch;
+	kunit_init_test(test, test_case->name, test_case->log);
+	try_catch = &test->try_catch;
 
 	kunit_try_catch_init(try_catch,
-			     &test,
+			     test,
 			     kunit_try_run_case,
 			     kunit_catch_run_case);
-	context.test = &test;
+	context.test = test;
 	context.suite = suite;
 	context.test_case = test_case;
 	kunit_try_catch_run(try_catch, &context);
 
-	test_case->success = test.success;
-
-	kunit_print_ok_not_ok(&test, true, test_case->success,
-			      kunit_test_case_num(suite, test_case),
-			      test_case->name);
+	test_case->success = test->success;
 }
 
 int kunit_run_tests(struct kunit_suite *suite)
@@ -356,8 +352,32 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 	kunit_print_subtest_start(suite);
 
-	kunit_suite_for_each_test_case(suite, test_case)
-		kunit_run_case_catch_errors(suite, test_case);
+	kunit_suite_for_each_test_case(suite, test_case) {
+		struct kunit test = { .param_value = NULL, .param_index = 0 };
+		bool test_success = true;
+
+		if (test_case->generate_params)
+			test.param_value = test_case->generate_params(NULL);
+
+		do {
+			kunit_run_case_catch_errors(suite, test_case, &test);
+			test_success &= test_case->success;
+
+			if (test_case->generate_params) {
+				kunit_log(KERN_INFO, &test,
+					KUNIT_SUBTEST_INDENT
+					"# %s: param-%d %s",
+					test_case->name, test.param_index,
+					kunit_status_to_string(test.success));
+				test.param_value = test_case->generate_params(test.param_value);
+				test.param_index++;
+			}
+		} while (test.param_value);
+
+		kunit_print_ok_not_ok(&test, true, test_success,
+				      kunit_test_case_num(suite, test_case),
+				      test_case->name);
+	}
 
 	kunit_print_subtest_end(suite);
 
-- 
2.25.1

