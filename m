Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08EA467119
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 05:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346669AbhLCE2n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 23:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346187AbhLCE2l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 23:28:41 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5235C061758
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Dec 2021 20:25:17 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id jt9-20020a05621427e900b003c027cd9516so2024572qvb.20
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Dec 2021 20:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fSy/Fps0hC3Qs9JZS/HYn83FATcrawQLmnEKF8iVVq4=;
        b=hTLsaCA1BMIfb2c2IkHZHIEVDs9uacn0E9VWismJp23btd2JnKaQxAOM1uT6lXhuVj
         OyByLVjQX1xJF6uA8VovM+84Mo9FYtKltbM8maNib792tKR0zcy/mQjtcGPI+oh5mmB9
         VPvKg/XOposGqRRWiSRuJTTRVlWEpxw6/wRCUcfQt9U65Nsgf42bY6pDWur3lEFQJ5P/
         PB/wshEQA06zzfXkbRdUA2/pDJp9SqDHwdUmSM+E9T/S9p8ey4xv2WeM+qEaYi6YbrYB
         sZ6Y8KTzdtrhEMPcEq/XTm5V36BMewBdm6ZoZRoPaY69puw3pyTfW4X9RGoJ74Y1elIa
         Ro7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fSy/Fps0hC3Qs9JZS/HYn83FATcrawQLmnEKF8iVVq4=;
        b=vWFIpu7dWMG88xh5tc3FyBAFWDvwbFaYVI+Ay5gDmzGxfDA3u7PubBXYEoyqvwCJfW
         uJ9heJ2SBlepzhVSxIS2FxaZMNd7UxDTd2EimGjb1/RdFey0GH4rjMJPuaJSwkJdG5uw
         ZmLC8Vas4Uq4RsFtmQKawxpzUQ3XgzDPF5Z+zZCDlWQ7K3ITWs6c3J6tDvhJsDDYuMAs
         IUWveXw6udnM25X1jJK3yND/07GHjkJFf3P1C2b4VERhsZaKlf3w9OOwDwVCj/F+E0Zh
         5nb2w+bu8k21129tASO7/s7OyKWZ8H3qUKs6GTa3KV2+ZfZFbKnI/Pt+zM1s42P4S9zK
         kaIQ==
X-Gm-Message-State: AOAM531ARztYB06uPn8yQtTYhlxLqdUJBo0URwE11cCZBEd//e/MWbnO
        WtqfKZSLC/cPSpb7HLTg+lf52jObCk02zSs=
X-Google-Smtp-Source: ABdhPJzjJfQ2iSVTCDCCUshko88P/WMAmsoA4qvqguoxSXX76lVRWdRq2ZwEJNtIm03bWACCb4XgjpJZulynaps=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a05:622a:151:: with SMTP id
 v17mr18532654qtw.167.1638505517045; Thu, 02 Dec 2021 20:25:17 -0800 (PST)
Date:   Fri,  3 Dec 2021 04:24:32 +0000
In-Reply-To: <20211203042437.740255-1-sharinder@google.com>
Message-Id: <20211203042437.740255-3-sharinder@google.com>
Mime-Version: 1.0
References: <20211203042437.740255-1-sharinder@google.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [PATCH v1 2/7] Documentation: KUnit: Rewrite getting started
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

Clarify the purpose of kunit_tool and fixed consistency issues

Signed-off-by: Harinder Singh <sharinder@google.com>
---
 Documentation/dev-tools/kunit/start.rst | 192 ++++++++++++------------
 1 file changed, 98 insertions(+), 94 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 1e00f9226f74..04b6b6a37488 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -4,132 +4,131 @@
 Getting Started
 ===============
 
-Installing dependencies
+Installing Dependencies
 =======================
-KUnit has the same dependencies as the Linux kernel. As long as you can build
-the kernel, you can run KUnit.
+KUnit has the same dependencies as the Linux kernel. As long as you can
+build the kernel, you can run KUnit.
 
-Running tests with the KUnit Wrapper
-====================================
-Included with KUnit is a simple Python wrapper which runs tests under User Mode
-Linux, and formats the test results.
-
-The wrapper can be run with:
+Running tests with kunit_tool
+=============================
+kunit_tool is a Python script, which configures and build a kernel, runs
+tests, and formats the test results. From the kernel repository, you
+can run kunit_tool:
 
 .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run
 
-For more information on this wrapper (also called kunit_tool) check out the
-Documentation/dev-tools/kunit/kunit-tool.rst page.
+For more information on this wrapper, see:
+Documentation/dev-tools/kunit/kunit-tool.rst.
+
+Creating a ``.kunitconfig``
+---------------------------
+If you want to run a specific set of tests (rather than those listed in
+the KUnit ``defconfig``), you can provide Kconfig options in the
+``.kunitconfig`` file. This file contains the regular
+Kernel config with the specific test targets. The
+``.kunitconfig`` also contains any other test specific config options,
+such as test dependencies. For
+example: the ``FAT_FS`` tests - ``FAT_KUNIT_TEST``, depends on
+``FAT_FS``. ``FAT_FS`` can be enabled by selecting either ``MSDOS_FS``
+or ``VFAT_FS``. To run ``FAT_KUNIT_TEST``, the ``.kunitconfig`` has:
+
+.. code-block:: none
 
-Creating a .kunitconfig
------------------------
-If you want to run a specific set of tests (rather than those listed in the
-KUnit defconfig), you can provide Kconfig options in the ``.kunitconfig`` file.
-This file essentially contains the regular Kernel config, with the specific
-test targets as well. The ``.kunitconfig`` should also contain any other config
-options required by the tests.
+	CONFIG_KUNIT=y
+	CONFIG_MSDOS_FS=y
+	CONFIG_FAT_KUNIT_TEST=y
 
-A good starting point for a ``.kunitconfig`` is the KUnit defconfig:
+1. A good starting point for the ``.kunitconfig``, is the KUnit default
+   config. Run the command:
 
 .. code-block:: bash
 
 	cd $PATH_TO_LINUX_REPO
 	cp tools/testing/kunit/configs/default.config .kunitconfig
 
-You can then add any other Kconfig options you wish, e.g.:
+2. You can then add any other Kconfig options, for example:
 
 .. code-block:: none
 
 	CONFIG_LIST_KUNIT_TEST=y
 
-:doc:`kunit_tool <kunit-tool>` will ensure that all config options set in
-``.kunitconfig`` are set in the kernel ``.config`` before running the tests.
-It'll warn you if you haven't included the dependencies of the options you're
-using.
-
-.. note::
-   Note that removing something from the ``.kunitconfig`` will not trigger a
-   rebuild of the ``.config`` file: the configuration is only updated if the
-   ``.kunitconfig`` is not a subset of ``.config``. This means that you can use
-   other tools (such as make menuconfig) to adjust other config options.
-
+Before running the tests, kunit_tool ensures that all config options
+set in ``.kunitconfig`` are set in the kernel ``.config``. It will warn
+you if you have not included dependencies for the options used.
 
-Running the tests (KUnit Wrapper)
----------------------------------
+.. note ::
+   The configuration is only updated if the ``.kunitconfig`` is not a
+   subset of ``.config``. You can use tools (for example:
+   make menuconfig) to adjust other config options.
 
-To make sure that everything is set up correctly, simply invoke the Python
-wrapper from your kernel repo:
+Running Tests (KUnit Wrapper)
+-----------------------------
+1. To make sure that everything is set up correctly, invoke the Python
+   wrapper from your kernel repository:
 
 .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run
 
-.. note::
-   You may want to run ``make mrproper`` first.
-
 If everything worked correctly, you should see the following:
 
-.. code-block:: bash
+.. code-block::
 
 	Generating .config ...
 	Building KUnit Kernel ...
 	Starting KUnit Kernel ...
 
-followed by a list of tests that are run. All of them should be passing.
+The tests will pass or fail.
 
-.. note::
-	Because it is building a lot of sources for the first time, the
-	``Building KUnit kernel`` step may take a while.
+.. note ::
+   Because it is building a lot of sources for the first time, the
+   ``Building KUnit kernel`` may take a while.
 
-Running tests without the KUnit Wrapper
+Running Tests without the KUnit Wrapper
 =======================================
-
-If you'd rather not use the KUnit Wrapper (if, for example, you need to
-integrate with other systems, or use an architecture other than UML), KUnit can
-be included in any kernel, and the results read out and parsed manually.
-
-.. note::
-   KUnit is not designed for use in a production system, and it's possible that
-   tests may reduce the stability or security of the system.
-
-
-
-Configuring the kernel
+If you do not want to use the KUnit Wrapper (for example: you want code
+under test to integrate with other systems, or use a different/
+unsupported architecture or configuration), KUnit can be included in
+any kernel, and the results are read out and parsed manually.
+
+.. note ::
+   ``CONFIG_KUNIT`` should not be enabled in a production environment.
+   Enabling KUnit disables Kernel Address-Space Layout Randomization
+   (KASLR), and tests may affect the state of the kernel not
+   suitable for production.
+
+Configuring the Kernel
 ----------------------
+To enable KUnit itself, you need to enable the ``CONFIG_KUNIT`` Kconfig
+option (under Kernel Hacking/Kernel Testing and Coverage in
+``menuconfig``). From there, you can enable any KUnit tests. They
+usually have config options ending in ``_KUNIT_TEST``.
 
-In order to enable KUnit itself, you simply need to enable the ``CONFIG_KUNIT``
-Kconfig option (it's under Kernel Hacking/Kernel Testing and Coverage in
-menuconfig). From there, you can enable any KUnit tests you want: they usually
-have config options ending in ``_KUNIT_TEST``.
-
-KUnit and KUnit tests can be compiled as modules: in this case the tests in a
-module will be run when the module is loaded.
-
+KUnit and KUnit tests can be compiled as modules. The tests in a module
+will run when the module is loaded.
 
-Running the tests (w/o KUnit Wrapper)
+Running Tests (without KUnit Wrapper)
 -------------------------------------
+Build and run your kernel. In the kernel log, the test output is printed
+out in the TAP format. This will only happen by default if KUnit/tests
+are built-in. Otherwise the module will need to be loaded.
 
-Build and run your kernel as usual. Test output will be written to the kernel
-log in `TAP <https://testanything.org/>`_ format.
+.. note ::
+   Some lines and/or data may get interspersed in the TAP output.
 
-.. note::
-   It's possible that there will be other lines and/or data interspersed in the
-   TAP output.
-
-
-Writing your first test
+Writing Your First Test
 =======================
+In your kernel repository, let's add some code that we can test.
 
-In your kernel repo let's add some code that we can test. Create a file
-``drivers/misc/example.h`` with the contents:
+1. Create a file ``drivers/misc/example.h``, which includes:
 
 .. code-block:: c
 
 	int misc_example_add(int left, int right);
 
-create a file ``drivers/misc/example.c``:
+2. Create a file ``drivers/misc/example.c``, which includes:
 
 .. code-block:: c
 
@@ -142,21 +141,22 @@ create a file ``drivers/misc/example.c``:
 		return left + right;
 	}
 
-Now add the following lines to ``drivers/misc/Kconfig``:
+3. Add the following lines to ``drivers/misc/Kconfig``:
 
 .. code-block:: kconfig
 
 	config MISC_EXAMPLE
 		bool "My example"
 
-and the following lines to ``drivers/misc/Makefile``:
+4. Add the following lines to ``drivers/misc/Makefile``:
 
 .. code-block:: make
 
 	obj-$(CONFIG_MISC_EXAMPLE) += example.o
 
-Now we are ready to write the test. The test will be in
-``drivers/misc/example-test.c``:
+Now we are ready to write the test cases.
+
+1. Add the below test case in ``drivers/misc/example_test.c``:
 
 .. code-block:: c
 
@@ -191,7 +191,7 @@ Now we are ready to write the test. The test will be in
 	};
 	kunit_test_suite(misc_example_test_suite);
 
-Now add the following to ``drivers/misc/Kconfig``:
+2. Add the following lines to ``drivers/misc/Kconfig``:
 
 .. code-block:: kconfig
 
@@ -200,26 +200,26 @@ Now add the following to ``drivers/misc/Kconfig``:
 		depends on MISC_EXAMPLE && KUNIT=y
 		default KUNIT_ALL_TESTS
 
-and the following to ``drivers/misc/Makefile``:
+3. Add the following lines to ``drivers/misc/Makefile``:
 
 .. code-block:: make
 
-	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example-test.o
+	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example_test.o
 
-Now add it to your ``.kunitconfig``:
+4. Add the following lines to ``.kunitconfig``:
 
 .. code-block:: none
 
 	CONFIG_MISC_EXAMPLE=y
 	CONFIG_MISC_EXAMPLE_TEST=y
 
-Now you can run the test:
+5. Run the test:
 
 .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run
 
-You should see the following failure:
+You should see the following failiure:
 
 .. code-block:: none
 
@@ -227,16 +227,20 @@ You should see the following failure:
 	[16:08:57] [PASSED] misc-example:misc_example_add_test_basic
 	[16:08:57] [FAILED] misc-example:misc_example_test_failure
 	[16:08:57] EXPECTATION FAILED at drivers/misc/example-test.c:17
-	[16:08:57] 	This test never passes.
+	[16:08:57]      This test never passes.
 	...
 
-Congrats! You just wrote your first KUnit test!
+Congrats! You just wrote your first KUnit test.
 
 Next Steps
 ==========
-*   Check out the Documentation/dev-tools/kunit/tips.rst page for tips on
-    writing idiomatic KUnit tests.
-*   Check out the :doc:`running_tips` page for tips on
-    how to make running KUnit tests easier.
-*   Optional: see the :doc:`usage` page for a more
-    in-depth explanation of KUnit.
+
+*   Documentation/dev-tools/kunit/usage.rst - KUnit features.
+*   Documentation/dev-tools/kunit/tips.rst - best practices with
+    examples.
+*   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
+    used for testing.
+*   Documentation/dev-tools/kunit/kunit-tool.rst - kunit_tool helper
+    script.
+*   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
+    answers.
-- 
2.34.0.384.gca35af8252-goog

