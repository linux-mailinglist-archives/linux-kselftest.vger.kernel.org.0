Return-Path: <linux-kselftest+bounces-39556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89050B30431
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 957BDB63693
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6586434A32F;
	Thu, 21 Aug 2025 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CH8r6nmP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536AA313553
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806865; cv=none; b=HD82bhsHO6dBSAxQ9kdIcfNKoJ1MgPC44u4Tv2u4h/ctrd3LbegvQdvcqIS6QExhT3tbHFjk0H3eaWfnYkpMzIjwohxAUv6T9yuUMZ35gB75hWWYRK7HA/Umrl3wriazjTaG6lg8JjmquzsdzsufuZUxh5y+lH98HaDx+GGrzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806865; c=relaxed/simple;
	bh=XmsSbVhT3dGsaRmtyroJ024d7WMqPWbEWQJfIPHhOJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urrHbmPar6KQ82RkVDQpsdk8R6YkdnP2TJcJI43O4QkD/MOTr3EDVzaQYJ6X8io4PpjRgHtAD4kXfdvAj63h2p/551KQQuk5kMxQcoRu7cQKQ2GZK7Cqk4avcrgZgmA9nH8/Zt9kaMares3xG8Q0rLI6MOzrixo3TvRaFaVIEHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CH8r6nmP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ4Uu4zoWyKmYQrq0i4l3HgKr6VpAHaNUVdQgPTsBAE=;
	b=CH8r6nmP3KCdXZMFkoQvPAZ1pJZRBcIAUYhHBGbN4jDLDZcaoAULhvaDkuTvcoWYCPQKxc
	Xz+1EDYt4987pD0fioEn7fmuSQW6gtcCiM6aZBUExDmETNIBvNF7qlU3/6+eDOdvpQFO6u
	k+VZJ2bivRWRY8bIqct/CM0tFvC6TSY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-Iie3IzVIOoWCwPKGmfa_Iw-1; Thu, 21 Aug 2025 16:07:39 -0400
X-MC-Unique: Iie3IzVIOoWCwPKGmfa_Iw-1
X-Mimecast-MFC-AGG-ID: Iie3IzVIOoWCwPKGmfa_Iw_1755806858
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b51411839so821405e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806858; x=1756411658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQ4Uu4zoWyKmYQrq0i4l3HgKr6VpAHaNUVdQgPTsBAE=;
        b=e+bRuC3FXnBAY3KYGg9H/RvWHU0u0TEKyioGjypGgKz/YSpm/bYVlAbkB26vzZ6jgj
         sVD4r5uAHpxXFyRbNkg5Sz2qvTM6scvrsHNH7wfi9C52/S5TUbi1rDM1bJGO4R0Zl2i0
         uwl/Gc8ldaamV28i3WWWjaQObqPKKOscvWPLxwmQZESRG9vUwHL+rQwbAxAD4MTxNt1s
         xHoZLQObUIupD5R9QHMexOD8Dg66NnjM7PjiB0DNlBQHLMAJCLEzDgAK8Szfxo6Ga2Oe
         GB4JgQ60HvacSevvDN4QwQu97ZFY0kfRjwAHBGrfS7SLpI0aeXvhELEgruPN6Ho5x+qZ
         ZuJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv/t5slHvkoAEo1dfVeeJwnW9FkmdcjsbyWCYS9xA9kI7s/AkYsX69ou+HRxz92kICkLexhw1w5k6+vVT4r/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyCRr58FwCC7qEjosiLhK/xNGfFiBn6rsXEsOkJUQ7lcY7O7V6
	CY9cMLLlgo1FbDW1yImCcVhWCFT8jExxTlS6WhuzLJpxk9sCtmvg10ElLWe3wf0cdMntoLrz01E
	ZrlMRePkjGag2uFftziBbZFcAPy+DyPvKeUbmK7GLYNjvRkxceMFt6ZdFqfBJpGkpthJJ3A==
X-Gm-Gg: ASbGncvoM/bojVjuEo9G7xl/4kHTxdVkyaIdbDghQHAWuLuAVC8TbtldhbtF8jb7/y3
	gSbUVkzCbsRib++0OpBgoZqPgh36fqS1WPXMnt5ebF8LcOt9QO2Ki/6yHup479JSOyCXgEd1LKs
	IQSkzD9Z+5YBVP5hOL+SS6+lf20z/0Ilkor4oV2t0sJ5If2sbjXwZxeTk2uUqg8y4jCTq3YFEpi
	anCfnEuF5LHVELdz6mE1HvawcHBQqUAu1QWv84YiwLDLMRsZ6fngqcV+G/V8aBxNyelhZaZbw+L
	CRtJfI/cQ3DjjpBCkxgZdbb6DWL1VHWEcJRiRtyTwkKwhtKzlBLERDpUYhAEXcBb6shvBcxuZ25
	GwiBwouux9DHRa6ToE+LyWw==
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr2646475e9.18.1755806857884;
        Thu, 21 Aug 2025 13:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlSU80KqPPviGOLp6CI40u/NjPujjG4FLCG6NoakJIlvY80lRDOTTm20w50mEKFuk0YjVSLQ==
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr2646245e9.18.1755806857378;
        Thu, 21 Aug 2025 13:07:37 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4e87858asm18672185e9.3.2025.08.21.13.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:36 -0700 (PDT)
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
Subject: [PATCH RFC 11/35] mm: sanity-check maximum folio size in folio_set_order()
Date: Thu, 21 Aug 2025 22:06:37 +0200
Message-ID: <20250821200701.1329277-12-david@redhat.com>
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

Let's sanity-check in folio_set_order() whether we would be trying to
create a folio with an order that would make it exceed MAX_FOLIO_ORDER.

This will enable the check whenever a folio/compound page is initialized
through prepare_compound_head() / prepare_compound_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc030..946ce97036d67 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -755,6 +755,7 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
 {
 	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
 		return;
+	VM_WARN_ON_ONCE(order > MAX_FOLIO_ORDER);
 
 	folio->_flags_1 = (folio->_flags_1 & ~0xffUL) | order;
 #ifdef NR_PAGES_IN_LARGE_FOLIO
-- 
2.50.1


