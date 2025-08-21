Return-Path: <linux-kselftest+bounces-39577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68418B30531
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7AB1CE7DD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA18C37F1E1;
	Thu, 21 Aug 2025 20:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZgwUtvu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8C37E8F8
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806922; cv=none; b=Lhm0PCf7fIwQH8FOmsC4dt37yrPKKOioTjqOw1G5oY0yP7I92kW3Og728PtRgvVoG5HfkgpPQ8iUMt7S9FZUS6u0wc0mg8Q+RXL0wWq+NtU5n10DUBGmSKPAD0GAVrFu9a/ci9C3aNH3+3DxqnSqxViWrH08U8kGQFIMIx5/HS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806922; c=relaxed/simple;
	bh=I4BkP0poqeOVnf4Ccw0GJyYkhfaxRMDSlYagPRdC1UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adcWcRo+NWxQRpX0hM39TOojemg6TlTltIlp+ySpkSdAzpIYQNNSfupVX08uYFObAgkAFap6jSapf/vqdNO3CKD2DVWbQAesMrVvlMmO9JFjb/x07ZirtmtLiNZx4+RuMcbWrbQmMRQaf3ToGKpHbetrTmai23klhOMQzPVwnRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZgwUtvu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3CqHI+s+zbpAzQhGC/xWDVPQsQNUZt86Ikrf9EwImgM=;
	b=YZgwUtvu7B8hcKdOyzJ3aFCXvS5VJsSg/0RXF4TDsYMsYa4HYsgMepNtcONST1jI2MeC5s
	UcQg4FltPxWNIpHg9egMR2dA6RxlLQzCKsx/Opm3TzmZmXIgm/QIlym21cgFO4lpndyEsj
	zyhvEHgi4LSlLBH1IFxCwRFfrc0M2lM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-KPUXGIoMNJ2G1cIMzdfcGg-1; Thu, 21 Aug 2025 16:08:36 -0400
X-MC-Unique: KPUXGIoMNJ2G1cIMzdfcGg-1
X-Mimecast-MFC-AGG-ID: KPUXGIoMNJ2G1cIMzdfcGg_1755806915
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b4d6f3ab0so8384825e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806915; x=1756411715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CqHI+s+zbpAzQhGC/xWDVPQsQNUZt86Ikrf9EwImgM=;
        b=P7su6Aj6B7+MvqsjnIWymLb9VljYName5oe8fyV2ir41StfuwW5HN03oww49k2mm1b
         tnSMyNkps5lenv7Mi6r9b0ORW2UPmHGK8xGxNw1MVi9vUfMYBmfXpmEqi5EDHxUmelqj
         wpDe3jOvipIyrW0O7+UjWZa/ftOGRKj5ya2WjaCK4ZUgcwJU4xZKHyh5hlL05TUgqicM
         jn8VMB/GriTIMQyvMZLUZsZ9e//ysCtSNv6a0fvvPgbOW29y4nnd5Z92OXGqQ+TznWJq
         diVOiZAfITSMLyblGOIuqlfMwrqWJrM91rVIKvw3hoTJEbLq/XuoCYqnkRE1vLsG3+JV
         KEHg==
X-Forwarded-Encrypted: i=1; AJvYcCUSiOMGpX4SjD89wJOHdUAKp23AchUarEKgb6rncMHEzfkrPKFusMgDYEHBxNP1fTWCz6ribX3wu5Xwp7NX1/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSbt4eUzXvSrGnynGBjcFUNiHydpAGUXpOOYLTMT5V24hSIbyd
	SsmyKslG4YUJ+GTCnVwGX1RfBIKGxY2t5bb1jeAu6nK/sLrRIGEBQ7AzD/yygoW8eyeuX4Yw3bv
	DLiyuY4KNVPThemiDBT1Kgu2RqzTkdIiLOf14XFxC7sZLTjXZsTipcMRkjy39UMMa6YRAIQ==
X-Gm-Gg: ASbGncvxqCv8g5T5jv+NoiOGFOQziGrCyHHO39Cfr1V6eNO3r+qc+OM8zgmKOD9exbS
	1x0cWqfCJAafHgP16PiqTx1OX9nHmsxxwZJanDUBMsrfnoQyUXatlILA62rCuL7H6GyO0ftwBXS
	91HC/jL/EvQf2HxeGoZyAgIx7aXeLRmaLA5wArJvqc8Zr/TAQawIOXFVu3ou7uIpPgxF6n/pNZT
	XF7v0nB9xnKJ+An7tNXx5yWr+LhbcUB8zxFsncpFwXrSLvn+jrhST09sB96U2bdN7rc2RJ+Q0St
	W2RSq5zXsBvmH+SUN5B9yUUzQSXULUf4ww4/nxL/7nUuS3rhX9QjcNzKMdXQ6aihLk6Xb/WZNdD
	PN3QnQgRxaEYjJ+AkyCqFFA==
X-Received: by 2002:a05:600c:1e85:b0:456:1006:5418 with SMTP id 5b1f17b1804b1-45b5179f0d8mr2710975e9.13.1755806915061;
        Thu, 21 Aug 2025 13:08:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNGUbCcltH4em232KOd7NJpwM5baGf2Rerwczj+dvqvR7jiogPR9NbFTOrLGPDkQDJL8nGzQ==
X-Received: by 2002:a05:600c:1e85:b0:456:1006:5418 with SMTP id 5b1f17b1804b1-45b5179f0d8mr2710565e9.13.1755806914568;
        Thu, 21 Aug 2025 13:08:34 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c074d43b9asm12707153f8f.24.2025.08.21.13.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:34 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH RFC 31/35] crypto: remove nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:57 +0200
Message-ID: <20250821200701.1329277-32-david@redhat.com>
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

It's no longer required to use nth_page() when iterating pages within a
single SG entry, so let's drop the nth_page() usage.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 crypto/ahash.c               | 4 ++--
 crypto/scompress.c           | 8 ++++----
 include/crypto/scatterwalk.h | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index a227793d2c5b5..a9f757224a223 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -88,7 +88,7 @@ static int hash_walk_new_entry(struct crypto_hash_walk *walk)
 
 	sg = walk->sg;
 	walk->offset = sg->offset;
-	walk->pg = nth_page(sg_page(walk->sg), (walk->offset >> PAGE_SHIFT));
+	walk->pg = sg_page(walk->sg) + walk->offset / PAGE_SIZE;
 	walk->offset = offset_in_page(walk->offset);
 	walk->entrylen = sg->length;
 
@@ -226,7 +226,7 @@ int shash_ahash_digest(struct ahash_request *req, struct shash_desc *desc)
 	if (!IS_ENABLED(CONFIG_HIGHMEM))
 		return crypto_shash_digest(desc, data, nbytes, req->result);
 
-	page = nth_page(page, offset >> PAGE_SHIFT);
+	page += offset / PAGE_SIZE;
 	offset = offset_in_page(offset);
 
 	if (nbytes > (unsigned int)PAGE_SIZE - offset)
diff --git a/crypto/scompress.c b/crypto/scompress.c
index c651e7f2197a9..1a7ed8ae65b07 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -198,7 +198,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 		} else
 			return -ENOSYS;
 
-		dpage = nth_page(dpage, doff / PAGE_SIZE);
+		dpage += doff / PAGE_SIZE;
 		doff = offset_in_page(doff);
 
 		n = (dlen - 1) / PAGE_SIZE;
@@ -220,12 +220,12 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 			} else
 				break;
 
-			spage = nth_page(spage, soff / PAGE_SIZE);
+			spage = spage + soff / PAGE_SIZE;
 			soff = offset_in_page(soff);
 
 			n = (slen - 1) / PAGE_SIZE;
 			n += (offset_in_page(slen - 1) + soff) / PAGE_SIZE;
-			if (PageHighMem(nth_page(spage, n)) &&
+			if (PageHighMem(spage + n) &&
 			    size_add(soff, slen) > PAGE_SIZE)
 				break;
 			src = kmap_local_page(spage) + soff;
@@ -270,7 +270,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
 			if (dlen <= PAGE_SIZE)
 				break;
 			dlen -= PAGE_SIZE;
-			dpage = nth_page(dpage, 1);
+			dpage++;
 		}
 	}
 
diff --git a/include/crypto/scatterwalk.h b/include/crypto/scatterwalk.h
index 15ab743f68c8f..cdf8497d19d27 100644
--- a/include/crypto/scatterwalk.h
+++ b/include/crypto/scatterwalk.h
@@ -159,7 +159,7 @@ static inline void scatterwalk_map(struct scatter_walk *walk)
 	if (IS_ENABLED(CONFIG_HIGHMEM)) {
 		struct page *page;
 
-		page = nth_page(base_page, offset >> PAGE_SHIFT);
+		page = base_page + offset / PAGE_SIZE;
 		offset = offset_in_page(offset);
 		addr = kmap_local_page(page) + offset;
 	} else {
@@ -259,7 +259,7 @@ static inline void scatterwalk_done_dst(struct scatter_walk *walk,
 		end += (offset_in_page(offset) + offset_in_page(nbytes) +
 			PAGE_SIZE - 1) >> PAGE_SHIFT;
 		for (i = start; i < end; i++)
-			flush_dcache_page(nth_page(base_page, i));
+			flush_dcache_page(base_page + i);
 	}
 	scatterwalk_advance(walk, nbytes);
 }
-- 
2.50.1


