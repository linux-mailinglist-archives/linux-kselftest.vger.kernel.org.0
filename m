Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320F6609309
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Oct 2022 14:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiJWMzZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Oct 2022 08:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJWMzW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Oct 2022 08:55:22 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00D72656D;
        Sun, 23 Oct 2022 05:55:20 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so6990185pjl.3;
        Sun, 23 Oct 2022 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ixa9Q2USMZVhIzGh4MBP10w3G2Xm+tYD7e/S5JSlY6c=;
        b=YZub1opvBM/rm6EqBO8wWMRkXO0TGkK8l3eH2nAwSo85z0HdbKN71E4SYDEIyXbrlE
         ODmYJ0TA3mad6Mc1FkbGFLcTUH8nOiCi4+gjBG+Tm4cD8kQV+UOUPsATsDzD7E3d6Ace
         f2vRe3EKwaii8riit++oU1/kl6XgruIGEZjHeaklyBktySa2CF+v4ikF2s/Wi5swTJi2
         phYRb8pWH3ka2AV+c61igG077f3KIlPfZBPbJ/TkI5cvxolGfvPhU09fuMNdW2TNJGSm
         V085xLxEY9sJOgCIfaFed+GORrJROv0/PCSuTlzYQzFn4E5X9U96th+7AvRqUF+eIijA
         NdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ixa9Q2USMZVhIzGh4MBP10w3G2Xm+tYD7e/S5JSlY6c=;
        b=qKjYLKBTfz7YJKflnBkapZbVKPpAWJ/CpU10i2DqOm2fZj/AJ1dG5JSxNPj8nCJ/28
         2Dp/bhokX6hDWIaHftEvy652F9tJSCTvKuHjLSQrgvKcBbdmZ5HPDkQVJ0CUn6tnbKP3
         K8jZ6rxbWGvPtY4bJfzJN72jGFkX631saiXlDYXXuZNWdRxtaCqBTF+WFmOHkdfgeBOn
         vsgyFmrI9bzD5lQsxSJ4DAu2KRxI6rlIcZuV4VeIValHxZnLg4kd+TFz6xHuOLW4XQhv
         uhU/2utqOIW21eu+FUEJ5rylrNUy9B1Q6Nke0O6t/TcfbyrExWX5xjjoZuk6zWyW114T
         F+yg==
X-Gm-Message-State: ACrzQf1v6yrWCxfHhbxNPME1WG5vjn+Gla+wDbvE0reyh+p8U5oQsIG/
        cE+Q9NJs5NE6+zEO4prpqtgRhGX71/N0Ew==
X-Google-Smtp-Source: AMsMyM7L0BQT9FIqmjZfswd+mcRO/+OClgxBzUaBq79YZsJrik0fd7hKcvwkRrQPmjxilmdAyb93aA==
X-Received: by 2002:a17:903:18b:b0:185:43e6:20df with SMTP id z11-20020a170903018b00b0018543e620dfmr27969785plg.4.1666529720134;
        Sun, 23 Oct 2022 05:55:20 -0700 (PDT)
Received: from debian.. (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id om10-20020a17090b3a8a00b00212daa68b7csm2670639pjb.44.2022.10.23.05.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 05:55:19 -0700 (PDT)
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
Subject: [PATCH 1/7] Documentation: kunit: rewrite "Writing Your First Test" section
Date:   Sun, 23 Oct 2022 19:54:08 +0700
Message-Id: <20221023125414.60961-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221023125414.60961-1-bagasdotme@gmail.com>
References: <20221023125414.60961-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3749; i=bagasdotme@gmail.com; h=from:subject; bh=g91P+iZ/B5WmHtrZ4ClqKE+RwGXIgqSSfN3JfN7FHdA=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmhljmeKW8/XWvk3//0R7jbIUUDdU8W3Yb1EwOalNd/2R98 qmN5RykLgxgHg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZyxZqR4Wa54K8HPI6unk3RCt4OEe 6lcsVr53wK/b8+PMRgbW/9MUaGs94H796Mu16y4EjEu0VTt9n9vel6geFYr8yTJbq5G98t4gcA
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

The "Writing Your First Test" section in "Getting Started"
documentation have wordings that need to be tweaked for clarity and
reducing redundancy. Rewrite the section.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/dev-tools/kunit/start.rst | 34 +++++++++++++++----------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index f4f504f1fb154f..590e25166efb0d 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -179,15 +179,19 @@ are built-in. Otherwise the module will need to be loaded.
 
 Writing Your First Test
 =======================
-In your kernel repository, let's add some code that we can test.
+In this tutorial, you will learn how to write and test a simple driver
+which performs addition of two integers.
 
-1. Create a file ``drivers/misc/example.h``, which includes:
+1. First, write the driver implementation. Follow the below steps.
+
+   a. Create a new header file ``drivers/misc/example.h`` and add the
+      prototype for ``misc_example_add()``:
 
 .. code-block:: c
 
 	int misc_example_add(int left, int right);
 
-2. Create a file ``drivers/misc/example.c``, which includes:
+   b. Write the function implementation in ``drivers/misc/example.c``:
 
 .. code-block:: c
 
@@ -200,22 +204,25 @@ In your kernel repository, let's add some code that we can test.
 		return left + right;
 	}
 
-3. Add the following lines to ``drivers/misc/Kconfig``:
+   c. In order for the driver to be selected, add configuration entry to
+      ``drivers/misc/Kconfig``:
 
 .. code-block:: kconfig
 
 	config MISC_EXAMPLE
 		bool "My example"
 
-4. Add the following lines to ``drivers/misc/Makefile``:
+   d. Last but not least, append the make goal to ``drivers/misc/Makefile``
+      so that the driver can be built:
 
 .. code-block:: make
 
 	obj-$(CONFIG_MISC_EXAMPLE) += example.o
 
-Now we are ready to write the test cases.
+2. Write the test suite that covers the driver functionality. Follow the
+   steps below:
 
-1. Add the below test case in ``drivers/misc/example_test.c``:
+   a. Write the test in ``drivers/misc/example_test.c``:
 
 .. code-block:: c
 
@@ -250,7 +257,7 @@ Now we are ready to write the test cases.
 	};
 	kunit_test_suite(misc_example_test_suite);
 
-2. Add the following lines to ``drivers/misc/Kconfig``:
+   b. Add configuration entry for the test suite to ``drivers/misc/Kconfig``:
 
 .. code-block:: kconfig
 
@@ -259,26 +266,27 @@ Now we are ready to write the test cases.
 		depends on MISC_EXAMPLE && KUNIT=y
 		default KUNIT_ALL_TESTS
 
-3. Add the following lines to ``drivers/misc/Makefile``:
+   c. Append make goal for the configuration to ``drivers/misc/Makefile``: 
 
 .. code-block:: make
 
 	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example_test.o
 
-4. Add the following lines to ``.kunit/.kunitconfig``:
+3. In order to enable the driver and its test suite, append configuration
+   fragment to ``.kunit/.kunitconfig``:
 
 .. code-block:: none
 
 	CONFIG_MISC_EXAMPLE=y
 	CONFIG_MISC_EXAMPLE_TEST=y
 
-5. Run the test:
+4. Run the test:
 
 .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run
 
-You should see the following failure:
+You should see the following output:
 
 .. code-block:: none
 
@@ -289,7 +297,7 @@ You should see the following failure:
 	[16:08:57]      This test never passes.
 	...
 
-Congrats! You just wrote your first KUnit test.
+Congrats! You have just written your first KUnit test.
 
 Next Steps
 ==========
-- 
An old man doll... just what I always wanted! - Clara

