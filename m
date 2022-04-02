Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912FA4EFEAE
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Apr 2022 06:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbiDBEhj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Apr 2022 00:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbiDBEhi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Apr 2022 00:37:38 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD4864F8
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Apr 2022 21:35:46 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id i2-20020a056a00224200b004fa60c248a1so2637987pfu.13
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Apr 2022 21:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zyrVWi3eHGXqwO/PAUfW0hT/y7AsGTlfR6Cmc9pUvak=;
        b=q3Kjbu44DZyXkKCF1mY3KZ2OalLQjz4MK5N6yHZRgSAoh1jUVv6YVTYE1lmVnWpOna
         IGgwnh6lMzb/l0T5/aVuQcShrGv0h2JQ6wxuSGxp5RAWx0krKRspKjBOowTIG/Sg+jqA
         BAGh6kFIm9JmcE745XEc5GvIDmonb9rNLjLe1J9pXuu/RmrVhJunSiph7UTSyKOCeTal
         J1MREfxm4Rzkx63/NEcUgoz4Pw58+2u5HpacnXZVNOUvgYjdCWuMBiSAPq0HIUNPaa51
         Ciet5yDZm01TWyQQoVRSnGzVmH/Q3i7XLsHcXhMJL9ix7yQ5ukH1v5WvJUS4OC+1Vm35
         mfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zyrVWi3eHGXqwO/PAUfW0hT/y7AsGTlfR6Cmc9pUvak=;
        b=Jb44psfqLYnnNUFigf40H4TAZgSUmPrXGql3jSRn9DKzmDQQkaan6UccO5TeXZ2W1j
         DPhUoD7fQkh14lEtE/lQ8rHnF8kOC7tke7oUg2FhW7GabBm8sVzG4LEBYxNv/Koi+pOG
         pYZ16FbzyEWGB+MqXvkDf0Y5oeIoiF748s/1YFmVXMDvSQWzH/Ij1cX5qTkFNVjEfx1n
         3K8LPpD05ka9D+ExdeDUjJFVOPSbaxOBr6mGAgJQQaH6SVbpEP8XLwh+KGGtW00nFLW2
         xbYzg0HkKeC/q2lcAqccQZ861CoEfU8mZ8zLCixDHCa6KL78tPOpENT9Jh6lSxStJEoZ
         vQZA==
X-Gm-Message-State: AOAM532iogsHltKzHiIQoBC6ViouZTxtxi2ajRsv8+1mMmayOoWOEfdR
        LbqwyhY0CPTz8k1GbMEtq/YzeOTtN2Mspg==
X-Google-Smtp-Source: ABdhPJyvq3IT8PQCrPzDGfmGfW7P0YXSEoo254Y9El8NUclS+I0IGtOVKeJztQKUnFxjvHPAZE2Q2z9SOQG2Rw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90b:3b44:b0:1c7:9ca8:a19e with SMTP
 id ot4-20020a17090b3b4400b001c79ca8a19emr15183745pjb.245.1648874146285; Fri,
 01 Apr 2022 21:35:46 -0700 (PDT)
Date:   Sat,  2 Apr 2022 12:35:29 +0800
Message-Id: <20220402043530.923747-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v2 1/2] kunit: Make kunit_remove_resource() idempotent
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kunit_remove_resource() function is used to unlink a resource from
the list of resources in the test, making it no longer show up in
kunit_find_resource().

However, this could lead to a race condition if two threads called
kunit_remove_resource() on the same resource at the same time: the
resource would be removed from the list twice (causing a crash at the
second list_del()), and the refcount for the resource would be
decremented twice (instead of once, for the reference held by the
resource list).

Fix both problems, the first by using list_del_init(), and the second by
checking if the resource has already been removed using list_empty(),
and only decrementing its refcount if it has not.

Also add a KUnit test for the kunit_remove_resource() function which
tests this behaviour.

Reported-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20220318064959.3298768-1-davidgow@google.com/
- Rebased on top of Daniel's split of the resource system into
  resource.{c,h}
  - https://lore.kernel.org/linux-kselftest/20220328174143.857262-1-dlatypov@google.com/
  - https://lore.kernel.org/linux-kselftest/20220328174143.857262-2-dlatypov@google.com/

 lib/kunit/kunit-test.c | 35 +++++++++++++++++++++++++++++++++++
 lib/kunit/resource.c   |  8 ++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 555601d17f79..9005034558aa 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -190,6 +190,40 @@ static void kunit_resource_test_destroy_resource(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
 }
 
+static void kunit_resource_test_remove_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *res = kunit_alloc_and_get_resource(
+			&ctx->test,
+			fake_resource_init,
+			fake_resource_free,
+			GFP_KERNEL,
+			ctx);
+
+	/* The resource is in the list */
+	KUNIT_EXPECT_FALSE(test, list_empty(&ctx->test.resources));
+
+	/* Remove the resource. The pointer is still valid, but it can't be
+	 * found.
+	 */
+	kunit_remove_resource(test, res);
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+	/* We haven't been freed yet. */
+	KUNIT_EXPECT_TRUE(test, ctx->is_resource_initialized);
+
+	/* Removing the resource multiple times is valid. */
+	kunit_remove_resource(test, res);
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+	/* Despite having been removed twice (from only one reference), the
+	 * resource still has not been freed.
+	 */
+	KUNIT_EXPECT_TRUE(test, ctx->is_resource_initialized);
+
+	/* Free the resource. */
+	kunit_put_resource(res);
+	KUNIT_EXPECT_FALSE(test, ctx->is_resource_initialized);
+}
+
 static void kunit_resource_test_cleanup_resources(struct kunit *test)
 {
 	int i;
@@ -387,6 +421,7 @@ static struct kunit_case kunit_resource_test_cases[] = {
 	KUNIT_CASE(kunit_resource_test_init_resources),
 	KUNIT_CASE(kunit_resource_test_alloc_resource),
 	KUNIT_CASE(kunit_resource_test_destroy_resource),
+	KUNIT_CASE(kunit_resource_test_remove_resource),
 	KUNIT_CASE(kunit_resource_test_cleanup_resources),
 	KUNIT_CASE(kunit_resource_test_proper_free_ordering),
 	KUNIT_CASE(kunit_resource_test_static),
diff --git a/lib/kunit/resource.c b/lib/kunit/resource.c
index b8bced246217..09ec392d2323 100644
--- a/lib/kunit/resource.c
+++ b/lib/kunit/resource.c
@@ -98,11 +98,15 @@ EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
 void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
 {
 	unsigned long flags;
+	bool was_linked;
 
 	spin_lock_irqsave(&test->lock, flags);
-	list_del(&res->node);
+	was_linked = !list_empty(&res->node);
+	list_del_init(&res->node);
 	spin_unlock_irqrestore(&test->lock, flags);
-	kunit_put_resource(res);
+
+	if (was_linked)
+		kunit_put_resource(res);
 }
 EXPORT_SYMBOL_GPL(kunit_remove_resource);
 
-- 
2.35.1.1094.g7c7d902a7c-goog

