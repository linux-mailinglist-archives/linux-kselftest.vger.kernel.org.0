Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97164B199C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 00:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345752AbiBJXgj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 18:36:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345704AbiBJXgj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 18:36:39 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216865F6C;
        Thu, 10 Feb 2022 15:36:38 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id r14so7235293qtt.5;
        Thu, 10 Feb 2022 15:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B90XLGkN1WAOFK2CFzfMG91YLQ/ZS8wjF5Kl3RkhK8g=;
        b=Q9oW0XMP47GNdrN33zUk2h0sfaPbl2WXBu4fp5WOkNolo5Ii9QB2PssBOmkUaaKD1M
         AimZzOblVR8A9rv/WJViikxMn4Z8X0s8fVtume6hrkGvh/9Ay5y3T9K+pQ3MY+zwuJXM
         PzYiW0ij8/at+7kld0Qn0zqfvZS1sjEZ5WeHVVjY0Udm5O/MZbOs45Yn4AkX+EggrYdQ
         T4qy+2hxI/cCtnsByOVOJp9PQESiFSVR1YlO3whb0EjhuC40JMeL9uzeW+VSyCrstigF
         u59bw8CfTF315/QKhW+i86cf8GbVigYTzVmavUXwMxBA3dJeAaXln2rnXNvGsrcp9u5G
         DJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B90XLGkN1WAOFK2CFzfMG91YLQ/ZS8wjF5Kl3RkhK8g=;
        b=e3S+91SmWVw2oq1OlbC31ebvJvBUdbOQjdbVbzft7qwqoqg2njL0GyupMOscKSCHQo
         Y02nOJgrjRe860Vt/jrW3kguSgMgtuFBg9G9iw1LsK3cELB73WsvfFcM3Bk4AUqURlKe
         moxndvlvbx9PNrYOq9vYRQAtjg/Z3FTn45PoOW48gu7/ymiwSf/h7bgsnokmsi6nuDFi
         DoyyKi4LCKH6+8yUYZH0CnLv3w6Xw8pBZvQWnwd/skEinI+QnapK+flXtj7TzVWOt2cz
         K7eQ4MAA23t/XFl3EiwOTZtRa1HdsHfAbUqRep0M+CYzyj4hgYTMgrSdLe4fhtBOhBn4
         YQvQ==
X-Gm-Message-State: AOAM53314jQ4uI2h5GruH3xCaBpOaUCnPnLPAVIEA/zIZHbkZM8DQWDg
        r2Gi7Ga1QBy6E6d2Dd4QIMY=
X-Google-Smtp-Source: ABdhPJx0C5YxrDsqACEFsPhRLb0S8MQ3RQwqAaOznzjMtAZBRYleWSNjGKWuntjz9xD9X8FMTu7D8A==
X-Received: by 2002:ac8:5808:: with SMTP id g8mr6617514qtg.483.1644536197314;
        Thu, 10 Feb 2022 15:36:37 -0800 (PST)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id n19sm1854209qtk.66.2022.02.10.15.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:36:36 -0800 (PST)
From:   frowand.list@gmail.com
To:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Tim.Bird@sony.com, Brendan Higgins <brendanhiggins@google.com>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/1] Documentation: dev-tools: clarify KTAP specification wording
Date:   Thu, 10 Feb 2022 17:36:30 -0600
Message-Id: <20220210233630.3304495-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Convert "Major differences between TAP and KTAP" from a bullet list
to a table.  The bullet list was being formatted as a single
paragraph.

Reviewed-by: Tim Bird <Tim.Bird@sony.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

I'm not sure if I should include a review tag of patch 2/2 version 4:
  Reviewed-by: Kees Cook <keescook@chromium.org>

Changes since version 4
  - Remove patch 2/2 (fixes to code-block directives)
  - Remove patch 2/2 (conversion to table folded into this patch)

Changes since version 3
  - Add reviewed by Shuah

Changes since version 2
  - Add missing quote after word: incorrect
  - Add Reviewed-by tags

Changes since version 1
  - Explain likely source of "Unknown lines"
  - "Unknown line" in nested tests are optionally indented
  - Add "Unknown lines" items to differences between TAP & KTAP list

Fixes to code-block directives in version 3 were also submitted by
Randy Dunlap in:
https://lore.kernel.org/lkml/20220131003637.14274-1-rdunlap@infradead.org/T/

 Documentation/dev-tools/ktap.rst | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index 878530cb9c27..d7fe05de40b4 100644
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
@@ -224,10 +234,15 @@ An example format with multiple levels of nested testing:
 Major differences between TAP and KTAP
 --------------------------------------
 
-Note the major differences between the TAP and KTAP specification:
-- yaml and json are not recommended in diagnostic messages
-- TODO directive not recognized
-- KTAP allows for an arbitrary number of tests to be nested
+==================================================   =========  ===============
+Feature                                              TAP        KTAP
+==================================================   =========  ===============
+yaml and json in diagnosic message                   ok         not recommended
+TODO directive                                       ok         not recognized
+allows an arbitrary number of tests to be nested     no         yes
+"Unknown lines" are in category of "Anything else"   yes        no
+"Unknown lines" are                                  incorrect  allowed
+==================================================   =========  ===============
 
 The TAP14 specification does permit nested tests, but instead of using another
 nested version line, uses a line of the form
-- 
Frank Rowand <frank.rowand@sony.com>

