Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E290376255B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjGYWCd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjGYWCO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:02:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB0C3AB5
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:01:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c83284edf0eso6435576276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322507; x=1690927307;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ubZcsRueKnG/2tJhq+EPb3SVilVStCRWb952/ddLi8c=;
        b=ud8AM+bppLCLXb7mNMhfT1HFd6fwo+cTKJGi34ouT8C1dTzU25XfOaHvmrDsGlw6GA
         1pzVxszWgv+Le37ynwaAVetaWFdJBakQXKzsFhDUpl28mnFvxes5ahVHm+11Y9T83W97
         tUKXAkVvbGabJzahmjEDZduv8liOIarlNJsf49WtKeyDNa+sdQhPFgQIIzrXsu8qR/uf
         OWjmTCxYLnvKBiY0BLVzWqwh63NDy1aUxgrhHjCkC9E2GF6hVX/obe1jmhAGUC3xSyLQ
         wiJOofY1vkjv0STNHy9kPhkpPC41WhqPBOjXrAlfT+8AERpMDR0pHH+suBZHUuB6grKR
         KfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322507; x=1690927307;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubZcsRueKnG/2tJhq+EPb3SVilVStCRWb952/ddLi8c=;
        b=djWZBotQ4dVePLUImi1hYU31jXbWYfajWWOPrdG4yuIcXC7IAtJYT4t5Xq6LdShjuI
         ZNAc2a1BOjbQvDQQlVfmv+Yvd/oOlmyI19Ty1DBN/ZyrbarZFwh1IyIvj+k5/3enGNIh
         DW6CHnmm13YGjnLSXIVyP8E99ejE/usVs/GQ2maFIbm/zs8wnOzyBq0QexJLoNMN42TI
         Jq7uuf7E6L7khHwvVtvjHtdBDL5phYbO8EVO0EjUkKPcvbdzdqOo8A1CCHF4SBHxA5+y
         KnkuzfEyMQyg65We/D1qgKcZKDT1BhYSbTo9PwDi7Vx2LeVJBgMJG2Z7BM+BHTWzOCW8
         QkGA==
X-Gm-Message-State: ABy/qLagg2fmrfvOB/2zuCK5gSpuXPmGeDesfylY9JsrTFmMmakv+HLp
        ruKHtC4iNNzDWgfW8PXLvTbswNeVHZd8w6VzZogxI7M+VBXEcFzf7ROGOFWPFYBgL+U63OnjA3j
        8c9jWTIUnel7+Oi5+yd62cGMoqxmFYrawvORi/v7XaFVTeDnJwgmAtVawmO6ROQUW3P6pGHAFOp
        ot
X-Google-Smtp-Source: APBJJlHEAfMRm8eWf/ls6DYdKgZ6XdZbDl9DZTTszHVNGIuNrigBJPNT9N5SxYQ3DTQ8R7kkOfSEoUgntfED
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a25:42c4:0:b0:bc0:bfa7:7647 with SMTP id
 p187-20020a2542c4000000b00bc0bfa77647mr2084yba.0.1690322506990; Tue, 25 Jul
 2023 15:01:46 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:00:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-1-afranji@google.com>
Subject: [PATCH v4 00/28] TDX KVM selftests
From:   Ryan Afranji <afranji@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, eesposit@redhat.com,
        borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, ackerleytng@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

This is v4 of the patch series for TDX selftests.

It has been updated for Intel=E2=80=99s v14 of the TDX host patches which w=
as
proposed here:
https://lore.kernel.org/lkml/cover.1685333727.git.isaku.yamahata@intel.com/

The tree can be found at:
https://github.com/googleprodkernel/linux-cc/tree/tdx-selftests-rfc-v4

Changes from RFC v3:

In v14, TDX can only run with UPM enabled so the necessary changes were
made to handle that.

td_vcpu_run() was added to handle TdVmCalls that are now handled in
userspace.

The comments under the patch "KVM: selftests: Require GCC to realign
stacks on function entry" were addressed with the following patch:
https://lore.kernel.org/lkml/Y%2FfHLdvKHlK6D%2F1v@google.com/T/

And other minor tweaks were made to integrate the selftest
infrastructure onto v14.

In RFCv4, TDX selftest code is organized into:

+ headers in tools/testing/selftests/kvm/include/x86_64/tdx/
+ common code in tools/testing/selftests/kvm/lib/x86_64/tdx/
+ selftests in tools/testing/selftests/kvm/x86_64/tdx_*

Dependencies

+ Peter=E2=80=99s patches, which provide functions for the host to allocate
  and track protected memory in the
  guest. https://lore.kernel.org/lkml/20221018205845.770121-1-pgonda@google=
.com/T/

Further work for this patch series/TODOs

+ Sean=E2=80=99s comments for the non-confidential UPM selftests patch seri=
es
  at https://lore.kernel.org/lkml/Y8dC8WDwEmYixJqt@google.com/T/#u apply
  here as well
+ Add ucall support for TDX selftests

I would also like to acknowledge the following people, who helped
review or test patches in RFCv1, RFCv2, and RFCv3:

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

 tools/testing/selftests/kvm/Makefile          |    8 +
 .../selftests/kvm/include/kvm_util_base.h     |   35 +
 .../selftests/kvm/include/x86_64/processor.h  |    4 +
 .../kvm/include/x86_64/tdx/td_boot.h          |   82 +
 .../kvm/include/x86_64/tdx/td_boot_asm.h      |   16 +
 .../selftests/kvm/include/x86_64/tdx/tdcall.h |   59 +
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |   65 +
 .../kvm/include/x86_64/tdx/tdx_util.h         |   19 +
 .../kvm/include/x86_64/tdx/test_util.h        |  164 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  115 +-
 .../selftests/kvm/lib/x86_64/processor.c      |   77 +-
 .../selftests/kvm/lib/x86_64/tdx/td_boot.S    |  101 ++
 .../selftests/kvm/lib/x86_64/tdx/tdcall.S     |  158 ++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        |  262 ++++
 .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   |  565 +++++++
 .../selftests/kvm/lib/x86_64/tdx/test_util.c  |  101 ++
 .../kvm/x86_64/tdx_shared_mem_test.c          |  134 ++
 .../selftests/kvm/x86_64/tdx_upm_test.c       |  469 ++++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 1322 +++++++++++++++++
 19 files changed, 3730 insertions(+), 26 deletions(-)
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
2.41.0.487.g6d72f3e995-goog

