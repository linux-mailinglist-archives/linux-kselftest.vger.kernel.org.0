Return-Path: <linux-kselftest+bounces-39582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D155B30573
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CA516ADE5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C378381037;
	Thu, 21 Aug 2025 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1JSg2B2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41BA352FEE
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806930; cv=none; b=tBdk8TARI9wueEK2gcFBUafgNx+mQ98iXyzW8Vmb4LEndUwfbBNSyNCvCYe7NusSiVjbk0cbw9J3IlYAW/fUx0v0n7eXO1IqvhFm9FN8HonVbc+A2KbM1xnTv86ov+YoHp3MBzCsIHIchGzM6uFQQ3+1JlgWpRREL+/YX0Bt69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806930; c=relaxed/simple;
	bh=vBZZGz0SB0V7Hvywd1N29mvuGT2dBN/lU5Bb9Xz8Q6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9eVEyMZJlFcF6hxdOHZ/ij75pOS5lSCCvSqYiJQtH8vUlRDe7lu6ddQpmywp9UjBLKvbMXGVxiWwhpN32GCYz5aFUJtP/wcGx+iF2NcUr/yDTA27hUu4bDsBAxqe/uRdzXDv92j4dfb8hhL+HFkGygtiT23hULSY2T4jTqLOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1JSg2B2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8aQmj/0+AYT4mPx/DatgQPPbmq0Lkvm9KCqKkKCdC9Q=;
	b=e1JSg2B2zYR4/k9MYnGN1wDcaVC0eaxaiLJohSY7QvdYHyg4VRv+llTGlQa4rwq5tW0NC5
	d9/gP1NklKkwL0k06r9F7aLwoefh2d/vgLLQbqgpE6xsiDSjZh7lOltjT5v2OJLwsEIq+J
	9PrzJIojvoLP/Q7Xbp8qcgcl6dtJiFA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-T3aBbGcjMgq73W8ZSxw4DQ-1; Thu, 21 Aug 2025 16:08:46 -0400
X-MC-Unique: T3aBbGcjMgq73W8ZSxw4DQ-1
X-Mimecast-MFC-AGG-ID: T3aBbGcjMgq73W8ZSxw4DQ_1755806925
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0071c1so6423015e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806925; x=1756411725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aQmj/0+AYT4mPx/DatgQPPbmq0Lkvm9KCqKkKCdC9Q=;
        b=h4DS9ZM0Bv0Sf1NyoLWYsUIg+MYjCigqDxLOc0050Nyq32QZTdd+467NNe8qqGPpFT
         9nGrA+XAJ6ysM4IwiHPXwrXzrmKTZpotQim7NdrPPC8jKrixVtab/EnGAoIEEI0M/yhk
         VKMAazxSyM7ZoVjvohA+LPNPRMwWUqqaKF878d+CV+ha1XrKH5MvKGW25evnFTC5vRhO
         cE1QbEboLc69/B6UdPJT1WLodkwIR7liWR+V9qOHLMxETwVYT0XTl6XMjCIpjbASyxSp
         UJW7bADwr69cuNNm9NTw52gxZ9f1NHOV1m/6g4CICbYul2RMRaTrI7/HJ7h2xK+Rhkxk
         metg==
X-Forwarded-Encrypted: i=1; AJvYcCXb+yf24fh69hhEOr2h5y6owv2TRBuerCo2UNPJadNPtSjKBc/wkdPPbrwMMYE2gCASlhvenUkuOLqOKby9GyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvKKxuB9Kc+QJ03q73MvQFJ183q07XILTZddsCz9WlkheWPOPc
	uOyXUgJTL3Q0JhWd8kVpiUEXwP1rlS5oY1rM6nfhDoagZfpXBms/q5HPJt4nSWedKZLTyM8HdM4
	Fawj/D2n95NI1Fpt+iMBFuGqvtbAdd+9H8Cam90P/AcEWCYaVRTsqx0EJA/9jIXFgz0lGUg==
X-Gm-Gg: ASbGnctr6MCUlYv76+6RGf3koPDGqPMNZO5TdZ61C+F6kd1gXVHJWqz2WBwPIJx7VP2
	G5jZFac67woT/J249e34xOJqNTtw/ocJ2uMf5u6E5EP+H0w9NKgsaM9/QtlmmKgOoXOqROGFX7f
	WcO+XgH20HH6Ghtz45LtX69cYTrSwxA/lobYDM3GcZ++yW5SNZ/d92ImB/VqOHR8vTgguRtp5Ju
	j8wbiiKM0/iyC0UBX1qVw/h0IgoBZCVYZUXS2hUzGw2BXlGvSuOH613vpKxZq01DNMKLTcWeh4Z
	/qHOmKMrmd2jyVZahV4mKYvQXTSmekFDnJzDcXKrh795B3eWlkTWJjGZ9/Xj5uMPuxNH4xoP69I
	OgqlJtLfpUPjGFUymDVPk0g==
X-Received: by 2002:a05:600c:3b25:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b517b008dmr3774195e9.16.1755806925522;
        Thu, 21 Aug 2025 13:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDDv+I9AWZPVyKVFD2prHDmQqsK3mzEWwP5yNf0oRJXtHjmqgi3hMC3hwAmszm5rTAtK85Rg==
X-Received: by 2002:a05:600c:3b25:b0:459:da89:b06 with SMTP id 5b1f17b1804b1-45b517b008dmr3774035e9.16.1755806925116;
        Thu, 21 Aug 2025 13:08:45 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e0a479sm8895255e9.21.2025.08.21.13.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:44 -0700 (PDT)
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
Subject: [PATCH RFC 35/35] mm: remove nth_page()
Date: Thu, 21 Aug 2025 22:07:01 +0200
Message-ID: <20250821200701.1329277-36-david@redhat.com>
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

Now that all users are gone, let's remove it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h                   | 2 --
 tools/testing/scatterlist/linux/mm.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f59ad1f9fc792..3ded0db8322f7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -210,9 +210,7 @@ extern unsigned long sysctl_admin_reserve_kbytes;
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 bool page_range_contiguous(const struct page *page, unsigned long nr_pages);
-#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 #else
-#define nth_page(page,n) ((page) + (n))
 static inline bool page_range_contiguous(const struct page *page,
 		unsigned long nr_pages)
 {
diff --git a/tools/testing/scatterlist/linux/mm.h b/tools/testing/scatterlist/linux/mm.h
index 5bd9e6e806254..121ae78d6e885 100644
--- a/tools/testing/scatterlist/linux/mm.h
+++ b/tools/testing/scatterlist/linux/mm.h
@@ -51,7 +51,6 @@ static inline unsigned long page_to_phys(struct page *page)
 
 #define page_to_pfn(page) ((unsigned long)(page) / PAGE_SIZE)
 #define pfn_to_page(pfn) (void *)((pfn) * PAGE_SIZE)
-#define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
 #define __min(t1, t2, min1, min2, x, y) ({              \
 	t1 min1 = (x);                                  \
-- 
2.50.1


