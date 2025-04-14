Return-Path: <linux-kselftest+bounces-30764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C04A88E2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5E2177CF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B271F460B;
	Mon, 14 Apr 2025 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xfAa9Rj0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7B1F4604
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667321; cv=none; b=R79FrPPTt36BzOYT6UyOPdYIDljrC/FGiwl2nWRGKxVfGtPI5pqBJZdfiCY+2mhvJofRyQA8iA8DFgwIKKiBe1XzXFpKO1/A3x9MJfQJJK8xhtnnNklUZbl13f7S/Wx6dXLJuglPdDe4O/ZBfPcgBTI7G6yxm/cE2DILX1GEreA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667321; c=relaxed/simple;
	bh=IizzDB/CPmORQHopDxbO5MtuP8whGaXt6RoLLc612Sc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RNfcjKRuv6/bBmf+qp8k3JC3dUZBm6PpwLj5mGUCPF0UH23P39V1hxPRu1JiGgFG8TVp5p/GULNUP1e6UpT4NwogvWdzF25CTS4j1VDvqqy42A1X0LsjlvDofQssaLjV0K2cU4pZ55rz4Pvr6CWV9+3K/6smtVxGlKHPX61yx40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xfAa9Rj0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224191d9228so58535005ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667318; x=1745272118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xeY3Ne7T73IiRsQfdaGb54kmu2OZnS8MLyUx2jX+LVI=;
        b=xfAa9Rj0GgyoTKnCaGuEOas7oPgAgy/7AxNg741hHxHVWpHJ1ZbVaicxANqiSeCGia
         92h8IUjV0sSTcPsvoAWXCe+R64zl6djt1tUeZrYbvhWWpx6JXCYrZ2IBoA3gWV9sY3/8
         lxFNuBlem5DcK6CpkEf621z0H0ZLTjYqrM4SPvQ0l2jcb3sX0FAw/FTBpjzlbsOWQ/mk
         ftMRr04Z0AGc5Lulv5uiYR0ZrljBKU9NGQ/tMI9Cc9LFEUX5yyo8bR6e3T34SHau6xGN
         0z9l1sA3COmspZ2MSQPfwrdlbZfmqGOa/pDCcXo09J7DGO+KQ/DPhUEJio8e1pbxo/i6
         tLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667318; x=1745272118;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xeY3Ne7T73IiRsQfdaGb54kmu2OZnS8MLyUx2jX+LVI=;
        b=uzuCAQ+aELn/JJ4/m58GRKAfkEv0GNCs3hhGjT3Ldl9C4fyYwkM6GOrdb5L/GXcVm8
         8ct+R2KHGXyByoqfjA1RzNXUmlW96WKweI/fn3sP6rq7tzFY//SbVDKssPPYUUGzqh6w
         +5kUxNU2SI/g463f4SDmN1qgjgN4L+fWQhnkanmQIMWmPRWb1up0Iyi+vNQdtGocYmE/
         pGHgMtO7CCNm3VbKJcYFFiP/QgAATFgDmzEH3+VZCsYkOT/ptYj2MqU/hoiKn62SyeVx
         ipt17a0pbb3NRXuRUavY2Uy7SmN2lXG4VNr4bidP6PI9kbtLLfPXPD878YoGRLe15ygY
         8biw==
X-Gm-Message-State: AOJu0Yy8qMJDXUB8iqtYvMjK9KoppeyFB1znRKK3aPmTYl3W15ZtHa5L
	VNrIMfBzbHnQzjANZxkLXbUYEH4GHViBHGUPMjPtqNeFSpFYYedcx2LhLiltZOf63/yU2LDmZ6x
	QAomhdyRktq65tMCEPNm04pjx0928u3QQu3jAgwvzbmGYC2/BiO9KUtnGEYLNJXy73P52D3chpk
	4ZK8whavyvMr+d5D27tw5qT3tzlQiK4KOR1pLObBY=
X-Google-Smtp-Source: AGHT+IGPgqVGp0oAP4P2gAYQk7qmJgaztFSfBdues0UWUj48+fetvYtjb/Emsq94oa1wkGIcnwuPQ2gSXQ==
X-Received: from plcm17.prod.google.com ([2002:a17:902:f211:b0:223:6546:744e])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c7:b0:220:e5be:29c7
 with SMTP id d9443c01a7336-22bea4f180fmr211893545ad.39.1744667318485; Mon, 14
 Apr 2025 14:48:38 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:29 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-1-sagis@google.com>
Subject: [PATCH v6 00/30] TDX KVM selftests
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is v6 of the TDX selftests that follow RFC v5 sent more than a year
ago. While it has been a while since the previous posting, the TDX
selftests kept up to date with the latest TDX development and supported
the health of the TDX base series.

With TDX base support now in kvm-coco-queue it is a good opportunity to
to again share the TDX selftests and also remove the "RFC" to convey that
this work is now ready to be considered for inclusion in support of the
TDX base support.

Apart from the addition of one new test ("KVM: selftests: TDX: Test
LOG_DIRTY_PAGES flag to a non-GUEST_MEMFD memslot") this series should be
familiar to anybody that previously looked at "RFC v5". All previous feedback
has been addressed. At the same time the changes to TDX base support needed
several matching changes in the TDX selftests that prompted dropping all
previously received "Reviewed-by" tags to indicate that the patches deserve
a new look. In support of upstream inclusion this version also includes many
non functional changes intended to follow the style and customs of this area.

This series is based on: commit 58dd191cf39c ("KVM: x86: Forbid the use of
kvm_load_host_xsave_state() with guest_state_protected") from branch
kvm-coco-queue on git://git.kernel.org/pub/scm/virt/kvm/kvm.git

While the kvm-coco-queue already contains these selftests, this is a
more up-to-date version of the patches.

The tree can be found at:
https://github.com/googleprodkernel/linux-cc/tree/tdx-selftests-v6

I would like to acknowledge the following people, who helped keep these
patches up to date with the latest TDX patches and prepare them for
review:

Reinette Chatre <reinette.chatre@intel.com>
Isaku Yamahata <isaku.yamahata@intel.com>
Binbin Wu <binbin.wu@linux.intel.com>
Adrian Hunter <adrian.hunter@intel.com>
Rick Edgecombe <rick.p.edgecombe@intel.com>

Links to earlier patch series:

RFC v5: https://lore.kernel.org/all/20231212204647.2170650-1-sagis@google.com/
RFC v4: https://lore.kernel.org/lkml/20230725220132.2310657-1-afranji@google.com/
RFC v3: https://lore.kernel.org/lkml/20230121001542.2472357-1-ackerleytng@google.com/T/#u
RFC v2: https://lore.kernel.org/lkml/20220830222000.709028-1-sagis@google.com/T/#u
RFC v1: https://lore.kernel.org/lkml/20210726183816.1343022-1-erdemaktas@google.com/T/#u

Ackerley Tng (12):
  KVM: selftests: Add function to allow one-to-one GVA to GPA mappings
  KVM: selftests: Expose function that sets up sregs based on VM's mode
  KVM: selftests: Store initial stack address in struct kvm_vcpu
  KVM: selftests: Add vCPU descriptor table initialization utility
  KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to validate TDs'
    attribute configuration
  KVM: selftests: TDX: Update load_td_memory_region() for VM memory
    backed by guest memfd
  KVM: selftests: Add functions to allow mapping as shared
  KVM: selftests: KVM: selftests: Expose new vm_vaddr_alloc_private()
  KVM: selftests: TDX: Add support for TDG.MEM.PAGE.ACCEPT
  KVM: selftests: TDX: Add support for TDG.VP.VEINFO.GET
  KVM: selftests: TDX: Add TDX UPM selftest
  KVM: selftests: TDX: Add TDX UPM selftests for implicit conversion

Erdem Aktas (3):
  KVM: selftests: Add helper functions to create TDX VMs
  KVM: selftests: TDX: Add TDX lifecycle test
  KVM: selftests: TDX: Add TDX HLT exit test

Isaku Yamahata (1):
  KVM: selftests: Update kvm_init_vm_address_properties() for TDX

Roger Wang (1):
  KVM: selftests: TDX: Add TDG.VP.INFO test

Ryan Afranji (2):
  KVM: selftests: TDX: Verify the behavior when host consumes a TD
    private memory
  KVM: selftests: TDX: Add shared memory test

Sagi Shahar (10):
  KVM: selftests: TDX: Add report_fatal_error test
  KVM: selftests: TDX: Adding test case for TDX port IO
  KVM: selftests: TDX: Add basic TDX CPUID test
  KVM: selftests: TDX: Add basic TDG.VP.VMCALL<GetTdVmCallInfo> test
  KVM: selftests: TDX: Add TDX IO writes test
  KVM: selftests: TDX: Add TDX IO reads test
  KVM: selftests: TDX: Add TDX MSR read/write tests
  KVM: selftests: TDX: Add TDX MMIO reads test
  KVM: selftests: TDX: Add TDX MMIO writes test
  KVM: selftests: TDX: Add TDX CPUID TDVMCALL test

Yan Zhao (1):
  KVM: selftests: TDX: Test LOG_DIRTY_PAGES flag to a non-GUEST_MEMFD
    memslot

 tools/testing/selftests/kvm/Makefile.kvm      |    8 +
 .../testing/selftests/kvm/include/kvm_util.h  |   36 +
 .../selftests/kvm/include/x86/kvm_util_arch.h |    1 +
 .../selftests/kvm/include/x86/processor.h     |    2 +
 .../selftests/kvm/include/x86/tdx/td_boot.h   |   83 ++
 .../kvm/include/x86/tdx/td_boot_asm.h         |   16 +
 .../selftests/kvm/include/x86/tdx/tdcall.h    |   54 +
 .../selftests/kvm/include/x86/tdx/tdx.h       |   67 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |   23 +
 .../selftests/kvm/include/x86/tdx/test_util.h |  133 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |   74 +-
 .../testing/selftests/kvm/lib/x86/processor.c |  108 +-
 .../selftests/kvm/lib/x86/tdx/td_boot.S       |  100 ++
 .../selftests/kvm/lib/x86/tdx/tdcall.S        |  163 +++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c |  243 ++++
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      |  643 +++++++++
 .../selftests/kvm/lib/x86/tdx/test_util.c     |  187 +++
 .../selftests/kvm/x86/tdx_shared_mem_test.c   |  129 ++
 .../testing/selftests/kvm/x86/tdx_upm_test.c  |  461 ++++++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 1254 +++++++++++++++++
 20 files changed, 3742 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/td_boot_asm.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/test_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_shared_mem_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_upm_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_vm_test.c

-- 
2.49.0.504.g3bcea36a83-goog


