Return-Path: <linux-kselftest+bounces-35003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD6FAD9B72
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 10:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80995189B9D1
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 08:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E8D1E5B9E;
	Sat, 14 Jun 2025 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJLyKtzX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8B1A2622
	for <linux-kselftest@vger.kernel.org>; Sat, 14 Jun 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749890874; cv=none; b=Xsd7FYFkNYJouH59pKW7Zyls6ar49/A373ua7Amo/RJz0FhwLc0TJRVDZVOjMqPFeWLijIks2pzF2cj0eOiGSrCYO92qhG3YG+iuaBEnATviDSfx2Nbg14J4mCrP4+fZII+jae+yQ7dl60p7aF+vNuYbWrBqNDzUocDQNq4/AXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749890874; c=relaxed/simple;
	bh=1zE5dRa2pTIbWgRSSsDZnGOGsw/ocPUokv7v0pIjIFw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qp2CeUnhexHBVS9An0CR+UOIkarnGAMUmZWJVk8spBnMs1fe0l4KDd3Ffm8w8vlLOpooXQDFCWITf8DDhqVcB/iMmOfDlVqSUF9MG6XPiRidWMG69yw4qGSBBUrDQEuijLEBWg2Q/LbWueW17gvaOOUZ10IsGliTSie1enVa8d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nJLyKtzX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c37558eccso2123494a12.1
        for <linux-kselftest@vger.kernel.org>; Sat, 14 Jun 2025 01:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749890872; x=1750495672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UmexxkUsMlwsDUZqAJqCu3m0c/NmHuIKmfWQMr16+98=;
        b=nJLyKtzXdgxjr5NMSb1YVwm47oslp0U6BdwXvPa5MS4CQ78l+hFqeYe1EYdgk2HDHX
         OlJhQoxmRbwv0JXJZL2ttb37B64FvWBztxDuNsbkTvy+jWuYsBqOh2RasgiLhErgtunz
         PGq3oPfah1e6qWIbok8LTQsM8FBYqnrdaHc9yUgUSGeksImr3WEWRYmPiWXiHzJvOyu6
         Za945L5ILNh6SlFLFKVHKUeQO4jn/BrmHx7cUF7GZQFwNa7lMfIivH9BiKxaieKxUEjb
         K/EHbT+nI3rnUFFpu9f2tW5QE0sKiYDorqIBp4pNRmTyqKXvPz0FWH7NYKYpAjCbatYA
         IoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749890872; x=1750495672;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmexxkUsMlwsDUZqAJqCu3m0c/NmHuIKmfWQMr16+98=;
        b=Y+M/pdb9dIeltz4jnIRXubwOz9xRq6jT0gbrhzQp1Le1DZcgbT5rtynF1O0TDWiOJp
         xlybuMhgW2eW350PsWqBeM1QJFnP56igrjiklBs4uBtF+Ku3FgvFyI1BtlgsMuPzhLHF
         PYy+/1EH0NUw8ttDhd3PsKk8MnAQ/WMrMx+9Xu/9MfxQ7KkGh/gVXXgVk09V7evmcQLh
         lynAuRf9K0bE6gtdSzDMNTeweGIrOUTO/pEzEVKEuhusf2nVhbwucs0IzSbfXqkh8sSh
         YCTMbG1DqYSXm4xiaHXVINbZH+OfLD+l65PbADDBH3o2umYrmaK447xkKPObrTyrOqzG
         MjcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKvEzWV/pS/gZsqXKSteOuFEIITchBryOX/BZy5YW2xTdn/iSDMVQ8FXimSwRk2cKpyLy+Y8kcj2m/H5QhGZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7ISz8tyRyryjeFH/KTlQBFQ6YIJ3LqqrXZJmFW1zGDZO9e+t
	UJdQkguawG6jATOJFIaopKfG99tsWJNYD+1CWKqrCsB+jZNOMDwLks3ETLiKXb7Bv9aMolGU1Cs
	EaCegu//jE+g2ig==
X-Google-Smtp-Source: AGHT+IFCKUfKSAYv//yvPxISNKnOAsmR1cCjTxj8W//eQP2JArQ4PikZxQbSriVlh2ufnFQbzVsf0UUzOE9QZQ==
X-Received: from pgqw8.prod.google.com ([2002:a65:6948:0:b0:b2f:5b01:af42])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6481:b0:21c:faa4:9ab9 with SMTP id adf61e73a8af0-21fbd631592mr3401257637.22.1749890871693;
 Sat, 14 Jun 2025 01:47:51 -0700 (PDT)
Date: Sat, 14 Jun 2025 16:47:11 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250614084711.2654593-2-davidgow@google.com>
Subject: [PATCH] kunit: Adjust kunit_test timeout based on test_{suite,case} speed
From: David Gow <davidgow@google.com>
To: Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Ujwal Jain <ujwaljain@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ujwal Jain <ujwaljain@google.com>

Currently, the in-kernel kunit test case timeout is 300 seconds. (There
is a separate timeout mechanism for the whole test execution in
kunit.py, but that's unrelated.) However, tests marked 'slow' or 'very
slow' may timeout, particularly on slower machines.

Implement a multiplier to the test-case timeout, so that slower tests
have longer to complete:
- DEFAULT -> 1x default timeout
- KUNIT_SPEED_SLOW -> 3x default timeout
- KUNIT_SPEED_VERY_SLOW -> 12x default timeout

A further change is planned to allow user configuration of the
default/base timeout to allow people with faster or slower machines to
adjust these to their use-cases.

Signed-off-by: Ujwal Jain <ujwaljain@google.com>
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/try-catch.h  |  1 +
 lib/kunit/kunit-test.c     |  9 +++++---
 lib/kunit/test.c           | 46 ++++++++++++++++++++++++++++++++++++--
 lib/kunit/try-catch-impl.h |  4 +++-
 lib/kunit/try-catch.c      | 29 ++----------------------
 5 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/include/kunit/try-catch.h b/include/kunit/try-catch.h
index 7c966a1adbd3..d4e1a5b98ed6 100644
--- a/include/kunit/try-catch.h
+++ b/include/kunit/try-catch.h
@@ -47,6 +47,7 @@ struct kunit_try_catch {
 	int try_result;
 	kunit_try_catch_func_t try;
 	kunit_try_catch_func_t catch;
+	unsigned long timeout;
 	void *context;
 };
 
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index d9c781c859fd..387cdf7782f6 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -43,7 +43,8 @@ static void kunit_test_try_catch_successful_try_no_catch(struct kunit *test)
 	kunit_try_catch_init(try_catch,
 			     test,
 			     kunit_test_successful_try,
-			     kunit_test_no_catch);
+			     kunit_test_no_catch,
+			     300 * msecs_to_jiffies(MSEC_PER_SEC));
 	kunit_try_catch_run(try_catch, test);
 
 	KUNIT_EXPECT_TRUE(test, ctx->function_called);
@@ -75,7 +76,8 @@ static void kunit_test_try_catch_unsuccessful_try_does_catch(struct kunit *test)
 	kunit_try_catch_init(try_catch,
 			     test,
 			     kunit_test_unsuccessful_try,
-			     kunit_test_catch);
+			     kunit_test_catch,
+			     300 * msecs_to_jiffies(MSEC_PER_SEC));
 	kunit_try_catch_run(try_catch, test);
 
 	KUNIT_EXPECT_TRUE(test, ctx->function_called);
@@ -129,7 +131,8 @@ static void kunit_test_fault_null_dereference(struct kunit *test)
 	kunit_try_catch_init(try_catch,
 			     test,
 			     kunit_test_null_dereference,
-			     kunit_test_catch);
+			     kunit_test_catch,
+			     300 * msecs_to_jiffies(MSEC_PER_SEC));
 	kunit_try_catch_run(try_catch, test);
 
 	KUNIT_EXPECT_EQ(test, try_catch->try_result, -EINTR);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 146d1b48a096..002121675605 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -373,6 +373,46 @@ static void kunit_run_case_check_speed(struct kunit *test,
 		   duration.tv_sec, duration.tv_nsec);
 }
 
+/* Returns timeout multiplier based on speed.
+ * DEFAULT:		    1
+ * KUNIT_SPEED_SLOW:        3
+ * KUNIT_SPEED_VERY_SLOW:   12
+ */
+static int kunit_timeout_mult(enum kunit_speed speed)
+{
+	switch (speed) {
+	case KUNIT_SPEED_SLOW:
+		return 3;
+	case KUNIT_SPEED_VERY_SLOW:
+		return 12;
+	default:
+		return 1;
+	}
+}
+
+static unsigned long kunit_test_timeout(struct kunit_suite *suite, struct kunit_case *test_case)
+{
+	int mult = 1;
+	/*
+	 * TODO: Make the default (base) timeout configurable, so that users with
+	 * particularly slow or fast machines can successfully run tests, while
+	 * still taking advantage of the relative speed.
+	 */
+	unsigned long default_timeout = 300;
+
+	/*
+	 * The default test timeout is 300 seconds and will be adjusted by mult
+	 * based on the test speed. The test speed will be overridden by the
+	 * innermost test component.
+	 */
+	if (suite->attr.speed != KUNIT_SPEED_UNSET)
+		mult = kunit_timeout_mult(suite->attr.speed);
+	if (test_case->attr.speed != KUNIT_SPEED_UNSET)
+		mult = kunit_timeout_mult(test_case->attr.speed);
+	return mult * default_timeout * msecs_to_jiffies(MSEC_PER_SEC);
+}
+
+
 /*
  * Initializes and runs test case. Does not clean up or do post validations.
  */
@@ -527,7 +567,8 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	kunit_try_catch_init(try_catch,
 			     test,
 			     kunit_try_run_case,
-			     kunit_catch_run_case);
+			     kunit_catch_run_case,
+			     kunit_test_timeout(suite, test_case));
 	context.test = test;
 	context.suite = suite;
 	context.test_case = test_case;
@@ -537,7 +578,8 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	kunit_try_catch_init(try_catch,
 			     test,
 			     kunit_try_run_case_cleanup,
-			     kunit_catch_run_case_cleanup);
+			     kunit_catch_run_case_cleanup,
+			     kunit_test_timeout(suite, test_case));
 	kunit_try_catch_run(try_catch, &context);
 
 	/* Propagate the parameter result to the test case. */
diff --git a/lib/kunit/try-catch-impl.h b/lib/kunit/try-catch-impl.h
index 203ba6a5e740..6f401b97cd0b 100644
--- a/lib/kunit/try-catch-impl.h
+++ b/lib/kunit/try-catch-impl.h
@@ -17,11 +17,13 @@ struct kunit;
 static inline void kunit_try_catch_init(struct kunit_try_catch *try_catch,
 					struct kunit *test,
 					kunit_try_catch_func_t try,
-					kunit_try_catch_func_t catch)
+					kunit_try_catch_func_t catch,
+					unsigned long timeout)
 {
 	try_catch->test = test;
 	try_catch->try = try;
 	try_catch->catch = catch;
+	try_catch->timeout = timeout;
 }
 
 #endif /* _KUNIT_TRY_CATCH_IMPL_H */
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 6bbe0025b079..d84a879f0a78 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -34,31 +34,6 @@ static int kunit_generic_run_threadfn_adapter(void *data)
 	return 0;
 }
 
-static unsigned long kunit_test_timeout(void)
-{
-	/*
-	 * TODO(brendanhiggins@google.com): We should probably have some type of
-	 * variable timeout here. The only question is what that timeout value
-	 * should be.
-	 *
-	 * The intention has always been, at some point, to be able to label
-	 * tests with some type of size bucket (unit/small, integration/medium,
-	 * large/system/end-to-end, etc), where each size bucket would get a
-	 * default timeout value kind of like what Bazel does:
-	 * https://docs.bazel.build/versions/master/be/common-definitions.html#test.size
-	 * There is still some debate to be had on exactly how we do this. (For
-	 * one, we probably want to have some sort of test runner level
-	 * timeout.)
-	 *
-	 * For more background on this topic, see:
-	 * https://mike-bland.com/2011/11/01/small-medium-large.html
-	 *
-	 * If tests timeout due to exceeding sysctl_hung_task_timeout_secs,
-	 * the task will be killed and an oops generated.
-	 */
-	return 300 * msecs_to_jiffies(MSEC_PER_SEC); /* 5 min */
-}
-
 void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 {
 	struct kunit *test = try_catch->test;
@@ -85,8 +60,8 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 	task_done = task_struct->vfork_done;
 	wake_up_process(task_struct);
 
-	time_remaining = wait_for_completion_timeout(task_done,
-						     kunit_test_timeout());
+	time_remaining = wait_for_completion_timeout(
+		task_done, try_catch->timeout);
 	if (time_remaining == 0) {
 		try_catch->try_result = -ETIMEDOUT;
 		kthread_stop(task_struct);
-- 
2.50.0.rc1.591.g9c95f17f64-goog


