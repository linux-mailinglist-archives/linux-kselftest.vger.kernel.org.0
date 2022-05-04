Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B513F51B29B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 May 2022 01:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379828AbiEDW6l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 18:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379277AbiEDW6K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 18:58:10 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB4D5469A;
        Wed,  4 May 2022 15:52:06 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r27so3077787iot.1;
        Wed, 04 May 2022 15:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPy6cGZiVn9/0omaO+YfLe4SKbdSU3+fUcFNm6w49Kc=;
        b=Z5e4PVqRZ3ZwoKj8x9aPrzkkAEc0QVBpouupChjpPGGs4ajRWKxB6FZqVsoR2YAGBt
         eCzrjaFYsRh5fEZA7ef7WccYCWAerqmiVC1zHW6jHk0KfmPtLgnZ/ThACwcGsmkC4Kty
         hzTHeyQDQTOmoVIIkT2H3HWXY5/v2bCbc89iuDJdLyDWaj1NKGnn9p/hyC81o/GTk46H
         6d+OsQqZzSH2MElJy8Q/EL4ZXfRu06OY0w9Do835t34y/O23+meMHNRG/p7W6XT9rij8
         pFLMC353sef/SqIO/cDIABK+IDr5lp1lDNQtuzoOtxfCbSrggYOFD4coy+ZvuFpJNlWy
         X9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPy6cGZiVn9/0omaO+YfLe4SKbdSU3+fUcFNm6w49Kc=;
        b=cFmahDDmHHD9HCMz3BuqdTQznHQr3x5ARtqcnAByhRrN7LBq3qUlWU7sAlvKVebti5
         RCaAZp0sE7dITU22bv4c4zvUMMIK+oqjqXGiu4M26qizGdfX13VStGKhqTD29Fjte9GE
         pvqWnXSt6e8+8yovo57r2mTAiDnW/clYWwpUl5fT/uTWHcwQlmZ2pYP//xNUQ3oTyhQ7
         rywXId35jX9EdozOnpMFRN+cvJIeR1TmL4VyRAO35OQB4hOtVt59e4LBUbVTK6NSZDDy
         FJdV4cNmP7bTSSuQsO/4keO160RTVHSE925jujDN/vG1nJE1pRxNJjP29NCUgX4T5g7I
         dXqw==
X-Gm-Message-State: AOAM530dpB/vlGryv9clHPhF1YstvcdcNj+TdZZBSvBaDOLxTOl1ad9U
        ENttdBVK9b5NGUsRJmIdOjA=
X-Google-Smtp-Source: ABdhPJzSQVwE7Bb+9mGRgCfNyffXiYGtwDfkeBKWE6u3UzUmpHek9/hw9VzPJkOGmhwIFOTMJskXFA==
X-Received: by 2002:a05:6638:144b:b0:321:589b:a8ea with SMTP id l11-20020a056638144b00b00321589ba8eamr10245216jad.296.1651704721781;
        Wed, 04 May 2022 15:52:01 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:94d4:5fe2:e117:e7c3])
        by smtp.gmail.com with ESMTPSA id i25-20020a02b699000000b0032b608e2926sm66372jam.9.2022.05.04.15.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 15:52:01 -0700 (PDT)
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
Subject: [PATCH v2 2/2] ktap_v2: change "version 1" to "version 2" in examples
Date:   Wed,  4 May 2022 17:51:52 -0500
Message-Id: <20220504225152.1451440-3-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504225152.1451440-1-frowand.list@gmail.com>
References: <20220504225152.1451440-1-frowand.list@gmail.com>
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
 Documentation/dev-tools/ktap.rst | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index 37b5dc61bfb8..c78bb46a4430 100644
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
 
@@ -204,9 +205,9 @@ An example of a test with two nested subtests:
 
 .. code-block:: none
 
-	KTAP version 1
+	KTAP version 2
 	1..1
-	  KTAP version 1
+	  KTAP version 2
 	  1..2
 	  ok 1 test_1
 	  not ok 2 test_2
@@ -217,11 +218,11 @@ An example format with multiple levels of nested testing:
 
 .. code-block:: none
 
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
@@ -252,21 +253,21 @@ Example KTAP output
 --------------------
 .. code-block:: none
 
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

