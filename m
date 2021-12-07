Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A997446B282
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 06:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbhLGFob (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 00:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbhLGFo3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 00:44:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DECDC0698C7
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 21:40:58 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j204-20020a2523d5000000b005c21574c704so23960717ybj.13
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Dec 2021 21:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=peX9wdineCkjiUZXwUK5TGzqPfhKlElEHyDi4h2iJxM=;
        b=RbI9UJqS8c80wGqML0f1HHp+33WmNx1ZOSmPNm9FGrByyT0ccEOSXn7+z4L32esA08
         ubQF58toR20vjdMTGIjP60txsNrSiMF5WyPFpBlCz153vCbbl/xGM3zDW9T/2rLasnj5
         AosR6Nt+vaGpI/SH4+MblkDRwP/uNRVqblj7tNntXqt3QHxFLfZRxQ7aDjW+rueGDivB
         iMP9Z8QAmGcgqDkBNHv/CfP87j6zqzCg24d/xfggrOEtW7DbfKiHXzu6Xis8IFET14Hu
         dG3UFgmZXL+N9vCFetnwVOMPA03NVyl2EsMNUG+mWCQR9qsqTtza+qyt0WtLkr3tMsw9
         4Udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=peX9wdineCkjiUZXwUK5TGzqPfhKlElEHyDi4h2iJxM=;
        b=SKDr6yjux0c5F9Nfh6Ep7dReP2WXyKCaKe7U9POkRad+OtA5jwgRqNvN4LtDBNa22Q
         V8iOdmgXG6Rmd8155C/WDgenBPU85aB7kNXe0jauR3NYExG/yrIsb4eTsXXzK+I3K0JM
         BNbAIxGcgazFwBoTbtVQuybX3bgn7jug6cPFqC5KJQIy1xOpgervWw5gs4NQTiEybB+E
         CnZeqM0WmyZ1ZgwumoIertYDoKIW7VD2dF/2p+2NQt31xayXu8I1OAwZlGV9mNjjhOMT
         ubMbw4jGZuVCBQEf6c/I9yxIJpyVQrFAiGO+lVKiICRxQfr255vi2hBmbmose9coD4Ck
         5HsQ==
X-Gm-Message-State: AOAM531bJ2U6CnI9ac4ZuBl0g1BhKFle93n+Mn3ujLRr3DK6kynyp6ty
        0ZwMdFMZZyQND+59KWuEp6rE1+eIajh3ExI=
X-Google-Smtp-Source: ABdhPJz3H/A8lZW+ZmPFUNKqAfJJacVI0S0Z8eT6qktPMT1e2X3etC7OPdwaoBVq9dOkBp1ah6vwiH5NxgJEPDY=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a25:3846:: with SMTP id
 f67mr50223319yba.551.1638855657536; Mon, 06 Dec 2021 21:40:57 -0800 (PST)
Date:   Tue,  7 Dec 2021 05:40:17 +0000
In-Reply-To: <20211207054019.1455054-1-sharinder@google.com>
Message-Id: <20211207054019.1455054-6-sharinder@google.com>
Mime-Version: 1.0
References: <20211207054019.1455054-1-sharinder@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v2 5/7] Documentation: KUnit: Rework writing page to focus on
 writing tests
From:   Harinder Singh <sharinder@google.com>
To:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim.bird@sony.com, Harinder Singh <sharinder@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We now have dedicated pages on running tests. Therefore refocus the
usage page on writing tests and add content from tips page and
information on other architectures.

Signed-off-by: Harinder Singh <sharinder@google.com>
---
 Documentation/dev-tools/kunit/index.rst |   2 +-
 Documentation/dev-tools/kunit/start.rst |   2 +-
 Documentation/dev-tools/kunit/usage.rst | 570 ++++++++++--------------
 3 files changed, 247 insertions(+), 327 deletions(-)

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index c0d1fd749cd2..76c9704d6a1a 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -102,7 +102,7 @@ How do I use it?
 *   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
 *   Documentation/dev-tools/kunit/run_wrapper.rst - run kunit_tool.
 *   Documentation/dev-tools/kunit/run_manual.rst - run tests without kunit_tool.
-*   Documentation/dev-tools/kunit/usage.rst - KUnit features.
+*   Documentation/dev-tools/kunit/usage.rst - write tests.
 *   Documentation/dev-tools/kunit/tips.rst - best practices with
     examples.
 *   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index af13f443c976..a858ab009944 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -243,7 +243,7 @@ Next Steps
 *   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
 *   Documentation/dev-tools/kunit/run_wrapper.rst - run kunit_tool.
 *   Documentation/dev-tools/kunit/run_manual.rst - run tests without kunit_tool.
-*   Documentation/dev-tools/kunit/usage.rst - KUnit features.
+*   Documentation/dev-tools/kunit/usage.rst - write tests.
 *   Documentation/dev-tools/kunit/tips.rst - best practices with
     examples.
 *   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 63f1bb89ebf5..b321877797f0 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -1,57 +1,13 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-===========
-Using KUnit
-===========
-
-The purpose of this document is to describe what KUnit is, how it works, how it
-is intended to be used, and all the concepts and terminology that are needed to
-understand it. This guide assumes a working knowledge of the Linux kernel and
-some basic knowledge of testing.
-
-For a high level introduction to KUnit, including setting up KUnit for your
-project, see Documentation/dev-tools/kunit/start.rst.
-
-Organization of this document
-=============================
-
-This document is organized into two main sections: Testing and Common Patterns.
-The first covers what unit tests are and how to use KUnit to write them. The
-second covers common testing patterns, e.g. how to isolate code and make it
-possible to unit test code that was otherwise un-unit-testable.
-
-Testing
-=======
-
-What is KUnit?
---------------
-
-"K" is short for "kernel" so "KUnit" is the "(Linux) Kernel Unit Testing
-Framework." KUnit is intended first and foremost for writing unit tests; it is
-general enough that it can be used to write integration tests; however, this is
-a secondary goal. KUnit has no ambition of being the only testing framework for
-the kernel; for example, it does not intend to be an end-to-end testing
-framework.
-
-What is Unit Testing?
----------------------
-
-A `unit test <https://martinfowler.com/bliki/UnitTest.html>`_ is a test that
-tests code at the smallest possible scope, a *unit* of code. In the C
-programming language that's a function.
-
-Unit tests should be written for all the publicly exposed functions in a
-compilation unit; so that is all the functions that are exported in either a
-*class* (defined below) or all functions which are **not** static.
-
 Writing Tests
--------------
+=============
 
 Test Cases
-~~~~~~~~~~
+----------
 
 The fundamental unit in KUnit is the test case. A test case is a function with
-the signature ``void (*)(struct kunit *test)``. It calls a function to be tested
+the signature ``void (*)(struct kunit *test)``. It calls the function under test
 and then sets *expectations* for what should happen. For example:
 
 .. code-block:: c
@@ -65,18 +21,19 @@ and then sets *expectations* for what should happen. For example:
 		KUNIT_FAIL(test, "This test never passes.");
 	}
 
-In the above example ``example_test_success`` always passes because it does
-nothing; no expectations are set, so all expectations pass. On the other hand
-``example_test_failure`` always fails because it calls ``KUNIT_FAIL``, which is
-a special expectation that logs a message and causes the test case to fail.
+In the above example, ``example_test_success`` always passes because it does
+nothing; no expectations are set, and therefore all expectations pass. On the
+other hand ``example_test_failure`` always fails because it calls ``KUNIT_FAIL``,
+which is a special expectation that logs a message and causes the test case to
+fail.
 
 Expectations
 ~~~~~~~~~~~~
-An *expectation* is a way to specify that you expect a piece of code to do
-something in a test. An expectation is called like a function. A test is made
-by setting expectations about the behavior of a piece of code under test; when
-one or more of the expectations fail, the test case fails and information about
-the failure is logged. For example:
+An *expectation* specifies that we expect a piece of code to do something in a
+test. An expectation is called like a function. A test is made by setting
+expectations about the behavior of a piece of code under test. When one or more
+expectations fail, the test case fails and information about the failure is
+logged. For example:
 
 .. code-block:: c
 
@@ -86,29 +43,28 @@ the failure is logged. For example:
 		KUNIT_EXPECT_EQ(test, 2, add(1, 1));
 	}
 
-In the above example ``add_test_basic`` makes a number of assertions about the
-behavior of a function called ``add``; the first parameter is always of type
-``struct kunit *``, which contains information about the current test context;
-the second parameter, in this case, is what the value is expected to be; the
+In the above example, ``add_test_basic`` makes a number of assertions about the
+behavior of a function called ``add``. The first parameter is always of type
+``struct kunit *``, which contains information about the current test context.
+The second parameter, in this case, is what the value is expected to be. The
 last value is what the value actually is. If ``add`` passes all of these
 expectations, the test case, ``add_test_basic`` will pass; if any one of these
 expectations fails, the test case will fail.
 
-It is important to understand that a test case *fails* when any expectation is
-violated; however, the test will continue running, potentially trying other
-expectations until the test case ends or is otherwise terminated. This is as
-opposed to *assertions* which are discussed later.
+A test case *fails* when any expectation is violated; however, the test will
+continue to run, and try other expectations until the test case ends or is
+otherwise terminated. This is as opposed to *assertions* which are discussed
+later.
 
-To learn about more expectations supported by KUnit, see
-Documentation/dev-tools/kunit/api/test.rst.
+To learn about more KUnit expectations, see Documentation/dev-tools/kunit/api/test.rst.
 
 .. note::
-   A single test case should be pretty short, pretty easy to understand,
-   focused on a single behavior.
+   A single test case should be short, easy to understand, and focused on a
+   single behavior.
 
-For example, if we wanted to properly test the add function above, we would
-create additional tests cases which would each test a different property that an
-add function should have like this:
+For example, if we want to rigorously test the ``add`` function above, create
+additional tests cases which would test each property that an ``add`` function
+should have as shown below:
 
 .. code-block:: c
 
@@ -134,56 +90,43 @@ add function should have like this:
 		KUNIT_EXPECT_EQ(test, INT_MIN, add(INT_MAX, 1));
 	}
 
-Notice how it is immediately obvious what all the properties that we are testing
-for are.
-
 Assertions
 ~~~~~~~~~~
 
-KUnit also has the concept of an *assertion*. An assertion is just like an
-expectation except the assertion immediately terminates the test case if it is
-not satisfied.
-
-For example:
+An assertion is like an expectation, except that the assertion immediately
+terminates the test case if the condition is not satisfied. For example:
 
 .. code-block:: c
 
-	static void mock_test_do_expect_default_return(struct kunit *test)
+	static void test_sort(struct kunit *test)
 	{
-		struct mock_test_context *ctx = test->priv;
-		struct mock *mock = ctx->mock;
-		int param0 = 5, param1 = -5;
-		const char *two_param_types[] = {"int", "int"};
-		const void *two_params[] = {&param0, &param1};
-		const void *ret;
-
-		ret = mock->do_expect(mock,
-				      "test_printk", test_printk,
-				      two_param_types, two_params,
-				      ARRAY_SIZE(two_params));
-		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
-		KUNIT_EXPECT_EQ(test, -4, *((int *) ret));
+		int *a, i, r = 1;
+		a = kunit_kmalloc_array(test, TEST_LEN, sizeof(*a), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a);
+		for (i = 0; i < TEST_LEN; i++) {
+			r = (r * 725861) % 6599;
+			a[i] = r;
+		}
+		sort(a, TEST_LEN, sizeof(*a), cmpint, NULL);
+		for (i = 0; i < TEST_LEN-1; i++)
+			KUNIT_EXPECT_LE(test, a[i], a[i + 1]);
 	}
 
-In this example, the method under test should return a pointer to a value, so
-if the pointer returned by the method is null or an errno, we don't want to
-bother continuing the test since the following expectation could crash the test
-case. `ASSERT_NOT_ERR_OR_NULL(...)` allows us to bail out of the test case if
-the appropriate conditions have not been satisfied to complete the test.
+In this example, the method under test should return pointer to a value. If the
+pointer returns null or an errno, we want to stop the test since the following
+expectation could crash the test case. `ASSERT_NOT_ERR_OR_NULL(...)` allows us
+to bail out of the test case if the appropriate conditions are not satisfied to
+complete the test.
 
 Test Suites
 ~~~~~~~~~~~
 
-Now obviously one unit test isn't very helpful; the power comes from having
-many test cases covering all of a unit's behaviors. Consequently it is common
-to have many *similar* tests; in order to reduce duplication in these closely
-related tests most unit testing frameworks - including KUnit - provide the
-concept of a *test suite*. A *test suite* is just a collection of test cases
-for a unit of code with a set up function that gets invoked before every test
-case and then a tear down function that gets invoked after every test case
-completes.
-
-Example:
+We need many test cases covering all the unit's behaviors. It is common to have
+many similar tests. In order to reduce duplication in these closely related
+tests, most unit testing frameworks (including KUnit) provide the concept of a
+*test suite*. A test suite is a collection of test cases for a unit of code
+with a setup function that gets invoked before every test case and then a tear
+down function that gets invoked after every test case completes. For example:
 
 .. code-block:: c
 
@@ -202,23 +145,48 @@ Example:
 	};
 	kunit_test_suite(example_test_suite);
 
-In the above example the test suite, ``example_test_suite``, would run the test
-cases ``example_test_foo``, ``example_test_bar``, and ``example_test_baz``;
-each would have ``example_test_init`` called immediately before it and would
-have ``example_test_exit`` called immediately after it.
+In the above example, the test suite ``example_test_suite`` would run the test
+cases ``example_test_foo``, ``example_test_bar``, and ``example_test_baz``. Each
+would have ``example_test_init`` called immediately before it and
+``example_test_exit`` called immediately after it.
 ``kunit_test_suite(example_test_suite)`` registers the test suite with the
 KUnit test framework.
 
 .. note::
-   A test case will only be run if it is associated with a test suite.
+   A test case will only run if it is associated with a test suite.
 
-``kunit_test_suite(...)`` is a macro which tells the linker to put the specified
-test suite in a special linker section so that it can be run by KUnit either
-after late_init, or when the test module is loaded (depending on whether the
-test was built in or not).
+``kunit_test_suite(...)`` is a macro which tells the linker to put the
+specified test suite in a special linker section so that it can be run by KUnit
+either after ``late_init``, or when the test module is loaded (if the test was
+built as a module).
 
-For more information on these types of things see the
-Documentation/dev-tools/kunit/api/test.rst.
+For more information, see Documentation/dev-tools/kunit/api/test.rst.
+
+Writing Tests For Other Architectures
+-------------------------------------
+
+Always prefer tests that run on UML to tests that only run under a particular
+architecture. In addition, prefer tests that run under QEMU or another easy
+(and monetarily free) to obtain software environment to a specific piece of
+hardware.
+
+Nevertheless, there are still valid reasons to write an architecture or
+hardware specific test. For example, we might want to test code that really
+belongs in ``arch/some-arch/*``. Even so, try to write the test so that it does
+not depend on physical hardware. Some of our test cases may not need hardware,
+only few tests actually require the hardware to test it. When hardware is not
+available, instead of disabling tests, we can skip them.
+
+Now that we have narrowed down exactly what bits are hardware specific, the
+actual procedure for writing and running the tests is same as writing normal
+KUnit tests.
+
+.. important::
+   We may have to reset hardware state. If this is not possible, we may only
+   be able to run one test case per invocation.
+
+.. TODO(brendanhiggins@google.com): Add an actual example of an architecture-
+   dependent KUnit test.
 
 Common Patterns
 ===============
@@ -226,43 +194,39 @@ Common Patterns
 Isolating Behavior
 ------------------
 
-The most important aspect of unit testing that other forms of testing do not
-provide is the ability to limit the amount of code under test to a single unit.
-In practice, this is only possible by being able to control what code gets run
-when the unit under test calls a function and this is usually accomplished
-through some sort of indirection where a function is exposed as part of an API
-such that the definition of that function can be changed without affecting the
-rest of the code base. In the kernel this primarily comes from two constructs,
-classes, structs that contain function pointers that are provided by the
-implementer, and architecture-specific functions which have definitions selected
-at compile time.
+Unit testing limits the amount of code under test to a single unit. It controls
+what code gets run when the unit under test calls a function. Where a function
+is exposed as part of an API such that the definition of that function can be
+changed without affecting the rest of the code base. In the kernel, this comes
+from two constructs: classes, structs. that contain function pointers provided
+by the implementer and architecture specific functions which have definitions
+selected at compile time.
 
 Classes
 ~~~~~~~
 
 Classes are not a construct that is built into the C programming language;
-however, it is an easily derived concept. Accordingly, pretty much every project
-that does not use a standardized object oriented library (like GNOME's GObject)
-has their own slightly different way of doing object oriented programming; the
-Linux kernel is no exception.
+however, it is an easily derived concept. Accordingly, in most cases, every
+project that does not use a standardized object oriented library (like GNOME's
+GObject) has their own slightly different way of doing object oriented
+programming; the Linux kernel is no exception.
 
 The central concept in kernel object oriented programming is the class. In the
 kernel, a *class* is a struct that contains function pointers. This creates a
 contract between *implementers* and *users* since it forces them to use the
-same function signature without having to call the function directly. In order
-for it to truly be a class, the function pointers must specify that a pointer
-to the class, known as a *class handle*, be one of the parameters; this makes
-it possible for the member functions (also known as *methods*) to have access
-to member variables (more commonly known as *fields*) allowing the same
-implementation to have multiple *instances*.
-
-Typically a class can be *overridden* by *child classes* by embedding the
-*parent class* in the child class. Then when a method provided by the child
-class is called, the child implementation knows that the pointer passed to it is
-of a parent contained within the child; because of this, the child can compute
-the pointer to itself because the pointer to the parent is always a fixed offset
-from the pointer to the child; this offset is the offset of the parent contained
-in the child struct. For example:
+same function signature without having to call the function directly. To be a
+class, the function pointers must specify that a pointer to the class, known as
+a *class handle*, be one of the parameters. Thus the member functions (also
+known as *methods*) have access to member variables (also known as *fields*)
+allowing the same implementation to have multiple *instances*.
+
+A class can be *overridden* by *child classes* by embedding the *parent class*
+in the child class. Then when the child class *method* is called, the child
+implementation knows that the pointer passed to it is of a parent contained
+within the child. Thus, the child can compute the pointer to itself because the
+pointer to the parent is always a fixed offset from the pointer to the child.
+This offset is the offset of the parent contained in the child struct. For
+example:
 
 .. code-block:: c
 
@@ -290,8 +254,8 @@ in the child struct. For example:
 		self->width = width;
 	}
 
-In this example (as in most kernel code) the operation of computing the pointer
-to the child from the pointer to the parent is done by ``container_of``.
+In this example, computing the pointer to the child from the pointer to the
+parent is done by ``container_of``.
 
 Faking Classes
 ~~~~~~~~~~~~~~
@@ -300,14 +264,11 @@ In order to unit test a piece of code that calls a method in a class, the
 behavior of the method must be controllable, otherwise the test ceases to be a
 unit test and becomes an integration test.
 
-A fake just provides an implementation of a piece of code that is different than
-what runs in a production instance, but behaves identically from the standpoint
-of the callers; this is usually done to replace a dependency that is hard to
-deal with, or is slow.
-
-A good example for this might be implementing a fake EEPROM that just stores the
-"contents" in an internal buffer. For example, let's assume we have a class that
-represents an EEPROM:
+A fake class implements a piece of code that is different than what runs in a
+production instance, but behaves identical from the standpoint of the callers.
+This is done to replace a dependency that is hard to deal with, or is slow. For
+example, implementing a fake EEPROM that stores the "contents" in an
+internal buffer. Assume we have a class that represents an EEPROM:
 
 .. code-block:: c
 
@@ -316,7 +277,7 @@ represents an EEPROM:
 		ssize_t (*write)(struct eeprom *this, size_t offset, const char *buffer, size_t count);
 	};
 
-And we want to test some code that buffers writes to the EEPROM:
+We want to test code that buffers writes to the EEPROM:
 
 .. code-block:: c
 
@@ -329,7 +290,7 @@ And we want to test some code that buffers writes to the EEPROM:
 	struct eeprom_buffer *new_eeprom_buffer(struct eeprom *eeprom);
 	void destroy_eeprom_buffer(struct eeprom *eeprom);
 
-We can easily test this code by *faking out* the underlying EEPROM:
+We can test this code by *faking out* the underlying EEPROM:
 
 .. code-block:: c
 
@@ -456,14 +417,14 @@ We can now use it to test ``struct eeprom_buffer``:
 		destroy_eeprom_buffer(ctx->eeprom_buffer);
 	}
 
-Testing against multiple inputs
+Testing Against Multiple Inputs
 -------------------------------
 
-Testing just a few inputs might not be enough to have confidence that the code
-works correctly, e.g. for a hash function.
+Testing just a few inputs is not enough to ensure that the code works correctly,
+for example: testing a hash function.
 
-In such cases, it can be helpful to have a helper macro or function, e.g. this
-fictitious example for ``sha1sum(1)``
+We can write a helper macro or function. The function is called for each input.
+For example, to test ``sha1sum(1)``, we can write:
 
 .. code-block:: c
 
@@ -475,16 +436,15 @@ fictitious example for ``sha1sum(1)``
 	TEST_SHA1("hello world",  "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed");
 	TEST_SHA1("hello world!", "430ce34d020724ed75a196dfc2ad67c77772d169");
 
+Note the use of the ``_MSG`` version of ``KUNIT_EXPECT_STREQ`` to print a more
+detailed error and make the assertions clearer within the helper macros.
 
-Note the use of ``KUNIT_EXPECT_STREQ_MSG`` to give more context when it fails
-and make it easier to track down. (Yes, in this example, ``want`` is likely
-going to be unique enough on its own).
+The ``_MSG`` variants are useful when the same expectation is called multiple
+times (in a loop or helper function) and thus the line number is not enough to
+identify what failed, as shown below.
 
-The ``_MSG`` variants are even more useful when the same expectation is called
-multiple times (in a loop or helper function) and thus the line number isn't
-enough to identify what failed, like below.
-
-In some cases, it can be helpful to write a *table-driven test* instead, e.g.
+In complicated cases, we recommend using a *table-driven test* compared to the
+helper macro variation, for example:
 
 .. code-block:: c
 
@@ -513,17 +473,18 @@ In some cases, it can be helpful to write a *table-driven test* instead, e.g.
 	}
 
 
-There's more boilerplate involved, but it can:
+There is more boilerplate code involved, but it can:
+
+* be more readable when there are multiple inputs/outputs (due to field names).
 
-* be more readable when there are multiple inputs/outputs thanks to field names,
+  * For example, see ``fs/ext4/inode-test.c``.
 
-  * E.g. see ``fs/ext4/inode-test.c`` for an example of both.
-* reduce duplication if test cases can be shared across multiple tests.
+* reduce duplication if test cases are shared across multiple tests.
 
-  * E.g. if we wanted to also test ``sha256sum``, we could add a ``sha256``
+  * For example: if we want to test ``sha256sum``, we could add a ``sha256``
     field and reuse ``cases``.
 
-* be converted to a "parameterized test", see below.
+* be converted to a "parameterized test".
 
 Parameterized Testing
 ~~~~~~~~~~~~~~~~~~~~~
@@ -531,7 +492,7 @@ Parameterized Testing
 The table-driven testing pattern is common enough that KUnit has special
 support for it.
 
-Reusing the same ``cases`` array from above, we can write the test as a
+By reusing the same ``cases`` array from above, we can write the test as a
 "parameterized test" with the following.
 
 .. code-block:: c
@@ -582,193 +543,152 @@ Reusing the same ``cases`` array from above, we can write the test as a
 
 .. _kunit-on-non-uml:
 
-KUnit on non-UML architectures
-==============================
-
-By default KUnit uses UML as a way to provide dependencies for code under test.
-Under most circumstances KUnit's usage of UML should be treated as an
-implementation detail of how KUnit works under the hood. Nevertheless, there
-are instances where being able to run architecture-specific code or test
-against real hardware is desirable. For these reasons KUnit supports running on
-other architectures.
-
-Running existing KUnit tests on non-UML architectures
------------------------------------------------------
+Exiting Early on Failed Expectations
+------------------------------------
 
-There are some special considerations when running existing KUnit tests on
-non-UML architectures:
+We can use ``KUNIT_EXPECT_EQ`` to mark the test as failed and continue
+execution.  In some cases, it is unsafe to continue. We can use the
+``KUNIT_ASSERT`` variant to exit on failure.
 
-*   Hardware may not be deterministic, so a test that always passes or fails
-    when run under UML may not always do so on real hardware.
-*   Hardware and VM environments may not be hermetic. KUnit tries its best to
-    provide a hermetic environment to run tests; however, it cannot manage state
-    that it doesn't know about outside of the kernel. Consequently, tests that
-    may be hermetic on UML may not be hermetic on other architectures.
-*   Some features and tooling may not be supported outside of UML.
-*   Hardware and VMs are slower than UML.
+.. code-block:: c
 
-None of these are reasons not to run your KUnit tests on real hardware; they are
-only things to be aware of when doing so.
+	void example_test_user_alloc_function(struct kunit *test)
+	{
+		void *object = alloc_some_object_for_me();
 
-Currently, the KUnit Wrapper (``tools/testing/kunit/kunit.py``) (aka
-kunit_tool) only fully supports running tests inside of UML and QEMU; however,
-this is only due to our own time limitations as humans working on KUnit. It is
-entirely possible to support other emulators and even actual hardware, but for
-now QEMU and UML is what is fully supported within the KUnit Wrapper. Again, to
-be clear, this is just the Wrapper. The actualy KUnit tests and the KUnit
-library they are written in is fully architecture agnostic and can be used in
-virtually any setup, you just won't have the benefit of typing a single command
-out of the box and having everything magically work perfectly.
+		/* Make sure we got a valid pointer back. */
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, object);
+		do_something_with_object(object);
+	}
 
-Again, all core KUnit framework features are fully supported on all
-architectures, and using them is straightforward: Most popular architectures
-are supported directly in the KUnit Wrapper via QEMU. Currently, supported
-architectures on QEMU include:
+Allocating Memory
+-----------------
 
-*   i386
-*   x86_64
-*   arm
-*   arm64
-*   alpha
-*   powerpc
-*   riscv
-*   s390
-*   sparc
+We can use ``kzalloc``, you should prefer ``kunit_kzalloc`` and KUnit will
+ensure that the memory is freed once the test completes.
 
-In order to run KUnit tests on one of these architectures via QEMU with the
-KUnit wrapper, all you need to do is specify the flags ``--arch`` and
-``--cross_compile`` when invoking the KUnit Wrapper. For example, we could run
-the default KUnit tests on ARM in the following manner (assuming we have an ARM
-toolchain installed):
+This is useful because it lets us use the ``KUNIT_ASSERT_EQ`` macros to exit
+early from a test without having to worry about remembering to call ``kfree``.
+For example:
 
-.. code-block:: bash
+.. code-block:: c
 
-	tools/testing/kunit/kunit.py run --timeout=60 --jobs=12 --arch=arm --cross_compile=arm-linux-gnueabihf-
+	void example_test_allocation(struct kunit *test)
+	{
+		char *buffer = kunit_kzalloc(test, 16, GFP_KERNEL);
+		/* Ensure allocation succeeded. */
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 
-Alternatively, if you want to run your tests on real hardware or in some other
-emulation environment, all you need to do is to take your kunitconfig, your
-Kconfig options for the tests you would like to run, and merge them into
-whatever config your are using for your platform. That's it!
+		KUNIT_ASSERT_STREQ(test, buffer, "");
+	}
 
-For example, let's say you have the following kunitconfig:
 
-.. code-block:: none
+Testing Static Functions
+------------------------
 
-	CONFIG_KUNIT=y
-	CONFIG_KUNIT_EXAMPLE_TEST=y
+If we do not want to expose functions or variables for testing, one option is to
+conditionally ``#include`` the test file at the end of your .c file. For
+example:
 
-If you wanted to run this test on an x86 VM, you might add the following config
-options to your ``.config``:
+.. code-block:: c
 
-.. code-block:: none
+	/* In my_file.c */
 
-	CONFIG_KUNIT=y
-	CONFIG_KUNIT_EXAMPLE_TEST=y
-	CONFIG_SERIAL_8250=y
-	CONFIG_SERIAL_8250_CONSOLE=y
+	static int do_interesting_thing();
 
-All these new options do is enable support for a common serial console needed
-for logging.
+	#ifdef CONFIG_MY_KUNIT_TEST
+	#include "my_kunit_test.c"
+	#endif
 
-Next, you could build a kernel with these tests as follows:
+Injecting Test-Only Code
+------------------------
 
+Similar to as shown above, we can add test-specific logic. For example:
 
-.. code-block:: bash
+.. code-block:: c
 
-	make ARCH=x86 olddefconfig
-	make ARCH=x86
+	/* In my_file.h */
 
-Once you have built a kernel, you could run it on QEMU as follows:
+	#ifdef CONFIG_MY_KUNIT_TEST
+	/* Defined in my_kunit_test.c */
+	void test_only_hook(void);
+	#else
+	void test_only_hook(void) { }
+	#endif
 
-.. code-block:: bash
+This test-only code can be made more useful by accessing the current ``kunit_test``
+as shown in next section: *Accessing The Current Test*.
 
-	qemu-system-x86_64 -enable-kvm \
-			   -m 1024 \
-			   -kernel arch/x86_64/boot/bzImage \
-			   -append 'console=ttyS0' \
-			   --nographic
+Accessing The Current Test
+--------------------------
 
-Interspersed in the kernel logs you might see the following:
+In some cases, we need to call test-only code from outside the test file.
+For example, see example in section *Injecting Test-Only Code* or if
+we are providing a fake implementation of an ops struct. Using
+``kunit_test`` field in ``task_struct``, we can access it via
+``current->kunit_test``.
 
-.. code-block:: none
+Below example includes how to implement "mocking":
 
-	TAP version 14
-		# Subtest: example
-		1..1
-		# example_simple_test: initializing
-		ok 1 - example_simple_test
-	ok 1 - example
+.. code-block:: c
 
-Congratulations, you just ran a KUnit test on the x86 architecture!
+	#include <linux/sched.h> /* for current */
 
-In a similar manner, kunit and kunit tests can also be built as modules,
-so if you wanted to run tests in this way you might add the following config
-options to your ``.config``:
+	struct test_data {
+		int foo_result;
+		int want_foo_called_with;
+	};
 
-.. code-block:: none
+	static int fake_foo(int arg)
+	{
+		struct kunit *test = current->kunit_test;
+		struct test_data *test_data = test->priv;
 
-	CONFIG_KUNIT=m
-	CONFIG_KUNIT_EXAMPLE_TEST=m
+		KUNIT_EXPECT_EQ(test, test_data->want_foo_called_with, arg);
+		return test_data->foo_result;
+	}
 
-Once the kernel is built and installed, a simple
+	static void example_simple_test(struct kunit *test)
+	{
+		/* Assume priv is allocated in the suite's .init */
+		struct test_data *test_data = test->priv;
 
-.. code-block:: bash
+		test_data->foo_result = 42;
+		test_data->want_foo_called_with = 1;
 
-	modprobe example-test
+		/* In a real test, we'd probably pass a pointer to fake_foo somewhere
+		 * like an ops struct, etc. instead of calling it directly. */
+		KUNIT_EXPECT_EQ(test, fake_foo(1), 42);
+	}
 
-...will run the tests.
 
-.. note::
-   Note that you should make sure your test depends on ``KUNIT=y`` in Kconfig
-   if the test does not support module build.  Otherwise, it will trigger
-   compile errors if ``CONFIG_KUNIT`` is ``m``.
+Note: here we are able to get away with using ``test->priv``, but if we want
+something more flexible we could use a named ``kunit_resource``, see
+Documentation/dev-tools/kunit/api/test.rst.
 
-Writing new tests for other architectures
------------------------------------------
+Failing The Current Test
+------------------------
 
-The first thing you must do is ask yourself whether it is necessary to write a
-KUnit test for a specific architecture, and then whether it is necessary to
-write that test for a particular piece of hardware. In general, writing a test
-that depends on having access to a particular piece of hardware or software (not
-included in the Linux source repo) should be avoided at all costs.
+If we want to fail the current test, we can use ``kunit_fail_current_test(fmt, args...)``
+which is defined in ``<kunit/test-bug.h>`` and does not require pulling in ``<kunit/test.h>``.
+For example, we have an option to enable some extra debug checks on some data
+structures as shown below:
 
-Even if you only ever plan on running your KUnit test on your hardware
-configuration, other people may want to run your tests and may not have access
-to your hardware. If you write your test to run on UML, then anyone can run your
-tests without knowing anything about your particular setup, and you can still
-run your tests on your hardware setup just by compiling for your architecture.
+.. code-block:: c
 
-.. important::
-   Always prefer tests that run on UML to tests that only run under a particular
-   architecture, and always prefer tests that run under QEMU or another easy
-   (and monetarily free) to obtain software environment to a specific piece of
-   hardware.
-
-Nevertheless, there are still valid reasons to write an architecture or hardware
-specific test: for example, you might want to test some code that really belongs
-in ``arch/some-arch/*``. Even so, try your best to write the test so that it
-does not depend on physical hardware: if some of your test cases don't need the
-hardware, only require the hardware for tests that actually need it.
-
-Now that you have narrowed down exactly what bits are hardware specific, the
-actual procedure for writing and running the tests is pretty much the same as
-writing normal KUnit tests. One special caveat is that you have to reset
-hardware state in between test cases; if this is not possible, you may only be
-able to run one test case per invocation.
+	#include <kunit/test-bug.h>
 
-.. TODO(brendanhiggins@google.com): Add an actual example of an architecture-
-   dependent KUnit test.
+	#ifdef CONFIG_EXTRA_DEBUG_CHECKS
+	static void validate_my_data(struct data *data)
+	{
+		if (is_valid(data))
+			return;
 
-KUnit debugfs representation
-============================
-When kunit test suites are initialized, they create an associated directory
-in ``/sys/kernel/debug/kunit/<test-suite>``.  The directory contains one file
+		kunit_fail_current_test("data %p is invalid", data);
 
-- results: "cat results" displays results of each test case and the results
-  of the entire suite for the last test run.
+		/* Normal, non-KUnit, error reporting code here. */
+	}
+	#else
+	static void my_debug_function(void) { }
+	#endif
 
-The debugfs representation is primarily of use when kunit test suites are
-run in a native environment, either as modules or builtin.  Having a way
-to display results like this is valuable as otherwise results can be
-intermixed with other events in dmesg output.  The maximum size of each
-results file is KUNIT_LOG_SIZE bytes (defined in ``include/kunit/test.h``).
-- 
2.34.1.400.ga245620fadb-goog

