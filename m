Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF742A9637
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 13:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgKFMem (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 07:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFMel (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 07:34:41 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F91C0613D2
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Nov 2020 04:34:41 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so355382wrx.5
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Nov 2020 04:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+0cyqcYUK2+B0qvk4HkncjgpI84qU878Jr3sHumUnC4=;
        b=MgMS7wfJPGYPDw9dED96W8wqjWKiOetL+Ja3hrUqjgo+c7aqOa7Qxe1lh8LWjA0qHi
         XRV3y4DYihndlFiaHsKYJEwiFcoMP1p2diofhARszuB/RxQqczRQRPYgBe9Y6yad3QKz
         ZRpAT5Bs/03ESFi7m69/Hz1dZpG661BUAa03D/XbCQVkd0QJEHgYsvxALrAxjlbJXsc6
         lFFxfo0iBVnJiFT/jkKoLv2NV1OhUURVB/0Pqpd1VCqnu+didTPDJfhIE0vP0cGc7Ksq
         zYrdT3dCz3KQeuEVszwy7u9VUO7iI+jfwsZfmsR2g50SM9VCHVq+QtTsToKlrggPaQaR
         VdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+0cyqcYUK2+B0qvk4HkncjgpI84qU878Jr3sHumUnC4=;
        b=X2bxfRe3aY1X2RR0SFC0o1eTU1XtGkz+Vyrbg9+9VZtlGLZwBir7w0rfzC/qZ0+ua4
         PPUy9jMpoL/lvkaGWJ/XXIBbJ6+SPG72mKjF0gz8SXHiNfRCLUJGmz4xIARTp0InCq/C
         qXhmL8ece5SVIBBP0mr4rLLw3Ok3TH0JNmNw8FKajenOclaXW5ANEaFz0YFbTBzxv+fR
         87w5cKgWE4j0wUqcAkclsZ/CZUEP2xj53jMZTKweO4H7P4+EYgmYIxq8mFP9xcKHdUDq
         CTJ3RvRQU6Nm5hZ0IcIrqHo+7ftTv87WqEzEu9s7SKzMXt/d4DTl2qWoMjTUmIWANh4e
         nM/Q==
X-Gm-Message-State: AOAM530z2YiO47BDc7Kfkd/Zes7ncD/48r4oVUkXfwQNToZKCJwhADgL
        afKPNCIJfSZZX9+GXtfKPVJp7w==
X-Google-Smtp-Source: ABdhPJx8pkKBByQHbPkV82psAfrDcCb9hyfQDBpKOYF74GUY2JB8yDA3oiAW2mfwTBALTKHbV9bnsA==
X-Received: by 2002:adf:a343:: with SMTP id d3mr2447934wrb.91.1604666079621;
        Fri, 06 Nov 2020 04:34:39 -0800 (PST)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id z14sm2170887wmc.15.2020.11.06.04.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 04:34:38 -0800 (PST)
Date:   Fri, 6 Nov 2020 13:34:33 +0100
From:   Marco Elver <elver@google.com>
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 1/2] kunit: Support for Parameterized Testing
Message-ID: <20201106123433.GA3563235@elver.google.com>
References: <20201027174630.85213-1-98.arpi@gmail.com>
 <CANpmjNOpbXHs4gs9Ro-u7hyN_zZ7s3AqDcdDy1Nqxq4ckThugA@mail.gmail.com>
 <73c4e46c-10f1-9362-b4fb-94ea9d74e9b2@gmail.com>
 <CANpmjNPxqQM0_f14ZwV3rHZzwhCtqx2fbOhHmXmiJawou6=z6Q@mail.gmail.com>
 <77d6dc66-1086-a9ae-ccbc-bb062ff81437@gmail.com>
 <CANpmjNORLJ4b_uwBB8v2h5cxoZF2SMTaz5K6QP37PxdUJDZUDA@mail.gmail.com>
 <20201105195503.GA2399621@elver.google.com>
 <f7e04221-607c-dd05-24a6-27c26d86919d@gmail.com>
 <CANpmjNMH9v3RE9xCh9nS=ZmBboxAsMvhfgby+QEO=Q3-oEyiNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANpmjNMH9v3RE9xCh9nS=ZmBboxAsMvhfgby+QEO=Q3-oEyiNA@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 06, 2020 at 09:11AM +0100, Marco Elver wrote:
> On Fri, 6 Nov 2020 at 06:54, Arpitha Raghunandan <98.arpi@gmail.com> wrot=
e:
[...]
> > I think this format of output should be fine for parameterized tests.
> > But, this patch has the same issue as earlier. While, the tests run and
> > this is the output that can be seen using dmesg, it still causes an iss=
ue on
> > using the kunit tool. It gives a similar error:
> >
> > [11:07:38] [ERROR]  expected 7 test suites, but got -1
> > [11:07:38] [ERROR] expected_suite_index -1, but got 2
> > [11:07:38] [ERROR] got unexpected test suite: kunit-try-catch-test
> > [ERROR] no tests run!
> > [11:07:38] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [11:07:38] Testing complete. 0 tests run. 0 failed. 0 crashed.
> >
>=20
> I'd suggest testing without these patches and diffing the output.
> AFAIK we're not adding any new non-# output, so it might be a
> pre-existing bug in some parsing code. Either that, or the parsing
> code does not respect the # correctly?

Hmm, tools/testing/kunit/kunit_parser.py has

	SUBTEST_DIAGNOSTIC =3D re.compile(r'^[\s]+# .*?: (.*)$')

, which seems to expect a ': ' in there. Not sure if this is required by
TAP, but let's leave this alone for now.

We can change the output to not trip this up, which might also be more a
consistent diagnostic format vs. other diagnostics. See the revised
patch below. With it the output is as follows:

| TAP version 14
| 1..6
|     # Subtest: ext4_inode_test
|     1..1
|     # inode_test_xtimestamp_decoding: param-0 ok
|     # inode_test_xtimestamp_decoding: param-1 ok
|     # inode_test_xtimestamp_decoding: param-2 ok
|     # inode_test_xtimestamp_decoding: param-3 ok
|     # inode_test_xtimestamp_decoding: param-4 ok
|     # inode_test_xtimestamp_decoding: param-5 ok
|     # inode_test_xtimestamp_decoding: param-6 ok
|     # inode_test_xtimestamp_decoding: param-7 ok
|     # inode_test_xtimestamp_decoding: param-8 ok
|     # inode_test_xtimestamp_decoding: param-9 ok
|     # inode_test_xtimestamp_decoding: param-10 ok
|     # inode_test_xtimestamp_decoding: param-11 ok
|     # inode_test_xtimestamp_decoding: param-12 ok
|     # inode_test_xtimestamp_decoding: param-13 ok
|     # inode_test_xtimestamp_decoding: param-14 ok
|     # inode_test_xtimestamp_decoding: param-15 ok
|     ok 1 - inode_test_xtimestamp_decoding
| ok 1 - ext4_inode_test

And kunit-tool seems to be happy as well.

Thanks,
-- Marco

------ >8 ------

=46rom 13a94d75d6b1b430e89fcff2cd76629b56b9d636 Mon Sep 17 00:00:00 2001
=46rom: Arpitha Raghunandan <98.arpi@gmail.com>
Date: Tue, 27 Oct 2020 23:16:30 +0530
Subject: [PATCH] kunit: Support for Parameterized Testing

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
- Rework parameterized test case execution strategy: each parameter is exec=
uted
  as if it was its own test case, with its own test initialization and clea=
nup
  (init and exit are called, etc.). However, we cannot add new test cases p=
er TAP
  protocol once we have already started execution. Instead, log the result =
of
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
---
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
=20
 	/* private: internal use only. */
 	bool success;
@@ -163,6 +165,22 @@ static inline char *kunit_status_to_string(bool status)
  */
 #define KUNIT_CASE(test_name) { .run_case =3D test_name, .name =3D #test_n=
ame }
=20
+/**
+ * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_=
case
+ *
+ * @test_name: a reference to a test case function.
+ * @gen_params: a reference to a parameter generator function.
+ *
+ * The generator function ``const void* gen_params(const void *prev)`` is =
used
+ * to lazily generate a series of arbitrarily typed values that fit into a
+ * void*. The argument @prev is the previously returned value, which shoul=
d be
+ * used to derive the next value; @prev is set to NULL on the initial gene=
rator
+ * call.  When no more values are available, the generator must return NUL=
L.
+ */
+#define KUNIT_CASE_PARAM(test_name, gen_params)			\
+		{ .run_case =3D test_name, .name =3D #test_name,	\
+		  .generate_params =3D gen_params }
+
 /**
  * struct kunit_suite - describes a related collection of &struct kunit_ca=
se
  *
@@ -208,6 +226,10 @@ struct kunit {
 	const char *name; /* Read only after initialization! */
 	char *log; /* Points at case log after initialization */
 	struct kunit_try_catch try_catch;
+	/* param_value is the current parameter value for a test case. */
+	const void *param_value;
+	/* param_index stores the index of the parameter in parameterized tests. =
*/
+	int param_index;
 	/*
 	 * success starts as true, and may only be set to false during a
 	 * test case; thus, it is safe to update this across multiple
@@ -1742,4 +1764,18 @@ do {									       \
 						fmt,			       \
 						##__VA_ARGS__)
=20
+/**
+ * KUNIT_ARRAY_PARAM() - Define test parameter generator from an array.
+ * @name:  prefix for the test parameter generator function.
+ * @array: array of test parameters.
+ *
+ * Define function @name_gen_params which uses @array to generate paramete=
rs.
+ */
+#define KUNIT_ARRAY_PARAM(name, array)								\
+	static const void *name##_gen_params(const void *prev)					\
+	{											\
+		typeof((array)[0]) * __next =3D prev ? ((typeof(__next)) prev) + 1 : (ar=
ray);	\
+		return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;			\
+	}
+
 #endif /* _KUNIT_TEST_H */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 750704abe89a..329fee9e0634 100644
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
=20
-	kunit_init_test(&test, test_case->name, test_case->log);
-	try_catch =3D &test.try_catch;
+	kunit_init_test(test, test_case->name, test_case->log);
+	try_catch =3D &test->try_catch;
=20
 	kunit_try_catch_init(try_catch,
-			     &test,
+			     test,
 			     kunit_try_run_case,
 			     kunit_catch_run_case);
-	context.test =3D &test;
+	context.test =3D test;
 	context.suite =3D suite;
 	context.test_case =3D test_case;
 	kunit_try_catch_run(try_catch, &context);
=20
-	test_case->success =3D test.success;
-
-	kunit_print_ok_not_ok(&test, true, test_case->success,
-			      kunit_test_case_num(suite, test_case),
-			      test_case->name);
+	test_case->success =3D test->success;
 }
=20
 int kunit_run_tests(struct kunit_suite *suite)
@@ -356,8 +352,32 @@ int kunit_run_tests(struct kunit_suite *suite)
=20
 	kunit_print_subtest_start(suite);
=20
-	kunit_suite_for_each_test_case(suite, test_case)
-		kunit_run_case_catch_errors(suite, test_case);
+	kunit_suite_for_each_test_case(suite, test_case) {
+		struct kunit test =3D { .param_value =3D NULL, .param_index =3D 0 };
+		bool test_success =3D true;
+
+		if (test_case->generate_params)
+			test.param_value =3D test_case->generate_params(NULL);
+
+		do {
+			kunit_run_case_catch_errors(suite, test_case, &test);
+			test_success &=3D test_case->success;
+
+			if (test_case->generate_params) {
+				kunit_log(KERN_INFO, &test,
+					  KUNIT_SUBTEST_INDENT
+					  "# %s: param-%d %s",
+					  test_case->name, test.param_index,
+					  kunit_status_to_string(test.success));
+				test.param_value =3D test_case->generate_params(test.param_value);
+				test.param_index++;
+			}
+		} while (test.param_value);
+
+		kunit_print_ok_not_ok(&test, true, test_success,
+				      kunit_test_case_num(suite, test_case),
+				      test_case->name);
+	}
=20
 	kunit_print_subtest_end(suite);
=20
--=20
2.29.2.222.g5d2a92d10f8-goog

