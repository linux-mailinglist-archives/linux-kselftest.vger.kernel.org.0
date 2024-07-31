Return-Path: <linux-kselftest+bounces-14575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A089436FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 22:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147691F22704
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 20:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757FA3B1BC;
	Wed, 31 Jul 2024 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GOhpvIHL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9EC182D8
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456919; cv=none; b=hnDX4mqtCmhlrb7JguikmfZoSYZjWp7h+Nr1H3OU4b0TcxI6GAYqkQgoqEvs+g+XddkKveHwaW6Q+JNYXZ8FU0u8pb8Edhwv6f/IMKPEwIjgxAN13TAorrumvAfISdiFKh/nGH8/a9yO48OTDYqOReOTityJbnAeW+U+MExrmoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456919; c=relaxed/simple;
	bh=CVt1fbmPXVyLuB05VF0Eeyv464whL7R9zjlKv47LJxY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tlvzq7Ck9uPhqzcfPH+iA/ktEc3YVwpTCCKIya0NIoh99m6KZ+7cEt0Lv979ei6+RNH3/tFeifIxAah41RcJU94t/AQ7xQIkko3ILxkLWa/Ww+Ry7QoaSlRjbv3eLunu9YciF7wTV1aWoaiRBQ3tPCmwbsGm0o4hBOf+vqV4udQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GOhpvIHL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66b3b4415c7so128537357b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 13:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722456916; x=1723061716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1oDowfhQycvrmi4jlaqZRlUo3on0dMIH9H6CfupRya0=;
        b=GOhpvIHLxg6YOp4cYgkGtm2CtfG5R6sdlaa2JPtlbcOTIG9yF8lvZ1SkkkwRTqp0kH
         RABoDx7i0CW/hE4TtSF3+R4NczT18uf4ggGsCqmFUSIYlUpBrBI4rAVsYjR2agIfZ0aC
         AXHccVjo23sTM41I5bDSb6W/vcIOtmCq3YZCvsvxwDDsV7KV/kcjT0y7lOAd5tT+OHLR
         2T2hr+OjTcj1Csm006pf+FiVgOvSPXx1m7zoFRAZ+ICSJapjPOp+5kCyjgaFuhRj6KMO
         /dquaKfqbT5PXjVhfYyeoxKfCQIpaomcdSqX8aKwyd5YeqfQVyuzJcnQX+V1WLbyogdy
         wYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722456916; x=1723061716;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1oDowfhQycvrmi4jlaqZRlUo3on0dMIH9H6CfupRya0=;
        b=uQDYC59v5HyX/6ywCwyvgx6GBN1fNlc6XClarA4JiQYZhNNBcyO0TpBDJ0VwEDKKvy
         w+CHxeRWaBoihp8VoTv7Ofvq5JVXGp7/R1aX8XGok/hNSZKyl4J1ykb0DbvWk1P++xP3
         TFk5ZBqFXfh30pZT7e7eO42g6amukqz7M9DhsnTkWSPD9mPKRbAhhnpQafHRdiubdB9S
         XzhDnDcKPZIzwtCiDOoXsRp+ByXLj1XwNwcWphOHmDG3qfjcWvE5zhdQJUtcJ5whCegg
         kIDPbtbR+KvIBzfEIEMkdOjoFef35JTCMiCoUQqMzWDV7l21hoIQJ1yOcPx8MJwkyUFp
         d7tQ==
X-Gm-Message-State: AOJu0YwrQPkzNVioJMa+nPRX8+qM++sehN1i4jF4WboNBAgkWswkMLYu
	VYDUWBxFywtExvGLUdmjybwLJ+Slp7uBPf4eRTg2RvsDoPq5RmMGWB02BXvbrxtGgktlJ0o5dQ=
	=
X-Google-Smtp-Source: AGHT+IENdh72dh9PnFdNT8axzxCFtztiUq7XqSGjM62xHve7F+RNbtwzib3M4neI57xZTVWRyukmA3UyZQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:1004:b0:e0b:b348:9848 with SMTP id
 3f1490d57ef6-e0bcd37b07amr164276.9.1722456916236; Wed, 31 Jul 2024 13:15:16
 -0700 (PDT)
Date: Wed, 31 Jul 2024 20:15:08 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240731201508.53805-1-rmoar@google.com>
Subject: [PATCH v2] kunit: add test duration attribute
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new test duration attribute to print the duration of a test run.

Example:
 KTAP version 1
    # Subtest: memcpy
    # module: memcpy_kunit
    1..4
    # memcpy_large_test.speed: slow
    # memcpy_large_test.duration: 1.134787584s
    ok 1 memcpy_large_test
    ...

This attribute is printed for each test (excluding parameterized tests).

Add documentation for this new attribute to KUnit docs.

In order to save the timespec64 object, add the ability to save a memory
allocated object to the attributes framework.

Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes v1->v2:
- Change sprintf to kasprintf

 .../dev-tools/kunit/running_tips.rst          |  7 +++
 include/kunit/attributes.h                    |  5 ++
 include/kunit/test.h                          |  1 +
 lib/kunit/attributes.c                        | 54 ++++++++++++++++++-
 lib/kunit/test.c                              | 25 +++++++--
 5 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index bd689db6fdd2..a528d92e5d8f 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -446,3 +446,10 @@ This attribute indicates whether the test uses init data or functions.
 
 This attribute is automatically saved as a boolean and tests can also be
 filtered using this attribute.
+
+``duration``
+
+This attribute indicates the length of time in seconds of the test execution.
+
+This attribute is automatically saved as a timespec64 and printed for each test
+(excluding parameterized tests).
diff --git a/include/kunit/attributes.h b/include/kunit/attributes.h
index bc76a0b786d2..89ca54ef380d 100644
--- a/include/kunit/attributes.h
+++ b/include/kunit/attributes.h
@@ -18,6 +18,11 @@ struct kunit_attr_filter {
 	char *input;
 };
 
+/*
+ * Frees all of a test's allocated attributes.
+ */
+void kunit_free_attr(void *test_or_suite, bool is_test);
+
 /*
  * Returns the name of the filter's attribute.
  */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index ec61cad6b71d..dca78d9bd3f6 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -82,6 +82,7 @@ enum kunit_speed {
 /* Holds attributes for each test case and suite */
 struct kunit_attributes {
 	enum kunit_speed speed;
+	struct timespec64 *duration;
 };
 
 /**
diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
index 2cf04cc09372..fd01d54e52d7 100644
--- a/lib/kunit/attributes.c
+++ b/lib/kunit/attributes.c
@@ -40,6 +40,7 @@ struct kunit_attr {
 	int (*filter)(void *attr, const char *input, int *err);
 	void *attr_default;
 	enum print_ops print;
+	bool to_free;
 };
 
 /* String Lists for enum Attributes */
@@ -79,8 +80,22 @@ static const char *attr_string_to_string(void *attr, bool *to_free)
 	return (char *) attr;
 }
 
+static const char *attr_duration_to_string(void *attr, bool *to_free)
+{
+	struct timespec64 *val = (struct timespec64 *)attr;
+	char *str = kasprintf(GFP_KERNEL, "%lld.%09lds", val->tv_sec, val->tv_nsec);
+
+	*to_free = true;
+	return str;
+}
+
 /* Filter Methods */
 
+static int attr_default_filter(void *attr, const char *input, int *err)
+{
+	return false;
+}
+
 static const char op_list[] = "<>!=";
 
 /*
@@ -246,8 +261,20 @@ static void *attr_is_init_get(void *test_or_suite, bool is_test)
 		return ((void *) suite->is_init);
 }
 
+static void *attr_duration_get(void *test_or_suite, bool is_test)
+{
+	struct kunit_case *test = is_test ? test_or_suite : NULL;
+
+	if (test && !test->generate_params)
+		return ((void *) test->attr.duration);
+	else
+		return ((void *) NULL);
+}
+
 /* List of all Test Attributes */
 
+static struct timespec64 duration_default = {0, 0};
+
 static struct kunit_attr kunit_attr_list[] = {
 	{
 		.name = "speed",
@@ -256,6 +283,7 @@ static struct kunit_attr kunit_attr_list[] = {
 		.filter = attr_speed_filter,
 		.attr_default = (void *)KUNIT_SPEED_NORMAL,
 		.print = PRINT_ALWAYS,
+		.to_free = false,
 	},
 	{
 		.name = "module",
@@ -264,6 +292,7 @@ static struct kunit_attr kunit_attr_list[] = {
 		.filter = attr_string_filter,
 		.attr_default = (void *)"",
 		.print = PRINT_SUITE,
+		.to_free = false,
 	},
 	{
 		.name = "is_init",
@@ -272,10 +301,33 @@ static struct kunit_attr kunit_attr_list[] = {
 		.filter = attr_bool_filter,
 		.attr_default = (void *)false,
 		.print = PRINT_SUITE,
+		.to_free = false,
+	},
+	{
+		.name = "duration",
+		.get_attr = attr_duration_get,
+		.to_string = attr_duration_to_string,
+		.filter = attr_default_filter,
+		.attr_default = (void *)(&duration_default),
+		.print = PRINT_ALWAYS,
+		.to_free = true,
 	}
 };
 
-/* Helper Functions to Access Attributes */
+/* Helper Functions to Access/Free Attributes */
+
+void kunit_free_attr(void *test_or_suite, bool is_test)
+{
+	int i;
+	void *attr;
+
+	for (i = 0; i < ARRAY_SIZE(kunit_attr_list); i++) {
+		if (kunit_attr_list[i].to_free) {
+			attr = kunit_attr_list[i].get_attr(test_or_suite, is_test);
+			kfree(attr);
+		}
+	}
+}
 
 const char *kunit_attr_filter_name(struct kunit_attr_filter filter)
 {
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index e8b1b52a19ab..0d18e4969015 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -376,11 +376,11 @@ static void kunit_run_case_check_speed(struct kunit *test,
 /*
  * Initializes and runs test case. Does not clean up or do post validations.
  */
-static void kunit_run_case_internal(struct kunit *test,
+static struct timespec64 kunit_run_case_internal(struct kunit *test,
 				    struct kunit_suite *suite,
 				    struct kunit_case *test_case)
 {
-	struct timespec64 start, end;
+	struct timespec64 start, end, duration;
 
 	if (suite->init) {
 		int ret;
@@ -389,7 +389,9 @@ static void kunit_run_case_internal(struct kunit *test,
 		if (ret) {
 			kunit_err(test, "failed to initialize: %d\n", ret);
 			kunit_set_failure(test);
-			return;
+			duration.tv_sec = 0;
+			duration.tv_nsec = 0;
+			return duration;
 		}
 	}
 
@@ -399,7 +401,11 @@ static void kunit_run_case_internal(struct kunit *test,
 
 	ktime_get_ts64(&end);
 
-	kunit_run_case_check_speed(test, test_case, timespec64_sub(end, start));
+	duration = timespec64_sub(end, start);
+
+	kunit_run_case_check_speed(test, test_case, duration);
+
+	return duration;
 }
 
 static void kunit_case_internal_cleanup(struct kunit *test)
@@ -424,6 +430,7 @@ struct kunit_try_catch_context {
 	struct kunit *test;
 	struct kunit_suite *suite;
 	struct kunit_case *test_case;
+	struct timespec64 duration;
 };
 
 static void kunit_try_run_case(void *data)
@@ -440,7 +447,7 @@ static void kunit_try_run_case(void *data)
 	 * abort will be called, this thread will exit, and finally the parent
 	 * thread will resume control and handle any necessary clean up.
 	 */
-	kunit_run_case_internal(test, suite, test_case);
+	ctx->duration = kunit_run_case_internal(test, suite, test_case);
 }
 
 static void kunit_try_run_case_cleanup(void *data)
@@ -521,6 +528,7 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 {
 	struct kunit_try_catch_context context;
 	struct kunit_try_catch *try_catch;
+	struct timespec64 *duration = kmalloc(sizeof(struct timespec64), GFP_KERNEL);
 
 	try_catch = &test->try_catch;
 
@@ -533,6 +541,10 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	context.test_case = test_case;
 	kunit_try_catch_run(try_catch, &context);
 
+	duration->tv_sec = context.duration.tv_sec;
+	duration->tv_nsec = context.duration.tv_nsec;
+	test_case->attr.duration = duration;
+
 	/* Now run the cleanup */
 	kunit_try_catch_init(try_catch,
 			     test,
@@ -670,6 +682,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 		}
 
 		kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CASE);
+		kunit_free_attr((void *)test_case, true);
 
 		kunit_print_test_stats(&test, param_stats);
 
@@ -680,6 +693,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 
 		kunit_update_stats(&suite_stats, test_case->status);
 		kunit_accumulate_stats(&total_stats, param_stats);
+
 	}
 
 	if (suite->suite_exit)
@@ -688,6 +702,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 	kunit_print_suite_stats(suite, suite_stats, total_stats);
 suite_end:
 	kunit_print_suite_end(suite);
+	kunit_free_attr((void *)suite, false);
 
 	return 0;
 }

base-commit: 67c9971cd6d309ecbcb87b942e22ffc194d7a376
-- 
2.46.0.rc2.264.g509ed76dc8-goog


