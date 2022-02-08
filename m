Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0014ADE92
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 17:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383528AbiBHQqc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 11:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbiBHQqc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 11:46:32 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B71C061576;
        Tue,  8 Feb 2022 08:46:31 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id v10so6347401qvk.7;
        Tue, 08 Feb 2022 08:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFg4oiGESgYctPjyVURPoa5eRtFO0bNPbfwjD0pksvo=;
        b=eEOSjkGvdwrw2HLW4fBjKdShFRwpRpIkMLBtU40unspsIhDn5Qjo7LmcGfYHO6VD4v
         6Peii3dIB69X90/0sxSreZtQYmSTIE+unRdfKf1KcrKffQVCdTEnCVZpkC3TgAaO9g6n
         L9poHgq2JH2V74j72dkvIaTF2aYAlURmKnrKj1zRVxx53kcahJuiTvlv1xiAQwyuzalK
         rEAGEcIe2pX5Se734mavOsPq/i6ZjSBPiWdaZ1SxMwTwhcuceyXqyekIzyyDVfaRos4y
         eD/HDJF5tBPV3iPVfMz8rhY09Yn4nO2klI5U0sk1h6rVcBfJB0HSXeAC37crb4p539pv
         JYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFg4oiGESgYctPjyVURPoa5eRtFO0bNPbfwjD0pksvo=;
        b=zWO2JhXp6zSYJP7+Eh/v+dB4ubfdxF7pODGS/Kol90xMgfx5mPrq0szNhGczTlrMhp
         pCnFXRWMzx1QoxJZyGc2qGy9QsLoOA464thPr2pt80fJboHnUwaMcjzllfVi4GJymUFp
         Ap/ytgAsnD7E4EI1rXl+6cuVZfc+VfQvzNBcJr+4WVF3vEpCnfqRdrhX7RiIlWqSbrvj
         7onI30P1URkjWWiSkc3QLTM52RlUuDmj+nGD0hJTU1xMKz0DLEj0oG10OA9qfynLiDX1
         eKrEfS6IikQu//sdYnChyr77c+hRKjn7j1heIKFvByAtexIfQtF35KP0IO1tBY2seLrk
         HKig==
X-Gm-Message-State: AOAM530W06H7xay4oEsWXir1N1BcEYs9tS0OHeRcxfRBlx/wSPTEssHH
        M9pgbDfVeacXSpTy7Z3/r9Q=
X-Google-Smtp-Source: ABdhPJzHN2AQIkV6FHtVyNV6Y3kslXhm7JjVYiUbZFgxCWt2Yo3VJdynX3nPGUagi1So0ihV2XMw6g==
X-Received: by 2002:a05:6214:29ec:: with SMTP id jv12mr3700945qvb.87.1644338790338;
        Tue, 08 Feb 2022 08:46:30 -0800 (PST)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id h9sm7546795qkn.121.2022.02.08.08.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 08:46:29 -0800 (PST)
From:   frowand.list@gmail.com
To:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Tim.Bird@sony.com, Brendan Higgins <brendanhiggins@google.com>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] Documentation: dev-tools: clarify KTAP specification wording
Date:   Tue,  8 Feb 2022 10:46:23 -0600
Message-Id: <20220208164623.3151777-1-frowand.list@gmail.com>
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

Reviewed-by: Tim Bird <Tim.Bird@sony.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

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

