Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421C860930C
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Oct 2022 14:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiJWMz2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Oct 2022 08:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiJWMz0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Oct 2022 08:55:26 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3943B9B1;
        Sun, 23 Oct 2022 05:55:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q71so6532610pgq.8;
        Sun, 23 Oct 2022 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXi6pfUX/CUtGab0f5TwpdJc904ss1/0JV1i/36x4zc=;
        b=eE4khKnss0xZCgP20SAc/gED9JtWoZ4VnwcjyhoggmhqySRKeqVKw4N+xLTth2rW+3
         7F/XA17KwWsPXjYaX8aT+EbIAlSyEF6x/HwqU2qdCIeDm+7if3m6TfM9XKJq9N1cF7QI
         D3mWbmQIn7fG2dHuuQ1jwk10lVOTFllFO/ew2ySKMAybSiHMnXuZ+CSpHx9QOhHZ6PEd
         0hCpJRzgqdBMpQpTfG3Yc7CLVTLy+eSkzrBD+otIKcfR4b+xMOhA/MvBglrO2C/gjmsH
         GGuWrd5jEcvYpcA+aSYa81Yu8a/s9sniPZXVwh5SlJbZBVCNqt9IAZ2mzWnpz+DsbJhA
         6KfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXi6pfUX/CUtGab0f5TwpdJc904ss1/0JV1i/36x4zc=;
        b=GUVVaR5hbhHvX95TJa8DdQUwxjIaPrXY/sFQL5M8peljx+vWnC9DDM3exwbdjizjMQ
         6IkLRTKGuVJHSbDnlMuHyn9ydDYIhBjQEgdNn7Wojh61NdhwhLotJYNfZOl88bIq2MbF
         XTz/oBNdYQWA5X8qIKwzfDaoAv5Vv9VyDT9vNqLvtfktjpkTMZV/iVEPY/jjXu670ZR3
         NbDNirOV3AK6Q+KLQCJ5xQLBTeNPEMOKPDmZ8jp54ZcUhc45tx5JBMnAC9DW7/d8zLlA
         HnycfFyQWoO1RdqOE3LHESP3BNywlOYGt/AqO0erqh+0U9q76FewqhltjJjQ4rPR9A5d
         B/NA==
X-Gm-Message-State: ACrzQf1nIKG+mWncLSnQmZaJrFna8e4JrjFKR19zPIkaoClKSl9yT87E
        cIXSp6HfovZUQbl7LjuOMfWjM9PXHVaM+A==
X-Google-Smtp-Source: AMsMyM4yr/1OgjoHaYEBexf5UGscUnJLo/TXzks+p/OYKBAHfYJsrncB5RKX520c32PsMSpyhBr5WQ==
X-Received: by 2002:a05:6a02:199:b0:469:d0e6:dab8 with SMTP id bj25-20020a056a02019900b00469d0e6dab8mr24696794pgb.97.1666529723789;
        Sun, 23 Oct 2022 05:55:23 -0700 (PDT)
Received: from debian.. (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id om10-20020a17090b3a8a00b00212daa68b7csm2670639pjb.44.2022.10.23.05.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 05:55:23 -0700 (PDT)
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
Subject: [PATCH 2/7] Documentation: kunit: align instruction code blocks
Date:   Sun, 23 Oct 2022 19:54:09 +0700
Message-Id: <20221023125414.60961-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221023125414.60961-1-bagasdotme@gmail.com>
References: <20221023125414.60961-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2933; i=bagasdotme@gmail.com; h=from:subject; bh=1SnUiB0gzIYxvwi4z2UvKjSn6I+UTeuPVzieo1f/vRU=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmhlrm37PdVmj9UfpLkoZGzPm7lzFOvL0rV/Pt7+ZmZWvoa u/UTO0pZGMQ4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRIm2GvyKxty4UMOhuteOeVmdxg6 16tuJq68dikxZmxzHkyzBOT2ZkmKmhelSN6aL5/7k695/dOTVRPIdR6Fo0l52c4nHVYxcvcwMA
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

Align code blocks in "Writing Your First Test" instructions list so that
these blocks will be rendered at the same level as surrounding
paragraphs in the list.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/dev-tools/kunit/start.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 590e25166efb0d..cdf043b6550e66 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -187,13 +187,13 @@ which performs addition of two integers.
    a. Create a new header file ``drivers/misc/example.h`` and add the
       prototype for ``misc_example_add()``:
 
-.. code-block:: c
+      .. code-block:: c
 
 	int misc_example_add(int left, int right);
 
    b. Write the function implementation in ``drivers/misc/example.c``:
 
-.. code-block:: c
+      .. code-block:: c
 
 	#include <linux/errno.h>
 
@@ -207,7 +207,7 @@ which performs addition of two integers.
    c. In order for the driver to be selected, add configuration entry to
       ``drivers/misc/Kconfig``:
 
-.. code-block:: kconfig
+      .. code-block:: kconfig
 
 	config MISC_EXAMPLE
 		bool "My example"
@@ -215,7 +215,7 @@ which performs addition of two integers.
    d. Last but not least, append the make goal to ``drivers/misc/Makefile``
       so that the driver can be built:
 
-.. code-block:: make
+      .. code-block:: make
 
 	obj-$(CONFIG_MISC_EXAMPLE) += example.o
 
@@ -224,7 +224,7 @@ which performs addition of two integers.
 
    a. Write the test in ``drivers/misc/example_test.c``:
 
-.. code-block:: c
+      .. code-block:: c
 
 	#include <kunit/test.h>
 	#include "example.h"
@@ -259,7 +259,7 @@ which performs addition of two integers.
 
    b. Add configuration entry for the test suite to ``drivers/misc/Kconfig``:
 
-.. code-block:: kconfig
+      .. code-block:: kconfig
 
 	config MISC_EXAMPLE_TEST
 		tristate "Test for my example" if !KUNIT_ALL_TESTS
@@ -268,27 +268,27 @@ which performs addition of two integers.
 
    c. Append make goal for the configuration to ``drivers/misc/Makefile``: 
 
-.. code-block:: make
+      .. code-block:: make
 
 	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example_test.o
 
 3. In order to enable the driver and its test suite, append configuration
    fragment to ``.kunit/.kunitconfig``:
 
-.. code-block:: none
+   .. code-block:: none
 
 	CONFIG_MISC_EXAMPLE=y
 	CONFIG_MISC_EXAMPLE_TEST=y
 
 4. Run the test:
 
-.. code-block:: bash
+   .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run
 
 You should see the following output:
 
-.. code-block:: none
+   .. code-block:: none
 
 	...
 	[16:08:57] [PASSED] misc-example:misc_example_add_test_basic
-- 
An old man doll... just what I always wanted! - Clara

