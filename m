Return-Path: <linux-kselftest+bounces-18400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6065987661
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 17:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70ED285E8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 15:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E121531EF;
	Thu, 26 Sep 2024 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYZgwxvY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32241531DB
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364059; cv=none; b=Qsn7y52t9RSeowb7kNQ6P8gyyc1JByOlYnpZvY2V7VbwZzU9zbT6qumpF1EU9TFmjVKIO398X5u0oVfosm38y+CT0sihgecuvRsEC+r4q3H1jW5xVM+wO+UAB0nGYPSFcUhva1JBHWU5XXvyTosE903eGRqIbcQy1RwCkMukfb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364059; c=relaxed/simple;
	bh=txWuXuILBv5S6sJcY8jEKBUNzgwD+nBQjS66HY/0zYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQTCEkfHY4rxNwSrocmCoKgHVwhpgDShcTYSLBC7j9BERRv7tEFvts220a+ZjXSgR3FshiMISX7BzwbWoMp6Eb8MZ0sI2PXM4Tkrja7kpGOjtvjpuH4CjpuHaopbbvpPZw9CP1dKDHeyEpWlcO08e6NFp2PyaAUeSQ1z7BFsJKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYZgwxvY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727364056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEU685hmTiGjO6vRfe2s3dQC7sd7dLb6c9biHu+eUc8=;
	b=cYZgwxvYFkqYW/I/Sdd0MU3zB8yIio3VM0/N6TaYxmEZRfDVwX9AuIgljR9o6uFsKXmcaK
	r+MatfWjlHCGli9m1ySOYd8r4XB230TDiL7XsxzFroCKSnHIxUvPPujj1JS47OKlP54hyC
	iSsHNtGsTaHtyIp7DSiBUzkOSEsVCgc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-e8N7HJqHNUW0sILja7qzCw-1; Thu,
 26 Sep 2024 11:20:54 -0400
X-MC-Unique: e8N7HJqHNUW0sILja7qzCw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3681B190FEFC;
	Thu, 26 Sep 2024 15:20:53 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.16.71])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C20001944D16;
	Thu, 26 Sep 2024 15:20:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Mario Casquero <mcasquer@redhat.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH v1 1/2] selftests/mm: hugetlb_fault_after_madv: use default hguetlb page size
Date: Thu, 26 Sep 2024 17:20:43 +0200
Message-ID: <20240926152044.2205129-2-david@redhat.com>
In-Reply-To: <20240926152044.2205129-1-david@redhat.com>
References: <20240926152044.2205129-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

We currently assume that the hugetlb page size is 2 MiB, which is
why we mmap() a 2 MiB range.

Is the default hugetlb size is larger, mmap() will fail because the
range is not suitable. If the default hugetlb size is smaller (e.g.,
s390x), mmap() will fail because we would need more than one hugetlb
page, but just asserted that we have exactly one.

So let's simply use the default hugetlb page size instead of hard-coded
2 MiB, so the test isn't unconditionally skipped on architectures like
s390x.

Before this patch on s390x:
$ ./hugetlb_fault_after_madv
	1..0 # SKIP Failed to allocated huge page

With this change on s390x:
	$ ./hugetlb_fault_after_madv

While at it, make "huge_ptr" static.

Reported-by: Mario Casquero <mcasquer@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../selftests/mm/hugetlb_fault_after_madv.c        | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
index 73b81c632366..ff3ba675278d 100644
--- a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
+++ b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
@@ -9,10 +9,10 @@
 #include "vm_util.h"
 #include "../kselftest.h"
 
-#define MMAP_SIZE (1 << 21)
 #define INLOOP_ITER 100
 
-char *huge_ptr;
+static char *huge_ptr;
+static size_t huge_page_size;
 
 /* Touch the memory while it is being madvised() */
 void *touch(void *unused)
@@ -30,7 +30,7 @@ void *madv(void *unused)
 	usleep(rand() % 10);
 
 	for (int i = 0; i < INLOOP_ITER; i++)
-		madvise(huge_ptr, MMAP_SIZE, MADV_DONTNEED);
+		madvise(huge_ptr, huge_page_size, MADV_DONTNEED);
 
 	return NULL;
 }
@@ -47,6 +47,10 @@ int main(void)
 
 	srand(getpid());
 
+	huge_page_size = default_huge_page_size();
+	if (!huge_page_size)
+		ksft_exit_skip("Could not detect default hugetlb page size.");
+
 	free_hugepages = get_free_hugepages();
 	if (free_hugepages != 1) {
 		ksft_exit_skip("This test needs one and only one page to execute. Got %lu\n",
@@ -54,7 +58,7 @@ int main(void)
 	}
 
 	while (max--) {
-		huge_ptr = mmap(NULL, MMAP_SIZE, PROT_READ | PROT_WRITE,
+		huge_ptr = mmap(NULL, huge_page_size, PROT_READ | PROT_WRITE,
 				MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
 				-1, 0);
 
@@ -66,7 +70,7 @@ int main(void)
 
 		pthread_join(thread1, NULL);
 		pthread_join(thread2, NULL);
-		munmap(huge_ptr, MMAP_SIZE);
+		munmap(huge_ptr, huge_page_size);
 	}
 
 	return KSFT_PASS;
-- 
2.46.1


