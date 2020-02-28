Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA9B17402D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2020 20:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgB1TS3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Feb 2020 14:18:29 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:46274 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1TS3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Feb 2020 14:18:29 -0500
Received: by mail-pl1-f201.google.com with SMTP id m9so2257614plt.13
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2020 11:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NyUF6FuGZBhiO9hWmDofMtbaniw79waqWdH7jbhgSu0=;
        b=aXWDQeQ7d2X5+LnPnxpiVAkSy9488VVilwuW+AOspMTCDnve3ODpI3n0Z8VjwyJvPW
         ynxIa8gpPwYy6Zhob9kmv2DizPBnwlFrf8UW5uARvfckuHcXO/3xJR2sZgKUBNux4rQw
         gL6gUjjCL1iCzP+jPdJ+rbYPdjdrvCFuyJwum/+H9PxEkmxNsr6wej6nMvvVviomH6tU
         Xm07z8fIwuOmji/bFWLvkY6kauvMP6H6AWtb3NOG0oV4O57GOscNsF9SdZBJZs0bGi07
         Jr7fy1BI4hHIJqlvJlAHmbMVPhlSevGaUHFBTMS8TFaAZRhYITKIuiBVcibewn32CWpT
         OvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NyUF6FuGZBhiO9hWmDofMtbaniw79waqWdH7jbhgSu0=;
        b=Vp4N9R0M3MsgJzHJMbRFgiBedL8OuZkmKMJKhwgIMqcAtCg7J/s8oUCt44upAKcI+r
         I2w1DnXZRCOAMDoU+UkWmbqRk/nkKqPJh/IJ/BLUY5ofL3TqALaPWABmmiIbushLQ4Pf
         nxvPb5jr8QZl3FDgdnoXrs8i4ry6jZnW0EVPsONG5KF6XI1GlgXdg1uLtrux3AxL1Z2j
         Lb5V59OfHfAeLeH5GoSFx8P8gsKAtriGy2pVj0NazyN9qtxLA8tjhKp42DqOsMeKTa3X
         PA13/n0ghrq8tI+DzO0kIccfvfnN0hn9izjT3WjvdZ+HYfB2bz2rNVnhy/HtOZLtUW8w
         lf8A==
X-Gm-Message-State: APjAAAW7vQRqIv+sL6ucRi4fVgYEaY++L9jvZnwi5ImuQiJDvbmKMzqd
        ZfD+frHIzS/t8Wk1TLBmKc3YbNy2m1j2pA==
X-Google-Smtp-Source: APXvYqxPC72J65p1miUQPRLMJdQESe9G2O2N3dWNk2PcLpSJyIvMLIDsEp2T0dKFV/1wRwMAwIk4816bsr2aSg==
X-Received: by 2002:a63:385c:: with SMTP id h28mr5493858pgn.200.1582917507543;
 Fri, 28 Feb 2020 11:18:27 -0800 (PST)
Date:   Fri, 28 Feb 2020 11:18:21 -0800
Message-Id: <20200228191821.42412-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v4] Documentation: kunit: Make the KUnit documentation less UML-specific
From:   David Gow <davidgow@google.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        corbet@lwn.net
Cc:     kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        frowand.list@gmail.com, Tim.Bird@sony.com,
        David Gow <davidgow@google.com>,
        Frank Rowand <frank.rowand@sony.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove some of the outmoded "Why KUnit" rationale, and move some
UML-specific information to the kunit_tool page. Also update the Getting
Started guide to mention running tests without the kunit_tool wrapper.

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Frank Rowand <frank.rowand@sony.com>
---
Sorry: I missed a couple of issues in the last version. They're fixed
here, and I think this should be ready to go.

Changelog:

v4:
- Fix typo: s/offsers/offers
- Talk about KUnit tests running on most "architectures" instead of
  "kernel configurations.
v3:
https://lore.kernel.org/linux-kselftest/20200214235723.254228-1-davidgow@google.com/T/#u
- Added a note that KUnit can be used with UML, both with and without
  kunit_tool to replace the section moved to kunit_tool.
v2:
https://lore.kernel.org/linux-kselftest/f99a3d4d-ad65-5fd1-3407-db33f378b1fa@gmail.com/T/
- Reinstated the "Why Kunit?" section, minus the comparison with other
  testing frameworks (covered in the FAQ), and the description of UML.
- Moved the description of UML into to kunit_tool page.
- Tidied up the wording around how KUnit is built and run to make it
  work
  without the UML description.
v1:
https://lore.kernel.org/linux-kselftest/9c703dea-a9e1-94e2-c12d-3cb0a09e75ac@gmail.com/T/
- Initial patch

 Documentation/dev-tools/kunit/index.rst      | 40 ++++++----
 Documentation/dev-tools/kunit/kunit-tool.rst |  7 ++
 Documentation/dev-tools/kunit/start.rst      | 80 ++++++++++++++++----
 3 files changed, 99 insertions(+), 28 deletions(-)

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index d16a4d2c3a41..e93606ecfb01 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -17,14 +17,23 @@ What is KUnit?
 ==============
 
 KUnit is a lightweight unit testing and mocking framework for the Linux kernel.
-These tests are able to be run locally on a developer's workstation without a VM
-or special hardware.
 
 KUnit is heavily inspired by JUnit, Python's unittest.mock, and
 Googletest/Googlemock for C++. KUnit provides facilities for defining unit test
 cases, grouping related test cases into test suites, providing common
 infrastructure for running tests, and much more.
 
+KUnit consists of a kernel component, which provides a set of macros for easily
+writing unit tests. Tests written against KUnit will run on kernel boot if
+built-in, or when loaded if built as a module. These tests write out results to
+the kernel log in `TAP <https://testanything.org/>`_ format.
+
+To make running these tests (and reading the results) easier, KUnit offers
+:doc:`kunit_tool <kunit-tool>`, which builds a `User Mode Linux
+<http://user-mode-linux.sourceforge.net>`_ kernel, runs it, and parses the test
+results. This provides a quick way of running KUnit tests during development,
+without requiring a virtual machine or separate hardware.
+
 Get started now: :doc:`start`
 
 Why KUnit?
@@ -36,21 +45,20 @@ allow all possible code paths to be tested in the code under test; this is only
 possible if the code under test is very small and does not have any external
 dependencies outside of the test's control like hardware.
 
-Outside of KUnit, there are no testing frameworks currently
-available for the kernel that do not require installing the kernel on a test
-machine or in a VM and all require tests to be written in userspace running on
-the kernel; this is true for Autotest, and kselftest, disqualifying
-any of them from being considered unit testing frameworks.
+KUnit provides a common framework for unit tests within the kernel.
+
+KUnit tests can be run on most architectures, and most tests are architecture
+independent. All built-in KUnit tests run on kernel startup.  Alternatively,
+KUnit and KUnit tests can be built as modules and tests will run when the test
+module is loaded.
 
-KUnit addresses the problem of being able to run tests without needing a virtual
-machine or actual hardware with User Mode Linux. User Mode Linux is a Linux
-architecture, like ARM or x86; however, unlike other architectures it compiles
-to a standalone program that can be run like any other program directly inside
-of a host operating system; to be clear, it does not require any virtualization
-support; it is just a regular program.
+.. note::
 
-Alternatively, kunit and kunit tests can be built as modules and tests will
-run when the test module is loaded.
+        KUnit can also run tests without needing a virtual machine or actual
+        hardware under User Mode Linux. User Mode Linux is a Linux architecture,
+        like ARM or x86, which compiles the kernel as a Linux executable. KUnit
+        can be used with UML either by building with ``ARCH=um`` (like any other
+        architecture), or by using :doc:`kunit_tool <kunit-tool>`.
 
 KUnit is fast. Excluding build time, from invocation to completion KUnit can run
 several dozen tests in only 10 to 20 seconds; this might not sound like a big
@@ -81,3 +89,5 @@ How do I use it?
 *   :doc:`start` - for new users of KUnit
 *   :doc:`usage` - for a more detailed explanation of KUnit features
 *   :doc:`api/index` - for the list of KUnit APIs used for testing
+*   :doc:`kunit-tool` - for more information on the kunit_tool helper script
+*   :doc:`faq` - for answers to some common questions about KUnit
diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
index 50d46394e97e..949af2da81e5 100644
--- a/Documentation/dev-tools/kunit/kunit-tool.rst
+++ b/Documentation/dev-tools/kunit/kunit-tool.rst
@@ -12,6 +12,13 @@ the Linux kernel as UML (`User Mode Linux
 <http://user-mode-linux.sourceforge.net/>`_), running KUnit tests, parsing
 the test results and displaying them in a user friendly manner.
 
+kunit_tool addresses the problem of being able to run tests without needing a
+virtual machine or actual hardware with User Mode Linux. User Mode Linux is a
+Linux architecture, like ARM or x86; however, unlike other architectures it
+compiles the kernel as a standalone Linux executable that can be run like any
+other program directly inside of a host operating system. To be clear, it does
+not require any virtualization support: it is just a regular program.
+
 What is a kunitconfig?
 ======================
 
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 4e1d24db6b13..e1c5ce80ce12 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -9,11 +9,10 @@ Installing dependencies
 KUnit has the same dependencies as the Linux kernel. As long as you can build
 the kernel, you can run KUnit.
 
-KUnit Wrapper
-=============
-Included with KUnit is a simple Python wrapper that helps format the output to
-easily use and read KUnit output. It handles building and running the kernel, as
-well as formatting the output.
+Running tests with the KUnit Wrapper
+====================================
+Included with KUnit is a simple Python wrapper which runs tests under User Mode
+Linux, and formats the test results.
 
 The wrapper can be run with:
 
@@ -21,22 +20,42 @@ The wrapper can be run with:
 
 	./tools/testing/kunit/kunit.py run --defconfig
 
-For more information on this wrapper (also called kunit_tool) checkout the
+For more information on this wrapper (also called kunit_tool) check out the
 :doc:`kunit-tool` page.
 
 Creating a .kunitconfig
-=======================
-The Python script is a thin wrapper around Kbuild. As such, it needs to be
-configured with a ``.kunitconfig`` file. This file essentially contains the
-regular Kernel config, with the specific test targets as well.
-
+-----------------------
+If you want to run a specific set of tests (rather than those listed in the
+KUnit defconfig), you can provide Kconfig options in the ``.kunitconfig`` file.
+This file essentially contains the regular Kernel config, with the specific
+test targets as well. The ``.kunitconfig`` should also contain any other config
+options required by the tests.
+
+A good starting point for a ``.kunitconfig`` is the KUnit defconfig:
 .. code-block:: bash
 
 	cd $PATH_TO_LINUX_REPO
 	cp arch/um/configs/kunit_defconfig .kunitconfig
 
-Verifying KUnit Works
----------------------
+You can then add any other Kconfig options you wish, e.g.:
+.. code-block:: none
+
+        CONFIG_LIST_KUNIT_TEST=y
+
+:doc:`kunit_tool <kunit-tool>` will ensure that all config options set in
+``.kunitconfig`` are set in the kernel ``.config`` before running the tests.
+It'll warn you if you haven't included the dependencies of the options you're
+using.
+
+.. note::
+   Note that removing something from the ``.kunitconfig`` will not trigger a
+   rebuild of the ``.config`` file: the configuration is only updated if the
+   ``.kunitconfig`` is not a subset of ``.config``. This means that you can use
+   other tools (such as make menuconfig) to adjust other config options.
+
+
+Running the tests
+-----------------
 
 To make sure that everything is set up correctly, simply invoke the Python
 wrapper from your kernel repo:
@@ -62,6 +81,41 @@ followed by a list of tests that are run. All of them should be passing.
 	Because it is building a lot of sources for the first time, the
 	``Building KUnit kernel`` step may take a while.
 
+Running tests without the KUnit Wrapper
+=======================================
+
+If you'd rather not use the KUnit Wrapper (if, for example, you need to
+integrate with other systems, or use an architecture other than UML), KUnit can
+be included in any kernel, and the results read out and parsed manually.
+
+.. note::
+   KUnit is not designed for use in a production system, and it's possible that
+   tests may reduce the stability or security of the system.
+
+
+
+Configuring the kernel
+----------------------
+
+In order to enable KUnit itself, you simply need to enable the ``CONFIG_KUNIT``
+Kconfig option (it's under Kernel Hacking/Kernel Testing and Coverage in
+menuconfig). From there, you can enable any KUnit tests you want: they usually
+have config options ending in ``_KUNIT_TEST``.
+
+KUnit and KUnit tests can be compiled as modules: in this case the tests in a
+module will be run when the module is loaded.
+
+Running the tests
+-----------------
+
+Build and run your kernel as usual. Test output will be written to the kernel
+log in `TAP <https://testanything.org/>`_ format.
+
+.. note::
+   It's possible that there will be other lines and/or data interspersed in the
+   TAP output.
+
+
 Writing your first test
 =======================
 
-- 
2.25.1.481.gfbce0eb801-goog

