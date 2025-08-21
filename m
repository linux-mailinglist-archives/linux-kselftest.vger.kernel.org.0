Return-Path: <linux-kselftest+bounces-39562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9243CB3049F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF25AC0D2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9360236208A;
	Thu, 21 Aug 2025 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFuwlXt0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6618F35FC0A
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806881; cv=none; b=q2W+kYvnb0BfPfByeRJzxNqHei/SRvWNwMD/vuqnqhFAqx1QXzh0F6BniRByTRRAHPrELCVQUq4/h+eKnUYakeKH//bRRJrAb4qpRmOLJn6ktLJ6WFVFYyv74A7qsRuGWCrda8ycbbv2LINumfpLqRnxg/KKiRy4IdtZVuVgMRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806881; c=relaxed/simple;
	bh=g5Pqhen6+TGsZaJhVjcxjHrty8uEIOPaJGSbz6Iayeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VajZ26g7KZNSHLFytEutjQWylr7W6Bl2waA1DOcT0FAUvkxowUBx83R8vlg1CT2F1KRkbYo+J+TZr9buEFh6ZY3v1EHvd99dVtsC6QFryq8I6C7h+LiHU60t6x9+OtsTkFKZ0AUQeq4JJ022fle0ntcNMSJcNP2Vjij07YQXx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFuwlXt0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaqjYk7qiFpFT4dP16wKMuC8fiQfbkUwRRgQVKGzHC8=;
	b=QFuwlXt0P5IZY7ve/ZagmEdYk53ZwTCGo2LpUWNWHOhCAvgDKIO7FMloNCM3+kZ+HoRKx/
	qRGB5gFTMF4dyRbuVEli5WGuRpWuJjLiza7xu8AcO4vzpxNb9B9vx2z0vQDmvIzX6t6SUe
	AH/Rss8u/WLO1TQNGNZgaY9Il2SSSCg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-ELEGFclfOdaeyVP0nAtnew-1; Thu, 21 Aug 2025 16:07:47 -0400
X-MC-Unique: ELEGFclfOdaeyVP0nAtnew-1
X-Mimecast-MFC-AGG-ID: ELEGFclfOdaeyVP0nAtnew_1755806866
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0d221aso6547685e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806866; x=1756411666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaqjYk7qiFpFT4dP16wKMuC8fiQfbkUwRRgQVKGzHC8=;
        b=C94304lx17GyV6etcn0BEPJqIs3qQPktzB/Cr07JX5Ot8CyFGOoUSIhYjUpldHRTnh
         1NcULeRO4NpT9bp65AQ+Xgpxcmn9crtJzKneMxr7vfflFSFyj+zNI/FRXUYyhk5xdedq
         Ws8ueJlRHVPwqlyC/bj6fW0CE63SJINJnIqBo/IFcoNcG927ViTtm5MA+6oMvM/atjlU
         qrvdZ1gpd5M+Sd8tIcLuw0f96FkYIHiaU0t2v+sYExYCaY35XZ38Zi1WUU67y4I/5M2f
         /7r2hCAYj6ubPr+zPwL6mV654aTDz50/olS899pMbjXXRc/vEjMCXwkvclOTvUN6Imwy
         P4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcTzdwMC59BsiQYuX7Np6OnGtgfnU1aSzdGPxIq1enttdPbf3w/QJbvQHeeibgIcKXxNu67QqN7UVvvLaNBkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgquEKGRrtH6jOHg/aab9/oJoRKSdA/pi3FJk7CqpEhrs+NCRx
	loEaaNhfOD4bfXYpaAC/8dRtttt6wZpq3SEJwhaPNV9b1gcbYwSMTFrMYDAS3GTWNIq8ShVfpC/
	m0NJGZbg7hf3kCBc/Vh0XvRp/dRyvFijUDCnyG7TF6Bz7I39Ne/Lq2NIe8+hRvnYwIMyykw==
X-Gm-Gg: ASbGncsn6ArTPb9+6g2pOYFmJgH40K0MF8uCTJ7KGfBzCYbV0lvprYOdCFXd5eaAUP3
	fwWGAVHKfTfnWfWKUcUF3xw5jHKafP4ZWSxbNBG5dL9lGx9n7W9jV6u34GfLJcdZodm2+C04kYI
	RU5N1+eSU6rQoenVlRoPuYCfFuRKAnZW1zWVHRvaxai/45AT4Pzkg32Fx9vDpnLNGT7gnpAFe3K
	fPC/Ti9KOwZ6+S+lgspbeS9DVaYr28t2muYopTez9YVqvTEuR7XoER5pFAzpsiu8Q/rgyRw9lSG
	yJoQ+AGmKP+56CyFxcETMwFqHOs3LbGSGnsJlZgguT+OV6b2gOgSS98Tcq2u4GFVo4duVPuhrNN
	s0Pxam3cJyFL4WB12BMuMKA==
X-Received: by 2002:a05:600c:1392:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45b517d4e23mr2819265e9.26.1755806866176;
        Thu, 21 Aug 2025 13:07:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUtzGc4rPv18tjnV22wd1xjfGI25AJiVbHUBF3o7jj7YvZLrrv8XzLc39l/Z4dCqHj4yY2QA==
X-Received: by 2002:a05:600c:1392:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45b517d4e23mr2819075e9.26.1755806865726;
        Thu, 21 Aug 2025 13:07:45 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dd0380sm8632985e9.10.2025.08.21.13.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:45 -0700 (PDT)
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
Subject: [PATCH RFC 14/35] mm/mm/percpu-km: drop nth_page() usage within single allocation
Date: Thu, 21 Aug 2025 22:06:40 +0200
Message-ID: <20250821200701.1329277-15-david@redhat.com>
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

We're allocating a higher-order page from the buddy. For these pages
(that are guaranteed to not exceed a single memory section) there is no
need to use nth_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/percpu-km.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu-km.c b/mm/percpu-km.c
index fe31aa19db81a..4efa74a495cb6 100644
--- a/mm/percpu-km.c
+++ b/mm/percpu-km.c
@@ -69,7 +69,7 @@ static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
 	}
 
 	for (i = 0; i < nr_pages; i++)
-		pcpu_set_page_chunk(nth_page(pages, i), chunk);
+		pcpu_set_page_chunk(pages + i, chunk);
 
 	chunk->data = pages;
 	chunk->base_addr = page_address(pages);
-- 
2.50.1


