Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C31874A740
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 00:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjGFWvZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 18:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjGFWvP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 18:51:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A491FE6
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Jul 2023 15:51:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-576d63dfc1dso14122787b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Jul 2023 15:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688683860; x=1691275860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qwjh0UAlAYXVze8TCXBt1h/rZKLWFE0vCD0k3jVLMVk=;
        b=Y2yizmMpjzL0EwPNfj1fzhhPy4fB1Fio/333NC+Pl3+CabD5WvQiBObIAnbDvfdIz0
         55qqIyoV/B43yRJQMgc5PRzcnEO7oZ13pzUFcnMsRpYGZDSVSZeMWMJRv9WA6h3i6GfT
         TXaYPaz84vks82iZ0vbDvAGXP/Ef7g9EhKOVR1CvAJFhj45Vp0/ta+dk/HgbDOBioOwa
         2BKF9RsPqJx9l5jS/r3knSsrH/fNyDrHo/fZURqQr/YXnDI5GwojI2TLVLkJxGr1ous4
         fBuKAKMZ/SIafScZO/gr72YFQKtZJ6oKMnuQ1yiJQjaFtVwKCY9iv6k7Pl0tvv06AM6a
         3A8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688683860; x=1691275860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qwjh0UAlAYXVze8TCXBt1h/rZKLWFE0vCD0k3jVLMVk=;
        b=SrxKBLec+98/oPPykO/HmOhg2U7mUX7Gkn9QhyIH+04Jcw++py1gtmAlt2eHzP9Xdb
         JeQ56QwKwi03Y5V4uITEc33FY/4QMbn+NjSQT/kCMDg9z7Secl3K3h4U0UDUhIpSv1dD
         eePWpfUmWmJNl8UXQVdZjjQ56wzbrovdcXb6OYACmfIkhKjgLYmcPOjCAVfHkFCrDpKL
         lAZVGbhcfTgxl7tEC077dpUGbBOyKmW/h4fR6dwlzQAHiMXg59aHjnCGLtTCtKK2UQWK
         DLu/C8lBAaio+jbfX0ROBGTJ/Y2Y313Ir7XBsVEt7259w2cAwvcVTavyvbiWoYIAiSZf
         sI0g==
X-Gm-Message-State: ABy/qLb0oU3TLqvx/KwI9dN9Zt4sqme5GuFvm8VQF7AbyQfULC7xX0xe
        P/E/MVb2shwIhgEfRE/WAljbOec1eRTJDdgerSy6
X-Google-Smtp-Source: APBJJlEpiTBdlhXFZSaqCdtDMzVQ5W4G5GGFJKBbdNzbEaJCnt1GA18H5a/L9p5DQaoHYiuhi3h9J1K3iDtJg/4EMWJg
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:bec3:2b1c:87a:fca2])
 (user=axelrasmussen job=sendgmr) by 2002:a81:c642:0:b0:576:d9ea:1331 with
 SMTP id q2-20020a81c642000000b00576d9ea1331mr27910ywj.4.1688683860327; Thu,
 06 Jul 2023 15:51:00 -0700 (PDT)
Date:   Thu,  6 Jul 2023 15:50:33 -0700
In-Reply-To: <20230706225037.1164380-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230706225037.1164380-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230706225037.1164380-6-axelrasmussen@google.com>
Subject: [PATCH v3 5/8] mm: userfaultfd: support UFFDIO_POISON for hugetlbfs
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

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/hugetlb.c     | 19 +++++++++++++++++++
 mm/userfaultfd.c |  3 +--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 934e129d9939..20c5f6a5420a 100644
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
+		_dst_pte = make_pte_marker(PTE_MARKER_ERROR);
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
index 899aa621d7c1..9ce129fdd596 100644
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

