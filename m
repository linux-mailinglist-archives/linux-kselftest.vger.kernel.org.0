Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8A12A87A2
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Nov 2020 20:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbgKETzN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 14:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKETzN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 14:55:13 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96388C0613D2
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Nov 2020 11:55:12 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id k18so2779890wmj.5
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Nov 2020 11:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MZwKDRqQrsQ4zOtuDWn8CpYHSaA3PZfjgaxfQ8Lvz/A=;
        b=NBn+saBUkqIqJpqtHqt6rtowzapePx1k8oKQTFP5PxeuOA3G0OkNG41bPksIwelbYO
         PejAhTKrb/eDzyCC08ZxjmSiAAur9pEit+ILEUm7F+Dyom01AsRBEl2LT2e7oTMvcqze
         19RLUwVVEdsMLJg8252nlHStnHyjlufXCodHavgjkGa1HQmLelZjKvJ+ETarJNeGdaIr
         oAoZ6TfWvKDB4E19ggLKP/kfP2YDdosadqaJDwsOCp9/zX5kkyCGOxBU0jW2MOxJJvdk
         ea8XPYUgoplya+AX67ysNkUfMQ39/IoKtrJzsk7PWkq8Ty8EX9G2ARdrfcQTg86a228w
         7E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MZwKDRqQrsQ4zOtuDWn8CpYHSaA3PZfjgaxfQ8Lvz/A=;
        b=IJgQHUWpdA8UIZc3Rul4+tyt8bbNySIFlVL+PmopuFlfDCoSzR5ohiV+m9YZHySLEp
         ujr/Ol95T/xxSb6vTNkAZCfR1dkOcsMen8DdV2VP78L/DNCq/KgSfbN4c8U69sQSu16P
         5W78m0ROSNZfBgQwqa9epBWqxv3575YBuLPDYH83HwEdvPOj070XZTrrA5ltsJiKV/7/
         Eq+1UjsD/SawDQoU1tv13lI564cMw6CqyiQ8xZsWOrudOITjrwBSfRQUn2Y+SGLc1gNX
         Y1hpOai9PHA3PiT/WyPrIKkt14RwEp0a6miPM25cmuY4LqCDZnaawGAktc7tCo2c0K+i
         qGJQ==
X-Gm-Message-State: AOAM53394p8ZRRvRTD2KFQ3cyOJ5F9BaKIx6MApd10Ih9JZxP3ZIsOur
        RszlD550e87hr2rq2DUN6UH+qg==
X-Google-Smtp-Source: ABdhPJwWdi8jg48/kPf5VHWeippxva2nmrLkrBaPBC/MBg75Uqf/eoJFRq4gHLJavMs6I4ZNbOeVnA==
X-Received: by 2002:a1c:205:: with SMTP id 5mr4334979wmc.7.1604606110996;
        Thu, 05 Nov 2020 11:55:10 -0800 (PST)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id b124sm647288wmh.13.2020.11.05.11.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:55:10 -0800 (PST)
Date:   Thu, 5 Nov 2020 20:55:03 +0100
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
Message-ID: <20201105195503.GA2399621@elver.google.com>
References: <20201027174630.85213-1-98.arpi@gmail.com>
 <CANpmjNOpbXHs4gs9Ro-u7hyN_zZ7s3AqDcdDy1Nqxq4ckThugA@mail.gmail.com>
 <73c4e46c-10f1-9362-b4fb-94ea9d74e9b2@gmail.com>
 <CANpmjNPxqQM0_f14ZwV3rHZzwhCtqx2fbOhHmXmiJawou6=z6Q@mail.gmail.com>
 <77d6dc66-1086-a9ae-ccbc-bb062ff81437@gmail.com>
 <CANpmjNORLJ4b_uwBB8v2h5cxoZF2SMTaz5K6QP37PxdUJDZUDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANpmjNORLJ4b_uwBB8v2h5cxoZF2SMTaz5K6QP37PxdUJDZUDA@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 05, 2020 at 04:02PM +0100, Marco Elver wrote:
> On Thu, 5 Nov 2020 at 15:30, Arpitha Raghunandan <98.arpi@gmail.com> wrot=
e:
[...]
> > >> I tried adding support to run each parameter as a distinct test case=
 by
> > >> making changes to kunit_run_case_catch_errors(). The issue here is t=
hat
> > >> since the results are displayed in KTAP format, this change will res=
ult in
> > >> each parameter being considered a subtest of another subtest (test c=
ase
> > >> in KUnit).
> > >
> > > Do you have example output? That might help understand what's going o=
n.
> > >
> >
> > The change that I tried can be seen here (based on the v4 patch):
> > https://gist.github.com/arpi-r/4822899087ca4cc34572ed9e45cc5fee.
> >
> > Using the kunit tool, I get this error:
> >
> > [19:20:41] [ERROR]  expected 7 test suites, but got -1
> > [ERROR] no tests run!
> > [19:20:41] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [19:20:41] Testing complete. 0 tests run. 0 failed. 0 crashed.
> >
> > But this error is only because of how the tool displays the results.
> > The test actually does run, as can be seen in the dmesg output:
> >
> > TAP version 14
> > 1..7
> >     # Subtest: ext4_inode_test
> >     1..1
> >     ok 1 - inode_test_xtimestamp_decoding 1
> >     ok 1 - inode_test_xtimestamp_decoding 2
> >     ok 1 - inode_test_xtimestamp_decoding 3
> >     ok 1 - inode_test_xtimestamp_decoding 4
> >     ok 1 - inode_test_xtimestamp_decoding 5
> >     ok 1 - inode_test_xtimestamp_decoding 6
> >     ok 1 - inode_test_xtimestamp_decoding 7
> >     ok 1 - inode_test_xtimestamp_decoding 8
> >     ok 1 - inode_test_xtimestamp_decoding 9
> >     ok 1 - inode_test_xtimestamp_decoding 10
> >     ok 1 - inode_test_xtimestamp_decoding 11
> >     ok 1 - inode_test_xtimestamp_decoding 12
> >     ok 1 - inode_test_xtimestamp_decoding 13
> >     ok 1 - inode_test_xtimestamp_decoding 14
> >     ok 1 - inode_test_xtimestamp_decoding 15
> >     ok 1 - inode_test_xtimestamp_decoding 16
> > ok 1 - ext4_inode_test
> > (followed by other kunit test outputs)
>=20
> Hmm, interesting. Let me play with your patch a bit.
>=20
> One option is to just have the test case number increment as well,
> i.e. have this:
> |    ok 1 - inode_test_xtimestamp_decoding#1
> |    ok 2 - inode_test_xtimestamp_decoding#2
> |    ok 3 - inode_test_xtimestamp_decoding#3
> |    ok 4 - inode_test_xtimestamp_decoding#4
> |    ok 5 - inode_test_xtimestamp_decoding#5
> ...
>=20
> Or is there something else I missed?

Right, so TAP wants the exact number of tests it will run ahead of time.
In which case we can still put the results of each parameterized test in
a diagnostic. Please see my proposed patch below, which still does
proper initialization/destruction of each parameter case as if it was
its own test case.

With it the output looks as follows:

| TAP version 14
| 1..6
|     # Subtest: ext4_inode_test
|     1..1
|     # ok param#0 - inode_test_xtimestamp_decoding
|     # ok param#1 - inode_test_xtimestamp_decoding
|     # ok param#2 - inode_test_xtimestamp_decoding
|     # ok param#3 - inode_test_xtimestamp_decoding
|     # ok param#4 - inode_test_xtimestamp_decoding
|     # ok param#5 - inode_test_xtimestamp_decoding
|     # ok param#6 - inode_test_xtimestamp_decoding
|     # ok param#7 - inode_test_xtimestamp_decoding
|     # ok param#8 - inode_test_xtimestamp_decoding
|     # ok param#9 - inode_test_xtimestamp_decoding
|     # ok param#10 - inode_test_xtimestamp_decoding
|     # ok param#11 - inode_test_xtimestamp_decoding
|     # ok param#12 - inode_test_xtimestamp_decoding
|     # ok param#13 - inode_test_xtimestamp_decoding
|     # ok param#14 - inode_test_xtimestamp_decoding
|     # ok param#15 - inode_test_xtimestamp_decoding
|     ok 1 - inode_test_xtimestamp_decoding
| ok 1 - ext4_inode_test

Would that be reasonable? If so, feel free to take the patch and
test/adjust as required.

I'm not sure on the best format -- is there is a recommended format for
parameterized test result output? If not, I suppose we can put anything
we like into the diagnostic.

Thanks,
-- Marco

------ >8 ------

=46rom ccbf4e2e190a2d7c6a94a51c9b1fb3b9a940e578 Mon Sep 17 00:00:00 2001
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
index 750704abe89a..453ebe4da77d 100644
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
+					  "# %s param#%d - %s",
+					  kunit_status_to_string(test.success),
+					  test.param_index, test_case->name);
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
2.29.1.341.ge80a0c044ae-goog

