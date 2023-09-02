Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE727907DC
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Sep 2023 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjIBMue (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Sep 2023 08:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjIBMue (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Sep 2023 08:50:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C2B132;
        Sat,  2 Sep 2023 05:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693659031; x=1725195031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1yJ8TMy38aSsT7Y7ApKktxIaSJdCAx0h8LuoNfgnrN8=;
  b=COg/hnZXRatWSN6ZwynEbGLeIoJy5hrF6o0E6kv1j3IB1yYO+KERWFbD
   ihjF8gswNo6jIjMf8/LMJN+br37e6+1Qqphe7wHBKnaLPFfjEkMN31xdN
   kdrFVKcUgt0nknR7uNjw39Gp/idI7DmeWuIUpKS1HVTziOAeG1uIJx2eR
   S2TJmjLbWUGiholORBj6R64gyzDRxMPgQg5haFxIdii87D6nm6iY6Dn0M
   EpbDVvLfBbBnesR3zlD8WEW500ITZyWxQkxMiAo3BLmor1IevMvP/Iqcl
   vMVFqWQlqgQ87HYo/IZjUS1qosuZrERMVimcVqsyftlq/bFgJQD2FfA0B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="366599144"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="366599144"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 05:50:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="855021919"
X-IronPort-AV: E=Sophos;i="6.02,222,1688454000"; 
   d="scan'208";a="855021919"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 05:50:21 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, wchen <waylingii@gmail.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Lei Wang <lei4.wang@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Thomas Huth <thuth@redhat.com>, Like Xu <likexu@tencent.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Michal Luczaj <mhal@rbox.co>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v2 0/8] RISCV: Add kvm Sstc timer selftest
Date:   Sat,  2 Sep 2023 20:59:22 +0800
Message-Id: <cover.1693659382.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The RISC-V arch_timer selftest is used to validate Sstc timer
functionality in a guest, which sets up periodic timer interrupts
and check the basic interrupt status upon its receipt.

This KVM selftest was ported from aarch64 arch_timer and tested
with Linux v6.5-rc5 on a Qemu riscv64 virt machine.

---
Changed since v1:
  * Rebase to kvm-riscv/riscv_kvm_next
  * Cherry-pick Sean's kselftest guest printf patch set
    https://lore.kernel.org/all/20230729003643.1053367-1-seanjc@google.com/
  * Copy the entire csr.h verbatim
  * Unified the function names for exception vector table setup
    void vm_init_vector_tables(struct kvm_vm *vm);
    void vcpu_init_vector_tables(struct kvm_vcpu *vcpu);
  * Format the handler.S asm file per Andrew's comments
  * Consolidate the timer test code for arm64 and riscv
    based on Andrew's and Sean's suggestion

Haibo Xu (8):
  KVM: selftests: Unify the codes for guest exception handling
  KVM: arm64: selftest: Split arch_timer test code
  tools: riscv: Add header file csr.h
  KVM: riscv: selftests: Switch to use macro from csr.h
  KVM: riscv: selftests: Add exception handling support
  KVM: riscv: selftests: Add guest helper to get vcpu id
  KVM: riscv: selftest: Change vcpu_has_ext to a common function
  KVM: riscv: selftests: Add sstc timer test

 tools/arch/riscv/include/asm/csr.h            | 521 ++++++++++++++++++
 tools/testing/selftests/kvm/Makefile          |  11 +-
 .../selftests/kvm/aarch64/arch_timer.c        | 292 +---------
 .../selftests/kvm/aarch64/debug-exceptions.c  |   4 +-
 .../selftests/kvm/aarch64/page_fault_test.c   |   4 +-
 .../testing/selftests/kvm/aarch64/vgic_irq.c  |   4 +-
 tools/testing/selftests/kvm/arch_timer.c      | 261 +++++++++
 .../selftests/kvm/include/aarch64/processor.h |  12 +-
 .../selftests/kvm/include/kvm_util_base.h     |   9 +
 .../selftests/kvm/include/riscv/arch_timer.h  |  80 +++
 .../selftests/kvm/include/riscv/processor.h   |  60 +-
 .../selftests/kvm/include/timer_test.h        |  58 ++
 .../selftests/kvm/include/x86_64/processor.h  |   5 -
 .../selftests/kvm/lib/aarch64/processor.c     |   6 +-
 .../selftests/kvm/lib/riscv/handlers.S        | 101 ++++
 .../selftests/kvm/lib/riscv/processor.c       |  86 +++
 .../selftests/kvm/lib/x86_64/processor.c      |   4 +-
 .../testing/selftests/kvm/riscv/arch_timer.c  | 130 +++++
 .../selftests/kvm/riscv/get-reg-list.c        |  14 -
 tools/testing/selftests/kvm/x86_64/amx_test.c |   4 +-
 .../selftests/kvm/x86_64/fix_hypercall_test.c |   4 +-
 .../selftests/kvm/x86_64/hyperv_evmcs.c       |   4 +-
 .../selftests/kvm/x86_64/hyperv_features.c    |   8 +-
 .../testing/selftests/kvm/x86_64/hyperv_ipi.c |   6 +-
 .../selftests/kvm/x86_64/kvm_pv_test.c        |   4 +-
 .../selftests/kvm/x86_64/monitor_mwait_test.c |   4 +-
 .../kvm/x86_64/pmu_event_filter_test.c        |   8 +-
 .../smaller_maxphyaddr_emulation_test.c       |   4 +-
 .../selftests/kvm/x86_64/svm_int_ctl_test.c   |   4 +-
 .../kvm/x86_64/svm_nested_shutdown_test.c     |   4 +-
 .../kvm/x86_64/svm_nested_soft_inject_test.c  |   4 +-
 .../kvm/x86_64/ucna_injection_test.c          |   8 +-
 .../kvm/x86_64/userspace_msr_exit_test.c      |   4 +-
 .../vmx_exception_with_invalid_guest_state.c  |   4 +-
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |   4 +-
 .../selftests/kvm/x86_64/xapic_ipi_test.c     |   4 +-
 .../selftests/kvm/x86_64/xcr0_cpuid_test.c    |   4 +-
 .../selftests/kvm/x86_64/xen_shinfo_test.c    |   4 +-
 38 files changed, 1376 insertions(+), 376 deletions(-)
 create mode 100644 tools/arch/riscv/include/asm/csr.h
 create mode 100644 tools/testing/selftests/kvm/arch_timer.c
 create mode 100644 tools/testing/selftests/kvm/include/riscv/arch_timer.h
 create mode 100644 tools/testing/selftests/kvm/include/timer_test.h
 create mode 100644 tools/testing/selftests/kvm/lib/riscv/handlers.S
 create mode 100644 tools/testing/selftests/kvm/riscv/arch_timer.c

-- 
2.34.1

