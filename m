Return-Path: <linux-kselftest+bounces-39565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BC3B304A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5961D1CE5C67
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4071E36933A;
	Thu, 21 Aug 2025 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnZCS9aX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8073680A9
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806887; cv=none; b=jdmG7jaI79ccoOEvanccyzGkJemMYqPFPXEBGM+Su4y82AHjRB1YJi7oPxCN7Z+7zugf6t7yjbRKus8oBrHpV57KFmPJSr5DdnFiQKFDwr1BhihiUhRsVa7u94IQ/uEG26qD9U1FrEwCE1m3TyPGjP5aCJQ2AH0XUExUoZiTZis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806887; c=relaxed/simple;
	bh=E88hXeAEs+yXdxHqIfTWo/GvQIeDr+kkFObDidynu1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwOUvMAmDvV06Skp8kiGQW962wof7rssf10cqawZFfYsOcTElNk7ZNT+Wt1sGkjaMeCNwyW3maOvh3bfQoYQi73EP593xORtHwYoky8o/Uvr7IqF+v5+qx/GIdbZRBQwgnwjNRUKx46woQbU4DFblozaFOYnFfWaWHFJsJmv2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnZCS9aX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6VkvDa+3msZeC5nA9B9+aDln+Mg2ABReefULBX94/4=;
	b=YnZCS9aXtCdJqzHs+BcT6Kh1Oe4HeIz1o97JXMO2tL3yeGaAymfYhHAN34YbcLU85epGw7
	EI90tQ1sEFCUOhvfbSEJHFNLxZiQ56AVcQU8xCED5etNzIMrSsLDCze+34Th0iNtqZCrR5
	qQpGWiegU/Hj13OQbRlfOSwiCuXNlRM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-rM6YMDSPMWeOGsJ_oc0HDw-1; Thu, 21 Aug 2025 16:08:01 -0400
X-MC-Unique: rM6YMDSPMWeOGsJ_oc0HDw-1
X-Mimecast-MFC-AGG-ID: rM6YMDSPMWeOGsJ_oc0HDw_1755806880
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so14273515e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806880; x=1756411680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6VkvDa+3msZeC5nA9B9+aDln+Mg2ABReefULBX94/4=;
        b=r9mtleEGDKD2CE1tG/n3FFSywjwN0PIerp7Dzdix5Q64tVGSEmUOkB4uQcP/HAk6/b
         Aua5ar8GdiOY3KPUHQgnjYha4EF5isQwr3MPXzShadnoGEBNk3AzaA/bnToU91qcwoTT
         C7ckaf1+lJAttGQ0Vtk2GNPAxPz8+Z0nzmzWFPR85oRj0OYj+1mQAlneI9iGtoH5LxuJ
         Q+GU3JpMHGFkpez8FphTPpnHKDz4EumzrhKLg4bw+Nj/nK8EavaLiWfwZGRQ/Qrm4bJV
         a+2dZOqtMsVY609b9m42opgJ3qHxWVfBo1YbcY0ebLJQma8bFb0lF4dxViNR/zPrlJu+
         YKXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWovO3av/OzeJEiExVj62yCjqS4isKCTgL7vtV3roDy6puhQkMEQ00c/ateL8yfmA539VNosY+7VSgYEU4tPDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLPIXDO6rldeMyti6nMA6SlGlybrJXzkf/CZ8+zdm9TS+Q8sfN
	BRPj50SCwKwObw3a+uCvB01OjTsNpQwFILUYJ2HOgzUdbQIkpjkzbAPwo4A++bbj3HheIyQ4uBs
	hqGyyUiQukISu+CtPPyxrZIB9XeLRhjfe+XPLBzqBLt4aH4P2sL+xH5/YJjr9YjK+lkiJgA==
X-Gm-Gg: ASbGnct/C9srYzTVtjPZkX4NQkR71YwtRI926kxeiz0pZiQZ5UF4MreUzq/oEqfXgHS
	5TibAv5xkkDUAqc9BUblrxrkRQ0e+x/Ve5jLbF7dUSHPLsO9b2dyX0RO2e8dd+kE/yy9JV31h8W
	UnD0YbxeiHRYjn/QCEVG+xcHLbo0qasZANrv0q2WUk1p9MvYy6hg+i68JTakXBNoGBmna+lYMhJ
	EUJOOTwEQd4GZ6ChOASFOcY/IrY0ZDoEEy1n+S1jhUc+Nsn6ogsuCi5Hfi8XrETjlrXS57AEast
	bN3RI2Xj9EMpg6DqCs8NWf0epCKxyO9BxonPpd8mqnO5eTIn5GZ3glcYVdaWGUKMBL2Fxx1p/oP
	NQuFKmuyizhD70PRoBNKn7g==
X-Received: by 2002:a05:600c:1c87:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45b51792539mr3328655e9.11.1755806880044;
        Thu, 21 Aug 2025 13:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9ciI0WdoI3CxhUtu7m/cESVsdReJmvmXFWCMaWsO+hhXySreox2GeOL2sJ8kVyLPwCYhbEA==
X-Received: by 2002:a05:600c:1c87:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45b51792539mr3328365e9.11.1755806879543;
        Thu, 21 Aug 2025 13:07:59 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c07778939bsm12219075f8f.46.2025.08.21.13.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:59 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
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
Subject: [PATCH RFC 19/35] io_uring/zcrx: remove nth_page() usage within folio
Date: Thu, 21 Aug 2025 22:06:45 +0200
Message-ID: <20250821200701.1329277-20-david@redhat.com>
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

Within a folio/compound page, nth_page() is no longer required.
Given that we call folio_test_partial_kmap()+kmap_local_page(), the code
would already be problematic if the src_pages would span multiple folios.

So let's just assume that all src pages belong to a single
folio/compound page and can be iterated ordinarily.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index f29b2a4867516..107b2a1b31c1c 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -966,7 +966,7 @@ static ssize_t io_copy_page(struct page *dst_page, struct page *src_page,
 		size_t n = len;
 
 		if (folio_test_partial_kmap(page_folio(src_page))) {
-			src_page = nth_page(src_page, src_offset / PAGE_SIZE);
+			src_page += src_offset / PAGE_SIZE;
 			src_offset = offset_in_page(src_offset);
 			n = min(PAGE_SIZE - src_offset, PAGE_SIZE - dst_offset);
 			n = min(n, len);
-- 
2.50.1


