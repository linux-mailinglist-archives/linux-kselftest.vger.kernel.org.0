Return-Path: <linux-kselftest+bounces-38104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E786B1749D
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 18:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22F7586793
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84C923A9AA;
	Thu, 31 Jul 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="S1rC1MQy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E740239E94;
	Thu, 31 Jul 2025 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977833; cv=pass; b=FTtSOj6NQFJjTzZQne+clctaIwgKT/3+pX9dk+fc2tBjtUl7JuNn1lA7aKlIllGB5AEsb/37vxqwtBWRwHwTIEvYqiq1ejpjUEztT/GIJsob/VAovGOm8atpiUOhEexCDTv+r9n3IYTr7P033RmS/BF3aVz7bfVrax1w8ZI41oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977833; c=relaxed/simple;
	bh=VXTNkqzTkDqV8GcHSpjtiQgoPkdEsP7OLKlAE7g0p4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kvcms1Kmq256fpN+XHoEfyisrrJR+Z+kMfB8Qr1gGMGtL3MkYxDlkygdKJSLx1+PWaIl6vgKfoLJj4jzpEt1aoQTOLtAqb7T0G2Qi6CGyUqCv/nbEzmt12Vvgn/fgZGzEGvQscJZ4huLQZGwl2hXPZ3HGHxKD1RlkFoML/ZYMr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=S1rC1MQy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753977760; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kNoE6JDxCi1zslQy1xpg+mF1/vsqY1D3IqpBnpStBmj+OXDL0sRiK9X/8RP0WJWhQV9EKf6arQbng8mdB1tISDmG3vzzJlBS5uQb92J4ctr3c0tK6Divd0PQ7nSxl5QW/LjfuA7kV1cn+p7frVI8nWvHO6p15RpIQAnQ81pLKM0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753977760; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CXpQvoH9jL/54pJyNmcqlS3Y6t709TK/3sP/jYyYCZU=; 
	b=NZyZzrXp0QdTzwxwKsCxIjIaiVVOA+no4R91yXoWdSxF0z/gyHj5/Gpjidw12oRfYSrdld3Yzur+XoJDWV9ZfNDjTkCXXsjngucvUvvrykcXVyW/yAXYwv+80v8ozhEpkkaUKJGM7OqeS8arsYYbWWHWniiSLhs950yL99WZQRg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753977760;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=CXpQvoH9jL/54pJyNmcqlS3Y6t709TK/3sP/jYyYCZU=;
	b=S1rC1MQyyVxUh5al7QzD/wEtVu0CmD2bLe+i9LKJ+7ptHaYzR0G48z6r+BrAVQW7
	jYiG5zrcVD4s2Lfc/fxvmu6Yth9ziyoLW5uiVmJVlmwAKFvZM2WY+t0wU4jbYoDkg5t
	7ThNDHHQcLZAZz6U2Oa5pA93JU1WwkDUolq7NmkI=
Received: by mx.zohomail.com with SMTPS id 1753977758262407.9841044700861;
	Thu, 31 Jul 2025 09:02:38 -0700 (PDT)
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
Subject: [PATCH v2 3/8] selftests: kselftest.h: Add __unused macro
Date: Thu, 31 Jul 2025 21:01:27 +0500
Message-Id: <20250731160132.1795351-4-usama.anjum@collabora.com>
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

Add __unused macro instead of using the complete verbose unused compiler
attribute. The raw __attribute__((__unused__)) is quite long and makes
code too much verbose to the kernel developer's taste.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/kselftest.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index c3b6d2604b1e4..8d17036d88396 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -92,6 +92,10 @@
 #endif
 #define __printf(a, b)   __attribute__((format(printf, a, b)))
 
+#ifndef __unused
+#define __unused         __attribute__((__unused__))
+#endif
+
 /* counters */
 struct ksft_count {
 	unsigned int ksft_pass;
-- 
2.39.5


