Return-Path: <linux-kselftest+bounces-39552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADFAB3040F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B29AE18C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1580A2C026D;
	Thu, 21 Aug 2025 20:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2b9wZzk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1314B36CDE8
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806848; cv=none; b=K64y8EwyPadwihCOBSDNoCj8cX02LUQGVkAB68llB5lJICsh7ld1T3vwanub6BduoMEhrm9BeUt9LtadKbApoQpaeFaRrEccsMwAmzcqULuyv0tSscyIzAfMvvpfRGHhkp1d9cZIXdgw93AWOeeyOlqg1So8YbrHFzj6MHQJcvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806848; c=relaxed/simple;
	bh=vLP4m8ubY62ddowshnJEYGhNc+fB41I1n0umGIUlXAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCPrUxWXNCBkbqCtkn3PL8AQLf8pjF2foF3Z72GCYpXryeJwn93FFG6r4/55ApsVaGVVNd606EsPsqAq1LpgE318uhySsDBJ6ew5bjdyGdwohN6oQEYs+iwMoVcYwvZAh0GJq8MNpQ3c6ia8BGBMYuHjqE2BTHw9vF8qxO5OE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2b9wZzk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOl+Pd7m6DQCTUATshUDhXjEbKNtUx8aQQ0CVjE/d9w=;
	b=T2b9wZzkC/xtgKn0ukr1t3QPXzSS8koSErP70VVlBJTnOOS6+oUpk4YqREoCKecgtdFRIx
	kGW2IIM/tgsuWykBgbG17G0j4gTen4UC+bNsSqM6/3hdTCdVEEjGP6KqUCVvLPRcpMl4xM
	kkKGre4Sb/rfgzVn3cYIqgkm329u0Nk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-TR8JlMjiNFKPppE-PfD_Qg-1; Thu, 21 Aug 2025 16:07:23 -0400
X-MC-Unique: TR8JlMjiNFKPppE-PfD_Qg-1
X-Mimecast-MFC-AGG-ID: TR8JlMjiNFKPppE-PfD_Qg_1755806842
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0045a0so8434025e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806842; x=1756411642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOl+Pd7m6DQCTUATshUDhXjEbKNtUx8aQQ0CVjE/d9w=;
        b=iJt9C3j9xplSGlKAZHwjOtINIV1Jpg+drmOSdUbwULKf2sYqv9YOj7FLjqqgV+3it1
         RVbi/51p6482wTm4LFkvm0XRNRwbIKAPkog+keCdxgAu95SJ5B+7TV3ANuQM8q/rTB8a
         V7BMSzxxaXIAF3k2C7zxtHB+I/UjD+xww81aGp+99WBuUwbbwuq4sNdMhSHlv9lvaArm
         OKVmmwU7HmfpvBw2nKYyTxuqd3PRD7i84UlWKFGQuJYdHTks1PRIIwqoJuUovhIa1Jnx
         cEHBHzwEg60cFZOcEgGqQnXSTYaWDKhDpvrMrDxzo4t9bloYEXnwE7KNUqWzjgJ+aaXv
         Uh4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhGl2xULN/n9+dvQcjVWCg/kaB3MizJwD5lsUjvNZhEbapHB0G16iDMv7uxwHfcjk61SfdYutvp6DvJsEB3Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBVHDjplZSVtTscaYqIDqNgW2iUPwJF3tN0NnEpOG/UL+PtDNn
	rh6qYVvxueMZToKtNU+WMNoWPt4GXtML4VJ3vXfs2kbR6Ajt+LS5fO0ROu2ddpyTQMrxTgwOxln
	Eckk88lP19vmeW2rvfAFs1dNURn4tTArqYcFfgxf8wz1s3bqM+SCHk2MSTKW9CYZyyl/T3w==
X-Gm-Gg: ASbGnctOHbylJzP6j3dpszktjL3bphyPoQADlggTQND+nl35yklFnMTKl8IblXOvqo1
	lulUVCMgJ1elv7XcCndfVfJjecV8u2XbmJFo9hVS+nigly33QZ1ul0QZIacuOhsQMKujsyxLsMy
	NMDqx5aw0s8LKSIvIQiMr6wgC1QKWTvt9hxHYOlCjtx8U/ObfHc29vGTm8EJznzZjpWkGXa6dae
	cVKq193NNHiDvZE9p0C24UEsJ29IIeL0LZMFG7wUAcNbO+n4ZcIRbBiPW+ziq6ZiUMYpUrqJyme
	oUZjGs0B2ExIspzPi6Ps89nMtJFj9pmJRdBgLwZYzByWZ4ziNeWuy8ZqfP8k9WasZHvyoF3l8Gr
	dhacEWM/yLJihrtngPERj1g==
X-Received: by 2002:a05:600c:1993:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-45b517ad4a9mr2412445e9.14.1755806841673;
        Thu, 21 Aug 2025 13:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtBnzBdejX2oNj8vG9iZBZKJew+pPrkGWxHzVnhFEnb5RkXIsj+cBFTtJrIXnzr/4lYhSU+w==
X-Received: by 2002:a05:600c:1993:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-45b517ad4a9mr2412295e9.14.1755806841198;
        Thu, 21 Aug 2025 13:07:21 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dc00a8sm10960275e9.1.2025.08.21.13.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:20 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
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
Subject: [PATCH RFC 05/35] wireguard: selftests: remove CONFIG_SPARSEMEM_VMEMMAP=y from qemu kernel config
Date: Thu, 21 Aug 2025 22:06:31 +0200
Message-ID: <20250821200701.1329277-6-david@redhat.com>
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

It's no longer user-selectable (and the default was already "y"), so
let's just drop it.

Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/wireguard/qemu/kernel.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index 0a5381717e9f4..1149289f4b30f 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -48,7 +48,6 @@ CONFIG_JUMP_LABEL=y
 CONFIG_FUTEX=y
 CONFIG_SHMEM=y
 CONFIG_SLUB=y
-CONFIG_SPARSEMEM_VMEMMAP=y
 CONFIG_SMP=y
 CONFIG_SCHED_SMT=y
 CONFIG_SCHED_MC=y
-- 
2.50.1


