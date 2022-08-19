Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7BE5994CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 07:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346404AbiHSFdK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 01:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346407AbiHSFdK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 01:33:10 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFC9E0FCA;
        Thu, 18 Aug 2022 22:33:09 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id x12so1449285uaf.0;
        Thu, 18 Aug 2022 22:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=UeGdqJCeHUV9zq8c5vfLzr8E358tdKigavISTdFlzcQ=;
        b=qClWBSbJwuqc/L+PpVs2gzeEGc4ywAL8Udwvi+e6Kw9JnkiwV8kPsjT/ZbUC4vCxfp
         5joevCS1zyFW+vF2obQJwpINb5hRM4DA1kknaDm20ESuTH3AVn8g/KYxvztkJj9sa7rN
         8oBTaeblNNRq/pfpzdyoDS+3fKXf2YHqwgeoFTwklEFmPiePtCyb/1lr7Rxwyma6j7em
         FfqvdTIRonH/I3s2PoHC9IStPmZVrXME0knrmptKQUOy2q7n/gupJR6qc2VofeLuAGnC
         pLZLfCGYIEdo5xPsA1FbM4h4jzd52iHhgeEZ3Mh+kDLmrQVg1vgsk/wtEqQHMraDy7Sh
         kvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UeGdqJCeHUV9zq8c5vfLzr8E358tdKigavISTdFlzcQ=;
        b=FmYtngIlNXMuAR3ehPixt8XMkV1FWfthstIrhI9wdXDM4J7Q6mBGtZMQQ8kjb/Endp
         32p2mi8KiKWiWxtwW6y7FinavJ6O29B/6nyEegTVImnHpUdCiNLJPWKzWPy97HuQdEGu
         apAy97HxVQGMA1SOS1ELBkFeQSDIsKavHVEgVbrLa15vEVhRR0k+vDkwhbZRk7UmZ4Iy
         7yGDVgT+zybeHc9XVvQFdWIAggXVPZYdtpSyi46YJ67SfyFY2yJeX5EVGSWewp79ktu8
         pc7+zaBbAJTvd/yK0uIuLyS2jaVgiZ8N7Ki1aZ8Q8gcXyjzJqgLC2rkJTm/jnSBUY+r5
         beYw==
X-Gm-Message-State: ACgBeo05z+NQ3u68mfcZY63x14y7Fr786g9y4H1zT7x7TPXpJ6SuPGF8
        vpxnM/JSE3kRAh2oCKoM69w=
X-Google-Smtp-Source: AA6agR7CQg0s+JOkkkB9MW0mWu9ooPIczF8B/osTovA1HmHGNY6T2gJlQLaWNpgi3D2lu1IcTIbOVw==
X-Received: by 2002:ab0:4a8b:0:b0:393:8b62:df40 with SMTP id s11-20020ab04a8b000000b003938b62df40mr2255039uae.18.1660887188131;
        Thu, 18 Aug 2022 22:33:08 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id w85-20020a1f9458000000b0037d0cd81996sm1999286vkd.37.2022.08.18.22.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 22:33:07 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
Subject: [PATCH 6/8] Documentation: KUnit: update links in the index page
Date:   Fri, 19 Aug 2022 02:32:32 -0300
Message-Id: <20220819053234.241501-7-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819053234.241501-1-tales.aparecida@gmail.com>
References: <20220819053234.241501-1-tales.aparecida@gmail.com>
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
2.37.1

