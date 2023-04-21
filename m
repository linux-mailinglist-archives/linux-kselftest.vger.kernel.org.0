Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851C36EAFEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 18:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjDUQ71 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 12:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjDUQ7W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 12:59:22 -0400
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8CC15A35
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 09:58:53 -0700 (PDT)
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-63d3b5c334eso1742303b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682095989; x=1684687989;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bpz9GCI4OFqr9DlnIkg8fh50O4zOZAPmw/GqyWI1sUY=;
        b=DGn7gCykqxE1wl2tXEHxtzFbscSQI+JYs1BOyBXnwpOUa0v37O5EWPBn/ZgODYtQlN
         ucm2bl+oRpYs66hkDH2OsTMMwYnJjHqmfL1Gfoz55eaPsC+KkP0XkEqAwZ6rs8pd6Rpz
         FUqoTwNDb4fdpZO/bATUsOleiUawwODIJsv2oBaDLHov514nHeOp01TeHl5biXsvmD+B
         drB6ioShN8gZ615eSTgzwj90uRL3MtckEF9+PdrDWulnCx0CuSxldhcUkAHan3z7jBnk
         tHJsR2+7JQcAF/jPDdgXfTyng+EIcBFq/MixhtIbZMOElAUZCqnEM9rZEPv1BqgcbQ1G
         Ek/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682095989; x=1684687989;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bpz9GCI4OFqr9DlnIkg8fh50O4zOZAPmw/GqyWI1sUY=;
        b=QIaSS+euEh1u6vrPPZArCL+ZpNqhipE1h8rRRdePxkaIge5+ooP9kFe4Fr4RDJuwPr
         Lr9n+G3dDEyLMe867ymkAx5eeuhBlYa40Z3sOl2bbgEWMMHvW5/fjpZsSzSH8Ai18gqJ
         jiNNJQa1j7R1KpRnUEmTS40nbIS/ziJM5LCI3Y+b/EiRmK9aaQlw536MD7JNn8T+jos9
         cYg92T0l/jEydLImEuwYZfk09yo+qV+TNSYMHygHOvETkyRWDY9nf/0gTCA4Zit+bDby
         GOxILXkcRC3XOOxpcfESyL+DU2rM8NpKVXmayIIYPuF8nrm0MNJnzeOG5LnuG8BuS8a2
         Fntg==
X-Gm-Message-State: AAQBX9cSAcPMcw3oyMzv+F1OWJgHDVVQts5lP9+datw4vSIlh149bajd
        IPd6sHYGFvt0BdPSo4UiFvYcSPj4epTZ
X-Google-Smtp-Source: AKy350ZhH26lR6IB3CnQ8CLF2JwssN6KagmxAVm6T/W0c2gS8Zvsk3hHnJOD9Yv5ucUQ9FKvawPIRN1PXzlu
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a05:6a00:b94:b0:63d:397a:8fdd with SMTP id
 g20-20020a056a000b9400b0063d397a8fddmr2339440pfj.0.1682095989138; Fri, 21 Apr
 2023 09:53:09 -0700 (PDT)
Date:   Fri, 21 Apr 2023 09:52:56 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421165305.804301-1-vipinsh@google.com>
Subject: [PATCH 0/9] KVM: arm64: Use MMU read lock for clearing dirty logs
From:   Vipin Sharma <vipinsh@google.com>
To:     maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        aleksandar.qemu.devel@gmail.com, tsbogend@alpha.franken.de,
        anup@brainfault.org, atishp@atishpatra.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, seanjc@google.com, pbonzini@redhat.com,
        dmatlack@google.com, ricarkol@google.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series improves guest vCPUs performances on Arm during clearing
dirty log operations by taking MMU read lock instead of MMU write lock.

vCPUs write protection faults are fixed in Arm using MMU read locks.
However, when userspace is clearing dirty logs via KVM_CLEAR_DIRTY_LOG
ioctl, then kernel code takes MMU write lock. This will block vCPUs
write protection faults and degrade guest performance.  This
degradation gets worse as guest VM size increases in terms of memory and
vCPU count.

In this series, MMU read lock adoption is made possible by using
KVM_PGTABLE_WALK_SHARED flag in page walker.

Patches 1 to 5:
These patches are modifying dirty_log_perf_test. Intent is to mimic
production scenarios where guest keeps on executing while userspace
threads collect and clear dirty logs independently.

Three new command line options are added:
1. j: Allows to run guest vCPUs and main thread collecting dirty logs
      independently of each other after initialization is complete.
2. k: Allows to clear dirty logs in smaller chunks compared to existing
      whole memslot clear in one call.
3. l: Allows to add customizable wait time between consecutive clear
      dirty log calls to mimic sending dirty memory to destination.

Patch 7-8:
These patches refactor code to move MMU lock operations to arch specific
code, refactor Arm's page table walker APIs, and change MMU write lock
for clearing dirty logs to read lock. Patch 8 has results showing
improvements based on dirty_log_perf_test.

Vipin Sharma (9):
  KVM: selftests: Allow dirty_log_perf_test to clear dirty memory in
    chunks
  KVM: selftests: Add optional delay between consecutive Clear-Dirty-Log
    calls
  KVM: selftests: Pass count of read and write accesses from guest to
    host
  KVM: selftests: Print read and write accesses of pages by vCPUs in
    dirty_log_perf_test
  KVM: selftests: Allow independent execution of vCPUs in
    dirty_log_perf_test
  KVM: arm64: Correct the kvm_pgtable_stage2_flush() documentation
  KVM: mmu: Move mmu lock/unlock to arch code for clear dirty log
  KMV: arm64: Allow stage2_apply_range_sched() to pass page table walker
    flags
  KVM: arm64: Run clear-dirty-log under MMU read lock

 arch/arm64/include/asm/kvm_pgtable.h          |  17 ++-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         |   4 +-
 arch/arm64/kvm/hyp/pgtable.c                  |  16 ++-
 arch/arm64/kvm/mmu.c                          |  36 ++++--
 arch/mips/kvm/mmu.c                           |   2 +
 arch/riscv/kvm/mmu.c                          |   2 +
 arch/x86/kvm/mmu/mmu.c                        |   3 +
 .../selftests/kvm/dirty_log_perf_test.c       | 108 ++++++++++++++----
 .../testing/selftests/kvm/include/memstress.h |  13 ++-
 tools/testing/selftests/kvm/lib/memstress.c   |  43 +++++--
 virt/kvm/dirty_ring.c                         |   2 -
 virt/kvm/kvm_main.c                           |   4 -
 12 files changed, 185 insertions(+), 65 deletions(-)


base-commit: 95b9779c1758f03cf494e8550d6249a40089ed1c
-- 
2.40.0.634.g4ca3ef3211-goog

