Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE8C51775B
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 May 2022 21:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiEBT1P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 May 2022 15:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiEBT1O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 May 2022 15:27:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F954FC7
        for <linux-kselftest@vger.kernel.org>; Mon,  2 May 2022 12:23:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d11b6259adso143285407b3.19
        for <linux-kselftest@vger.kernel.org>; Mon, 02 May 2022 12:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=u6uGuHjDonU8GgKi5o3QqSYBcswbbJsYRfVkbCnaliQ=;
        b=iNzC0zoQbUjXIUrnjuhHAFXqs+YbWqM7nT1s5vxFwUvhF2evBiuySc5Mu/w9M39xfg
         tFIKiiKMZOlPL1TvFfScVrPaeAXApNH3unbI0WhLnM6+KMV3CxXEWUDTTiWTI7hUyOue
         2XcXRwyX7mCE8WpddgEWCEza5ugI1ny6mDlH+rimNWtesU+UgmOUIOL/cJ3LlVCSZ2L9
         u+vt2yksHd1ECxeGZsTUM+MLXg5/ssjji+Xk++gazq8qtMXk4S4DyS7LOnSh4jwYpe5q
         Ng1r056NUewG/eZqZRWgDF7qgnIgHNDjmKb4LyVv9SUrWlu02Y3LomLhwIvUwyXiFchp
         4s7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=u6uGuHjDonU8GgKi5o3QqSYBcswbbJsYRfVkbCnaliQ=;
        b=dvihf0yjbeT0odYLE4JrQ2Xs6XEmOHjJV1RUh+fOJoLz5TChc/aoolapy09iVdu+Lw
         5mZVefeApXuid7L59W1o7gs9Q1GKD0+zn/nvIpWw19p0OuP4316JpE3AXm3OmaweXR3m
         TfvjqSRSwQEWrW0okh3BO33py5c6FKRl4xHZoo6KaU5AJvZSMYhujraAHVjZGfPSxEWd
         YG3MB548yEvB+iZkeDwEqmgJvbKxlQxLbh6w1Zg7R2tsWln3s8gi9FMqdSdBLLzwQIn2
         XgmaAdtEV63WVJxSjnl1GGj5+SKEL8nMt41D+PylX6Sqm6BjWq8h6RbH4xqW6psNS2bR
         0Lgg==
X-Gm-Message-State: AOAM533yGLHty6qYsPsqneMJ/ARq1itlOC6O1w4ywAs1r7g6IOOBMMxp
        aT25MvMR2MJF81wz/Z6RCGwAK4zpln5dsA==
X-Google-Smtp-Source: ABdhPJzr+Qb68nmy/48m+B8I8Rvi4T/TloDTdT8kDtBPCHEXSQ6VRNR7jB4iAi0iqzm4afiOCQL+T98bxKy/2A==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a2d5:5696:644a:499e])
 (user=dlatypov job=sendgmr) by 2002:a25:ec0d:0:b0:648:480d:7c08 with SMTP id
 j13-20020a25ec0d000000b00648480d7c08mr11491125ybh.206.1651519424288; Mon, 02
 May 2022 12:23:44 -0700 (PDT)
Date:   Mon,  2 May 2022 12:23:27 -0700
Message-Id: <20220502192327.81153-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH] lib/atomic64_test.c: convert to use KUnit
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        mpe@ellerman.id.au, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test currently is a bunch of checks (implemented using BUG_ON())
that can be built into the kernel or as a module.

Convert it to a KUnit test, which can also run in both modes.
From a user's perspective, this change adds a CONFIG_KUNIT=3Dy dep and
changes the output format of the test [1]. The test itself is the same.

This hopefully makes the test easier to run and more consistent with
similar tests in lib/.
Since it has no dependencies, it can be run without explicitly setting
up a .kunitconfig via
$ ./tools/testing/kunit/kunit.py run atomic
...
[13:53:44] Starting KUnit Kernel (1/1)...
[13:53:44] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[13:53:47] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D atomic=
 (2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[13:53:47] [PASSED] test_atomic
[13:53:47] [PASSED] test_atomic64
[13:53:47] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
[PASSED] atomic =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
[13:53:47] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[13:53:47] Testing complete. Passed: 2, Failed: 0, Crashed: 0, Skipped: 0, =
Errors: 0
[13:53:47] Elapsed time: 13.902s total, 1.629s configuring, 9.331s building=
, 2.852s running

It can be run on ARCH=3Dx86_64 (and others) via:
$ ./tools/testing/kunit/kunit.py run --arch=3Dx86_64 atomic

The message about which platform the test ran on won't show up in
kunit.py, but still gets printed out in dmesg, e.g.
> TAP version 14
> 1..1
>     # Subtest: atomic
>     1..2
>     ok 1 - test_atomic
>     ok 2 - test_atomic64
>     # atomic: ran on x86-64 platform with CX8 and with SSE
> # atomic: pass:2 fail:0 skip:0 total:2
> # Totals: pass:2 fail:0 skip:0 total:2
> ok 1 - atomic

Signed-off-by: Daniel Latypov <dlatypov@google.com>

[1] https://www.kernel.org/doc/html/latest/dev-tools/ktap.html
---
Meta:
1. this patch applies on top of the kunit branch,
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?=
h=3Dkunit

2. checkpatch complains about aligning with parens, but it wants me to
indent the `#ifdef CONFIG_X86_64` which seems inappropriate in context.

3. this file doesn't seem to have a clear maintainer, so I assume this
conversion is fine to go through the kunit branch. The only observable
differences are the new CONFIG_KUNIT=3Dy dep and more standardized (KTAP)
output format.
---
 lib/Kconfig.debug   |   4 +-
 lib/atomic64_test.c | 107 +++++++++++++++++++++-----------------------
 2 files changed, 55 insertions(+), 56 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 075cd25363ac..4cf8d5feda0a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2223,7 +2223,9 @@ config PERCPU_TEST
 	  If unsure, say N.
=20
 config ATOMIC64_SELFTEST
-	tristate "Perform an atomic64_t self-test"
+	tristate "Perform an atomic64_t self-test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  Enable this option to test the atomic64_t functions at boot or
 	  at module load time.
diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index d9d170238165..46cb0130f8d0 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -5,13 +5,9 @@
  * Copyright =C2=A9 2010  Luca Barbieri
  */
=20
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <kunit/test.h>
=20
-#include <linux/init.h>
-#include <linux/bug.h>
-#include <linux/kernel.h>
 #include <linux/atomic.h>
-#include <linux/module.h>
=20
 #ifdef CONFIG_X86
 #include <asm/cpufeature.h>	/* for boot_cpu_has below */
@@ -23,9 +19,7 @@ do {								\
 	r =3D v0;							\
 	atomic##bit##_##op(val, &v);				\
 	r c_op val;						\
-	WARN(atomic##bit##_read(&v) !=3D r, "%Lx !=3D %Lx\n",	\
-		(unsigned long long)atomic##bit##_read(&v),	\
-		(unsigned long long)r);				\
+	KUNIT_ASSERT_EQ(test, atomic##bit##_read(&v), r);	\
 } while (0)
=20
 /*
@@ -46,8 +40,8 @@ do {								\
 	atomic##bit##_set(&v, v0);				\
 	r =3D v0;							\
 	r c_op val;						\
-	BUG_ON(atomic##bit##_##op(val, &v) !=3D r);		\
-	BUG_ON(atomic##bit##_read(&v) !=3D r);			\
+	KUNIT_ASSERT_EQ(test, atomic##bit##_##op(val, &v), r);	\
+	KUNIT_ASSERT_EQ(test, atomic##bit##_read(&v), r);	\
 } while (0)
=20
 #define TEST_FETCH(bit, op, c_op, val)				\
@@ -55,8 +49,8 @@ do {								\
 	atomic##bit##_set(&v, v0);				\
 	r =3D v0;							\
 	r c_op val;						\
-	BUG_ON(atomic##bit##_##op(val, &v) !=3D v0);		\
-	BUG_ON(atomic##bit##_read(&v) !=3D r);			\
+	KUNIT_ASSERT_EQ(test, atomic##bit##_##op(val, &v), v0);	\
+	KUNIT_ASSERT_EQ(test, atomic##bit##_read(&v), r);	\
 } while (0)
=20
 #define RETURN_FAMILY_TEST(bit, op, c_op, val)			\
@@ -72,8 +66,8 @@ do {								\
 #define TEST_ARGS(bit, op, init, ret, expect, args...)		\
 do {								\
 	atomic##bit##_set(&v, init);				\
-	BUG_ON(atomic##bit##_##op(&v, ##args) !=3D ret);		\
-	BUG_ON(atomic##bit##_read(&v) !=3D expect);		\
+	KUNIT_ASSERT_EQ(test, atomic##bit##_##op(&v, ##args), ret);\
+	KUNIT_ASSERT_EQ(test, atomic##bit##_read(&v), expect);	\
 } while (0)
=20
 #define XCHG_FAMILY_TEST(bit, init, new)				\
@@ -101,7 +95,7 @@ do {							\
 			i, (i) - one, (i) - one);	\
 } while (0)
=20
-static __init void test_atomic(void)
+static void test_atomic(struct kunit *test)
 {
 	int v0 =3D 0xaaa31337;
 	int v1 =3D 0xdeadbeef;
@@ -144,7 +138,7 @@ static __init void test_atomic(void)
 }
=20
 #define INIT(c) do { atomic64_set(&v, c); r =3D c; } while (0)
-static __init void test_atomic64(void)
+static void test_atomic64(struct kunit *test)
 {
 	long long v0 =3D 0xaaa31337c001d00dLL;
 	long long v1 =3D 0xdeadbeefdeafcafeLL;
@@ -156,12 +150,12 @@ static __init void test_atomic64(void)
=20
 	atomic64_t v =3D ATOMIC64_INIT(v0);
 	long long r =3D v0;
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	atomic64_set(&v, v1);
 	r =3D v1;
-	BUG_ON(v.counter !=3D r);
-	BUG_ON(atomic64_read(&v) !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
+	KUNIT_ASSERT_EQ(test, atomic64_read(&v), r);
=20
 	TEST(64, add, +=3D, onestwos);
 	TEST(64, add, +=3D, -one);
@@ -190,12 +184,12 @@ static __init void test_atomic64(void)
 	INIT(v0);
 	atomic64_inc(&v);
 	r +=3D one;
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(v0);
 	atomic64_dec(&v);
 	r -=3D one;
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INC_RETURN_FAMILY_TEST(64, v0);
 	DEC_RETURN_FAMILY_TEST(64, v0);
@@ -204,73 +198,76 @@ static __init void test_atomic64(void)
 	CMPXCHG_FAMILY_TEST(64, v0, v1, v2);
=20
 	INIT(v0);
-	BUG_ON(atomic64_add_unless(&v, one, v0));
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_FALSE(test, atomic64_add_unless(&v, one, v0));
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(v0);
-	BUG_ON(!atomic64_add_unless(&v, one, v1));
+	KUNIT_ASSERT_TRUE(test, atomic64_add_unless(&v, one, v1));
 	r +=3D one;
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(onestwos);
-	BUG_ON(atomic64_dec_if_positive(&v) !=3D (onestwos - 1));
+	KUNIT_ASSERT_EQ(test, atomic64_dec_if_positive(&v), (onestwos - 1));
 	r -=3D one;
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(0);
-	BUG_ON(atomic64_dec_if_positive(&v) !=3D -one);
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, atomic64_dec_if_positive(&v), -one);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(-one);
-	BUG_ON(atomic64_dec_if_positive(&v) !=3D (-one - one));
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, atomic64_dec_if_positive(&v), (-one - one));
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(onestwos);
-	BUG_ON(!atomic64_inc_not_zero(&v));
+	KUNIT_ASSERT_TRUE(test, atomic64_inc_not_zero(&v));
 	r +=3D one;
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(0);
-	BUG_ON(atomic64_inc_not_zero(&v));
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_FALSE(test, atomic64_inc_not_zero(&v));
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	INIT(-one);
-	BUG_ON(!atomic64_inc_not_zero(&v));
+	KUNIT_ASSERT_TRUE(test, atomic64_inc_not_zero(&v));
 	r +=3D one;
-	BUG_ON(v.counter !=3D r);
+	KUNIT_ASSERT_EQ(test, v.counter, r);
=20
 	/* Confirm the return value fits in an int, even if the value doesn't */
 	INIT(v3);
+
 	r_int =3D atomic64_inc_not_zero(&v);
-	BUG_ON(!r_int);
+	KUNIT_ASSERT_NE(test, r_int, 0);
 }
=20
-static __init int test_atomics_init(void)
-{
-	test_atomic();
-	test_atomic64();
+static struct kunit_case atomic_test_cases[] =3D {
+	KUNIT_CASE(test_atomic),
+	KUNIT_CASE(test_atomic64),
+	{},
+};
=20
+static void atomic_suite_exit(struct kunit_suite *suite)
+{
 #ifdef CONFIG_X86
-	pr_info("passed for %s platform %s CX8 and %s SSE\n",
+	kunit_info(suite, "ran on %s platform %s CX8 and %s SSE\n",
 #ifdef CONFIG_X86_64
-		"x86-64",
+		   "x86-64",
 #elif defined(CONFIG_X86_CMPXCHG64)
-		"i586+",
+		   "i586+",
 #else
-		"i386+",
+		   "i386+",
 #endif
-	       boot_cpu_has(X86_FEATURE_CX8) ? "with" : "without",
-	       boot_cpu_has(X86_FEATURE_XMM) ? "with" : "without");
-#else
-	pr_info("passed\n");
+		   boot_cpu_has(X86_FEATURE_CX8) ? "with" : "without",
+		   boot_cpu_has(X86_FEATURE_XMM) ? "with" : "without");
 #endif
-
-	return 0;
 }
=20
-static __exit void test_atomics_exit(void) {}
+static struct kunit_suite atomic_test_suite =3D {
+	.name =3D "atomic",
+	.test_cases =3D atomic_test_cases,
+	.suite_exit =3D atomic_suite_exit,
+};
=20
-module_init(test_atomics_init);
-module_exit(test_atomics_exit);
+kunit_test_suites(&atomic_test_suite);
=20
 MODULE_LICENSE("GPL");

base-commit: 38289a26e1b8a37755f3e07056ca416c1ee2a2e8
--=20
2.36.0.464.gb9c8b46e94-goog

