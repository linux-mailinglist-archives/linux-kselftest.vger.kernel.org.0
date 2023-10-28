Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A32B7DA466
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Oct 2023 02:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjJ1Ai3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 20:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjJ1Ai2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 20:38:28 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C431BD
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 17:38:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7b9e83b70so24976797b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 17:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698453505; x=1699058305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hd9WkLbC3/9tKbDr398vMG9sjKzgB6769/dIszrNtnA=;
        b=0WMvlORCh5eNdKteXyjztoAPal+jeVc94WtxFTyTPkacbGB6Uy7qO0oopPVCMS9Kd1
         R6uAt5fpwgyCJTj6v7zu5LWroSrxw7hWH7F/AskFMri4nDXpZkTWBMaZW5AVkZQ0Eb9T
         jaDFBOuWJSii9w/2Cm/unGNPKIB8qRnOenqt+O5DWva8wHHvYiCmxo9awZtx1LPi3Apq
         LPrhLrbJ/r3UdBs9s+lelrfO58TjmSAnP3SWoou9mSBNB5lEebCs5TllNteyXojSprgu
         a6rNx+UM8kpYJMO1nM1Ty7iSYJGeNOx5rsG217WxbZEvhhW1P2LLKscvERjDHj3XKy3G
         /+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698453505; x=1699058305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hd9WkLbC3/9tKbDr398vMG9sjKzgB6769/dIszrNtnA=;
        b=OEY7W3whWaFHhVue5wLfeavBx58v1Xl2Rh1gbpbv6uoyPWo4atiWynqtpoxkjRYbf8
         +P2YxvtXwf1a75YCp+afj62PP8lQZp3MtAV897rjod9yupKl3suTmUq4ah18LhWpxE8e
         ys1/lSNKbpSzT3Vx3fI5Di7xJlrHdi6voSBNL0uxgLKSUDhUsSCt/WqOUqUNm4xa+kPw
         7V2/WtxFWH29lpcs6RUh+ZBuXOQpFd0/5Xt+EKdS6AetRf71XIqZMEW6YX1Q/2A8XLPW
         9fzh7F8f0cNsx7Pq0y47mS7zEUSKCoWX2FhCtvBTt36mmhfJlxkopJ/IhOiNCJYSSqMe
         YUMA==
X-Gm-Message-State: AOJu0YzP8YTbYycRho+qCPRSUWNTgLK4OEdIR0U6WFCJIGbr4iQYYyRZ
        0iPuWbgmCkmhvX6GZ2nhvbmWyLJB0go=
X-Google-Smtp-Source: AGHT+IEhFUjmYdEXljORLOc7MoR1TUT63j0H8MtfIU3FFKJvRVJyyGkKkhRak6IgKRfrZGiSU7tVlIjlryE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:cba3:7e7f:79e4:fa57])
 (user=surenb job=sendgmr) by 2002:a81:7648:0:b0:59b:b0b1:d75a with SMTP id
 j8-20020a817648000000b0059bb0b1d75amr194570ywk.4.1698453504908; Fri, 27 Oct
 2023 17:38:24 -0700 (PDT)
Date:   Fri, 27 Oct 2023 17:38:11 -0700
In-Reply-To: <20231028003819.652322-1-surenb@google.com>
Mime-Version: 1.0
References: <20231028003819.652322-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231028003819.652322-2-surenb@google.com>
Subject: [PATCH v4 1/5] mm/rmap: support move to different root anon_vma in folio_move_anon_rmap()
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        david@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Andrea Arcangeli <aarcange@redhat.com>

For now, folio_move_anon_rmap() was only used to move a folio to a
different anon_vma after fork(), whereby the root anon_vma stayed
unchanged. For that, it was sufficient to hold the folio lock when
calling folio_move_anon_rmap().

However, we want to make use of folio_move_anon_rmap() to move folios
between VMAs that have a different root anon_vma. As folio_referenced()
performs an RMAP walk without holding the folio lock but only holding the
anon_vma in read mode, holding the folio lock is insufficient.

When moving to an anon_vma with a different root anon_vma, we'll have to
hold both, the folio lock and the anon_vma lock in write mode.
Consequently, whenever we succeeded in folio_lock_anon_vma_read() to
read-lock the anon_vma, we have to re-check if the mapping was changed
in the meantime. If that was the case, we have to retry.

Note that folio_move_anon_rmap() must only be called if the anon page is
exclusive to a process, and must not be called on KSM folios.

This is a preparation for UFFDIO_MOVE, which will hold the folio lock,
the anon_vma lock in write mode, and the mmap_lock in read mode.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/rmap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index 7a27a2b41802..525c5bc0b0b3 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -542,6 +542,7 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 	struct anon_vma *root_anon_vma;
 	unsigned long anon_mapping;
 
+retry:
 	rcu_read_lock();
 	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
 	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
@@ -552,6 +553,17 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
 	root_anon_vma = READ_ONCE(anon_vma->root);
 	if (down_read_trylock(&root_anon_vma->rwsem)) {
+		/*
+		 * folio_move_anon_rmap() might have changed the anon_vma as we
+		 * might not hold the folio lock here.
+		 */
+		if (unlikely((unsigned long)READ_ONCE(folio->mapping) !=
+			     anon_mapping)) {
+			up_read(&root_anon_vma->rwsem);
+			rcu_read_unlock();
+			goto retry;
+		}
+
 		/*
 		 * If the folio is still mapped, then this anon_vma is still
 		 * its anon_vma, and holding the mutex ensures that it will
@@ -586,6 +598,18 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 	rcu_read_unlock();
 	anon_vma_lock_read(anon_vma);
 
+	/*
+	 * folio_move_anon_rmap() might have changed the anon_vma as we might
+	 * not hold the folio lock here.
+	 */
+	if (unlikely((unsigned long)READ_ONCE(folio->mapping) !=
+		     anon_mapping)) {
+		anon_vma_unlock_read(anon_vma);
+		put_anon_vma(anon_vma);
+		anon_vma = NULL;
+		goto retry;
+	}
+
 	if (atomic_dec_and_test(&anon_vma->refcount)) {
 		/*
 		 * Oops, we held the last refcount, release the lock
-- 
2.42.0.820.g83a721a137-goog

