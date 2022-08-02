Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8962858801A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 18:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiHBQQl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 12:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbiHBQPr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 12:15:47 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B735244C;
        Tue,  2 Aug 2022 09:13:12 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Ly0QD64Z3zDqP7;
        Tue,  2 Aug 2022 16:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659456773; bh=dJvkjz5q+UjtrpfqwZXEWprXYS3ZxbQTVDUb6XEz5+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UfAta++ZdlrDFF9oJo3hrF/X+G1omfbvMLdFctmQ7qyoqa5NyFXUNpAt1hiYzW6Y3
         CbWrPWrlUGGd22eOoosernHMnMy4XgBjx87GtQUwOg7cTnkvbno2dYdh2GsrH7MSXG
         X+5JuMaobXjQLGZYio4dWWwsEA2vhar0Q4fZzCQk=
X-Riseup-User-ID: 83E1D91EBC164CF9789726DDF682014813EF89086BB18E6456191CC4E022AB31
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Ly0Q662Ndz5vTk;
        Tue,  2 Aug 2022 16:12:46 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        airlied@linux.ie, daniel@ffwll.ch, davem@davemloft.net,
        kuba@kernel.org, jose.exposito89@gmail.com, javierm@redhat.com
Cc:     andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH 2/3] kunit: add KUnit array assertions to the example_all_expect_macros_test
Date:   Tue,  2 Aug 2022 13:12:05 -0300
Message-Id: <20220802161206.228707-3-mairacanal@riseup.net>
In-Reply-To: <20220802161206.228707-1-mairacanal@riseup.net>
References: <20220802161206.228707-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Increament the example_all_expect_macros_test with the
KUNIT_EXPECT_ARREQ and KUNIT_EXPECT_ARRNEQ macros by creating a test
with array assertions.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 lib/kunit/kunit-example-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index f8fe582c9e36..fc81a45d9cbc 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -86,6 +86,9 @@ static void example_mark_skipped_test(struct kunit *test)
  */
 static void example_all_expect_macros_test(struct kunit *test)
 {
+	const u32 array[] = { 0x0F, 0xFF };
+	const u32 expected[] = { 0x1F, 0xFF };
+
 	/* Boolean assertions */
 	KUNIT_EXPECT_TRUE(test, true);
 	KUNIT_EXPECT_FALSE(test, false);
@@ -109,6 +112,10 @@ static void example_all_expect_macros_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, "hi", "hi");
 	KUNIT_EXPECT_STRNEQ(test, "hi", "bye");
 
+	/* Array assertions */
+	KUNIT_EXPECT_ARREQ(test, expected, expected, 2);
+	KUNIT_EXPECT_ARRNEQ(test, array, expected, 2);
+
 	/*
 	 * There are also ASSERT variants of all of the above that abort test
 	 * execution if they fail. Useful for memory allocations, etc.
-- 
2.37.1

