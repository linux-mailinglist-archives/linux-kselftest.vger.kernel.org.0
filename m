Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21C179F646
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 03:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjINB2B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 21:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjINB2A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 21:28:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FAD1BD1;
        Wed, 13 Sep 2023 18:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694654876; x=1726190876;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ueE/011k9DiwV0Anf9SWAZccz4IuGXFEGSyhfc+Fk0k=;
  b=DfQuoVf5XhvkZwpdK1eoYwINamWBmIwKEM8v2zvkqyJvs0jRrukzeC1G
   GLh7IVjm7cQaLit+KIUKVlImqK/7VQzcywhCA0FjENG52xqtivS2DdRyS
   bVIQRcbm+4Dt8P1mWmWgSTILE+4wdP3eOogXAlPY4MQzI7Z56qirQpb+M
   XoubkjgdATql7y8+S3w35PrJIugrA2jXs3ax266DfwU602BOdvxUclgXn
   RYXszGcLCjH2/mOAs+LfUv+XpEXC6eZXWj+oh8a2lYqt+9tewvRV5TEUk
   55qECN7f5eQGFefAyDzxcmuqhygpVayLugyqKdo9ia8yjVCVsZkEbfHDT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377733953"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="377733953"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 18:27:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="694048860"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="694048860"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 18:27:48 -0700
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
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Like Xu <likexu@tencent.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Thomas Huth <thuth@redhat.com>,
        Colton Lewis <coltonlewis@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v3 0/9] RISCV: Add kvm Sstc timer selftests
Date:   Thu, 14 Sep 2023 09:36:54 +0800
Message-Id: <cover.1694421911.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The RISC-V arch_timer selftests is used to validate Sstc timer
functionality in a guest, which sets up periodic timer interrupts
and check the basic interrupt status upon its receipt.

This KVM selftests was ported from aarch64 arch_timer and tested
with Linux v6.6-rc1 on a Qemu riscv64 virt machine.

---
Changed since v2:
  * Rebase to Linux 6.6-rc1
  * Add separate patch for kvm/Makefile improvement
  * Move aarch64 specific macros to aarch64/arch_timer.c
  * Add -DCONFIG_64BIT to kvm/Makefile CFLAGS to ensure
    only 64bit registers were available in csr.h
  * Avoid some #ifdef in kvm/arch_timer.c by setting some
    aarch64 specific variable to 0 on risc-v

Haibo Xu (9):
  KVM: selftests: Unify the codes for guest exception handling
  KVM: selftests: Unify the makefile rule for split targets
  KVM: arm64: selftests: Split arch_timer test code
  tools: riscv: Add header file csr.h
  KVM: riscv: selftests: Switch to use macro from csr.h
  KVM: riscv: selftests: Add exception handling support
  KVM: riscv: selftests: Add guest helper to get vcpu id
  KVM: riscv: selftests: Change vcpu_has_ext to a common function
  KVM: riscv: selftests: Add sstc timer test

 tools/arch/riscv/include/asm/csr.h            | 521 ++++++++++++++++++
 tools/testing/selftests/kvm/Makefile          |  14 +-
 .../selftests/kvm/aarch64/arch_timer.c        | 291 +---------
 .../selftests/kvm/aarch64/debug-exceptions.c  |   4 +-
 .../selftests/kvm/aarch64/page_fault_test.c   |   4 +-
 .../testing/selftests/kvm/aarch64/vgic_irq.c  |   4 +-
 tools/testing/selftests/kvm/arch_timer.c      | 250 +++++++++
 .../selftests/kvm/include/aarch64/processor.h |  12 +-
 .../selftests/kvm/include/kvm_util_base.h     |   9 +
 .../selftests/kvm/include/riscv/arch_timer.h  |  80 +++
 .../selftests/kvm/include/riscv/processor.h   |  63 ++-
 .../testing/selftests/kvm/include/test_util.h |   2 +
 .../selftests/kvm/include/timer_test.h        |  43 ++
 .../selftests/kvm/include/x86_64/processor.h  |   5 -
 .../selftests/kvm/lib/aarch64/processor.c     |   6 +-
 .../selftests/kvm/lib/riscv/handlers.S        | 101 ++++
 .../selftests/kvm/lib/riscv/processor.c       |  86 +++
 .../selftests/kvm/lib/x86_64/processor.c      |   4 +-
 .../testing/selftests/kvm/riscv/arch_timer.c  | 107 ++++
 .../selftests/kvm/riscv/get-reg-list.c        |  16 +-
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
 39 files changed, 1338 insertions(+), 374 deletions(-)
 create mode 100644 tools/arch/riscv/include/asm/csr.h
 create mode 100644 tools/testing/selftests/kvm/arch_timer.c
 create mode 100644 tools/testing/selftests/kvm/include/riscv/arch_timer.h
 create mode 100644 tools/testing/selftests/kvm/include/timer_test.h
 create mode 100644 tools/testing/selftests/kvm/lib/riscv/handlers.S
 create mode 100644 tools/testing/selftests/kvm/riscv/arch_timer.c

-- 
2.34.1

