Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044216761F3
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjAUAQH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjAUAQH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:16:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA898F6C4
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:16:05 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k204-20020a256fd5000000b007b8b040bc50so7394283ybc.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O13XsMhe3FapLxKaNj8MRbQZ1Bo+zuL+Id74AOAL1Xo=;
        b=SaD8EG+wEFG08JNVIdCa38YUS+n1ExpCtEFt1+gN0wwtDDRTyXRmnHNuANZfM6N3h6
         4IBqtaEOfPwcxWrnKGiStt3TMn2aujOR3KxkOBg8jZaJhNfMBmiBIYCrgFNLQaqWwjJp
         M/GsqFEo8Dg61tRNkM13z0QFeGlQ9NDSsT5gqrArdWnABP9PxItopjLJk9otjMWepxIY
         rw9hv2fRwV9vPaLfEVQi9HdrILpDDU+R3WGikfHOjxkzMSxE2a4URQDw4My4PFe77Wuj
         N9/J+QdqUzn+aBKIXrisE+SWDBFNmxhVzfAw+z+wq9W1ITK+GtC3u+t4VJN+6DPYVtcF
         4JEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O13XsMhe3FapLxKaNj8MRbQZ1Bo+zuL+Id74AOAL1Xo=;
        b=luxOamzVdZ+I4LFml6INvrEFu0a5HXyTvY+eNHj45zFFfPq2bGfgJ45hbeY8emRrW5
         0QmXF+nPQ+yTjSYyWEeH48VcQ2EXNDaRH9+Gma4HRaRWFQrJuGioiyod2cp6C/J7wRz7
         NIP2ENmjHReApaEbppBQd1kekAt0JVOgRhKwcbG8cGgUi/42ro3isoiCJ8y3AvXtB4VB
         By1yUqCOFzG6Z7VgKnZFwo5b6Yv8imXqdFWfQvT8Hw3+uKNlpGkmFL+6hsHpYqwzUNTx
         pflFOyJ17vq5SF23d/TmckVouPenSZMcgVS5NoVIl2n/hGYebD+cgS2uaX4X+E4p0RLr
         T/UA==
X-Gm-Message-State: AFqh2kpG4AbjvkiHHzYMJP9t2zdT4uxIRebUqVdv8/fk2Yt09NAufU81
        ZAtLbWyHbkwGXvwMDEPpRhSK9df7X78EgsvG6SCH+A0BKObaGCTZBCI48YXO3NDLLBqUg4T54P4
        SVGJKeEdqEzILdDhRKeXafciifsuEbc3aT1TiwnLXSsNjAz5jeH7dnS8UFdYMjxxAoop/jSeSZ9
        X98W984pdoxCg=
X-Google-Smtp-Source: AMrXdXvE4UxHSPt0jkUbjVScWwtHv+JfvxzKfDaUOpaJjockRZgYQA7m9flG5b3pUI8zx4lcw4+eDyS3Grl32fVvEw==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a05:690c:31c:b0:4fa:7af6:5321 with
 SMTP id bg28-20020a05690c031c00b004fa7af65321mr1035841ywb.451.1674260164370;
 Fri, 20 Jan 2023 16:16:04 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-1-ackerleytng@google.com>
Subject: [RFC PATCH v3 00/31] TDX KVM selftests
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

This is v3 of the patch series for TDX selftests.

It has been updated for Intel=E2=80=99s V10 of the TDX host patches which w=
as
proposed in https://lkml.org/lkml/2022/8/8/877

The tree can be found at
https://github.com/googleprodkernel/linux-cc/tree/tdx-selftests-rfc-v3/

Changes from RFC v2:

Selftest setup now builds upon the KVM selftest framework when setting
up the guest for testing. We now use the KVM selftest framework to
build the guest page tables and load the ELF binary into guest memory.

Inlining of the entire guest image is no longer required and that
allows us to cleanly separate code into different compilation units
and be able to use proper assembly instead of inline assembly
(addresses Sean=E2=80=99s comment).

To achieve this, we take a dependency on the SEV VM tests:
https://lore.kernel.org/lkml/20221018205845.770121-1-pgonda@google.com/T/. =
Those
patches provide functions for the host to allocate and track protected
memory in the guest.

In RFCv3, TDX selftest code is organized into:

+ headers in tools/testing/selftests/kvm/include/x86_64/tdx/
+ common code in tools/testing/selftests/kvm/lib/x86_64/tdx/
+ selftests in tools/testing/selftests/kvm/x86_64/tdx_*

RFCv3 also adds additional selftests for UPM.

Dependencies

+ Peter=E2=80=99s patches, which provide functions for the host to allocate
  and track protected memory in the
  guest. https://lore.kernel.org/lkml/20221018205845.770121-1-pgonda@google=
.com/T/
+ Peter=E2=80=99s patches depend on Sean=E2=80=99s patches:
    + https://lore.kernel.org/linux-arm-kernel/20220825232522.3997340-1-sea=
njc@google.com/T/
    + https://lore.kernel.org/lkml/20221006004512.666529-1-seanjc@google.co=
m/T/
+ Proposed fixes for these these issues mentioned on the mailing list
    + https://lore.kernel.org/lkml/36cde6d6-128d-884e-1447-09b08bb5de3d@int=
el.com/
    + https://lore.kernel.org/lkml/diqzedtubs0d.fsf@google.com/
    + https://lore.kernel.org/lkml/67b782ee-c95c-d6bc-3cca-cdfe75f4bf6a@int=
el.com/
    + https://lore.kernel.org/lkml/diqzcz7cd983.fsf@ackerleytng-cloudtop-sg=
.c.googlers.com/
    + https://lore.kernel.org/linux-mm/20221116205025.1510291-1-ackerleytng=
@google.com/

Further work for this patch series/TODOs

+ Sean=E2=80=99s comments for the non-confidential UPM selftests patch seri=
es
  at https://lore.kernel.org/lkml/Y8dC8WDwEmYixJqt@google.com/T/#u apply
  here as well
+ Add ucall support for TDX selftests

I would also like to acknowledge the following people, who helped
review or test patches in RFCv1 and RFCv2:

+ Sean Christopherson <seanjc@google.com>
+ Zhenzhong Duan <zhenzhong.duan@intel.com>
+ Peter Gonda <pgonda@google.com>
+ Andrew Jones <drjones@redhat.com>
+ Maxim Levitsky <mlevitsk@redhat.com>
+ Xiaoyao Li <xiaoyao.li@intel.com>
+ David Matlack <dmatlack@google.com>
+ Marc Orr <marcorr@google.com>
+ Isaku Yamahata <isaku.yamahata@gmail.com>

Links to earlier patch series

+ RFC v1: https://lore.kernel.org/lkml/20210726183816.1343022-1-erdemaktas@=
google.com/T/#u
+ RFC v2: https://lore.kernel.org/lkml/20220830222000.709028-1-sagis@google=
.com/T/#u

Ackerley Tng (14):
  KVM: selftests: Add function to allow one-to-one GVA to GPA mappings
  KVM: selftests: Expose function that sets up sregs based on VM's mode
  KVM: selftests: Store initial stack address in struct kvm_vcpu
  KVM: selftests: Refactor steps in vCPU descriptor table initialization
  KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to validate TDs'
    attribute configuration
  KVM: selftests: Require GCC to realign stacks on function entry
  KVM: selftests: Add functions to allow mapping as shared
  KVM: selftests: Add support for restricted memory
  KVM: selftests: TDX: Update load_td_memory_region for VM memory backed
    by restricted memfd
  KVM: selftests: Expose _vm_vaddr_alloc
  KVM: selftests: TDX: Add support for TDG.MEM.PAGE.ACCEPT
  KVM: selftests: TDX: Add support for TDG.VP.VEINFO.GET
  KVM: selftests: TDX: Add TDX UPM selftest
  KVM: selftests: TDX: Add TDX UPM selftests for implicit conversion

Erdem Aktas (4):
  KVM: selftests: Add support for creating non-default type VMs
  KVM: selftests: Add helper functions to create TDX VMs
  KVM: selftests: TDX: Add TDX lifecycle test
  KVM: selftests: TDX: Adding test case for TDX port IO

Roger Wang (1):
  KVM: selftests: TDX: Add TDG.VP.INFO test

Ryan Afranji (2):
  KVM: selftests: TDX: Verify the behavior when host consumes a TD
    private memory
  KVM: selftests: TDX: Add shared memory test

Sagi Shahar (10):
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

 tools/testing/selftests/kvm/.gitignore        |    3 +
 tools/testing/selftests/kvm/Makefile          |   10 +-
 .../selftests/kvm/include/kvm_util_base.h     |   43 +-
 .../testing/selftests/kvm/include/test_util.h |    2 +
 .../selftests/kvm/include/x86_64/processor.h  |    4 +
 .../kvm/include/x86_64/tdx/td_boot.h          |   82 +
 .../kvm/include/x86_64/tdx/td_boot_asm.h      |   16 +
 .../selftests/kvm/include/x86_64/tdx/tdcall.h |   59 +
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |   65 +
 .../kvm/include/x86_64/tdx/tdx_util.h         |   19 +
 .../kvm/include/x86_64/tdx/test_util.h        |  164 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  123 +-
 tools/testing/selftests/kvm/lib/test_util.c   |    7 +
 .../selftests/kvm/lib/x86_64/processor.c      |   77 +-
 tools/testing/selftests/kvm/lib/x86_64/sev.c  |    2 +-
 .../selftests/kvm/lib/x86_64/tdx/td_boot.S    |  101 ++
 .../selftests/kvm/lib/x86_64/tdx/tdcall.S     |  158 ++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        |  231 +++
 .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   |  562 +++++++
 .../selftests/kvm/lib/x86_64/tdx/test_util.c  |  101 ++
 .../kvm/x86_64/tdx_shared_mem_test.c          |  137 ++
 .../selftests/kvm/x86_64/tdx_upm_test.c       |  460 ++++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 1329 +++++++++++++++++
 23 files changed, 3709 insertions(+), 46 deletions(-)
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

--
2.39.0.246.g2a6d74b583-goog
