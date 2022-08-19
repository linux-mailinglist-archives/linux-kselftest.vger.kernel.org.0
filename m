Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B308D5994C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 07:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346356AbiHSFcz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 01:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345813AbiHSFcz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 01:32:55 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F9DE0FD2;
        Thu, 18 Aug 2022 22:32:54 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id z185so3544086vsb.4;
        Thu, 18 Aug 2022 22:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uPBP+GitFvO77AKu8PhsYfx02hdTtsTUPVNZmX5tIHk=;
        b=ms2N2gcDo951NDjNL2cCLKv41hSz7LxjYn7ABmhPWEP1Ht4WQB0PmXIOZZ+xuln8vq
         hJvl2sIDhoYSC+fPDObTpkUm7bJBvmBpZwUOYnodyI8Ms06YUBq09gfhyGQj18/ntsAp
         AEA1PIEBRfWTrP3iLjMghNwOngHN3e8zSKBYkXJm5iMLsbjklTjbzhntJ33CvPC6ryuS
         Dm00fSBR4KEdFYU0p8UAsY6Q3rmh0DxPH/mapiRgM8+aCrZ/E1w6Km4vag1FX89hxyyA
         VUnKTH0oqw2aJdJbHz2Hd50QWHjjjJQIkWAnYaXCZ68BvnpycphUZ6cqZE5S+RKvpYxH
         /QaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uPBP+GitFvO77AKu8PhsYfx02hdTtsTUPVNZmX5tIHk=;
        b=eOjAbwDqSfGKnHVdVjzZqAx/O37xLcf7Ez66RNSnTWwPOvec1xQL0TIliINFTor7co
         GaxpYI4UeH6QVV+iG8IYjMx9pT6IS1oZH7vadW+12afPnfnqQ93zggTewIeAFbSA5QIG
         4zbjtsLfLlGLTuA2S56alctYm+a6aHMWp5Q36gr+HbJaPfvibv2pN5Hc2plVOW7Qooz/
         9H+SEPd8B1mLuzlw6rnOb1p24kBTBC8B4w/8wrL20gsgcFBLZDrL2TUczzaGFMYLm7j0
         3N8nqQNjj5960ENHaNNJvMQPg/i1WYcPWQO5vIc52qu9BZigVMhDDwduN/Xtq096Q72v
         dDVg==
X-Gm-Message-State: ACgBeo1C/wkLWyT0kb4/pheXuWGkJEaD4wqk/NUM0WFY3VnWtP7Bt6Fs
        VmOz3nIklkZIU5acIfrq11I=
X-Google-Smtp-Source: AA6agR5T7ivMnr7EYZD4CLSwPgL4CB3V34CSZthGwY1mqeS3bLY5rtcdtlresSOI3MGUAEqurhMPxw==
X-Received: by 2002:a05:6102:356:b0:375:3bbb:149 with SMTP id e22-20020a056102035600b003753bbb0149mr2181542vsa.72.1660887173096;
        Thu, 18 Aug 2022 22:32:53 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id w85-20020a1f9458000000b0037d0cd81996sm1999286vkd.37.2022.08.18.22.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 22:32:52 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
Subject: [PATCH 2/8] Documentation: KUnit: avoid repeating "kunit.py run" in start.rst
Date:   Fri, 19 Aug 2022 02:32:28 -0300
Message-Id: <20220819053234.241501-3-tales.aparecida@gmail.com>
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

Combine two sections mentioning "kunit.py run" to streamline the
getting-started guide.

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 Documentation/dev-tools/kunit/start.rst | 38 ++++++++++---------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index e730df1f468e..165d7964aa13 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -19,7 +19,21 @@ can run kunit_tool:
 
 	./tools/testing/kunit/kunit.py run
 
-For more information on this wrapper, see:
+If everything worked correctly, you should see the following:
+
+.. code-block::
+
+	Generating .config ...
+	Building KUnit Kernel ...
+	Starting KUnit Kernel ...
+
+The tests will pass or fail.
+
+.. note ::
+   Because it is building a lot of sources for the first time, the
+   ``Building KUnit kernel`` may take a while.
+
+For detailed information on this wrapper, see:
 Documentation/dev-tools/kunit/run_wrapper.rst.
 
 Creating a ``.kunitconfig``
@@ -74,28 +88,6 @@ you if you have not included dependencies for the options used.
    tools like ``make menuconfig O=.kunit``. As long as its a superset of
    ``.kunitconfig``, kunit.py won't overwrite your changes.
 
-Running Tests (KUnit Wrapper)
------------------------------
-1. To make sure that everything is set up correctly, invoke the Python
-   wrapper from your kernel repository:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run
-
-If everything worked correctly, you should see the following:
-
-.. code-block::
-
-	Generating .config ...
-	Building KUnit Kernel ...
-	Starting KUnit Kernel ...
-
-The tests will pass or fail.
-
-.. note ::
-   Because it is building a lot of sources for the first time, the
-   ``Building KUnit kernel`` may take a while.
 
 Running Tests without the KUnit Wrapper
 =======================================
-- 
2.37.1

