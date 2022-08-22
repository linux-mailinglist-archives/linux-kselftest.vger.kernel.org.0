Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE51B59B7A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 04:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiHVCaj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 22:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiHVCag (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 22:30:36 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1627920BD4;
        Sun, 21 Aug 2022 19:30:35 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a10so3819687uas.7;
        Sun, 21 Aug 2022 19:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VrrdJ3K9eRjv1UeAhxVJuXXbMmxDwwAQl5QOTteS6Y0=;
        b=hu3r2uvVSKZaur3rxubLdn1JkKgRnHJnuwxauyGJJF+Z74cgSnMDtXGOzAwNTV7wZb
         8aAX3WElOohubEjBEfCMYAzcwpA7LAseWCxmFNbQUZUxaq8jfA9FYSmiE/ROWArFRtvJ
         Kl0q139ZDMXQtBZRRausHZzDoPZnIpu5XJgWxcjy+3As3hQcxoozYsgX0nkbOLh3QG3/
         2JbX4f8PC7fFF14okB5Rfu7odkv5RZpG1hI5tqzJSQC0/dY9P0cXSsmRPOC5CjZg0fvM
         0uNoi5Is7/hBKvpzLR4EBF2Gu3fJsQNS3HB4PMGPFKIAZNlQR1voZMF/EMjrksbEppZR
         tmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VrrdJ3K9eRjv1UeAhxVJuXXbMmxDwwAQl5QOTteS6Y0=;
        b=RPuPvy/+iOgxmfgafcTIK/v0wftNhxggkHPLhkY63KTSdkge3iGrQ9dDBqqdhJRShe
         CAKkrUQ3AmiJHBylt/m1XpfJtl7qSDBu0IAAxcU5UfBFx/pUG5YHVHUXDKeqko/2+DbY
         j6TZROp1Weao1L1IoUGmTJxmQnd+yxdee8bpvJHEhtQzJhSnuSMToRagOj0EVo4Z2kjE
         ThwCtnDvbY+cX8ys0UcHu5ZsluOSc25zCzi90DYrka+0Q5MIgUZRL6Yo6mRI6Ng98Ioh
         wWwwG5QTXkIcCCyrnRayrgsSueUGmENy+oVE0TdiohcnuFaUBArAPhkUzovoQgeiwuAd
         J/wg==
X-Gm-Message-State: ACgBeo3DlfXfUquORZhCr4DN9zQnpEnXs+JJhZR0CUqEeWfJLKsIQbKn
        Oqx32QyIDn99Hng1NDPG1p4=
X-Google-Smtp-Source: AA6agR5lj1NBmzIaXGQ6Wd8AyZCrWunsjz5k0TaEHmVoBuReOlRUmJEq+T5TrWoLalCNhce/ol0hlQ==
X-Received: by 2002:a9f:358c:0:b0:387:9de3:6c8a with SMTP id t12-20020a9f358c000000b003879de36c8amr6454109uad.94.1661135434641;
        Sun, 21 Aug 2022 19:30:34 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id y125-20020a1f3283000000b00378fe8518dcsm8330853vky.51.2022.08.21.19.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:30:34 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
Subject: [PATCH v2 4/8] Documentation: KUnit: Reword start guide for selecting tests
Date:   Sun, 21 Aug 2022 23:26:42 -0300
Message-Id: <20220822022646.98581-5-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822022646.98581-1-tales.aparecida@gmail.com>
References: <20220822022646.98581-1-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Maíra Canal <mairacanal@riseup.net>

---
Notes:
    Avoid hyphen in "test case" and "test suite"
    Fix nit: "any test case that match" -> "...matches"
---
 Documentation/dev-tools/kunit/start.rst | 90 +++++++++++++++++--------
 1 file changed, 63 insertions(+), 27 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 9beec7d6ac4b..adf782507999 100644
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
+separator between the name of the test suite and the test case,
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
+c. use wildcard characters (``*?[``) to run any test case that matches the pattern,
+   like ``"*.*64*"`` to run test cases containing ``"64"`` in the name inside
+   any test suite::
+
+	./tools/testing/kunit/kunit.py run "*.*64*"
+
 Running Tests without the KUnit Wrapper
 =======================================
 If you do not want to use the KUnit Wrapper (for example: you want code
-- 
2.37.2

