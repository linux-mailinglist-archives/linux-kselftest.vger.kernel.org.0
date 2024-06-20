Return-Path: <linux-kselftest+bounces-12353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB9C91115D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 20:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9511628165B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 18:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373531B9AC4;
	Thu, 20 Jun 2024 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DSZeZWeO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2B91B47D4
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909343; cv=none; b=EnRVxeKc6fBnE+NRG0lwkD4ObrV7e7xmyv+tO7qBm/0/zN4di/fU9j2fb3XbWVWolgTLG32mnuxcJaAS0hKQOJRhHfuUmCXffudPUbo4S/pghB/PqB9SxkLJFXaKlSxW7Z6KPd8zDZLITDBbmAouwlqY1eC8MdhKybvMvW06Nnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909343; c=relaxed/simple;
	bh=ZJlt/X6PrwPET2Sqp74JHEjJORFV5iRxJOPxh1IkXWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=olGlISMDiF9cguN08bV6EjT2R6FirjyShfpWGnemBOxpVzWu3GYGoJoaoMiUMrEhBev30JMNL5V0UYEt/sFfoe1YXH4V6UTMbqMDE7UwnJLcF3c2dXJygUQz6+CNTRzy/GthM9Vu/WxHoOJHQiPaDUhJX3vZ6Nx9TT2l3G6jZjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DSZeZWeO; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f66f2e4cc7so18089485ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718909341; x=1719514141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wu1wVc+3ogmDWb1QmIkKTSRvM9RrOiJDS3aYm0qmOo=;
        b=DSZeZWeORNCuRiyaJXFyNoaWlTDlW/QAL6e92L4nVXeOLETbPXb4D64wwGqvh+vUx/
         V26/bXPkdEh2J4+bfPitLGzT/ZRXkABpEOJxr7/Cu4H6srob/GnbBQMCtePb/dKpu8FV
         sI8c2Gj+agLVuughCjjwvd7NJ0QZiMG73VpHv1cK0xaP6IIxIjCF+pikbOFXxWLGiMSc
         B58gYms5he5TeemZnCGqTzCjvMeqY2iFbIZ5n33fXrneWC0xtHfus2B5lAWW1q//PG1I
         Rv2OMzb9Fn2ykgkDlgX6AXrB0wGyN/UhkQl0++vJmk3LWzoouoaxyYX6XWUjTXGobgy8
         CbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718909341; x=1719514141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wu1wVc+3ogmDWb1QmIkKTSRvM9RrOiJDS3aYm0qmOo=;
        b=oF4kX90d2eB9e3z/p4bbBca6rxLo7Aku6zzPrqAKeiQxNqNFFGyjE/5KhYSt/PUo2S
         ccClE5XHITYdYMm/7ar+Fwsv09Jmqk9VUhvDhiiQtJy6ocZWH1ibEHuYFNDBgAwIekd/
         3dbu3tG/m7SCqymZXoga7LkyPCu5tXag5oWzv4WTqSRuZpj5r9Dk2VGF8mueQXmG/ek+
         Zd4/AkG/ESeiGSMO8Mm/kG8Q3GDOqzKbVkXKlaHs4hP6mpE67TfWAM2NGqyFoczq2OsD
         S2+cg/G58mQXW3OfEPCw7VQEQJqkkkdbiDDOTU1xAxYJsJPZY1Fxfr1u34Y1HEddPEE0
         RwuA==
X-Forwarded-Encrypted: i=1; AJvYcCUojjuvhLiNEB7eF6KTYadnxR/fSr4E0sJWZzgJidQbnZr4XUBMgNxCGhFU7Es9tApnFuIji5kYtpZvbLy1fINqFimYy8yYwBqlkN/eZ8u3
X-Gm-Message-State: AOJu0Yz1otR59w5H5ZVJjExdAU8QwlvEeEfPFhkaq675h2/MSEmg7Azm
	7UBAqGSC8Vkj0DMIoa1Jdqs37OMeDIK5oEG0pVFx+UVbXdS7LHXTQK6cvklCnidAXz5wz8V8eiK
	Xpr7X8yRoZQ==
X-Google-Smtp-Source: AGHT+IEjuzQzaeOO0XPvpr1aZfzic9vLyfJJ9ryfPTpvci6d1NFaBB/sikXz1OAKxDRDMP415k8OVyAsWAiWxg==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:903:110d:b0:1f6:77fc:c576 with SMTP
 id d9443c01a7336-1f9aa39e4a8mr4906245ad.1.1718909341152; Thu, 20 Jun 2024
 11:49:01 -0700 (PDT)
Date: Thu, 20 Jun 2024 18:48:53 +0000
In-Reply-To: <20240620184856.600717-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240620184856.600717-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240620184856.600717-2-jiaqiyan@google.com>
Subject: [PATCH v4 1/4] mm/memory-failure: refactor log format in soft offline code
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
	osalvador@suse.de
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, rientjes@google.com, duenwen@google.com, fvdl@google.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Logs from soft_offline_page and soft_offline_in_use_page have
different formats than majority of the memory failure code:

  "Memory failure: 0x${pfn}: ${lower_case_message}"

Convert them to the following format:

  "Soft offline: 0x${pfn}: ${lower_case_message}"

No functional change in this commit.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 mm/memory-failure.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d3c830e817e3..2a097af7da0e 100644
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
+		pr_info("%#lx page already poisoned\n", pfn);
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


