Return-Path: <linux-kselftest+bounces-17602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E55973B93
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3081F2565E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22FD19A292;
	Tue, 10 Sep 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="n/iT9sTO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E0D199E9D;
	Tue, 10 Sep 2024 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981740; cv=none; b=NLg2a2PKUBKak10wA+8BXHgGkrAzMPRIcxYKbvYIhkWmL7fut8KTIlSrExJ6R8vIRL2oKyi/g1yBb675c+O6FxyPTHdnt5Z7R4/AyA+qITZ3KEVnSjFItTN46o0i5A+2SKoE3E/rCZDP4Xau8Z8zsonmb+eIhv4tyT0Y8nbALJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981740; c=relaxed/simple;
	bh=qgdA0EYPO0r8WOy7gskqSHKpz2q4qYmpUZ/uN9rbctU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dJwsSn0wbW3v8QeA03fiwSIMvtC/RWPxijALjcBnOOnVJ1F7hz9A8T5L8EhAmbcCkCpwqMFr45a4T3XdLJ4uYTu1/j0QndNZPljA05XqrJRiv3u2fqFag67ALhbQEc2Jgy8SCLkbq8PlaVQxz/X67nxJxeWbmLiWq50tUCkKmMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=n/iT9sTO; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1725981739; x=1757517739;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=43ZxBeRcDpaBJaxymQ3wNAHT+dVvxgAEwURx9xvQwhA=;
  b=n/iT9sTOzSBrmUuR+MxYNUiLHRpV9tO4FhUR8wVdUWCNmbKhH55Kdch0
   xqq/p8Q0N8JNvSO0OHT+QvVb9obaCPG107pdW4OAik5EvH7MEKEtW7wcu
   PBF900vjaZ8f2eghwUmXTIMJmLkwArH8h3Pz+iL01z4gfk+cFUjEnLSMJ
   g=;
X-IronPort-AV: E=Sophos;i="6.10,217,1719878400"; 
   d="scan'208";a="758469827"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 15:22:12 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:33591]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.222:2525] with esmtp (Farcaster)
 id f7ece884-a3c5-4b3d-be0e-818f565ea73b; Tue, 10 Sep 2024 15:22:12 +0000 (UTC)
X-Farcaster-Flow-ID: f7ece884-a3c5-4b3d-be0e-818f565ea73b
Received: from EX19D020UWC001.ant.amazon.com (10.13.138.157) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:22:11 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D020UWC001.ant.amazon.com (10.13.138.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Sep 2024 15:22:11 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (10.253.74.52)
 by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 10 Sep 2024 15:22:08 +0000
From: Nikolas Wipper <nikwip@amazon.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
CC: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
	<graf@amazon.de>, James Gowans <jgowans@amazon.com>,
	<nh-open-source@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kvmarm@lists.linux.dev>,
	<kvm-riscv@lists.infradead.org>, Nikolas Wipper <nikwip@amazon.de>
Subject: [PATCH 00/15] KVM: x86: Introduce new ioctl KVM_TRANSLATE2
Date: Tue, 10 Sep 2024 15:21:52 +0000
Message-ID: <20240910152207.38974-1-nikwip@amazon.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series introduces a new ioctl KVM_TRANSLATE2, which expands on
KVM_TRANSLATE. It is required to implement Hyper-V's
HvTranslateVirtualAddress hyper-call as part of the ongoing effort to
emulate HyperV's Virtual Secure Mode (VSM) within KVM and QEMU. The hyper-
call requires several new KVM APIs, one of which is KVM_TRANSLATE2, which
implements the core functionality of the hyper-call. The rest of the
required functionality will be implemented in subsequent series.

Other than translating guest virtual addresses, the ioctl allows the
caller to control whether the access and dirty bits are set during the
page walk. It also allows specifying an access mode instead of returning
viable access modes, which enables setting the bits up to the level that
caused a failure. Additionally, the ioctl provides more information about
why the page walk failed, and which page table is responsible. This
functionality is not available within KVM_TRANSLATE, and can't be added
without breaking backwards compatiblity, thus a new ioctl is required.

The ioctl was designed to facilitate as many other use cases as possible
apart from VSM. The error codes were intentionally chosen to be broad
enough to avoid exposing architecture specific details. Even though
HvTranslateVirtualAddress only really needs one flag to set the accessed
and dirty bits whenever possible, that was split into several flags so
that future users can chose more gradually when these bits should be set.
Furthermore, as much information as possible is provided to the caller.

The patch series includes selftests for the ioctl, as well as fuzzy
testing on random garbage guest page table entries. All previously passing
KVM selftests and KVM unit tests still pass.

Series overview:
- 1: Document the new ioctl
- 2-11: Update the page walker in preparation
- 12-14: Implement the ioctl
- 15: Implement testing

This series, alongside the series by Nicolas Saenz Julienne [1]
introducing the core building blocks for VSM and the accompanying QEMU
implementation [2], is capable of booting Windows Server 2019.

Both series are also available on GitHub [3].

[1] https://lore.kernel.org/linux-hyperv/20240609154945.55332-1-nsaenz@amazon.com/
[2] https://github.com/vianpl/qemu/tree/vsm/next
[3] https://github.com/vianpl/linux/tree/vsm/next

Best,
Nikolas

Nikolas Wipper (15):
  KVM: Add API documentation for KVM_TRANSLATE2
  KVM: x86/mmu: Abort page walk if permission checks fail
  KVM: x86/mmu: Introduce exception flag for unmapped GPAs
  KVM: x86/mmu: Store GPA in exception if applicable
  KVM: x86/mmu: Introduce flags parameter to page walker
  KVM: x86/mmu: Implement PWALK_SET_ACCESSED in page walker
  KVM: x86/mmu: Implement PWALK_SET_DIRTY in page walker
  KVM: x86/mmu: Implement PWALK_FORCE_SET_ACCESSED in page walker
  KVM: x86/mmu: Introduce status parameter to page walker
  KVM: x86/mmu: Implement PWALK_STATUS_READ_ONLY_PTE_GPA in page walker
  KVM: x86: Introduce generic gva to gpa translation function
  KVM: Introduce KVM_TRANSLATE2
  KVM: Add KVM_TRANSLATE2 stub
  KVM: x86: Implement KVM_TRANSLATE2
  KVM: selftests: Add test for KVM_TRANSLATE2

 Documentation/virt/kvm/api.rst                | 131 ++++++++
 arch/x86/include/asm/kvm_host.h               |  18 +-
 arch/x86/kvm/hyperv.c                         |   3 +-
 arch/x86/kvm/kvm_emulate.h                    |   8 +
 arch/x86/kvm/mmu.h                            |  10 +-
 arch/x86/kvm/mmu/mmu.c                        |   7 +-
 arch/x86/kvm/mmu/paging_tmpl.h                |  80 +++--
 arch/x86/kvm/x86.c                            | 123 ++++++-
 include/linux/kvm_host.h                      |   6 +
 include/uapi/linux/kvm.h                      |  33 ++
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/kvm_translate2.c     | 310 ++++++++++++++++++
 virt/kvm/kvm_main.c                           |  41 +++
 13 files changed, 724 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/kvm_translate2.c

-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


