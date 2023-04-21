Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506406EA61D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 10:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjDUInI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 04:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjDUImz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 04:42:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81E59757
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 01:42:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8ed0d99a7fso832725276.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 01:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682066568; x=1684658568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEEb4C1MXHRprmR5HHPu3CotKdbDXVaTHLjb5P98lHM=;
        b=yzRovhVJ66P12HUPvsEjD48dab5ICCTEQbiTUmWPwkPZveJ7/5bYyKdfQWuNxasm0k
         974M6Y84tvzdkeXl91gtaNdMevz2gswJETxqftQm74ua7wsJF4El/xUmm5r/VP1mjeN4
         X0kNDkyQGm9iPFrg7TicqN/Bel5ywQDtqbGEJJeSGwAH1/zuvNIu4YuP/WBYZ2e1Yeja
         jDwUJ7IZVhRQqVG5Zg5GsJMUbN8h/UjqNqZayme/AjtggXUXAgTm4N1TGyPN46KLXjip
         8LqeO+2Fi9yZB7KydrGRZnbfLA4cChWN1KKeRyl2doM0e4uJjGh75iixJ/kOsYGR5EQR
         Jpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066568; x=1684658568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEEb4C1MXHRprmR5HHPu3CotKdbDXVaTHLjb5P98lHM=;
        b=ReXxOE1j7V5vpSBl4e1cMxDNs+ARwI7c3v+GS3PiyWKUL1SztLGU97OtPh247gtG6V
         cix7pmZJxtNMKdyJ2XO4uFn2SrN+86uLBL9o/lHHoxEzPosNLvdZDOjj18lqfUFmJIcs
         DWtmPqdFFK2K1wp/mamR0LB4cvzgpYvuqxyfmP4OflHrgyY9YE0E/Lghus0aoh+zZjYc
         9ReiPuenS8ftNybvq/1NUjBcv0qWf/0jWAx5N37KtMXqMHsnjPdhFFH3YcuatfNzWNgN
         V2iOGM2EeRr17J7e7gHhjPJQ7DwHIyAcEP3w7eAkoxB/Yc05gPN8yU8LTRSSr6X8v40Z
         YrfQ==
X-Gm-Message-State: AAQBX9c4Mb5FkGMPvBMY8B93btk6M648KxWxXCaSyugkwj9KhRlQQfFX
        Y1B3zyBLMEpUc3Ic9yfAMaZPEkgSH38wHQ==
X-Google-Smtp-Source: AKy350aXCY521YxQpLSky5f+7Krq4YeBVK66lmw9NALxj4KPTruWIrf9Mv+7P5X5dRe2C7exCPaiWGO5pAZFQQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:6e46:0:b0:b8f:610b:e6b8 with SMTP id
 j67-20020a256e46000000b00b8f610be6b8mr1259447ybc.9.1682066567913; Fri, 21 Apr
 2023 01:42:47 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:42:26 +0800
In-Reply-To: <20230421084226.2278282-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230421084226.2278282-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421084226.2278282-4-davidgow@google.com>
Subject: [PATCH v1 3/3] kunit: kmalloc_array: Use kunit_add_action()
From:   David Gow <davidgow@google.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
Cc:     David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kunit_add_action() function is much simpler and cleaner to use that
the full KUnit resource API for simple things like the
kunit_kmalloc_array() functionality.

Replacing it allows us to get rid of a number of helper functions, and
leaves us with no uses of kunit_alloc_resource(), which has some
usability problems and is going to have its behaviour modified in an
upcoming patch.

Note that we need to use kunit_release_action() to implement kunit_kfree().

Signed-off-by: David Gow <davidgow@google.com>
---

Changes since RFCv2:
https://lore.kernel.org/linux-kselftest/20230331080411.981038-4-davidgow@google.com/
- Update to match changes in the the action API.
- Always allocate the action context with GFP_KERNEL.
- Update documentation to note that this will cause GFP_KERNEL
  allocations, regardless of the gfp argument passed in.

---
 include/kunit/test.h | 10 +++++++--
 lib/kunit/test.c     | 48 +++++++++-----------------------------------
 2 files changed, 17 insertions(+), 41 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 57b309c6ca27..3e8e98d0d8b1 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -321,8 +321,11 @@ enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite);
  * @gfp: flags passed to underlying kmalloc().
  *
  * Just like `kmalloc_array(...)`, except the allocation is managed by the test case
- * and is automatically cleaned up after the test case concludes. See &struct
- * kunit_resource for more information.
+ * and is automatically cleaned up after the test case concludes. See kunit_add_action()
+ * for more information.
+ *
+ * Note that some internal context data is also allocated with GFP_KERNEL,
+ * regardless of the gfp passed in.
  */
 void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp);
 
@@ -333,6 +336,9 @@ void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp);
  * @gfp: flags passed to underlying kmalloc().
  *
  * See kmalloc() and kunit_kmalloc_array() for more information.
+ *
+ * Note that some internal context data is also allocated with GFP_KERNEL,
+ * regardless of the gfp passed in.
  */
 static inline void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
 {
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index e2910b261112..6aafe2138766 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -712,58 +712,28 @@ static struct notifier_block kunit_mod_nb = {
 };
 #endif
 
-struct kunit_kmalloc_array_params {
-	size_t n;
-	size_t size;
-	gfp_t gfp;
-};
-
-static int kunit_kmalloc_array_init(struct kunit_resource *res, void *context)
+void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
 {
-	struct kunit_kmalloc_array_params *params = context;
+	void *data;
 
-	res->data = kmalloc_array(params->n, params->size, params->gfp);
-	if (!res->data)
-		return -ENOMEM;
+	data = kmalloc_array(n, size, gfp);
 
-	return 0;
-}
+	if (!data)
+		return NULL;
 
-static void kunit_kmalloc_array_free(struct kunit_resource *res)
-{
-	kfree(res->data);
-}
+	if (kunit_add_action_or_reset(test, (void (*)(void *))kfree, data) != 0)
+		return NULL;
 
-void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
-{
-	struct kunit_kmalloc_array_params params = {
-		.size = size,
-		.n = n,
-		.gfp = gfp
-	};
-
-	return kunit_alloc_resource(test,
-				    kunit_kmalloc_array_init,
-				    kunit_kmalloc_array_free,
-				    gfp,
-				    &params);
+	return data;
 }
 EXPORT_SYMBOL_GPL(kunit_kmalloc_array);
 
-static inline bool kunit_kfree_match(struct kunit *test,
-				     struct kunit_resource *res, void *match_data)
-{
-	/* Only match resources allocated with kunit_kmalloc() and friends. */
-	return res->free == kunit_kmalloc_array_free && res->data == match_data;
-}
-
 void kunit_kfree(struct kunit *test, const void *ptr)
 {
 	if (!ptr)
 		return;
 
-	if (kunit_destroy_resource(test, kunit_kfree_match, (void *)ptr))
-		KUNIT_FAIL(test, "kunit_kfree: %px already freed or not allocated by kunit", ptr);
+	kunit_release_action(test, (void (*)(void *))kfree, (void *)ptr);
 }
 EXPORT_SYMBOL_GPL(kunit_kfree);
 
-- 
2.40.0.634.g4ca3ef3211-goog

