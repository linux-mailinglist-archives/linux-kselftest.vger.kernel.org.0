Return-Path: <linux-kselftest+bounces-39574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CE7B30514
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8261CC20E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B30D37C114;
	Thu, 21 Aug 2025 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdA0r21N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1637429B
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806910; cv=none; b=D5zTs3HiglxuFWzTk21uzlDPXXSg85A5oVdCNLPfKU6dxTQBKVwDWFf2nO+oQIa1sbmm3FH8MnenoVYJiEjansd4klwbNYfB5E5kEnqbhhLVAEhpXzTzfJzvnel3QHoHEbMVdsBT+AawfmPxyqxrFkDHmsf72tRlPMG3PieGhyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806910; c=relaxed/simple;
	bh=bq2gWh1hWRAlT57D1zXSNbOueAtiEim7ETzHNFHN/Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlXuzCiap8whaSO3wrq96sENRjhgHP8mMWSUwvzsXpB8Oq/1Ol6g2Z6GZBIcXHziu3tcLWAeRHY7XmTNJoVSIkNsP4XSt2xdZAeWPZAQZCx4com7prlNzxLAfXWgo0ILoZj5tCiH4+OP3qQfeEgilvSDB7nrA1m3APWoyJhHHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdA0r21N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yR/3u5W37RASrGsn/s3pQVQ78UUgH4ByCavV3b4UG3M=;
	b=fdA0r21N38x+v2UQLIZ9WgOzWypzyF/gGbyMtQrNNeIBCBkAH7jv3EsB2igOSoB1bm5R0u
	zwSo3epyzhY1kDhsD1gVzR3BS/SSw7j4pFu5qqw1G9nF2GyfOSX3B4rDzNGsDz+YRLxAib
	yGhcCmMtiIyZzytyFFCB9WOUCQp/uaY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-82uxAh_gNJiQ4BBbUmBuHg-1; Thu, 21 Aug 2025 16:08:25 -0400
X-MC-Unique: 82uxAh_gNJiQ4BBbUmBuHg-1
X-Mimecast-MFC-AGG-ID: 82uxAh_gNJiQ4BBbUmBuHg_1755806904
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so14275085e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806904; x=1756411704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR/3u5W37RASrGsn/s3pQVQ78UUgH4ByCavV3b4UG3M=;
        b=gkK2Hq1YvaQVo2xRi7wCzMpnHV5QXQ7jST7YggP1Gs7V2yDh4KzvG9c+9u0HMsHiLZ
         CAgdCO4DkDD2jNAV2ztiu6zEkozmTYqLkPDSktM3JPsM09utyrjGOx9aaiW957a1q4/a
         R+QcoSlQYvhKSiaZ7rWdusU8zgotRpZTunO5vySBTOMyEMEsloQlt8VgSKpCt2vWKo+u
         VQdYgJR0LzZKrIkvBaUQncyv+fd5o9rzhBuqHPsL5qKngSxz++0U4hzI9lEgM7EobZab
         c4y0YIzyPjPfxkcIhDGzehIAajjOzfT2ceER6UmnNEyiRruruykxyis2yYnjew37+1rD
         lheA==
X-Forwarded-Encrypted: i=1; AJvYcCVFkkBiLHtJ6VCOSMcavvHm8qlL22deWXlDfdUa0kSaGUuu31h8rsBf8ZHi8tgoHATi9ETYTMfgezhkkk4Ql7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBl2SyAlR9ML+zUzIIe4n1gu5pLAxXLWFbDgwzEcC67DNPiqXN
	+oR69vxJPdMK1NIUCvFEs4zBXl0SiUPftb9Ab2U4Ugm+BMLBJNYw7Nf8ubW3d3c0rzKnz5tWleA
	WCYq/MbxFwRsZAujNG+0rosv5z3mLxHoAuUSpUBryI/4UVcedF6SmoCWqrcsifVRY6fRJnA==
X-Gm-Gg: ASbGncvs0zerWNy+IdiY+FB4s6SYqOVZiDUBBBlxcOh/Jf2X+RddiPptAOJb939Eoix
	/EVO4Fi6OixVt+08kagQYVwgg5OOTtRi1fyY0HlN+IPYrwRQMyvh0ZvL/oxKC14BBsQS61fzHeO
	LCBn+o/YLo7PDQePKR17sMJ+v8+QDrPptXONP8pVc+moEBEP0Pc3Zgcwj4Btj8vifvBHW+FH2hl
	/RjVDnxbeUw1yFZhburWtRmbsqMpMntkeiJkjmyx0FHY2moZMBmOEQ43/CuZzZziurUqpYtgVwS
	b96e8ASi81GrEL3EiJEq53FwnrkxgvKdN8DFN18zWvRnmfczcxyX2mr78q3Cfi2ix4hs5Ram1Of
	8whbUVLDm5SPksRZUs5QKGQ==
X-Received: by 2002:a05:6000:310e:b0:3c3:5406:12b0 with SMTP id ffacd0b85a97d-3c5d53b40abmr247305f8f.30.1755806903666;
        Thu, 21 Aug 2025 13:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+53ePp4gOBoZK5+aLlST4uu6G3xHtHBUa0vmdrbtPfJ4bf44S3Zn2IpCr0m84pAneAOD81g==
X-Received: by 2002:a05:6000:310e:b0:3c3:5406:12b0 with SMTP id ffacd0b85a97d-3c5d53b40abmr247245f8f.30.1755806903113;
        Thu, 21 Aug 2025 13:08:23 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0771c1708sm13032145f8f.38.2025.08.21.13.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:22 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
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
Subject: [PATCH RFC 27/35] memstick: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:53 +0200
Message-ID: <20250821200701.1329277-28-david@redhat.com>
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

Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/memstick/host/jmb38x_ms.c | 3 +--
 drivers/memstick/host/tifm_ms.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index cddddb3a5a27f..c5e71d39ffd51 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -317,8 +317,7 @@ static int jmb38x_ms_transfer_data(struct jmb38x_ms_host *host)
 		unsigned int p_off;
 
 		if (host->req->long_data) {
-			pg = nth_page(sg_page(&host->req->sg),
-				      off >> PAGE_SHIFT);
+			pg = sg_page(&host->req->sg) + off / PAGE_SIZE;
 			p_off = offset_in_page(off);
 			p_cnt = PAGE_SIZE - p_off;
 			p_cnt = min(p_cnt, length);
diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
index db7f3a088fb09..0d64184ca10a9 100644
--- a/drivers/memstick/host/tifm_ms.c
+++ b/drivers/memstick/host/tifm_ms.c
@@ -201,8 +201,7 @@ static unsigned int tifm_ms_transfer_data(struct tifm_ms *host)
 		unsigned int p_off;
 
 		if (host->req->long_data) {
-			pg = nth_page(sg_page(&host->req->sg),
-				      off >> PAGE_SHIFT);
+			pg = sg_page(&host->req->sg) + off / PAGE_SIZE;
 			p_off = offset_in_page(off);
 			p_cnt = PAGE_SIZE - p_off;
 			p_cnt = min(p_cnt, length);
-- 
2.50.1


