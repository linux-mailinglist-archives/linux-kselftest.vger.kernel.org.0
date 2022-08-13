Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34716591897
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Aug 2022 06:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbiHMEVU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 Aug 2022 00:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiHMEVS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 Aug 2022 00:21:18 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4D914012;
        Fri, 12 Aug 2022 21:21:15 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id s129so2593559vsb.11;
        Fri, 12 Aug 2022 21:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gNs9sey591WPnXbNPiS1OcGYuvQlyk8T1glh4KMvcRM=;
        b=dNHnkRdXtFsuE2N/jkVbPN5WpeUIbdQ4mrP2miILjOgcFqac+pQ84PPzJHdkP6HvgZ
         H4tw54xJsL7wreN7LdeLVtri1m584bZMz23SEQ8TboJzOPmhYVP7rThIAld4ugqNiaF7
         2cu6ghx4EtR/3CnSnlZpoaJeeAPJXfqAlMHsq1hJHxkMmovFsBr5y5W57jvgX9NVZPb1
         cqydruhAvo3738kkLEqZV8JcrzTDIinDdNxfycwjwGrgH33ijQpZd5lIXHHKa2QWCCd9
         BitWc0yhonIt3PAf7d19PIw0ke9x7iC/PZrhWCx7KlGxJMPcBhCXM3nn4cD1pfxagIjZ
         mnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gNs9sey591WPnXbNPiS1OcGYuvQlyk8T1glh4KMvcRM=;
        b=dEzj7EonvEGVCCmaOMpLaUqdQPiXz7X/Zth5qGSqSzkAfZLhXD2hooKuKb0BK+N6ee
         RDDjvBpP7bBdSxi60ug9sECZkG/swBu72lBu8JWZThlzHl1rJdJKNH63nFQlnk67OteE
         GAyfq130d+ON1JS0GCnkH3FoKkoshvSzaSf12b2wSZB0+6WuQ4GHFs8nilqr1PBzYFFW
         GcJZSefkz5FoSUuxLn3LnKkV17av1KqyZOh1ST9BUfJlc+x0BpKmkofaqQJKVaT09FeO
         9Mi23a0fFZDz6G256V0Yjyw6WJtP+J681pp6sCyj0B08YGW/v/VdoLttNgS6jAMKrdtr
         OMsw==
X-Gm-Message-State: ACgBeo0nUhp0Ftby7VPYAAwusfScoC4CR+vnVKfGAuEKFFQdXPbC66Bu
        GmVryW/DIEaQvtJurnkBIsVLgbiUSQnhHQ==
X-Google-Smtp-Source: AA6agR7IsNjHqelxS6j3S91zn+3jnq5utB+yK8vXp0LUgaFtFzXde4mcTj9QgZs89AvfKxsePmfFtQ==
X-Received: by 2002:a05:6102:5094:b0:388:6903:5f09 with SMTP id bl20-20020a056102509400b0038869035f09mr3084636vsb.46.1660364474383;
        Fri, 12 Aug 2022 21:21:14 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
        by smtp.gmail.com with ESMTPSA id cz10-20020a056102290a00b0038712af0dbesm2434646vsb.22.2022.08.12.21.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 21:21:13 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>, brendanhiggins@google.com,
        corbet@lwn.net
Cc:     Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Documentation: KUnit: Fix non-uml anchor
Date:   Sat, 13 Aug 2022 01:20:54 -0300
Message-Id: <20220813042055.136832-4-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220813042055.136832-1-tales.aparecida@gmail.com>
References: <20220813042055.136832-1-tales.aparecida@gmail.com>
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

The section was rewritten but its anchor got left behind.
Fix the anchor and add some references to running on QEMU.

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 Documentation/dev-tools/kunit/faq.rst         | 6 +++---
 Documentation/dev-tools/kunit/run_wrapper.rst | 2 ++
 Documentation/dev-tools/kunit/usage.rst       | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
index 172e239791a8..f1b4cef68ced 100644
--- a/Documentation/dev-tools/kunit/faq.rst
+++ b/Documentation/dev-tools/kunit/faq.rst
@@ -31,7 +31,8 @@ For the most part, the KUnit core framework (what we use to write the tests)
 can compile to any architecture. It compiles like just another part of the
 kernel and runs when the kernel boots, or when built as a module, when the
 module is loaded.  However, there is infrastructure, like the KUnit Wrapper
-(``tools/testing/kunit/kunit.py``) that does not support other architectures.
+(``tools/testing/kunit/kunit.py``) that might not support some architectures
+(see :ref:`kunit-on-qemu`).
 
 In short, yes, you can run KUnit on other architectures, but it might require
 more work than using KUnit on UML.
@@ -95,8 +96,7 @@ things to try.
    seeing. When tests are built-in, they will execute when the kernel boots, and
    modules will automatically execute associated tests when loaded. Test results
    can be collected from ``/sys/kernel/debug/kunit/<test suite>/results``, and
-   can be parsed with ``kunit.py parse``. For more details, see "KUnit on
-   non-UML architectures" in Documentation/dev-tools/kunit/usage.rst.
+   can be parsed with ``kunit.py parse``. For more details, see :ref:`kunit-on-qemu`.
 
 If none of the above tricks help, you are always welcome to email any issues to
 kunit-dev@googlegroups.com.
diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index db1e867820e7..a1070def284f 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -165,6 +165,8 @@ example: if we only want to run KUnit resource tests, use:
 
 This uses the standard glob format with wildcard characters.
 
+.. _kunit-on-qemu:
+
 Run Tests on qemu
 =================
 
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 44158eecb51e..2737863ef365 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -165,6 +165,8 @@ built as a module).
 
 For more information, see Documentation/dev-tools/kunit/api/test.rst.
 
+.. _kunit-on-non-uml:
+
 Writing Tests For Other Architectures
 -------------------------------------
 
@@ -544,8 +546,6 @@ By reusing the same ``cases`` array from above, we can write the test as a
 		{}
 	};
 
-.. _kunit-on-non-uml:
-
 Exiting Early on Failed Expectations
 ------------------------------------
 
-- 
2.37.1

