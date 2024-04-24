Return-Path: <linux-kselftest+bounces-8823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7E28B165E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 00:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B959D1F240EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 22:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EBA16E873;
	Wed, 24 Apr 2024 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QE8pAFFH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DDE16D9AF
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998680; cv=none; b=TShmEgWxLI8/KxaSGYdyVvXqBsJYJgApbXJfHavkf7wi6w7d+0ZLvHD/qlcC9vu0/V0Z6OwGpmp/C/4Tb4mF5K79Y0BJagFhgTorp9ZlP3cBoFnGHe1Hgq3/Rh1mqbocZVuliQQNQYewZ09fo9ScmTnuUD5JIgWNaPocrUTNLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998680; c=relaxed/simple;
	bh=nNdamjmTjT8cwo6W3kCWm+1dZIV0BkTnEcpD6tnN4Qg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y5vb4cG8Cq4CfZ/J2J4JK4+8Tg+QwMTfUpvxgUpMuzxrZGbgOOrFtxdu5OJJR0y13LVFo/eg8pEpx7dE8Y8zbKqBtaG4Hl12z+Q5QC4+VqxH9fsKXvJFU4rgfBQf4kJbXOuQOz0Y06ZOvZuSCTxjnNsX2skPx/PSwprfcxj/5Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QE8pAFFH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713998678; x=1745534678;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nNdamjmTjT8cwo6W3kCWm+1dZIV0BkTnEcpD6tnN4Qg=;
  b=QE8pAFFH4QfDMAeV5WMdxW3+vyNrZoL/egKpXu+VeqncdeHhmeSHBPO/
   ahcBBsVJAJH6wJyAyURaqqr538AHA/M38sPr/rKDq6tY0maA1UdK226a2
   XXccsJFc1Uia+WxbnKu5w+UJP1FnCjzbxz7aHpQUUIIAxdM5y6TwWdZXb
   QobMyFtpqyG2g4BjePOMZz5Ghhe9elVk22JUZvIGGRln6JJvB2yo4a5u8
   z6iQdwnkbHQb+RqybJa57g6wQvbPAwLKEuePgm6LPskXyxLS66px229fz
   bUEYq8Ap3fba1rkqVk137QpgiXX8X/5nR3FKknA9JMTDIbpEQkptNKzKW
   w==;
X-CSE-ConnectionGUID: ioRebes6Qp2Xp/WbW/Fweg==
X-CSE-MsgGUID: 5gwgdC65SPawCxUXz4P/Ng==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9821349"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9821349"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 15:44:38 -0700
X-CSE-ConnectionGUID: De836+7kQcCSP24Dk5Kj7w==
X-CSE-MsgGUID: yHJQaAdhQGGp7SEp/zoqxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="29647931"
Received: from gnr-001.sh.intel.com ([10.112.230.245])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 15:44:37 -0700
From: Dongsheng Zhang <dongsheng.x.zhang@intel.com>
To: linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] KVM: selftests: Fix nx_huge_pages_test for default_hugepagesz=1G
Date: Thu, 25 Apr 2024 06:44:33 +0800
Message-ID: <20240424224434.14166-1-dongsheng.x.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: donsheng <dongsheng.x.zhang@intel.com>

If the host was booted with the "default_hugepagesz=1G" kernel command-line
parameter, running the NX hugepage test will fail with error "Invalid argument"
at the TEST_ASSERT line in kvm_util.c's __vm_mem_region_delete() function:
static void __vm_mem_region_delete(struct kvm_vm *vm,
                   struct userspace_mem_region *region,
                   bool unlink)
{
    int ret;
    ...
    ret = munmap(region->mmap_start, region->mmap_size);
    TEST_ASSERT(!ret, __KVM_SYSCALL_ERROR("munmap()", ret));
    ...
}

NX hugepage test creates a VM with a data slot of 6M size backed with huge
pages. If the default hugetlb page size is set to 1G, calling mmap() with
MAP_HUGETLB and a length of 6M will succeed but calling its matching munmap()
will fail. Documentation/admin-guide/mm/hugetlbpage.rst specifies this behavior:

"Syscalls that operate on memory backed by hugetlb pages only have their lengths
aligned to the native page size of the processor; they will normally fail with
errno set to EINVAL or exclude hugetlb pages that extend beyond the length if
not hugepage aligned.  For example, munmap(2) will fail if memory is backed by
a hugetlb page and the length is smaller than the hugepage size."

Explicitly use MAP_HUGE_2MB in conjunction with MAP_HUGETLB to fix the issue.

Signed-off-by: donsheng <dongsheng.x.zhang@intel.com>
Suggested-by: Zide Chen <zide.chen@intel.com>
---
 tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
index 17bbb96fc4df..146e9033e206 100644
--- a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
+++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
@@ -129,7 +129,7 @@ void run_test(int reclaim_period_ms, bool disable_nx_huge_pages,
 
 	vcpu = vm_vcpu_add(vm, 0, guest_code);
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS_HUGETLB,
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS_HUGETLB_2MB,
 				    HPAGE_GPA, HPAGE_SLOT,
 				    HPAGE_SLOT_NPAGES, 0);
 
-- 
2.43.0


