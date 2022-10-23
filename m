Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEE6609348
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Oct 2022 15:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiJWNKG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Oct 2022 09:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJWNKF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Oct 2022 09:10:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27902A727;
        Sun, 23 Oct 2022 06:09:56 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f23so6346700plr.6;
        Sun, 23 Oct 2022 06:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ixa9Q2USMZVhIzGh4MBP10w3G2Xm+tYD7e/S5JSlY6c=;
        b=CtunuXO8m4PYEN57qEqqRDwHZptjPq9qkJyZNyO0ImI0F7xs3oRL7o6JoVfZ+fy2fi
         ki1AEm8Rw/ivSQSZ2K7M0d6s1lgcDCxCA6xojppefOqkPc5K88OT/PTSBhDy2qKMs45f
         JAuk6rfqbtROG9/Go++G53Bq6/8I0fL/AVhSrIeRozGktIWugy6yuv5NbvKzHh+46aSf
         U/JcOpRRxacw/KKzrt2aAw4TYKsoXEyzxsJaaXWSlMqorUDPq9nWlPnVPPLM4u8oO4Rr
         kUGDZ5R/mfbSlFwjrSozTGCe6It+TV4jY0dn74U2Yv8HVLVR0Jm7hmBnPacQJKx856ad
         gcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ixa9Q2USMZVhIzGh4MBP10w3G2Xm+tYD7e/S5JSlY6c=;
        b=44uZZ971rqo9eavo7vzbBoMw20TleZL08Y7naB4N59T/+t0KYidVt2Mwk8Y/vElXq5
         WQvsNQIw7g640EHvLd0LVap3YgjS1sU6JTiJPGYDTjow6XDY/bcWd+RNPbggWSLwBhNv
         BOpInC2NQQ6nmPqp+Luax5ZylPsD6Mw9CD0HVM8zVj61CbJ6QjZ6v3wTpbIAPhSih4x9
         Yep28isaFZvNRuzFpf+qJz3YtJ4Zgq0X9vtT6hx1e+cpyBo9bg2OYRaIeknzL8OWcK1U
         TK0FsTSUVs54YwmBFzXsAE3cruojD00U+49Z1WXrqXlhphGbz4YLMbDbfglNgErLBwB2
         jLlQ==
X-Gm-Message-State: ACrzQf1fD9SggdxuF2j9s6pmp81xxOCPXUhrprfhdSJJUDfwQpMHfVIv
        oY8m972sF82sFcuQtGonCtHHVV7u4FBCqg==
X-Google-Smtp-Source: AMsMyM4e24G/F3iOwPY3YBO/bvgKOsKRM/trREKWL2GqPInbpejwJPBtZq4kBW5DGaEycyK5EhNFvA==
X-Received: by 2002:a17:903:2410:b0:17a:b32:dbec with SMTP id e16-20020a170903241000b0017a0b32dbecmr28521854plo.163.1666530595958;
        Sun, 23 Oct 2022 06:09:55 -0700 (PDT)
Received: from debian.. (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id d5-20020a623605000000b0056b6c7a17c6sm3411713pfa.12.2022.10.23.06.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 06:09:55 -0700 (PDT)
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
Subject: [PATCH RESEND 1/7] Documentation: kunit: rewrite "Writing Your First Test" section
Date:   Sun, 23 Oct 2022 20:08:41 +0700
Message-Id: <20221023130846.63296-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221023130846.63296-1-bagasdotme@gmail.com>
References: <20221023130846.63296-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3749; i=bagasdotme@gmail.com; h=from:subject; bh=g91P+iZ/B5WmHtrZ4ClqKE+RwGXIgqSSfN3JfN7FHdA=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmhNrc8U95+utbIv//pj3C3Q4oG6p4sug3rJwY0Ka//sj/4 VMfyjlIWBjEOBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzE4B4jQ/8UN8ZLEhNufVO272/2jw kyOex7poot5e/t9Q7mbEulFjL8lRbdV/Ou6OAynVkHv+16f3HGSm3j3bX5T/Zvnca82jR8NycA
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

