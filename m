Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFAA58943A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 23:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbiHCV73 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 17:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbiHCV7Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 17:59:25 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032515C364;
        Wed,  3 Aug 2022 14:59:21 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4Lym3X6hQTz9sVj;
        Wed,  3 Aug 2022 21:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659563961; bh=glxS61ZhA9NpjQ9BgyBjKtJiI7HbN3sRAOiv/aBjuag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQeSWqIzdyqk3hwGvamVbIybqjj/5zldarUeGyuNgErLczXp5208YnNIAe3xPMvtv
         QYJL+tp1OL8Xg9i5jHPIo0fv9SzgK9cY90WO+qQlIQRAeVs5tl/eOCr6NdjbAOVWLa
         +JXVXo0rLYqctbhkhFW9dpp7VRBswATfakNevMSw=
X-Riseup-User-ID: C6F2E6C326FCBCED5274DDA358CE340C31D5F169B3DAF8B842CD5F953A39C80F
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4Lym3S2jtCz1ySb;
        Wed,  3 Aug 2022 21:59:16 +0000 (UTC)
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
Subject: [PATCH v3 2/3] kunit: Add KUnit memory block assertions to the example_all_expect_macros_test
Date:   Wed,  3 Aug 2022 18:58:54 -0300
Message-Id: <20220803215855.258704-3-mairacanal@riseup.net>
In-Reply-To: <20220803215855.258704-1-mairacanal@riseup.net>
References: <20220803215855.258704-1-mairacanal@riseup.net>
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

Augment the example_all_expect_macros_test with the KUNIT_EXPECT_MEMEQ
and KUNIT_EXPECT_MEMNEQ macros by creating a test with memory block
assertions.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
---
v1 -> v2:
- Change the macro KUNIT_EXPECT_ARREQ to KUNIT_EXPECT_MEMEQ, in order to make
it easier for users to infer the right size unit (Daniel Latypov).
- Replace a constant number of array elements for ARRAY_SIZE() (André Almeida).
- Rename "array" and "expected" variables to "array1" and "array2" (Daniel Latypov).

v2 -> v3:
- Change "Increament" to "Augment" (Daniel Latypov).
- Use sizeof() for array sizes (Daniel Latypov).
---
 lib/kunit/kunit-example-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index f8fe582c9e36..66cc4e2365ec 100644
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
+	KUNIT_EXPECT_MEMEQ(test, array1, array1, sizeof(array1));
+	KUNIT_EXPECT_MEMNEQ(test, array1, array2, sizeof(array1));
+
 	/*
 	 * There are also ASSERT variants of all of the above that abort test
 	 * execution if they fail. Useful for memory allocations, etc.
--
2.37.1

