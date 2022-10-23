Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD1A609351
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Oct 2022 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiJWNKb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Oct 2022 09:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiJWNK0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Oct 2022 09:10:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D120A2B62B;
        Sun, 23 Oct 2022 06:10:08 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so10768368pji.1;
        Sun, 23 Oct 2022 06:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmR/gqIxQhBNs+360mgXWEdqP4BqSnl2UZtgUNKM0Tw=;
        b=V5YgVNMgjszbblHEDyqPSxsjWUu4N4smV90rArkkVXcL+IIhSEONA0CHFv8/zxwx0M
         VmdEwZ6G5oD3BwByNlhSoUR2UxEsuYprGs/hDQCe7J2b4e/Y/8C/xVwKpz1ss1kkCpeN
         NWnBqjXxdMIHsjq38Q7hatqJFp6LBLGn5D0LIXec+6YO5FvtIkSbvXUjyZHDSuIk4MSj
         L32xc9RopO3zi/NmDBLEtKFOd48EsYyOAvy+QaO2/9KmxtYd4WAygnSv+QkDlu458ubF
         Al4djohhPxKgZvbnGWG2sYLmA9WNcMSGMvEGDvkCMxM8Z3+W3GCYVTCdCTNxSvFNOywV
         G/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmR/gqIxQhBNs+360mgXWEdqP4BqSnl2UZtgUNKM0Tw=;
        b=OV/SwiAj3e8zrU/tiVuI6j3KJ08PbxkMVk1jrx63XYxUFpIkfvQ4vo6V/dkMN9OjNN
         NfR31APYERqC2gYFPR4oIBhZJGH8plzCrxu0wqNKJzky8xRHLRLsurETKCCOOgUTW8cw
         Thq8X6bUe2DU0BHa3x6SfdoAKS27lwWULxwDS5Mr9E4HPGOB/AWax0D7Zbd2JkzOFa8l
         VgmZ9O2SDQK+MmqvfvqvPWSxdykmlqYZCgkCcbM8rRxgTXFRtSzPUFPNEdvuq/Kj/kIi
         Yh2QyYHdm8lUkNzGv8yrXfZxFbActZRv/Eu7ObzIm8TS0OTzO/N5EG2aEaGMjTNtG5m5
         9CIg==
X-Gm-Message-State: ACrzQf1WnAodgKVpCUtpCTUfqZoBoRwse9D7aCui9bPOX0Uiscl+E81r
        HyF/OAFvJi8ac8K9aCOqbN0uCtyRjp4tiQ==
X-Google-Smtp-Source: AMsMyM5D8JgcvYw5Kjkm8KB0mwlZwcENACiSFARJGCnMpCh9tFlekvzy5gswZHnVFBwvIAHoy4jahA==
X-Received: by 2002:a17:902:7849:b0:186:68b9:e1ae with SMTP id e9-20020a170902784900b0018668b9e1aemr16679819pln.139.1666530607200;
        Sun, 23 Oct 2022 06:10:07 -0700 (PDT)
Received: from debian.. (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id d5-20020a623605000000b0056b6c7a17c6sm3411713pfa.12.2022.10.23.06.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 06:10:06 -0700 (PDT)
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
Subject: [PATCH RESEND 4/7] Documentation: kunit: move introduction to its own document
Date:   Sun, 23 Oct 2022 20:08:44 +0700
Message-Id: <20221023130846.63296-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221023130846.63296-1-bagasdotme@gmail.com>
References: <20221023130846.63296-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7356; i=bagasdotme@gmail.com; h=from:subject; bh=OEQrwbZin8rzzpBGXarDh6toHlpYYd/ADdl9XFMdDz8=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmhNrd/pHycFLteIn754pKqg6Hn4/9VPmxYIn7uVeZGdvdH BZ4HO0pZGMQ4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRq7MZ/sdLXvxvcc/U8RMvw9V/Pj 9XG72XkpzueDFs557G+fWM/88zMqwt+yeud8zpvphYSMatQt89zQlnFZZsv7U5urpx2st5vhwA
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

