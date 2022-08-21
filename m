Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09D259B4BD
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Aug 2022 16:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiHUO7s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 10:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHUO7s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 10:59:48 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054D3193F6
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Aug 2022 07:59:46 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id E6E0530F38F;
        Sun, 21 Aug 2022 16:59:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1661093985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0L/1zZPXwT3KhPUeRIuxAhL42kC36ci9w7jqdIOHPso=;
        b=B32SzHgQIDMetyv1Y75FzA1V6HOZKUguuPJwBxGPLn4uCXPDtzJKS99ys0FM4+YD+R4fch
        Dogtpnqj+FUuxGUu5peMG3cotX1wcLZnbgmE0WmyM5pM2PIQJNUA44XAONDm0f9rZQ37u4
        roX4g8Cm5F9pFCijNmghDoK52iKcfVgWA24JQw7t8bK9fnZaU7dstgWgr3NXhGNdpamzyu
        5h7ziDW4lL3I5tsjj2WU/DVXESeI1wYIwDGvI4ReZ7zUKsF8hgtbvfjVip4U3pYA3YXUvS
        /5k9292/tSHSRUPb+V4yWWiYg97T/odCY51fJU3a1/mzC355vJYfK5n2di72GA==
From:   Sander Vanheule <sander@svanheule.net>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH] kunit: fix assert_type for KUNIT_EXPECT_LE_MSG()
Date:   Sun, 21 Aug 2022 16:59:40 +0200
Message-Id: <20220821145940.277394-1-sander@svanheule.net>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When replacing KUNIT_BINARY_LE_MSG_ASSERTION() with
KUNIT_BINARY_INT_ASSERTION() for KUNIT_EXPECT_LE_MSG(), the assert_type
parameter was changed from KUNIT_EXPECTATION to KUNIT_ASSERTION.  This
causes KUNIT_EXPECT_LE_MSG() and KUNIT_ASSERT_LE_MSG() to behave the
same way, and tests after a failed KUNIT_EXPECT_LE_MSG() are not run.

Call KUNIT_BINARY_INT_ASSERTIO() with KUNIT_EXPECTATION for again match
the documented behavior for KUNIT_EXPECT_* macros.

Fixes: 40f39777ce4f ("kunit: decrease macro layering for integer asserts")
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 include/kunit/test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index c958855681cc..617ec995671d 100644
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
-- 
2.37.2

