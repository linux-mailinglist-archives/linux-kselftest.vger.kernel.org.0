Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6922F7206DD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 18:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbjFBQJY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 12:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjFBQJX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 12:09:23 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2E81B8
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 09:09:20 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b03f2663caso10350815ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685722160; x=1688314160;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CrBznNpfIektl+0F56DGUskRV9SVRyyJJNGSAgJCWsU=;
        b=b0EK5EkQAvUbJd/5CI9JmaBA2AcS63I/nUtDpTen2VS8L6qUHg6hJhg/pSoRsKwY4v
         4zc/VohGEqRAQaxYJ8s5Q2wlDDmC09ip4PGnO085kJMhMWxl9YRHBs93r34YaRgw4pZ1
         huwuhwxN1DFxBu/3v8+NwObO937gaBYARAS9sxQSrfflMOhQ8yJa+YtpjeBho/o4y8iI
         9xCfS18WMita6JT6dnI49ZMdliDI9SVor79yYAeB5DCtqlu7a26jmHwHKghM4bNAYrAD
         e0AM/+ZNxKbH+7lx5Q1/kxruJPXl4BFhClRg34UJpUKntukQdSbuPskeuSipMWVufF4z
         6C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722160; x=1688314160;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrBznNpfIektl+0F56DGUskRV9SVRyyJJNGSAgJCWsU=;
        b=Ano4waUPo2D4IGCkyhcYaud5BKEV3XQiTwuBYfF72yJKAN/a/cP9PPQ5BCqoGFg3Z1
         cKWZuVSVwEneetDBecgrdi/zen8lkZoxtWZdd+5O65do3btg4xOiPCUvGLVZdC6oJn7P
         Quz2wxYwpfBpkJJMSIVZ1leEQ5+/FbY74AEPBAoLJhMSrGVV2w5O0ZAVyWi8A40XBYsw
         UHEG5Ni7iDot7eT88dBeYSUUdB8989/WS8WvNgWa7Rqh+QilxzeNokNILgHoTbMyMdUP
         XeEFQDCh1pt+sMBGDYyhpc9xbhuDYAQIiAOe9hBrYZgZ2Py+aCWLrjO2nbCrg+aHUa0u
         QfKw==
X-Gm-Message-State: AC+VfDy9hkyCT/irraGNd5DkV+xkqONCHaRmBQLgNS0nkcADOLo4ltLn
        IEa7UXkcWPPYjeIzZzckNwhkdY0RGv3K
X-Google-Smtp-Source: ACHHUZ5ZGxbo+gkDx4JqKh+NeWoLt4VdzZkYMyMMkIG5LjQfWBJtHb0cBRHXtDUdDevPcUhc5Nq9rRO9T/h3
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:902:eac5:b0:1b1:7e1e:5ddd with SMTP id
 p5-20020a170902eac500b001b17e1e5dddmr91433pld.9.1685722159787; Fri, 02 Jun
 2023 09:09:19 -0700 (PDT)
Date:   Fri,  2 Jun 2023 09:08:58 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602160914.4011728-1-vipinsh@google.com>
Subject: [PATCH v2 00/16] Use MMU read lock for clear-dirty-log
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This series is on top of kvmarm/next as I needed to also modify Eager
page splitting logic in clear-dirty-log API. Eager page splitting is not
present in Linux 6.4-rc4.

Also, I had to change selftests patches (1 to 5) as some commits were
removed from kvm/queue remote. This caused issue due to different APIs
being present in dirty_log_perf_test when I was rebasing v2. Those
removed commits are now back in kvm-x86 branch of Sean [1] but not in
kvmarm/next or kvm/queue. I didn't want to wait for review of v2, so I
changed dirty_log_perf_test to work with kvmarm/next branch. When Sean's
kvm-x86 branch is merged, sleftests in this patch series need to be
modified to use new APIs or whoever merges last need to take care of
that.

This patch series modifies clear-dirty-log operation to run under MMU
read lock. It write protects SPTEs and split huge pages using MMU read
lock instead of MMU write lock.

Use of MMU read lock is made possible by using shared page table
walkers. Currently only page fault handlers use shared page table
walkers, with this series, clear-dirty-log operation will also use
shared page table walkers.

Patches 1 to 5:
These patches are modifying dirty_log_perf_test. Intent is to mimic
production scenarios where guest keeps on executing while userspace
thread collects and clears dirty logs independently.

Three new command line options are added:
1. j: Allows to run guest vCPUs and main thread collecting dirty logs
      independently of each other after initialization is complete.
2. k: Allows to clear dirty logs in smaller chunks compared to existing
      whole memslot clear in one call.
3. l: Allows to add customizable wait time between consecutive clear
      dirty log calls to mimic sending dirty memory to destination.

Patch 7-16:
These patches refactor code to move MMU lock operations to arch specific
code, refactor Arm's page table walker APIs, and change MMU write lock
for clearing dirty logs to read lock. Patch 16 has results showing
improvements based on dirty_log_perf_test.


1. https://lore.kernel.org/lkml/168565341087.666819.6731422637224460050.b4-ty@google.com/

v2:
- Fix compile warning for mips and riscv.
- Added logic to continue or retry shared page walk which are not fault
  handler.
- Huge page split also changed to run under MMU read lock.
- Added more explanations in commit logs.
- Selftests is modified because a commit series was reverted back in
  dirty_log_perf_test on kvm/queue.

v1: https://lore.kernel.org/lkml/20230421165305.804301-1-vipinsh@google.com/

Vipin Sharma (16):
  KVM: selftests: Clear dirty logs in user defined chunks sizes in
    dirty_log_perf_test
  KVM: selftests: Add optional delay between consecutive clear-dirty-log
    calls
  KVM: selftests: Pass the count of read and write accesses from guest
    to host
  KVM: selftests: Print read-write progress by vCPUs in
    dirty_log_perf_test
  KVM: selftests: Allow independent execution of vCPUs in
    dirty_log_perf_test
  KVM: arm64: Correct the kvm_pgtable_stage2_flush() documentation
  KVM: mmu: Move mmu lock/unlock to arch code for clear dirty log
  KMV: arm64: Pass page table walker flags to stage2_apply_range_*()
  KVM: arm64: Document the page table walker actions based on the
    callback's return value
  KVM: arm64: Return -ENOENT if PTE is not valid in stage2_attr_walker
  KVM: arm64: Use KVM_PGTABLE_WALK_SHARED flag instead of
    KVM_PGTABLE_WALK_HANDLE_FAULT
  KVM: arm64: Retry shared page table walks outside of fault handler
  KVM: arm64: Run clear-dirty-log under MMU read lock
  KVM: arm64: Pass page walker flags from callers of stage 2 split
    walker
  KVM: arm64: Provide option to pass page walker flag for huge page
    splits
  KVM: arm64: Split huge pages during clear-dirty-log under MMU read
    lock

 arch/arm64/include/asm/kvm_pgtable.h          |  42 +++--
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         |   4 +-
 arch/arm64/kvm/hyp/pgtable.c                  |  68 ++++++--
 arch/arm64/kvm/mmu.c                          |  65 +++++---
 arch/mips/kvm/mmu.c                           |   2 +
 arch/riscv/kvm/mmu.c                          |   2 +
 arch/x86/kvm/mmu/mmu.c                        |   3 +
 .../selftests/kvm/dirty_log_perf_test.c       | 147 ++++++++++++++----
 tools/testing/selftests/kvm/lib/memstress.c   |  13 +-
 virt/kvm/dirty_ring.c                         |   2 -
 virt/kvm/kvm_main.c                           |   4 -
 11 files changed, 265 insertions(+), 87 deletions(-)


base-commit: 532b2ecfa547f02b1825108711565eff026bce5a
-- 
2.41.0.rc0.172.g3f132b7071-goog

