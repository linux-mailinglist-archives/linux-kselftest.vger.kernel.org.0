Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5BE37AA3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 May 2021 17:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhEKPIr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 May 2021 11:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhEKPIq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 May 2021 11:08:46 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3BAC061574;
        Tue, 11 May 2021 08:07:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s6so23249899edu.10;
        Tue, 11 May 2021 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fRsR5t8wvCfu4sVp9hQ5wsUoHnYKOQm/lSOy9/33Bw=;
        b=qU+9gcOwydfg4s6P6n/Jb+5uionmETIkViN7y+BGerFtxjo3bl57OISiAWjpk8S9t2
         AhC97YSGC5R811hgJhp4Wk1drQAyUwZ2ih0doU8PbXjOeD0TevC3uXVC4n+x51XGcsts
         PKGHs1Hngz5Cw5oyclUpQZbmRdUCUR6CvWfiHncCH6/1XT4zmG2QSAEEHzdPdCG2amyX
         aMf23Mqnki3G62xwUiuL8dJhRw5kMCiTlmyyaSZwkYzpypWjWkhZl9N2SbcNGcloKbWl
         dH9pmLYQbP42p+hpaQ0eKQQ7G3Tu4Er2jAejDC2g8nsN8Va0HB+/Wbu2AX5vy60fCymQ
         WEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+fRsR5t8wvCfu4sVp9hQ5wsUoHnYKOQm/lSOy9/33Bw=;
        b=cjaS6g/bw79eAxI9Tcvjrh4OwcsOIF7LR26h8TKFGBD8Urp/vZK36cZSoxTTtPm1md
         qlF1+WIXxPGFg70GNzWg+5/kzys9SqaHKQVUEHh4C6wAsueRKj0I+QFrlwNlTg2W3AuP
         ZK4Xa60fTP/RRYndGYj7UmCOLv9MlTpfbkzVwS7VOHeGP5qs99q7xG7SuwgxzJZeQhnq
         uEBc8qqRPJy33zwlOFR09UggHX1fKzPTfohLiEdQfMhCwckpSW95LdZsKPFtXyUQkSWH
         H/dMu+bZILOK7qA8aSh13GOaSHx6eWTXo0xf3XkM8vz4wywYu1JRTgjRMeyZMBmrmK7i
         ab/g==
X-Gm-Message-State: AOAM533V/7fTzpPdKLUwXtNscO6mQFLnMl133roo4pUg1+zGn69nqcIq
        trEcm+Imcx6IGppxJJ72kcE=
X-Google-Smtp-Source: ABdhPJzVrN4P/dKwWMkwHkth9UYmwQuaRE8e4YYq8slMmp8f8icnhSQHfcZPPLBj0WhS5HmnOJCnNg==
X-Received: by 2002:a50:c446:: with SMTP id w6mr33437597edf.62.1620745656797;
        Tue, 11 May 2021 08:07:36 -0700 (PDT)
Received: from localhost.localdomain (ispc-static-34.84-47-111.telekom.sk. [84.47.111.34])
        by smtp.gmail.com with ESMTPSA id lr15sm11872709ejb.107.2021.05.11.08.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 08:07:36 -0700 (PDT)
From:   glittao@gmail.com
To:     brendanhiggins@google.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org, elver@google.com,
        dlatypov@google.com, Oliver Glitta <glittao@gmail.com>
Subject: [PATCH v5 1/3] kunit: make test->lock irq safe
Date:   Tue, 11 May 2021 17:07:32 +0200
Message-Id: <20210511150734.3492-1-glittao@gmail.com>
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
Changes since v4
Rebased whole series on 5.13-rc1

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
index 2f6cc0123232..45f068864d76 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -475,6 +475,7 @@ int kunit_add_resource(struct kunit *test,
 		       void *data)
 {
 	int ret = 0;
+	unsigned long flags;

 	res->free = free;
 	kref_init(&res->refcount);
@@ -487,10 +488,10 @@ int kunit_add_resource(struct kunit *test,
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
@@ -548,9 +549,11 @@ EXPORT_SYMBOL_GPL(kunit_alloc_and_get_resource);

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
@@ -630,6 +633,7 @@ EXPORT_SYMBOL_GPL(kunit_kfree);
 void kunit_cleanup(struct kunit *test)
 {
 	struct kunit_resource *res;
+	unsigned long flags;

 	/*
 	 * test->resources is a stack - each allocation must be freed in the
@@ -641,9 +645,9 @@ void kunit_cleanup(struct kunit *test)
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
@@ -654,7 +658,7 @@ void kunit_cleanup(struct kunit *test)
 		 * resource, and this can't happen if the test->lock
 		 * is held.
 		 */
-		spin_unlock(&test->lock);
+		spin_unlock_irqrestore(&test->lock, flags);
 		kunit_remove_resource(test, res);
 	}
 	current->kunit_test = NULL;
--
2.31.1.272.g89b43f80a5

