Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E2E6D1950
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 10:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjCaIEw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 04:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjCaIEk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 04:04:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4B9B3
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 01:04:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k199-20020a2524d0000000b00b7f3a027e50so6408990ybk.4
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 01:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680249877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jpGavDy61WmZmhN58Mtaqc/5O+sP6wYORL/bT/HmA3s=;
        b=Jk+cj+bjqrt3IqsApBiA7kyT1hEOS6On/c1fpo7tIRjMDJngA1tR7nXLnotUfnUWq/
         T9mKz27VMe9Rizr9kVZo/rgfAnwx8yAn7rasVFdwe9sWKMZ26kzZs5axvhoUdkRi2Yze
         cB+y4k0u/GmhVe91VPk2kN8oFvfZyKPH0pAHBavpOeiyQh1Qc4NRtA3iubKYqUe5Q/fR
         btr2lK1oD6j6/Dr+MTbru55OEucEtyU4//WfluYDnS7obc2ttuduLNi/fKqOBm/6krll
         QCwKUr1vRTCpTcCgk/TuBYLgNJ/rvKpph3zItKFgg4yLOotBEr3UOX/F57G3NjJpirvD
         Eljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680249877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpGavDy61WmZmhN58Mtaqc/5O+sP6wYORL/bT/HmA3s=;
        b=6X/0rqK4eNelifo86bxJ4AOAfMd4Fxy+/zADTXR87q/l0Xb+sLmQA6mO0ShE3EV64/
         OW87ctWOnXlSYk4xSxmreJqcJbe2kGWTti3nhK1K2rdplrX4DDa3O/UCaBaT/DKqcJtd
         5TJEnzjcE2GYVJWfPquQSMjlAtVYqFFBuOr97kTOqlYM/x5cNwtcVczrW4N23GXJah6d
         Ox6YQCkreZ8xVQs0fBkfVhtiF7mGBn21WeyO35Tyxeh/uh2X0ct3/GoOJG6bnSGFZfpH
         5vQveS7+fDv3HJEfkY6RJm1nnIhrIWT+ksqpyBUyqZCSyoT1ohT0bx4oJtMi9WZOR8Rd
         aBQQ==
X-Gm-Message-State: AAQBX9cTUnKmebS9wMC2lXv52SF24Q+7VOwT+/K9ftvmgduDklmFkrgV
        /diTukjJjVj/7Q3cXFTd8eZargzdwSTyig==
X-Google-Smtp-Source: AKy350YeFkXOzIOL84FaInn6T78DR5eXXkOwBFoQTOFE1jQOAGN+Kkru2oR7XOnak4OZulhM4Z2Ugi4l/W5cIw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:72e:b0:b6c:f26c:e5ab with SMTP
 id l14-20020a056902072e00b00b6cf26ce5abmr18114164ybt.3.1680249877289; Fri, 31
 Mar 2023 01:04:37 -0700 (PDT)
Date:   Fri, 31 Mar 2023 16:04:11 +0800
In-Reply-To: <20230331080411.981038-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230331080411.981038-1-davidgow@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230331080411.981038-4-davidgow@google.com>
Subject: [RFC PATCH v2 3/3] kunit: kmalloc_array: Use kunit_add_action()
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/test.c | 48 ++++++++----------------------------------------
 1 file changed, 8 insertions(+), 40 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index e2910b261112..ec45c8863f04 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -712,58 +712,26 @@ static struct notifier_block kunit_mod_nb = {
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
-
-	res->data = kmalloc_array(params->n, params->size, params->gfp);
-	if (!res->data)
-		return -ENOMEM;
-
-	return 0;
-}
+	void *data;
 
-static void kunit_kmalloc_array_free(struct kunit_resource *res)
-{
-	kfree(res->data);
-}
+	data = kmalloc_array(n, size, gfp);
 
-void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
-{
-	struct kunit_kmalloc_array_params params = {
-		.size = size,
-		.n = n,
-		.gfp = gfp
-	};
+	if (!data)
+		return NULL;
 
-	return kunit_alloc_resource(test,
-				    kunit_kmalloc_array_init,
-				    kunit_kmalloc_array_free,
-				    gfp,
-				    &params);
+	kunit_add_action(test, (kunit_defer_function_t)kfree, data, gfp);
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
+	kunit_release_action(test, (kunit_defer_function_t)kfree, (void *)ptr);
 }
 EXPORT_SYMBOL_GPL(kunit_kfree);
 
-- 
2.40.0.348.gf938b09366-goog

