Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718E874B8EC
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 23:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjGGV4F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 17:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjGGV4C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 17:56:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BDB2127
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 14:55:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c595cadae4bso2451197276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 14:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688766953; x=1691358953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OLsbot8A3mLzPOTacWgWQym2WdRGSP5CUekvmW42V6U=;
        b=u4eWVZhzXkhr8wDK2s+0iTmAY7l1h7R8MMREKtd6LAlEQHntgig16nK2DmvVjFtAts
         msXCG4jhwlQLWJ7mMhcWd94nmZDBm9Cq+zUjd6HljvgRAmkhpgv0xVCKBFZiliIr4ZRU
         lJ8XlRPYDtAXOgFTgkEbA2VAMupk6A+/nyrhmDIHETRiNLXPxTJkdqTH3PtZeCK+4ys/
         yja0ZfMTqDUhv3HkJ7Igyj0pyhydxjC+QDfmIGRe122yVx7v1/1OQSVN86AWXYuftoFV
         PzsEid3tTnR28UcWxblLYAu3XQZ8xKr3MUXV1i8PoVEZYRxu++znQoGIDktCzSa3JUOO
         wVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688766953; x=1691358953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLsbot8A3mLzPOTacWgWQym2WdRGSP5CUekvmW42V6U=;
        b=LItqY+dMwRMIgUcP8E5naXmTu36AuL7tQuGTVZYRlX3xa+jidHkOWN6SvU7d1IuYgQ
         sJI4Gwhs7JlMoZJUhZfT5ygc8VRgVPfltnkw5CKzJ3FX1WlHLU9JmLsI26rH2FwybGGK
         ziafamXX4raNyUbKj68+E2nxSENi26dOX9loKmwXHV+zMGYgtuJxuGaaq9wU6bHJN82V
         s9qYN283SGjflL3mPr0W/om4NxI4F826Q11iV408KaWGLxfPnRB0m5cGdUW3E5T2Bmmh
         QegGEh3ZFDjWKegs1/uVEnyevjJ4zAsBdXQ2fy/HNeL8gMSQk7YNV+IzGSccPruqnI/Z
         D10g==
X-Gm-Message-State: ABy/qLau2xv5kz4WJH87qHik7ZhBZZK6GVAtHnEZXsL+te2leRHUF3XE
        B/M1vqAH2DUrtgHWJ/lkbGn/wY6XD+mlDLVhGczK
X-Google-Smtp-Source: APBJJlHL/U0DvDL04upfB3UAQ4yyr3JL0AGmb9MqqDsUkDgEZRrl5NMG/hgdzAz1NMr7770PTdyAART4pZ39J+ilp8hn
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:c201:5125:39d1:ef3f])
 (user=axelrasmussen job=sendgmr) by 2002:a25:e442:0:b0:bd7:6810:6666 with
 SMTP id b63-20020a25e442000000b00bd768106666mr33172ybh.5.1688766952790; Fri,
 07 Jul 2023 14:55:52 -0700 (PDT)
Date:   Fri,  7 Jul 2023 14:55:37 -0700
In-Reply-To: <20230707215540.2324998-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230707215540.2324998-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707215540.2324998-6-axelrasmussen@google.com>
Subject: [PATCH v4 5/8] mm: userfaultfd: support UFFDIO_POISON for hugetlbfs
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
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

The behavior here is the same as it is for anon/shmem. This is done
separately because hugetlb pte marker handling is a bit different.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/hugetlb.c     | 19 +++++++++++++++++++
 mm/userfaultfd.c |  3 +--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 66225b21c64e..8789101de88f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6263,6 +6263,25 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	int writable;
 	bool folio_in_pagecache = false;
 
+	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
+		ptl = huge_pte_lock(h, dst_mm, dst_pte);
+
+		/* Don't overwrite any existing PTEs (even markers) */
+		if (!huge_pte_none(huge_ptep_get(dst_pte))) {
+			spin_unlock(ptl);
+			return -EEXIST;
+		}
+
+		_dst_pte = make_pte_marker(PTE_MARKER_POISONED);
+		set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+
+		/* No need to invalidate - it was non-present before */
+		update_mmu_cache(dst_vma, dst_addr, dst_pte);
+
+		spin_unlock(ptl);
+		return 0;
+	}
+
 	if (is_continue) {
 		ret = -EFAULT;
 		folio = filemap_lock_folio(mapping, idx);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 68157359dc34..eaa59fb81719 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -373,8 +373,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 * by THP.  Since we can not reliably insert a zero page, this
 	 * feature is not supported.
 	 */
-	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE) ||
-	    uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
+	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
 		mmap_read_unlock(dst_mm);
 		return -EINVAL;
 	}
-- 
2.41.0.255.g8b1d071c50-goog

