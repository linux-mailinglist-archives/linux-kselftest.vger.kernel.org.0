Return-Path: <linux-kselftest+bounces-8824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AD28B165F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 00:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEBF81F23D4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 22:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A8C16E878;
	Wed, 24 Apr 2024 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gT2Oe6HP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D28616DEDE
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998681; cv=none; b=MT0CCjJuc6yw948AIF1W3iwv46dp3z0C0KCQ5LTp+Zpu1L8gBefAXQD+TgXZA8DGFS415mQOtn13EUEKyzGJEmzi6eSbE4IkCRLTfbNIkHkZhodPtO8ABjfd6Br2J3zWeMCmBiAoJA5/Z97odWoOUm4+SioFbrnkyOm5fffnWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998681; c=relaxed/simple;
	bh=DmC2o0bH2ZycsH1BkNpAJFPKVv6GVkR7uN7efgPshq0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMEPSKfGTJvgdFOvEmhRYDhtUpqSZ5OfW94zg0a9o2hOLxCBrW4SI/mtcXwsWJwGJPGof1SBBrQ64+zN3EYfCULxa88auu6zO8/NfAf3gwcg+dS+KypRy0UQKjvJfoaLf0l6GCp+vUmuyOCh2fJ+NcPcLbs67M7C7SSQQXkrzT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gT2Oe6HP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713998679; x=1745534679;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=DmC2o0bH2ZycsH1BkNpAJFPKVv6GVkR7uN7efgPshq0=;
  b=gT2Oe6HPE3RWdyW7g2siGEzwlcShMa2k7u+LWDzkEdQucnfo6hL3mSYG
   7JgnjYQeoXa3VMtIbczjz9ByqUHSyL/0zSKcZRWsuO4h3wu4moDZ0oZ8c
   kScPCoo6a3YXdy1fLwxEIfaQiCjx/J3g1FR2aCmxbp2pPJjfhw6Nf2Exg
   wBmzd9NNLXBci/GviuK0Quq1AJuk1SilpV+DRzxo/estntSZHGxbrFzqp
   sDX/4u4henQIQ1dZKxkpQzjM5ZTmigpEER3EAAq3E5Y0iI3sFzcv7ZZQ2
   ej2lh7Z/H95LQOjOZTpL/Czn6bTL04O1fEq5nhQLLT3TMsGftrq/E2ldO
   Q==;
X-CSE-ConnectionGUID: JRcCsrCIRIm9IWsYTMAm/w==
X-CSE-MsgGUID: REYISlXXRjGp1yyQaq2v1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9821351"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9821351"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 15:44:39 -0700
X-CSE-ConnectionGUID: iE8CYq/yTUWoHCgicKMlrw==
X-CSE-MsgGUID: Pl8x73U5R1CDN68y6IKi8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="29647941"
Received: from gnr-001.sh.intel.com ([10.112.230.245])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 15:44:38 -0700
From: Dongsheng Zhang <dongsheng.x.zhang@intel.com>
To: linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] KVM: selftests: Add assertion for mem_size in vm_mem_add()
Date: Thu, 25 Apr 2024 06:44:34 +0800
Message-ID: <20240424224434.14166-2-dongsheng.x.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424224434.14166-1-dongsheng.x.zhang@intel.com>
References: <20240424224434.14166-1-dongsheng.x.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: donsheng <dongsheng.x.zhang@intel.com>

If mmap() is called with MAP_HUGETLB and the requested mapping size is
not a multiple of the underlying hugetlb page size, kernel will automatically
align the mmap size, but munmap() will fail if you specify the size you asked
for rather than the size that was assigned by Linux kernel mmap().

To avoid munmap() failure, add sanity check for mem_size in vm_mem_add() to
ensure that mem_size is aligned to page size of the underlying hugetlb backing src.

This assertion helps to ensure that vm_mem_add() is called with aligned mapping size,
especially when vm_mem_add() is called to add guest memory backed by
VM_MEM_SRC_ANONYMOUS_HUGETLB which relies on the default hugetlb page size.

Signed-off-by: donsheng <dongsheng.x.zhang@intel.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b2262b5fad9e..827bb3d57815 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -985,6 +985,11 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		"  vm->max_gfn: 0x%lx vm->page_size: 0x%x",
 		guest_paddr, npages, vm->max_gfn, vm->page_size);
 
+	TEST_ASSERT(!(is_backing_src_hugetlb(src_type) &&
+		(mem_size & (backing_src_pagesz - 1))),
+		"mem_size 0x%lx is not aligned to backing src %s's page size 0x%lx",
+		mem_size, vm_mem_backing_src_alias(src_type)->name, backing_src_pagesz);
+
 	/*
 	 * Confirm a mem region with an overlapping address doesn't
 	 * already exist.
-- 
2.43.0


