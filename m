Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E775994A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 07:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346377AbiHSFdI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 01:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346394AbiHSFdE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 01:33:04 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10338E0FEC;
        Thu, 18 Aug 2022 22:33:01 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id q190so3520887vsb.7;
        Thu, 18 Aug 2022 22:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1u6mv9kSVTi0mdVSnBCVTFeOJbHhGehQzmqLPC1wjOo=;
        b=I/f62gx8xepNEf3nLui2xhR/6VUbewRRr6OSTN1htWiS8MlkEMvobHWnD/CZ3CVbI1
         aWj2JiWi/vH8JK+xowOczNJvOinJKzfCisaX9D1K4pkiQ8UQZzH2PrTzmAydIjXFJ0jF
         vM05dqQzyRDXhSvU6s89Ixy4iIQJsCrjg1uZHQ6Ck5Wsdze1RWBCOATs/8o5VgHiXk2O
         ldfk/rxt5Nvl4axrwOuyXYosfnyJeqZUruIkFH7LhuaQsdf3u9y9DhLNl3mxCJkOdyLj
         kQ9vK5/LdsMUBKBEYKsSik8u4/LdblTY6NfvsfpNTPjgAN58tk4RYfv75egWdOiXEtA3
         Ni0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1u6mv9kSVTi0mdVSnBCVTFeOJbHhGehQzmqLPC1wjOo=;
        b=jhXCXMVMkM9G0Az01zCjN+OMPuVSCIPaiLVmZ5YAvojH4R7DjjLw1TJf4q5Jf5gpD7
         +8ywZe3d7mQ3F13jPFD4ZoOfy/1qTSZoKq5I36t8V/Vs7s0FdjbhbPEBiaCOw8COSzRA
         mPI+8IigidtPxbB675lbxL7VYQIZNsb2bU4CTmlOZEjWVzW+i9Jcw1y3hK4jxezlMP6W
         y8z3Qw1VpQnKHS9jOXNakPy6/IsRLldS8ka11jEYxx6a0SWikxrFE0k7wfuWUdm8quyN
         ICxb5vQguODBfCu80QrBErCrG08ua2zFVjx3FjK4ZP0PII0LfRsb4DPrSMpZWHaHdfNP
         rjgQ==
X-Gm-Message-State: ACgBeo3HJIUdCrayWzeG/ceSRN8Y+fhMEL8OhO+Z0xdfPX3NEhiEXESm
        iBG5PVvsnYobSUBkZNH9jX8=
X-Google-Smtp-Source: AA6agR41P6aj6ZVIGHklcU1v/LA0yhnjIR36yzcdH0WdvL9bpmwYkfw1TOlQSiczsEY8eJutqiTgQg==
X-Received: by 2002:a05:6102:1346:b0:386:507:e188 with SMTP id j6-20020a056102134600b003860507e188mr2502155vsl.63.1660887180608;
        Thu, 18 Aug 2022 22:33:00 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id w85-20020a1f9458000000b0037d0cd81996sm1999286vkd.37.2022.08.18.22.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 22:33:00 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
Subject: [PATCH 4/8] Documentation: KUnit: Reword start guide for selecting tests
Date:   Fri, 19 Aug 2022 02:32:30 -0300
Message-Id: <20220819053234.241501-5-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819053234.241501-1-tales.aparecida@gmail.com>
References: <20220819053234.241501-1-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Reword "Creating a ``.kunitconfig``" into "Selecting which tests to run"
covering the current alternatives for editing configs and glob-filtering

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 Documentation/dev-tools/kunit/start.rst | 90 +++++++++++++++++--------
 1 file changed, 63 insertions(+), 27 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index e4b73adde6d0..f0ec64207bd3 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -52,27 +52,20 @@ The tests will pass or fail.
 For detailed information on this wrapper, see:
 Documentation/dev-tools/kunit/run_wrapper.rst.
 
-Creating a ``.kunitconfig``
----------------------------
-
-By default, kunit_tool runs a selection of tests. However, you can specify which
-unit tests to run by creating a ``.kunitconfig`` file with kernel config options
-that enable only a specific set of tests and their dependencies.
-The ``.kunitconfig`` file contains a list of kconfig options which are required
-to run the desired targets. The ``.kunitconfig`` also contains any other test
-specific config options, such as test dependencies. For example: the
-``FAT_FS`` tests - ``FAT_KUNIT_TEST``, depends on
-``FAT_FS``. ``FAT_FS`` can be enabled by selecting either ``MSDOS_FS``
-or ``VFAT_FS``. To run ``FAT_KUNIT_TEST``, the ``.kunitconfig`` has:
+Selecting which tests to run
+----------------------------
 
-.. code-block:: none
+By default, kunit_tool runs all tests reachable with minimal configuration,
+that is, using default values for most of the kconfig options.  However,
+you can select which tests to run by:
 
-	CONFIG_KUNIT=y
-	CONFIG_MSDOS_FS=y
-	CONFIG_FAT_KUNIT_TEST=y
+- `Customizing Kconfig`_ used to compile the kernel, or
+- `Filtering tests by name`_ to select specifically which compiled tests to run.
 
-1. A good starting point for the ``.kunitconfig`` is the KUnit default config.
-   You can generate it by running:
+Customizing Kconfig
+~~~~~~~~~~~~~~~~~~~
+A good starting point for the ``.kunitconfig`` is the KUnit default config.
+If you didn't run ``kunit.py run`` yet, you can generate it by running:
 
 .. code-block:: bash
 
@@ -84,27 +77,70 @@ or ``VFAT_FS``. To run ``FAT_KUNIT_TEST``, the ``.kunitconfig`` has:
    ``.kunitconfig`` lives in the ``--build_dir`` used by kunit.py, which is
    ``.kunit`` by default.
 
-.. note ::
+Before running the tests, kunit_tool ensures that all config options
+set in ``.kunitconfig`` are set in the kernel ``.config``. It will warn
+you if you have not included dependencies for the options used.
+
+There are many ways to customize the configurations:
+
+a. Edit ``.kunit/.kunitconfig``. The file should contain the list of kconfig
+   options required to run the desired tests, including their dependencies.
    You may want to remove CONFIG_KUNIT_ALL_TESTS from the ``.kunitconfig`` as
    it will enable a number of additional tests that you may not want.
+   If you need to run on an architecture other than UML see :ref:`kunit-on-qemu`.
 
-2. You can then add any other Kconfig options, for example:
+b. Enable additional kconfig options on top of ``.kunit/.kunitconfig``.
+   For example, to include the kernel's linked-list test you can run::
 
-.. code-block:: none
+	./tools/testing/kunit/kunit.py run \
+		--kconfig_add CONFIG_LIST_KUNIT_TEST=y
 
-	CONFIG_LIST_KUNIT_TEST=y
+c. Provide the path of one or more .kunitconfig files from the tree.
+   For example, to run only ``FAT_FS`` and ``EXT4`` tests you can run::
 
-Before running the tests, kunit_tool ensures that all config options
-set in ``.kunitconfig`` are set in the kernel ``.config``. It will warn
-you if you have not included dependencies for the options used.
+	./tools/testing/kunit/kunit.py run \
+		--kunitconfig ./fs/fat/.kunitconfig \
+		--kunitconfig ./fs/ext4/.kunitconfig
 
-.. note ::
-   If you change the ``.kunitconfig``, kunit.py will trigger a rebuild of the
+d. If you change the ``.kunitconfig``, kunit.py will trigger a rebuild of the
    ``.config`` file. But you can edit the ``.config`` file directly or with
    tools like ``make menuconfig O=.kunit``. As long as its a superset of
    ``.kunitconfig``, kunit.py won't overwrite your changes.
 
 
+.. note ::
+
+	To save a .kunitconfig after finding a satisfactory configuration::
+
+		make savedefconfig O=.kunit
+		cp .kunit/defconfig .kunit/.kunitconfig
+
+Filtering tests by name
+~~~~~~~~~~~~~~~~~~~~~~~
+If you want to be more specific than Kconfig can provide, it is also possible
+to select which tests to execute at boot-time by passing a glob filter
+(read instructions regarding the pattern in the manpage :manpage:`glob(7)`).
+If there is a ``"."`` (period) in the filter, it will be interpreted as a
+separator between the name of the test-suite and the test-case,
+otherwise, it will be interpreted as the name of the test suite.
+For example, let's assume we are using the default config:
+
+a. inform the name of a test suite, like ``"kunit_executor_test"``,
+   to run every test case it contains::
+
+	./tools/testing/kunit/kunit.py run "kunit_executor_test"
+
+b. inform the name of a test case prefixed by its test suite,
+   like ``"example.example_simple_test"``, to run specifically that test case::
+
+	./tools/testing/kunit/kunit.py run "example.example_simple_test"
+
+c. use wildcard characters (``*?[``) to run any test-case that match the pattern,
+   like ``"*.*64*"`` to run test-cases containing ``"64"`` in the name inside
+   any test-suite::
+
+	./tools/testing/kunit/kunit.py run "*.*64*"
+
 Running Tests without the KUnit Wrapper
 =======================================
 If you do not want to use the KUnit Wrapper (for example: you want code
-- 
2.37.1

