Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C119660934E
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Oct 2022 15:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiJWNK2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Oct 2022 09:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJWNKO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Oct 2022 09:10:14 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD8A3B96F;
        Sun, 23 Oct 2022 06:10:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d10so6879410pfh.6;
        Sun, 23 Oct 2022 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vJjSOBwWKd48xSylazpwkm6EPjFpvkm4tEsXJ6mBNY=;
        b=P1soqzH7T7eLdsYv5gwkYyTkQj+2rv30evQvOV1NjvgmlWhVseOSTSHC1/wU51c/uP
         99pzPWYGJ1tBU5E+gTUsgomFLrlMtWYExKdSTomf6LqZJCV0/nX0RNl7i3Q8BBc5sqg2
         K4Za+uqivu+v1qz/hfT+eYnxSIODTbZZzz84tBrFFEsR3WOJBs91w2OoWAXGHFXw9c3M
         xPaWvKjQilX8FwWo0ek4CNHwIgv9ujAMqVz3YWLriNi/6heEWLZitpWITDa2ayeELkeF
         m6m/HTFDoJ5KklXrRcA9jwEcBH2zsqsCmpk1aTACZoIAAVQjHg5Op1AtbQ3Vnw2bS74p
         EFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vJjSOBwWKd48xSylazpwkm6EPjFpvkm4tEsXJ6mBNY=;
        b=mlTpWBWL5rmPshbON5Q6kvKQUcCVgwj1P4vWorHWZpjtKv6bFfTrd/dy7PmEwj5seX
         w0hDjxVbmVBdY6KEFu1f/Iw0pcrMh1hWVPzm9j7vT7nnRiT68y2fi/Hg+dUZJDc6gbKT
         riau5TCBvGi7Ysuk7KSLFqGugJB+hAYJPOwdfmUOxevAYSLIfGqpWI+BBIjcFXTh2xCu
         wPeG/iTPwKZRP0tEH2V3gjkdGBm9+LGHMQBGKKT0a3S+3ARc4Z+axLio3+MDi2JZMurr
         e7A6J+bfNuuavfe6tRC/lBdIrhBI38rKH6nDe2GcXfZf6cd9XYqMy+Fd1DDqafYTqFPI
         FRsA==
X-Gm-Message-State: ACrzQf2fMokFLPOXtLflgiZ65KJi4uaPNyVPTc+TVpaEb+0L6fcGqvrS
        76BCtYbynJXFpD6il9yzr7p4C0jQFnGYJA==
X-Google-Smtp-Source: AMsMyM65f1LcqlTWVoN89y85Kui3FEyXtagCBBUCKyBtbXrxd5EXtZW5/1QLwRoihqkmG+MiLGqxKA==
X-Received: by 2002:a63:82c3:0:b0:46e:c4e4:f8cb with SMTP id w186-20020a6382c3000000b0046ec4e4f8cbmr8274020pgd.155.1666530603362;
        Sun, 23 Oct 2022 06:10:03 -0700 (PDT)
Received: from debian.. (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id d5-20020a623605000000b0056b6c7a17c6sm3411713pfa.12.2022.10.23.06.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 06:10:03 -0700 (PDT)
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
Subject: [PATCH RESEND 3/7] Documentation: kunit: rewrite the rest of "Getting Started" documentation
Date:   Sun, 23 Oct 2022 20:08:43 +0700
Message-Id: <20221023130846.63296-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221023130846.63296-1-bagasdotme@gmail.com>
References: <20221023130846.63296-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14213; i=bagasdotme@gmail.com; h=from:subject; bh=KHKCvMsVjuqrd8vApmXHIpqnqVrG7j8/yR7ng37u1b8=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmhNrcnlJ0t2N93nyutoz37sUNPbXHsBTemWcwpky/PefIm 1Sq7o5SFQYyDQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABPhvcnwz0zZ/HtgyqR9f+ZI3fbuPl d+LYG906/Gv7ktScbnTUlyESPDfO36muBevsvh8Qd19EM3hZ2JaT98aLrJnGLGw7vqJn9hAgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
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

Rewrite the rest of "Getting Started" documentation for clarity. Major
points:

  * link to "Build directory for the kernel" section of kernel README
    for the caveats.
  * To change kernel configurations in .kunitconfig, use configuration
    interfaces just like configuring normal kernel.
  * Remove "Next steps" section as it will be placed on the introduction
    page.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/README.rst    |   2 +
 Documentation/dev-tools/kunit/start.rst | 210 ++++++++++--------------
 2 files changed, 93 insertions(+), 119 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 9a969c0157f1e5..f3cdc8496da03f 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -123,6 +123,8 @@ Software requirements
    you can just update packages when obvious problems arise during
    build or operation.
 
+.. _kernel-build-directory:
+
 Build directory for the kernel
 ------------------------------
 
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index cdf043b6550e66..1195d5de53343e 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -4,178 +4,164 @@
 Getting Started
 ===============
 
-This page contains an overview of the kunit_tool and KUnit framework,
-teaching how to run existing tests and then how to write a simple test case,
-and covers common problems users face when using KUnit for the first time.
+This guide is an overview of KUnit framework. It teaches how to run tests
+with kunit_tool as well as writing a simple test case.
 
-Installing Dependencies
-=======================
-KUnit has the same dependencies as the Linux kernel. As long as you can
-build the kernel, you can run KUnit.
+Prerequisites
+=============
+No extra dependencies are required in order to use KUnit. See
+:doc:`/process/changes` for details.
 
 Running tests with kunit_tool
 =============================
-kunit_tool is a Python script, which configures and builds a kernel, runs
-tests, and formats the test results. From the kernel repository, you
-can run kunit_tool:
+kunit_tool is a wrapper script written in Python. It configures and builds
+the kernel, runs tests, and formats the results. To run the script:
 
 .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run
 
 .. note ::
-	You may see the following error:
-	"The source tree is not clean, please run 'make ARCH=um mrproper'"
+	You may see the following error::
 
-	This happens because internally kunit.py specifies ``.kunit``
-	(default option) as the build directory in the command ``make O=output/dir``
-	through the argument ``--build_dir``.  Hence, before starting an
-	out-of-tree build, the source tree must be clean.
+	    The source tree is not clean, please run 'make ARCH=um mrproper'
 
-	There is also the same caveat mentioned in the "Build directory for
-	the kernel" section of the :doc:`admin-guide </admin-guide/README>`,
-	that is, its use, it must be used for all invocations of ``make``.
-	The good news is that it can indeed be solved by running
-	``make ARCH=um mrproper``, just be aware that this will delete the
-	current configuration and all generated files.
+        This happens because internally kunit_tool passes the default build
+        directory ``.kunit`` as environment variable to make (which is invoked
+        as ``make O=.kunit``). A different build directory can be specified by
+        passing ``--build_dir`` option. Hence, before starting the build,
+        the source tree must be clean.
 
-If everything worked correctly, you should see the following:
+	The caveat from the :ref:`kernel-build-directory`
+        also applies to running kunit_tool.
 
-.. code-block::
+If everything worked correctly, you should see the following output::
 
 	Configuring KUnit Kernel ...
 	Building KUnit Kernel ...
 	Starting KUnit Kernel ...
 
-The tests will pass or fail.
+.. note ::
+        Depending on configurations enabled in the kernel, the build process
+        may take a while.
+
+See Documentation/dev-tools/kunit/run_wrapper.rst for details.
+
+Selecting tests
+---------------
+
+By default, kunit_tool runs all tests using default configuration (defconfig).
+The following subsections allow you to customize the configuration as well as
+filtering the test that will be run.
 
 .. note ::
-   Because it is building a lot of sources for the first time,
-   the ``Building KUnit Kernel`` step may take a while.
+        KUnit by default runs tests for UML architecture (``ARCH=um``). If you
+        need to run test on other architectures see :ref:`kunit-on-qemu`.
 
-For detailed information on this wrapper, see:
-Documentation/dev-tools/kunit/run_wrapper.rst.
-
-Selecting which tests to run
-----------------------------
-
-By default, kunit_tool runs all tests reachable with minimal configuration,
-that is, using default values for most of the kconfig options.  However,
-you can select which tests to run by:
-
-- `Customizing Kconfig`_ used to compile the kernel, or
-- `Filtering tests by name`_ to select specifically which compiled tests to run.
-
-Customizing Kconfig
-~~~~~~~~~~~~~~~~~~~
-A good starting point for the ``.kunitconfig`` is the KUnit default config.
-If you didn't run ``kunit.py run`` yet, you can generate it by running:
+Kernel configuration
+~~~~~~~~~~~~~~~~~~~~
+A good starting point for the ``.kunitconfig`` is the KUnit default config,
+which can be generated by:
 
 .. code-block:: bash
 
-	cd $PATH_TO_LINUX_REPO
-	tools/testing/kunit/kunit.py config
-	cat .kunit/.kunitconfig
+	./tools/testing/kunit/kunit.py config
 
 .. note ::
-   ``.kunitconfig`` lives in the ``--build_dir`` used by kunit.py, which is
-   ``.kunit`` by default.
+   ``.kunitconfig`` is located in the directory specified by ``--build_dir``
+   argument. The default build directory is ``.kunit``.
 
-Before running the tests, kunit_tool ensures that all config options
-set in ``.kunitconfig`` are set in the kernel ``.config``. It will warn
-you if you have not included dependencies for the options used.
+Before running the tests, kunit_tool ensures that all options set in
+``.kunitconfig`` are set in the ``.config`` used for kernel build process. It
+will errored if you have not enabled option dependencies for all selected
+options.
 
 There are many ways to customize the configurations:
 
-a. Edit ``.kunit/.kunitconfig``. The file should contain the list of kconfig
+a. Edit the configuration. ``.kunitconfig`` should contains configuration
    options required to run the desired tests, including their dependencies.
-   You may want to remove CONFIG_KUNIT_ALL_TESTS from the ``.kunitconfig`` as
-   it will enable a number of additional tests that you may not want.
-   If you need to run on an architecture other than UML see :ref:`kunit-on-qemu`.
-
-b. Enable additional kconfig options on top of ``.kunit/.kunitconfig``.
-   For example, to include the kernel's linked-list test you can run::
+   As with other kernel configurations, it is recommended to use :doc:`one of
+   configuration interfaces </kbuild/kconfig>`, passing
+   ``KCONFIG_CONFIG=.kunit/.kunitconfig`` target variable to make. You may
+   want to disable ``CONFIG_KUNIT_ALL_TESTS`` as it will enable a number of
+   additional tests that you may not want to be run.
+   
+b. Add options with ``--kconfig_add``. For example, to include the
+   linked-list test you can run::
 
 	./tools/testing/kunit/kunit.py run \
 		--kconfig_add CONFIG_LIST_KUNIT_TEST=y
 
-c. Provide the path of one or more .kunitconfig files from the tree.
-   For example, to run only ``FAT_FS`` and ``EXT4`` tests you can run::
+c. Pass the path to one or more .kunitconfig files from the tree.
+   For example, to run only ``FAT_FS`` and ``EXT4`` tests::
 
 	./tools/testing/kunit/kunit.py run \
 		--kunitconfig ./fs/fat/.kunitconfig \
 		--kunitconfig ./fs/ext4/.kunitconfig
 
-d. If you change the ``.kunitconfig``, kunit.py will trigger a rebuild of the
-   ``.config`` file. But you can edit the ``.config`` file directly or with
-   tools like ``make menuconfig O=.kunit``. As long as its a superset of
-   ``.kunitconfig``, kunit.py won't overwrite your changes.
-
-
 .. note ::
 
-	To save a .kunitconfig after finding a satisfactory configuration::
-
-		make savedefconfig O=.kunit
-		cp .kunit/defconfig .kunit/.kunitconfig
+        If you change the ``.kunitconfig``, kunit_tool will resynchronize
+        ``.config``, which can be edited. As long as it is a superset of
+        ``.kunitconfig``, kunit.py won't overwrite your changes in ``.config``
 
 Filtering tests by name
 ~~~~~~~~~~~~~~~~~~~~~~~
-If you want to be more specific than Kconfig can provide, it is also possible
-to select which tests to execute at boot-time by passing a glob filter
-(read instructions regarding the pattern in the manpage :manpage:`glob(7)`).
-If there is a ``"."`` (period) in the filter, it will be interpreted as a
-separator between the name of the test suite and the test case,
-otherwise, it will be interpreted as the name of the test suite.
-For example, let's assume we are using the default config:
+It is also possible to select which tests to execute at boot-time by passing
+a glob filter (see :manpage:`glob(7)` for details).
+If there is a period (``.``) in the filter, it will be interpreted as a
+separator between the name of the test suite and the test case; otherwise it
+will be interpreted as the name of the test suite.
 
-a. inform the name of a test suite, like ``"kunit_executor_test"``,
-   to run every test case it contains::
+The complete ways to specify the tests are:
+
+a. Pass the test suite name to run every case in that test::
 
 	./tools/testing/kunit/kunit.py run "kunit_executor_test"
 
-b. inform the name of a test case prefixed by its test suite,
-   like ``"example.example_simple_test"``, to run specifically that test case::
+b. Pass the fully qualified name of test case to run the specific case::
 
 	./tools/testing/kunit/kunit.py run "example.example_simple_test"
 
-c. use wildcard characters (``*?[``) to run any test case that matches the pattern,
-   like ``"*.*64*"`` to run test cases containing ``"64"`` in the name inside
-   any test suite::
+c. Use wildcard characters (``*?[``) to run any test case that matches the
+   pattern.  For example, ``"*.*64*"`` matches test case names that contain
+   "64" across any test suite::
 
 	./tools/testing/kunit/kunit.py run "*.*64*"
 
-Running Tests without the KUnit Wrapper
-=======================================
-If you do not want to use the KUnit Wrapper (for example: you want code
-under test to integrate with other systems, or use a different/
+Running tests without kunit_tool
+================================
+If you do not want to use kunit_tool (e.g. you want the tested code
+to be integrated with other systems, or use different/
 unsupported architecture or configuration), KUnit can be included in
-any kernel, and the results are read out and parsed manually.
+any kernel code. The results can then be read out and parsed manually.
 
 .. note ::
    ``CONFIG_KUNIT`` should not be enabled in a production environment.
    Enabling KUnit disables Kernel Address-Space Layout Randomization
-   (KASLR), and tests may affect the state of the kernel in ways not
-   suitable for production.
+   (KASLR) and tests may affect the state of the kernel in ways not
+   suitable for production (like performance issues).
 
-Configuring the Kernel
+Configuring the kernel
 ----------------------
-To enable KUnit itself, you need to enable the ``CONFIG_KUNIT`` Kconfig
-option (under Kernel Hacking/Kernel Testing and Coverage in
-``menuconfig``). From there, you can enable any KUnit tests. They
-usually have config options ending in ``_KUNIT_TEST``.
+To enable KUnit itself, you need to enable the ``CONFIG_KUNIT``
+option (the entry is under
+:menuselection:`Kernel Hacking -> Kernel Testing and Coverage`).
+You can enable any tests that you want to be run. These
+configuration usually have ``_KUNIT_TEST`` suffix.
 
-KUnit and KUnit tests can be compiled as modules. The tests in a module
-will run when the module is loaded.
+Just like any other configuration options, KUnit and KUnit tests can be
+built as modules. The tests in the module will be run when the module is
+loaded.
 
-Running Tests (without KUnit Wrapper)
--------------------------------------
-Build and run your kernel. In the kernel log, the test output is printed
-out in the TAP format. This will only happen by default if KUnit/tests
-are built-in. Otherwise the module will need to be loaded.
+Running tests
+-------------
+Build and run your kernel as usual. If KUnit and the tests are built as
+modules, these need to be loaded first. The test results are logged (printed
+out) in the TAP format.
 
 .. note ::
-   Some lines and/or data may get interspersed in the TAP output.
+   Some lines and/or data may get interspersed in the output.
 
 Writing Your First Test
 =======================
@@ -298,17 +284,3 @@ You should see the following output:
 	...
 
 Congrats! You have just written your first KUnit test.
-
-Next Steps
-==========
-
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
-- 
An old man doll... just what I always wanted! - Clara

