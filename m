Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7284E609318
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Oct 2022 14:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiJWM4Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Oct 2022 08:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiJWMzz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Oct 2022 08:55:55 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024C35926A;
        Sun, 23 Oct 2022 05:55:43 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q71so6532998pgq.8;
        Sun, 23 Oct 2022 05:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6vwtBgk1QR+Bc4S86nB20t7mIV4s/vDKmFGd1CmmDU=;
        b=kHn1W714Xzr/vtBCCFUq0WBZxVmrVcf4dPWQJoxAMiC04ZGcMieo2FrC5rfZOrVYz4
         oanp3gIJQeVsH3axIiiGlzOUnceFabBpBjfmA+RPU2eCJW3nz/W9glyDka4JMU0YqcTW
         BmBW1pm0HzmifRvyxhqUXVn6LuXSQs05gw5iwNPeOj9e32LyKgW8NUNggrlwIFV8UAxL
         L6nWKALz/aRHyNS7DDgRRj7E5P90cdLPshnAspHmm9tBB6+p6AJoHOOjRw+MLvk5oDKW
         NfLqxQlOU21RSpP6VBUumjg+xr+pe3dAB+a+uQ8Y+s5qIlOWZ4PX9wW5/ZuGPdNSfyZV
         mhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6vwtBgk1QR+Bc4S86nB20t7mIV4s/vDKmFGd1CmmDU=;
        b=TuDV7WMtp1g4F7eUFKMEiVH3fOIiQLGjh7I8C0r9x2A8944yfOFhq+2ilQ6j7Y56y7
         MkXApvTr66O/uLZfQfCKFpsJtZiC/HuNnbaX7U9tpcfnYB6zAYPI0bSCgy5FPp6zfv/C
         xm9mFlewtSK/MfgT+sMOB+xMrhiVuwgK7KeXfnlq5GyuaaV6bLq1o3Qd7osmhJC5/Ghj
         qyem7Gxvp4V7HLecAwpoeNOES3T3jvbxri5kFGQFS/ZuBkfwFGdUsogyoynptbpcMI8O
         5OpkOGL8wK1C0UcLrXXcgg514hxXIbego10dMbAG/xlsrao95FGx0L+VhcbdESlj5TUD
         /UAg==
X-Gm-Message-State: ACrzQf1zKRWgZpmaWi1joYSFuu8Qz9ErvVFkPjfNIMk4xPK8kn6WrOno
        Dp61L80lAEXM9mr0MAiegeUO4SV3sDZdQQ==
X-Google-Smtp-Source: AMsMyM4uO0IdVXYOy1WLfEvKbk+bybxbD0GLAXz3vo0E5dv8HZ9RfQ4b/6hqKpyEVahjHjqgvaybXg==
X-Received: by 2002:a63:6cc3:0:b0:43c:7585:1ec with SMTP id h186-20020a636cc3000000b0043c758501ecmr24240336pgc.571.1666529742597;
        Sun, 23 Oct 2022 05:55:42 -0700 (PDT)
Received: from debian.. (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id om10-20020a17090b3a8a00b00212daa68b7csm2670639pjb.44.2022.10.23.05.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 05:55:42 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 7/7] Documentation: kunit: rewrite usage
Date:   Sun, 23 Oct 2022 19:54:14 +0700
Message-Id: <20221023125414.60961-8-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221023125414.60961-1-bagasdotme@gmail.com>
References: <20221023125414.60961-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=27186; i=bagasdotme@gmail.com; h=from:subject; bh=ZBMrD2zTAwPNW4BI+VkpvBw6PlGVuQCho52Kn8PDVZU=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmhlnkV9WX7db9m2RybzTZFwerLznrOovlmV6/xyq+7s3Ol itvKjlIWBjEOBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEyEuZKRoUdq1XzhjzenTdNZe12J6/ FUs/Wsk3V3Ze/Mzdy+m2VTkyojw+6YE6nvBSenuV+/K3La1EnUdt+ONxobFns+sNqisf7yFA4A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rewrite the documentation for clarity. Major points:

  * Switch to third person point of view
  * Briefly describe code examples before giving them out
  * Use "base" and "derived" terminology on class inheritance

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/dev-tools/kunit/usage.rst | 322 +++++++++++++-----------
 1 file changed, 173 insertions(+), 149 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 2737863ef36532..e529da3fd1d32b 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -6,9 +6,11 @@ Writing Tests
 Test Cases
 ----------
 
-The fundamental unit in KUnit is the test case. A test case is a function with
-the signature ``void (*)(struct kunit *test)``. It calls the function under test
-and then sets *expectations* for what should happen. For example:
+The fundamental unit in KUnit is the test case. A test case in KUnit is a
+function with the signature ``void (*)(struct kunit *test)``. It calls the
+function under test and then sets *expectations* for what should happen.
+
+Below are the simplest examples:
 
 .. code-block:: c
 
@@ -22,18 +24,17 @@ and then sets *expectations* for what should happen. For example:
 	}
 
 In the above example, ``example_test_success`` always passes because it does
-nothing; no expectations are set, and therefore all expectations pass. On the
-other hand ``example_test_failure`` always fails because it calls ``KUNIT_FAIL``,
-which is a special expectation that logs a message and causes the test case to
-fail.
+nothing (there are no expectations set). On the
+other hand ``example_test_failure`` always fails because it calls
+``KUNIT_FAIL``, which is a special function that logs the message string and
+signal the test as failed.
 
 Expectations
 ~~~~~~~~~~~~
-An *expectation* specifies that we expect a piece of code to do something in a
-test. An expectation is called like a function. A test is made by setting
-expectations about the behavior of a piece of code under test. When one or more
-expectations fail, the test case fails and information about the failure is
-logged. For example:
+An *expectation* specifies the expected behavior of tested function. It is
+written as regular function call. A test is made by asserting one or more
+expectations in the test case. When any of these is not satisfied, the test
+case fails and information about the failure is logged. For example:
 
 .. code-block:: c
 
@@ -43,18 +44,16 @@ logged. For example:
 		KUNIT_EXPECT_EQ(test, 2, add(1, 1));
 	}
 
-In the above example, ``add_test_basic`` makes a number of assertions about the
-behavior of a function called ``add``. The first parameter is always of type
+In the above example, ``add_test_basic`` tests a function called ``add()``.
+The first parameter to ``KUNIT_EXPECT_EQ`` is always of type
 ``struct kunit *``, which contains information about the current test context.
-The second parameter, in this case, is what the value is expected to be. The
-last value is what the value actually is. If ``add`` passes all of these
-expectations, the test case, ``add_test_basic`` will pass; if any one of these
-expectations fails, the test case will fail.
+The second parameter is what the value is expected to be returned by the
+function. The last is value returned by calling the tested function.
 
-A test case *fails* when any expectation is violated; however, the test will
-continue to run, and try other expectations until the test case ends or is
-otherwise terminated. This is as opposed to *assertions* which are discussed
-later.
+Even though a single expectation is not satisfied, the test will
+continue to run and try asserting the following expectations until either
+the test case ends or is terminated. This is as opposed to *assertions* which
+are discussed later.
 
 To learn about more KUnit expectations, see Documentation/dev-tools/kunit/api/test.rst.
 
@@ -62,9 +61,8 @@ To learn about more KUnit expectations, see Documentation/dev-tools/kunit/api/te
    A single test case should be short, easy to understand, and focused on a
    single behavior.
 
-For example, if we want to rigorously test the ``add`` function above, create
-additional tests cases which would test each property that an ``add`` function
-should have as shown below:
+The example below extends ``add()`` tests with cases for negative values
+and edge cases involving ``INT_MIN`` and ``INT_MAX`` constants:
 
 .. code-block:: c
 
@@ -93,8 +91,10 @@ should have as shown below:
 Assertions
 ~~~~~~~~~~
 
-An assertion is like an expectation, except that the assertion immediately
-terminates the test case if the condition is not satisfied. For example:
+An assertion is like an expectation, except that it immediately
+terminates the test case if the condition is false.
+
+The following example demonstrate testing ``sort()`` function:
 
 .. code-block:: c
 
@@ -112,21 +112,22 @@ terminates the test case if the condition is not satisfied. For example:
 			KUNIT_EXPECT_LE(test, a[i], a[i + 1]);
 	}
 
-In this example, the method under test should return pointer to a value. If the
-pointer returns null or an errno, we want to stop the test since the following
-expectation could crash the test case. `ASSERT_NOT_ERR_OR_NULL(...)` allows us
-to bail out of the test case if the appropriate conditions are not satisfied to
-complete the test.
+In this example, the method under test should return pointer to a value. If
+it instead returns null pointer or errno, the test case should be bailed out
+with ``KUNIT_ASSERT_NOT_ERR_OR_NULL()`` since the following expectation that
+asserts the array order could crash it.
 
 Test Suites
 ~~~~~~~~~~~
 
-We need many test cases covering all the unit's behaviors. It is common to have
-many similar tests. In order to reduce duplication in these closely related
-tests, most unit testing frameworks (including KUnit) provide the concept of a
-*test suite*. A test suite is a collection of test cases for a unit of code
-with optional setup and teardown functions that run before/after the whole
-suite and/or every test case. For example:
+It is common to have many similar tests cases in order to test the code
+behavior. In order to reduce duplication in these closely related
+tests, most unit testing frameworks (including KUnit) provide the *test suite*
+concept. A test suite is a collection of test cases for a particularcode
+with optional setup and cleanup functions that run before/after the whole
+suite and/or every test case.
+
+Below is an example of writing a test suite:
 
 .. code-block:: c
 
@@ -147,21 +148,21 @@ suite and/or every test case. For example:
 	};
 	kunit_test_suite(example_test_suite);
 
-In the above example, the test suite ``example_test_suite`` would first run
-``example_suite_init``, then run the test cases ``example_test_foo``,
-``example_test_bar``, and ``example_test_baz``. Each would have
-``example_test_init`` called immediately before it and ``example_test_exit``
-called immediately after it. Finally, ``example_suite_exit`` would be called
-after everything else. ``kunit_test_suite(example_test_suite)`` registers the
-test suite with the KUnit test framework.
+In the above example, running ``example_test_suite`` will initialize the
+suite with ``example_suite_init``, then run three cases ``example_test_foo``,
+``example_test_bar``, and ``example_test_baz``. Each case will be initialized
+with ``example_test_init`` and ``example_test_exit`` will take care of
+case-specific cleanup after the case have been finished. Finally,
+``example_suite_exit`` will do suite-wide cleanup, then finish the suite.
+``kunit_test_suite(example_test_suite)`` registers the test suite with KUnit.
 
 .. note::
    A test case will only run if it is associated with a test suite.
 
-``kunit_test_suite(...)`` is a macro which tells the linker to put the
-specified test suite in a special linker section so that it can be run by KUnit
-either after ``late_init``, or when the test module is loaded (if the test was
-built as a module).
+``kunit_test_suite()`` is a macro which tells the linker to put the specified
+test suite in a special linker section so that it can be run either after
+``late_init``, or when the test module is loaded (if the test was built as
+module).
 
 For more information, see Documentation/dev-tools/kunit/api/test.rst.
 
@@ -170,25 +171,23 @@ For more information, see Documentation/dev-tools/kunit/api/test.rst.
 Writing Tests For Other Architectures
 -------------------------------------
 
-It is better to write tests that run on UML to tests that only run under a
-particular architecture. It is better to write tests that run under QEMU or
-another easy to obtain (and monetarily free) software environment to a specific
-piece of hardware.
+In many cases, it is better to write tests that can be run on UML or QEMU
+without requiring any specific architecture or hardware, since these can
+be practically run by any machine that is capable of cross-compiling.
 
-Nevertheless, there are still valid reasons to write a test that is architecture
-or hardware specific. For example, we might want to test code that really
-belongs in ``arch/some-arch/*``. Even so, try to write the test so that it does
-not depend on physical hardware. Some of our test cases may not need hardware,
-only few tests actually require the hardware to test it. When hardware is not
-available, instead of disabling tests, we can skip them.
+Nevertheless, there are still valid reasons to write architecture-specific
+or hardware-specific tests. For example, you might want to test codes that
+are in ``arch/some-arch/*``. Even so, try to write tests so that it does
+not require specific hardware to run them. A test suite may contain
+hardware-specific cases. These can be skipped if the hardware is not
+available.
 
-Now that we have narrowed down exactly what bits are hardware specific, the
-actual procedure for writing and running the tests is same as writing normal
-KUnit tests.
+Writing architecture-specific and hardware-specific tests is the same as
+writing any other tests.
 
 .. important::
-   We may have to reset hardware state. If this is not possible, we may only
-   be able to run one test case per invocation.
+   In some cases you need to reset hardware state after each test case,
+   otherwise only one case can be run per test suite.
 
 .. TODO(brendanhiggins@google.com): Add an actual example of an architecture-
    dependent KUnit test.
@@ -200,38 +199,41 @@ Isolating Behavior
 ------------------
 
 Unit testing limits the amount of code under test to a single unit. It controls
-what code gets run when the unit under test calls a function. Where a function
-is exposed as part of an API such that the definition of that function can be
+what code gets run when the unit under test calls a function. When a function
+is exposed as part of an API, the function definition can be
 changed without affecting the rest of the code base. In the kernel, this comes
 from two constructs: classes, which are structs that contain function pointers
-provided by the implementer, and architecture-specific functions, which have
-definitions selected at compile time.
+provided by the implementer; and architecture-specific functions, which have
+definitions determined at compile time.
 
 Classes
 ~~~~~~~
 
-Classes are not a construct that is built into the C programming language;
-however, it is an easily derived concept. Accordingly, in most cases, every
-project that does not use a standardized object oriented library (like GNOME's
-GObject) has their own slightly different way of doing object oriented
-programming; the Linux kernel is no exception.
+The C programming language does not have the formal notion of class-based
+object-oriented programming, hovewer the paradigm can be applied within
+procedural framework. Accordingly, every project has their own slightly
+different way of doing object oriented programming (such as GNOME's GObject);
+the Linux kernel is no exception.
 
 The central concept in kernel object oriented programming is the class. In the
 kernel, a *class* is a struct that contains function pointers. This creates a
 contract between *implementers* and *users* since it forces them to use the
-same function signature without having to call the function directly. To be a
-class, the function pointers must specify that a pointer to the class, known as
-a *class handle*, be one of the parameters. Thus the member functions (also
-known as *methods*) have access to member variables (also known as *fields*)
-allowing the same implementation to have multiple *instances*.
+same function signature without having to call the function directly. In order
+to be a class, the function pointers must specify that a pointer to the class
+(known as a *class handle*) be one of the parameters; thus the member functions
+(also known as *methods*) have access to member variables (also known as
+*fields*), allowing the same implementation to have multiple *instances*.
 
-A class can be *overridden* by *child classes* by embedding the *parent class*
-in the child class. Then when the child class *method* is called, the child
-implementation knows that the pointer passed to it is of a parent contained
-within the child. Thus, the child can compute the pointer to itself because the
-pointer to the parent is always a fixed offset from the pointer to the child.
-This offset is the offset of the parent contained in the child struct. For
-example:
+A class can be *overridden* by *derived classes* by embedding the *base class*
+in the derived class. Then when the dervied class *method* is called, the
+derived class implementation knows that the pointer passed to it is of a base
+class contained within the derived class. Thus, the child can compute the
+pointer to itself because the pointer to the base class is always a fixed
+offset from the pointer to the derived class. This offset is the offset of the
+base class contained in the struct of derived class.
+
+The example below defines a base class ``shape`` and derived class
+``rectangle`` along with class implementations:
 
 .. code-block:: c
 
@@ -259,8 +261,8 @@ example:
 		self->width = width;
 	}
 
-In this example, computing the pointer to the child from the pointer to the
-parent is done by ``container_of``.
+In this example, computing the pointer to ``rectangle`` from the pointer to
+the ``shape`` is taken care of by ``container_of`` method.
 
 Faking Classes
 ~~~~~~~~~~~~~~
@@ -269,11 +271,13 @@ In order to unit test a piece of code that calls a method in a class, the
 behavior of the method must be controllable, otherwise the test ceases to be a
 unit test and becomes an integration test.
 
-A fake class implements a piece of code that is different than what runs in a
-production instance, but behaves identical from the standpoint of the callers.
-This is done to replace a dependency that is hard to deal with, or is slow. For
-example, implementing a fake EEPROM that stores the "contents" in an
-internal buffer. Assume we have a class that represents an EEPROM:
+A fake class implements a piece of code that interfaces to actual code
+used in production. This is done to replace code dependencies that is hard to
+deal with (expensive or impossible to duplicate), or is slow.
+
+The examples below shows how to test fake EEPROM implementation that stores
+its contents in an internal buffer. Assume that there is ``eeprom`` class,
+which is defined as:
 
 .. code-block:: c
 
@@ -282,7 +286,8 @@ internal buffer. Assume we have a class that represents an EEPROM:
 		ssize_t (*write)(struct eeprom *this, size_t offset, const char *buffer, size_t count);
 	};
 
-And we want to test code that buffers writes to the EEPROM:
+Supposes that you want to test ``eeprom_buffer`` class, which writes the
+contents to actual EEPROM:
 
 .. code-block:: c
 
@@ -295,7 +300,8 @@ And we want to test code that buffers writes to the EEPROM:
 	struct eeprom_buffer *new_eeprom_buffer(struct eeprom *eeprom);
 	void destroy_eeprom_buffer(struct eeprom *eeprom);
 
-We can test this code by *faking out* the underlying EEPROM:
+In order to test ``eeprom_buffer``, you need *faking out* the underlying
+EEPROM with ``fake_eeprom``, which is derived from ``eeprom``:
 
 .. code-block:: c
 
@@ -331,7 +337,7 @@ We can test this code by *faking out* the underlying EEPROM:
 		memset(this->contents, 0, FAKE_EEPROM_CONTENTS_SIZE);
 	}
 
-We can now use it to test ``struct eeprom_buffer``:
+You can now use it to test ``eeprom_buffer``:
 
 .. code-block:: c
 
@@ -425,11 +431,12 @@ We can now use it to test ``struct eeprom_buffer``:
 Testing Against Multiple Inputs
 -------------------------------
 
-Testing just a few inputs is not enough to ensure that the code works correctly,
-for example: testing a hash function.
+Sometimes in order to correctly test the code, many inputs are required. In
+such cases, you can write a helper macro or function. The helper can be
+called for each test input.
 
-We can write a helper macro or function. The function is called for each input.
-For example, to test ``sha1sum(1)``, we can write:
+The following example defines ``TEST_SHA1`` helper macro for testing
+:manpage:`sha1sum(1)`. The macro is called on 2 test cases:
 
 .. code-block:: c
 
@@ -444,12 +451,15 @@ For example, to test ``sha1sum(1)``, we can write:
 Note the use of the ``_MSG`` version of ``KUNIT_EXPECT_STREQ`` to print a more
 detailed error and make the assertions clearer within the helper macros.
 
-The ``_MSG`` variants are useful when the same expectation is called multiple
-times (in a loop or helper function) and thus the line number is not enough to
-identify what failed, as shown below.
+The ``_MSG`` variants are useful when the same expectation is asserted
+multiple times (in a loop or helper function), since the line number alone is
+not enough to identify the failure, as shown below.
 
-In complicated cases, we recommend using a *table-driven test* compared to the
-helper macro variation, for example:
+In complicated cases, it is recommended to use *table-driven test* pattern
+instead.
+
+The following example does the same test as above, but the test cases are
+defined in an array of struct:
 
 .. code-block:: c
 
@@ -478,18 +488,14 @@ helper macro variation, for example:
 	}
 
 
-There is more boilerplate code involved, but it can:
+There are advantages of *table-driven tests*:
 
-* be more readable when there are multiple inputs/outputs (due to field names).
-
-  * For example, see ``fs/ext4/inode-test.c``.
-
-* reduce duplication if test cases are shared across multiple tests.
-
-  * For example: if we want to test ``sha256sum``, we could add a ``sha256``
-    field and reuse ``cases``.
-
-* be converted to a "parameterized test".
+* The test is more readable when there are many inputs and expected outputs.
+  See ``fs/ext4/inode-test.c`` for example.
+* It can reduce duplication if test cases are shared across multiple tests.
+  For example, if you want to also test :manpage:`sha256sum(1)`, you can
+  simply add ``sha256`` field to ``cases``.
+* The test can be turned into "parameterized test", see below subsection.
 
 Parameterized Testing
 ~~~~~~~~~~~~~~~~~~~~~
@@ -497,8 +503,8 @@ Parameterized Testing
 The table-driven testing pattern is common enough that KUnit has special
 support for it.
 
-By reusing the same ``cases`` array from above, we can write the test as a
-"parameterized test" with the following.
+The following example does the same :manpage:`sha1sum(1)` test as above,
+but is written using parameterized testing facilities:
 
 .. code-block:: c
 
@@ -526,7 +532,7 @@ By reusing the same ``cases`` array from above, we can write the test as a
 	// Creates `sha1_gen_params()` to iterate over `cases`.
 	KUNIT_ARRAY_PARAM(sha1, cases, case_to_desc);
 
-	// Looks no different from a normal test.
+	// Looks no different from other tests.
 	static void sha1_test(struct kunit *test)
 	{
 		// This function can just contain the body of the for-loop.
@@ -539,7 +545,7 @@ By reusing the same ``cases`` array from above, we can write the test as a
 				      "sha1sum(%s)", test_param->str);
 	}
 
-	// Instead of KUNIT_CASE, we use KUNIT_CASE_PARAM and pass in the
+	// Instead of KUNIT_CASE, use KUNIT_CASE_PARAM and pass in the
 	// function declared by KUNIT_ARRAY_PARAM.
 	static struct kunit_case sha1_test_cases[] = {
 		KUNIT_CASE_PARAM(sha1_test, sha1_gen_params),
@@ -549,9 +555,13 @@ By reusing the same ``cases`` array from above, we can write the test as a
 Exiting Early on Failed Expectations
 ------------------------------------
 
-We can use ``KUNIT_EXPECT_EQ`` to mark the test as failed and continue
-execution.  In some cases, it is unsafe to continue. We can use the
-``KUNIT_ASSERT`` variant to exit on failure.
+All the tests until now uses ``KUNIT_EXPECT`` macros to assert expectations.
+In case of any of these are failed, the test continues. However, in some
+cases, continuing tests is not possible or is unsafe. For these cases,
+you can use ``KUNIT_ASSERT`` variant to exit early on failure.
+
+The example below tests allocating objects then play with them. Only if
+the allocation succeed, these objects can be played with:
 
 .. code-block:: c
 
@@ -567,12 +577,15 @@ execution.  In some cases, it is unsafe to continue. We can use the
 Allocating Memory
 -----------------
 
-Where you might use ``kzalloc``, you can instead use ``kunit_kzalloc`` as KUnit
-will then ensure that the memory is freed once the test completes.
+When ``kzalloc`` may be used to allocate memory, you can instead use
+``kunit_kzalloc`` as KUnit will then ensure that the memory is freed once
+the test completes.
 
-This is useful because it lets us use the ``KUNIT_ASSERT_EQ`` macros to exit
-early from a test without having to worry about remembering to call ``kfree``.
-For example:
+This is useful because it lets you to use ``KUNIT_ASSERT_EQ`` macros to exit
+early from a test without having to worry about remembering to freeing
+memory with ``kfree``.
+
+The following example tests allocating buffer memory:
 
 .. code-block:: c
 
@@ -589,9 +602,11 @@ For example:
 Testing Static Functions
 ------------------------
 
-If we do not want to expose functions or variables for testing, one option is to
-conditionally ``#include`` the test file at the end of your .c file. For
-example:
+If you do not want to expose testing functions or variables unconditionally,
+you can ``#include`` the test file inside ``#ifdef`` guard.
+
+In the example below, the test code in ``my_kunit_test.c`` is included and
+compiled only if ``CONFIG_MY_KUNIT_TEST`` is enabled:
 
 .. code-block:: c
 
@@ -606,7 +621,11 @@ example:
 Injecting Test-Only Code
 ------------------------
 
-Similar to as shown above, we can add test-specific logic. For example:
+You can also add test-only logic inside the guard.
+
+In the following example, prototype of ``test_only_hook()`` is defined with
+``CONFIG_MY_KUNIT_TEST`` both enabled and disabled. In case the configuration
+is disabled, the hook is defined as empty function:
 
 .. code-block:: c
 
@@ -619,19 +638,21 @@ Similar to as shown above, we can add test-specific logic. For example:
 	void test_only_hook(void) { }
 	#endif
 
-This test-only code can be made more useful by accessing the current ``kunit_test``
-as shown in next section: *Accessing The Current Test*.
+This can be made more useful by accessing the current ``kunit_test``
+as shown in next section below.
 
 Accessing The Current Test
 --------------------------
 
-In some cases, we need to call test-only code from outside the test file.
-For example, see example in section *Injecting Test-Only Code* or if
-we are providing a fake implementation of an ops struct. Using
-``kunit_test`` field in ``task_struct``, we can access it via
-``current->kunit_test``.
+In some cases, it is desired to call test-only code from outside the test
+file. See example from previous section for how this can be done by
+including the test file.
 
-The example below includes how to implement "mocking":
+Another way is to provide the fake implementation of an ops struct. For
+example, given ``kunit_test`` field in ``task_struct``, the field can be
+accessed via ``current->kunit_test``.
+
+The example below shows how to implement "mocking" pattern:
 
 .. code-block:: c
 
@@ -665,25 +686,28 @@ The example below includes how to implement "mocking":
 		KUNIT_EXPECT_EQ(test, fake_foo(1), 42);
 	}
 
-In this example, we are using the ``priv`` member of ``struct kunit`` as a way
+In this example, ``kunit->priv`` is used as a way
 of passing data to the test from the init function. In general ``priv`` is
 pointer that can be used for any user data. This is preferred over static
 variables, as it avoids concurrency issues.
 
-Had we wanted something more flexible, we could have used a named ``kunit_resource``.
-Each test can have multiple resources which have string names providing the same
-flexibility as a ``priv`` member, but also, for example, allowing helper
+In cases where you want something more flexible, ``kunit_resource`` can be
+used instead. Each test can have multiple resources which have names providing
+the same flexibility as ``priv``, but also, for example, allowing helper
 functions to create resources without conflicting with each other. It is also
-possible to define a clean up function for each resource, making it easy to
-avoid resource leaks. For more information, see Documentation/dev-tools/kunit/api/test.rst.
+possible to define clean up routines for each resource, making it easy to
+avoid leaking. For more information, see
+Documentation/dev-tools/kunit/api/test.rst.
 
 Failing The Current Test
 ------------------------
 
-If we want to fail the current test, we can use ``kunit_fail_current_test(fmt, args...)``
-which is defined in ``<kunit/test-bug.h>`` and does not require pulling in ``<kunit/test.h>``.
-For example, we have an option to enable some extra debug checks on some data
-structures as shown below:
+If you want to fail the current test with a meaningful reason, you can use
+``kunit_fail_current_test()``, which is defined in ``<kunit/test-bug.h>``.
+It does not require pulling in ``<kunit/test.h>``.
+
+The following example have the extra validation over ``data`` struct, which
+is only done when ``CONFIG_EXTRA_DEBUG_CHECKS`` is enabled:
 
 .. code-block:: c
 
-- 
An old man doll... just what I always wanted! - Clara

