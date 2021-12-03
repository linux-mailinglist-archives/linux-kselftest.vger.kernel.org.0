Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7133C467129
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 05:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378506AbhLCE37 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 23:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244445AbhLCE3b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 23:29:31 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D23C06175C
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Dec 2021 20:25:38 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r18-20020a25ac52000000b005c9047c420bso4199258ybd.4
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Dec 2021 20:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=3xzJc9WVmPqWhudcS9WHcT6GEhVMfkh1tYjcOjahSJM=;
        b=Viccmw6FFo9ZXO8aXhgdnQZ6o1WW4fzUIG+63JrAHDrvWVvtVrCagNH8UEdXNP1Qrc
         ewylaWkdncjV2Jk8OtycOhhzkch/VfkO1HYQKQi16sgIi+yoTLQfuidUt41Ng0QbPaD1
         mVs8XrtRSNVJFzxNXol8HXb1Ma19VdvHtRN6+UkMLF+zUX2Xx473Ct8BoujXPLCOZLUC
         bn3uGFYXyJ/zr9//lAnXwL7xyoSTon8y6zSVpYWhr+eozKMZtbqda5UgI3QmgFIrO1Zd
         YKyxwhjDZFUpAYdPyt+KJx7uRos6XsdiC7Pcuwr0vgra5MsYMFH66oPEelSke72VU0pp
         3YrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=3xzJc9WVmPqWhudcS9WHcT6GEhVMfkh1tYjcOjahSJM=;
        b=n2zyv8nz9HgO3DSA1TLhH86xUUKVSmtkbeII/Q+OpJZZBsKIzbzEKKorng3zKjX4YT
         Did2RWm7DRvdcv1534nlBdmzK/29Iq4eH5GXNvAp4d422QcgOuLofZ4W97KYbr5s9GuA
         Nf5DPaI6EtihxVGOjumTw2Q15x+XlPK8mpDGc5BC2ke/s0T5yvGlmp2g7w+f4ieRcpj6
         MktmBG0//qks1E/d3rK8I4v+M1vJaQ2UPoPxYm3+UXP7KGx6K4elWjMDLZksq1q0eeYa
         rpdhXZKrj4iMqRBQwD1x34DyKUwsyTzyxpZkneu6/uW+H30MYujF2ioqU2Q105ViLIcK
         BVIA==
X-Gm-Message-State: AOAM531m1YS74lQLyWED68J2UMAPdG0ZEYkWjsGudyVVaFOuGoL9SoKA
        kUtqImeWCRm26P9iv88mYQx69EqIuArB91o=
X-Google-Smtp-Source: ABdhPJyoCB9KQXUXEpX6sNSGaBxDzYWbw7Gb423pOaj50FGMoev2io4K7mYnRFrbd9SJ+a2G7X1UmDmHSABVYNI=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a5b:c01:: with SMTP id
 f1mr20508861ybq.617.1638505537833; Thu, 02 Dec 2021 20:25:37 -0800 (PST)
Date:   Fri,  3 Dec 2021 04:24:36 +0000
In-Reply-To: <20211203042437.740255-1-sharinder@google.com>
Message-Id: <20211203042437.740255-7-sharinder@google.com>
Mime-Version: 1.0
References: <20211203042437.740255-1-sharinder@google.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [PATCH v1 6/7] Documentation: KUnit: Restyle Test Style and
 Nomenclature page
From:   Harinder Singh <sharinder@google.com>
To:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harinder Singh <sharinder@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rewrite page to enhance content consistency.

Signed-off-by: Harinder Singh <sharinder@google.com>
---
 Documentation/dev-tools/kunit/style.rst | 101 ++++++++++++------------
 1 file changed, 49 insertions(+), 52 deletions(-)

diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-to=
ols/kunit/style.rst
index 8dbcdc552606..8fae192cae28 100644
--- a/Documentation/dev-tools/kunit/style.rst
+++ b/Documentation/dev-tools/kunit/style.rst
@@ -4,37 +4,36 @@
 Test Style and Nomenclature
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
=20
-To make finding, writing, and using KUnit tests as simple as possible, it'=
s
+To make finding, writing, and using KUnit tests as simple as possible, it =
is
 strongly encouraged that they are named and written according to the guide=
lines
-below. While it's possible to write KUnit tests which do not follow these =
rules,
+below. While it is possible to write KUnit tests which do not follow these=
 rules,
 they may break some tooling, may conflict with other tests, and may not be=
 run
 automatically by testing systems.
=20
-It's recommended that you only deviate from these guidelines when:
+It is recommended that you only deviate from these guidelines when:
=20
-1. Porting tests to KUnit which are already known with an existing name, o=
r
-2. Writing tests which would cause serious problems if automatically run (=
e.g.,
-   non-deterministically producing false positives or negatives, or taking=
 an
-   extremely long time to run).
+1. Porting tests to KUnit which are already known with an existing name.
+2. Writing tests which would cause serious problems if automatically run. =
For
+   example, non-deterministically producing false positives or negatives, =
or
+   taking a long time to run.
=20
 Subsystems, Suites, and Tests
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
=20
-In order to make tests as easy to find as possible, they're grouped into s=
uites
-and subsystems. A test suite is a group of tests which test a related area=
 of
-the kernel, and a subsystem is a set of test suites which test different p=
arts
-of the same kernel subsystem or driver.
+To make tests easy to find, they are grouped into suites and subsystems. A=
 test
+suite is a group of tests which test a related area of the kernel. A subsy=
stem
+is a set of test suites which test different parts of a kernel subsystem
+or a driver.
=20
 Subsystems
 ----------
=20
 Every test suite must belong to a subsystem. A subsystem is a collection o=
f one
 or more KUnit test suites which test the same driver or part of the kernel=
. A
-rule of thumb is that a test subsystem should match a single kernel module=
. If
-the code being tested can't be compiled as a module, in many cases the sub=
system
-should correspond to a directory in the source tree or an entry in the
-MAINTAINERS file. If unsure, follow the conventions set by tests in simila=
r
-areas.
+test subsystem should match a single kernel module. If the code being test=
ed
+cannot be compiled as a module, in many cases the subsystem should corresp=
ond to
+a directory in the source tree or an entry in the ``MAINTAINERS`` file. If
+unsure, follow the conventions set by tests in similar areas.
=20
 Test subsystems should be named after the code being tested, either after =
the
 module (wherever possible), or after the directory or files being tested. =
Test
@@ -42,9 +41,8 @@ subsystems should be named to avoid ambiguity where neces=
sary.
=20
 If a test subsystem name has multiple components, they should be separated=
 by
 underscores. *Do not* include "test" or "kunit" directly in the subsystem =
name
-unless you are actually testing other tests or the kunit framework itself.
-
-Example subsystems could be:
+unless we are actually testing other tests or the kunit framework itself. =
For
+example, subsystems could be called:
=20
 ``ext4``
   Matches the module and filesystem name.
@@ -56,13 +54,13 @@ Example subsystems could be:
   Has several components (``snd``, ``hda``, ``codec``, ``hdmi``) separated=
 by
   underscores. Matches the module name.
=20
-Avoid names like these:
+Avoid names as shown in examples below:
=20
 ``linear-ranges``
   Names should use underscores, not dashes, to separate words. Prefer
   ``linear_ranges``.
 ``qos-kunit-test``
-  As well as using underscores, this name should not have "kunit-test" as =
a
+  This name should not use underscores, not have "kunit-test" as a
   suffix, and ``qos`` is ambiguous as a subsystem name. ``power_qos`` woul=
d be a
   better name.
 ``pc_parallel_port``
@@ -70,34 +68,32 @@ Avoid names like these:
   be named ``parport_pc``.
=20
 .. note::
-        The KUnit API and tools do not explicitly know about subsystems. T=
hey're
-        simply a way of categorising test suites and naming modules which
-        provides a simple, consistent way for humans to find and run tests=
. This
-        may change in the future, though.
+        The KUnit API and tools do not explicitly know about subsystems. T=
hey are
+        a way of categorising test suites and naming modules which provide=
s a
+        simple, consistent way for humans to find and run tests. This may =
change
+        in the future.
=20
 Suites
 ------
=20
 KUnit tests are grouped into test suites, which cover a specific area of
 functionality being tested. Test suites can have shared initialisation and
-shutdown code which is run for all tests in the suite.
-Not all subsystems will need to be split into multiple test suites (e.g. s=
imple drivers).
+shutdown code which is run for all tests in the suite. Not all subsystems =
need
+to be split into multiple test suites (for example, simple drivers).
=20
 Test suites are named after the subsystem they are part of. If a subsystem
 contains several suites, the specific area under test should be appended t=
o the
 subsystem name, separated by an underscore.
=20
 In the event that there are multiple types of test using KUnit within a
-subsystem (e.g., both unit tests and integration tests), they should be pu=
t into
-separate suites, with the type of test as the last element in the suite na=
me.
-Unless these tests are actually present, avoid using ``_test``, ``_unittes=
t`` or
-similar in the suite name.
+subsystem (for example, both unit tests and integration tests), they shoul=
d be
+put into separate suites, with the type of test as the last element in the=
 suite
+name. Unless these tests are actually present, avoid using ``_test``, ``_u=
nittest``
+or similar in the suite name.
=20
 The full test suite name (including the subsystem name) should be specifie=
d as
 the ``.name`` member of the ``kunit_suite`` struct, and forms the base for=
 the
-module name (see below).
-
-Example test suites could include:
+module name. For example, test suites could include:
=20
 ``ext4_inode``
   Part of the ``ext4`` subsystem, testing the ``inode`` area.
@@ -109,26 +105,27 @@ Example test suites could include:
   The ``kasan`` subsystem has only one suite, so the suite name is the sam=
e as
   the subsystem name.
=20
-Avoid names like:
+Avoid names, for example:
=20
 ``ext4_ext4_inode``
-  There's no reason to state the subsystem twice.
+  There is no reason to state the subsystem twice.
 ``property_entry``
   The suite name is ambiguous without the subsystem name.
 ``kasan_integration_test``
   Because there is only one suite in the ``kasan`` subsystem, the suite sh=
ould
-  just be called ``kasan``. There's no need to redundantly add
-  ``integration_test``. Should a separate test suite with, for example, un=
it
-  tests be added, then that suite could be named ``kasan_unittest`` or sim=
ilar.
+  just be called as ``kasan``. Do not redundantly add
+  ``integration_test``. It should be a separate test suite. For example, i=
f the
+  unit tests are added, then that suite could be named as ``kasan_unittest=
`` or
+  similar.
=20
 Test Cases
 ----------
=20
 Individual tests consist of a single function which tests a constrained
-codepath, property, or function. In the test output, individual tests' res=
ults
-will show up as subtests of the suite's results.
+codepath, property, or function. In the test output, an individual test's
+results will show up as subtests of the suite's results.
=20
-Tests should be named after what they're testing. This is often the name o=
f the
+Tests should be named after what they are testing. This is often the name =
of the
 function being tested, with a description of the input or codepath being t=
ested.
 As tests are C functions, they should be named and written in accordance w=
ith
 the kernel coding style.
@@ -136,7 +133,7 @@ the kernel coding style.
 .. note::
         As tests are themselves functions, their names cannot conflict wit=
h
         other C identifiers in the kernel. This may require some creative
-        naming. It's a good idea to make your test functions `static` to a=
void
+        naming. It is a good idea to make your test functions `static` to =
avoid
         polluting the global namespace.
=20
 Example test names include:
@@ -150,7 +147,7 @@ Example test names include:
=20
 Should it be necessary to refer to a test outside the context of its test =
suite,
 the *fully-qualified* name of a test should be the suite name followed by =
the
-test name, separated by a colon (i.e. ``suite:test``).
+test name, separated by a colon (``suite:test``).
=20
 Test Kconfig Entries
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -162,16 +159,16 @@ This Kconfig entry must:
 * be named ``CONFIG_<name>_KUNIT_TEST``: where <name> is the name of the t=
est
   suite.
 * be listed either alongside the config entries for the driver/subsystem b=
eing
-  tested, or be under [Kernel Hacking]=E2=86=92[Kernel Testing and Coverag=
e]
-* depend on ``CONFIG_KUNIT``
+  tested, or be under [Kernel Hacking]->[Kernel Testing and Coverage]
+* depend on ``CONFIG_KUNIT``.
 * be visible only if ``CONFIG_KUNIT_ALL_TESTS`` is not enabled.
 * have a default value of ``CONFIG_KUNIT_ALL_TESTS``.
-* have a brief description of KUnit in the help text
+* have a brief description of KUnit in the help text.
=20
-Unless there's a specific reason not to (e.g. the test is unable to be bui=
lt as
-a module), Kconfig entries for tests should be tristate.
+If we are not able to meet above conditions (for example, the test is unab=
le to
+be built as a module), Kconfig entries for tests should be tristate.
=20
-An example Kconfig entry:
+For example, a Kconfig entry might look like:
=20
 .. code-block:: none
=20
@@ -182,8 +179,8 @@ An example Kconfig entry:
 		help
 		  This builds unit tests for foo.
=20
-		  For more information on KUnit and unit tests in general, please refer
-		  to the KUnit documentation in Documentation/dev-tools/kunit/.
+		  For more information on KUnit and unit tests in general,
+		  please refer to the KUnit documentation in Documentation/dev-tools/kun=
it/.
=20
 		  If unsure, say N.
=20
--=20
2.34.0.384.gca35af8252-goog

