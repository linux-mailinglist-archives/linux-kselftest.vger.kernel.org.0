Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D4172A721
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 02:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjFJAwP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 20:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFJAwM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 20:52:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA066E1
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 17:52:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-568ab5c813eso33366167b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 17:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686358329; x=1688950329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ylzIdUa/HdrZ45yd+RRq5LnH+hOmWvIma/I97GpGtAs=;
        b=Zmr+EkhSeSNvCLPC3fmn2tX9mMT6rgh3uQ/IJsxW1MCezHgJiQdRtFwdXdki72dVD5
         CXjnrDMiJEXw566GTSbcLVdlvJmN0o4vXeFJm94iDce0N11wsaJRsjgjDQ9jt1oMOM1N
         Atyk9QAqumY9ETSWsPdP0GGEPInAebRX8DFrjCTVHtfp2K3le9vulryAW+tjZwfiCl2l
         tCSrakVDNP/LGpZxVVoNL7MIRcU4bnQOvwNkusbHS6wLTOcSJBgYigUfekT9aXn8yQes
         Mx9d+Mna3RA/iTXw9GtQS+7tQvd63vIkJTP0UvjgIkbvBSfi0a1jgfk3zyaxGX0koNbO
         QEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686358329; x=1688950329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylzIdUa/HdrZ45yd+RRq5LnH+hOmWvIma/I97GpGtAs=;
        b=Ti3EdEbckV0AovNBl0IIlGc3eAJpGid8WtoMFVn9T+Cf/1A9r9D32e8h66xAnsHxBJ
         wiv0o/uzDycn2KdsHem7oiHNaKHi8w93ph0i1IFE8s0yOikBDkmDWbXE+XBdBwYqUb4d
         QSRYCIOOh9KS0cOSOhOLpgTZ0tmCRz51zAffLj5/ZbNWuv+VGW08Y3rInycbJatrxEzR
         Lg2BxLT3Yy/HCYdIpsxc0XQF3rHkj3tldXJj34/xHF5RDvOv4rywnG5PGLMRwLv2jpmv
         Ya4Ec1+PL/7gVjJpY3WG26j3kxnj3s4/gACaWFJpjViinb9ll2jfB72uYQpfhgkN5TOA
         ZlMw==
X-Gm-Message-State: AC+VfDx4VJQQtnZEEyXki7+/lOQdkpBcoXFzr9pIm/Hno4WRrFAKOvAH
        /KhNZBHRNx+Iq/xGSqMM87jhP9xlmw==
X-Google-Smtp-Source: ACHHUZ6aVbU/xiu8xxQnCIprN1NVtQfosUsTiEtzBVSYhi87pylg/c24Jte89T8fkhjvtHjKHtPnmUIxIw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:8d0d:0:b0:569:8603:577 with SMTP id
 d13-20020a818d0d000000b0056986030577mr1681187ywg.4.1686358328849; Fri, 09 Jun
 2023 17:52:08 -0700 (PDT)
Date:   Sat, 10 Jun 2023 00:51:44 +0000
In-Reply-To: <20230610005149.1145665-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230610005149.1145665-2-rmoar@google.com>
Subject: [RFC v1 1/6] kunit: Add test attributes API structure
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the basic structure of the test attribute API to KUnit, which can be
used to save and access test associated data.

Add attributes.c and attributes.h to hold associated structs and functions
for the API.

Create a struct that holds a variety of associated helper functions for
each test attribute. These helper functions will be used to get the
attribute value, convert the value to a string, and filter based on the
value. This struct is flexible by design to allow for attributes of
numerous types and contexts.

Add a method to print test attributes in the format of "# [<test_name if
not suite>.]<attribute_name>: <attribute_value>".

Example for a suite: "# speed: slow"

Example for a test case: "# test_case.speed: very_slow"

Use this method to report attributes in the KTAP output and _list_tests
output.

In test.h, add fields and associated helper functions to test cases and
suites to hold user-inputted test attributes.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 include/kunit/attributes.h | 19 +++++++++++
 include/kunit/test.h       | 33 +++++++++++++++++++
 lib/kunit/Makefile         |  3 +-
 lib/kunit/attributes.c     | 65 ++++++++++++++++++++++++++++++++++++++
 lib/kunit/executor.c       | 10 +++++-
 lib/kunit/test.c           | 17 ++++++----
 6 files changed, 138 insertions(+), 9 deletions(-)
 create mode 100644 include/kunit/attributes.h
 create mode 100644 lib/kunit/attributes.c

diff --git a/include/kunit/attributes.h b/include/kunit/attributes.h
new file mode 100644
index 000000000000..9fcd184cce36
--- /dev/null
+++ b/include/kunit/attributes.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit API to save and access test attributes
+ *
+ * Copyright (C) 2023, Google LLC.
+ * Author: Rae Moar <rmoar@google.com>
+ */
+
+#ifndef _KUNIT_ATTRIBUTES_H
+#define _KUNIT_ATTRIBUTES_H
+
+/*
+ * Print all test attributes for a test case or suite.
+ * Output format for test cases: "# <test_name>.<attribute>: <value>"
+ * Output format for test suites: "# <attribute>: <value>"
+ */
+void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level);
+
+#endif /* _KUNIT_ATTRIBUTES_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 23120d50499e..1fc9155988e9 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -63,12 +63,16 @@ enum kunit_status {
 	KUNIT_SKIPPED,
 };
 
+/* Holds attributes for each test case and suite */
+struct kunit_attributes {};
+
 /**
  * struct kunit_case - represents an individual test case.
  *
  * @run_case: the function representing the actual test case.
  * @name:     the name of the test case.
  * @generate_params: the generator function for parameterized tests.
+ * @attr:     the attributes associated with the test
  *
  * A test case is a function with the signature,
  * ``void (*)(struct kunit *)``
@@ -104,6 +108,7 @@ struct kunit_case {
 	void (*run_case)(struct kunit *test);
 	const char *name;
 	const void* (*generate_params)(const void *prev, char *desc);
+	struct kunit_attributes attr;
 
 	/* private: internal use only. */
 	enum kunit_status status;
@@ -133,6 +138,18 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  */
 #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
 
+/**
+ * KUNIT_CASE_ATTR - A helper for creating a &struct kunit_case
+ * with attributes
+ *
+ * @test_name: a reference to a test case function.
+ * @attributes: a reference to a struct kunit_attributes object containing
+ * test attributes
+ */
+#define KUNIT_CASE_ATTR(test_name, attributes)			\
+		{ .run_case = test_name, .name = #test_name,	\
+		  .attr = attributes }
+
 /**
  * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
  *
@@ -154,6 +171,20 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
 		{ .run_case = test_name, .name = #test_name,	\
 		  .generate_params = gen_params }
 
+/**
+ * KUNIT_CASE_PARAM_ATTR - A helper for creating a parameterized &struct
+ * kunit_case with attributes
+ *
+ * @test_name: a reference to a test case function.
+ * @gen_params: a reference to a parameter generator function.
+ * @attributes: a reference to a struct kunit_attributes object containing
+ * test attributes
+ */
+#define KUNIT_CASE_PARAM_ATTR(test_name, gen_params, attributes)	\
+		{ .run_case = test_name, .name = #test_name,	\
+		  .generate_params = gen_params,				\
+		  .attr = attributes }
+
 /**
  * struct kunit_suite - describes a related collection of &struct kunit_case
  *
@@ -163,6 +194,7 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
  * @init:	called before every test case.
  * @exit:	called after every test case.
  * @test_cases:	a null terminated array of test cases.
+ * @attr:	the attributes associated with the test suite
  *
  * A kunit_suite is a collection of related &struct kunit_case s, such that
  * @init is called before every test case and @exit is called after every
@@ -182,6 +214,7 @@ struct kunit_suite {
 	int (*init)(struct kunit *test);
 	void (*exit)(struct kunit *test);
 	struct kunit_case *test_cases;
+	struct kunit_attributes attr;
 
 	/* private: internal use only */
 	char status_comment[KUNIT_STATUS_COMMENT_SIZE];
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index cb417f504996..46f75f23dfe4 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -6,7 +6,8 @@ kunit-objs +=				test.o \
 					string-stream.o \
 					assert.o \
 					try-catch.o \
-					executor.o
+					executor.o \
+					attributes.o
 
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
new file mode 100644
index 000000000000..0ea641be795f
--- /dev/null
+++ b/lib/kunit/attributes.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit API to save and access test attributes
+ *
+ * Copyright (C) 2023, Google LLC.
+ * Author: Rae Moar <rmoar@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/attributes.h>
+
+/**
+ * struct kunit_attr - represents a test attribute and holds flexible
+ * helper functions to interact with attribute.
+ *
+ * @name: name of test attribute, eg. speed
+ * @get_attr: function to return attribute value given a test
+ * @to_string: function to return string representation of given
+ * attribute value
+ * @filter: function to indicate whether a given attribute value passes a
+ * filter
+ */
+struct kunit_attr {
+	const char *name;
+	void *(*get_attr)(void *test_or_suite, bool is_test);
+	const char *(*to_string)(void *attr, bool *to_free);
+	int (*filter)(void *attr, const char *input, int *err);
+	void *attr_default;
+};
+
+/* List of all Test Attributes */
+
+static struct kunit_attr kunit_attr_list[1] = {};
+
+/* Helper Functions to Access Attributes */
+
+void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level)
+{
+	int i;
+	bool to_free;
+	void *attr;
+	const char *attr_name, *attr_str;
+	struct kunit_suite *suite = is_test ? NULL : test_or_suite;
+	struct kunit_case *test = is_test ? test_or_suite : NULL;
+
+	for (i = 0; i < ARRAY_SIZE(kunit_attr_list); i++) {
+		attr = kunit_attr_list[i].get_attr(test_or_suite, is_test);
+		if (attr) {
+			attr_name = kunit_attr_list[i].name;
+			attr_str = kunit_attr_list[i].to_string(attr, &to_free);
+			if (test) {
+				kunit_log(KERN_INFO, test, "%*s# %s.%s: %s",
+					KUNIT_INDENT_LEN * test_level, "", test->name,
+					attr_name, attr_str);
+			} else {
+				kunit_log(KERN_INFO, suite, "%*s# %s: %s",
+					KUNIT_INDENT_LEN * test_level, "", attr_name, attr_str);
+			}
+
+			/* Free to_string of attribute if needed */
+			if (to_free)
+				kfree(attr_str);
+		}
+	}
+}
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 74982b83707c..767a84e32f06 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -2,6 +2,7 @@
 
 #include <linux/reboot.h>
 #include <kunit/test.h>
+#include <kunit/attributes.h>
 #include <linux/glob.h>
 #include <linux/moduleparam.h>
 
@@ -180,10 +181,17 @@ static void kunit_exec_list_tests(struct suite_set *suite_set)
 	/* Hack: print a ktap header so kunit.py can find the start of KUnit output. */
 	pr_info("KTAP version 1\n");
 
-	for (suites = suite_set->start; suites < suite_set->end; suites++)
+	for (suites = suite_set->start; suites < suite_set->end; suites++) {
+		/* Print suite name and suite attributes */
+		pr_info("%s\n", (*suites)->name);
+		kunit_print_attr((void *)(*suites), false, 0);
+
+		/* Print test case name and attributes in suite */
 		kunit_suite_for_each_test_case((*suites), test_case) {
 			pr_info("%s.%s\n", (*suites)->name, test_case->name);
+			kunit_print_attr((void *)test_case, true, 0);
 		}
+	}
 }
 
 int kunit_run_all_tests(void)
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 84e4666555c9..9ee55139ecd1 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -9,6 +9,7 @@
 #include <kunit/resource.h>
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
+#include <kunit/attributes.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -168,6 +169,13 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
 }
 EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
 
+/* Currently supported test levels */
+enum {
+	KUNIT_LEVEL_SUITE = 0,
+	KUNIT_LEVEL_CASE,
+	KUNIT_LEVEL_CASE_PARAM,
+};
+
 static void kunit_print_suite_start(struct kunit_suite *suite)
 {
 	/*
@@ -181,17 +189,11 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
 	pr_info(KUNIT_SUBTEST_INDENT "KTAP version 1\n");
 	pr_info(KUNIT_SUBTEST_INDENT "# Subtest: %s\n",
 		  suite->name);
+	kunit_print_attr((void *)suite, false, KUNIT_LEVEL_CASE);
 	pr_info(KUNIT_SUBTEST_INDENT "1..%zd\n",
 		  kunit_suite_num_test_cases(suite));
 }
 
-/* Currently supported test levels */
-enum {
-	KUNIT_LEVEL_SUITE = 0,
-	KUNIT_LEVEL_CASE,
-	KUNIT_LEVEL_CASE_PARAM,
-};
-
 static void kunit_print_ok_not_ok(struct kunit *test,
 				  unsigned int test_level,
 				  enum kunit_status status,
@@ -651,6 +653,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 			}
 		}
 
+		kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CASE);
 
 		kunit_print_test_stats(&test, param_stats);
 
-- 
2.41.0.162.gfafddb0af9-goog

