Return-Path: <linux-kselftest+bounces-12769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5D79177E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 07:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493791F21DA4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 05:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7BB13CFBC;
	Wed, 26 Jun 2024 05:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJnIj9qq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D86613AD31
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378506; cv=none; b=KPMgke8lqqGNjtNHMAE4hP+pTxnLaMuUu1iMpF76o+DIlIT83hEAjOXljdXETAmhCNaYCdt1vURtmkB+nUBJuFigPfq1H58i9Mn9gZVzUiP1IeZ/a2u3rc+kuFs0CQjs00TNJ4xSJVgQp2uzbgfsc1kl6kdR7FIi/BulW0VpJjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378506; c=relaxed/simple;
	bh=qx8MOK26n6rR3NnDetvMsPmMOa5xf3/d0U5fAnDsN5o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CR7rszYpLC1aFt7S0uxVD9Wc9P0JtrlBgiBd7iz2YVwLlP4r3xA5u48NvM/4s+8TQMeArqW2G8PX8HBOXueSu/mPEEuwR7dS10jmvO9tVSZDqkhGEfesWepKUz5gXZ4c9eDf5PqdA6V2XPrfBv9l5kCSjh04aiNoCN8QG1ckQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJnIj9qq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1f9c3c61dc9so76890725ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 22:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719378505; x=1719983305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gXkC9UGwLbi0GqLoxfNlsmYzpSOeBdR127cDmlyAfFg=;
        b=aJnIj9qqv3fx3rotKW4Xpghfv6zb7oJKXLgOrhEJakwpPFmJOU9sj6WUTEvn9l2dmh
         PIJVQvq39eqXPmrvf0JPGWtWTAHrwfRBfta6svYWF39yhf2pfWRVu23NIjlKo0VxHpPu
         GkBAsfwprpRhWqdpi//wROORBf43ta5eYQdtcgKgXLANPnK1l38uIvrR0nmiKRXdsJNc
         RDIczPuTgnHhv6D9qBzeR+AYcmZnwpKnAsuljMO+xs1RN46+qLvHm+WO7ObSG7D0VAOz
         cRnuYoC+1hYzTE+OPfP1GtJoG3ivmC7GSO3SeCmhrJ3N099GQmFLV3M5ggq+tpxm18n1
         Fzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719378505; x=1719983305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXkC9UGwLbi0GqLoxfNlsmYzpSOeBdR127cDmlyAfFg=;
        b=kKY3cdOKfrir18HhRUhaTZJCuOjryhTE84zfziVzlZC+0QWN2z6k8eeMsYcpUYJGJm
         sYLHhTQ5RFyCWNwP7tKKYEyAxL+DX7KhrN4i2kVyJpcdiPfc9e1GU8KTHTU1rXTVdDXD
         IA+fW6LKo/mlZbSc96EeSRdZ0MDkSdp28Tnk9qMeidyfVVLqFWfcZN0DruL9n3iVE8Pi
         fcRa1kWEzdct1dUbNK3t2o/KdJS14lrV0Uuf/g0PFqKZVlUeojb6KdrrqYvOnHNZOvpl
         u5qWf1d/bBa1nf3AcCN3fMqGk5SYp9SvOF3HJ4jcJy1GgkSnn5lVydtkhr9aezVwlLl+
         G3GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrlbNfm7ppa+37d3AjxFuQGAJwMe4cPC7P8P1/r4+gydQbEXFoCXwX7epABXVm9BI+QVdRSafjImDFYOA4e4T+lrX0um1Kw5YKP8FCNi1N
X-Gm-Message-State: AOJu0YwyBDu4Ty+1KAnbOfXKAdm/EUyOvbJrCY5ZczLMKzaBkhRVZxRJ
	hTnmrna553zMRYJBrDVeyxH5GM2pIzVN707B6d+acXxc37Lxnn6tj9Vt4JvQx2dRbF+SbbcQAs/
	OXPQbaEZhQg==
X-Google-Smtp-Source: AGHT+IEPP52YEAOSaOBTdeEN7RWm3wytwjEt4v74q/ZLwZQeZ8KX/WkYqZtMZc6X7SeBdJvi3Uxvj75c3h8DJA==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:902:e892:b0:1f7:ae0:3e3c with SMTP id
 d9443c01a7336-1fa23f8dd5fmr11037925ad.12.1719378504545; Tue, 25 Jun 2024
 22:08:24 -0700 (PDT)
Date: Wed, 26 Jun 2024 05:08:15 +0000
In-Reply-To: <20240626050818.2277273-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626050818.2277273-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240626050818.2277273-2-jiaqiyan@google.com>
Subject: [PATCH v6 1/4] mm/memory-failure: refactor log format in soft offline code
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com
Cc: jane.chu@oracle.com, rdunlap@infradead.org, ioworker0@gmail.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Logs from soft_offline_page and soft_offline_in_use_page have
different formats than majority of the memory failure code:

  "Memory failure: 0x${pfn}: ${lower_case_message}"

Convert them to the following format:

  "Soft offline: 0x${pfn}: ${lower_case_message}"

No functional change in this commit.

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 mm/memory-failure.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d3c830e817e3..6f5ac334efba 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2631,6 +2631,9 @@ int unpoison_memory(unsigned long pfn)
 }
 EXPORT_SYMBOL(unpoison_memory);
 
+#undef pr_fmt
+#define pr_fmt(fmt) "Soft offline: " fmt
+
 static bool mf_isolate_folio(struct folio *folio, struct list_head *pagelist)
 {
 	bool isolated = false;
@@ -2686,7 +2689,7 @@ static int soft_offline_in_use_page(struct page *page)
 
 	if (!huge && folio_test_large(folio)) {
 		if (try_to_split_thp_page(page)) {
-			pr_info("soft offline: %#lx: thp split failed\n", pfn);
+			pr_info("%#lx: thp split failed\n", pfn);
 			return -EBUSY;
 		}
 		folio = page_folio(page);
@@ -2698,7 +2701,7 @@ static int soft_offline_in_use_page(struct page *page)
 	if (PageHWPoison(page)) {
 		folio_unlock(folio);
 		folio_put(folio);
-		pr_info("soft offline: %#lx page already poisoned\n", pfn);
+		pr_info("%#lx: page already poisoned\n", pfn);
 		return 0;
 	}
 
@@ -2711,7 +2714,7 @@ static int soft_offline_in_use_page(struct page *page)
 	folio_unlock(folio);
 
 	if (ret) {
-		pr_info("soft_offline: %#lx: invalidated\n", pfn);
+		pr_info("%#lx: invalidated\n", pfn);
 		page_handle_poison(page, false, true);
 		return 0;
 	}
@@ -2728,13 +2731,13 @@ static int soft_offline_in_use_page(struct page *page)
 			if (!list_empty(&pagelist))
 				putback_movable_pages(&pagelist);
 
-			pr_info("soft offline: %#lx: %s migration failed %ld, type %pGp\n",
+			pr_info("%#lx: %s migration failed %ld, type %pGp\n",
 				pfn, msg_page[huge], ret, &page->flags);
 			if (ret > 0)
 				ret = -EBUSY;
 		}
 	} else {
-		pr_info("soft offline: %#lx: %s isolation failed, page count %d, type %pGp\n",
+		pr_info("%#lx: %s isolation failed, page count %d, type %pGp\n",
 			pfn, msg_page[huge], page_count(page), &page->flags);
 		ret = -EBUSY;
 	}
@@ -2786,7 +2789,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 	mutex_lock(&mf_mutex);
 
 	if (PageHWPoison(page)) {
-		pr_info("%s: %#lx page already poisoned\n", __func__, pfn);
+		pr_info("%#lx: page already poisoned\n", pfn);
 		put_ref_page(pfn, flags);
 		mutex_unlock(&mf_mutex);
 		return 0;
-- 
2.45.2.741.gdbec12cfda-goog


