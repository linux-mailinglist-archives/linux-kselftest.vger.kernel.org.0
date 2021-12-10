Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FFC46FA69
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 06:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbhLJFcl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 00:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbhLJFcd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 00:32:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC25C061746
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 21:28:58 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso14805663ybj.18
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Dec 2021 21:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fkg1mI+Db1oVO87JCisJGaRTIFR9sODJhCV59aBxEMg=;
        b=lacTvAJwrb/C0K/6iy2ZEjHm5iiXDQizR+lqRk7iIDPRCDtOW20hV3CZyC/pj0Z1hH
         jfPtdTTZ0rGKAuSWAvz/HJQK5U9AIBPLfP22Cfbr6YPjnl3wXo1CjaNrzImd5+wnyKvR
         H9PKOYnD64trOO6RUhZL6zK5n2EkhG8j6mUXIKIEI7qZCfV2llm8deltfj2pDPkK3bgV
         V4x2QTqlsu/6Ndbvy+/op/W+OiCu4izBLzVqurPrfdx518GENzGXuiJYuCAcp5UUvKv3
         C7HWZh1p7KTLJf3XB3bP/jV3lJ7Ap2PotzCBKqqIuaZaZfhLz8yOBpoqJX2LqDUOnNvt
         X7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fkg1mI+Db1oVO87JCisJGaRTIFR9sODJhCV59aBxEMg=;
        b=YjBfCGSBputru0oD3sIijhptw83a9ek2AVrRtOAXXQIVE3j4UJL7yO95Tg8x4JYS1e
         m5ApLnE6uI3lnH3gV3RqtgIDrFuMOXHRhH2Xo9QdkiInmRsROd2QAihyQMjk3tcamBFB
         m/glN03bnljKC6Z4+b4lGZNuLwF0tXk9cEOMBkcnJpjLPlndR/fRtK7ujsyAD9VCJaxZ
         kWoONsgR15LmYbD4Qk4CyfZYg4VxyDm5RO43CL9Gjdjwp9cGl17Z+akjtW//5vvSZYNh
         Hi7sfVUf85AFaOGm5Ub7ZsVmw933jD0IEjZpohF8kwR1J1YUpJOLMP2GjfXVSASlKfLH
         pwLQ==
X-Gm-Message-State: AOAM530OAe/+KuazzuAUhbQ9U3hE5+CDL4gM1NRx+zVtjmylpnx9LCt1
        14Va7z2REJSCWc7UEzXu2Iswe/lalAGQrr0=
X-Google-Smtp-Source: ABdhPJzlBYZMzD2K2MMhUKmMbI+PPZLT0nS3mljiFRpE87k/CgskEeLC7TpZw3Sk4H7yk6FvJ+jH1gOXESZsQ4k=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a25:104:: with SMTP id
 4mr12236623ybb.27.1639114137792; Thu, 09 Dec 2021 21:28:57 -0800 (PST)
Date:   Fri, 10 Dec 2021 05:28:12 +0000
In-Reply-To: <20211210052812.1998578-1-sharinder@google.com>
Message-Id: <20211210052812.1998578-8-sharinder@google.com>
Mime-Version: 1.0
References: <20211210052812.1998578-1-sharinder@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 7/7] Documentation: KUnit: Restyled Frequently Asked Questions
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
2.34.1.173.g76aa8bc2d0-goog

