Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D917917EA
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 15:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbjIDNWK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 09:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbjIDNWJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 09:22:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D168CCD0
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Sep 2023 06:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=PfQ10RDcuF6bzVfXDVOWYd7nyL7h/wSUO25g2XCuP84=; t=1693833722; x=1695043322; 
        b=Y8ASWMegN9nEzgCPhMSD3bhB7d7PReyazIcQq1EJx2M/mfP5gutwdhOI+D4aV6rwt+USCPRC2mj
        CbznJEWgm3OX7CuH2bNczxlEUzPw1oQjNuWf5lEFNwEEt1fnTiNFuI4cy1kaGo4EhMnN79Yp9WGOw
        ntHpyjWS1y3ek0BQo/JL8dDrpNm9iwDq7dC1XqsmI8ovvhIeNqvKWDLH7DOMirc2SmVoVvtt23XWM
        VyBC0i4eqz1WJnajtN+lmvyoXGt3IQIvxNQLH77DJCGmmUjR3o2iYxqH2vdbiQT7bYe024xupOBGI
        ACRJBzQCc8tXAolQPajiFiqTEdAbMtreqBnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1qd9Wh-00D8YX-1f;
        Mon, 04 Sep 2023 15:21:59 +0200
From:   benjamin@sipsolutions.net
To:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/2] kunit: add parameter generation macro using description from array
Date:   Mon,  4 Sep 2023 15:21:38 +0200
Message-ID: <20230904132139.103140-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

The existing KUNIT_ARRAY_PARAM macro requires a separate function to
get the description. However, in a lot of cases the description can
just be copied directly from the array. Add a second macro that
avoids having to write a static function just for a single strscpy.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 Documentation/dev-tools/kunit/usage.rst |  7 ++++---
 include/kunit/test.h                    | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index c27e1646ecd9..fe8c28d66dfe 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -571,8 +571,9 @@ By reusing the same ``cases`` array from above, we can write the test as a
 	{
 		strcpy(desc, t->str);
 	}
-	// Creates `sha1_gen_params()` to iterate over `cases`.
-	KUNIT_ARRAY_PARAM(sha1, cases, case_to_desc);
+	// Creates `sha1_gen_params()` to iterate over `cases` while using
+	// the struct member `str` for the case description.
+	KUNIT_ARRAY_PARAM_DESC(sha1, cases, str);
 
 	// Looks no different from a normal test.
 	static void sha1_test(struct kunit *test)
@@ -588,7 +589,7 @@ By reusing the same ``cases`` array from above, we can write the test as a
 	}
 
 	// Instead of KUNIT_CASE, we use KUNIT_CASE_PARAM and pass in the
-	// function declared by KUNIT_ARRAY_PARAM.
+	// function declared by KUNIT_ARRAY_PARAM or KUNIT_ARRAY_PARAM_DESC.
 	static struct kunit_case sha1_test_cases[] = {
 		KUNIT_CASE_PARAM(sha1_test, sha1_gen_params),
 		{}
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 68ff01aee244..f60d11e41855 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1516,6 +1516,25 @@ do {									       \
 		return NULL;									\
 	}
 
+/**
+ * KUNIT_ARRAY_PARAM_DESC() - Define test parameter generator from an array.
+ * @name:  prefix for the test parameter generator function.
+ * @array: array of test parameters.
+ * @desc_member: structure member from array element to use as description
+ *
+ * Define function @name_gen_params which uses @array to generate parameters.
+ */
+#define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)					\
+	static const void *name##_gen_params(const void *prev, char *desc)			\
+	{											\
+		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
+		if (__next - (array) < ARRAY_SIZE((array))) {					\
+			strscpy(desc, __next->desc_member, KUNIT_PARAM_DESC_SIZE);		\
+			return __next;								\
+		}										\
+		return NULL;									\
+	}
+
 // TODO(dlatypov@google.com): consider eventually migrating users to explicitly
 // include resource.h themselves if they need it.
 #include <kunit/resource.h>
-- 
2.41.0

