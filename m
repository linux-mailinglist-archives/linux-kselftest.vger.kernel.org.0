Return-Path: <linux-kselftest+bounces-39569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A119DB304A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 896F24E6604
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B230437058A;
	Thu, 21 Aug 2025 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2kzACG/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2137350D56
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806898; cv=none; b=iAU0YUf3Qe44eSJZy1I4hg2x6Hc42HjYZwTmz8BHIm7tpMRFmTXTxuiLjAxf3jvEN30oCUI1rgbzj72KSsc2jtw7omhjyi+IpC/ac6oGPKJxmMHgkFmYlkth7tSEOUKr4MZOpSX2oNy2gK8ZEIpRhESpeT4pfU18ZlU1MS8m1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806898; c=relaxed/simple;
	bh=kURokXQjB5Kuo7a6U8usTL1aQ1tfaOTG2Bf9aj2NBoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYu6drfqkP/aGHL4hen+5JKLEPYUdPwct/EE+AFq/vlG7ElQq0X9mjhYSBjEDsqsps0HHW7W4NLRliKXjIB0t8fUdwluywtXDT5UJKcFTf8bf3S+EDz1VgKwHXJoDD8Swam1VnOerkJjzNdfRa7dMZXBiMHv2ueIV7R1ordFxjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I2kzACG/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKFS9/TuG2v9AIcAoooIJr3bGKW6zmP0XL+5izT5Y+4=;
	b=I2kzACG/XgO8fyV/UW5NJzt4znBSoXpxfY+JJceW7RcSLvJ3tiYmR4dJPG9N2Y4DV8PqSh
	ksGBQosUGSmvdlwn9XrdbSVHDuh4abHQqMb01qTcKD/uTU6XkGeOGy2L//fOn7YEZmSlgk
	527G2JfUjG4HmH+iMXma0t55Hezg/mA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-zHqIz1f0MdadpXqazbaggw-1; Thu, 21 Aug 2025 16:08:13 -0400
X-MC-Unique: zHqIz1f0MdadpXqazbaggw-1
X-Mimecast-MFC-AGG-ID: zHqIz1f0MdadpXqazbaggw_1755806892
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b05d251so7744075e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806892; x=1756411692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKFS9/TuG2v9AIcAoooIJr3bGKW6zmP0XL+5izT5Y+4=;
        b=oE3OsGZxVrkJMJMha052/0adiGh0IYmdXMzdD+RWJLg9B8xF1AIgwGeI/GOyXjw/q/
         lHsBwc6nSkc+X4XQxmIrtGOg3fLvBiEWMv4mIL7ryAdgYTKBOMw+zAubTLMO8ql03zv8
         buIMEfiZRnxwhHsFJgzxC0qWrJg/YokPKL5JEMA3daLx7OS0GDJhwZMMMGVfKxVglygv
         bBoNL40cuFtmiVBf/bDDjeEkhrMahWDuUBEz0RMP6I2kofQD0nsWAdE3LNlY5iHa3BtB
         rtCbR1OyqjBPz5zLYzrZCeYPppqLCwlbNjf+Y9o7zp/C6sTc53qZajMPyz+bIyJNQJG/
         ASOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWym+o7VXxrB+Q6Vbwza5FVv/5Sx8mDt6eXV4QUt/EnMdKjc0vdSTKXpVtdFIepnwE+tw8OTJGZFZSux5Zh4Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/XCVE/4NwG/B5bTvqwRPv484KvTTECqL7pQnZ52I7tZn4daB9
	6te/RYfsNTBGQ18s3ETJsGWwKGlz/udI4/p72L8gtZp6ZWXVsFJwB0fPMQQlKNDRkY4Nv0iwkLi
	n0Ca+YBYYOEHSrFM96BsnU1WG3ri6/Vc+WGfflQ96StG9dtQ2TM9K60NWw7HQsE4yp6A/3w==
X-Gm-Gg: ASbGncvYwR5QCwacaIG5TIYtfD1wOPNEAyIHKuKdWl2jW3iguc/z/JQ9jleHp+rVZta
	yHEOMjzvg+IJaNs9M0UwZFsCenH+E6nEVrsmeppYXOFkP25WfEIP7Tp8AzYrJuUsjx5aok3swYP
	qajLBr9AxRCD59mGtx8+GkG9t3c9IbM4uw84nehbD8DPPjW2Bg4rE+a3llIAe69MSAx4bGnrocZ
	jIm5j5ShZjH+F7/C7MYZUt0ucY2cT2plolxyEufIVN+HxiqP9CCTeCNC2yHBFNOOawIi2AVjG1j
	RHJ6XzP4CJnzC1btJEoAmMmUGXGu0lkhILaegX31CO9TAR5p9ZgWsOCtAKqXWfwRn1hw0c/3suj
	682r0usI9yytCc2C5c7PmXQ==
X-Received: by 2002:a05:600c:1f1a:b0:45b:43cc:e557 with SMTP id 5b1f17b1804b1-45b517cbee2mr2552525e9.34.1755806891767;
        Thu, 21 Aug 2025 13:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/z26sBz7JGLAktk/cnLNnmvA2KmHoRy5M1TseKC0NpCNohvOWfWbiwnk6fyruz4Gv4BdEig==
X-Received: by 2002:a05:600c:1f1a:b0:45b:43cc:e557 with SMTP id 5b1f17b1804b1-45b517cbee2mr2552235e9.34.1755806891155;
        Thu, 21 Aug 2025 13:08:11 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0748797acsm12277591f8f.10.2025.08.21.13.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:10 -0700 (PDT)
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
Subject: [PATCH RFC 23/35] scatterlist: disallow non-contigous page ranges in a single SG entry
Date: Thu, 21 Aug 2025 22:06:49 +0200
Message-ID: <20250821200701.1329277-24-david@redhat.com>
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

The expectation is that there is currently no user that would pass in
non-contigous page ranges: no allocator, not even VMA, will hand these
out.

The only problematic part would be if someone would provide a range
obtained directly from memblock, or manually merge problematic ranges.
If we find such cases, we should fix them to create separate
SG entries.

Let's check in sg_set_page() that this is really the case. No need to
check in sg_set_folio(), as pages in a folio are guaranteed to be
contiguous.

We can now drop the nth_page() usage in sg_page_iter_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/scatterlist.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 6f8a4965f9b98..8196949dfc82c 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/bug.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <asm/io.h>
 
 struct scatterlist {
@@ -158,6 +159,7 @@ static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
 static inline void sg_set_page(struct scatterlist *sg, struct page *page,
 			       unsigned int len, unsigned int offset)
 {
+	VM_WARN_ON_ONCE(!page_range_contiguous(page, ALIGN(len + offset, PAGE_SIZE) / PAGE_SIZE));
 	sg_assign_page(sg, page);
 	sg->offset = offset;
 	sg->length = len;
@@ -600,7 +602,7 @@ void __sg_page_iter_start(struct sg_page_iter *piter,
  */
 static inline struct page *sg_page_iter_page(struct sg_page_iter *piter)
 {
-	return nth_page(sg_page(piter->sg), piter->sg_pgoffset);
+	return sg_page(piter->sg) + piter->sg_pgoffset;
 }
 
 /**
-- 
2.50.1


