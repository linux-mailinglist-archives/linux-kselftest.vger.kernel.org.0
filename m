Return-Path: <linux-kselftest+bounces-3240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A916A8329CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 13:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49DCFB22C4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 12:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF81751C3D;
	Fri, 19 Jan 2024 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M51iYifA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8F43C470
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Jan 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669098; cv=none; b=cJKms+efRnYZOPDohsVIvM7K+RcYJ4PEQ/7UK2IfCSVh6RaBch+oyWb0haQmVWkdEyDo3ziNiRDJ7EJ+fOsNl6uyfM95zFH53wYZCRR4bGctFsUYn/W5sftk30MHO13TwQO3DPj2sEY9YRf36XPF81TKYhDedbz/YeSlcHbtnY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669098; c=relaxed/simple;
	bh=9oN8WEtKHa5I91ygCWQnS1mqKVl+6aTCIb+eEtvC21Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ab+GVKRAo5WspfCgJiEeybPcm5Lk6EyOJPRU87sxSKld+JQKCanRTaDjpbMXgpBrhpxYs5cM226pc5ltwmuq5luFL8kl5+FpryYb7ua4KzdycibGItSaBnftJgX/cVu9fpIv9H7B6bBKZdilS3T1xnQdfzKMUR5MR/mtYVwCQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M51iYifA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705669096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tSl8vraS51FiTpTDwvXe67q3UpTXFaFfY6Fu62WAl5w=;
	b=M51iYifAULJULUrki9vrbZfhZmY2sJddlgOm8ZrNJ2K2SONrSxUcEMiK5HgHdxuaywq1Ba
	WUlgn064jYBSZG2K7C97GLeDHF9tlmgsog6kzKEVNtw3VOqWr/WwxjUaLBtr+dHNZbIkgG
	ymiveC2z3+vAtu1xMz6qOSKi6r+cVsA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-56YpH6c8NtiCuO0XfASFRw-1; Fri, 19 Jan 2024 07:58:12 -0500
X-MC-Unique: 56YpH6c8NtiCuO0XfASFRw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AB5585A597;
	Fri, 19 Jan 2024 12:58:12 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.22.32.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A227DC1690E;
	Fri, 19 Jan 2024 12:58:11 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	shuah@kernel.org,
	donettom@linux.vnet.ibm.com
Subject: [PATCH] selftests: mm: fix map_hugetlb failure on 64K page size systems
Date: Fri, 19 Jan 2024 05:57:53 -0700
Message-ID: <20240119125753.152354-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On systems with 64k page size and 512M huge page sizes, the allocation
and test succeeds but errors out at the munmap. As the comment states,
munmap will failure if its not HUGEPAGE aligned. This is due to the
length of the mapping being 1/2 the size of the hugepage causing the
munmap to not be hugepage aligned. Fix this by making the mapping length
the full hugepage if the hugepage is larger than the length of the
mapping.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 tools/testing/selftests/mm/map_hugetlb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/mm/map_hugetlb.c b/tools/testing/selftests/mm/map_hugetlb.c
index 193281560b61..dcb8095fcd45 100644
--- a/tools/testing/selftests/mm/map_hugetlb.c
+++ b/tools/testing/selftests/mm/map_hugetlb.c
@@ -58,10 +58,16 @@ int main(int argc, char **argv)
 {
 	void *addr;
 	int ret;
+	size_t maplength;
 	size_t length = LENGTH;
 	int flags = FLAGS;
 	int shift = 0;
 
+	maplength = default_huge_page_size();
+	/* mmap with fail if the length is not page */
+	if (maplength > length)
+		length = maplength;
+
 	if (argc > 1)
 		length = atol(argv[1]) << 20;
 	if (argc > 2) {
-- 
2.43.0


