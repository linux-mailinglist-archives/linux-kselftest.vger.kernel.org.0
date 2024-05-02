Return-Path: <linux-kselftest+bounces-9258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE988B96E1
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 10:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74208281121
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 08:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B2146556;
	Thu,  2 May 2024 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCfVLmRq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B47843AB3
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639987; cv=none; b=sKem49S6aIbQJ9ufQtFkWYUbhWVaiWsnQRUOmkUVxS+OaZE/5yC3ReqoKZngKQZEZSUik18GY56coF5u9bETFgpaOe4DiC7aiIy4J33gtAB/joEcd6nRMlfaZoQl0quaG5M3VwxJqO8CLKVdfC5w4KQ46j6YZyRoP06hWhe4Gzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639987; c=relaxed/simple;
	bh=LEOOwhiOIcvRQi9Cb1d0MWZ04FF4u1rqzdfIYJBWXW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OUeaOGlWZltPXr5GNeWvnzuuhovzBqn+t/L7IBK2qwBWRyNi7NeG11p+qHanX4G4cuVcDvaq4hJ587/oCmEJxHFBG0Q0RGkzd01CyA5YnODWL66xb7/8MIurBEsFptRf+p7RZa8XiP0zkM+1GLnkaiwwaXTzLr7ySfHn3wS14jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCfVLmRq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714639985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NR4F1yCnaHMzo+jYRRQjO/m7l+e0Gwyie6VNrB5gst4=;
	b=SCfVLmRqNHFs1JGM5E/Fs1e/tm9V3O5CbuRnhIBEbcqkXZExNisEL9DviV5ywMGGxnDORH
	FpuQ2BCoqV7HdMjYmdqpOn8HhfymT4i1kdHDB0HONJfL8TTuHljDVHIf0x6uJXNDpC+NQh
	DmB0z4n9T4Ig3McJPXZazxmiLyuKjCU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-_IBEBEYFPGCCtQ-Rix5efA-1; Thu, 02 May 2024 04:53:02 -0400
X-MC-Unique: _IBEBEYFPGCCtQ-Rix5efA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22905830D37;
	Thu,  2 May 2024 08:53:02 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.224])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 12B1C40ED31;
	Thu,  2 May 2024 08:52:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1 0/2] selftests: mm: cow: flag vmsplice() hugetlb tests as XFAIL
Date: Thu,  2 May 2024 10:52:57 +0200
Message-ID: <20240502085259.103784-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

The failing hugetlb vmsplice() COW tests keep confusing people, and
having tests that have been failing for years and likely will keep failing
for years to come because nobody cares enough is rather suboptimal. Let's
mark them as XFAIL and document why fixing them is not that easy as
it would appear at first sight.

More details can be found in [1], especially around how hugetlb pages
cannot really be overcommitted, and why we don't particularly care about
these vmsplice() leaks for hugetlb -- in contrast to ordinary memory.

[1] https://lore.kernel.org/all/8b42a24d-caf0-46ef-9e15-0f88d47d2f21@redhat.com/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Shuah Khan <shuah@kernel.org>

David Hildenbrand (2):
  selftests: mm: cow: flag vmsplice() hugetlb tests as XFAIL
  mm/hugetlb: document why hugetlb uses folio_mapcount() for COW reuse
    decisions

 mm/hugetlb.c                     |   7 ++
 tools/testing/selftests/mm/cow.c | 106 +++++++++++++++++++++----------
 2 files changed, 78 insertions(+), 35 deletions(-)

-- 
2.44.0


