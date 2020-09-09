Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45ACC2626A5
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Sep 2020 07:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgIIFQy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Sep 2020 01:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgIIFQu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Sep 2020 01:16:50 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9552DC061573
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Sep 2020 22:16:49 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id bo17so739776qvb.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Sep 2020 22:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=hZkaguA2IJiB+Yz+ysCYxUfYklcLU1iNq8wPCuV5FAw=;
        b=k9HixUQw5zlv5PBtnMXtho9JIjhYUS/sPo5INqnL78/8CsavL5dEH7CdYvwdr3qcby
         kTo+9kfXEj7tdWxsu9eFCsH5MqgSazUhd7v4RB5+iog3DdTrW+oaPMg59VcqMuki5gfr
         fVCtRrhjvRJAVnjzrCNZIzOyD8e66Qd8n8I/FAsGcz4bDueRjMnn5Utkprg3IrAiDkj9
         gHUHioXuqCU0jTLKl/4uqucNP9OEoMnzuVZVkOerHaB41BppE3lzBpyFBoSZbKL8xBCg
         N4UrozDOd2dU4gy+/IFpA3YsBvjEMcFIQF4aIf5VbsPIRvortcRlHMOh37LJ2/Hk6bCu
         j7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc:content-transfer-encoding;
        bh=hZkaguA2IJiB+Yz+ysCYxUfYklcLU1iNq8wPCuV5FAw=;
        b=RT5CGiHFUBDPrsmgqGOqzXAgG3suUMKNA2p74d+J4oTKk0zqxqWJ3a1rEYGLLIQ0I6
         +1l4GM4x93Jt3/JllfEp8a9gbLmuZXiPbtjxhtD+gyNxYJ0iZWDd6VRX55m1y76hvzYk
         zK1oMuEs7LZd5eU3mD8Oa/oXdFFpLcNXHpsDuAL7poNww05SQNa322g6co90uJv3Hybt
         GjdpCUcfS2r5NnAf+oISSIPc/+n/5V8fbD9U/ZPPZaFG1s4XbZ4FbanihQg8XwyDPfkH
         bLaUtKxAEQvpW/PntbvXI6Wc9EnGImFsEJQlLJpa0xlnShLrpRmpJmt+/1GWZwxqFtPr
         +RxA==
X-Gm-Message-State: AOAM531/AZ8X1z9BSGXRmaR8HtBu5W/FcEDwBt/ba7Y6ghZ+px8q5reI
        kxivq8o2D7mjLaffjJE0Krc1qtTg2m06rA==
X-Google-Smtp-Source: ABdhPJzeLN3zjFSA5UGr1FF9hLvAsmUobP1sITK9TIP9ruN/fVZ3BYJPGR1LwuSKWsDdgx0ZACpmPxNEvAaBPw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a0c:8001:: with SMTP id
 1mr2556215qva.21.1599628608615; Tue, 08 Sep 2020 22:16:48 -0700 (PDT)
Date:   Tue,  8 Sep 2020 22:16:31 -0700
Message-Id: <20200909051631.2960347-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2] Documentation: kunit: Add naming guidelines
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tim Bird <Tim.Bird@sony.com>,
        Marco Elver <elver@google.com>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As discussed in [1], KUnit tests have hitherto not had a particularly
consistent naming scheme. This adds documentation outlining how tests
and test suites should be named, including how those names should be
used in Kconfig entries and filenames.

[1]:
https://lore.kernel.org/linux-kselftest/202006141005.BA19A9D3@keescook/t/#u

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---

This is v2 of the KUnit test nomenclature guidelines. The guidelines have
changed a bit in response to the discussion on the v1 thread which came
about after plumbers. The major change is that the filename suffix is
now "_test", with "_kunit" permitted where it conflicts. There are also
some other exceptions carved out around existing tests, and very
non-unit-like tests.

Changelog:

v2:
- Rewrote the filename section to use "_test" as a suffix, and focus on
  module names, not filenames.
- Add a motivating introduction, which also calls out existing tests and
  tests which cause problems when run automatically (long running,
  flaky tests) as reasons to avoid the guidelines.
- Talk about including the type of test in the suite name, but only if
  theres an actual confict. (And update the example for this).

v1:
https://lore.kernel.org/linux-kselftest/20200702071416.1780522-1-davidgow@g=
oogle.com/
- Fixed a bit of space/tab confusion in the index (Thanks, Randy)
- Added some more examples (and some test case examples).
- Added some examples of what not to call subsystems and suites.
- No longer explicitly require "If unsure, put N" in Kconfig entries.
- Minor formatting changes

RFC:
https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@go=
ogle.com/T/#u
- Initial version


The result is a little bit weaker than the previous versions, but
hopefully will let us get the areas we agree on down.

-- David


 Documentation/dev-tools/kunit/index.rst |   1 +
 Documentation/dev-tools/kunit/style.rst | 207 ++++++++++++++++++++++++
 2 files changed, 208 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/style.rst

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-to=
ols/kunit/index.rst
index e93606ecfb01..c234a3ab3c34 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -11,6 +11,7 @@ KUnit - Unit Testing for the Linux Kernel
 	usage
 	kunit-tool
 	api/index
+	style
 	faq
=20
 What is KUnit?
diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-to=
ols/kunit/style.rst
new file mode 100644
index 000000000000..c001ea1cd87d
--- /dev/null
+++ b/Documentation/dev-tools/kunit/style.rst
@@ -0,0 +1,207 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+Test Style and Nomenclature
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+To make finding, writing, and using KUnit tests as simple as possible, it'=
s
+strongly encouraged that they are named and written according to the guide=
lines
+below. While it's possible to write KUnit tests which do not follow these =
rules,
+they may break some tooling, may conflict with other tests, and may not be=
 run
+automatically by testing systems.
+
+It's recommended that you only deviate from these guidelines when:
+
+1. Porting tests to KUnit which are already known with an existing name, o=
r
+2. Writing tests which would cause serious problems if automatically run (=
e.g.,
+   nonderministically producing false positives or negatives, or taking an
+   extremely long time to run).
+
+Subsystems, Suites, and Tests
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+In order to make tests as easy to find as possible, they're grouped into s=
uites
+and subsystems. A test suite is a group of tests which test a related area=
 of
+the kernel, and a subsystem is a set of test suites which test different p=
arts
+of the same kernel subsystem or driver.
+
+Subsystems
+----------
+
+Every test suite must belong to a subsystem. A subsystem is a collection o=
f one
+or more KUnit test suites which test the same driver or part of the kernel=
. A
+rule of thumb is that a test subsystem should match a single kernel module=
. If
+the code being tested can't be compiled as a module, in many cases the sub=
system
+should correspond to a directory in the source tree or an entry in the
+MAINTAINERS file. If unsure, follow the conventions set by tests in simila=
r
+areas.
+
+Test subsystems should be named after the code being tested, either after =
the
+module (wherever possible), or after the directory or files being tested. =
Test
+subsystems should be named to avoid ambiguity where necessary.
+
+If a test subsystem name has multiple components, they should be separated=
 by
+underscores. *Do not* include "test" or "kunit" directly in the subsystem =
name
+unless you are actually testing other tests or the kunit framework itself.
+
+Example subsystems could be:
+
+``ext4``
+  Matches the module and filesystem name.
+``apparmor``
+  Matches the module name and LSM name.
+``kasan``
+  Common name for the tool, prominent part of the path ``mm/kasan``
+``snd_hda_codec_hdmi``
+  Has several components (``snd``, ``hda``, ``codec``, ``hdmi``) separated=
 by
+  underscores. Matches the module name.
+
+Avoid names like these:
+
+``linear-ranges``
+  Names should use underscores, not dashes, to separate words. Prefer
+  ``linear_ranges``.
+``qos-kunit-test``
+  As well as using underscores, this name should not have "kunit-test" as =
a
+  suffix, and ``qos`` is ambiguous as a subsystem name. ``power_qos`` woul=
d be a
+  better name.
+``pc_parallel_port``
+  The corresponding module name is ``parport_pc``, so this subsystem shoul=
d also
+  be named ``parport_pc``.
+
+.. note::
+        The KUnit API and tools do not explicitly know about subsystems. T=
hey're
+        simply a way of categorising test suites and naming modules which
+        provides a simple, consistent way for humans to find and run tests=
. This
+        may change in the future, though.
+
+Suites
+------
+
+KUnit tests are grouped into test suites, which cover a specific area of
+functionality being tested. Test suites can have shared initialisation and
+shutdown code which is run for all tests in the suite.
+Not all subsystems will need to be split into multiple test suites (e.g. s=
imple drivers).
+
+Test suites are named after the subsystem they are part of. If a subsystem
+contains several suites, the specific area under test should be appended t=
o the
+subsystem name, separated by an underscore.
+
+In the event that there are multiple types of test using KUnit within a
+subsystem (e.g., both unit tests and integration tests), they should be pu=
t into
+separate suites, with the type of test as the last element in the suite na=
me.
+Unless these tests are actually present, avoid using ``_test``, ``_unittes=
t`` or
+similar in the suite name.
+
+The full test suite name (including the subsystem name) should be specifie=
d as
+the ``.name`` member of the ``kunit_suite`` struct, and forms the base for=
 the
+module name (see below).
+
+Example test suites could include:
+
+``ext4_inode``
+  Part of the ``ext4`` subsystem, testing the ``inode`` area.
+``kunit_try_catch``
+  Part of the ``kunit`` implementation itself, testing the ``try_catch`` a=
rea.
+``apparmor_property_entry``
+  Part of the ``apparmor`` subsystem, testing the ``property_entry`` area.
+``kasan``
+  The ``kasan`` subsystem has only one suite, so the suite name is the sam=
e as
+  the subsystem name.
+
+Avoid names like:
+
+``ext4_ext4_inode``
+  There's no reason to state the subsystem twice.
+``property_entry``
+  The suite name is ambiguous without the subsystem name.
+``kasan_integration_test``
+  Because there is only one suite in the ``kasan`` subsystem, the suite sh=
ould
+  just be called ``kasan``. There's no need to redundantly add
+  ``integration_test``. Should a separate test suite with, for example, un=
it
+  tests be added, then that suite could be named ``kasan_unittest`` or sim=
ilar.
+
+Test Cases
+----------
+
+Individual tests consist of a single function which tests a constrained
+codepath, property, or function. In the test output, individual tests' res=
ults
+will show up as subtests of the suite's results.
+
+Tests should be named after what they're testing. This is often the name o=
f the
+function being tested, with a description of the input or codepath being t=
ested.
+As tests are C functions, they should be named and written in accordance w=
ith
+the kernel coding style.
+
+.. note::
+        As tests are themselves functions, their names cannot conflict wit=
h
+        other C identifiers in the kernel. This may require some creative
+        naming. It's a good idea to make your test functions `static` to a=
void
+        polluting the global namespace.
+
+Example test names include:
+
+``unpack_u32_with_null_name``
+  Tests the ``unpack_u32`` function when a NULL name is passed in.
+``test_list_splice``
+  Tests the ``list_splice`` macro. It has the prefix ``test_`` to avoid a
+  name conflict with the macro itself.
+
+
+Should it be necessary to refer to a test outside the context of its test =
suite,
+the *fully-qualified* name of a test should be the suite name followed by =
the
+test name, separated by a colon (i.e. ``suite:test``).
+
+Test Kconfig Entries
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Every test suite should be tied to a Kconfig entry.
+
+This Kconfig entry must:
+
+* be named ``CONFIG_<name>_KUNIT_TEST``: where <name> is the name of the t=
est
+  suite.
+* be listed either alongside the config entries for the driver/subsystem b=
eing
+  tested, or be under [Kernel Hacking]=E2=86=92[Kernel Testing and Coverag=
e]
+* depend on ``CONFIG_KUNIT``
+* be visible only if ``CONFIG_KUNIT_ALL_TESTS`` is not enabled.
+* have a default value of ``CONFIG_KUNIT_ALL_TESTS``.
+* have a brief description of KUnit in the help text
+
+Unless there's a specific reason not to (e.g. the test is unable to be bui=
lt as
+a module), Kconfig entries for tests should be tristate.
+
+An example Kconfig entry:
+
+.. code-block:: none
+
+        config FOO_KUNIT_TEST
+                tristate "KUnit test for foo" if !KUNIT_ALL_TESTS
+                depends on KUNIT
+                default KUNIT_ALL_TESTS
+                help
+                    This builds unit tests for foo.
+
+                    For more information on KUnit and unit tests in genera=
l, please refer
+                    to the KUnit documentation in Documentation/dev-tools/=
kunit
+
+                    If unsure, say N
+
+
+Test File and Module Names
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
+KUnit tests can often be compiled as a module. These modules should be nam=
ed
+after the test suite, followed by ``_test``. If this is likely to conflict=
 with
+non-KUnit tests, the suffic ``_kunit`` can also be used.
+
+The easiest way of achieving this is to name the file containing the test =
suite
+``<suite>_test.c`` (or, as above, ``<suite>_kunit.c``). This file should b=
e
+placed next to the code under test.
+
+If the suite name contains some or all of the name of the test's parent
+directory, it may make sense to modify the source filename to reduce redun=
dancy.
+For example, a ``foo_firmware`` suite could be in the ``foo/firmware_test.=
c``
+file.
+
+
--=20
2.28.0.526.ge36021eeef-goog

