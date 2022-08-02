Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0DB588380
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 23:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiHBV1G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 17:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiHBV04 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 17:26:56 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687671146;
        Tue,  2 Aug 2022 14:26:55 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4Ly7NZ2mBnz9t4M;
        Tue,  2 Aug 2022 21:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659475614; bh=WuK2Sx+mxOIQk5hMW52/XS5PWDjNUepSKr6xd8wUCA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YcKQQazb3MUnlVfMr3OPGpeNR7xJD32D0QRfzJJLXkqYgs1TYl/G+ykJhTJgPjiC9
         DmezALFAq05llDI/f843Z7ebkKFnlQUuPmihrSQE5pXL1+LUWmhvH8yJmrlgnK/DSW
         /JyLKV6yVmnhZ8ad661t0pkyh0RyG00t/Lz27GaU=
X-Riseup-User-ID: 43DA5C0C3D591D23322711762507FB2E04651A85A61A325FAFA6FFD94C0EAEAB
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Ly7NS2GH1z5vw2;
        Tue,  2 Aug 2022 21:26:48 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        Daniel Latypov <dlatypov@google.com>, airlied@linux.ie,
        daniel@ffwll.ch, davem@davemloft.net, kuba@kernel.org,
        jose.exposito89@gmail.com, javierm@redhat.com
Cc:     andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH v2 2/3] kunit: Add KUnit memory block assertions to the example_all_expect_macros_test
Date:   Tue,  2 Aug 2022 18:26:20 -0300
Message-Id: <20220802212621.420840-3-mairacanal@riseup.net>
In-Reply-To: <20220802212621.420840-1-mairacanal@riseup.net>
References: <20220802212621.420840-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Increament the example_all_expect_macros_test with the
KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros by creating a test
with memory block assertions.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
- Change the macro KUNIT_EXPECT_ARREQ to KUNIT_EXPECT_MEMEQ, in order to make
it easier for users to infer the right size unit (Daniel Latypov).
- Replace a constant number of array elements for ARRAY_SIZE() (André Almeida).
- Rename "array" and "expected" variables to "array1" and "array2" (Daniel Latypov).
---
 lib/kunit/kunit-example-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index f8fe582c9e36..8a9b0eeb1934 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -86,6 +86,9 @@ static void example_mark_skipped_test(struct kunit *test)
  */
 static void example_all_expect_macros_test(struct kunit *test)
 {
+	const u32 array1[] = { 0x0F, 0xFF };
+	const u32 array2[] = { 0x1F, 0xFF };
+
 	/* Boolean assertions */
 	KUNIT_EXPECT_TRUE(test, true);
 	KUNIT_EXPECT_FALSE(test, false);
@@ -109,6 +112,10 @@ static void example_all_expect_macros_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, "hi", "hi");
 	KUNIT_EXPECT_STRNEQ(test, "hi", "bye");
 
+	/* Memory block assertions */
+	KUNIT_EXPECT_MEMEQ(test, array1, array1, sizeof(u32) * ARRAY_SIZE(array1));
+	KUNIT_EXPECT_MEMNEQ(test, array1, array2, sizeof(u32) * ARRAY_SIZE(array1));
+
 	/*
 	 * There are also ASSERT variants of all of the above that abort test
 	 * execution if they fail. Useful for memory allocations, etc.
-- 
2.37.1

