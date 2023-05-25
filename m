Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBE8710407
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 06:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbjEYEWF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 00:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjEYEV5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 00:21:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0B3B3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 21:21:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8cf175f5bso308450276.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 21:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684988514; x=1687580514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6+sgLz6IKrRIO1yM+TpsTAd9X8BjcHwKTpevLF9Po4=;
        b=acs2JXhDytmqbLjWUEKhEkUFKrCaBUNuqEeIXFSkxZV7b+9bvAMlxxDqn1jMcHOB14
         6XTzYmb7BFqj32KP8Wz01ehCy45RNxbyvseLn6490y+8WoJrQGGpQHvwkaGw7ej7km5t
         bhOGaNsgyLj7VWjNFdJhyWwzEanRcmUEaTuQ2G9MinnG9DfhOzAuYJa7uA1UES3fcKAx
         x7aREWcR8ycChGRDqL+f49aHXOvU5WmK3BjMLybSUXNEqDzvoB+so/1VjVSz7j8H9tSg
         JD6uWtRebzL9lUiVjL+uIVvXGV5uDiLrCkacj8IckkLT1Uf4HwzA8Uy/jDe0oM2lFoxT
         ZJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684988514; x=1687580514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6+sgLz6IKrRIO1yM+TpsTAd9X8BjcHwKTpevLF9Po4=;
        b=AKavXLEKo3eab3pfLAWSROpxPpTT9Pzn8swmm5VvqsbXyMlbHvk9HLEsYyWQOhodHf
         HCvU89a3F5V/K9LYGlUicbQTlnApvGiQ/VOHJlsadN0Nq1jmdnngY6fCDBoMRmI8ywoY
         HVkPNsG+AkFckEKPjtPT90VANTLRsffjvFAJ9n5yu+AN++JHPZt+ObQOCyg9BEJWvL78
         uhWEa9wlqON3xSajE/930NbQhMgMIrFI8EKhUqOoScP9+gBukAsS8yWfyZCeE6UhrefY
         Baa9U26WhricsxdFRlIdd1IZk6b1gQbpe07rQAqHsPDO0+KoP1R0FkmROo/kxAWDYyik
         L2hQ==
X-Gm-Message-State: AC+VfDwCbHIaBu7bIOhSkVyYuD5F1AHOXoFUq0iSCbGNK/Dj15sKgpS1
        mZn9KJpaXXpsHwslKoOH5NwqIFBEIVuMGg==
X-Google-Smtp-Source: ACHHUZ5TJwnLd31an9veopSLqB2YlrNro/fDAjUNvfcwvcpKtjRqsyiBLYFC26WloVni/2gtqK+0Lx0Bg89szg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1613:b0:ba2:2d0e:a752 with SMTP
 id bw19-20020a056902161300b00ba22d0ea752mr1276553ybb.6.1684988513884; Wed, 24
 May 2023 21:21:53 -0700 (PDT)
Date:   Thu, 25 May 2023 12:21:30 +0800
In-Reply-To: <20230525042133.212534-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230525042133.212534-1-davidgow@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230525042133.212534-3-davidgow@google.com>
Subject: [PATCH v3 3/4] kunit: kmalloc_array: Use kunit_add_action()
From:   David Gow <davidgow@google.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>
Cc:     David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>
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

Note that we need to use kunit_defer_trigger_all() to implement
kunit_kfree().

Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>
Tested-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: David Gow <davidgow@google.com>
---

No changes since v2:
https://lore.kernel.org/linux-kselftest/20230518083849.2631178-3-davidgow@google.com/

Changes since v1:
https://lore.kernel.org/linux-kselftest/20230421084226.2278282-4-davidgow@google.com/
- Use the kunit_action_t typedef.
  - This fixes some spurious checkpatch warnings.

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
index 3028a1a3fcad..2f23d6efa505 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -324,8 +324,11 @@ enum kunit_status kunit_suite_has_succeeded(struct kunit_suite *suite);
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
 
@@ -336,6 +339,9 @@ void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp);
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
index f5e4ceffd282..d3fb93a23ccc 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -752,58 +752,28 @@ static struct notifier_block kunit_mod_nb = {
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
+	if (kunit_add_action_or_reset(test, (kunit_action_t *)kfree, data) != 0)
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
+	kunit_release_action(test, (kunit_action_t *)kfree, (void *)ptr);
 }
 EXPORT_SYMBOL_GPL(kunit_kfree);
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

