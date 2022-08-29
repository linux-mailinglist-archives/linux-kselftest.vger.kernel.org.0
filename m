Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CFA5A579B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 01:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiH2Xcm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 19:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiH2Xck (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 19:32:40 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225D980F57;
        Mon, 29 Aug 2022 16:32:40 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 6-20020a9d0106000000b0063963134d04so6990662otu.3;
        Mon, 29 Aug 2022 16:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pcwb/p5+jybv9fHerrohgcSzr7MnKBdlSMhQ4dihg0o=;
        b=C7J0eUMt5+vJdczODpeq86N9bO2dDO1VQb/5YrmWv1PMUiRDIjHFGP2gaJk9xmOSG/
         WsBif31jiznmqa21fK1NRx9m+oNgiG0cmEwJ9KstmIncsvQ9j11wNaZqEFUH4SR0P5vq
         iWFQZu5mjBB4G6K0jLMq/n/tqm3+73TUqRZHuGvtZAVnM8Ee9USrxzcg2OW+OTgoC3Zm
         wsKSQiKu5TNJFwPAcLxz+DtmO3ysL8kr30Ks26Le2Xw3ZgFJHm6p8/NCJsdjPFPXZ2R5
         mHYl7TQ6WYVU1R/L+MKO3De7e7yo2CldLaSZ5a1ZfQ4Z94dNUK1fFNzd+rMaWUU0IraQ
         hqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pcwb/p5+jybv9fHerrohgcSzr7MnKBdlSMhQ4dihg0o=;
        b=mCo2yCi+BaMo4wpx7K6VJsLZpy8Ox6CSf3uaq5qlwmMYlciKopAUXkdvNUYUqtuXD9
         oDjWufNuUP2hf5lzmcMrL68n3BI3mjFRQSHorJICmHtbHPbicPrsbXBJCULGUl5P6NHc
         aOekpOLI9YRu7ZXpDPfN+iLruek/CKZOaBG0kqVG64OSI+Q7mEUNLtDBGQrurIOry/iD
         Ikr2qtmC6vayIbshdAiUuJtPMdjTqMO1e8t6JNsc4QqC5BLed8iVAzeWr1Lu4jqXl6tX
         /xxHGvuAtUi7N9obpwbla95Ra9k+/ngV33ThQAyf8fyfSvVyiLNnaKOSSe8h3mdab+75
         v8RQ==
X-Gm-Message-State: ACgBeo30W+p4zZVGjlws7WOgZ6qnxVu5wJFYm5ZEcdxitLBQZ8rnZEqj
        t+jmAM+olu6qbfc8m7bSs48=
X-Google-Smtp-Source: AA6agR7so/qOD3k8QI/sorSQtm+h9+oaifcFsM0/9jO8R7DDJjiEXSC/Y8aivOkbLfXussd2YDsOdg==
X-Received: by 2002:a9d:12d:0:b0:639:41f8:df09 with SMTP id 42-20020a9d012d000000b0063941f8df09mr7417644otu.98.1661815959492;
        Mon, 29 Aug 2022 16:32:39 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:dd06:f7b4:b579:6561])
        by smtp.gmail.com with ESMTPSA id bu28-20020a0568300d1c00b0063b24357269sm4183611otb.13.2022.08.29.16.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 16:32:39 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Frank Rowand <frowand.list@gmail.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] ktap_v2: change "version 1" to "version 2" in examples
Date:   Mon, 29 Aug 2022 18:31:50 -0500
Message-Id: <20220829233150.3564612-3-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829233150.3564612-1-frowand.list@gmail.com>
References: <20220829233150.3564612-1-frowand.list@gmail.com>
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

Change the "version line" in example output from
"KTAP version 1" to "KTAP version 2".

Change version that should be used by compliant tests from 1 to 2.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Changes since patch version 2:
   - refresh version 2 patch 2/2 for new context

 Documentation/dev-tools/ktap.rst | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index b9a57ceddd4f..ff77f4aaa6ef 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -39,6 +39,7 @@ version of the (K)TAP standard the result is compliant with.
 
 For example:
 - "KTAP version 1"
+- "KTAP version 2"
 - "TAP version 13"
 - "TAP version 14"
 
@@ -46,7 +47,7 @@ Note that, in KTAP, subtests also begin with a version line, which denotes the
 start of the nested test results. This differs from TAP14, which uses a
 separate "Subtest" line.
 
-While, going forward, "KTAP version 1" should be used by compliant tests, it
+While, going forward, "KTAP version 2" should be used by compliant tests, it
 is expected that most parsers and other tooling will accept the other versions
 listed here for compatibility with existing tests and frameworks.
 
@@ -202,9 +203,9 @@ An example of a test with two nested subtests:
 
 ::
 
-	KTAP version 1
+	KTAP version 2
 	1..1
-	  KTAP version 1
+	  KTAP version 2
 	  1..2
 	  ok 1 test_1
 	  not ok 2 test_2
@@ -215,11 +216,11 @@ An example format with multiple levels of nested testing:
 
 ::
 
-	KTAP version 1
+	KTAP version 2
 	1..2
-	  KTAP version 1
+	  KTAP version 2
 	  1..2
-	    KTAP version 1
+	    KTAP version 2
 	    1..2
 	    not ok 1 test_1
 	    ok 2 test_2
@@ -250,21 +251,21 @@ Example KTAP output
 --------------------
 ::
 
-	KTAP version 1
+	KTAP version 2
 	1..1
-	  KTAP version 1
+	  KTAP version 2
 	  1..3
-	    KTAP version 1
+	    KTAP version 2
 	    1..1
 	    # test_1: initializing test_1
 	    ok 1 test_1
 	  ok 1 example_test_1
-	    KTAP version 1
+	    KTAP version 2
 	    1..2
 	    ok 1 test_1 # SKIP test_1 skipped
 	    ok 2 test_2
 	  ok 2 example_test_2
-	    KTAP version 1
+	    KTAP version 2
 	    1..3
 	    ok 1 test_1
 	    # test_2: FAIL
-- 
Frank Rowand <frank.rowand@sony.com>

