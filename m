Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912EB4AC617
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 17:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiBGQjo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 11:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244795AbiBGQ2Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 11:28:24 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C164BC0401DC;
        Mon,  7 Feb 2022 08:28:22 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id o3so12290991qtm.12;
        Mon, 07 Feb 2022 08:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjuYbPqGlUU+uIXv13zUv8IJB7OPzzTg6ohYTp3I1lU=;
        b=IU3HAqftGzdEiHLQ5P3E0wX8ENgnTWKRN+2SAH5KdWQHa5um85ch2zDilFcHkt6olY
         uVg+a+2brsJewG6N0oIibftvqH13FjygO6/WXAQIwfdE+5hqV/FDwt3XSQUUUHhHDKgz
         wGlyn9KJxmxaBfNtlVTbHNgyMwmljNL1iJ7CB6eOAPTh5XZoYKUk18i9Qt7N1Tv6hLQw
         jt7mWG+YNV5CT7VLzkAxiIeAM14IHhaxOJd1hMZon2LpYLfoyLLTqRQQ2FBKA/faoPca
         U/dGpcspb1MZGoGmxSYxeLuEonVuw4QI1i3aZMOrdxsKwq6YcLDPJY/UEGcmv71Nv+TF
         aJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjuYbPqGlUU+uIXv13zUv8IJB7OPzzTg6ohYTp3I1lU=;
        b=c5T1TZ74NzY4koLR7ZYMSeDWh0MajACw4LjNNvBhwo9bEVvJJtzi3Xq0DzkkKfI4Lv
         5va99ATQvtB3daefXxgARL4TD4qph9P55daebpl6yx7g8Wd2HslQR0Q0P5RvI6KahI79
         hLGyLCnrwA9Vdi0zhh4Qc1T5s9M7ik8u7ONy8qbE8XsfswONIqi9ASoEuuXD/OWD+3/B
         vPO0qaVwiWPPVOlPdqis1J2KA/l9jL+qnSeqTO8ESmkWIsQHYVX6PjU0qe2lBrFDGgw4
         geYfEZBEXChypmVGK+S47F3jy6w/g7ik+KuVYibm6CP34M5VtGwBRxavfoVj2pbqPNYz
         7F7w==
X-Gm-Message-State: AOAM531n7EgF/wqWevPwNb4wDznNcVlUNNh89a5SzkLzxwhHF0raJbIV
        MFF3Y9ORmGh6fopxVCPby2U=
X-Google-Smtp-Source: ABdhPJwX1a1/fFvnULl6HaYsf119iOikOAO7Z7I1JhSJceT872zBsey2kuDqr/eSFqF5a3bgKRPLyA==
X-Received: by 2002:ac8:7f48:: with SMTP id g8mr199849qtk.622.1644251301886;
        Mon, 07 Feb 2022 08:28:21 -0800 (PST)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id w3sm6175253qta.13.2022.02.07.08.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 08:28:21 -0800 (PST)
From:   frowand.list@gmail.com
To:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Tim.Bird@sony.com, Brendan Higgins <brendanhiggins@google.com>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] Documentation: dev-tools: clarify KTAP specification wording
Date:   Mon,  7 Feb 2022 10:28:13 -0600
Message-Id: <20220207162813.3091899-1-frowand.list@gmail.com>
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

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Changes since version 1
  - Explain likely source of "Unknown lines"
  - "Unknown line" in nested tests are optionally indented
  - Add "Unknown lines" items to differences between TAP & KTAP list

 Documentation/dev-tools/ktap.rst | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index 878530cb9c27..9c40c94d3f12 100644
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
+- TAP says "Unknown lines" are "incorrect; KTAP allows "Unknown lines"
 
 The TAP14 specification does permit nested tests, but instead of using another
 nested version line, uses a line of the form
-- 
Frank Rowand <frank.rowand@sony.com>

