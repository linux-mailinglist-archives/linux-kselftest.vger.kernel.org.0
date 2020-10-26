Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5B299578
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 19:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790019AbgJZSgN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 14:36:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37713 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790017AbgJZSgM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 14:36:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id b12so2790581plr.4;
        Mon, 26 Oct 2020 11:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDOHv5b8HiOM16zq/llcw/rbyjliyY5uE1ixYVZQCRk=;
        b=Oluu89m6zfnz2xjgPuqZ/RtqNtSFMlEBWuKWY6dglhynSZHo52MpwU4nIX/l9JqgBN
         VAWmDkz5EtHdhrStBWaYy0XSF15h0gb5VOmfQTL8nkeOh6BYtLAisjFqocIuPlpH/ZWd
         Q9FEbXvfhwzq/+BN9aRU+0+DeoMf+7hEkbQ1ZMCBEjUph0HQmkWd4qgAeZKkBZ9JydvD
         yQD2cCtL8Kdf6eAfhHpmVHp+BwyvUEWelMiHhRkEcDaGdXyDbyjTQSb7pXPQftDuXR9E
         5kjXcMxTwR3Wojl8R9kX5fDWk9vxT8NZdMeNBzlCeQoFLtb/xTVk05VEN/mqZtngfZH+
         nbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDOHv5b8HiOM16zq/llcw/rbyjliyY5uE1ixYVZQCRk=;
        b=jTMNt6g1qfcAdx5e42ro5VOLajPC0q8+AYwAaetDTPRAFRQ/ErCMUwpd9/8fqaGHTI
         o6Qu9kJ0IUC2ss1/mcNrCp4uX0n6XTHSrE1AiGZ65gTbYIzy+kPRuFjIW7wd5NH6HD0A
         pznjKG5/91oTHi27JL9VM2qWfIVr8BuqyntXiu/F77Ze9H8e8R9BtJ6pg/FekugHAuoJ
         q+mliRFGZVwgJ9I6bavhhbE6q2ts0UARAQcpF65HJ7lKSHER7DW9nbsztVz5lnEGLOwg
         KtK2iIaVgtkhcbQ3kl59KQpxfGiHY7hnJL2ly5asSDYMw57tBbnyk3vBSnV9SwIW51i0
         yldA==
X-Gm-Message-State: AOAM533KRia6tby1c2Cs8WVFe4nyOaJrbSSvMqugQSH/L6k9t9GX4s4C
        DUFD9eAyzbMftmJIFcEbcGw=
X-Google-Smtp-Source: ABdhPJw+Kpj72k9Rn6j1v/PbCzIUTKXOjmOgwzcUZNhWRbstWGMZPmaBxBy8VHtiGcdwZKqlH49fTQ==
X-Received: by 2002:a17:90a:fe8:: with SMTP id 95mr17238402pjz.73.1603737370301;
        Mon, 26 Oct 2020 11:36:10 -0700 (PDT)
Received: from arpitha-Inspiron-7570.lan ([106.51.240.100])
        by smtp.gmail.com with ESMTPSA id z23sm11085260pgf.12.2020.10.26.11.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:36:09 -0700 (PDT)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        elver@google.com, yzaikin@google.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH v3 1/2] kunit: Support for Parameterized Testing
Date:   Tue, 27 Oct 2020 00:05:23 +0530
Message-Id: <20201026183523.82749-1-98.arpi@gmail.com>
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
Changes v2->v3:
- Modifictaion of generator macro and method
Changes v1->v2:
- Use of a generator method to access test case parameters

 include/kunit/test.h | 32 ++++++++++++++++++++++++++++++++
 lib/kunit/test.c     | 20 +++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index a423fffefea0..16bf9f334e2c 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -142,6 +142,12 @@ struct kunit_case {
 	void (*run_case)(struct kunit *test);
 	const char *name;
 
+	/*
+	 * Pointer to test parameter generator function.
+	 * Used only for parameterized tests.
+	 */
+	void* (*generate_params)(void *prev);
+
 	/* private: internal use only. */
 	bool success;
 	char *log;
@@ -162,6 +168,9 @@ static inline char *kunit_status_to_string(bool status)
  * &struct kunit_case for an example on how to use it.
  */
 #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
+#define KUNIT_CASE_PARAM(test_name, gen_params)			\
+		{ .run_case = test_name, .name = #test_name,	\
+		  .generate_params = gen_params }
 
 /**
  * struct kunit_suite - describes a related collection of &struct kunit_case
@@ -208,6 +217,15 @@ struct kunit {
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
@@ -1742,4 +1760,18 @@ do {									       \
 						fmt,			       \
 						##__VA_ARGS__)
 
+/**
+ * KUNIT_PARAM_GENERATOR() - Helper method for test parameter generators
+ * 			     required in parameterized tests.
+ * @name:  prefix of the name for the test parameter generator function.
+ * @prev: a pointer to the previous test parameter, NULL for first parameter.
+ * @array: a user-supplied pointer to an array of test parameters.
+ */
+#define KUNIT_PARAM_GENERATOR(name, array)							\
+	static void *name##_gen_params(void *prev)						\
+	{											\
+		typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
+		return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;			\
+	}
+
 #endif /* _KUNIT_TEST_H */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 750704abe89a..b70ab9b12f3b 100644
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
+		test->param_values = test_case->generate_params(NULL);
+		test->current_param = 0;
+
+		while (test->param_values) {
+			test_case->run_case(test);
+			test->param_values = test_case->generate_params(test->param_values);
+			test->current_param++;
+		}
+	}
 }
 
 static void kunit_case_internal_cleanup(struct kunit *test)
-- 
2.25.1

