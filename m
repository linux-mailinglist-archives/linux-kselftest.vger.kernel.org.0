Return-Path: <linux-kselftest+bounces-42367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A91C3BA0D7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19AA81C203D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA7D3112A1;
	Thu, 25 Sep 2025 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGEtYPAt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E930E853
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821343; cv=none; b=l8efdak2QullaDIhI4ngK4nnLCtG4JJYUPskpT0RBwBV+9qrZBjkBuDAwndxP2Y5ONwHH3aqCFhq9VI5djA3tcmysqECl1PIugGu0ZcH47W5LeJGQCG0P4FrNuZ9JIu397LXhBdj1eDIpZ6PnThR5ca0Nex7Pq4T2XcUWOAQoRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821343; c=relaxed/simple;
	bh=cm0oCj2UwzVSQ7oovRIDgBAWt+iE2WW/cAR3ClzBlvw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kr5zO7enEkPSkTZ2iAkE2vkZiB7xAyWUNfgFTxuNWwlV1T/4cv9jzzVWxAuXN5cdDqsm8EIXeDPqBD5oSJM6ghOp88V/wBzCEERpNDfuyjuku1W45DxU0f7BofuGlRbHnHww0NwqphZoK0M3GT77KwEiwTz5ZLYNrLrBAT+3RPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dGEtYPAt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77f2e48a829so1987709b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821341; x=1759426141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XbtNUlyKoSJFL65Tzu8MVZFu/2Cto42AWWcWpi30VOw=;
        b=dGEtYPAt2B3+I3bmT66lwf+EqtIhUfo7+om/Y7r9r31xbw3PjKnof8UZwu3Y4B3h59
         mp3r8Ou33yAtMrme6j08XNr1svxq9RAfhUZ4IjQuFxbj9PSEpKatD8DvfgC/n9ET2Poj
         IsXRVm2uNhYYA1dk2UO3mzRO0sc+YrvzPKV7e1/LSoRLcPljGekEswOHIqCX53U+Y8Bg
         1sp5yIr23Kz73wKmwU3BFhtp/B9ciqmEWsvWUkG5TKN/tEcGCXdUqa3KRSv63Nm+5pXK
         jovA1A4X1xQA/tYLJQoZbVq+nppsyXTzVVfhB3bXFN1XBRhtQ8qd6fgAfTHyfKwi73q+
         dQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821341; x=1759426141;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XbtNUlyKoSJFL65Tzu8MVZFu/2Cto42AWWcWpi30VOw=;
        b=a99rJyWxJ4wJR8UfFYyLbFBS5qyl6HrZJU89eiTSPDJXu5u0KYKAIOHvshhKPmSEln
         wY5QYalpglIVl1TiHfWZUsv0pek3wdaxkH/rkjw0GjFERmRGxEhkfsMsFA51oH5PnBrl
         oWKKCOXUcXn6cRQzne2r8QAqaMwI8mv+f/swDIb45W57NTDmUrkg+sPFoPiuT2NZaEPP
         KDujI5xhBIjg7aHNbXbWOd8OUgg81pnU/dIPUK8rKp6VFhIzM2i5xNqpjX8bGzc3ypb5
         yQajHpRB0VKzpwxrKjjQSwdxP9cCX1SVadapBB333X2xfVOoFzYvoFMj+aUeK98J3Z0N
         e0pA==
X-Gm-Message-State: AOJu0YwlJ3jdCg2sAn3ErGTl5e2LT6pvxDGaiaZvPDPz2O+XpK51Nwu+
	CKB5AMiykbehR62wIBjm+azuSCBzxLIjp6DKrXxIvW6eKfy+zYEI+6ftUOr/pt0mRSXKeVfomOl
	0UwSEPbj8cl5ph5zra3D1LPc5gZZsh4BafWDGY12n5KPJkLAF29woqnO5Js2bzYt9lDVdxblKR9
	585OIBLRSnlp2kuP8Vp9Fz3/5UOpuRSYnYb4D6ELafuHA=
X-Google-Smtp-Source: AGHT+IGivp1/jQ3RPpkMeC3Ub385iB6a468x5KIwdLm5vCmP81FbX++bVDDnS8keVwbIlU+p1Nthkfmp0w==
X-Received: from pfks14.prod.google.com ([2002:a05:6a00:194e:b0:77f:efc:1431])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e13:b0:776:1de4:aee6
 with SMTP id d2e1a72fcca58-780fcec2c91mr4157926b3a.16.1758821340695; Thu, 25
 Sep 2025 10:29:00 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:28:28 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172851.606193-1-sagis@google.com>
Subject: [PATCH v11 00/21] TDX KVM selftests
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is v11 of the TDX selftests.

This series is based on v6.17-rc7

Changes from v10 [1]:
- Rebased on top of v6.17-rc4.
- Addressed minor comments from v10.
- Removed code for setting up X86_CR4_OSXMMEXCPT which is not needed for
  now.
- Added call to vm_tdx_load_common_boot_parameters() in "KVM: selftests:
  Call TDX init when creating a new TDX vm" which was accidentally
  dropped between v9 and v10 due to code refactoring

[1] https://lore.kernel.org/lkml/20250904065453.639610-1-sagis@google.com/#r

Ackerley Tng (2):
  KVM: selftests: Add helpers to init TDX memory and finalize VM
  KVM: selftests: Add ucall support for TDX

Erdem Aktas (2):
  KVM: selftests: Add TDX boot code
  KVM: selftests: Add support for TDX TDCALL from guest

Isaku Yamahata (2):
  KVM: selftests: Update kvm_init_vm_address_properties() for TDX
  KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to validate TDs'
    attribute configuration

Sagi Shahar (15):
  KVM: selftests: Allocate pgd in virt_map() as necessary
  KVM: selftests: Expose functions to get default sregs values
  KVM: selftests: Expose function to allocate guest vCPU stack
  KVM: selftests: Expose segment definitons to assembly files
  KVM: selftests: Add kbuild definitons
  KVM: selftests: Define structs to pass parameters to TDX boot code
  KVM: selftests: Set up TDX boot code region
  KVM: selftests: Set up TDX boot parameters region
  KVM: selftests: Add helper to initialize TDX VM
  KVM: selftests: Call TDX init when creating a new TDX vm
  KVM: selftests: Setup memory regions for TDX on vm creation
  KVM: selftests: Call KVM_TDX_INIT_VCPU when creating a new TDX vcpu
  KVM: selftests: Set entry point for TDX guest code
  KVM: selftests: Add wrapper for TDX MMIO from guest
  KVM: selftests: Add TDX lifecycle test

 tools/include/linux/kbuild.h                  |  18 +
 tools/testing/selftests/kvm/Makefile.kvm      |  32 ++
 .../selftests/kvm/include/ucall_common.h      |   1 +
 .../selftests/kvm/include/x86/processor.h     |  35 ++
 .../selftests/kvm/include/x86/processor_asm.h |  12 +
 .../selftests/kvm/include/x86/tdx/td_boot.h   |  74 ++++
 .../kvm/include/x86/tdx/td_boot_asm.h         |  16 +
 .../selftests/kvm/include/x86/tdx/tdcall.h    |  34 ++
 .../selftests/kvm/include/x86/tdx/tdx.h       |  14 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |  86 +++++
 .../testing/selftests/kvm/include/x86/ucall.h |   6 -
 tools/testing/selftests/kvm/lib/kvm_util.c    |  10 +-
 .../testing/selftests/kvm/lib/x86/processor.c |  93 +++--
 .../selftests/kvm/lib/x86/tdx/td_boot.S       |  60 +++
 .../kvm/lib/x86/tdx/td_boot_offsets.c         |  21 ++
 .../selftests/kvm/lib/x86/tdx/tdcall.S        |  93 +++++
 .../kvm/lib/x86/tdx/tdcall_offsets.c          |  16 +
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c |  23 ++
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 348 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/ucall.c   |  46 ++-
 tools/testing/selftests/kvm/x86/tdx_vm_test.c |  31 ++
 21 files changed, 1029 insertions(+), 40 deletions(-)
 create mode 100644 tools/include/linux/kbuild.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/processor_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdcall_offsets.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_vm_test.c

-- 
2.51.0.536.g15c5d4f767-goog


