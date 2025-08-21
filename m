Return-Path: <linux-kselftest+bounces-39558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D929B3045E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F651CC0DB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5BD35690F;
	Thu, 21 Aug 2025 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQegWUNt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE435209B
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806872; cv=none; b=WTTX33FJn96fxGQ976lVnT2YkRJwquKvq5E8vZar72PTuqhBUCyGnb7gwAtCqdxW7JaXCZQlysSZ7lv6POVxAkbu78sK5qQyXRKHbPrHA4tVztLILaNW25s3Vez8l2MHBY+vRpw45dAT35VwJe7vKFcnN0Vo0znrzSMhSOMPluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806872; c=relaxed/simple;
	bh=ncGz2ZUizfxPtBenqYCMYHXawyPm3K75je3+1YWzFIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=St2l3/irqGJwwyIuqL/Tr+aEd9FptYw50RJ/vZ3LWoJV6XyR2Pcw579tsUbCPelgnPgTRdxtUfgNkJ0aFe6DTvCZrgvTSRFz03F/+unKHCA18/z5W7pa0a2oaBOobiK9tynbNFp9o/LOghoiTnmN8qE3r/qju0mzEJ3CM+9gE8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQegWUNt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9hzYOZv6YXUN4v1wicJ53nqMhopJDezqYU76J2buLg=;
	b=bQegWUNtDMs5UIWTi66EHbfuIIa5+qKC9ZhLsRrB9Fe3tywG+NPTR3N3T8oW8JE3gyOvlc
	0cuFkah4boJL7Ei9wbFCRdzzv2JA46SSgX4nMefPLpN4ezoYIn/Av0Dt9geCi9Fmky85u9
	ra/HbnAWuQyLLd9JZMZS757ma2k49X0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-KrjtBBiHPdiU9jffGWtikA-1; Thu, 21 Aug 2025 16:07:31 -0400
X-MC-Unique: KrjtBBiHPdiU9jffGWtikA-1
X-Mimecast-MFC-AGG-ID: KrjtBBiHPdiU9jffGWtikA_1755806850
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b05a59cso9773795e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806850; x=1756411650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9hzYOZv6YXUN4v1wicJ53nqMhopJDezqYU76J2buLg=;
        b=Ot1CIElc2huN7wZArbXqswcBYizTpA/VJtxekljw9O/wYdd/+yQU7fgXmGwGFw9QyN
         et145Xpewa3k/nHVDyxnyevFGPR1QLXjvz+6uE6X2wsq7qhKVlPcSOo/sVQXO21+pKpd
         XBOvOgyxwUpcvmaVucQUjAN/FIT/GtKhdMwgHsfXddtxKDTV81Il2f5M2tby1/gCp704
         Gz2e4ctcNlpV9tiCP4hNDdi1s/yHe6hEQH01qGXGoui4nC5pey9QmR6lTmc+jMOL7IrK
         vwlblzHCCxN0HNOyNi05TDbnrUHN8JSTo1cQF/E1eG2gnlyC+85mZQ+bqO3S4FMZaYka
         zx4A==
X-Forwarded-Encrypted: i=1; AJvYcCXymMMBaWQLsWsrWt7bGf8734XvgtFRScBgt/ULPgvaFtxCxCrkqCzAOsl7tpjK55hEHLkHpXP1L8azDCvTYs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5/dIYnTzVaaaKF0E3UwErtl46cmQ/HMEa/msCSusoUD6Un2gi
	lU7WIBereXYy9AKCbcu4IrXBgILPN0cp5e+c1TAN7iIEDeM/l0+5+Qy4pyoswSVJFP3BmpSmP6E
	YwNW2B6BaTgR2i2AkXgvpukzY+Z/0+1r7tKgpaip2PJUliZS9JFv95s67CYRyGOd7TONv4Q==
X-Gm-Gg: ASbGncs2Vs6uwgxFNaadbDojrqSkVbYFDcGalBTivoOJ2In/Fm45Re9FnLFsxYr3Fzw
	t0AhIhcsIDNuDPtc6EBSe1d2oZLo+baYFEunH36aO51Dlm6H0nnM/LsJ6eM0ZaKWktIxOByG1tZ
	cPpAJsvbcA9b9v8bqFxIsDij1ZljTFAIFUBgs+ulXm77Tzx6Bqc6r4/WWgVMLKTiawk7/RQSZgK
	Qu81qlRq0kGMIqrnAZGdap02bO7JgZP/brRaSmBzB9YC5VmMS48CHRKT7BORoWqHxCoAqe96FG5
	IesT8NdY04qK+yQRNoXpZqJA3z2peycEnScVJTDQMO7iazg0Bu5oXX2gEJGbcESItbNsKPoiamm
	m5JXl301QopUDkhBTYCqvEw==
X-Received: by 2002:a05:600c:1548:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45b517ddbe2mr2955965e9.31.1755806850034;
        Thu, 21 Aug 2025 13:07:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPNoTdvVqQJqQwQf/z0aFpcDb/7HunF1Y6KwbAqmFFF4D3cnAaKEmAnoGbjwE6N5eIepmoyw==
X-Received: by 2002:a05:600c:1548:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45b517ddbe2mr2955545e9.31.1755806849496;
        Thu, 21 Aug 2025 13:07:29 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c3a8980ed5sm7242256f8f.16.2025.08.21.13.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:29 -0700 (PDT)
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
Subject: [PATCH RFC 08/35] mm/hugetlb: check for unreasonable folio sizes when registering hstate
Date: Thu, 21 Aug 2025 22:06:34 +0200
Message-ID: <20250821200701.1329277-9-david@redhat.com>
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

Let's check that no hstate that corresponds to an unreasonable folio size
is registered by an architecture. If we were to succeed registering, we
could later try allocating an unsupported gigantic folio size.

Further, let's add a BUILD_BUG_ON() for checking that HUGETLB_PAGE_ORDER
is sane at build time. As HUGETLB_PAGE_ORDER is dynamic on powerpc, we have
to use a BUILD_BUG_ON_INVALID() to make it compile.

No existing kernel configuration should be able to trigger this check:
either SPARSEMEM without SPARSEMEM_VMEMMAP cannot be configured or
gigantic folios will not exceed a memory section (the case on sparse).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 514fab5a20ef8..d12a9d5146af4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4657,6 +4657,7 @@ static int __init hugetlb_init(void)
 
 	BUILD_BUG_ON(sizeof_field(struct page, private) * BITS_PER_BYTE <
 			__NR_HPAGEFLAGS);
+	BUILD_BUG_ON_INVALID(HUGETLB_PAGE_ORDER > MAX_FOLIO_ORDER);
 
 	if (!hugepages_supported()) {
 		if (hugetlb_max_hstate || default_hstate_max_huge_pages)
@@ -4740,6 +4741,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	}
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
 	BUG_ON(order < order_base_2(__NR_USED_SUBPAGE));
+	WARN_ON(order > MAX_FOLIO_ORDER);
 	h = &hstates[hugetlb_max_hstate++];
 	__mutex_init(&h->resize_lock, "resize mutex", &h->resize_key);
 	h->order = order;
-- 
2.50.1


