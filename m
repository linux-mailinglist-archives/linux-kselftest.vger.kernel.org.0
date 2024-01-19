Return-Path: <linux-kselftest+bounces-3243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9BD832A29
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 14:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4F51F21B60
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 13:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66D7524DC;
	Fri, 19 Jan 2024 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSN1zpzZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28174BABE
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Jan 2024 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670085; cv=none; b=KheXgn1MiYSZW1iGrUSfna+lNgIuEvQc4LfFl8s8J4xvFFr3PG1QXRbDudq/aaa2ugux2iXb7luVYTO9JIQb4zARn3PnsKETUEk7o0XzpziUPZittJgODDZStIdZtRBl0wjtmk9JU217NlgDqojzXeiIWMTl8Fn18qSEGgBbNXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670085; c=relaxed/simple;
	bh=Yd8Hfv3YoXkOkWdBGQbqAsfi6VWsPeqx8i7E6nlEngk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvJtvAD/7Kw//kAoST7yrNWZJvZobviarKK0Xm6vXOdDN6IXZn/V50U6vigd65IpebptfMGJ1zQc1wDnjcMQvrQ9HK4qfCR1wxRh0FAuOHMLovlOTWbPEjOB+eFvqkpHSmRpQgYxuIbiK/Uug7RmhPFR/zEWpxAlApS2ThdL/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSN1zpzZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705670082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FMCcNkW+birNtx8xk197SfIjTJCrWWEkNPF60sBeOCI=;
	b=dSN1zpzZtzCKSrtGs9JnvjylOLcsMpVeCS7xMCJn8VteixadiV66E25Q9YpufTBx72zwdh
	drGxPyQ2fFiuRvOJIa1IM6Ei5B6kOgYj5kTNaV/e0QoGcz0XkfbvsBzy3EK/NVKP0mbXO1
	VRSV7dl+k+gq8KGOz+i3GM86y1RUuuU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217--TNxNdLxPgGuY0vHTURHIQ-1; Fri, 19 Jan 2024 08:14:39 -0500
X-MC-Unique: -TNxNdLxPgGuY0vHTURHIQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7F93185A788;
	Fri, 19 Jan 2024 13:14:38 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.22.32.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6286C51D5;
	Fri, 19 Jan 2024 13:14:38 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	shuah@kernel.org,
	donettom@linux.vnet.ibm.com
Subject: [PATCH v2] selftests: mm: fix map_hugetlb failure on 64K page size systems
Date: Fri, 19 Jan 2024 06:14:29 -0700
Message-ID: <20240119131429.172448-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On systems with 64k page size and 512M huge page sizes, the allocation
and test succeeds but errors out at the munmap. As the comment states,
munmap will failure if its not HUGEPAGE aligned. This is due to the
length of the mapping being 1/2 the size of the hugepage causing the
munmap to not be hugepage aligned. Fix this by making the mapping length
the full hugepage if the hugepage is larger than the length of the
mapping.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 tools/testing/selftests/mm/map_hugetlb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/mm/map_hugetlb.c b/tools/testing/selftests/mm/map_hugetlb.c
index 193281560b61..86e8f2048a40 100644
--- a/tools/testing/selftests/mm/map_hugetlb.c
+++ b/tools/testing/selftests/mm/map_hugetlb.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
+#include "vm_util.h"
 
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
@@ -58,10 +59,16 @@ int main(int argc, char **argv)
 {
 	void *addr;
 	int ret;
+	size_t hugepage_size;
 	size_t length = LENGTH;
 	int flags = FLAGS;
 	int shift = 0;
 
+	hugepage_size = default_huge_page_size();
+	/* munmap with fail if the length is not page aligned */
+	if (hugepage_size > length)
+		length = hugepage_size;
+
 	if (argc > 1)
 		length = atol(argv[1]) << 20;
 	if (argc > 2) {
-- 
2.43.0


