Return-Path: <linux-kselftest+bounces-1723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B6E80F812
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBC31C20DA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DA56414C;
	Tue, 12 Dec 2023 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jkjtlyc1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F0FBD
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:00 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d0b944650bso29196195ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414020; x=1703018820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/7dr6LesSd6J0D4aMekJuWGTOXlB00/XOYyVR4kkX9o=;
        b=Jkjtlyc1NE1k+yb7l8hdk36VbGfORZuTzgmD+23nvMxiOKbYIv+yKeQmX8HruwUnwT
         zjwab4FYI1Vrj0kob5dJLXukWz+HGc1BeOqLhdQqDeC0DRPgDbC7dbSIKGch1QxIhGeQ
         sCe7PUh53BEvpLgaPyDE4sNqgydh/ZTRhSpiixDCJXlJNesJ6oxeiSUCCQm8Gu2bhQzh
         aEx0XQhdobsVzkwY2aFStcCaa3BQerGs+ZYaDdEFO21RI9yc1ZxoQJPTfLAsFAB4v5va
         jDv/6P3VMCG2qdrygO+EHo2hTRd5oZZoXbzwrOxz9jKsMIlrMa0Ka+m+uYXJ3rzXmtFl
         /8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414020; x=1703018820;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7dr6LesSd6J0D4aMekJuWGTOXlB00/XOYyVR4kkX9o=;
        b=ugcRwy0O8RxzzwJ0+I6LxxiV3cRJgFzdAwO+Dj4aiFTwwqZCYYpBKSyJARUn4Z0plS
         HhKuUc5vAkaALp5KE9gr/LO4uxS03U6059cuyVvH0KVCT8OJ90m0FWJhRcE8lnZawlks
         p3YY9/vwsvQE6FvIF1K/RagaPWylgF0BIRXaJNSNa/AFmFKFQx0wXnWwu9iBPJaPrNqW
         uIl9u3M65ZGYPtIPPBoJca9jf0htLpuDyETNUIxiU1o1fevg3vm0VYEYHBk9TNgs85eB
         5RcLIRhMPIfevLWC1yvcwluZ0h2haBg2QSJfRB1bPLR4D/uXdwPrnPzgNwPTxXDtA0au
         VWOQ==
X-Gm-Message-State: AOJu0Yw4QgktMTqiprM52YFN8IvNZTkkv/1ETrOwhRbFWoJDJdtEsz7I
	4u7ZV5jYFvKZWYXY52b//uqS8KTZNxOv3gxL4VTJjtajVPbGka+BIqjG+ttFrjPnLYuF17NrZUT
	xepdsigPffEooP1IUFZ0+hopJZIg05S3kNz0gpYpnRzrA5WE8PB7SP+9GIvpc+9tx8OCduAE=
X-Google-Smtp-Source: AGHT+IEfcl1fpngZWor1J98CNRcmX2Te7PCQfMM2bpoJPUISib0v7zYmBv6kzfWIo6aCYm3tYDv2DEXrEA==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:903:32c8:b0:1d0:902c:e834 with SMTP id
 i8-20020a17090332c800b001d0902ce834mr53461plr.12.1702414017857; Tue, 12 Dec
 2023 12:46:57 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:15 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-1-sagis@google.com>
Subject: [RFC PATCH v5 00/29] TDX KVM selftests
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Sagi Shahar <sagis@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>, jmattson@google.com, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

This is v4 of the patch series for TDX selftests.

It has been updated for Intel=E2=80=99s v17 of the TDX host patches which w=
as
proposed here:
https://lore.kernel.org/all/cover.1699368322.git.isaku.yamahata@intel.com/

The tree can be found at:
https://github.com/googleprodkernel/linux-cc/tree/tdx-selftests-rfc-v5

Changes from RFC v4:

Added patch to propagate KVM_EXIT_MEMORY_FAULT to userspace.

Minor tweaks to align the tests to the new TDX 1.5 spec such as changes
in the expected values in TDG.VP.INFO.

In RFCv5, TDX selftest code is organized into:

+ headers in tools/testing/selftests/kvm/include/x86_64/tdx/
+ common code in tools/testing/selftests/kvm/lib/x86_64/tdx/
+ selftests in tools/testing/selftests/kvm/x86_64/tdx_*

Dependencies

+ Peter=E2=80=99s patches, which provide functions for the host to allocate
  and track protected memory in the guest.
  https://lore.kernel.org/all/20230110175057.715453-1-pgonda@google.com/

Further work for this patch series/TODOs

+ Sean=E2=80=99s comments for the non-confidential UPM selftests patch seri=
es
  at https://lore.kernel.org/lkml/Y8dC8WDwEmYixJqt@google.com/T/#u apply
  here as well
+ Add ucall support for TDX selftests

I would also like to acknowledge the following people, who helped
review or test patches in previous versions:

+ Sean Christopherson <seanjc@google.com>
+ Zhenzhong Duan <zhenzhong.duan@intel.com>
+ Peter Gonda <pgonda@google.com>
+ Andrew Jones <drjones@redhat.com>
+ Maxim Levitsky <mlevitsk@redhat.com>
+ Xiaoyao Li <xiaoyao.li@intel.com>
+ David Matlack <dmatlack@google.com>
+ Marc Orr <marcorr@google.com>
+ Isaku Yamahata <isaku.yamahata@gmail.com>
+ Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Links to earlier patch series

+ RFC v1: https://lore.kernel.org/lkml/20210726183816.1343022-1-erdemaktas@=
google.com/T/#u
+ RFC v2: https://lore.kernel.org/lkml/20220830222000.709028-1-sagis@google=
.com/T/#u
+ RFC v3: https://lore.kernel.org/lkml/20230121001542.2472357-1-ackerleytng=
@google.com/T/#u
+ RFC v4: https://lore.kernel.org/lkml/20230725220132.2310657-1-afranji@goo=
gle.com/

*** BLURB HERE ***

Ackerley Tng (12):
  KVM: selftests: Add function to allow one-to-one GVA to GPA mappings
  KVM: selftests: Expose function that sets up sregs based on VM's mode
  KVM: selftests: Store initial stack address in struct kvm_vcpu
  KVM: selftests: Refactor steps in vCPU descriptor table initialization
  KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to validate TDs'
    attribute configuration
  KVM: selftests: TDX: Update load_td_memory_region for VM memory backed
    by guest memfd
  KVM: selftests: Add functions to allow mapping as shared
  KVM: selftests: Expose _vm_vaddr_alloc
  KVM: selftests: TDX: Add support for TDG.MEM.PAGE.ACCEPT
  KVM: selftests: TDX: Add support for TDG.VP.VEINFO.GET
  KVM: selftests: TDX: Add TDX UPM selftest
  KVM: selftests: TDX: Add TDX UPM selftests for implicit conversion

Erdem Aktas (3):
  KVM: selftests: Add helper functions to create TDX VMs
  KVM: selftests: TDX: Add TDX lifecycle test
  KVM: selftests: TDX: Adding test case for TDX port IO

Roger Wang (1):
  KVM: selftests: TDX: Add TDG.VP.INFO test

Ryan Afranji (2):
  KVM: selftests: TDX: Verify the behavior when host consumes a TD
    private memory
  KVM: selftests: TDX: Add shared memory test

Sagi Shahar (11):
  KVM: selftests: TDX: Add report_fatal_error test
  KVM: selftests: TDX: Add basic TDX CPUID test
  KVM: selftests: TDX: Add basic get_td_vmcall_info test
  KVM: selftests: TDX: Add TDX IO writes test
  KVM: selftests: TDX: Add TDX IO reads test
  KVM: selftests: TDX: Add TDX MSR read/write tests
  KVM: selftests: TDX: Add TDX HLT exit test
  KVM: selftests: TDX: Add TDX MMIO reads test
  KVM: selftests: TDX: Add TDX MMIO writes test
  KVM: selftests: TDX: Add TDX CPUID TDVMCALL test
  KVM: selftests: Propagate KVM_EXIT_MEMORY_FAULT to userspace

 tools/testing/selftests/kvm/Makefile          |    8 +
 .../selftests/kvm/include/kvm_util_base.h     |   30 +
 .../selftests/kvm/include/x86_64/processor.h  |    4 +
 .../kvm/include/x86_64/tdx/td_boot.h          |   82 +
 .../kvm/include/x86_64/tdx/td_boot_asm.h      |   16 +
 .../selftests/kvm/include/x86_64/tdx/tdcall.h |   59 +
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |   65 +
 .../kvm/include/x86_64/tdx/tdx_util.h         |   19 +
 .../kvm/include/x86_64/tdx/test_util.h        |  164 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  101 +-
 .../selftests/kvm/lib/x86_64/processor.c      |   77 +-
 .../selftests/kvm/lib/x86_64/tdx/td_boot.S    |  101 ++
 .../selftests/kvm/lib/x86_64/tdx/tdcall.S     |  158 ++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        |  262 ++++
 .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   |  558 +++++++
 .../selftests/kvm/lib/x86_64/tdx/test_util.c  |  101 ++
 .../kvm/x86_64/tdx_shared_mem_test.c          |  135 ++
 .../selftests/kvm/x86_64/tdx_upm_test.c       |  469 ++++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 1319 +++++++++++++++++
 19 files changed, 3693 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/td_boot.=
h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/td_boot_=
asm.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util=
.h
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/test_uti=
l.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/td_boot.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_shared_mem_test.=
c
 create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c

--=20
2.43.0.472.g3155946c3a-goog


