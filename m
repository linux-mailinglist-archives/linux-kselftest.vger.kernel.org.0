Return-Path: <linux-kselftest+bounces-21099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0F19B649F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6D81C2104F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 13:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80481EB9EE;
	Wed, 30 Oct 2024 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="i+aouXCT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FD613FEE;
	Wed, 30 Oct 2024 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296183; cv=none; b=GWohMfwgrOw9ZvilZf1q127trlmBheN4wT4a5NeYof6GMDblwy1mGgeF+/4MQTKOnxXPo8FyiRQtvkuFl9O0h+MGs8K/ivOIgXh+lj1pBq7HYjACqHab7J1m4gb0FOV2yzfivyCzz58cdspsjckOwRMxuRAgZJCBPd61lMVym9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296183; c=relaxed/simple;
	bh=XEZK53E2LoP/MsvOnXL4Hb1nrrUl4RW9PyyRhFcQTY8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QBjMQxzZo8jzbvSPJZVR+jvhxRXQS04K8h4VTMrGgnKxKtNTAOlyLxr27jmzTpsw8t5oxnsJCzikisYvVEDBmRhxd5+SHI/hTOlpiNOfm880DSCCVzevrbFFJq829NfD/jKvKmgUDVCxuvMykNl1s2X9AsaRfXPyMbzuqIRZvkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=i+aouXCT; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1730296181; x=1761832181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r1QMDZCnRymQeRRBpcOx6ZreXT7450ZDAPuRRJDuiN0=;
  b=i+aouXCTuryFwwmX9zGipDzExIUvjlTZDjjcfz0Ap5NR4G9H/Pdd1jxM
   9thLbUD6HdEwtJNlS5Me9QDkgqkm2FonplFsjvpyQS8WVoAn/eqbEBy5g
   qJjX35Re6wFTmg30NYyI2m5P6rt8jc5TaPu7R9f6fvRlNBNVLMPFQgsS7
   E=;
X-IronPort-AV: E=Sophos;i="6.11,245,1725321600"; 
   d="scan'208";a="141949542"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 13:49:37 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:55646]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.36:2525] with esmtp (Farcaster)
 id b62929fd-fda7-42c8-9f60-587e2125a407; Wed, 30 Oct 2024 13:49:36 +0000 (UTC)
X-Farcaster-Flow-ID: b62929fd-fda7-42c8-9f60-587e2125a407
Received: from EX19D003UWB004.ant.amazon.com (10.13.138.24) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 30 Oct 2024 13:49:36 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D003UWB004.ant.amazon.com (10.13.138.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 30 Oct 2024 13:49:35 +0000
Received: from email-imr-corp-prod-pdx-all-2c-8a67eb17.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Wed, 30 Oct 2024 13:49:35 +0000
Received: from ua2d7e1a6107c5b.home (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2c-8a67eb17.us-west-2.amazon.com (Postfix) with ESMTPS id C4A404032D;
	Wed, 30 Oct 2024 13:49:26 +0000 (UTC)
From: Patrick Roy <roypat@amazon.co.uk>
To: <tabba@google.com>, <quic_eberman@quicinc.com>, <david@redhat.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <jthoughton@google.com>,
	<ackerleytng@google.com>, <vannapurve@google.com>, <rppt@kernel.org>
CC: Patrick Roy <roypat@amazon.co.uk>, <graf@amazon.com>,
	<jgowans@amazon.com>, <derekmn@amazon.com>, <kalyazin@amazon.com>,
	<xmarcalx@amazon.com>, <linux-mm@kvack.org>, <corbet@lwn.net>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
	<kernel@xen0n.name>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
	<agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<gerald.schaefer@linux.ibm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
Date: Wed, 30 Oct 2024 13:49:04 +0000
Message-ID: <20241030134912.515725-1-roypat@amazon.co.uk>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Unmapping virtual machine guest memory from the host kernel's direct map
is a successful mitigation against Spectre-style transient execution
issues: If the kernel page tables do not contain entries pointing to
guest memory, then any attempted speculative read through the direct map
will necessarily be blocked by the MMU before any observable
microarchitectural side-effects happen. This means that Spectre-gadgets
and similar cannot be used to target virtual machine memory. Roughly 60%
of speculative execution issues fall into this category [1, Table 1].

This patch series extends guest_memfd with the ability to remove its
memory from the host kernel's direct map, to be able to attain the above
protection for KVM guests running inside guest_memfd.

=== Changes to v2 ===

- Handle direct map removal for physically contiguous pages in arch code
  (Mike R.)
- Track the direct map state in guest_memfd itself instead of at the
  folio level, to prepare for huge pages support (Sean C.)
- Allow configuring direct map state of not-yet faulted in memory
  (Vishal A.)
- Pay attention to alignment in ftrace structs (Steven R.)

Most significantly, I've reduced the patch series to focus only on
direct map removal for guest_memfd for now, leaving the whole "how to do
non-CoCo VMs in guest_memfd" for later. If this separation is
acceptable, then I think I can drop the RFC tag in the next revision
(I've mainly kept it here because I'm not entirely sure what to do with
patches 3 and 4).

=== Implementation ===

This patch series introduces a new flag to the KVM_CREATE_GUEST_MEMFD
that causes guest_memfd to remove its pages from the host kernel's
direct map immediately after population/preparation.  It also adds
infrastructure for tracking the direct map state of all gmem folios
inside the guest_memfd inode. Storing this information in the inode has
the advantage that the code is ready for future hugepages extensions,
where only removing/reinserting direct map entries for sub-ranges of a
huge folio is a valid usecase, and it allows pre-configuring the direct
map state of not-yet faulted in parts of memory (for example, when the
VMM is receiving a RX virtio buffer from the guest).

=== Summary ===

Patch 1 (from Mike Rapoport) adds arch APIs for manipulating the direct
map for ranges of physically contiguous pages, which are used by
guest_memfd in follow up patches. Patch 2 adds the
KVM_GMEM_NO_DIRECT_MAP flag and the logic for configuring direct map
state of freshly prepared folios. Patches 3 and 4 mainly serve an
illustrative purpose, to show how the framework from patch 2 can be
extended with routines for runtime direct map manipulation. Patches 5
and 6 deal with documentation and self-tests respectively.

[1]: https://download.vusec.net/papers/quarantine_raid23.pdf
[RFC v1]: https://lore.kernel.org/kvm/20240709132041.3625501-1-roypat@amazon.co.uk/
[RFC v2]: https://lore.kernel.org/kvm/20240910163038.1298452-1-roypat@amazon.co.uk/

Mike Rapoport (Microsoft) (1):
  arch: introduce set_direct_map_valid_noflush()

Patrick Roy (5):
  kvm: gmem: add flag to remove memory from kernel direct map
  kvm: gmem: implement direct map manipulation routines
  kvm: gmem: add trace point for direct map state changes
  kvm: document KVM_GMEM_NO_DIRECT_MAP flag
  kvm: selftests: run gmem tests with KVM_GMEM_NO_DIRECT_MAP set

 Documentation/virt/kvm/api.rst                |  14 +
 arch/arm64/include/asm/set_memory.h           |   1 +
 arch/arm64/mm/pageattr.c                      |  10 +
 arch/loongarch/include/asm/set_memory.h       |   1 +
 arch/loongarch/mm/pageattr.c                  |  21 ++
 arch/riscv/include/asm/set_memory.h           |   1 +
 arch/riscv/mm/pageattr.c                      |  15 +
 arch/s390/include/asm/set_memory.h            |   1 +
 arch/s390/mm/pageattr.c                       |  11 +
 arch/x86/include/asm/set_memory.h             |   1 +
 arch/x86/mm/pat/set_memory.c                  |   8 +
 include/linux/set_memory.h                    |   6 +
 include/trace/events/kvm.h                    |  22 ++
 include/uapi/linux/kvm.h                      |   2 +
 .../testing/selftests/kvm/guest_memfd_test.c  |   2 +-
 .../kvm/x86_64/private_mem_conversions_test.c |   7 +-
 virt/kvm/guest_memfd.c                        | 280 +++++++++++++++++-
 17 files changed, 384 insertions(+), 19 deletions(-)


base-commit: 5cb1659f412041e4780f2e8ee49b2e03728a2ba6
-- 
2.47.0


