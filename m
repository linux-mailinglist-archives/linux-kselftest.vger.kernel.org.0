Return-Path: <linux-kselftest+bounces-34785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFD4AD664B
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 05:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0D43AD25B
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 03:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022E21CD215;
	Thu, 12 Jun 2025 03:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nggY2ap/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3065F1A5B92;
	Thu, 12 Jun 2025 03:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700481; cv=none; b=lt87LuZ/XpFiVAJ7GEmBLbe8Wteh/lIsKAy072n0ZFrb95h5pcgmqZ0uiarkr/1PCr50mouo/QhHp6WFuRYrim9ZolGAOLhgqZPLZRldOWH/sjN3ILyB7REf/2sriZoEkleF3pUXMQKI8L7QC7+4LGePHGO88WAE0JcmCQx5eME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700481; c=relaxed/simple;
	bh=0qO1I6eQHyLDxt28LjGMWfn3ucClxQYRzRmbAjICYbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hzQjRKE0vLM9fnkSZ9MdiiyrWHpSoxXxOTVtxk6RBUKrb7z1sjc2/Mp5yp8WWCo4RZrV4t+z8s+CUeHPJmU0BedDvJwZYAmFvDr5OkfSq4F+uhAd7Y3xNfdAA8zVJsUbbn0ZfUjS4y1E/WO87aVjRD4DLpXQLkUO745/Lnut3Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nggY2ap/; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749700471; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vhGiq7rkvYoNNdtNkWO+TZlRxj9/2gW4OzFoq6S0qAk=;
	b=nggY2ap/va7ZeHAr45Mq/i5OTGWWYaOf1lfnzGRAfbzbALglPMV9FXLePEYIJkOcDQv1IBxn2t8gH86hJzaTIZ4hXtFOt0NvNTYhb0vt/hWH7m2OoVtnPPBnPQeb2PsRVbLANak2/1+Kmb9q9ZNw/HIGb7UQcx1d0e6hPQvrpBE=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WdfRnw6_1749700469 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Jun 2025 11:54:30 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	david@redhat.com
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	shuah@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests: khugepaged: fix the shmem collapse failure
Date: Thu, 12 Jun 2025 11:54:20 +0800
Message-ID: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running the khugepaged selftest for shmem (./khugepaged all:shmem),
I encountered the following test failures:
"
Run test: collapse_full (khugepaged:shmem)
Collapse multiple fully populated PTE table.... Fail
...
Run test: collapse_single_pte_entry (khugepaged:shmem)
Collapse PTE table with single PTE entry present.... Fail
...
Run test: collapse_full_of_compound (khugepaged:shmem)
Allocate huge page... OK
Split huge page leaving single PTE page table full of compound pages... OK
Collapse PTE table full of compound pages.... Fail
"

The reason for the failure is that, it will set MADV_NOHUGEPAGE to prevent
khugepaged from continuing to scan shmem VMA after khugepaged finishes
scanning in the wait_for_scan() function. Moreover, shmem requires a refault
to establish PMD mappings.

However, after commit 2b0f922323cc, PMD mappings are prevented if the VMA is
set with MADV_NOHUGEPAGE flag, so shmem cannot establish PMD mappings during
refault.

To fix this issue, we can set the MADV_NOHUGEPAGE flag after the shmem refault.
With this fix, the shmem test case passes.

Fixes: 2b0f922323cc ("mm: don't install PMD mappings when THPs are disabled by the hw/process/vma")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 tools/testing/selftests/mm/khugepaged.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 8a4d34cce36b..d462f62d8116 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -561,8 +561,6 @@ static bool wait_for_scan(const char *msg, char *p, int nr_hpages,
 		usleep(TICK);
 	}
 
-	madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
-
 	return timeout == -1;
 }
 
@@ -585,6 +583,7 @@ static void khugepaged_collapse(const char *msg, char *p, int nr_hpages,
 	if (ops != &__anon_ops)
 		ops->fault(p, 0, nr_hpages * hpage_pmd_size);
 
+	madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
 	if (ops->check_huge(p, expect ? nr_hpages : 0))
 		success("OK");
 	else
-- 
2.43.5


