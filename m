Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0577C478428
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 05:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhLQEiY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 23:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhLQEiW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 23:38:22 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2CBC061747
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 20:38:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i187-20020a2522c4000000b006093b616e65so852757ybi.17
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 20:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Fkg1mI+Db1oVO87JCisJGaRTIFR9sODJhCV59aBxEMg=;
        b=Tj3meYekaMc40xRg2gOOa2R1K6Z7UK/MBmbN3EnS9Mp8DnlQlPCjXF34eAqShGVK+P
         59mFBmk9o3oOmmNPmBNQTzhZ25PLT9cI18lFD3STzbVIJz/N47hJIo5oeivLioFgYbnF
         1UUn1XS4fOmuL5OxZY1YonTe7Gj4QiBXZlniqemvl9uP7PaZKRL3LzhtjO+fnK7TyDPn
         AZC1lRJDSlqMAivyF+hKKSBKdFc4T9NmNUTzut3dEXb9AgVJCuSp9HX8wFAMinNZbF8Y
         Q4bU/ilg75qhD61271BiUxZTRmUeaqkPWbFsoQuwkybvXwjlngOD02+DReLUjKOmJNMP
         /G0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Fkg1mI+Db1oVO87JCisJGaRTIFR9sODJhCV59aBxEMg=;
        b=79ByE6gVbzaNnmDX8JmxusfWfcH4nQyygU3jZwZKIZbPoDWmlbVaF8u4XVeojbMRzH
         rjRZlKOleRCj55BsjS7lrHxvOzEfjMjUyNlQ9MORO1pfU+Cw+0WFTZeZtaHuEHCWeXwa
         cBInKyD8bMS5y4x8ETqJ4oUXtNFKsTrF6E1D4pKcZLsauAe80KVHlrVC8WaZGETgTzNR
         7E/E3S7okKu0pwn4FSJby2qOX8lO3/mZjCN/2RBq7sNX5vQG5DE6wo/n9pTtRaaJQOoZ
         iXRrr6ajyoa1Ln8LrLssNbvDyIJYOli8S499wNC5KpGhYa1wwzF8zDWkMVC7JTiScu2f
         7/gg==
X-Gm-Message-State: AOAM530wxmWkUPlyu9jd/7U1TjppR4zucEmvjj6f+r4G/RJ3EEamzWUi
        tijutDu+G3BiaQ6zQhvrJT++P+rFBYkP0kc=
X-Google-Smtp-Source: ABdhPJxXxK6aWyjr6j7IicczuiAbEf0DU7IIPOvC9+NBN96/LXbwnuIIzXbpJ3osiiRKmjeJvacad2NaLz3aOKk=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a25:acc3:: with SMTP id
 x3mr2292079ybd.332.1639715901479; Thu, 16 Dec 2021 20:38:21 -0800 (PST)
Date:   Fri, 17 Dec 2021 04:37:16 +0000
In-Reply-To: <20211217043716.794289-1-sharinder@google.com>
Message-Id: <20211217043716.794289-8-sharinder@google.com>
Mime-Version: 1.0
References: <20211217043716.794289-1-sharinder@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v5 7/7] Documentation: KUnit: Restyled Frequently Asked Questions
From:   Harinder Singh <sharinder@google.com>
To:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim.bird@sony.com, elver@google.com,
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
2.34.1.173.g76aa8bc2d0-goog

