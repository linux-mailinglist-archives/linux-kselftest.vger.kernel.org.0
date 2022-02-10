Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C194B036D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 03:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiBJCfa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 21:35:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiBJCf2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 21:35:28 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45251237D2;
        Wed,  9 Feb 2022 18:35:30 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id z1so3806377qto.3;
        Wed, 09 Feb 2022 18:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oJUtVaUMZZQ3Wf3eYjXBC/gGfRZDVoAst5E9J28F8Fw=;
        b=Mk9V3Uge8lU26SkqYaHpr1oS8I+T8nFRRG8J9Tr86RzwVjWAlYQhUqE+FIV4/6EOD2
         ZqSHtbvRkDaoZxHBb9yVQJrnRTPzmbuTkHamCogMd8FB1IFg2QxlZL4w+476LwMlmjzO
         Zjyyck1EmKMJFRU//TdVg1fn0NsgBuFIigMdxT+K9Pv2mG5Huig7dbIilITJK3GRmC+j
         ryF5hNV160hFP+muelCNcwLiF6GtQvdHWDqsiZSujewBnhAcvxkxKjzezXPbCB5PJVSz
         ENeITHkXJcmsjhWko8yKM+hJEvI3SbJwHMWbesCwbdU8MyI92Q1RvbJBgQjHxg4djXw1
         Jy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oJUtVaUMZZQ3Wf3eYjXBC/gGfRZDVoAst5E9J28F8Fw=;
        b=6AzYrhrerkXYj1dKKcZYVZUkM6sRJR4TXow+7XYwNzJGprs2bXANAHkZCQJWYrD3Qm
         1mVXM8A1PenIczgx2NHm9ITaUdVbl1LkX/IJsc+DHbs3o53ax88Odnw3RK+d3aCs3WVh
         lDQQAyy2kLV78bY6ypCPU8DG57MqUyFCIHGUqVHb2ZZ5Gdy1+aCSlAKbmFKM4O449/hW
         iXu0aec49ILjErq7EbKPc0Sf0yhH85cZZQrqxx2mwTTk34oy6+uCVOSCdKOkoo/8Hvm6
         dzXuHhNuZY+gXqLgEAzATNq6/CDfvEPbMcJ1qgA3yV+sxvOibMAW532LlI9wz8boxQAd
         ig+g==
X-Gm-Message-State: AOAM530Cown6M7BOFJ7U2RdAI3DjT1bB8FB9LmDJnEOJJUxk9ZGDPiuG
        I13XKfPRXtedXI3vwZKcPIM=
X-Google-Smtp-Source: ABdhPJy9P2O4RKwq83H+EoQrtNUcaisIFb9g4ub306K5gr2IRqBRMRVBztCnm4LMQY8Rgn0es2KDKQ==
X-Received: by 2002:a05:622a:50a:: with SMTP id l10mr3496252qtx.679.1644460529457;
        Wed, 09 Feb 2022 18:35:29 -0800 (PST)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id h11sm1333374qkp.89.2022.02.09.18.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 18:35:29 -0800 (PST)
From:   frowand.list@gmail.com
To:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Tim.Bird@sony.com, Brendan Higgins <brendanhiggins@google.com>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] Documentation: dev-tools: fix KTAP specification build warnings
Date:   Wed,  9 Feb 2022 20:35:19 -0600
Message-Id: <20220210023519.3221051-3-frowand.list@gmail.com>
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

Convert "Major differences between TAP and KTAP" from a bullet list
to a table.  The bullet list was being formatted as a single
paragraph.

Add missing required argument in code-block directives.

---

Table conversion suggested by Shuah.

Patch 2/2 not previously reviewed, so Reviewed-by tags not provided.

Changes since version 3
  - Add this commit (patch 2/2) to the series

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 Documentation/dev-tools/ktap.rst | 33 +++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index dfb3f10a8b2d..5ee735c6687f 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -68,7 +68,7 @@ Test case result lines
 Test case result lines indicate the final status of a test.
 They are required and must have the format:
 
-.. code-block::
+.. code-block:: none
 
 	<result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
 
@@ -117,32 +117,32 @@ separator.
 
 Example result lines include:
 
-.. code-block::
+.. code-block:: none
 
 	ok 1 test_case_name
 
 The test "test_case_name" passed.
 
-.. code-block::
+.. code-block:: none
 
 	not ok 1 test_case_name
 
 The test "test_case_name" failed.
 
-.. code-block::
+.. code-block:: none
 
 	ok 1 test # SKIP necessary dependency unavailable
 
 The test "test" was SKIPPED with the diagnostic message "necessary dependency
 unavailable".
 
-.. code-block::
+.. code-block:: none
 
 	not ok 1 test # TIMEOUT 30 seconds
 
 The test "test" timed out, with diagnostic data "30 seconds".
 
-.. code-block::
+.. code-block:: none
 
 	ok 5 check return code # rcode=0
 
@@ -202,7 +202,7 @@ allowed to be either indented or not indented.
 
 An example of a test with two nested subtests:
 
-.. code-block::
+.. code-block:: none
 
 	KTAP version 1
 	1..1
@@ -215,7 +215,7 @@ An example of a test with two nested subtests:
 
 An example format with multiple levels of nested testing:
 
-.. code-block::
+.. code-block:: none
 
 	KTAP version 1
 	1..2
@@ -234,12 +234,15 @@ An example format with multiple levels of nested testing:
 Major differences between TAP and KTAP
 --------------------------------------
 
-Note the major differences between the TAP and KTAP specification:
-- yaml and json are not recommended in KTAP diagnostic messages
-- TODO directive not recognized in KTAP
-- KTAP allows for an arbitrary number of tests to be nested
-- TAP includes "Unknown lines" in the category of "Anything else"
-- TAP says "Unknown lines" are "incorrect"; KTAP allows "Unknown lines"
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
@@ -247,7 +250,7 @@ nested version line, uses a line of the form
 
 Example KTAP output
 --------------------
-.. code-block::
+.. code-block:: none
 
 	KTAP version 1
 	1..1
-- 
Frank Rowand <frank.rowand@sony.com>

