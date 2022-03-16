Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018914DB95D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 21:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356159AbiCPU2I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 16:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357964AbiCPU17 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 16:27:59 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC603F8AE;
        Wed, 16 Mar 2022 13:26:43 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d15so1704635qty.8;
        Wed, 16 Mar 2022 13:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gns4/i7WVTMPvm4NCq+ncvvmRYDMWRv+EPtpCaahO6I=;
        b=Y4SLtxmwKiGsSL/pt5pVjNOc8tI4eDK8Avvn7lQnt8NjQTgicY9820fpiXjU5jBXAv
         fR6gCM19reTd6IHxEtYkZ7iXoZMjQi4S3S7cGEndRgEpU2439g9jVmmeuseWAg9KByeI
         PmuxYYiomzKSbVsLeHA9tPuOggZfxsR+/aFuUXZGsYcg4jdcPw4IFR9MVG9s4R8upKhT
         BeLDkiNxuMzCQq1vEtkM9Epb071ZocsII6eucqqe9a0hvwVhYPgmWes2tSSvm4GN0szb
         WgnkQSu9JbMCzjKuK2ZAhGrDF3Inos8eNDllCIV/oRp5jV28vxsrOzN7bj5aaGdRQT9c
         vdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gns4/i7WVTMPvm4NCq+ncvvmRYDMWRv+EPtpCaahO6I=;
        b=sXwCKYK6aPh7dQjY0V++LB/qqlvg5E2au/MM7crn6a0Z99zEqagPmWyGZYXGLIbrcv
         rw5C6dLu3EZ5CxsHp2ck83ail7EvgY/xM/Yfk4ZE+Rxbk0QShYxUUmOZhvIdno5gK+8Z
         q60Ya12B++F71S24rOH4zaBys0ci0CgpC84h/j9P/5SBVGPzin8XKmfGwNZz6g0nY+YL
         0oj1VzMUPdU55tVpfnl+IpCcdXkOxEb8IPBJg1ILccEjdJzzmu//DGEswhJkviFdSlyt
         a0fnhwDFXwAr3vSDcb7oRxSJsQq5LHOaZdJKJW6UKq2LUycI0IhNXgp9JWcyZG3eU3+L
         aStA==
X-Gm-Message-State: AOAM531AOlUyFL2/QgX+Z+RsrChPCX3Hz2fUn8eed6deeX0SCfpBYUN4
        RBlJ5DuaPFs+4fbaj4dVVBs=
X-Google-Smtp-Source: ABdhPJwDDTLLFZ3EPcFp8sFnXz3GpraQjpfswl3LzydEvK2e93Q65Q22kyKStXJosR6i+yavMvSWpw==
X-Received: by 2002:a05:622a:1808:b0:2e0:6d99:a782 with SMTP id t8-20020a05622a180800b002e06d99a782mr1360726qtc.406.1647462402852;
        Wed, 16 Mar 2022 13:26:42 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:7488:f626:3f3b:5607])
        by smtp.gmail.com with ESMTPSA id bp9-20020a05622a1b8900b002e0e86b8ac6sm1940074qtb.67.2022.03.16.13.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 13:26:42 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] Documentation: dev-tools: use literal block instead of code-block
Date:   Wed, 16 Mar 2022 15:26:22 -0500
Message-Id: <20220316202622.324866-3-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316202622.324866-1-frowand.list@gmail.com>
References: <20220316202622.324866-1-frowand.list@gmail.com>
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

KTAP Specification: Change code-block directives to straightforward
literal blocks since the blocks do not contain code.

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 Documentation/dev-tools/ktap.rst | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index 37b5dc61bfb8..b9a57ceddd4f 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -115,34 +115,32 @@ The diagnostic data field is optional, and results which have neither a
 directive nor any diagnostic data do not need to include the "#" field
 separator.
 
-Example result lines include:
-
-.. code-block:: none
+Example result lines include::
 
 	ok 1 test_case_name
 
 The test "test_case_name" passed.
 
-.. code-block:: none
+::
 
 	not ok 1 test_case_name
 
 The test "test_case_name" failed.
 
-.. code-block:: none
+::
 
 	ok 1 test # SKIP necessary dependency unavailable
 
 The test "test" was SKIPPED with the diagnostic message "necessary dependency
 unavailable".
 
-.. code-block:: none
+::
 
 	not ok 1 test # TIMEOUT 30 seconds
 
 The test "test" timed out, with diagnostic data "30 seconds".
 
-.. code-block:: none
+::
 
 	ok 5 check return code # rcode=0
 
@@ -202,7 +200,7 @@ allowed to be either indented or not indented.
 
 An example of a test with two nested subtests:
 
-.. code-block:: none
+::
 
 	KTAP version 1
 	1..1
@@ -215,7 +213,7 @@ An example of a test with two nested subtests:
 
 An example format with multiple levels of nested testing:
 
-.. code-block:: none
+::
 
 	KTAP version 1
 	1..2
@@ -250,7 +248,7 @@ nested version line, uses a line of the form
 
 Example KTAP output
 --------------------
-.. code-block:: none
+::
 
 	KTAP version 1
 	1..1
-- 
Frank Rowand <frank.rowand@sony.com>

