Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953F54B0368
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 03:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiBJCf2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 21:35:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiBJCf1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 21:35:27 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA2C237D3;
        Wed,  9 Feb 2022 18:35:29 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id a28so3579984qvb.10;
        Wed, 09 Feb 2022 18:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74Mm/lTty9d4MomegbPgFDlHGu1ie2dczUGBXMz/OHk=;
        b=Ho+oKUDtFcihYlMA4zE6jKR75hXzuXnWAHv602EU6A+VpPp4j7NJ43EQW/jLCsPa6j
         XNDOjjhbtlSjnLfNpIxtW5B6lkbylyeIB7peFdrGf94VGU1Tt6ClEmmbc/jByADDqIvV
         wUokrcjTzdLiEh/Lfi1v2PQg+zgaFNQmVbfzePkqb9GRYSMLHwT5zutJFrOsvwA2GdC8
         barSLHHiyrWd1oiQ6jUI/6Zy9dTFjj1h4Kh0m7/FT7nlzylW4N24JGGj3G/5pHi6kPV8
         pdO87wwKI3JtmRDkpl4I8JHrn8oU2dsaysXfGFyIbdey7RrAPfq/3MbTUm+YciEUwO4S
         Nirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74Mm/lTty9d4MomegbPgFDlHGu1ie2dczUGBXMz/OHk=;
        b=FROfsYGEn1G0IA49622Wmlh+Jb6ZHxKP/fsV5GM6ZAHD+rUPj7yYjvhDvnRr7uSQws
         aNKYd96SI3M9Xc6TFYY96/atcP/Uu6XV+pZNnICWJUBbK8KCrzATfF+Vn3lYqoMw0nIv
         /bUzQq2prPoOI8x9Zimj522noEYuU0TpV3nu4lvA6aws1y51DsWh83hQy4QexOr5YPsM
         Uo2ulIrjPCR3qHJkVM5keubefFdo4VxTk3LG0CWL/Ka793nUxI7BQhkxA4+/f9ciHK3V
         vgUchwHYC8BeW5Yb5N4SHWfnRZtPk6569SKTnjEa2xN7i+LEi2qrilR1GV6rEvZ7XTSs
         l/8w==
X-Gm-Message-State: AOAM531g+ijRqrK4SNo+iSoYiX4t/z/WeggsazsKvwiziMqHk/zn0Sva
        R6aFTAlI9DQuPDMCFxB0IPWQYQ1dCQk=
X-Google-Smtp-Source: ABdhPJzFb4Z7vhifhMjgXsUD6r3HcUwbLHNhGJXD+CRXsxLwWFNI/1nHE3oZiiGaqtEYCi5NiklFEQ==
X-Received: by 2002:ad4:596d:: with SMTP id eq13mr3577233qvb.131.1644460528277;
        Wed, 09 Feb 2022 18:35:28 -0800 (PST)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id h11sm1333374qkp.89.2022.02.09.18.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 18:35:27 -0800 (PST)
From:   frowand.list@gmail.com
To:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Tim.Bird@sony.com, Brendan Higgins <brendanhiggins@google.com>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] Documentation: dev-tools: clarify KTAP specification wording
Date:   Wed,  9 Feb 2022 20:35:18 -0600
Message-Id: <20220210023519.3221051-2-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210023519.3221051-1-frowand.list@gmail.com>
References: <20220210023519.3221051-1-frowand.list@gmail.com>
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

From: Frank Rowand <frank.rowand@sony.com>

Add the spec version to the title line.

Explain likely source of "Unknown lines".

"Unknown lines" in nested tests are optionally indented.

Add "Unknown lines" items to differences between TAP & KTAP list

Reviewed-by: Tim Bird <Tim.Bird@sony.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>

---
Changes since version 3
  - Add reviewed by Shuah

Changes since version 2
  - Add missing quote after word: incorrect
  - Add Reviewed-by tags

Changes since version 1
  - Explain likely source of "Unknown lines"
  - "Unknown line" in nested tests are optionally indented
  - Add "Unknown lines" items to differences between TAP & KTAP list

 Documentation/dev-tools/ktap.rst | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index 878530cb9c27..dfb3f10a8b2d 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-========================================
-The Kernel Test Anything Protocol (KTAP)
-========================================
+===================================================
+The Kernel Test Anything Protocol (KTAP), version 1
+===================================================
 
 TAP, or the Test Anything Protocol is a format for specifying test results used
 by a number of projects. It's website and specification are found at this `link
@@ -174,6 +174,13 @@ There may be lines within KTAP output that do not follow the format of one of
 the four formats for lines described above. This is allowed, however, they will
 not influence the status of the tests.
 
+This is an important difference from TAP.  Kernel tests may print messages
+to the system console or a log file.  Both of these destinations may contain
+messages either from unrelated kernel or userspace activity, or kernel
+messages from non-test code that is invoked by the test.  The kernel code
+invoked by the test likely is not aware that a test is in progress and
+thus can not print the message as a diagnostic message.
+
 Nested tests
 ------------
 
@@ -186,10 +193,13 @@ starting with another KTAP version line and test plan, and end with the overall
 result. If one of the subtests fail, for example, the parent test should also
 fail.
 
-Additionally, all result lines in a subtest should be indented. One level of
+Additionally, all lines in a subtest should be indented. One level of
 indentation is two spaces: "  ". The indentation should begin at the version
 line and should end before the parent test's result line.
 
+"Unknown lines" are not considered to be lines in a subtest and thus are
+allowed to be either indented or not indented.
+
 An example of a test with two nested subtests:
 
 .. code-block::
@@ -225,9 +235,11 @@ Major differences between TAP and KTAP
 --------------------------------------
 
 Note the major differences between the TAP and KTAP specification:
-- yaml and json are not recommended in diagnostic messages
-- TODO directive not recognized
+- yaml and json are not recommended in KTAP diagnostic messages
+- TODO directive not recognized in KTAP
 - KTAP allows for an arbitrary number of tests to be nested
+- TAP includes "Unknown lines" in the category of "Anything else"
+- TAP says "Unknown lines" are "incorrect"; KTAP allows "Unknown lines"
 
 The TAP14 specification does permit nested tests, but instead of using another
 nested version line, uses a line of the form
-- 
Frank Rowand <frank.rowand@sony.com>

