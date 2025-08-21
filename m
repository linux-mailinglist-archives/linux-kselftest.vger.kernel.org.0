Return-Path: <linux-kselftest+bounces-39561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED011B30490
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B131CC7DDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2AB36206C;
	Thu, 21 Aug 2025 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cc7k8vzI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDF334F488
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806880; cv=none; b=GFc8XnyK3mweSK1BUa+Vg8+khTxUyNYQk1DKiWyV1y9xcdLTrGAQNE4SMzl0vq9gjV/AwLQTMgCFMWCfL8y8qtyTT6aQUAWWR3wUfn6XU9zxj9AZg2uDGfYeCcN47CMIQm+BPuaBJ7M1nReJ1jhcWaeF8OSLWJ/ca1BM3pU3pqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806880; c=relaxed/simple;
	bh=jeuBd6AEd//7dLky0U/9/K8CcfgAIF74DmeLEQ7xh6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzf4qT4eLFy47oo8P/gk5pmD6Vqpx5tS0TqMDqlTztN57XKoS/5MN+98UPGfGyxEcG++8o5WdR4ei8LuKN4BcopEhsP0RUu2+nHvfjV7K+1j9Yn6ENxdvv4uIhv9tdFkTAlTrGHZ2ITpsrhn1GcGZCn6zMSQ1+l1vO32AKaVpTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cc7k8vzI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPs2EdTZ9fd3MpWdb0ATDCa6nUqfGtFMv2uyZP7L+uU=;
	b=Cc7k8vzI8vWyxlhOTg3zj5LNGjaDshsiz6wO+Ms72EVhWwZd1ayoq4w78xvhwzeswURLhd
	sTkMrm8c281eBuTMugA4EQ0gLZR/hym/wLnJuwYj0b/EGcngrTVom43mob3elWoOAbQwg8
	yXIaPVKhDlpqvvHwwbMbC25+SHd0wvM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-U7gJMxOKMoaVlKtMMFWAAA-1; Thu, 21 Aug 2025 16:07:55 -0400
X-MC-Unique: U7gJMxOKMoaVlKtMMFWAAA-1
X-Mimecast-MFC-AGG-ID: U7gJMxOKMoaVlKtMMFWAAA_1755806874
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0514a5so6771815e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806874; x=1756411674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPs2EdTZ9fd3MpWdb0ATDCa6nUqfGtFMv2uyZP7L+uU=;
        b=FK1Kc3BwdKeNzvt+XUe7jV9Xgbd78yc/foV0XJxGyipHxU5p9f6gm6NJzvkm7qbSa5
         rAoNvHQO5/eHMFhH3fP8jsDPcKuJZ4A4mwpBB6Vev7MBUgbiu7uFva6zkiOVRSoym9hI
         do5D1C91fEkEWt86OwZTkPW02q/ZARznTFvRd2PsfyE4jE85gm/7jchlLcJhPPSC31q2
         AIn/2B8igoeJ1tTMXgkkWeXRB6dc1CX8t2DIANYLy0sBzWbJ3n0xuyPR00cx8tvzrpte
         lbKv9t/CypB+t3JyjCVWM1w0yjhPAa842fJ363nTGWo5RavsdzffCtsofZLtMAXF58qn
         XWpA==
X-Forwarded-Encrypted: i=1; AJvYcCUynjSABbpR0v3UFPKWXf658kHBpAvz/IxyO4tPgfxN1xqYZcEp6qsnE3lojQOg9Ch1ASqsJj+aJyKBpKImoC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwshIcYNGq5twTmkNiZiKj9D358V+3iP0RM8HdSwFKyPpNQTupp
	X2prU3gxyiXsi74SgttxOoTFjj8cW20QAXQsNCysicrQcNZcABwDn2T2qNFgNwhLbzS3lvIqXLz
	IWThnYTtiEg/iU1dBAStr5YnrApqgO3Yk+pKLr+5p/8KrPmJN+u1q5ttdJVN4sJyZktMo1Q==
X-Gm-Gg: ASbGncvVfSO51MBieJWu5uiU2LiWaf/jg0hqar8XipEuf6tqDgEgClu7icQAvYbLX62
	uR/R+rrMAHjw2n+ZUJJJSJy4dx/HN4AjnDMUWYftjkLwPKS4Fw3AsDcdGMVyxw4jgJrRPMH27tB
	bwM1zyX1bqa3vRhGn1MYHUA7MBEh+kvuNU1wRmW1vxW7qVNWgr+sUocSf9gL9R9wnKAfGzburxX
	3oAIwdmSEf22KPNuyixLxcxW3qGG0oMYFy3EAG28V6Auk5F3FeE9c0A5dowvkkfxjSaDMsItsfg
	MaZsacnBhMDF+JslAbl9OVZ1DfmWMlMVbHdU9Tbr6tNbehIegC+WxZsOhImW7VH6RINlSnZelTW
	hKywd6cUNNGiEKlw63Q8/pQ==
X-Received: by 2002:a05:600c:1388:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-45b517d40f2mr2554065e9.24.1755806874298;
        Thu, 21 Aug 2025 13:07:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo8ikhW4DoWVw60oDeAXqMRvn4UERlcVawLCjGel2pacwRc1R1ONhYVQm5EzuW0YIJQT4FDg==
X-Received: by 2002:a05:600c:1388:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-45b517d40f2mr2553905e9.24.1755806873856;
        Thu, 21 Aug 2025 13:07:53 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c07487a009sm12690403f8f.11.2025.08.21.13.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:53 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 17/35] mm/gup: drop nth_page() usage within folio when recording subpages
Date: Thu, 21 Aug 2025 22:06:43 +0200
Message-ID: <20250821200701.1329277-18-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nth_page() is no longer required when iterating over pages within a
single folio, so let's just drop it when recording subpages.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index b2a78f0291273..f017ff6d7d61a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -491,9 +491,9 @@ static int record_subpages(struct page *page, unsigned long sz,
 	struct page *start_page;
 	int nr;
 
-	start_page = nth_page(page, (addr & (sz - 1)) >> PAGE_SHIFT);
+	start_page = page + ((addr & (sz - 1)) >> PAGE_SHIFT);
 	for (nr = 0; addr != end; nr++, addr += PAGE_SIZE)
-		pages[nr] = nth_page(start_page, nr);
+		pages[nr] = start_page + nr;
 
 	return nr;
 }
@@ -1512,7 +1512,7 @@ static long __get_user_pages(struct mm_struct *mm,
 			}
 
 			for (j = 0; j < page_increm; j++) {
-				subpage = nth_page(page, j);
+				subpage = page + j;
 				pages[i + j] = subpage;
 				flush_anon_page(vma, subpage, start + j * PAGE_SIZE);
 				flush_dcache_page(subpage);
-- 
2.50.1


