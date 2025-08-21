Return-Path: <linux-kselftest+bounces-39563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CE2B30474
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F91A4E64A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA606362097;
	Thu, 21 Aug 2025 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g44+u123"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E82235FC07
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806881; cv=none; b=ZpkLoWe/xsUUu5FRg18l2bi6zom7tplFgvWsK4CVOztm5w+Z/AJ9mkabK2PCAJ3Z3NKCgdBo1X8vW6zZY32OomxiWGps/Q4HSBTUAy+xJuZeeSHlWr/XMIeyWzPywwCF/AchWGXOlgMsYBv0G6ZM1etYExayYX7HDXiUxYZrWoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806881; c=relaxed/simple;
	bh=DqyVXDGsUgZb9r/3HwvxxZbRj3b/8OImyDb3ud4Q1pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJX7IV36JEc0yqcquB9vuwPygN/eE8oVATkxkRsSi/fsEAyvJ9DBsJovcL+dwW9D0everKVZ0m7fKV7i/kwr6Pgo7C4FWEuBUqiYKWzvyROrXi6QESiNYEzwy2kV1J1u7u6c4Oq+l92zTsT0cv+7PtlgPjnPxLONX1Aq5R4oCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g44+u123; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCvnB/7xI7T/4p4mwWx/D4+W6s//h9G2+oSyfbDOFZs=;
	b=g44+u1235YMcQfRmdOoNEIVXNH1JVAXRu2m91yLBDJRa4D3O8o60Q5vAp/xQqEzLVVRcEe
	zp0hpkpdv0AUUYBY6k2kowcYBwcuiIZWiUKuScYn/et9LDziwL+7d3G3sUD2Y0iv6GZWif
	FGpDzqXJnQKAPb/NgyWvibO4kpzqoAk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-mFP4QaeZM6GMC2myCWl_4A-1; Thu, 21 Aug 2025 16:07:52 -0400
X-MC-Unique: mFP4QaeZM6GMC2myCWl_4A-1
X-Mimecast-MFC-AGG-ID: mFP4QaeZM6GMC2myCWl_4A_1755806872
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0b2b5cso10138345e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806871; x=1756411671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCvnB/7xI7T/4p4mwWx/D4+W6s//h9G2+oSyfbDOFZs=;
        b=j20aanLzgvUKJPBR+XXVSg2d2WpTOXJoR9cYfX8pKDnlI145wBi7ZfpyP1fnR00pdM
         tFxwSC1PjFm60l1apR5bz3CDz7PbqQBv2S1PE4+Z7GSpnlKYgg8AHcrSfceqGQ3ckD6K
         Gc2VGlPIKIqOHD1vWca/l6PwuNfBaWsamuWWNUeOmOf3e8BVijrAk3Ts47NGsCyo/Vhh
         UOkD+OusfvLOfLIBCaGTcioWaxqBsCO80YPr8lhtV7bi6Ve/Knuysu2j9eir/cbmKHG5
         S3iPRS2yzG+3ZxG8g24H9FQTp4y1X55y+4BeO5gD9uHrQd9Xt2+ykuxZ8tlHC03fy1Ti
         mH8A==
X-Forwarded-Encrypted: i=1; AJvYcCUmirx+HDuf4vhKxdIHmu9VXR9n0bXvI90XoBZDdY+ri8iLD+qxBdzAdlo/ny2qJ+mDnCuQ5V2S+s3YPzTMcKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6cefRMkpxoSAn7qaOwnGIlE+3ZPE7COBj3lLH97ygH3W5EScq
	rQeRBrmZUsd/LzhMF5AkQmi/G6DRem/kNHZUPABxvHf+Cfiyve1M23aWJ20SikRHMXJCfbor26G
	Qtj9BzT/Js68rZ76cbQGSPfZbIrvj8hGuarvl/0P2cM5+972bznyP+cOknNsbjjq+E1GcBw==
X-Gm-Gg: ASbGncvaSYNT6RuoKWILqNFnkyhEzr7c3wYopmB1I87xVSqE8VXn/j1R/vVzdq/+5bB
	C5t31C/Iw94hwiUdfnCnteuGd4Wxy4ZT5LKSrIhh365X2fvAY8utg9Eule2e1nyWScMvIvCnvAe
	PzUBUBdA5CtLfcZaQjqpFUAtZv72o4qtharsCVQOp0NKHhXbxIxgmFAU6pddvfI8BBg+56h6lAf
	oobmpXkno/2sTNLDlLJ1OOfTTq+f+iri4FW9Kpm9ve1EtvWj5l8nfcijqCR0PcZMQoSKafL77Zg
	pNzoHTXHU4q7Xsu2C0DTlgFyesZJOYWoYcRZUBaDWQkS2xEjJiLEKa4QC3hXQauHyVaQblc/Ijq
	Qp0YMCgRiNKUYVbCC8etNzA==
X-Received: by 2002:a05:600c:1d07:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-45b5179e897mr2278675e9.10.1755806871553;
        Thu, 21 Aug 2025 13:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQe1GSIQC6LfutgynQLrqB1o4Jo0GTrBjlhxRWjM7nqTD8l8oEo1HOcPxtIuVQVn3tsHm8QA==
X-Received: by 2002:a05:600c:1d07:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-45b5179e897mr2278575e9.10.1755806871147;
        Thu, 21 Aug 2025 13:07:51 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4e1d77e0sm22159155e9.0.2025.08.21.13.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:50 -0700 (PDT)
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
Subject: [PATCH RFC 16/35] mm/pagewalk: drop nth_page() usage within folio in folio_walk_start()
Date: Thu, 21 Aug 2025 22:06:42 +0200
Message-ID: <20250821200701.1329277-17-david@redhat.com>
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

It's no longer required to use nth_page() within a folio, so let's just
drop the nth_page() in folio_walk_start().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index c6753d370ff4e..9e4225e5fcf5c 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -1004,7 +1004,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 found:
 	if (expose_page)
 		/* Note: Offset from the mapped page, not the folio start. */
-		fw->page = nth_page(page, (addr & (entry_size - 1)) >> PAGE_SHIFT);
+		fw->page = page + ((addr & (entry_size - 1)) >> PAGE_SHIFT);
 	else
 		fw->page = NULL;
 	fw->ptl = ptl;
-- 
2.50.1


