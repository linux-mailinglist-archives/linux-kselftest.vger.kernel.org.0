Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249F72FFB4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jan 2021 04:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbhAVDmk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jan 2021 22:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbhAVDj6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jan 2021 22:39:58 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83030C06121D
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:38:04 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id d85so3986856qkg.5
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jan 2021 19:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ww8Q0Da/+DIxS1T1usnfh0rNDpKLMU8oare1xDqS0zM=;
        b=Mf0oSq4JFezwt44YaRp1C+QuJzl97ccfxkHBzS1KNCWF3SlVvz4L7qYRdjMW7rmkkh
         juBf+RAWRBf7wD+eUdQEMMeeR8eIf+oO3VdpAhWyoi4b1E34M5nlKVv2+Fcu5N2Mt4kF
         YBDAx1Q81DIdxolkqzZzCvTJ/q7CS9WnpzURMusqoDF4EW/o+YMKn4M0HNTPtPxeRnri
         TKv9E0tpOA5FcmfUcja35jFz4+FpQTizg//+zGYFz5HpDOQ1l3DrCTH9H0Jjjbskk9Lr
         i+0Rrky0yfZ5xB5A6hfk5myMRInLbqTd9JXWRViRCEXU6/Cwf1CEHe3p0GYaKr4kPMH1
         XYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ww8Q0Da/+DIxS1T1usnfh0rNDpKLMU8oare1xDqS0zM=;
        b=AZQD3xDMIwdWqNNGyziKXCNOzY/07cS7woutRcI1xa+OUaV4IpXL41AnII3CCdYfIO
         UHQlhtRoAzmjnnDWUxXYZjzCDdb49GVrutUlcdxUuiPsS7d0WCoNzWZDNl5rnUat/Usl
         dPpQ+7v2IamOlR7WHMq1caA20zQhRGAyd1AqdpJgS71z+84H/VYVOUAZv/Sf0kJ+jEtW
         tCBfFLX9dXnF7esW8QxCS+YttY6LGIqPNTiCSRczpCvKv98WUStO1A+5K8Ke405eqN4U
         Aj+jzlCHPah6injiCsLtAm6w5vTyWDOx9MqBr6OGyWjF8lLuocaxv6bsWd4Gg2YOukTe
         uv6A==
X-Gm-Message-State: AOAM5303D+ycxQICIlADugeYA7F8QFbcWDGyQ8URzdT4NLnZf2eyScm5
        qdvN27cpsHXNG39dNRR3Sgbwfg==
X-Google-Smtp-Source: ABdhPJzt2/smnB6p66DCizkPFGoswyWg33mAx+2LV7Ch6Ynzoo1kwsCulZT1KMM0eO/W21Er8jepGg==
X-Received: by 2002:a37:8b81:: with SMTP id n123mr3195913qkd.242.1611286683789;
        Thu, 21 Jan 2021 19:38:03 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m85sm5426529qke.33.2021.01.21.19.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 19:38:03 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v7 08/14] mm/gup: do not migrate zero page
Date:   Thu, 21 Jan 2021 22:37:42 -0500
Message-Id: <20210122033748.924330-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122033748.924330-1-pasha.tatashin@soleen.com>
References: <20210122033748.924330-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On some platforms ZERO_PAGE(0) might end-up in a movable zone. Do not
migrate zero page in gup during longterm pinning as migration of zero page
is not allowed.

For example, in x86 QEMU with 16G of memory and kernelcore=5G parameter, I
see the following:

Boot#1: zero_pfn  0x48a8d zero_pfn zone: ZONE_DMA32
Boot#2: zero_pfn 0x20168d zero_pfn zone: ZONE_MOVABLE

On x86, empty_zero_page is declared in .bss and depending on the loader
may end up in different physical locations during boots.

Also, move is_zero_pfn() my_zero_pfn() functions under CONFIG_MMU, because
zero_pfn that they are using is declared in memory.c which is compiled
with CONFIG_MMU.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/mmzone.h  | 4 ++++
 include/linux/pgtable.h | 3 +--
 mm/gup.c                | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ae588b2f87ef..72b0b6eba854 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -427,6 +427,10 @@ enum zone_type {
 	 *    techniques might use alloc_contig_range() to hide previously
 	 *    exposed pages from the buddy again (e.g., to implement some sort
 	 *    of memory unplug in virtio-mem).
+	 * 6. ZERO_PAGE(0), kernelcore/movablecore setups might create
+	 *    situations where ZERO_PAGE(0) which is allocated differently
+	 *    on different platforms may end up in a movable zone. ZERO_PAGE(0)
+	 *    cannot be migrated.
 	 *
 	 * In general, no unmovable allocations that degrade memory offlining
 	 * should end up in ZONE_MOVABLE. Allocators (like alloc_contig_range())
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index ea5c4102c23e..54a740602618 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1118,6 +1118,7 @@ extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 extern void untrack_pfn_moved(struct vm_area_struct *vma);
 #endif
 
+#ifdef CONFIG_MMU
 #ifdef __HAVE_COLOR_ZERO_PAGE
 static inline int is_zero_pfn(unsigned long pfn)
 {
@@ -1142,8 +1143,6 @@ static inline unsigned long my_zero_pfn(unsigned long addr)
 }
 #endif
 
-#ifdef CONFIG_MMU
-
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int pmd_trans_huge(pmd_t pmd)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 857b273e32ac..fdd5cda30a07 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1580,6 +1580,8 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 		 * of the CMA zone if possible.
 		 */
 		if (is_migrate_cma_page(head)) {
+			if (is_zero_pfn(page_to_pfn(head)))
+				continue;
 			if (PageHuge(head)) {
 				if (!isolate_huge_page(head, &cma_page_list))
 					isolation_error_count++;
-- 
2.25.1

