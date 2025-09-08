Return-Path: <linux-kselftest+bounces-40998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04FFB49C2E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 23:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15234E255B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 21:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6DE2E9EC1;
	Mon,  8 Sep 2025 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l3qTk5Lt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C272E888A;
	Mon,  8 Sep 2025 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367187; cv=none; b=k/TA/7mhx6885gFAL13dWQOsSQfEu/hK+zbNGVtNEFi2+E6tkozrfMhP59bKZOnQXE69ajbQJlVexr/siHUioB/4aIhHV9Qp7icTjelLhKr9hwshW5UHCyzF3TIYgsZkJgOzg2WKPUH1yMkeCFq5yqn+t36XCS5sEWicvNwhUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367187; c=relaxed/simple;
	bh=V8rYw/JRih+YtWeCsVuIpSGHovoq+kulWPDrk4knZAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gBOod1PTcE1/J6ZYwzSvmn22pr+D6QezzdRX7ip/yHyKapwoXpm5tFsbCzuzm0CylGKqzNcSybJPiGwwF0rjrYdV/fCC2e/YqIA/UVt8/cZ3DmLaXmbH5qnlYr5FbRHVDWXlydL/FlsrWqBQy7opn52A/alxSgCkie70FfCSU1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l3qTk5Lt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=A0OjpVDD2znJS8dM8mjDlBY42FWUIIEQb+1xhiGSU0w=; b=l3qTk5LtQfVj0Ovaax2NglC5Ks
	iJ232iK42z129GUSkTVFNDlVWIbeEXkuBW8tjVJ0/3RtFNkCuydBMaEInr68WVUSOe4F+YBT+qv5k
	SNUD/7CFeqKJ89wojjok8tjrC1nd0KJEwyrT7VFzIjZY9nImb0RhuiF3yddOP4R9T6bkRSANCIAPz
	8mnVKPrFp6vBs/fDGMGb9CXDEguTXMsXSR1r4x/Bc22/5GQ+81kRsC31+poA7wymadLKnPgbg4aGh
	OMBEwKn8Z3NYh7LYEpgGOScSLYIpR97kyWKgaUDRMQrqK3cXXOTeCLiz8x1NoE/wG6KHI1BZP2VG+
	exZsAB8g==;
Received: from griffoul by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvjTy-0000000DNpT-3Fo3;
	Mon, 08 Sep 2025 21:33:02 +0000
From: Fred Griffoul <griffoul@infradead.org>
To: kvm@vger.kernel.org
Cc: griffoul@gmail.com,
	Fred Griffoul <griffoul@casper.infradead.org>,
	dwmw@amazon.co.uk,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/5] KVM: Improve nested VMX performance 
Date: Mon,  8 Sep 2025 22:32:25 +0100
Message-ID: <20250908213241.3189113-1-griffoul@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <griffoul@casper.infradead.org>

This patch series addresses performance issues in nested VMX when
handling unmanaged guest memory. Unmanaged guest memory refers to memory
not directly mapped by the kernel (no struct page), such as memory
passed with the mem= parameter or guest_memfd for non-Confidential
Computing (CoCo) VMs.

Current Problem:

During nested VMX operations, the system frequently accesses specific
guest pages during L2 VM entry/exit cycles. The current workflow:

1. kvm_vcpu_map() invokes memremap() for unmanaged memory.
2. The system either directly accesses mapped memory via nested VMX or
   passes it to the L2 guest through vmcs02.
3. kvm_vcpu_unmap() invokes memunmap()

This repeated map/unmap cycle creates significant performance overhead
due to expensive remapping operations.

Solution approach:

Our solution replaces kvm_host_map with gfn_to_pfn_cache in nested VMX.
It addresses two distinct types of guest pages.

First, we handle the L1 MSR bitmap page, which requires read-only access
for folding L1 and L0 MSR bitmap. We implement this conversion to
gfn_to_pfn_cache in patch 1.

Second, we tackle system pages, including APIC access, virtual APIC, and
posted interrupt descriptor pages. These pages are more complex as
they're accessed by both nested VMX code _and_ passed to the L2 guest in
vmcs02 fields. This requires to restore and complete the
"guest-uses-pfn" support in pfncache through patches 2 and 3, followed
by implementing kvm_host_map replacement with caches in patch 4.

Testing:

Patch 5 introduces a new selftest to verify cache invalidation and
memslot update functionality.

The changes are available in a git repository at:

git://git.infradead.org/users/griffoul/linux.git tags/nvmx-gpc-v1

Suggested-by: dwmw@amazon.co.uk

Fred Griffoul (5):
  KVM: nVMX: Implement cache for L1 MSR bitmap
  KVM: pfncache: Restore guest-uses-pfn support
  KVM: x86: Add nested state validation for pfncache support
  KVM: nVMX: Implement cache for L1 APIC pages
  KVM: selftests: Add nested VMX APIC cache invalidation test

 arch/x86/include/asm/kvm_host.h               |   1 +
 arch/x86/kvm/vmx/nested.c                     | 213 +++++++++---
 arch/x86/kvm/vmx/vmx.h                        |  10 +-
 arch/x86/kvm/x86.c                            |  14 +-
 include/linux/kvm_host.h                      |  34 +-
 include/linux/kvm_types.h                     |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/vmx_apic_update_test.c  | 302 ++++++++++++++++++
 virt/kvm/kvm_main.c                           |   3 +-
 virt/kvm/kvm_mm.h                             |   6 +-
 virt/kvm/pfncache.c                           |  43 ++-
 11 files changed, 575 insertions(+), 53 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_apic_update_test.c

-- 
2.51.0


