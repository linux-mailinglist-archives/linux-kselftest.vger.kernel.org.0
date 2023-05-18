Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283DF707C3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 10:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjERIjU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 04:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjERIjP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 04:39:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A354726BA
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 01:39:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7e3fc659so3775522276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 01:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684399144; x=1686991144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMMY2IhA+ayZjLnqfRnZckNf3MVLjRtK6Q5wsal9HA8=;
        b=3x5r0tGrLw6rFp6TVHFxeLH725gzBcx5wp2Dx0AhmvLNwoWJPanri0ykYahpqr4Bh/
         3flyLRW5GC68zojn7bGlc1MPaiwsXlURyNl8wVubmu0OMi7PsJN2xlIqllKqTqhpTmD6
         xS1Gu+ANAXFWP4km77v1QHYuvmT+FC1EwWTUmB2TfTtJrwYVSms2A+trHMDHBToiOwEf
         tclxWcxLDJGNEVRE2h/7o7GGPBtZHT22GyMcOFSgPTuNJkhFAs/9THQtYQwaUiIQLWWe
         7vdZUf107RvLfDEURZZ25TNxWeuyHyfjsW+9LIIJJUeW2N+9LjnBzV5lPDqUUsu46jTH
         FGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684399144; x=1686991144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMMY2IhA+ayZjLnqfRnZckNf3MVLjRtK6Q5wsal9HA8=;
        b=YikpTYiZEMbXIlEv/NtBSwfxdJmV7wW0lhptihFtwG9HWB+vCybb4UdBJnFeEh0TjY
         3IfuTePmFcl4gEASu5eoUosGVbN8Mh+ra6csAtYHlMALxTb/hciAHL63b+R3PejxVykP
         jd5fCEdnzCfJX3tEwwrxdAc4pu+RfxCwxb1r+pQsam269D0ycgRmj/Lb1pGW9drvCKRM
         43AN0GxMHbzXUciKKISp/1Iqr668HWYdIiPeBqH7goEaS0PnTj4NuY5xp2GNVnWbd5EF
         QqfjNjw/E7MB5LOGLp0dUMoElURV9pgCXlrfHwKrE6RPWrWygOMFQmBktiaZ3xpH2grZ
         0Zew==
X-Gm-Message-State: AC+VfDxkHPLpkKTfBSYmZT4C9R/L1EslJ/MdFapi22DP7QMBHonpk0Vj
        gsgPyAx9jDbxMvpfVr+fJzFOGZxMn6jciQ==
X-Google-Smtp-Source: ACHHUZ6+gBSp4HG6CzdFt7TsBNeV5wUeCmkgtxTqlM4/GWSU0Rti7SiFwU4PuW0NfQ0/fLQErz0YOtpUN9/aGA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:2e07:0:b0:ba8:6b34:a6ce with SMTP id
 u7-20020a252e07000000b00ba86b34a6cemr461552ybu.8.1684399143958; Thu, 18 May
 2023 01:39:03 -0700 (PDT)
Date:   Thu, 18 May 2023 16:38:45 +0800
In-Reply-To: <20230518083849.2631178-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230518083849.2631178-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230518083849.2631178-3-davidgow@google.com>
Subject: [PATCH v2 3/4] kunit: kmalloc_array: Use kunit_add_action()
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
2.40.1.698.g37aff9b760-goog

