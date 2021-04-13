Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E5F35DC2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Apr 2021 12:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbhDMKIK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Apr 2021 06:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240752AbhDMKIK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Apr 2021 06:08:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2897C061574;
        Tue, 13 Apr 2021 03:07:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x7so15810359wrw.10;
        Tue, 13 Apr 2021 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FwM59yTbDnSoBD6KRDn+z40LZ7IN7rcrI7Nk5SqbzKk=;
        b=DmlHPLWjktVtVCap8dnE1YNFhOzBBX2MikJhZs80jTxbZXQbAu0XaH2k4E9CCyFNnB
         llQQ5U246amGzAotRafCx3zfT6S9116pgxiVrwmiYNDskkMzIOzhAxO6ZRAVohV2itq9
         lmRmHHwrjWfPUr8GGkRhwfip9og38JOALfflR7MMcXoNcNsvx6WVC+Pe3h+11hJPtGb4
         Glsjv92p1DnUelTcU6LaMw1bvwabzXwLOtAjxh7T4sMFfa1Z6RxSv1ZmW3Pg54LCKORT
         j2JwjOT0A+C66rMdQw7zwjAtBc9l/HBCp2uIwCpm8i3cfxW3iws+ajIkVJgR4qnyzdCE
         Qv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FwM59yTbDnSoBD6KRDn+z40LZ7IN7rcrI7Nk5SqbzKk=;
        b=KiK/WtcWcdv93wI+Knc4vLm1fshmBwW6c8dqRyXrfoTLzUNlElOjuIr8cNza6VkpSS
         CloPt6llmkLwyiivOaRhnWM+5VPNAtgXoNvDVnimVz/NIeXmJ30Zm5AJ4Q1H5Gqj6wvz
         9hm8KSuy8wsagod8P2Ibcx9SywjHENX1RR9O1gSDds1E9dMkyCDiQFAMqf6i4wq8MEI9
         QGEnGIE2GHJ3OMLMoHYPNDSxsuJx1FTVrrKhQCm2Cq5LVKEdCapVB1NakfgEZKiOVx0H
         kRmoqChUi+JVStYLJ4lMsm/ugqukwRTZ13OERfCYaZhcuhrpg7o6auT15/9PlzTMKwDN
         5btg==
X-Gm-Message-State: AOAM530RnhOW9bHa1uKvsJFSt28AjV2vbRZNu1xR3WE7dkaRK6pMmOhD
        81aSDGclT62LDX+fEeLGkdM=
X-Google-Smtp-Source: ABdhPJwXFmzq87jl09bdCGZ4jT2r6PxCUkOiH71mR48+QR5bl2xTbEJNaFq7hfl8HDD3uCWaO8PDNA==
X-Received: by 2002:adf:bc49:: with SMTP id a9mr13537107wrh.109.1618308469638;
        Tue, 13 Apr 2021 03:07:49 -0700 (PDT)
Received: from oliver-Z170M-D3H.cuni.cz ([2001:718:1e03:5128:35b3:1d60:e26d:e79b])
        by smtp.gmail.com with ESMTPSA id b1sm19621280wru.90.2021.04.13.03.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 03:07:49 -0700 (PDT)
From:   glittao@gmail.com
To:     brendanhiggins@google.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org, elver@google.com,
        dlatypov@google.com, Oliver Glitta <glittao@gmail.com>
Subject: [PATCH v4 1/3] kunit: make test->lock irq safe
Date:   Tue, 13 Apr 2021 12:07:45 +0200
Message-Id: <20210413100747.4921-1-glittao@gmail.com>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Vlastimil Babka <vbabka@suse.cz>

The upcoming SLUB kunit test will be calling kunit_find_named_resource() from
a context with disabled interrupts. That means kunit's test->lock needs to be
IRQ safe to avoid potential deadlocks and lockdep splats.

This patch therefore changes the test->lock usage to spin_lock_irqsave()
and spin_unlock_irqrestore().

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Oliver Glitta <glittao@gmail.com>
---
 include/kunit/test.h |  5 +++--
 lib/kunit/test.c     | 18 +++++++++++-------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 49601c4b98b8..524d4789af22 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -515,8 +515,9 @@ kunit_find_resource(struct kunit *test,
 		    void *match_data)
 {
 	struct kunit_resource *res, *found = NULL;
+	unsigned long flags;
 
-	spin_lock(&test->lock);
+	spin_lock_irqsave(&test->lock, flags);
 
 	list_for_each_entry_reverse(res, &test->resources, node) {
 		if (match(test, res, (void *)match_data)) {
@@ -526,7 +527,7 @@ kunit_find_resource(struct kunit *test,
 		}
 	}
 
-	spin_unlock(&test->lock);
+	spin_unlock_irqrestore(&test->lock, flags);
 
 	return found;
 }
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index ec9494e914ef..2c62eeb45b82 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -442,6 +442,7 @@ int kunit_add_resource(struct kunit *test,
 		       void *data)
 {
 	int ret = 0;
+	unsigned long flags;
 
 	res->free = free;
 	kref_init(&res->refcount);
@@ -454,10 +455,10 @@ int kunit_add_resource(struct kunit *test,
 		res->data = data;
 	}
 
-	spin_lock(&test->lock);
+	spin_lock_irqsave(&test->lock, flags);
 	list_add_tail(&res->node, &test->resources);
 	/* refcount for list is established by kref_init() */
-	spin_unlock(&test->lock);
+	spin_unlock_irqrestore(&test->lock, flags);
 
 	return ret;
 }
@@ -515,9 +516,11 @@ EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);
 
 void kunit_remove_resource(struct kunit *test, struct kunit_resource *res)
 {
-	spin_lock(&test->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&test->lock, flags);
 	list_del(&res->node);
-	spin_unlock(&test->lock);
+	spin_unlock_irqrestore(&test->lock, flags);
 	kunit_put_resource(res);
 }
 EXPORT_SYMBOL_GPL(kunit_remove_resource);
@@ -597,6 +600,7 @@ EXPORT_SYMBOL_GPL(kunit_kfree);
 void kunit_cleanup(struct kunit *test)
 {
 	struct kunit_resource *res;
+	unsigned long flags;
 
 	/*
 	 * test->resources is a stack - each allocation must be freed in the
@@ -608,9 +612,9 @@ void kunit_cleanup(struct kunit *test)
 	 * protect against the current node being deleted, not the next.
 	 */
 	while (true) {
-		spin_lock(&test->lock);
+		spin_lock_irqsave(&test->lock, flags);
 		if (list_empty(&test->resources)) {
-			spin_unlock(&test->lock);
+			spin_unlock_irqrestore(&test->lock, flags);
 			break;
 		}
 		res = list_last_entry(&test->resources,
@@ -621,7 +625,7 @@ void kunit_cleanup(struct kunit *test)
 		 * resource, and this can't happen if the test->lock
 		 * is held.
 		 */
-		spin_unlock(&test->lock);
+		spin_unlock_irqrestore(&test->lock, flags);
 		kunit_remove_resource(test, res);
 	}
 #if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
-- 
2.31.1.272.g89b43f80a5

