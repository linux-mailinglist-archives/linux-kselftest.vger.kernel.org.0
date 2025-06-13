Return-Path: <linux-kselftest+bounces-34856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE24AD807A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 03:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73083A47AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 01:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B901E0DD8;
	Fri, 13 Jun 2025 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dnPFu5Gi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED221DFD96;
	Fri, 13 Jun 2025 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749779382; cv=none; b=oEVoZDKBTsj0yVwErb8mLP2i2L7+RhT2/vLu4rDC7/+iU6QDs2dZ3rUwvOm5W/6HzoshZIOXEf8xCFyywV8zm/bEaug5MICmaTmDkzpWKvGOVClwbBLS2tDwIZVU+k99+LZwIPNKZLTyaLY46u3Xk8Ec4pXOvfQ9Iglp12H54Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749779382; c=relaxed/simple;
	bh=tZEWVSv372VA7rjweAEWTCSBnCTvaH5PrhFFxQbZb/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKUDw1etXywsDA0XJR0qp3GyKLchPMq75cOQd+x3Q7VK+ir3Q0gHvmgSOCXdkP7xs7JepHQdLzf1qvhIRIzsma26JD2/5ql2tytQEGznfWTbW8pQ4ovj574/8OQVoVdZupBnETpxfCZHYqZYvxQzIbB+ACWWgIHLaPrp8veuUAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dnPFu5Gi; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749779370; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=r6nZuF5tTb5TGTQTMpuco3jv+ToYoP7IRA14ag7htuk=;
	b=dnPFu5GiVCIWNn+bw5ixdxjiVcw3Z6HgHdRhiftm4hKlokZTxHT3JxlA7w/h/8ra3j32C5bkJfxxb2JkM4hbCHumbuHk9s+gcyitEhwsFY1vjBd7zZ22lUW9wND58S3EjcSusZ+OEwZVyktFKD1BIztp203VLhSHfGELDpME4BI=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WdiYSo7_1749779369 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Jun 2025 09:49:30 +0800
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
Subject: [PATCH v2 1/2] selftests: khugepaged: fix the shmem collapse failure
Date: Fri, 13 Jun 2025 09:49:19 +0800
Message-ID: <d8502fc50d0304c2afd27ced062b1d636b7a872e.1749779183.git.baolin.wang@linux.alibaba.com>
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

However, after commit 2b0f922323cc ("mm: don't install PMD mappings when
THPs are disabled by the hw/process/vma"), PMD mappings are prevented if the
VMA is set with MADV_NOHUGEPAGE flag, so shmem cannot establish PMD mappings
during refault.

One way to fix this issue is to move the MADV_NOHUGEPAGE setting after the
shmem refault. After shmem refault and check huge, the test case will unmap
the shmem immediately. So it seems unnecessary to set the MADV_NOHUGEPAGE.

Then we can simply drop the MADV_NOHUGEPAGE setting, and all khugepaged test
cases passed.

Fixes: 2b0f922323cc ("mm: don't install PMD mappings when THPs are disabled by the hw/process/vma")
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v1:
 - Add reviewed tag from Zi. Thanks.
 - Drop the MADV_NOHUGEPAGE setting, per David.
---
 tools/testing/selftests/mm/khugepaged.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 8a4d34cce36b..4341ce6b3b38 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -561,8 +561,6 @@ static bool wait_for_scan(const char *msg, char *p, int nr_hpages,
 		usleep(TICK);
 	}
 
-	madvise(p, nr_hpages * hpage_pmd_size, MADV_NOHUGEPAGE);
-
 	return timeout == -1;
 }
 
-- 
2.43.5


