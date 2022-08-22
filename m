Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CE559B7B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 04:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiHVCaf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 22:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiHVCa3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 22:30:29 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2202520BD4;
        Sun, 21 Aug 2022 19:30:28 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id o198so1117245vko.4;
        Sun, 21 Aug 2022 19:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ASKzNR3OVr0x/auTLjHZPWrTcHhp/uvCLAxf9+B1KJY=;
        b=UDsAnzPXw283JlQUcitS9QnSZsILv9uj16dtK+BvvdxBHgylz1PESQwpnP6RR4Y78T
         J6IZcg2CWZHbndDWcBjldrz3nWEp3Yjadf43698DtIWiNY7WFGY1VsU1aNKPIIrZ2c1G
         TJOib7hiqBg3KD+wlXtdWvUc3PcLb3uxRox+YPnCA57H7EWq02lpsgnf9+RRG8NfdYY4
         vF34ERaKLkuHttgc5KnJ6Ju1+lvKxviuB384WAQgTeYAwo7BWfjBCfXawVRm2qsYGyOJ
         fG/jhUgQyd34eP+cjVYqaGGXXxVstCCYHwwOR3vv18eV05qibKMfOEAzvCpu1aCGmShL
         6vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ASKzNR3OVr0x/auTLjHZPWrTcHhp/uvCLAxf9+B1KJY=;
        b=nZRR4A8mNO/5/9We2b41UPfBXGrZJUNJWC1ZCd4AZ43OssqmSgQ+JvFLn+7s19A9tX
         ru0KDHgjcUlc3a/NNm8o3+3MDd9D3mTW91MC8ZNDTeat62O/OSZPMzjexvGUzErNOvM4
         JWOAc/2SIwIAa2YzomqlvYgyMCYe6A4Xtw8OwAo3iqLcrSKrHJKg9egqh480Q/VgIxE/
         +RZN/wsCouDOyIivLabNnP4/gUOjKSVSB8Kvu8abin4Yj//ndpU7lbuNqO8ncBIX7B1P
         KqShcd5aRGnaTUHjHEbOKkUsSNUiS9ZWOBMm6/5ifR1UpnRR+k3J/8Ei9vHF7/XQ0fZE
         ajPw==
X-Gm-Message-State: ACgBeo1cPP9gjkc1LJTBFgPD3D9WLoqKWy3+tapmFTnP2PjMZF8Meyin
        MyGu0ONVYk0WkrM97gC/jCE=
X-Google-Smtp-Source: AA6agR60IQ0+5Kgby8Gfqv4jS5SE/LjLzFRcDfSQeDi+FRI40t2fkA9fFctG9FyaxKVti2SZIfEwGg==
X-Received: by 2002:a1f:adc7:0:b0:377:c12:78ef with SMTP id w190-20020a1fadc7000000b003770c1278efmr6669359vke.19.1661135427212;
        Sun, 21 Aug 2022 19:30:27 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id y125-20020a1f3283000000b00378fe8518dcsm8330853vky.51.2022.08.21.19.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:30:26 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
Subject: [PATCH v2 2/8] Documentation: KUnit: avoid repeating "kunit.py run" in start.rst
Date:   Sun, 21 Aug 2022 23:26:40 -0300
Message-Id: <20220822022646.98581-3-tales.aparecida@gmail.com>
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

Combine two sections mentioning "kunit.py run" to streamline the
getting-started guide. Update "kunit.py run" expected output in
the guide and run_wrapper.

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>

---
Notes:
    Update the expected output and the note that follows it (Maíra Canal and
    Sadiya Kazi). The output was updated on the commit: 45ba7a893ad8
    ("kunit: kunit_tool: Separate out config/build/exec/parse")
    Add word "step" to note and fix the case of "kernel".
---
 Documentation/dev-tools/kunit/run_wrapper.rst |  2 +-
 Documentation/dev-tools/kunit/start.rst       | 38 ++++++++-----------
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 518cf87ea732..6b33caf6c8ab 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -22,7 +22,7 @@ We should see the following:
 
 .. code-block::
 
-	Generating .config...
+	Configuring KUnit Kernel ...
 	Building KUnit kernel...
 	Starting KUnit kernel...
 
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index e730df1f468e..2e31350a85e1 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -19,7 +19,21 @@ can run kunit_tool:
 
 	./tools/testing/kunit/kunit.py run
 
-For more information on this wrapper, see:
+If everything worked correctly, you should see the following:
+
+.. code-block::
+
+	Configuring KUnit Kernel ...
+	Building KUnit Kernel ...
+	Starting KUnit Kernel ...
+
+The tests will pass or fail.
+
+.. note ::
+   Because it is building a lot of sources for the first time,
+   the ``Building KUnit Kernel`` step may take a while.
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
2.37.2

