Return-Path: <linux-kselftest+bounces-39571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5C9B30500
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75257622B78
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F1A372896;
	Thu, 21 Aug 2025 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TobQHE72"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D319371EB4
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806904; cv=none; b=Qpi9fvgRLkm/qZVfhQgNv0Gh2zHv2fwVZcWeivQJ8jVa3+9+r4JtpvzQ9aKSrdARYAD8aHgrSTdGHHlsjOWSW4Meme1dIgVjyZmqkl6t9w2nisA1Ip1qcH0iC1RCMSGaWxxF6GhIPFWi0YxUOfm8xMI9Gg67d3GA2z8GvJ2dz0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806904; c=relaxed/simple;
	bh=r9aVOOwiYkYkJ2XxN3c4oDiixJCUuv2T31t2h3Fc0ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzhXB8G0iYGLfCdOVS5P21oNWqxOHmkCGh6skKJK/Ug2Ms46wRVJwaISp5yzRoAa4gN9r4VcvEMX34KxI04IZceO547AuyDsR6NOUg3c1WxTdE6A/26Jw+rw/L8Vl24bxmrMD4rWlhhaqCVDeg+YbXPZFr6iKfWvM7xqdQN5SDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TobQHE72; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5INZuVEW8ZoCVRVHt0CSLhpT4h786L9PUsnD4NVlnkc=;
	b=TobQHE723m2bw21PBPzEoo4me1lXI+LQ1c6ohnUWy6S9zSQVR28QJbgXq/qM5sTvkK07sb
	xd4zymHXVzNkG4UVO164ucoGh7UATB09rMKuVjM4k/cKprzszruOTfiy1HVCeeE2NOuGEk
	T2zFlNxQxtfc5ZdgI45eSY/Z0F8wznQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-uvlD7HxpOveHkrJivCDlDQ-1; Thu, 21 Aug 2025 16:08:18 -0400
X-MC-Unique: uvlD7HxpOveHkrJivCDlDQ-1
X-Mimecast-MFC-AGG-ID: uvlD7HxpOveHkrJivCDlDQ_1755806898
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b51411839so824355e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806897; x=1756411697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5INZuVEW8ZoCVRVHt0CSLhpT4h786L9PUsnD4NVlnkc=;
        b=HUiD/EPs5iBulm0IkawBodtFQ4VYDCReTJZpTE8uk3lEeCRyCFOqQFyrvw4Oe/aARu
         p+vhM5zzaN4LfrO0a5NXAvbKsIyJhidH0MtRH4LBYxb3XSnBmobDZ6J2XIoL8iVIiKpK
         qw4IORRjExI0Lh4wGUanpcaAXrRPvztQKb8XJIFbiijssruAEqMgrMwk28XS2e2BMAnA
         8i5aT9+eAhn4P+WJYll9x9A0egfhjDStVcDN7ehH3a10ITyY4oPk4ZUf0WnpwUmmxT+S
         aAAJ43uREI8ROs8JaThqKqqS8xvxqplWX+dSYqnN5MGUFRP8udjMBu+QlDZ55fHIwHov
         FacQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4iwPCy8FqvMegnJIN3XnUSDznB1+mfL2d26sWcBjjfrCO/da08rQM4dbER2DeiE5hc724+YfpQWFEKTjgfkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzas44GQHpqxD8UznWmF2jRGnyHgivKfjH7qIAbagKPF5RCR5TL
	KRmsrw/BiohNG0bwnmDwyw+/a8N/MwG2Rn7Tq4pTpXwvTXswJ3d8L98X+BLVmOVWfOMkVWEocTD
	6Sfig1R0zTeT3EPFWZmUPi6mbUvmfvOKfOG830Fm9mhl91mOgtFZ1AqN6YVRkXPP9QEgObA==
X-Gm-Gg: ASbGnctoM8hxI/AaJi0EAY1vMtM7Mv5f1ugIv8HtMJGcYwY16/K+eyrgJ0LqRQPKhLC
	RG0syjssfy2DmGy8k4GMVPcb1qVYc6fmA6zwZwmFe7YUbGWzwpTfPoW/bauw+E3NMYzc8uCoTg+
	XP4hs5H+qoSXOgOoEyrWiySvLQ7ow3FhKM44knW5QGxv8z6esJbIcpYEEG+ow/btQUbNLNk5Lkh
	kPkOid4TJLdvwWR/8ql6zbMRDez9Esd24QLzoNeqqiV/7wKHhcH2s4zaawf4v6CeTF8W5udi4t/
	Os8gCflTzkJkkg76b3mHX0df0N9xdPN5qwAZ9TQUNXl23Qny2nTeHKbiB8N/DYxa6AaYwfNqydW
	Im26qzGqKoR6Q8CDK5dqjjw==
X-Received: by 2002:a05:600c:470c:b0:456:285b:db29 with SMTP id 5b1f17b1804b1-45b517d416bmr2505935e9.29.1755806897449;
        Thu, 21 Aug 2025 13:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPdYXvWWhsiYzUao4v8GSpApokx2tOJxTxGWaryOs6bj53AmOc+7o5w7P2pIRGnKU6jzi+ow==
X-Received: by 2002:a05:600c:470c:b0:456:285b:db29 with SMTP id 5b1f17b1804b1-45b517d416bmr2505625e9.29.1755806896948;
        Thu, 21 Aug 2025 13:08:16 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e3a551sm8831035e9.19.2025.08.21.13.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:16 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
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
Subject: [PATCH RFC 25/35] drm/i915/gem: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:51 +0200
Message-ID: <20250821200701.1329277-26-david@redhat.com>
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

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_pages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index c16a57160b262..031d7acc16142 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -779,7 +779,7 @@ __i915_gem_object_get_page(struct drm_i915_gem_object *obj, pgoff_t n)
 	GEM_BUG_ON(!i915_gem_object_has_struct_page(obj));
 
 	sg = i915_gem_object_get_sg(obj, n, &offset);
-	return nth_page(sg_page(sg), offset);
+	return sg_page(sg) + offset;
 }
 
 /* Like i915_gem_object_get_page(), but mark the returned page dirty */
-- 
2.50.1


