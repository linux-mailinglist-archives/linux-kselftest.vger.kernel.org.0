Return-Path: <linux-kselftest+bounces-38106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F6DB174A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 18:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2D01885C0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 16:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FADD27A913;
	Thu, 31 Jul 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="bcQ9Gw+j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE29323F403;
	Thu, 31 Jul 2025 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977840; cv=pass; b=bAXpntElUsHCGgTVEvbjzkciHWHG5dnwugh7Lf48LXgkz03WBv8pPg97PX+HGIkJukYfnPhqh8PJmfhRoD7aNI5i3PK+u/kXtBVVnaHP9MlubfbIa+qSW0nrC/JS3whO1Ad6lGCWklTBzq4wET4/3m7IY7Kk9qtSsoesSGUat8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977840; c=relaxed/simple;
	bh=eDKzkMDZF/mxj5E5sFDQz9q7rcAf5JyA7EJM+AuDcIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fRLOrV2vWE8fng2IyVAYyW8fApZh3d+0PSsqJWvtZ8gUkGQrx/c1pxfoeJR/4zWATbqYY+4+xeMan9Z32fKZHTMNhvELYtOyc/uDT6k0NPx5bNY2BQo/6ZJeBNNT3aeK0jqTfozw1rQ4WNwtkkxMQlX//m/f0oY0E4d787zNxFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=bcQ9Gw+j; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753977750; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DGVGICaTwhhJr59gs+cfZIQtxM2SepPnYLR/ivuLXW+6ONYxfFOmF/m90Avpb5zRkiM1CFHFsumMTL5pQP5LO1apBSZ7JW974L42i0iGtZSOqi4uwI3I8+yLa6jQUhNFDDrbLhA4XVB9LBEQb0FMYKWiQMPUu36H2bUQlgA1vE8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753977750; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jsundmjk432Nmx+yxivH/Xk7ers/4Sj7qV5Y59avV5g=; 
	b=jXJ5PIT9OftLeQJq9Mgv/O2RwZNvlA+Z3/MdnDE2IeJIf3jCRszZlUXaespC1q5Mk6PBc2z0B9VvyXApz7fOQZoih+KbUnPvx40pLpTlBGtYPffCH1x2waK7hFVc/SGJtRiNLorQwf95kuIHn8kXKMqQbLcC73lXCUFlrR1blZE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753977749;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=jsundmjk432Nmx+yxivH/Xk7ers/4Sj7qV5Y59avV5g=;
	b=bcQ9Gw+jfHYzvDinaxptTQseABCW6dyLRb4HAE/vHF5+bg6OQXjqZtEp9b2szz6N
	kw6Iy4yI6w830plPR6802G9dUD4zErzqq7DnRMDJwv+r/eeEeorIPNi2MJYsXxMd65y
	3aSpCymxEyWj7fLqY8U5Q2VgOHl1NstMwA1xXyMc=
Received: by mx.zohomail.com with SMTPS id 17539777482221004.5959311406996;
	Thu, 31 Jul 2025 09:02:28 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Leon Romanovsky <leon@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v2 2/8] selftests/mm: protection_keys: Fix dead code
Date: Thu, 31 Jul 2025 21:01:26 +0500
Message-Id: <20250731160132.1795351-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731160132.1795351-1-usama.anjum@collabora.com>
References: <20250731160132.1795351-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The while loop doesn't execute and following warning gets generated:

protection_keys.c:561:15: warning: code will never be executed
[-Wunreachable-code]
                int rpkey = alloc_random_pkey();

Let's enable the while loop such that it gets executed nr_iterations
times. Simplify the code a bit as well.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/protection_keys.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 23ebec367015f..6281d4c61b50e 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -557,13 +557,11 @@ int mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
 	int nr_iterations = random() % 100;
 	int ret;
 
-	while (0) {
+	while (nr_iterations-- >= 0) {
 		int rpkey = alloc_random_pkey();
 		ret = sys_mprotect_pkey(ptr, size, orig_prot, pkey);
 		dprintf1("sys_mprotect_pkey(%p, %zx, prot=0x%lx, pkey=%ld) ret: %d\n",
 				ptr, size, orig_prot, pkey, ret);
-		if (nr_iterations-- < 0)
-			break;
 
 		dprintf1("%s()::%d, ret: %d pkey_reg: 0x%016llx"
 			" shadow: 0x%016llx\n",
-- 
2.39.5


