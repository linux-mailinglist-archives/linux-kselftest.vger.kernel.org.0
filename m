Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2FD29C383
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 18:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1822123AbgJ0RrN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 13:47:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38488 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1822118AbgJ0RrH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 13:47:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so1345608pfp.5;
        Tue, 27 Oct 2020 10:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aVsNnL1ok0ysdwP7UDtWbtFrfy8z7SExZwj3jr3Vm2s=;
        b=RnoCBn0oxegs9sYJiBmxzUlpBqJs6P6O+Gp4kF2ZAUcxgKaN3Fx6pXdjHj/JpqrhJ2
         4spcs0faeMhQYyYLd18oI5PPUXFdHxHFTlUGasjDxO5Z/lH4YvkbQziO5AWKT92i9Cvq
         n05pKOts614rBAaS7r6bvoH5HDoUjV5I/ufgA5I4/lwgE5sxVe49R6QMeVfz1ZJq0VXq
         usm+mtrQW8J+9rn39s/G6l+eOpYeeN5IGTlwBK1A/u1diB2rFnD9zVYJp7ieK6hREiw7
         BTbJlxtzhl3v+mK6xbEA2S7gqF2K7RLy6ZS20F9dhM7yfDENhNbPP3LMHwcZS3bqeKVF
         M+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aVsNnL1ok0ysdwP7UDtWbtFrfy8z7SExZwj3jr3Vm2s=;
        b=i27nptSi1cc+e3Ldq5pdkO18WBaMFloiQ8L8y2ecmhjdz0NdkS84IBYoKkgcqcRHTe
         OuZ1bhlZ8zkgwK/oIPETh1NxWaNj+1rvKQxEUVulh7chwvGKmEAg6VKwz0gHzKBvJkk/
         ilZqIJCjyWUE5WP9uISdSy/fsC4ILj2vTh64N4ayQf4Ia0zpnVApNKJxHgOqTcuzqQGZ
         5mBQ+RfbWnl33tAc8BZeIFA2KQlA9NPqc46nlpVel8mz8SKERtaEMlsElD4ZfmcfMgtD
         +cOa7hOWg9BglmB9WwZMiv64ppEysRNtwZ8m/OrQRzY2LvN1POKF7iWrlGnuh5bmbmyQ
         /vQA==
X-Gm-Message-State: AOAM5315xucPpWZYHK44IjaH9c1pS0GFVp9ob0a8IVexw3aL1s+bU1qs
        eOdfObzMg9xsmgqF1V3of9A=
X-Google-Smtp-Source: ABdhPJwVATQwRqDKinAmRyabBjkId+SiNykWzpqlwCHd7Rs0ZVL1i/IScSyDPS3WF1qjRBUgSOTWQw==
X-Received: by 2002:a05:6a00:134c:b029:160:c73:8462 with SMTP id k12-20020a056a00134cb02901600c738462mr3264745pfu.4.1603820826322;
        Tue, 27 Oct 2020 10:47:06 -0700 (PDT)
Received: from arpitha-Inspiron-7570.lan ([106.51.240.100])
        by smtp.gmail.com with ESMTPSA id 15sm2965980pfj.179.2020.10.27.10.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:47:05 -0700 (PDT)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        elver@google.com, yzaikin@google.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH v4 1/2] kunit: Support for Parameterized Testing
Date:   Tue, 27 Oct 2020 23:16:30 +0530
Message-Id: <20201027174630.85213-1-98.arpi@gmail.com>
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
Changes v3->v4:
- Rename kunit variables
- Rename generator function helper macro
- Add documentation for generator approach
- Display test case name in case of failure along with param index
Changes v2->v3:
- Modifictaion of generator macro and method
Changes v1->v2:
- Use of a generator method to access test case parameters

 include/kunit/test.h | 34 ++++++++++++++++++++++++++++++++++
 lib/kunit/test.c     | 21 ++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9197da792336..ec2307ee9bb0 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -107,6 +107,13 @@ struct kunit;
  *
  * @run_case: the function representing the actual test case.
  * @name:     the name of the test case.
+ * @generate_params: the generator function for parameterized tests.
+ *
+ * The generator function is used to lazily generate a series of
+ * arbitrarily typed values that fit into a void*. The argument @prev
+ * is the previously returned value, which should be used to derive the
+ * next value; @prev is set to NULL on the initial generator call.
+ * When no more values are available, the generator must return NULL.
  *
  * A test case is a function with the signature,
  * ``void (*)(struct kunit *)``
@@ -141,6 +148,7 @@ struct kunit;
 struct kunit_case {
 	void (*run_case)(struct kunit *test);
 	const char *name;
+	void* (*generate_params)(void *prev);
 
 	/* private: internal use only. */
 	bool success;
@@ -162,6 +170,9 @@ static inline char *kunit_status_to_string(bool status)
  * &struct kunit_case for an example on how to use it.
  */
 #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
+#define KUNIT_CASE_PARAM(test_name, gen_params)			\
+		{ .run_case = test_name, .name = #test_name,	\
+		  .generate_params = gen_params }
 
 /**
  * struct kunit_suite - describes a related collection of &struct kunit_case
@@ -208,6 +219,15 @@ struct kunit {
 	const char *name; /* Read only after initialization! */
 	char *log; /* Points at case log after initialization */
 	struct kunit_try_catch try_catch;
+	/* param_value points to test case parameters in parameterized tests */
+	void *param_value;
+	/*
+	 * param_index stores the index of the parameter in
+	 * parameterized tests. param_index + 1 is printed
+	 * to indicate the parameter that causes the test
+	 * to fail in case of test failure.
+	 */
+	int param_index;
 	/*
 	 * success starts as true, and may only be set to false during a
 	 * test case; thus, it is safe to update this across multiple
@@ -1742,4 +1762,18 @@ do {									       \
 						fmt,			       \
 						##__VA_ARGS__)
 
+/**
+ * KUNIT_ARRAY_PARAM() - Helper method for test parameter generators
+ * 			 required in parameterized tests.
+ * @name:  prefix of the name for the test parameter generator function.
+ *	   It will be suffixed by "_gen_params".
+ * @array: a user-supplied pointer to an array of test parameters.
+ */
+#define KUNIT_ARRAY_PARAM(name, array)								\
+	static void *name##_gen_params(void *prev)						\
+	{											\
+		typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
+		return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;			\
+	}
+
 #endif /* _KUNIT_TEST_H */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 750704abe89a..8ad908b61494 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -127,6 +127,12 @@ unsigned int kunit_test_case_num(struct kunit_suite *suite,
 }
 EXPORT_SYMBOL_GPL(kunit_test_case_num);
 
+static void kunit_print_failed_param(struct kunit *test)
+{
+	kunit_err(test, "\n\tTest failed at:\n\ttest case: %s\n\tparameter: %d\n",
+						test->name, test->param_index + 1);
+}
+
 static void kunit_print_string_stream(struct kunit *test,
 				      struct string_stream *stream)
 {
@@ -168,6 +174,8 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
 	assert->format(assert, stream);
 
 	kunit_print_string_stream(test, stream);
+	if (test->param_value)
+		kunit_print_failed_param(test);
 
 	WARN_ON(string_stream_destroy(stream));
 }
@@ -239,7 +247,18 @@ static void kunit_run_case_internal(struct kunit *test,
 		}
 	}
 
-	test_case->run_case(test);
+	if (!test_case->generate_params) {
+		test_case->run_case(test);
+	} else {
+		test->param_value = test_case->generate_params(NULL);
+		test->param_index = 0;
+
+		while (test->param_value) {
+			test_case->run_case(test);
+			test->param_value = test_case->generate_params(test->param_value);
+			test->param_index++;
+		}
+	}
 }
 
 static void kunit_case_internal_cleanup(struct kunit *test)
-- 
2.25.1

