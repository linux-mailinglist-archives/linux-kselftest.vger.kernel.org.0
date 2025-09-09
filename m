Return-Path: <linux-kselftest+bounces-41018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB424B4A1DA
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191191891CFE
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 06:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89812550CA;
	Tue,  9 Sep 2025 06:15:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C32302166;
	Tue,  9 Sep 2025 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398557; cv=none; b=S2uxU335MZ8fspwjNmJvKbV/UYaGZV5kHna61Szez3CDblB0U5X/vY3ukYBqElVIxzuS5qibHByKPUNRcxu54StRQRjO6ahgJ1lzUw9442eBlpKn4duji8/89rHTJvLgInGfc+N7P4TK+yRUaZ8HiIWpI1w9KaVZynBiVNjhhMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398557; c=relaxed/simple;
	bh=QzIcuS2t8tEQAmmj74shO4l4o7K0JZ82raaDhQi9Lxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Inbft4+rFJs28Ep8WWQG2h7yao14vR10DlEtbuNPtOI0Bo6BDF50hs2DXbj0XH7avDSoIRHnNPhtZCwdBJbm2QknMzVdykVm/fApLafmDx+2oMiFsaW68KgPkqgVeM1hWYLFnvZyZzncxu58IG41UHgvvOtNswav8V85t9cTX4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A77DF1655;
	Mon,  8 Sep 2025 23:15:46 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D8D2D3F66E;
	Mon,  8 Sep 2025 23:15:50 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	shuah@kernel.org
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v2 1/2] selftests/mm/uffd-stress: make test operate on less hugetlb memory
Date: Tue,  9 Sep 2025 11:45:29 +0530
Message-Id: <20250909061531.57272-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909061531.57272-1-dev.jain@arm.com>
References: <20250909061531.57272-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We observed uffd-stress selftest failure on arm64 and intermittent failures
on x86 too:
running ./uffd-stress hugetlb-private 128 32

bounces: 17, mode: rnd read, ERROR: UFFDIO_COPY error: -12 (errno=12, @uffd-common.c:617) [FAIL]
not ok 18 uffd-stress hugetlb-private 128 32 # exit=1

For this particular case, the number of free hugepages from run_vmtests.sh
will be 128, and the test will allocate 64 hugepages in the source
location. The stress() function will start spawning threads which will
operate on the destination location, triggering uffd-operations like
UFFDIO_COPY from src to dst, which means that we will require 64 more
hugepages for the dst location.

Let us observe the locking_thread() function. It will lock the mutex kept
at dst, triggering uffd-copy. Suppose that 127 (64 for src and 63 for dst)
hugepages have been reserved. In case of BOUNCE_RANDOM, it may happen that
two threads trying to lock the mutex at dst, try to do so at the same
hugepage number. If one thread succeeds in reserving the last hugepage,
then the other thread may fail in alloc_hugetlb_folio(), returning -ENOMEM.
I can confirm that this is indeed the case by this hacky patch:

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 753f99b4c718..39eb21d8a91b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6929,6 +6929,11 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 
 		folio = alloc_hugetlb_folio(dst_vma, dst_addr, false);
 		if (IS_ERR(folio)) {
+			pte_t *actual_pte = hugetlb_walk(dst_vma, dst_addr, PMD_SIZE);
+			if (actual_pte) {
+				ret = -EEXIST;
+				goto out;
+			}
 			ret = -ENOMEM;
 			goto out;
 		}

This code path gets triggered indicating that the PMD at which one thread
is trying to map a hugepage, gets filled by a racing thread.

Therefore, instead of using freepgs to compute the amount of memory,
use freepgs - (min(32, nr_cpus) - 1), so that the test still has some extra
hugepages to use. The adjustment is a function of min(32, nr_cpus) - the
value of nr_parallel in the test - because in the worst case, nr_parallel
number of threads will try to map a hugepage on the same PMD, one will
win the allocation race, and the other nr_parallel - 1 threads will fail,
so we need extra nr_parallel - 1 hugepages to satisfy this request.
Note that, in case the adjusted value underflows, there is a check for
the number of free hugepages in the test itself, which will fail:
get_free_hugepages() < bytes / page_size
A negative value will be passed on to bytes which is of type size_t, thus
the RHS will become a large value and the check will fail,
so we are safe.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 471e539d82b8..b9c73ef81c03 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -322,11 +322,15 @@ CATEGORY="gup_test" run_test ./gup_longterm
 CATEGORY="userfaultfd" run_test ./uffd-unit-tests
 uffd_stress_bin=./uffd-stress
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon 20 16
-# Hugetlb tests require source and destination huge pages. Pass in half
-# the size of the free pages we have, which is used for *each*.
+# Hugetlb tests require source and destination huge pages. Pass in almost half
+# the size of the free pages we have, which is used for *each*. An adjustment
+# of (nr_parallel - 1) is done (see nr_parallel in uffd-stress.c) to have some
+# extra hugepages - this is done to prevent the test from failing by racily
+# reserving more hugepages than strictly required.
 # uffd-stress expects a region expressed in MiB, so we adjust
 # half_ufd_size_MB accordingly.
-half_ufd_size_MB=$(((freepgs * hpgsize_KB) / 1024 / 2))
+adjustment=$(( (31 < (nr_cpus - 1)) ? 31 : (nr_cpus - 1) ))
+half_ufd_size_MB=$((((freepgs - adjustment) * hpgsize_KB) / 1024 / 2))
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb "$half_ufd_size_MB" 32
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb-private "$half_ufd_size_MB" 32
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem 20 16
-- 
2.30.2


