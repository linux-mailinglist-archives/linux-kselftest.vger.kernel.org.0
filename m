Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786E45918A0
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Aug 2022 06:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiHMEV3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 Aug 2022 00:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbiHMEVX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 Aug 2022 00:21:23 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE91313F9B;
        Fri, 12 Aug 2022 21:21:18 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id j2so2624477vsp.1;
        Fri, 12 Aug 2022 21:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RI0CJJBq8KUXBhWRmxHVc6zRcB3gwN2DmCRZwDgGjR0=;
        b=UrZNi4i5m0mQYV+2gurqXQKVcPQEK1TcTrdzFxacXRVk9GEw4r9uDbILBfRCHMjAJc
         NVvE6jJNcXRDtCztR3Rja2U8RlH/DmYOHTZcLxyOBlO5LttAuLGv71QxP1c88U+ZKf3w
         1lPnThdYb2d6YXfrrZFcTHjOMDAYIvbwz7Q175l5sewUHGDCPoGtQj79VvWnWpzdiBp+
         jxFWW6oDg/XkOt3YnvhwiK9g322n5oZY57xwT+0DHB58/2mGCDiRmVCMJHX0ZfMMBSbB
         y8NFsYhhdbiPFZvmnLaUq03IdhBNR8uyoAPmKCzemmz3DvwD+ZN7GNXXGc7xOw5ovF4r
         Z7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RI0CJJBq8KUXBhWRmxHVc6zRcB3gwN2DmCRZwDgGjR0=;
        b=wXuALHBtMCK/TuO+962rKT4maCFHOIuWiWgbmAnQ6FW7bzdYyoCJB5KZoxqTz2t4su
         nrwAORSlQTdIiDhw4WHcslX4u1tBA4pzM0KVKUdUGSNKCFwtS5PLbzcuEEQDdOJHeGzC
         xwnQ+GgZWquf5fixJg8GODoSHd1gY7u16REOfDJECjlG/C/arnVYTAX/YKKB17I10Kaq
         WKG0FF9uJSlm+IVMHRFUKZqEotz/hHqYYqS8BHvmkTJQgW3YSFqqB7phLBSDyoLsVVXt
         qJ6jZnkr54pLOSxWjSqEzZxxQbJlroF3EB3Tl3tq5DvjLbVZ9aVCd4ZeMA63B5mbVOp+
         GZuw==
X-Gm-Message-State: ACgBeo22vOTCr81qn+ddmqHBIBRsLAguXca/Mf6lRFWEcNV65ni8K/7J
        HI1ws14GUGzLT4HFkFf4HkA=
X-Google-Smtp-Source: AA6agR7DgSzX2jpz7lbIPIm2l7xQ1ilyJ/8kXZLtNoGiBDnsrO/TuMZ8C8Q8JWKkxk1V7IfhlIX2uA==
X-Received: by 2002:a67:b84f:0:b0:388:cbb3:25af with SMTP id o15-20020a67b84f000000b00388cbb325afmr3029624vsh.52.1660364477953;
        Fri, 12 Aug 2022 21:21:17 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1003])
        by smtp.gmail.com with ESMTPSA id cz10-20020a056102290a00b0038712af0dbesm2434646vsb.22.2022.08.12.21.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 21:21:17 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>, brendanhiggins@google.com,
        corbet@lwn.net
Cc:     Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Documentation: Kunit: Add ref for other kinds of tests
Date:   Sat, 13 Aug 2022 01:20:55 -0300
Message-Id: <20220813042055.136832-5-tales.aparecida@gmail.com>
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

Add an organic link to the "other kinds of tests" in the index page

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 Documentation/dev-tools/kunit/faq.rst   | 2 ++
 Documentation/dev-tools/kunit/index.rst | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
index f1b4cef68ced..fae426f2634a 100644
--- a/Documentation/dev-tools/kunit/faq.rst
+++ b/Documentation/dev-tools/kunit/faq.rst
@@ -39,6 +39,8 @@ more work than using KUnit on UML.
 
 For more information, see :ref:`kunit-on-non-uml`.
 
+.. _kinds-of-tests:
+
 What is the difference between a unit test and other kinds of tests?
 ====================================================================
 Most existing tests for the Linux kernel would be categorized as an integration
diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index 595205348d2d..bc91ad7b8961 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -95,6 +95,8 @@ Unit Testing Advantages
 - Improves code quality.
 - Encourages writing testable code.
 
+Read also :ref:`kinds-of-tests`.
+
 How do I use it?
 ================
 
-- 
2.37.1

