Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA97260934B
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Oct 2022 15:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiJWNKN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Oct 2022 09:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiJWNKG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Oct 2022 09:10:06 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781302D1F4;
        Sun, 23 Oct 2022 06:10:00 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h185so6539293pgc.10;
        Sun, 23 Oct 2022 06:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXi6pfUX/CUtGab0f5TwpdJc904ss1/0JV1i/36x4zc=;
        b=CykSc9zEqnTDY8iD1nH8ko4JZcgt9k+43FS1+9u9eQtHEbFJgkAoJtjMg00t5auwyA
         qdgadz3VF1GMRZvx3Fzm9q+0BZhbSCxCygsM48C0z9O7LIcfdLcJie8F9jdi8oZd8eoq
         FZp8Qj/nUPwfNsqyHP0oL75uVpkrxB0DGTuPhrqib9I9GyL+53vdy9KLkeFH2qzrhfkT
         YTBIwECJJ6B0cAGSHBPC5TIMWl6qpjDgYeYHiq0b6CNL9aKaRcYUSUPQh5e6iE0bfqPg
         crHoqzZHTTBd8ky+hoN0x/td92TDDWDD2+F0iVolb16ETZPsPADXdfYJgmU1BThFdaRM
         QWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXi6pfUX/CUtGab0f5TwpdJc904ss1/0JV1i/36x4zc=;
        b=XqDCS7BTKrbC7Vu6Huar3gMw3IsiLtmfG/Po662cIK2yLT07D6htZLo7GMEn/t97vh
         25krk2iZOzzEQnJOw+cjeDESXl6wmlDqPaMz1g2A0Lnpm+UwUzsLDS7rXmQ7vh0Jshni
         g32Nkp9HxDh75EAlmbHhBi0j17VSHwDdk7Js3+bKJ25pqUF3xpetL3dFH1mKOWjjmObc
         Q+QpePQ2caHMww8nx+9tzI/3SqGLk3FgLex0DIjxmVRg00psCqVLACPwHAwewJ/oHEMh
         nnB4ZDkZXVy9gTL1Njd7eW4qVxHLV8Ti4LdA2MfQl6Fbfpq52FELo3GPC5MbQ45ALUTk
         SIlQ==
X-Gm-Message-State: ACrzQf2Uj67WahGySss7sTYcd077SvjNvC0j7WeiM5LiZ8lbRlj6SGhv
        v6ICb/cIMXZQ5Nzi5dZQj/wZsy1i0T9XKg==
X-Google-Smtp-Source: AMsMyM47nodA314qahMPh6g8SvdC4dCQBnGB2oR2EZPU/vbjq6xM0NG7lUH4A29aZfh80xyyuM4XWQ==
X-Received: by 2002:a63:c4e:0:b0:45f:795:c20a with SMTP id 14-20020a630c4e000000b0045f0795c20amr24634785pgm.559.1666530599712;
        Sun, 23 Oct 2022 06:09:59 -0700 (PDT)
Received: from debian.. (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id d5-20020a623605000000b0056b6c7a17c6sm3411713pfa.12.2022.10.23.06.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 06:09:59 -0700 (PDT)
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
Subject: [PATCH RESEND 2/7] Documentation: kunit: align instruction code blocks
Date:   Sun, 23 Oct 2022 20:08:42 +0700
Message-Id: <20221023130846.63296-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221023130846.63296-1-bagasdotme@gmail.com>
References: <20221023130846.63296-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2933; i=bagasdotme@gmail.com; h=from:subject; bh=1SnUiB0gzIYxvwi4z2UvKjSn6I+UTeuPVzieo1f/vRU=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmhNrdv2e+rNH+o/CTJQyNnfdzKmadeX5Sq+ff38jMztfQ1 dusndpSyMIhxMMiKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiPy4z/OG7f7DlzsFtW/Wey5x0fC FzYPfDBAXj+9ucV0u91f6YYTOPkWHZtYSP884kLo8UUVeZ+eYmq+72PWcmLY5bMGe7Z93y+dkMAA==
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

