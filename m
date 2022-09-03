Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71905ABC09
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Sep 2022 03:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiICB3I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Sep 2022 21:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiICB3I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Sep 2022 21:29:08 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B13EEF0C
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Sep 2022 18:29:07 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id f128-20020a636a86000000b004340efec1faso36062pgc.4
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Sep 2022 18:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=zLFYPEVszfNpW6dCutbkzHT/LYTZJZBJHTuaDoaj/cE=;
        b=jduT6xdjGBEpUaZZI4/ZP9lwMs8afG7T8AbeScf86NEDtTl3FPIPdc5ZefkA3jIrDj
         Bwb3/DP5hlGZY0WU3YZpC5AglW3nbor5Zb/S961uBOb3PUmk7Udw1GQ54mX1dNwk2jPI
         noQNbXLcB4uoecphVEXOx8qyF64OLSPdkp5kRKQ40qZtBN9TNL8jJOLNR5Qj1qWQf22C
         VZf2Oer2GQYEIYNZQgsTsx8MKpiIT0bwQfRO4eB4SchDYHhXAng2I65osVf2BG7qAN7I
         PaEOhkYpuXWewR8O1cB7p9EM3Jjvlow8cWj5mMfdLwCu8QGWMEC+jR2eMfeJ2zXg6bmN
         VquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=zLFYPEVszfNpW6dCutbkzHT/LYTZJZBJHTuaDoaj/cE=;
        b=yQNsr9TehDb/giSLGQRynyrcMb6gUUmxP+PLRE8vRBvKBchqiJa3Vh7oeLsFo4itcZ
         AhkhBLtXXcoZMMR7QKuCE6IgU5sOdvU2gL1sxuD08WAca/z1CDjdVWb4KoIxn4ZSQnA3
         COxJSS9NVaFISkujsXfQUstPJ+nfpMZ2zlqVZme7BcMykEaurda+tRYXkPQikkuHVc0+
         w/Xzw2aHNROEsxWpqUN1gjUzg3GgGwIIN3OeqDytKlZ4i2sIIj2wZJnZsGILI/8ruh2u
         aEPGGvxTwoDey37cFv3SA1V9r/tlyS4bgH09qFta1DzxEDlMhP6oPjAiD3V2rWuLkZ02
         B6xQ==
X-Gm-Message-State: ACgBeo3TfebFSmQBZRAP/1LI7UxpBCWgZZgcaT7qkTSMLoRRIWn6FWIj
        40sHBkSo8BobWCoBCqm3ky2xNSN8aGfvJy9f
X-Google-Smtp-Source: AA6agR66rzFlSrfpXOBJSYUMRES0YBW3NRHNhBL90Jx4+4OKfXFQ2RxhLBsioUbgHaLkY0WBRQnAVizY/BrawuDR
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a62:27c1:0:b0:536:32d2:d098 with SMTP
 id n184-20020a6227c1000000b0053632d2d098mr39234197pfn.63.1662168546414; Fri,
 02 Sep 2022 18:29:06 -0700 (PDT)
Date:   Sat,  3 Sep 2022 01:28:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220903012849.938069-1-vannapurve@google.com>
Subject: [V1 PATCH 0/5] Execute hypercalls from guests according to cpu type
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, drjones@redhat.com, dmatlack@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series is posted in context of the discussion at:
https://lore.kernel.org/lkml/Ywa9T+jKUpaHLu%2Fl@google.com/

Major changes:
1) Move common startup logic to a single common main function in
kvm_util.c
2) Introduce following APIs:
	kvm_arch_main: to perform arch specific common startup.
	kvm_post_vm_load: to update the guest memory state to convey
		common information to guests.
3) For x86, capture cpu type at startup and pass on the cpu type to
guest after guest elf is loaded.
4) Execute hypercall instruction from within guest VMs according to the
cpu type. This will help prevent an extra kvm exit during hypercall
execution.

Vishal Annapurve (5):
  selftests: kvm: move common startup logic to kvm_util.c
  selftests: kvm: Introduce kvm_arch_main and helpers
  selftests: kvm: x86: Execute vmcall/vmmcall according to CPU type
  selftests: kvm: delete svm_vmcall_test
  selftests: kvm: Execute vmcall/vmmcall as per cpu type

 tools/testing/selftests/kvm/.gitignore        |  1 -
 .../selftests/kvm/aarch64/arch_timer.c        |  5 +-
 .../selftests/kvm/aarch64/debug-exceptions.c  |  2 +-
 .../selftests/kvm/aarch64/get-reg-list.c      |  2 +-
 .../selftests/kvm/aarch64/hypercalls.c        |  4 +-
 .../testing/selftests/kvm/aarch64/psci_test.c |  2 +-
 .../selftests/kvm/aarch64/vcpu_width_config.c |  2 +-
 .../testing/selftests/kvm/aarch64/vgic_init.c |  2 +-
 .../testing/selftests/kvm/aarch64/vgic_irq.c  |  5 +-
 .../selftests/kvm/access_tracking_perf_test.c |  4 +-
 .../selftests/kvm/demand_paging_test.c        |  7 +-
 .../selftests/kvm/dirty_log_perf_test.c       |  4 +-
 tools/testing/selftests/kvm/dirty_log_test.c  |  4 +-
 .../selftests/kvm/hardware_disable_test.c     |  2 +-
 .../selftests/kvm/include/kvm_util_base.h     | 15 ++++
 .../selftests/kvm/include/x86_64/processor.h  | 10 +++
 .../selftests/kvm/include/x86_64/vmx.h        |  9 ---
 .../selftests/kvm/kvm_binary_stats_test.c     |  3 +-
 .../selftests/kvm/kvm_create_max_vcpus.c      |  4 +-
 .../selftests/kvm/kvm_page_table_test.c       |  4 +-
 .../selftests/kvm/lib/aarch64/processor.c     |  8 ++
 tools/testing/selftests/kvm/lib/elf.c         |  2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 12 +++
 .../selftests/kvm/lib/riscv/processor.c       |  8 ++
 .../selftests/kvm/lib/s390x/processor.c       |  8 ++
 tools/testing/selftests/kvm/lib/sparsebit.c   |  2 +-
 .../selftests/kvm/lib/x86_64/perf_test_util.c |  2 +-
 .../selftests/kvm/lib/x86_64/processor.c      | 38 +++++++++-
 .../selftests/kvm/max_guest_memory_test.c     |  2 +-
 .../kvm/memslot_modification_stress_test.c    |  4 +-
 .../testing/selftests/kvm/memslot_perf_test.c |  9 +--
 tools/testing/selftests/kvm/rseq_test.c       |  7 +-
 tools/testing/selftests/kvm/s390x/memop.c     |  4 +-
 tools/testing/selftests/kvm/s390x/resets.c    |  4 +-
 .../selftests/kvm/s390x/sync_regs_test.c      |  5 +-
 tools/testing/selftests/kvm/s390x/tprot.c     |  2 +-
 .../selftests/kvm/set_memory_region_test.c    |  7 +-
 tools/testing/selftests/kvm/steal_time.c      |  4 +-
 .../kvm/system_counter_offset_test.c          |  2 +-
 tools/testing/selftests/kvm/x86_64/amx_test.c |  2 +-
 .../testing/selftests/kvm/x86_64/cpuid_test.c |  2 +-
 .../kvm/x86_64/cr4_cpuid_sync_test.c          |  6 +-
 .../testing/selftests/kvm/x86_64/debug_regs.c |  4 +-
 .../kvm/x86_64/emulator_error_test.c          |  7 +-
 .../testing/selftests/kvm/x86_64/evmcs_test.c |  2 +-
 .../selftests/kvm/x86_64/fix_hypercall_test.c |  2 +-
 .../kvm/x86_64/get_msr_index_features.c       |  2 +-
 .../selftests/kvm/x86_64/hyperv_clock.c       |  2 +-
 .../selftests/kvm/x86_64/hyperv_cpuid.c       |  7 +-
 .../selftests/kvm/x86_64/hyperv_features.c    |  2 +-
 .../selftests/kvm/x86_64/hyperv_svm_test.c    |  2 +-
 .../selftests/kvm/x86_64/kvm_clock_test.c     |  2 +-
 .../selftests/kvm/x86_64/kvm_pv_test.c        |  2 +-
 .../kvm/x86_64/max_vcpuid_cap_test.c          |  3 +-
 .../selftests/kvm/x86_64/mmio_warning_test.c  |  4 +-
 .../selftests/kvm/x86_64/monitor_mwait_test.c |  3 +-
 .../selftests/kvm/x86_64/nx_huge_pages_test.c |  4 +-
 .../selftests/kvm/x86_64/platform_info_test.c |  7 +-
 .../kvm/x86_64/pmu_event_filter_test.c        |  7 +-
 .../selftests/kvm/x86_64/set_boot_cpu_id.c    |  2 +-
 .../selftests/kvm/x86_64/set_sregs_test.c     |  7 +-
 .../selftests/kvm/x86_64/sev_migrate_tests.c  |  3 +-
 tools/testing/selftests/kvm/x86_64/smm_test.c |  4 +-
 .../testing/selftests/kvm/x86_64/state_test.c | 10 +--
 .../selftests/kvm/x86_64/svm_int_ctl_test.c   |  3 +-
 .../kvm/x86_64/svm_nested_soft_inject_test.c  |  7 +-
 .../selftests/kvm/x86_64/svm_vmcall_test.c    | 74 -------------------
 .../selftests/kvm/x86_64/sync_regs_test.c     |  7 +-
 .../kvm/x86_64/triple_fault_event_test.c      |  2 +-
 .../selftests/kvm/x86_64/tsc_msrs_test.c      |  4 +-
 .../selftests/kvm/x86_64/tsc_scaling_sync.c   |  3 +-
 .../kvm/x86_64/ucna_injection_test.c          |  2 +-
 .../selftests/kvm/x86_64/userspace_io_test.c  |  6 +-
 .../kvm/x86_64/userspace_msr_exit_test.c      |  7 +-
 .../kvm/x86_64/vmx_apic_access_test.c         |  5 +-
 .../kvm/x86_64/vmx_close_while_nested_test.c  |  2 +-
 .../selftests/kvm/x86_64/vmx_dirty_log_test.c |  4 +-
 .../vmx_exception_with_invalid_guest_state.c  |  2 +-
 .../x86_64/vmx_invalid_nested_guest_state.c   |  2 +-
 .../selftests/kvm/x86_64/vmx_msrs_test.c      |  2 +-
 .../kvm/x86_64/vmx_nested_tsc_scaling_test.c  |  5 +-
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |  2 +-
 .../kvm/x86_64/vmx_preemption_timer_test.c    |  4 +-
 .../kvm/x86_64/vmx_set_nested_state_test.c    |  3 +-
 .../kvm/x86_64/vmx_tsc_adjust_test.c          |  5 +-
 .../selftests/kvm/x86_64/xapic_ipi_test.c     |  4 +-
 .../selftests/kvm/x86_64/xapic_state_test.c   |  2 +-
 .../selftests/kvm/x86_64/xen_shinfo_test.c    | 67 +++++++----------
 .../selftests/kvm/x86_64/xen_vmcall_test.c    | 17 +++--
 .../selftests/kvm/x86_64/xss_msr_test.c       |  2 +-
 90 files changed, 223 insertions(+), 339 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/x86_64/svm_vmcall_test.c

-- 
2.37.2.789.g6183377224-goog

