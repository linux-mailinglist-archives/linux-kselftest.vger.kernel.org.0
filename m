Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011DC467128
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 05:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244995AbhLCE35 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 23:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378497AbhLCE3w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 23:29:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98565C0613E1
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Dec 2021 20:25:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d9-20020a251d09000000b005c208092922so4045698ybd.20
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Dec 2021 20:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qxbnzCQ6QEwp/BitO1PAPeye8PgYvL0SmJ/m1TAbk3E=;
        b=srMNZ6cuwUBYNE/71mhekZbOCqzVYMqgDdYD0VzNvt5+f13qdSm36nnRA3zDsczD2Q
         uApJgEK8LF3C3xYru56puqQvB2+MoHj8dL8Dao4Pu+lqm6kJSKw5L+lhX4y8F1BYvwzo
         5GlM1pBBD1WrFKlLwr4IRb+szMp4Qnk7xv8gQDBDj81XXU/VEP/RqQEA0Di9NAUQ25zQ
         OeMgdYEgVUsf91cILvs1ixbyCNssUrkxO1T9Uo6+yqtZl3k6R/y0dxgPTLtHqkY9KO63
         pbhwkmhi0/CF5JIZQJAiVIX/LD4auxYwAy+UfrijIrAMUy7DNxXpTmrPZ0rb0LJSZQuK
         ZzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qxbnzCQ6QEwp/BitO1PAPeye8PgYvL0SmJ/m1TAbk3E=;
        b=CjU9f+1VPRbIT/qfd2awyuw/oWAHrx9JTNaa2v5eK9laVzQiW74uxlhwwaYB3kLLda
         hcYc34jlJDbdJdUGahZdTOIzCoAgLVdtDkBMhD+HqujRWuPlxXAcxUArDYG6a/860R39
         OVnhCKhClplHiO5dtJtHaf5HdbZ/SCeWrEGM/wYxMsnwIXVjlwtRmhAGRvoezfa+/zTq
         oiw0IcczhLkpzG2p9E0XKQgoHTzfdQ0meh3gqNTKDPnIHa4QqJlVjuN2b9P0z365fk+O
         hOOEfgz3I3I/PqLKzWDYs73Y3n+V35kVjt6hlE5ZD3xHr5s/NNPXvCDAXLNtIcC6GWsm
         9/zg==
X-Gm-Message-State: AOAM532zb1zVyMmeCTRvsDhe1NwBte6XE6nTPQ6bVC0l5FdhUaldVxrS
        gJA2WLFZGKZlfFY/ZZ+lDiDPMLBjF4dUo44=
X-Google-Smtp-Source: ABdhPJyLVANCmaJIYRjoNSQbaYfnbdYeIjLgN9Fbufolt2xDGwD1lLK+zEflSbQ57rynf6F40s8kjGrSNcdJtJs=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a25:54e:: with SMTP id
 75mr19360896ybf.393.1638505542869; Thu, 02 Dec 2021 20:25:42 -0800 (PST)
Date:   Fri,  3 Dec 2021 04:24:37 +0000
In-Reply-To: <20211203042437.740255-1-sharinder@google.com>
Message-Id: <20211203042437.740255-8-sharinder@google.com>
Mime-Version: 1.0
References: <20211203042437.740255-1-sharinder@google.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [PATCH v1 7/7] Documentation: KUnit: Restyled Frequently Asked Questions
From:   Harinder Singh <sharinder@google.com>
To:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harinder Singh <sharinder@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Reword to align with other chapters.

Signed-off-by: Harinder Singh <sharinder@google.com>
---
 Documentation/dev-tools/kunit/faq.rst | 73 +++++++++++++--------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
index 5c6555d020f3..172e239791a8 100644
--- a/Documentation/dev-tools/kunit/faq.rst
+++ b/Documentation/dev-tools/kunit/faq.rst
@@ -4,56 +4,55 @@
 Frequently Asked Questions
 ==========================
 
-How is this different from Autotest, kselftest, etc?
-====================================================
+How is this different from Autotest, kselftest, and so on?
+==========================================================
 KUnit is a unit testing framework. Autotest, kselftest (and some others) are
 not.
 
 A `unit test <https://martinfowler.com/bliki/UnitTest.html>`_ is supposed to
-test a single unit of code in isolation, hence the name. A unit test should be
-the finest granularity of testing and as such should allow all possible code
-paths to be tested in the code under test; this is only possible if the code
-under test is very small and does not have any external dependencies outside of
+test a single unit of code in isolation and hence the name *unit test*. A unit
+test should be the finest granularity of testing and should allow all possible
+code paths to be tested in the code under test. This is only possible if the
+code under test is small and does not have any external dependencies outside of
 the test's control like hardware.
 
 There are no testing frameworks currently available for the kernel that do not
-require installing the kernel on a test machine or in a VM and all require
-tests to be written in userspace and run on the kernel under test; this is true
-for Autotest, kselftest, and some others, disqualifying any of them from being
-considered unit testing frameworks.
+require installing the kernel on a test machine or in a virtual machine. All
+testing frameworks require tests to be written in userspace and run on the
+kernel under test. This is true for Autotest, kselftest, and some others,
+disqualifying any of them from being considered unit testing frameworks.
 
 Does KUnit support running on architectures other than UML?
 ===========================================================
 
-Yes, well, mostly.
+Yes, mostly.
 
-For the most part, the KUnit core framework (what you use to write the tests)
-can compile to any architecture; it compiles like just another part of the
+For the most part, the KUnit core framework (what we use to write the tests)
+can compile to any architecture. It compiles like just another part of the
 kernel and runs when the kernel boots, or when built as a module, when the
-module is loaded.  However, there is some infrastructure,
-like the KUnit Wrapper (``tools/testing/kunit/kunit.py``) that does not support
-other architectures.
+module is loaded.  However, there is infrastructure, like the KUnit Wrapper
+(``tools/testing/kunit/kunit.py``) that does not support other architectures.
 
-In short, this means that, yes, you can run KUnit on other architectures, but
-it might require more work than using KUnit on UML.
+In short, yes, you can run KUnit on other architectures, but it might require
+more work than using KUnit on UML.
 
 For more information, see :ref:`kunit-on-non-uml`.
 
-What is the difference between a unit test and these other kinds of tests?
-==========================================================================
+What is the difference between a unit test and other kinds of tests?
+====================================================================
 Most existing tests for the Linux kernel would be categorized as an integration
 test, or an end-to-end test.
 
-- A unit test is supposed to test a single unit of code in isolation, hence the
-  name. A unit test should be the finest granularity of testing and as such
-  should allow all possible code paths to be tested in the code under test; this
-  is only possible if the code under test is very small and does not have any
-  external dependencies outside of the test's control like hardware.
+- A unit test is supposed to test a single unit of code in isolation. A unit
+  test should be the finest granularity of testing and, as such, allows all
+  possible code paths to be tested in the code under test. This is only possible
+  if the code under test is small and does not have any external dependencies
+  outside of the test's control like hardware.
 - An integration test tests the interaction between a minimal set of components,
   usually just two or three. For example, someone might write an integration
   test to test the interaction between a driver and a piece of hardware, or to
   test the interaction between the userspace libraries the kernel provides and
-  the kernel itself; however, one of these tests would probably not test the
+  the kernel itself. However, one of these tests would probably not test the
   entire kernel along with hardware interactions and interactions with the
   userspace.
 - An end-to-end test usually tests the entire system from the perspective of the
@@ -62,26 +61,26 @@ test, or an end-to-end test.
   hardware with a production userspace and then trying to exercise some behavior
   that depends on interactions between the hardware, the kernel, and userspace.
 
-KUnit isn't working, what should I do?
-======================================
+KUnit is not working, what should I do?
+=======================================
 
 Unfortunately, there are a number of things which can break, but here are some
 things to try.
 
-1. Try running ``./tools/testing/kunit/kunit.py run`` with the ``--raw_output``
+1. Run ``./tools/testing/kunit/kunit.py run`` with the ``--raw_output``
    parameter. This might show details or error messages hidden by the kunit_tool
    parser.
 2. Instead of running ``kunit.py run``, try running ``kunit.py config``,
    ``kunit.py build``, and ``kunit.py exec`` independently. This can help track
    down where an issue is occurring. (If you think the parser is at fault, you
-   can run it manually against stdin or a file with ``kunit.py parse``.)
-3. Running the UML kernel directly can often reveal issues or error messages
-   kunit_tool ignores. This should be as simple as running ``./vmlinux`` after
-   building the UML kernel (e.g., by using ``kunit.py build``). Note that UML
-   has some unusual requirements (such as the host having a tmpfs filesystem
-   mounted), and has had issues in the past when built statically and the host
-   has KASLR enabled. (On older host kernels, you may need to run ``setarch
-   `uname -m` -R ./vmlinux`` to disable KASLR.)
+   can run it manually against ``stdin`` or a file with ``kunit.py parse``.)
+3. Running the UML kernel directly can often reveal issues or error messages,
+   ``kunit_tool`` ignores. This should be as simple as running ``./vmlinux``
+   after building the UML kernel (for example, by using ``kunit.py build``).
+   Note that UML has some unusual requirements (such as the host having a tmpfs
+   filesystem mounted), and has had issues in the past when built statically and
+   the host has KASLR enabled. (On older host kernels, you may need to run
+   ``setarch `uname -m` -R ./vmlinux`` to disable KASLR.)
 4. Make sure the kernel .config has ``CONFIG_KUNIT=y`` and at least one test
    (e.g. ``CONFIG_KUNIT_EXAMPLE_TEST=y``). kunit_tool will keep its .config
    around, so you can see what config was used after running ``kunit.py run``.
-- 
2.34.0.384.gca35af8252-goog

