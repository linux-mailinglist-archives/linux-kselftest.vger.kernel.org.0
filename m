Return-Path: <linux-kselftest+bounces-40624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB4EB40A85
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 18:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD7E5E3D3E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3813C3375DA;
	Tue,  2 Sep 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTQEhxIp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929322DFF12
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830351; cv=none; b=FbEni5vE25VzPkHQTP5YUfEHWc2EtJYEVHT2yCRYZYl0tKUOWZzkGKOwI+xBw8gRWsfKkwE/Kp8C9NZxJlrsnpH1q0CDyS8Lau3FNPWHPMkMpS2AUl8K4wrsNaf3d6Bwybi2GramwGEvccVPQgtOu/sQHEIewsSXlzOHIGcx+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830351; c=relaxed/simple;
	bh=EbHkox18YVqu4d1wwTFPqoPxl1p+eVLhgTprkFJEzAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CrblJGl+502aYgSjpldG8JJirO24mwhniKHg86WXEBW6XHoFzQAyLcKpFjneIFg7FGOa+GnMAXM/SSdMvaT6eOPrZOT2qq1bRzToPBWnSM+7NXaYi6lfm8iSGXcyeJc897tA5bIU2evH60X+J9VllMS+9pXFqijGZzEXTNHm820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTQEhxIp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756830348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SUik/jyyQ1k9liiWuKi+y+woyh+KAPCpYTGPEAo73+c=;
	b=BTQEhxIpqjrYuMvKXCe6i4gROHdcTRg9gI2/NKQLxXqRmQsoo9K1US+xlnXDD9vz4HMkAm
	MNCpVSQAQb5KDz/HdH2yAq9gTNq8cgf27UhEEWv8bVDEtPuhktcBpKgq0reuyJCCdRoRza
	uwJDJ2GVEZSSmWeOowxLVepbaOwZ6lY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-tMtwTW8sMByXxpPUBno_fg-1; Tue,
 02 Sep 2025 12:25:45 -0400
X-MC-Unique: tMtwTW8sMByXxpPUBno_fg-1
X-Mimecast-MFC-AGG-ID: tMtwTW8sMByXxpPUBno_fg_1756830343
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 293A518003FC;
	Tue,  2 Sep 2025 16:25:43 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.80.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE9FC300019F;
	Tue,  2 Sep 2025 16:25:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v2 0/2] selftests/mm: split_huge_page_test: split_pte_mapped_thp improvements
Date: Tue,  2 Sep 2025 18:25:34 +0200
Message-ID: <20250902162536.956465-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

One fix for occasional failures I found while testing and a bunch of
cleanups that should make that test easier to digest.

Tested on x86-64, the test seems to reliably pass.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>

David Hildenbrand (2):
  selftests/mm: split_huge_page_test: fix occasional
    is_backed_by_folio() wrong results
  selftests/mm: split_huge_page_test: cleanups for split_pte_mapped_thp
    test

 .../selftests/mm/split_huge_page_test.c       | 138 ++++++++++--------
 1 file changed, 81 insertions(+), 57 deletions(-)


base-commit: b73c6f2b5712809f5f386780ac46d1d78c31b2e6
-- 
2.50.1


