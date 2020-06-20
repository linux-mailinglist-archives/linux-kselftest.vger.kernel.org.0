Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEDA2021C0
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jun 2020 07:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgFTFuQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Jun 2020 01:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgFTFuP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Jun 2020 01:50:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC9CC06174E
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 22:50:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c17so12516233ybf.7
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 22:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=w+bw/iadzMNcs/GQEQe/9mn2EUSTk7D5RqaFJzB0X78=;
        b=RPeBtp0uZB7ijB2DxjeIl8lCsyAwavxKk6RzC1k30vLro9n3mEQGKqK3w/BGZ4a91E
         WSBOCAWJ42OVrWsARdMMEcDpWfmCeqNhxyrAUg3S6xzS8BiudGS/EjfiRiYOwanFNJpl
         zKKjJl3jf1SmqZtl1VpB78j1+rgJy2hThWLHubq+zYgy7IPIhU8MmNEn4OrMMn2yZgHs
         pZBxsiPfwoC80GPRRazLLFQvryZsr65aBGY4FTKnWw8z1J3XxK0lW21hplx+WM3SyhMz
         zep5NAsBAxTymIcO4UgR2L+wWeaig3yzlj2qFRG2xVUtrDtEfQQ4Fz4/bUp7bmI5tIOw
         4HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=w+bw/iadzMNcs/GQEQe/9mn2EUSTk7D5RqaFJzB0X78=;
        b=hDulwpoc72D2FnCna6p9aQ+o8MmeJ05K9u/lW3vgpr9tZGwwoHRTk8QtFW02VlrY4z
         VIkDcv7Nr40QmmyrqfVw1lJYwMw+Yt7HfIzf3DajD11CwcjnYL7bXU2OtfLrJ2w0lP9V
         FojDSWEdTaqVkgYSGrsxTCVyCvU7ebKCl0ZmHUYxNX3ghcNNz/Mm31GTE1o9hm3oIUly
         EMTVtBS9fJPmRtjAZVeEu500psoRoOT78nk3xxQncjZhmFwkhKjlierdhYuu9H97VszF
         W2C7yJGxrviArKn1RQuukMGieSfhGGbOrWeYo8k6g1M5hU0tDYai8YJBhY4gUy9DcyF5
         SuWQ==
X-Gm-Message-State: AOAM532Ox3w/zf5Xyy6/2RH8vV8VJbwbheHY3YE1R44bSXPIHJATIdiB
        89KR07X1TUtu0JaeU+3RNJgq1AqbNuNEcw==
X-Google-Smtp-Source: ABdhPJyFj79DgaInQbFMsGvJXfS/+duq+1CJaf/Mdz5KDbTwQgIQpMQPen2lREAJDEwidLg6lwxeocLGbVd/8w==
X-Received: by 2002:a25:7903:: with SMTP id u3mr11230122ybc.416.1592632212416;
 Fri, 19 Jun 2020 22:50:12 -0700 (PDT)
Date:   Fri, 19 Jun 2020 22:49:44 -0700
Message-Id: <20200620054944.167330-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH] Documentation: kunit: Add naming guidelines
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Alan Maguire <alan.maguire@oracle.com>
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
---
This is a first draft of some naming guidelines for KUnit tests. Note
that I haven't edited it for spelling/grammar/style yet: I wanted to get
some feedback on the actual naming conventions first.

The issues which came most to the forefront while writing it were:
- Do we want to make subsystems a more explicit thing (make the KUnit
  framework recognise them, make suites KTAP subtests of them, etc)
  - I'm leaning towards no, mainly because it doesn't seem necessary,
    and it makes the subsystem-with-only-one-suite case ugly.

- Do we want to support (or encourage) Kconfig options and/or modules at
  the subsystem level rather than the suite level?
  - This could be nice: it'd avoid the proliferation of a large number
    of tiny config options and modules, and would encourage the test for
    <module> to be <module>_kunit, without other stuff in-between.

- As test names are also function names, it may actually make sense to
  decorate them with "test" or "kunit" or the like.
  - If we're testing a function "foo", "test_foo" seems like as good a
    name for the function as any. Sure, many cases may could have better
    names like "foo_invalid_context" or something, but that won't make
    sense for everything.
  - Alternatively, do we split up the test name and the name of the
    function implementing the test?

Thoughts?

 Documentation/dev-tools/kunit/index.rst |   1 +
 Documentation/dev-tools/kunit/style.rst | 139 ++++++++++++++++++++++++
 2 files changed, 140 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/style.rst

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-to=
ols/kunit/index.rst
index e93606ecfb01..117c88856fb3 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -11,6 +11,7 @@ KUnit - Unit Testing for the Linux Kernel
 	usage
 	kunit-tool
 	api/index
+        style
 	faq
=20
 What is KUnit?
diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-to=
ols/kunit/style.rst
new file mode 100644
index 000000000000..9363b5607262
--- /dev/null
+++ b/Documentation/dev-tools/kunit/style.rst
@@ -0,0 +1,139 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+Test Style and Nomenclature
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
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
+underscores. Do not include "test" or "kunit" directly in the subsystem na=
me
+unless you are actually testing other tests or the kunit framework itself.
+
+Example subsystems could be:
+
+* ``ext4``
+* ``apparmor``
+* ``kasan``
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
+The full test suite name (including the subsystem name) should be specifie=
d as
+the ``.name`` member of the ``kunit_suite`` struct, and forms the base for=
 the
+module name (see below).
+
+Example test suites could include:
+
+* ``ext4_inode``
+* ``kunit_try_catch``
+* ``apparmor_property_entry``
+* ``kasan``
+
+Tests
+-----
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
+* include "If unsure, say N" in the help text
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
+Test Filenames
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Where possible, test suites should be placed in a separate source file in =
the
+same directory as the code being tested.
+
+This file should be named ``<suite>_kunit.c``. It may make sense to strip
+excessive namespacing from the source filename (e.g., ``firmware_kunit.c``=
 instead of
+``<drivername>_firmware.c``), but please ensure the module name does conta=
in the
+full suite name.
+
+
--=20
2.27.0.111.gc72c7da667-goog

