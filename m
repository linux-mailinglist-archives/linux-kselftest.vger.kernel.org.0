Return-Path: <linux-kselftest+bounces-39560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDFAB3047E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CB6188E824
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527E135CED5;
	Thu, 21 Aug 2025 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApVUgePM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D735AAC8
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806875; cv=none; b=QknJkiv9eRsgNqoXZDQCazBwnE5gw+FU4+HVEOZesOUmLRlaNl6RLSUtODiKcl9aKTahOn2HcRVqSNgZWOf8DOLrFxfDQ1IToY/8XkKatOPjXGEpnNEpoiHUSQphAa9aaKFSCAHAYEn6rQoGSsRaufdwl30bnxR3EiXksh4t0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806875; c=relaxed/simple;
	bh=d4tmPeOlqOBXo+X4Tiv9h/CbkpHAugux1EiNuLc/Y0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uo33/Lvd7O9fjzNLMQhTv3Z4m3p1xjGrrP2CvS63OkurhIKerye4Vf25XoBodU9WAc18R408HzM3b8fDQ4AATyBFnfOOcSWG8tnmNyCnmJ6RCG8FU/2lmN2omkTGve7n6RU02j1Lx+xtiS6aeigFS9ainxch+/DVpTaMbNwrG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ApVUgePM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzMWVCGQW0mP4+/ULAfe7CdOmgWkAKLnoxAB4Fy092E=;
	b=ApVUgePMc5w7rL41HNMIKF85AcMs6Un4ujFWJA5x+7+Llhbk1+gVkmabnDQ0P0g6RwRZ6I
	hiG/PTnBi6M9L8qRsc++NZhZs06JhKlMLLamkv6/9nyiqk5kpcRGlad8oxOAC+Nn5J3rGI
	2Nt7rHQpw5MKfM1CUw8SvaJu7Y3EaHY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-xRma-TuWOKmpq5LWabixug-1; Thu, 21 Aug 2025 16:07:50 -0400
X-MC-Unique: xRma-TuWOKmpq5LWabixug-1
X-Mimecast-MFC-AGG-ID: xRma-TuWOKmpq5LWabixug_1755806869
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9e4117542so631172f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806869; x=1756411669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzMWVCGQW0mP4+/ULAfe7CdOmgWkAKLnoxAB4Fy092E=;
        b=ByKh6aVETOummQasIsj1/c9fGxRCkUNx3UTXKEkniamZQUFigRi/HOS3/9gPKYOgcA
         9A3uuBE0e1Acm6um7K+TUvIvynrRFMB2Q0nP7C6DV5q5O9SL4emN9A6B44WLhHV69XX5
         MXGFFEH4nwqergTLvHu7QGa3m9IvKwZ7EvNEwqYzHG8t68nz1gjGGoimsZo+orMLqY5d
         U1e9jdr6xGxELCpQU/xVp/G0HSBgslaHLhcl9OolglcRINsf5GDzDCbORiTz9cbc8fUL
         Lg70Wv5vHvgJkTWHm11ybUsLk+PCSXhLEFhKVi07HV05Jf3r5QVYP15yey8jDxAUlDC7
         djbg==
X-Forwarded-Encrypted: i=1; AJvYcCVY2btue8SKHD46usjC2DnGGoTVm5GRgxb+qIAbn0YSSprbY3RBRkwRbHjHPW7VY2OxCu8dUSezEO9zj5SGWRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPBZTxpMSfzSI2DNJN0uUp5Pjy/mttJqbVGVubPNaqzq03q3Zf
	xMhcZJgTACXFcs0Oe3PM/OxBCP4kBoTKDaHDPmNzpuCFngTcfgFtOlMOfQT4vOYg3Rqpj+vU8YX
	nNnaCw2U9qHYw+2KXSi0PCIpPvwnEC/W31lQRAUUGuhEWMYNb1ybmcOPgKqUA5reRGqTOrg==
X-Gm-Gg: ASbGncto5GIUT9lysa3xSi6bwR6+7I2HDJtDiW8PcauzwBDFSasiH1OmxWFuaGR6BGV
	Qh8D4GwHEpXzG41LKj7Z98NASMxcDen3opuRUjaAEf2ze6Hl+m9i/7ZPSQpqEquF3FGyrxB69WL
	fN6z2ZMiZXlG9Vu+8DgRAQ301ZZlLC1LHnXBPNbxTmfKAAQue1AxdevoFBkOQypDQqS7hviKuui
	no+ixQDcznQR4gysN23oHgY0WUWMdiRndZOKMNqUZ6Ar5a4g943DVEhlKoklnPucdrxVl6zO4kI
	clFWW38GSnKdMlpZCiDbiJmpjEpMp1+fZi+va/Vl+v9sDeAHo2T/gaaSezXf30Z7W+JpJYPiGV6
	SDNIqrJ/Cg3nlc0swiTUSzA==
X-Received: by 2002:a05:6000:2901:b0:3b7:c703:ce4 with SMTP id ffacd0b85a97d-3c5dcff5f3amr167784f8f.59.1755806868883;
        Thu, 21 Aug 2025 13:07:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCm64ALptQrKyrLlaLt4xJ2vziBy3gZm4Q1WMVX6wnWhr2W2tRcHnZJHBwxpAOnTfL4mKx+A==
X-Received: by 2002:a05:6000:2901:b0:3b7:c703:ce4 with SMTP id ffacd0b85a97d-3c5dcff5f3amr167760f8f.59.1755806868453;
        Thu, 21 Aug 2025 13:07:48 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c5826751d5sm1323274f8f.14.2025.08.21.13.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:47 -0700 (PDT)
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
Subject: [PATCH RFC 15/35] fs: hugetlbfs: remove nth_page() usage within folio in adjust_range_hwpoison()
Date: Thu, 21 Aug 2025 22:06:41 +0200
Message-ID: <20250821200701.1329277-16-david@redhat.com>
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

The nth_page() is not really required anymore, so let's remove it.
While at it, cleanup and simplify the code a bit.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/hugetlbfs/inode.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 34d496a2b7de6..dc981509a7717 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -198,31 +198,22 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 static size_t adjust_range_hwpoison(struct folio *folio, size_t offset,
 		size_t bytes)
 {
-	struct page *page;
-	size_t n = 0;
-	size_t res = 0;
+	struct page *page = folio_page(folio, offset / PAGE_SIZE);
+	size_t n, safe_bytes;
 
-	/* First page to start the loop. */
-	page = folio_page(folio, offset / PAGE_SIZE);
 	offset %= PAGE_SIZE;
-	while (1) {
+	for (safe_bytes = 0; safe_bytes < bytes; safe_bytes += n) {
+
 		if (is_raw_hwpoison_page_in_hugepage(page))
 			break;
 
 		/* Safe to read n bytes without touching HWPOISON subpage. */
-		n = min(bytes, (size_t)PAGE_SIZE - offset);
-		res += n;
-		bytes -= n;
-		if (!bytes || !n)
-			break;
-		offset += n;
-		if (offset == PAGE_SIZE) {
-			page = nth_page(page, 1);
-			offset = 0;
-		}
+		n = min(bytes - safe_bytes, (size_t)PAGE_SIZE - offset);
+		offset = 0;
+		page++;
 	}
 
-	return res;
+	return safe_bytes;
 }
 
 /*
-- 
2.50.1


