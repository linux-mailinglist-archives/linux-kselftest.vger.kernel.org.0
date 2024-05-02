Return-Path: <linux-kselftest+bounces-9260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E298B96E5
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 10:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C489828292D
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 08:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FB253373;
	Thu,  2 May 2024 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDgTxs/P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB07524B8
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639992; cv=none; b=huFo3NhF/Eik+M2wmfPrKnhB6bpK+p8s3F8Zlz2PHkGqOmKQTOv5VX2JgZdxyWkNyyZ4i6RXfihqdW3lv8RjGDd2cigzym3TKDnf2vPAor6G2em7bz+C1oj92EBT9PaJOGGCUq2mLMQDxD6j77RDFuf+0CgPNlkdkTWC34eLg/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639992; c=relaxed/simple;
	bh=2P0XQ3f/nErLPEazYra6MFwog6B2HmsLDNWBea6YiYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYmxW8LHu/6NH4r58CouNylNYnXMtUErApGtD9J6ccljhx6r1TpnkvzES9qS2zyAGtgeujBJyOjTKn4GKQmVGuf+lQJ4fMt8mkzFW4iKkyI+jRAYbUE5Yl7sHoe5v/n6TAMh27aBgJUujKNq6Oi2ItGZzNF1DD2pFvvGvp4A3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDgTxs/P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714639990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T0uhogWZMK2FCWUvbV0NVhLRqNmBD8nexNysXl5gy1w=;
	b=bDgTxs/P2/76qrH/X++uUJ8cvSOdBxWxNU03Xk2kOBUNGlN4PcyekdWuBgWopvrtsTUkFq
	TLaXXxjICKFN+x+v94bL+nqjw2iz7vfCmWQ4DZkH/91qsgHkkotXX4td97pQxw/4nZW2pe
	EmdzUj3Sc35Y38FNX//UE/jidCs6u7E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-rpnWT_B-O0-ApCVzbzjOLA-1; Thu, 02 May 2024 04:53:07 -0400
X-MC-Unique: rpnWT_B-O0-ApCVzbzjOLA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D9B6811029;
	Thu,  2 May 2024 08:53:06 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.224])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8ED1A40ED2F;
	Thu,  2 May 2024 08:53:04 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 2/2] mm/hugetlb: document why hugetlb uses folio_mapcount() for COW reuse decisions
Date: Thu,  2 May 2024 10:52:59 +0200
Message-ID: <20240502085259.103784-3-david@redhat.com>
In-Reply-To: <20240502085259.103784-1-david@redhat.com>
References: <20240502085259.103784-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Let's document why hugetlb still uses folio_mapcount() and is prone to
leaking memory between processes, for example using vmsplice() that
still uses FOLL_GET.

More details can be found in [1], especially around how hugetlb pages
cannot really be overcommitted, and why we don't particularly care about
these vmsplice() leaks for hugetlb -- in contrast to ordinary memory.

[1] https://lore.kernel.org/all/8b42a24d-caf0-46ef-9e15-0f88d47d2f21@redhat.com/

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 417fc5cdb6eeb..a7efb350f5d07 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5963,6 +5963,13 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	/*
 	 * If no-one else is actually using this page, we're the exclusive
 	 * owner and can reuse this page.
+	 *
+	 * Note that we don't rely on the (safer) folio refcount here, because
+	 * copying the hugetlb folio when there are unexpected (temporary)
+	 * folio references could harm simple fork()+exit() users when
+	 * we run out of free hugetlb folios: we would have to kill processes
+	 * in scenarios that used to work. As a side effect, there can still
+	 * be leaks between processes, for example, with FOLL_GET users.
 	 */
 	if (folio_mapcount(old_folio) == 1 && folio_test_anon(old_folio)) {
 		if (!PageAnonExclusive(&old_folio->page)) {
-- 
2.44.0


