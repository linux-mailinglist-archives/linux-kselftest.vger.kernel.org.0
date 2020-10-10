Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D730828A39B
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Oct 2020 01:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390289AbgJJW4w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Oct 2020 18:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731493AbgJJT3p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Oct 2020 15:29:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681A0C05BD23;
        Sat, 10 Oct 2020 07:54:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d1so1061953pfc.0;
        Sat, 10 Oct 2020 07:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/krkgGWRLPwrBOotoEiPAuKzZC5AWMQrtjDnDpAK2FI=;
        b=pDMCrxd/zMBAJCqjki45oqVCT+zX55BDa9Ycymnp0lMpeZBUVnoSz8ksHcktrZKRq7
         lcOeufePSzUUMeU3fzBGlYBph5pcUaZQqt87oykxn6idISuIc7fhlRTpWA+RU5alacTr
         4iegTO4ybojBhElULXjQToX8+ifPswiUXZ+drmKsH0JC6K16Ovy8cc+/Vyh+Lt9D+pr6
         AsQ0CFbyOm1uvljB+Ej8t+Dufxz3p+heCtLN4ENRcAh3rtwWPkSWV8MalbKb96YHx6Qz
         Ygf3wFXOniHOUUoBDezcXXWwH+8Ot4HyVlxYYjg+UrVlZ2zYq0WM+MeLZFY3rgRr71Zi
         i7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/krkgGWRLPwrBOotoEiPAuKzZC5AWMQrtjDnDpAK2FI=;
        b=ov1p1FO0LlXRApD/Y2ED73vo7wtir3Dmo2g8HvO32wdn2oSVacf4MQkWBNVz7g8QE+
         Qjm9/s5HALYU1gEzU5QR1Lfx3Vk0uY9TUfLjfgRstAKPgyLuQj5ewhEX1qfHqLVyJweD
         4US07FEzG8nUyBamQWO63SDc4eZ8C1QTGrNTVygWpx8SwK7zLZpL0ZYASlquS8dQCG9Z
         ln4ZOVsaGKUKCDrECLfxY9wz8c+3mv91nnIxTQGPqtBkuSAkM4GIRcweg9OKCg0Vj13r
         r0513OZvPjV91epuDncC/cLTNcewAtIGM0sT+jeHNGIYGDi1Rx9JfDMORxHhxaFjxGQG
         zZKw==
X-Gm-Message-State: AOAM530XkHF2two3IVCkOjvv4GdPIXUBL4CK3ZfHvzz/Umx8LCwsXZGJ
        xBDl5gXxOPS+RncOKMtwkSY=
X-Google-Smtp-Source: ABdhPJwkQW2le5RVdC4V9Sn8fTVfqQ39bAof6kT8+Bi38tuJ+vH393jZam3QMTBaK9swjMMH5rg9Zw==
X-Received: by 2002:a63:3193:: with SMTP id x141mr7266188pgx.254.1602341684887;
        Sat, 10 Oct 2020 07:54:44 -0700 (PDT)
Received: from arpitha-Inspiron-7570.lan ([106.51.240.187])
        by smtp.gmail.com with ESMTPSA id gg24sm15772806pjb.44.2020.10.10.07.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 07:54:44 -0700 (PDT)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        yzaikin@google.com, elver@google.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kunit: Support for Parameterized Testing
Date:   Sat, 10 Oct 2020 20:23:57 +0530
Message-Id: <20201010145357.60886-1-98.arpi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Implementation of support for parameterized testing in KUnit.

Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
---
 include/kunit/test.h | 29 +++++++++++++++++++++++++++++
 lib/kunit/test.c     | 44 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 59f3144f009a..4740d66269b4 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -140,10 +140,14 @@ struct kunit;
 struct kunit_case {
 	void (*run_case)(struct kunit *test);
 	const char *name;
+	void* (*get_params)(void);
+	int max_parameters_count;
+	int parameter_size;
 
 	/* private: internal use only. */
 	bool success;
 	char *log;
+	bool parameterized;
 };
 
 static inline char *kunit_status_to_string(bool status)
@@ -162,6 +166,11 @@ static inline char *kunit_status_to_string(bool status)
  */
 #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
 
+#define KUNIT_CASE_PARAM(test_name, getparams, count, size)				\
+		{ .run_case = test_name, .name = #test_name,				\
+		  .parameterized = true, .get_params = (void* (*)(void))getparams,	\
+		  .max_parameters_count = count, .parameter_size = size }
+
 /**
  * struct kunit_suite - describes a related collection of &struct kunit_case
  *
@@ -206,6 +215,23 @@ struct kunit {
 	/* private: internal use only. */
 	const char *name; /* Read only after initialization! */
 	char *log; /* Points at case log after initialization */
+	bool parameterized; /* True for parameterized tests */
+	/* param_values stores the test parameters
+	 * for parameterized tests.
+	 */
+	void *param_values;
+	/* max_parameters_count indicates maximum number of
+	 * parameters for parameterized tests.
+	 */
+	int max_parameters_count;
+	/* iterator_count is used by the iterator method
+	 * for parameterized tests.
+	 */
+	int iterator_count;
+	/* parameter_size indicates size of a single test case
+	 * for parameterized tests.
+	 */
+	int parameter_size;
 	struct kunit_try_catch try_catch;
 	/*
 	 * success starts as true, and may only be set to false during a
@@ -225,6 +251,7 @@ struct kunit {
 };
 
 void kunit_init_test(struct kunit *test, const char *name, char *log);
+void kunit_init_param_test(struct kunit *test, struct kunit_case *test_case);
 
 int kunit_run_tests(struct kunit_suite *suite);
 
@@ -237,6 +264,8 @@ int __kunit_test_suites_init(struct kunit_suite **suites);
 
 void __kunit_test_suites_exit(struct kunit_suite **suites);
 
+void *get_test_case_parameters(struct kunit *test);
+
 /**
  * kunit_test_suites() - used to register one or more &struct kunit_suite
  *			 with KUnit.
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c36037200310..ab9e13c81d4a 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -142,6 +142,11 @@ unsigned int kunit_test_case_num(struct kunit_suite *suite,
 }
 EXPORT_SYMBOL_GPL(kunit_test_case_num);
 
+static void kunit_print_failed_param(struct kunit *test)
+{
+	kunit_err(test, "\n\tTest failed at parameter: %d\n", test->iterator_count);
+}
+
 static void kunit_print_string_stream(struct kunit *test,
 				      struct string_stream *stream)
 {
@@ -182,6 +187,9 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
 
 	assert->format(assert, stream);
 
+	if (test->parameterized)
+		kunit_print_failed_param(test);
+
 	kunit_print_string_stream(test, stream);
 
 	WARN_ON(string_stream_destroy(stream));
@@ -236,6 +244,18 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
 }
 EXPORT_SYMBOL_GPL(kunit_init_test);
 
+void kunit_init_param_test(struct kunit *test, struct kunit_case *test_case)
+{
+	spin_lock_init(&test->lock);
+	INIT_LIST_HEAD(&test->resources);
+	test->parameterized = true;
+	test->param_values = (void *)(test_case->get_params());
+	test->max_parameters_count = test_case->max_parameters_count;
+	test->parameter_size = test_case->parameter_size;
+	test->iterator_count = 0;
+}
+EXPORT_SYMBOL_GPL(kunit_init_param_test);
+
 /*
  * Initializes and runs test case. Does not clean up or do post validations.
  */
@@ -254,7 +274,14 @@ static void kunit_run_case_internal(struct kunit *test,
 		}
 	}
 
-	test_case->run_case(test);
+	if (!test->parameterized) {
+		test_case->run_case(test);
+	} else {
+		int i;
+
+		for (i = 0; i < test->max_parameters_count; i++)
+			test_case->run_case(test);
+	}
 }
 
 static void kunit_case_internal_cleanup(struct kunit *test)
@@ -343,6 +370,8 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	struct kunit test;
 
 	kunit_init_test(&test, test_case->name, test_case->log);
+	if (test_case->parameterized)
+		kunit_init_param_test(&test, test_case);
 	try_catch = &test.try_catch;
 
 	kunit_try_catch_init(try_catch,
@@ -407,6 +436,19 @@ void __kunit_test_suites_exit(struct kunit_suite **suites)
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
 
+/*
+ * Iterator method for the parameterized test cases
+ */
+void *get_test_case_parameters(struct kunit *test)
+{
+	int index = test->iterator_count * test->parameter_size;
+
+	if (test->iterator_count != test->max_parameters_count)
+		test->iterator_count++;
+	return (test->param_values + index);
+}
+EXPORT_SYMBOL_GPL(get_test_case_parameters);
+
 /*
  * Used for static resources and when a kunit_resource * has been created by
  * kunit_alloc_resource().  When an init function is supplied, @data is passed
-- 
2.25.1

