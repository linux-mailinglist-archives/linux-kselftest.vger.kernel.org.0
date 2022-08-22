Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0107C59B79C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 04:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiHVCa6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 22:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiHVCan (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 22:30:43 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABC1220E2;
        Sun, 21 Aug 2022 19:30:43 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id l7so9535043vsc.0;
        Sun, 21 Aug 2022 19:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Rcr+UWvpwFsX5wSj0zFjllGRLda0UFgn1uun5gueN54=;
        b=iRa7nBPVQ5ieSVV1SEsOAgeorDjhvJIj97P/ytmGKL1DZEFV7tVA0vA05SFAqI2Pp4
         9UzZZnmN2FWpDN9VuiRY2cw9JSq6weyc1OZTVbGtffiY7HohaPqTuS05rOcGZIsqUX0Z
         RTmJ03PXzB7P3bT4W0+jZq7u9rJKpEuVGw8cKIZW4H1AsQQGTmS/R0U/bwLIJwGfR95Q
         NSbByhx88Ml8Dr206INUbAwVWyGmwkJsNNHZ9wVLM+RySnuycIDPgEO4U4H/JS7T3Fb6
         DHsyIAzJEJGw7Ge8ZvU/h9eNL3k4Hy7RsixMSgihINwl80ibekP/tQJxK9MyoEVqHsPW
         vFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Rcr+UWvpwFsX5wSj0zFjllGRLda0UFgn1uun5gueN54=;
        b=ZmyOsg0KzVYqFCEYtPNDg9nDOox0brmCN2vmzqDafB57sP2bRZa6mr9Zu3dl13PazH
         r1++xQDJqLSDJDkRHRu5AhhmZnM5DrTwHSl/IUMZYDkXmTJNFh+0sf48L4LBCEoi5Hgs
         eu7D4L+67GxzUTcBgKDrkdk/fXhaeucJj5qdqh8MsL8WQANiSW9zwPafHSOhb4j+QOvR
         6IGIP1yZCBcanOh4orAvyViJzZ4xyUidZH3W3nMvfpvP67yVaKa3ovcArPqa2nBTveWz
         eWn60iACEMeczYAR9a1R3FvbUf8jJwVj8F4lBkUAIeT26xTFHbuI8b7Syp0EZjL6oYoS
         pejg==
X-Gm-Message-State: ACgBeo1NHNnktn04yOLKdbQZoUx75JIx4DB0fDswcBORe/dASInxCg+y
        fpO9fMF/z52P7aqPV6plUvUzPEPMyMTHMA==
X-Google-Smtp-Source: AA6agR5Ib6+kInWcaTt9oNzRZdyf2mKEebjRh/3ftNJwvPLBqAp1l2rxn84sCGZZcFRHo+/rqzu0lg==
X-Received: by 2002:a67:d483:0:b0:38f:4981:c4f3 with SMTP id g3-20020a67d483000000b0038f4981c4f3mr5962663vsj.59.1661135442235;
        Sun, 21 Aug 2022 19:30:42 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id y125-20020a1f3283000000b00378fe8518dcsm8330853vky.51.2022.08.21.19.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:30:41 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
Subject: [PATCH v2 6/8] Documentation: KUnit: update links in the index page
Date:   Sun, 21 Aug 2022 23:26:44 -0300
Message-Id: <20220822022646.98581-7-tales.aparecida@gmail.com>
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

Replace out-of-date external links with references to the kernel
documentation, replacing TAP webpage for the more appropriate KTAP
documentation and the UML webpage by its documentation.

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
---
 Documentation/dev-tools/kunit/index.rst | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index d7187282ba28..f5d13f1d37be 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -28,10 +28,10 @@ KUnit (Kernel unit testing framework) provides a common framework for
 unit tests within the Linux kernel. Using KUnit, you can define groups
 of test cases called test suites. The tests either run on kernel boot
 if built-in, or load as a module. KUnit automatically flags and reports
-failed test cases in the kernel log. The test results appear in `TAP
-(Test Anything Protocol) format <https://testanything.org/>`_. It is inspired by
-JUnit, Python’s unittest.mock, and GoogleTest/GoogleMock (C++ unit testing
-framework).
+failed test cases in the kernel log. The test results appear in
+:doc:`KTAP (Kernel - Test Anything Protocol) format</dev-tools/ktap>`.
+It is inspired by JUnit, Python’s unittest.mock, and GoogleTest/GoogleMock
+(C++ unit testing framework).
 
 KUnit tests are part of the kernel, written in the C (programming)
 language, and test parts of the Kernel implementation (example: a C
@@ -45,8 +45,9 @@ internal system functionality. KUnit runs in kernel space and is not
 restricted to things exposed to user-space.
 
 In addition, KUnit has kunit_tool, a script (``tools/testing/kunit/kunit.py``)
-that configures the Linux kernel, runs KUnit tests under QEMU or UML (`User Mode
-Linux <http://user-mode-linux.sourceforge.net/>`_), parses the test results and
+that configures the Linux kernel, runs KUnit tests under QEMU or UML
+(:doc:`User Mode Linux </virt/uml/user_mode_linux_howto_v2>`),
+parses the test results and
 displays them in a user friendly manner.
 
 Features
-- 
2.37.2

