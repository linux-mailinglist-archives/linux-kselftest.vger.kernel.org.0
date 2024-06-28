Return-Path: <linux-kselftest+bounces-12945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8E291C7B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 23:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C814D1F21CD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 21:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009B77D06B;
	Fri, 28 Jun 2024 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtedybNK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8807BAEC
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608404; cv=none; b=M4ct46LB0pZbnJecHI1cwmHEs6OF8mI0gw63Ig4M+TTToGcodKSiM918tqPE6kMDL3qCvpGw3yvQhNMux1ICUHijJq26rvX/sKpYkpayxLAIXwxX0TxZCQqdeT332VqWUxMieh2ZCBz0VFWln9H9P0jy57/yM3WeypCpjsOn17k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608404; c=relaxed/simple;
	bh=8I231QFuiBSGPyr0EMhXn+o2nbNjY4SIkiFEY5MIBaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G8PX7+yPy4hrrFEG+Jy+SwuZbBvOL0vZwYXQuXd3ZPkEAAIguYzK7S9NtlzTXzKYHy5iXchic8d3CC+dOuMPQ37SQOzXrcMYIAwVZ0aq/B3yWzmcRWUHsWLbhqSXFEYPF13D71x4AHYkznzIq5f0NKQbDkWD8ChL4ZDtnUG63Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TtedybNK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f733390185so6327985ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719608403; x=1720213203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0CbibTHvg/Mc5IP1SBIsRIj2TjPoTYgF7QMmo8HErQ=;
        b=TtedybNK7yGdtTf8OVxN/dH0Me08nGmeLaCi5v+u0eTJDvDaMhRLdxhN9BNBWYLF/S
         DsFuvX0DA+chB/AIeh32xcL4GmhWsucYxHSZ7OyZdeRigly3Cwht7ej4fipRs8/GUTFu
         4l8hiDaURfSG4ubcSw3HSXKxnhSujPRyY3xUl0gZ5lsugqLzReYX/+IyAOGrO4BCECYe
         MyE1AOXrEzwCNZvgZ89dX+WO/mu+EreDzCJv9KRu0LJurtsf0AKxnP1/hvQamYoZBy1z
         yEvXI3FdfeR3NaXfQOmkjJ5EgT29kcXEOVQjtiEh75342koORoxxHnVNXRsmHmDFMve2
         fRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719608403; x=1720213203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0CbibTHvg/Mc5IP1SBIsRIj2TjPoTYgF7QMmo8HErQ=;
        b=xLQcw4b6WZeCQsGgH5lCMQlL16OKrmTMJC7aiJcbzH8M4KDRyrAsw0S7GUlvE+AcPn
         0RuTJJs0eUIjgF5qNIHRNPDGf3u1PFh6q51Lxf7Ps0cvR35pT5OGMxxYxS1ykAkW+U/j
         BypTelTxGq7WBmsk5OBf+6hc/fTnndxnyz0xeNcxx7nl46OeamhVA8w0X/HUn86J9FS9
         f6MQcY/7dksmsfUomtDeg2NxIGjKF0PQguj6+rDx3mPL6TGT7WNESTdYmgsGN2g3ZEwX
         2evlW2khdjsfEQY3V7WeEUFwdHU+EPUSqPL8CZGBaBxM13ZPQtNFcec8NCJvHCwjHYaU
         OV0A==
X-Forwarded-Encrypted: i=1; AJvYcCV6IkccqnqbJabf9JNKGE4JAduFZO3+dcwOhWophYnqJC18Gj6HL/i5BEAtgIHweR1qWPJAGizhhJM00hGhh0C08K1HFio/c6jO/6o0foCy
X-Gm-Message-State: AOJu0Yw4DEokmBdD8didxWt929zg3o4wWRCAdOXgO1BqEnRpsR9GSd3Y
	g3MI7A9+smw8Wqs7gSKHTWZahuvvTnAp5wpQyyRdotkQId0gM5RUNWG2gxFH41KveED0Ofyd2zo
	TJg/NJzFpVA==
X-Google-Smtp-Source: AGHT+IHvSyTDpXGxBgupVIRFAkBG3VdCY5GUBbjJLmgeOIsfaxOiwkfDkgH572hLnULmbZAu+zNkcopy7a37Yw==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:902:facf:b0:1f7:1640:cef0 with SMTP
 id d9443c01a7336-1fa1d668ce5mr424595ad.12.1719608402621; Fri, 28 Jun 2024
 14:00:02 -0700 (PDT)
Date: Fri, 28 Jun 2024 20:59:55 +0000
In-Reply-To: <20240628205958.2845610-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628205958.2845610-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628205958.2845610-2-jiaqiyan@google.com>
Subject: [PATCH v7 1/4] mm/memory-failure: refactor log format in soft offline code
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com
Cc: jane.chu@oracle.com, ioworker0@gmail.com, muchun.song@linux.dev, 
	akpm@linux-foundation.org, shuah@kernel.org, rdunlap@infradead.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, ak@linux.intel.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
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
index 2cf7acc286de..685ab9a77966 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2640,6 +2640,9 @@ int unpoison_memory(unsigned long pfn)
 }
 EXPORT_SYMBOL(unpoison_memory);
 
+#undef pr_fmt
+#define pr_fmt(fmt) "Soft offline: " fmt
+
 static bool mf_isolate_folio(struct folio *folio, struct list_head *pagelist)
 {
 	bool isolated = false;
@@ -2695,7 +2698,7 @@ static int soft_offline_in_use_page(struct page *page)
 
 	if (!huge && folio_test_large(folio)) {
 		if (try_to_split_thp_page(page, true)) {
-			pr_info("soft offline: %#lx: thp split failed\n", pfn);
+			pr_info("%#lx: thp split failed\n", pfn);
 			return -EBUSY;
 		}
 		folio = page_folio(page);
@@ -2707,7 +2710,7 @@ static int soft_offline_in_use_page(struct page *page)
 	if (PageHWPoison(page)) {
 		folio_unlock(folio);
 		folio_put(folio);
-		pr_info("soft offline: %#lx page already poisoned\n", pfn);
+		pr_info("%#lx: page already poisoned\n", pfn);
 		return 0;
 	}
 
@@ -2720,7 +2723,7 @@ static int soft_offline_in_use_page(struct page *page)
 	folio_unlock(folio);
 
 	if (ret) {
-		pr_info("soft_offline: %#lx: invalidated\n", pfn);
+		pr_info("%#lx: invalidated\n", pfn);
 		page_handle_poison(page, false, true);
 		return 0;
 	}
@@ -2737,13 +2740,13 @@ static int soft_offline_in_use_page(struct page *page)
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
@@ -2795,7 +2798,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 	mutex_lock(&mf_mutex);
 
 	if (PageHWPoison(page)) {
-		pr_info("%s: %#lx page already poisoned\n", __func__, pfn);
+		pr_info("%#lx: page already poisoned\n", pfn);
 		put_ref_page(pfn, flags);
 		mutex_unlock(&mf_mutex);
 		return 0;
-- 
2.45.2.803.g4e1b14247a-goog


