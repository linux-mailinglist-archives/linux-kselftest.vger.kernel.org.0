Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C093B2971E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465521AbgJWPGL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 11:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461528AbgJWPGK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 11:06:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7BC0613CE;
        Fri, 23 Oct 2020 08:06:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so1488882pgg.1;
        Fri, 23 Oct 2020 08:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cOkCttaR0bC+4/s3OhAlnJb8FuiFIwQlMyKpigG8dkI=;
        b=pFREwHdtLPQZmiTj8UQXEeuy9cmHFRUbUCtz+jETwBYbX8Fi7yzUGESD6Qvh0ZAxHR
         ZFlrFzC+UDnJcHOfad12GTiXKcQ01F/bry3iRzK+DT8JSvQecsQrP1vcIxjbtIYgvGHw
         uhL4pP1tS4NL0tKBwi/hv2z24CkByZulgdi2vxo1IHrvX2jy9vohwpwB+fVzWgZNhre9
         t8So6jTNE8/J+yYhIPeLCNr3XWBKs4lpVkhs2XKy02MkoNS4ITETMKdvx6SBxh4JDlrN
         FOhmgXMnX70JmMSNw9OI6uro4n95eGaVIkeoKMHsJqZb5/zhb/VTXr6oxu6w5ybzZlMA
         6LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cOkCttaR0bC+4/s3OhAlnJb8FuiFIwQlMyKpigG8dkI=;
        b=essW8S4Y0PIEWxqQdwxWeEoY7J37tB6cUytCqrI1RkhXvVV1ZvT2rtFA9FRqmMJq34
         N0QCXBFQsRf15SE9YaFfCmytSNES5Djz3554hDxADxreAd2GB+wAlsM30RQ/mm5IIOCQ
         eDPWJjBhaq6Xmp+2OUzAROdYvcsYIQs2hXpYlI9HSbfhGi/Z3+J8OSknAUjH4LuTpbbY
         vgCrmniwHrDDVOx0u42Rp3SfjjVFHJuIF62OcwuOWbwXGic4i7stLm+K2aQ/hFFxFNBJ
         3lkqURiXFrmIo7ELwoXHTG1Ca0IWGpNftFG67BHR9rkjN1x+01YAQIpzxT0tp1P9hAua
         v8ew==
X-Gm-Message-State: AOAM531EGoXTUkQH7plSSEn7cnjcAd1/H8VINWyhuLm6DCHuA1gX1aKX
        QOV9INTeiuqyUhreDpEoydgVQaM9I17g1tXW
X-Google-Smtp-Source: ABdhPJy+G+QRKUIq2q5O0AbyDACZK1LnjZBNu9jE4BW7rj5lUUjlAVaQEcEaigJVkn4aUzpNH2EvKg==
X-Received: by 2002:a17:90b:1c0d:: with SMTP id oc13mr3275849pjb.192.1603465569743;
        Fri, 23 Oct 2020 08:06:09 -0700 (PDT)
Received: from arpitha-Inspiron-7570.lan ([106.51.242.32])
        by smtp.gmail.com with ESMTPSA id 78sm2430532pfz.211.2020.10.23.08.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 08:06:08 -0700 (PDT)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        elver@google.com, yzaikin@google.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH v2 1/2] kunit: Support for Parameterized Testing
Date:   Fri, 23 Oct 2020 20:35:36 +0530
Message-Id: <20201023150536.282568-1-98.arpi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Implementation of support for parameterized testing in KUnit.

Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
---
Changes v1->v2:
- Use of a generator method to access test case parameters

 include/kunit/test.h | 45 ++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/test.c     | 20 +++++++++++++++++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index a423fffefea0..c417ac140326 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -141,6 +141,7 @@ struct kunit;
 struct kunit_case {
 	void (*run_case)(struct kunit *test);
 	const char *name;
+	void* (*generate_params)(struct kunit *test, void *prev);
 
 	/* private: internal use only. */
 	bool success;
@@ -162,6 +163,9 @@ static inline char *kunit_status_to_string(bool status)
  * &struct kunit_case for an example on how to use it.
  */
 #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
+#define KUNIT_CASE_PARAM(test_name, gen_params)			\
+		{ .run_case = test_name, .name = #test_name,	\
+		  .generate_params = gen_params }
 
 /**
  * struct kunit_suite - describes a related collection of &struct kunit_case
@@ -208,6 +212,15 @@ struct kunit {
 	const char *name; /* Read only after initialization! */
 	char *log; /* Points at case log after initialization */
 	struct kunit_try_catch try_catch;
+	/* param_values points to test case parameters in parameterized tests */
+	void *param_values;
+	/*
+	 * current_param stores the index of the parameter in
+	 * the array of parameters in parameterized tests.
+	 * current_param + 1 is printed to indicate the parameter
+	 * that causes the test to fail in case of test failure.
+	 */
+	int current_param;
 	/*
 	 * success starts as true, and may only be set to false during a
 	 * test case; thus, it is safe to update this across multiple
@@ -1742,4 +1755,36 @@ do {									       \
 						fmt,			       \
 						##__VA_ARGS__)
 
+/**
+ * kunit_param_generator_helper() - Helper method for test parameter generators
+ * 				    required in parameterized tests.
+ * @test: The test context object.
+ * @prev_param: a pointer to the previous test parameter, NULL for first parameter.
+ * @param_array: a user-supplied pointer to an array of test parameters.
+ * @array_size: number of test parameters in the array.
+ * @type_size: size of one test parameter.
+ */
+static inline void *kunit_param_generator_helper(struct kunit *test,
+					void *prev_param,
+					void *param_array,
+					size_t array_size,
+					size_t type_size)
+{
+	KUNIT_ASSERT_EQ(test, (prev_param - param_array) % type_size, 0);
+
+	if (!prev_param)
+		return param_array;
+
+	KUNIT_ASSERT_GE(test, prev_param, param_array);
+
+	if (prev_param + type_size < param_array + (array_size * type_size))
+		return prev_param + type_size;
+	else
+		return NULL;
+}
+
+#define KUNIT_PARAM_GENERATOR_HELPER(test, prev_param, param_array, param_type) \
+	kunit_param_generator_helper(test, prev_param, param_array,		\
+				ARRAY_SIZE(param_array), sizeof(param_type))
+
 #endif /* _KUNIT_TEST_H */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 750704abe89a..0e6ffe6384a7 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -127,6 +127,11 @@ unsigned int kunit_test_case_num(struct kunit_suite *suite,
 }
 EXPORT_SYMBOL_GPL(kunit_test_case_num);
 
+static void kunit_print_failed_param(struct kunit *test)
+{
+	kunit_err(test, "\n\tTest failed at parameter: %d\n", test->current_param + 1);
+}
+
 static void kunit_print_string_stream(struct kunit *test,
 				      struct string_stream *stream)
 {
@@ -168,6 +173,8 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
 	assert->format(assert, stream);
 
 	kunit_print_string_stream(test, stream);
+	if (test->param_values)
+		kunit_print_failed_param(test);
 
 	WARN_ON(string_stream_destroy(stream));
 }
@@ -239,7 +246,18 @@ static void kunit_run_case_internal(struct kunit *test,
 		}
 	}
 
-	test_case->run_case(test);
+	if (!test_case->generate_params) {
+		test_case->run_case(test);
+	} else {
+		test->param_values = test_case->generate_params(test, NULL);
+		test->current_param = 0;
+
+		while (test->param_values) {
+			test_case->run_case(test);
+			test->param_values = test_case->generate_params(test, test->param_values);
+			test->current_param++;
+		}
+	}
 }
 
 static void kunit_case_internal_cleanup(struct kunit *test)
-- 
2.25.1

