Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AAC609324
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Oct 2022 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiJWM5o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Oct 2022 08:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiJWM5Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Oct 2022 08:57:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997AA62AAB;
        Sun, 23 Oct 2022 05:56:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso4244751pjc.0;
        Sun, 23 Oct 2022 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmR/gqIxQhBNs+360mgXWEdqP4BqSnl2UZtgUNKM0Tw=;
        b=CZSBuCjJVa0mOW3xN6xHk+V/mMN8hDZJfgbiVp8nU7K3kjfJciKEhPPUPUirXLzXoc
         zxLtv9fUTOLtlAS/zzJ0vqwLupRpbRw2WEpe7qj3sCgGo8E/skqvGMaxi3Y8NR9A+tFo
         PHNOvgBZHcbPX1/4PsJ5TFnhFoBiAiO1kx9IbQHUL1WLfq0uA8jMrKiBbHU0Achjc2rm
         WkcZ9ovsHn0j9tuZU5MyASQ1G+e9oR8GLKZpmR8sCIeaZMrEUMkqRVTRZOji8lwq1Qis
         zRnpO4FppWAIT+yxnIKLCmIBRI2UQW/6w36fGI5kvKaKIImJR0j71j5KYdIpDuLAxxBi
         hprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmR/gqIxQhBNs+360mgXWEdqP4BqSnl2UZtgUNKM0Tw=;
        b=bbrUe+HJIxCsDGjh84DbARV84IER0kfrEdMA2ro/zPzZYEifcoZG8TM76Hqhkec8U7
         jmHvYd20agUMhXw4N229FgbjFCP/RfhBdS6fJpZvvQpo/mkZQxYr0lTR7vO1J2Z+IioW
         qmcCRZMqSs6vX+oHn/idu8XrxrUTSUT3VzpcAdJbqRCEi7G/SoZkd09+PZGN9WDKulYP
         eZAj95H9/6tFFdLLrONxUCGHsfJJT6IN4cUWI0aubKUP3bZFnhIc1DamP0fcvb6LEQSI
         9Diet89Ni1a7et64kVLDQiluzjeti5gA/UF+hJaMuUH8ds9YYCfXG/3B6ywm6q0Omie1
         FChQ==
X-Gm-Message-State: ACrzQf25n4ShQJDQtAONYegfs0WTKzdOtUMnj8hXALAOMd5UK9jfFWSv
        9HIJ0AQ1gM/Y+DDKFWsIp+G4V1TOuL4tSg==
X-Google-Smtp-Source: AMsMyM4udHaviZWGrxBvutPkMlA7bwzb1895/q/cEBXMaD2LCvJlRqxFMwSMB3eLF4M4VfQ2VmrCmA==
X-Received: by 2002:a17:902:b218:b0:184:710c:8c52 with SMTP id t24-20020a170902b21800b00184710c8c52mr28721026plr.95.1666529731291;
        Sun, 23 Oct 2022 05:55:31 -0700 (PDT)
Received: from debian.. (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id om10-20020a17090b3a8a00b00212daa68b7csm2670639pjb.44.2022.10.23.05.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 05:55:31 -0700 (PDT)
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
Subject: [PATCH 4/7] Documentation: kunit: move introduction to its own document
Date:   Sun, 23 Oct 2022 19:54:11 +0700
Message-Id: <20221023125414.60961-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221023125414.60961-1-bagasdotme@gmail.com>
References: <20221023125414.60961-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7356; i=bagasdotme@gmail.com; h=from:subject; bh=OEQrwbZin8rzzpBGXarDh6toHlpYYd/ADdl9XFMdDz8=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmhlrk/Uj5Oil0vEb98cUnVwdDz8f8qHzYsET/3KnMju/uj As+DHaUsDGIcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZgIy22G/17/RTnvNVuWJRdfVTnh97 3ZzNPj9p575TsjjbNOJSgzODD8DypKEjH8vr7j/SHtNY4fH1763CHx5ae8ov9D+cmP6xaoMQAA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Type: text/plain; charset=UTF-8
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

Move KUnit introduction from table of contents index to its own page.

While at it, rewrite the intro.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/dev-tools/kunit/index.rst | 93 +------------------------
 Documentation/dev-tools/kunit/intro.rst | 61 ++++++++++++++++
 2 files changed, 62 insertions(+), 92 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/intro.rst

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index f5d13f1d37be1d..ad972602d91ad8 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -8,6 +8,7 @@ KUnit - Linux Kernel Unit Testing
 	:maxdepth: 2
 	:caption: Contents:
 
+	intro
 	start
 	architecture
 	run_wrapper
@@ -19,95 +20,3 @@ KUnit - Linux Kernel Unit Testing
 	tips
 	running_tips
 
-This section details the kernel unit testing framework.
-
-Introduction
-============
-
-KUnit (Kernel unit testing framework) provides a common framework for
-unit tests within the Linux kernel. Using KUnit, you can define groups
-of test cases called test suites. The tests either run on kernel boot
-if built-in, or load as a module. KUnit automatically flags and reports
-failed test cases in the kernel log. The test results appear in
-:doc:`KTAP (Kernel - Test Anything Protocol) format</dev-tools/ktap>`.
-It is inspired by JUnit, Python’s unittest.mock, and GoogleTest/GoogleMock
-(C++ unit testing framework).
-
-KUnit tests are part of the kernel, written in the C (programming)
-language, and test parts of the Kernel implementation (example: a C
-language function). Excluding build time, from invocation to
-completion, KUnit can run around 100 tests in less than 10 seconds.
-KUnit can test any kernel component, for example: file system, system
-calls, memory management, device drivers and so on.
-
-KUnit follows the white-box testing approach. The test has access to
-internal system functionality. KUnit runs in kernel space and is not
-restricted to things exposed to user-space.
-
-In addition, KUnit has kunit_tool, a script (``tools/testing/kunit/kunit.py``)
-that configures the Linux kernel, runs KUnit tests under QEMU or UML
-(:doc:`User Mode Linux </virt/uml/user_mode_linux_howto_v2>`),
-parses the test results and
-displays them in a user friendly manner.
-
-Features
---------
-
-- Provides a framework for writing unit tests.
-- Runs tests on any kernel architecture.
-- Runs a test in milliseconds.
-
-Prerequisites
--------------
-
-- Any Linux kernel compatible hardware.
-- For Kernel under test, Linux kernel version 5.5 or greater.
-
-Unit Testing
-============
-
-A unit test tests a single unit of code in isolation. A unit test is the finest
-granularity of testing and allows all possible code paths to be tested in the
-code under test. This is possible if the code under test is small and does not
-have any external dependencies outside of the test's control like hardware.
-
-
-Write Unit Tests
-----------------
-
-To write good unit tests, there is a simple but powerful pattern:
-Arrange-Act-Assert. This is a great way to structure test cases and
-defines an order of operations.
-
-- Arrange inputs and targets: At the start of the test, arrange the data
-  that allows a function to work. Example: initialize a statement or
-  object.
-- Act on the target behavior: Call your function/code under test.
-- Assert expected outcome: Verify that the result (or resulting state) is as
-  expected.
-
-Unit Testing Advantages
------------------------
-
-- Increases testing speed and development in the long run.
-- Detects bugs at initial stage and therefore decreases bug fix cost
-  compared to acceptance testing.
-- Improves code quality.
-- Encourages writing testable code.
-
-Read also :ref:`kinds-of-tests`.
-
-How do I use it?
-================
-
-*   Documentation/dev-tools/kunit/start.rst - for KUnit new users.
-*   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
-*   Documentation/dev-tools/kunit/run_wrapper.rst - run kunit_tool.
-*   Documentation/dev-tools/kunit/run_manual.rst - run tests without kunit_tool.
-*   Documentation/dev-tools/kunit/usage.rst - write tests.
-*   Documentation/dev-tools/kunit/tips.rst - best practices with
-    examples.
-*   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
-    used for testing.
-*   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
-    answers.
diff --git a/Documentation/dev-tools/kunit/intro.rst b/Documentation/dev-tools/kunit/intro.rst
new file mode 100644
index 00000000000000..6061aaa0e905ab
--- /dev/null
+++ b/Documentation/dev-tools/kunit/intro.rst
@@ -0,0 +1,61 @@
+Introduction to KUnit
+=====================
+
+KUnit (Kernel unit testing framework) provides a common framework for
+unit tests within the Linux kernel. Using KUnit, you can write test
+suites for your kernel code. As with other kernel features, the
+tests can be either built into the kernel image or as loadable modules.
+It automatically flags and reports
+failed test cases in the kernel log. The test results appear in
+:doc:`KTAP (Kernel - Test Anything Protocol) format</dev-tools/ktap>`.
+It is inspired by JUnit, Python’s unittest.mock, and GoogleTest/GoogleMock
+(C++ unit testing framework).
+
+KUnit tests are kernel code, written in the C, that tests particular kernel
+functionality. KUnit can run around
+100 tests in less than 10 seconds.
+KUnit can test any kernel component, such as file system, system
+calls, memory management, device drivers and so on.
+
+KUnit follows the white-box testing approach. The test has access to
+kernel internal. It runs in kernel space and thus not restricted to things
+exposed to user-space.
+
+In addition, KUnit has a script (``tools/testing/kunit/kunit.py``)
+that configures the kernel, runs the tests under QEMU or UML
+(:doc:`User Mode Linux </virt/uml/user_mode_linux_howto_v2>`),
+parses the test results and displays them in a user friendly manner.
+The rest of KUnit documentation will refer to this script as kunit_tool.
+
+Features
+--------
+
+- Provides a framework for writing unit tests.
+- Runs tests on any kernel architecture.
+- Runs a test in milliseconds.
+
+Prerequisites
+-------------
+
+- Linux kernel 5.5 or later is required to test using KUnit.
+
+Unit testing
+------------
+
+A unit test tests a particular code in isolation. It is the finest
+granularity of testing and allows all possible code paths to be tested in the
+code under test. This is possible if the code under test is small and does not
+depend on external factors (like hardware).
+
+Next steps
+----------
+
+If you haven't write the test before, see
+Documentation/dev-tools/kunit/start.rst for tutorial on writing your first
+test. An in-depth explanation of writing test is described in
+Documentation/dev-tools/kunit/usage.rst. For information on running tests,
+see Documentation/dev-tools/kunit/run_wrapper.rst and
+Documentation/dev-tools/kunit/run_manual.rst.
+
+The KUnit infrastructure is explained in
+Documentation/dev-tools/kunit/architecture.rst.
-- 
An old man doll... just what I always wanted! - Clara

