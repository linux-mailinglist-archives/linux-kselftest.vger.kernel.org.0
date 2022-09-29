Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0DF5EF677
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 15:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiI2N0w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 09:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiI2N02 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 09:26:28 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD08F11DFCD;
        Thu, 29 Sep 2022 06:26:19 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 3so1462454pga.1;
        Thu, 29 Sep 2022 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=tZqNyVFP8TilF+zyV4PYC5u7/K2JRWQ8RYWUuGAVbWU=;
        b=cX4x36k3ftMZAj4wDt2XyX9s8mpa6T2cqgqfZVZR+aM1HnfxIY1D0N/oeEIylgPIsR
         /s48GoP2v2XTVNoU73D3SNEfQN/EKIV2rg16OqpdizhFX9ds8y0XZWvv8SVml3iY3/jd
         mVnHBivKIe9S/YU4AbEnrhQInJNlrhnlKXq5Kd67mbYJhkpbwZfiZYKPD9B0QBgNV8Se
         UnLoJOIhrowLAooSsjasef/0KjFhaPDNe3mkH/b6fZFQJmF5UlcGaA6VCNWZqn17BuNq
         R7hjSvqlaQW2oyjJDIHQHTG7rz7wTweSCC9r5VolAlNdzsBbHTZFgY8O4NX7sVbveYVQ
         W2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tZqNyVFP8TilF+zyV4PYC5u7/K2JRWQ8RYWUuGAVbWU=;
        b=3J45kZ6Iz7+pjNpkE5uWW3kBC2tHw2tV63/8VsO05Dv/LhxebCZ0l7aEdvBHVxEjSO
         nHRIUeYyv8Upj1nmqS/O1whpw/AvltEyXyhrcCWy7V6zUNWj0q+4l5hx5QG+GqHt1Av6
         bYywWQmeM2fG4lGRGOwIkJmKA6M+/4W+IYPkXtocaF3j736IT3fPUf9kWN4Ot3AtoIuB
         ypG73H/u9zfgYR3xpJ99heM0kYA92OyWKPlwGk0bw9SgIHA8MR4qyDjPL1yWKixdIaCU
         sXUBSgo9cnzLBq0KZqxQ5uGijOe8d+4GkoKYP2fa448dOxgKJqrwgt74h22cmLAWnoy5
         ZiMQ==
X-Gm-Message-State: ACrzQf2aSe3O7Tmih8HAoGHHw0R4ZfeUkpmfCp51zwl5Qcfeda9F1JGg
        KkHSobnAWnL0geWGavaA30KRBlS7gqAyLSvG
X-Google-Smtp-Source: AMsMyM6E1lmgYBG3krlNTaNVmvfDxtih9qIcvbgskKpTf5Wihh+/0LcgP9LLmZIJ6wJF7d37f8P1tw==
X-Received: by 2002:a65:5b05:0:b0:439:a0ae:7e6a with SMTP id y5-20020a655b05000000b00439a0ae7e6amr2981230pgq.16.1664457977896;
        Thu, 29 Sep 2022 06:26:17 -0700 (PDT)
Received: from debian.. (subs03-180-214-233-65.three.co.id. [180.214.233.65])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902654400b0016be834d54asm5886900pln.306.2022.09.29.06.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 06:26:17 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] Documentation: kunit: rewrite writing first test instructions
Date:   Thu, 29 Sep 2022 20:25:49 +0700
Message-Id: <20220929132549.56452-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3901; i=bagasdotme@gmail.com; h=from:subject; bh=BF2ojZpfYeCZ/rD/w17Lk5r/0Jvd5HPV5sWmEkAa5r0=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmmcy5VvnC0u2v8/f4p1o/BZgVBM5/+PLEmqszq7aRFYW6h ke9WdpSyMIhxMMiKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiO34z/FM04vBJXarZe/+KxluDqd ombzgyE8wWyb0o8bTlcHZxucDIsHvSqqtFkmx9mycL7lc48nu1D+t1/p4HFj0sS3+cPa5bzAcA
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

The wordings of step-by-step instructions on writing the first Kunit test
are instructing readers to write codes without knowing what these are about.
Rewrite these instructions to include the purpose of written code.

While at it, align the code blocks of these contents.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v1 [1]:

   - Fix jumped list numbering on writing the feature

 This patch is based on Khalid's full path to .kunitconfig patch [2].

 [1]: https://lore.kernel.org/linux-doc/20220929125458.52979-1-bagasdotme@gmail.com/
 [2]: https://lore.kernel.org/linux-doc/20220929085332.4155-1-khalid.masum.92@gmail.com/

 Documentation/dev-tools/kunit/start.rst | 40 ++++++++++++++-----------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 7999874dc4ddb3..c0a5adf6d8d665 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -131,17 +131,19 @@ are built-in. Otherwise the module will need to be loaded.
 
 Writing Your First Test
 =======================
-In your kernel repository, let's add some code that we can test.
+In your kernel repository, let's add some code that we can test. For this
+purpose, we are going to add simple addition driver.
 
-1. Create a file ``drivers/misc/example.h``, which includes:
+1. Write the feature that will be tested. First, write the declaration
+   for ``misc_example_add()`` in ``drivers/misc/example.h``:
 
-.. code-block:: c
+   .. code-block:: c
 
 	int misc_example_add(int left, int right);
 
-2. Create a file ``drivers/misc/example.c``, which includes:
+   Then implement the function in ``drivers/misc/example.c``:
 
-.. code-block:: c
+   .. code-block:: c
 
 	#include <linux/errno.h>
 
@@ -152,24 +154,25 @@ In your kernel repository, let's add some code that we can test.
 		return left + right;
 	}
 
-3. Add the following lines to ``drivers/misc/Kconfig``:
+2. Add Kconfig menu entry for the feature to ``drivers/misc/Kconfig``:
 
-.. code-block:: kconfig
+   .. code-block:: kconfig
 
 	config MISC_EXAMPLE
 		bool "My example"
 
-4. Add the following lines to ``drivers/misc/Makefile``:
+3. Add the kbuild goal that will build the feature to
+   ``drivers/misc/Makefile``:
 
-.. code-block:: make
+   .. code-block:: make
 
 	obj-$(CONFIG_MISC_EXAMPLE) += example.o
 
 Now we are ready to write the test cases.
 
-1. Add the below test case in ``drivers/misc/example_test.c``:
+1. Write the test in ``drivers/misc/example_test.c``:
 
-.. code-block:: c
+   .. code-block:: c
 
 	#include <kunit/test.h>
 	#include "example.h"
@@ -202,31 +205,32 @@ Now we are ready to write the test cases.
 	};
 	kunit_test_suite(misc_example_test_suite);
 
-2. Add the following lines to ``drivers/misc/Kconfig``:
+2. Add following Kconfig entry for the test to ``drivers/misc/Kconfig``:
 
-.. code-block:: kconfig
+   .. code-block:: kconfig
 
 	config MISC_EXAMPLE_TEST
 		tristate "Test for my example" if !KUNIT_ALL_TESTS
 		depends on MISC_EXAMPLE && KUNIT=y
 		default KUNIT_ALL_TESTS
 
-3. Add the following lines to ``drivers/misc/Makefile``:
+3. Add kbuild goal of the test to ``drivers/misc/Makefile``:
 
-.. code-block:: make
+   .. code-block:: make
 
 	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example_test.o
 
-4. Add following configuration fragments to ``.kunit/.kunitconfig``:
+4. Add following configuration fragments for the test to
+   ``.kunit/.kunitconfig``:
 
-.. code-block:: none
+   .. code-block:: none
 
 	CONFIG_MISC_EXAMPLE=y
 	CONFIG_MISC_EXAMPLE_TEST=y
 
 5. Run the test:
 
-.. code-block:: bash
+   .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run
 
-- 
An old man doll... just what I always wanted! - Clara

