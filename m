Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C9259B4C2
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Aug 2022 17:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiHUPCE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 11:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiHUPCE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 11:02:04 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6086D220D0
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Aug 2022 08:02:03 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 8589230F393;
        Sun, 21 Aug 2022 17:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661094121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NGn4jZsbuNjkEtw7pLzAbQJitKSYJr1nvJnRle8TX58=;
        b=OXyvnHf/kMUwjaMvbZ5Vag0qmd7adQ+djvciGJVsxi1W5MiYHu0XGIuNqm6ZH36wKofAD2
        OUAYQ+gnUPulBqXKIM9vq8GayxPQq+5ovLUiQ1+dzx7OqdnahLjf7ug/wkoJ1UBif5OjJS
        YZqUsPXjbFiHxNIyT/9SMramk7afs9CB1l+yWMpkd6qnNv8eELbht0APUYua3Ic7mZUO73
        f5iZbNHv2Keox1LKlP6YG765+U3eZkcc0uad4FJKtO3roVhJD8mYFCtGnrMzb5wUSKsv1U
        MDda1Q0qj8wRsfE2hKlGUYlefCeUPaKB8ie1qYYNkpqnaveIfN6jUi21hAXQLQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v2] kunit: fix assert_type for comparison macros
Date:   Sun, 21 Aug 2022 17:01:47 +0200
Message-Id: <20220821150147.277753-1-sander@svanheule.net>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When replacing KUNIT_BINARY_*_MSG_ASSERTION() macros with
KUNIT_BINARY_INT_ASSERTION(), the assert_type parameter was not always
correctly transferred.  Specifically, the following errors were
introduced:
  - KUNIT_EXPECT_LE_MSG() uses KUNIT_ASSERTION
  - KUNIT_ASSERT_LT_MSG() uses KUNIT_EXPECTATION
  - KUNIT_ASSERT_GT_MSG() uses KUNIT_EXPECTATION

A failing KUNIT_EXPECT_LE_MSG() test thus prevents further tests from
running, while failing KUNIT_ASSERT_{LT,GT}_MSG() tests do not prevent
further tests from running.  This is contrary to the documentation,
which states that failing KUNIT_EXPECT_* macros allow further tests to
run, while failing KUNIT_ASSERT_* macros should prevent this.

Revert the KUNIT_{ASSERTION,EXPECTATION} switches to fix the behaviour
for the affected macros.

Fixes: 40f39777ce4f ("kunit: decrease macro layering for integer asserts")
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 include/kunit/test.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index c958855681cc..840a2c375065 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -826,7 +826,7 @@ do {									       \
 
 #define KUNIT_EXPECT_LE_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_INT_ASSERTION(test,				       \
-				   KUNIT_ASSERTION,			       \
+				   KUNIT_EXPECTATION,			       \
 				   left, <=, right,			       \
 				   fmt,					       \
 				    ##__VA_ARGS__)
@@ -1116,7 +1116,7 @@ do {									       \
 
 #define KUNIT_ASSERT_LT_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_INT_ASSERTION(test,				       \
-				   KUNIT_EXPECTATION,			       \
+				   KUNIT_ASSERTION,			       \
 				   left, <, right,			       \
 				   fmt,					       \
 				    ##__VA_ARGS__)
@@ -1157,7 +1157,7 @@ do {									       \
 
 #define KUNIT_ASSERT_GT_MSG(test, left, right, fmt, ...)		       \
 	KUNIT_BINARY_INT_ASSERTION(test,				       \
-				   KUNIT_EXPECTATION,			       \
+				   KUNIT_ASSERTION,			       \
 				   left, >, right,			       \
 				   fmt,					       \
 				    ##__VA_ARGS__)
-- 
2.37.2

