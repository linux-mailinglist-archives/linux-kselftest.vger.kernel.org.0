Return-Path: <linux-kselftest+bounces-19024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC07F99055B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D128E1C20FC0
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8DA2141D7;
	Fri,  4 Oct 2024 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="dJaxc4Dm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802562141DC;
	Fri,  4 Oct 2024 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050904; cv=none; b=uJUzllNFjEiu4drhf20enhh1VoXN8w5AnyJzQFMQsoWhPW7KL7l6VDhA8L13a+Zu06L2xBrExgnVQyuHohaA27moMz57WBQGc2zkf7H7mDz8KMAFOw8xj2WPEQ6x2CpMogG+j3hPXBDb9eq/XYTvhQTSDtzYKRz9f4TV4oCpxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050904; c=relaxed/simple;
	bh=dEFXc+lJNzaKiiAH+N4aUTtNjda1w1YYpte7n0oZRSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GrFpvL5AfJao4oPzDyK1VHoHJoGrkylDirdNkJOJjxVqeSf7GN8T9GP7tQ7TsiRZYkpPt6XYFmjiXgdsfQlQCIJcSjnxasGV/6mCq5yJ4YMqSBqQtC3EtEt16fnRSiyoHVhx8qBPoZ78ngBGNv/ouVYCSqoXfWYBZcBKFsZ2yEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=dJaxc4Dm; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1728050903; x=1759586903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uPg7F0nSFvjnhLWmD+reVh0IDZxY4LYEuXfZgFaWKT4=;
  b=dJaxc4DmNVVjMBMLYjT0cfhGlInhamQqi7IzfgtKSmbkfcppFGqUzXtB
   vFbsMwk+REgvAQf972IMpQPAGUlOulf7t3IWmYaP0Pr84s3jUhaCR+39/
   0DkTWW/Hs1OqlOTpNTejKRC4ov6A2EoLW+xEdM1WRhSsJ05Gt5nD8kmcq
   w=;
X-IronPort-AV: E=Sophos;i="6.11,177,1725321600"; 
   d="scan'208";a="428887629"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 14:08:19 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:4822]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.100:2525] with esmtp (Farcaster)
 id 22c93a9c-ae03-4c8d-b0d2-293a9c1b4d54; Fri, 4 Oct 2024 14:08:17 +0000 (UTC)
X-Farcaster-Flow-ID: 22c93a9c-ae03-4c8d-b0d2-293a9c1b4d54
Received: from EX19D020UWA001.ant.amazon.com (10.13.138.249) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 14:08:14 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D020UWA001.ant.amazon.com (10.13.138.249) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 14:08:14 +0000
Received: from email-imr-corp-prod-pdx-all-2c-475d797d.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 4 Oct 2024 14:08:14 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com [10.253.74.52])
	by email-imr-corp-prod-pdx-all-2c-475d797d.us-west-2.amazon.com (Postfix) with ESMTPS id 6F1C3A03AD;
	Fri,  4 Oct 2024 14:08:11 +0000 (UTC)
From: Nikolas Wipper <nikwip@amazon.de>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
	<graf@amazon.de>, James Gowans <jgowans@amazon.com>,
	<nh-open-source@amazon.com>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Nikolas Wipper <nik.wipper@gmx.de>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Nikolas
 Wipper" <nikwip@amazon.de>
Subject: [PATCH 0/7] KVM: x86: Introduce new ioctl KVM_HYPERV_SET_TLB_FLUSH_INHIBIT
Date: Fri, 4 Oct 2024 14:08:03 +0000
Message-ID: <20241004140810.34231-1-nikwip@amazon.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series introduces a new ioctl KVM_HYPERV_SET_TLB_FLUSH_INHIBIT. It
allows hypervisors to inhibit remote TLB flushing of a vCPU coming from
Hyper-V hyper-calls (namely HvFlushVirtualAddressSpace(Ex) and
HvFlushirtualAddressList(Ex)). It is required to implement the
HvTranslateVirtualAddress hyper-call as part of the ongoing effort to
emulate VSM within KVM and QEMU. The hyper-call requires several new KVM
APIs, one of which is KVM_HYPERV_SET_TLB_FLUSH_INHIBIT.

Once the inhibit flag is set, any processor attempting to flush the TLB on
the marked vCPU, with a HyperV hyper-call, will be suspended until the
flag is cleared again. During the suspension the vCPU will not run at all,
neither receiving events nor running other code. It will wake up from
suspension once the vCPU it is waiting on clears the inhibit flag. This
behaviour is specified in Microsoft's "Hypervisor Top Level Functional
Specification" (TLFS).

The vCPU will block execution during the suspension, making it transparent
to the hypervisor. An alternative design to what is proposed here would be
to exit from the Hyper-V hypercall upon finding an inhibited vCPU. We
decided against it, to allow for a simpler and more performant
implementation. Exiting to user space would create an additional
synchronisation burden and make the resulting code more complex.
Additionally, since the suspension is specific to HyperV events, it
wouldn't provide any functional benefits.

The TLFS specifies that the instruction pointer is not moved during the
suspension, so upon unsuspending the hyper-calls is re-executed. This
means that, if the vCPU encounters another inhibited TLB and is
resuspended, any pending events and interrupts are still executed. This is
identical to the vCPU receiving such events right before the hyper-call.

This inhibiting of TLB flushes is necessary, to securely implement
intercepts. These allow a higher "Virtual Trust Level" (VTL) to react to
a lower VTL accessing restricted memory. In such an intercept the VTL may
want to emulate a memory access in software, however, if another processor
flushes the TLB during that operation, incorrect behaviour can result.

The patch series includes basic testing of the ioctl and suspension state.
All previously passing KVM selftests and KVM unit tests still pass.

Series overview:
- 1: Document the new ioctl
- 2: Implement the suspension state
- 3: Update TLB flush hyper-call in preparation
- 4-5: Implement the ioctl
- 6: Add traces
- 7: Implement testing

As the suspension state is transparent to the hypervisor, testing is
complicated. The current version makes use of a set time intervall to give
the vCPU time to enter the hyper-call and get suspended. Ideas for
improvement on this are very welcome.

This series, alongside my series [1] implementing KVM_TRANSLATE2, the
series by Nicolas Saenz Julienne [2] implementing the core building blocks
for VSM and the accompanying QEMU implementation [3], is capable of
booting Windows Server 2019 with VSM/CredentialGuard enabled.

All three series are also available on GitHub [4].

[1] https://lore.kernel.org/linux-kernel/20240910152207.38974-1-nikwip@amazon.de/
[2] https://lore.kernel.org/linux-hyperv/20240609154945.55332-1-nsaenz@amazon.com/
[3] https://github.com/vianpl/qemu/tree/vsm/next
[4] https://github.com/vianpl/linux/tree/vsm/next

Best,
Nikolas

Nikolas Wipper (7):
  KVM: Add API documentation for KVM_HYPERV_SET_TLB_FLUSH_INHIBIT
  KVM: x86: Implement Hyper-V's vCPU suspended state
  KVM: x86: Check vCPUs before enqueuing TLB flushes in
    kvm_hv_flush_tlb()
  KVM: Introduce KVM_HYPERV_SET_TLB_FLUSH_INHIBIT
  KVM: x86: Implement KVM_HYPERV_SET_TLB_FLUSH_INHIBIT
  KVM: x86: Add trace events to track Hyper-V suspensions
  KVM: selftests: Add tests for KVM_HYPERV_SET_TLB_FLUSH_INHIBIT

 Documentation/virt/kvm/api.rst                |  41 +++
 arch/x86/include/asm/kvm_host.h               |   5 +
 arch/x86/kvm/hyperv.c                         |  86 +++++-
 arch/x86/kvm/hyperv.h                         |  17 ++
 arch/x86/kvm/trace.h                          |  39 +++
 arch/x86/kvm/x86.c                            |  41 ++-
 include/uapi/linux/kvm.h                      |  15 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/x86_64/hyperv_tlb_flush_inhibit.c     | 274 ++++++++++++++++++
 9 files changed, 503 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush_inhibit.c

-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


