Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7D946B27C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 06:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbhLGFoJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 00:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbhLGFoI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 00:44:08 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B592C061746
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 21:40:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h5-20020a255f45000000b005ffd939127bso23822264ybm.10
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Dec 2021 21:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=nxBLzKA4ybKZDtJ73PAKLyE/bKqtg74Ou0Zh30NRku8=;
        b=hfzZn80h+bsMj4esAMmwwUoQKDNCUvBBTnUict1Xt7YuOjlsdowrMkjGsBLRPjoPnv
         bIwESNGzKqqtT0Tg591ojcrA1qVSQVcyJEoJjcy+4/IGiaVi6I9E8HVaw08u9/zVBfUy
         5eKsNjwMTLM85jfZ2deG3JGKQP/6p0c87PjTuLNvK2+QWnJ1GRMEmUsjLejBHLPugYE1
         4GTJL7xLKpocWWwgRSeQusAec6guU9fVhWzFCvnGIwlviwJycTDWLH+9IdGd9nKVxXSQ
         OPJxO4e1RTOf74OBvNZeTbXzxTELfgsUBHG02YJFCQLwHlRrJxjp/Fwqd9vgD5j++GgD
         Qnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=nxBLzKA4ybKZDtJ73PAKLyE/bKqtg74Ou0Zh30NRku8=;
        b=xa8NOw5aXfan1/YRPPGFuHZ3MBvvD/M0xChMtRL3jHfaJtquyrboIEQnVpG6mOpmw3
         nn9yLWEZoKqeUc1mm+KBF6cBdjt+ffEGWjW+vKCa5YlZvRopGmZ+3+7xAFtBzoKMLHhE
         EcUOp+9KjtnO+Pt4nM4LapP1itv1kgiUmEbffrtOe18OKx8NkbXmuZdawOrz9IQ7sAE6
         z3B5KAA0NRdY2HGbuQ3Bgzud8IzbhMlM+8Q+FnJT22AOEb8KkIgmNwHQ6pMOhMcfLZr8
         +l2o+KWjKIagEl/VsuSN6r9URB5dRZZPZl2yDGpZvXwQby43P/C/UnpbV5m+Bbq/blve
         80Nw==
X-Gm-Message-State: AOAM532yGXrMyHI60H9ehIPh1tLUO2TczECQncpwerT6gp7YTeshz+B8
        gmQi0qyUZSTnjmzE257tjOQCl7O9WLB9p1M=
X-Google-Smtp-Source: ABdhPJwpSXAhSABnQoLNl4VfLW0Xi74Oh96dC+g4PwY6vINu2MlWFLxqe3oDdiu9CZ36/vQpt1klJntPVWSjwo8=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a25:2a03:: with SMTP id
 q3mr46677981ybq.55.1638855637590; Mon, 06 Dec 2021 21:40:37 -0800 (PST)
Date:   Tue,  7 Dec 2021 05:40:13 +0000
In-Reply-To: <20211207054019.1455054-1-sharinder@google.com>
Message-Id: <20211207054019.1455054-2-sharinder@google.com>
Mime-Version: 1.0
References: <20211207054019.1455054-1-sharinder@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v2 1/7] Documentation: KUnit: Rewrite main page
From:   Harinder Singh <sharinder@google.com>
To:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim.bird@sony.com, Harinder Singh <sharinder@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a section on advantages of unit testing, how to write unit tests,
KUnit features and Prerequisites.

Signed-off-by: Harinder Singh <sharinder@google.com>
---
 Documentation/dev-tools/kunit/index.rst | 166 +++++++++++++-----------
 1 file changed, 88 insertions(+), 78 deletions(-)

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-to=
ols/kunit/index.rst
index cacb35ec658d..ebf4bffaa1ca 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -1,11 +1,12 @@
 .. SPDX-License-Identifier: GPL-2.0
=20
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-KUnit - Unit Testing for the Linux Kernel
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+KUnit - Linux Kernel Unit Testing
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 .. toctree::
 	:maxdepth: 2
+	:caption: Contents:
=20
 	start
 	usage
@@ -16,82 +17,91 @@ KUnit - Unit Testing for the Linux Kernel
 	tips
 	running_tips
=20
-What is KUnit?
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-KUnit is a lightweight unit testing and mocking framework for the Linux ke=
rnel.
-
-KUnit is heavily inspired by JUnit, Python's unittest.mock, and
-Googletest/Googlemock for C++. KUnit provides facilities for defining unit=
 test
-cases, grouping related test cases into test suites, providing common
-infrastructure for running tests, and much more.
-
-KUnit consists of a kernel component, which provides a set of macros for e=
asily
-writing unit tests. Tests written against KUnit will run on kernel boot if
-built-in, or when loaded if built as a module. These tests write out resul=
ts to
-the kernel log in `TAP <https://testanything.org/>`_ format.
-
-To make running these tests (and reading the results) easier, KUnit offers
-:doc:`kunit_tool <kunit-tool>`, which builds a `User Mode Linux
-<http://user-mode-linux.sourceforge.net>`_ kernel, runs it, and parses the=
 test
-results. This provides a quick way of running KUnit tests during developme=
nt,
-without requiring a virtual machine or separate hardware.
-
-Get started now: Documentation/dev-tools/kunit/start.rst
-
-Why KUnit?
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-A unit test is supposed to test a single unit of code in isolation, hence =
the
-name. A unit test should be the finest granularity of testing and as such =
should
-allow all possible code paths to be tested in the code under test; this is=
 only
-possible if the code under test is very small and does not have any extern=
al
-dependencies outside of the test's control like hardware.
-
-KUnit provides a common framework for unit tests within the kernel.
-
-KUnit tests can be run on most architectures, and most tests are architect=
ure
-independent. All built-in KUnit tests run on kernel startup.  Alternativel=
y,
-KUnit and KUnit tests can be built as modules and tests will run when the =
test
-module is loaded.
-
-.. note::
-
-        KUnit can also run tests without needing a virtual machine or actu=
al
-        hardware under User Mode Linux. User Mode Linux is a Linux archite=
cture,
-        like ARM or x86, which compiles the kernel as a Linux executable. =
KUnit
-        can be used with UML either by building with ``ARCH=3Dum`` (like a=
ny other
-        architecture), or by using :doc:`kunit_tool <kunit-tool>`.
-
-KUnit is fast. Excluding build time, from invocation to completion KUnit c=
an run
-several dozen tests in only 10 to 20 seconds; this might not sound like a =
big
-deal to some people, but having such fast and easy to run tests fundamenta=
lly
-changes the way you go about testing and even writing code in the first pl=
ace.
-Linus himself said in his `git talk at Google
-<https://gist.github.com/lorn/1272686/revisions#diff-53c65572127855f1b003d=
b4064a94573R874>`_:
-
-	"... a lot of people seem to think that performance is about doing the
-	same thing, just doing it faster, and that is not true. That is not what
-	performance is all about. If you can do something really fast, really
-	well, people will start using it differently."
-
-In this context Linus was talking about branching and merging,
-but this point also applies to testing. If your tests are slow, unreliable=
, are
-difficult to write, and require a special setup or special hardware to run=
,
-then you wait a lot longer to write tests, and you wait a lot longer to ru=
n
-tests; this means that tests are likely to break, unlikely to test a lot o=
f
-things, and are unlikely to be rerun once they pass. If your tests are rea=
lly
-fast, you run them all the time, every time you make a change, and every t=
ime
-someone sends you some code. Why trust that someone ran all their tests
-correctly on every change when you can just run them yourself in less time=
 than
-it takes to read their test log?
+This section details the kernel unit testing framework.
+
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+KUnit (Kernel unit testing framework) provides a common framework for
+unit tests within the Linux kernel. Using KUnit, you can define groups
+of test cases called test suites. The tests either run on kernel boot
+if built-in, or load as a module. KUnit automatically flags and reports
+failed test cases in the kernel log. The test results appear in `TAP
+(Test Anything Protocol) format <https://testanything.org/>`_. It is inspi=
red by
+JUnit, Python=E2=80=99s unittest.mock, and GoogleTest/GoogleMock (C++ unit=
 testing
+framework).
+
+KUnit tests are part of the kernel, written in the C (programming)
+language, and test parts of the Kernel implementation (example: a C
+language function). Excluding build time, from invocation to
+completion, KUnit can run around 100 tests in less than 10 seconds.
+KUnit can test any kernel component, for example: file system, system
+calls, memory management, device drivers and so on.
+
+KUnit follows the white-box testing approach. The test has access to
+internal system functionality. KUnit runs in kernel space and is not
+restricted to things exposed to user-space.
+
+In addition, KUnit has kunit_tool, a script (``tools/testing/kunit/kunit.p=
y``)
+that configures the Linux kernel, runs KUnit tests under QEMU or UML (`Use=
r Mode
+Linux <http://user-mode-linux.sourceforge.net/>`_), parses the test result=
s and
+displays them in a user friendly manner.
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
+- Any Linux kernel compatible hardware.
+- For Kernel under test, Linux kernel version 5.5 or greater.
+
+Unit Testing
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A unit test tests a single unit of code in isolation. A unit test is the f=
inest
+granularity of testing and allows all possible code paths to be tested in =
the
+code under test. This is possible if the code under test is small and does=
 not
+have any external dependencies outside of the test's control like hardware=
.
+
+
+Write Unit Tests
+----------------
+
+To write good unit tests, there is a simple but powerful pattern:
+Arrange-Act-Assert. This is a great way to structure test cases and
+defines an order of operations.
+
+- Arrange inputs and targets: At the start of the test, arrange the data
+  that allows a function to work. Example: initialize a statement or
+  object.
+- Act on the target behavior: Call your function/code under test.
+- Assert expected outcome: Verify the result (or resulting state) as expec=
ted
+  or not.
+
+Unit Testing Advantages
+-----------------------
+
+- Increases testing speed and development in the long run.
+- Detects bugs at initial stage and therefore decreases bug fix cost
+  compared to acceptance testing.
+- Improves code quality.
+- Encourages writing testable code.
=20
 How do I use it?
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-*   Documentation/dev-tools/kunit/start.rst - for new users of KUnit
-*   Documentation/dev-tools/kunit/tips.rst - for short examples of best pr=
actices
-*   Documentation/dev-tools/kunit/usage.rst - for a more detailed explanat=
ion of KUnit features
-*   Documentation/dev-tools/kunit/api/index.rst - for the list of KUnit AP=
Is used for testing
-*   Documentation/dev-tools/kunit/kunit-tool.rst - for more information on=
 the kunit_tool helper script
-*   Documentation/dev-tools/kunit/faq.rst - for answers to some common que=
stions about KUnit
+*   Documentation/dev-tools/kunit/start.rst - for KUnit new users.
+*   Documentation/dev-tools/kunit/usage.rst - KUnit features.
+*   Documentation/dev-tools/kunit/tips.rst - best practices with
+    examples.
+*   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
+    used for testing.
+*   Documentation/dev-tools/kunit/kunit-tool.rst - kunit_tool helper
+    script.
+*   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
+    answers.
--=20
2.34.1.400.ga245620fadb-goog

