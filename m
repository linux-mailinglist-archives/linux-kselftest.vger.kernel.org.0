Return-Path: <linux-kselftest+bounces-40102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C00EB38DB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A95B165A71
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 22:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676DE35336C;
	Wed, 27 Aug 2025 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QajM0bXl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A461831A54B
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332602; cv=none; b=CkcK6+1AJbMir/4yPNwwNFUQPI6M593oqmtRGfQka4O+xq2D1k7LufnVAwqMxGr9SZD0oUkEwBcaw08LJ2riyhY97YBI1QqhIUplN3oGJNxF1khtBFcGRwzTHDuT7eMa363Slu7pgAKtSaZtX+YIU6v1ih7P20xwbdUpDV8vv14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332602; c=relaxed/simple;
	bh=N1v9UA/QRYGQm6CSj/DvrAk3dhh2ai3p0H8BW+jGGK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPPKcU1nPuf/yskrGkD9bEP630QQEGiB2INYeo9sBRZkFm4bKLJmnXlOumRxTqH3XnI5V7CL4ALZWUOzWucYTm2Lamxkc5Jr5VrDI7oznXJ4JT9yDUgiBUu/IHNT/hJ5SEwCjOKfG5VJcDbNuxYFwn2m/QRTFwmVgQVOF2FN0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QajM0bXl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756332599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXg5sKb3LQ8Ovlzb+xXgvQsFzOeAfDPZ/pDh6HDj700=;
	b=QajM0bXlffMDJHwtTs/crVCo49dahvKkoF6bIhsP3f17ai/hWTQhzd8Z5fUP1hGd5/wP2T
	QmQMkb7GfqiSWAkVfCJpi8Sz9/udvA5KTRmeovdfI3nO9czIyQQKx21Siv9Ii7NSSO+8l3
	ArIZ4RGg4QYZfE4qukzyTnjUVzCKht8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-6glRl4KNPgiaFeNg7_zkYg-1; Wed,
 27 Aug 2025 18:09:55 -0400
X-MC-Unique: 6glRl4KNPgiaFeNg7_zkYg-1
X-Mimecast-MFC-AGG-ID: 6glRl4KNPgiaFeNg7_zkYg_1756332590
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F370918002C4;
	Wed, 27 Aug 2025 22:09:49 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.80.195])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9186830001A1;
	Wed, 27 Aug 2025 22:09:33 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
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
Subject: [PATCH v1 27/36] memstick: drop nth_page() usage within SG entry
Date: Thu, 28 Aug 2025 00:01:31 +0200
Message-ID: <20250827220141.262669-28-david@redhat.com>
In-Reply-To: <20250827220141.262669-1-david@redhat.com>
References: <20250827220141.262669-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

It's no longer required to use nth_page() when iterating pages within a
single SG entry, so let's drop the nth_page() usage.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/memstick/host/jmb38x_ms.c | 3 +--
 drivers/memstick/host/tifm_ms.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index cddddb3a5a27f..79e66e30417c1 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -317,8 +317,7 @@ static int jmb38x_ms_transfer_data(struct jmb38x_ms_host *host)
 		unsigned int p_off;
 
 		if (host->req->long_data) {
-			pg = nth_page(sg_page(&host->req->sg),
-				      off >> PAGE_SHIFT);
+			pg = sg_page(&host->req->sg) + (off >> PAGE_SHIFT);
 			p_off = offset_in_page(off);
 			p_cnt = PAGE_SIZE - p_off;
 			p_cnt = min(p_cnt, length);
diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
index db7f3a088fb09..0b6a90661eee5 100644
--- a/drivers/memstick/host/tifm_ms.c
+++ b/drivers/memstick/host/tifm_ms.c
@@ -201,8 +201,7 @@ static unsigned int tifm_ms_transfer_data(struct tifm_ms *host)
 		unsigned int p_off;
 
 		if (host->req->long_data) {
-			pg = nth_page(sg_page(&host->req->sg),
-				      off >> PAGE_SHIFT);
+			pg = sg_page(&host->req->sg) + (off >> PAGE_SHIFT);
 			p_off = offset_in_page(off);
 			p_cnt = PAGE_SIZE - p_off;
 			p_cnt = min(p_cnt, length);
-- 
2.50.1


