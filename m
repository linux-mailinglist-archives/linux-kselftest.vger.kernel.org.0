Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0A35EF5CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 14:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbiI2Mzr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 08:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiI2Mzp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 08:55:45 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D627C1323D5;
        Thu, 29 Sep 2022 05:55:44 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r62so1352120pgr.12;
        Thu, 29 Sep 2022 05:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=9yf4OQz+BK3lw3pxhu02ZUG7Irlu0z/ZcY7cz4znAzs=;
        b=dJkWfKlkyJBN7WaUfltXzILCK2Wy5ACLkrxeFQCE/YTFIoDSh7HbLG0zdsR2ij9PtQ
         o9XtqcmnebtOH6EOAxM46xj2zr08TxQNhig9krAUmWhW+rJhL5xY85dYBblq01+Bdhk0
         RB3gx8izGpJQRsiRMTUfbLmJjDi4k6OL5lt2hRyuPtIrK9pVdsQINS5AFg3fVblYBNr6
         RPy7oGnPWeNjesvlwvQNzcUZOkhmoxiFxAA+UEipzOadO7JNhW43uZgHTzg2ahA0My/v
         DEJLC2jy/9rEl+z+Yk5coa7ydqOqBpgaKceZlnpM3Jpnj6fyWGfanedU4w59XT6amaVp
         mXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9yf4OQz+BK3lw3pxhu02ZUG7Irlu0z/ZcY7cz4znAzs=;
        b=di2VzddzhYxadQ1w4qIe6qpET/WbrjY5DMbW+ZT7S86RHTwjXcRafSr+eAjMw0RQKg
         TzN3GNPj46DGDWd9KW/AGWC5fvIPAMqsvgy2r/dE8eyCExIkNGkw9J8E8bjkHofBldf2
         pyIvuU4fSU7/2rMToQCF350tn3b9HoQ3Nxrh6g4Ya2dxW7LDpDkxfJRxMjmXB+PpvMaH
         16HpferSOvfQTzJSnxKkX6Bb5OyW/gNNBjMzOUZ611EQCkgS/iM962RkODTaBBGCXqej
         znl8e+GkqADYoSIbUQUxSxmIbtrPmU28BZtu/lrC6WezBK5hZwt4L8g/RCD4gKM59AGe
         TUug==
X-Gm-Message-State: ACrzQf0zYyNG52RhS/92XqPuGHxHiLe47Dos2gaAvAMnZSiDz8057x2Y
        FH+Pd/Pn1e5gZnG+/ELrzuHud7U5xq9dLw==
X-Google-Smtp-Source: AMsMyM6IPHHra7AxEtjzU6k5fLaaFgYbpyzssqyW3xHAR2tOYvYHgx86NKhSQRqSBiiPKn2DkdDR4w==
X-Received: by 2002:a05:6a00:1249:b0:543:aa0a:9c0a with SMTP id u9-20020a056a00124900b00543aa0a9c0amr3479328pfi.2.1664456144072;
        Thu, 29 Sep 2022 05:55:44 -0700 (PDT)
Received: from debian.. (subs32-116-206-28-55.three.co.id. [116.206.28.55])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7956f000000b0052e987c64efsm6219645pfq.174.2022.09.29.05.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 05:55:43 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: kunit: rewrite writing first test instructions
Date:   Thu, 29 Sep 2022 19:54:59 +0700
Message-Id: <20220929125458.52979-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3732; i=bagasdotme@gmail.com; h=from:subject; bh=yfiSx16xg1z1vQcacEqraLapzGUSyioovfRTutAD9m8=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmmU+dey3eRm/8kjlUp/c5M364sa+MzM2dcy5YRvMEo9X1K zpPjHaUsDGIcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZiInyPDP1t9XqfSMxMat3SmOU0TyD q3nk05Rqq2d2Nd2htzwzzVGwz/S/y0jhyz/XPKpyF745aH6zayWzieOFPsEae+al5T8OyjPAA=
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
 This patch is based on Khalid's full path to .kunitconfig patch [1].

 [1]: https://lore.kernel.org/linux-doc/20220929085332.4155-1-khalid.masum.92@gmail.com/

 Documentation/dev-tools/kunit/start.rst | 40 ++++++++++++++-----------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 7999874dc4ddb3..9628360947507b 100644
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
+3. Add Kconfig menu entry for the feature to ``drivers/misc/Kconfig``:
 
-.. code-block:: kconfig
+   .. code-block:: kconfig
 
 	config MISC_EXAMPLE
 		bool "My example"
 
-4. Add the following lines to ``drivers/misc/Makefile``:
+4. Add the kbuild goal that will build the feature to
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

