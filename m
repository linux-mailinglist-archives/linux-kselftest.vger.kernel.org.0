Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27173AC270
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 06:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhFREuc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 00:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhFREub (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 00:50:31 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D823C061760
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 21:48:23 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id p17-20020a056a000b51b02902f9e70d70ecso5043974pfo.5
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 21:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aX5vzwr4uX568u1A1NtAetcO8H5b06l0VkOaAxAnVkA=;
        b=tGukxaCQCc4unz3T4o+1k0603INSgUYlITVDfwwxW++mV230YThTVX3uCxQj4LPeyV
         3tm06/AS0y5aN6UK0EwyOKWiRohe3ONlbCdGuGqjcnREBxpAyAv8DP0+F+cY7XOqaHw1
         7k42a9bIJ1Fee1o5+wigkWZooFIb0jYeG+XGss6wAugAWZPyeo+HUsDOauBm1Il8f4P+
         FUNhuo9ZSeAvtjf3L27zPcNWsbbSlPmt9h1IwZZLoRPjynf6iBgu9eEBGxffroGj9/RG
         XBHxo7/gRpWxb9UUjGtV/B2xSoT61OqmSFGwBrpukiIJqlz67koILyqmP2Y/FucTrV86
         8J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aX5vzwr4uX568u1A1NtAetcO8H5b06l0VkOaAxAnVkA=;
        b=bU/nQdG7uy5+F7pfXtjCxno+HS6n6zNGovPeShHKNJ1rBGF4pezB7FmYd8lPHRCE8b
         FJqW+4xz7xMy0g0wZGKmGylZlsyE5Isv63MRSSy7B9QyHJ8NDO3SHDmMp/Lx2fdhn+CC
         99YHlwcMcjuQtL+3W2MlY7x5gsRNFpsONRaiZ7TtFugUMKsZ6EjgPqOLCLCTdJo6z92h
         HrRVTzxzFtt0L/9xoiYa64drjzdRHyo2zqTWMR+JSXPoy0kcedTF7lPePLvq9lD9z9EJ
         pS7pVHAscENaKUFaeWXXtY9NJl8jtgKizpp8/b2l7FlQ1amWx4IIByEsb+HWVh0ZcOmt
         Em8g==
X-Gm-Message-State: AOAM530knvT//zoROql41AgIroGrHXpuEjwvBzxyVFxREYnRlPxek3sZ
        ni8fr9Hw48EJs90txqoLUFskOkt02bx3xLRphA==
X-Google-Smtp-Source: ABdhPJxEgFkmUsrAiGXTKrRezE/MFsoflpuzIyEmccg4HBROR6o6jTNfQuRly6Y0jXP9sNzdKcJFCvKFqlwREyAfag==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a17:903:31c9:b029:ed:6f56:9d1e with
 SMTP id v9-20020a17090331c9b02900ed6f569d1emr2993605ple.46.1623991702352;
 Thu, 17 Jun 2021 21:48:22 -0700 (PDT)
Date:   Fri, 18 Jun 2021 04:48:12 +0000
Message-Id: <20210618044819.3690166-1-jingzhangos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v11 0/7] KVM statistics data fd-based binary interface
From:   Jing Zhang <jingzhangos@google.com>
To:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset provides a file descriptor for every VM and VCPU to read
KVM statistics data in binary format.
It is meant to provide a lightweight, flexible, scalable and efficient
lock-free solution for user space telemetry applications to pull the
statistics data periodically for large scale systems. The pulling
frequency could be as high as a few times per second.
In this patchset, every statistics data are treated to have some
attributes as below:
  * architecture dependent or generic
  * VM statistics data or VCPU statistics data
  * type: cumulative, instantaneous, peak
  * unit: none for simple counter, nanosecond, microsecond,
    millisecond, second, Byte, KiByte, MiByte, GiByte, Clock Cycles
Since no lock/synchronization is used, the consistency between all
the statistics data is not guaranteed. That means not all statistics
data are read out at the exact same time, since the statistics data
are still being updated by KVM subsystems while they are read out.

---

* v10 -> v11
  - Rebase to kvm/queue, commit f1b832550832
    (KVM: x86/mmu: Fix TDP MMU page table level)
  - Separate binary stats implementation commit
  - Use flexible length array member field in API structure instead of
    zero-length array member field
  - Move major binary stats reading function in a separate source file
  - Move stats id string into vm/vcpu structures
  - Add some detailed comments and update commit messages
  - Addressed some other review comments from Greg K.H. and Paolo.

* v9 -> v10
  - Relocate vcpu stat in vcpu's slab's usercopy region
  - Fix test issue for capability checking
  - Update commit message to explain why/how we need to add this new
    API for KVM statistics

* v8 -> v9
  - Rebase to commit 8331a2bc0898
    (KVM: X86: Introduce KVM_HC_MAP_GPA_RANGE hypercall)
  - Reduce code duplication between binary and debugfs interface
  - Add field "offset" in stats descriptor to let us define stats
    descriptors in any order (not necessary in the order of stats
    defined in vm/vcpu stats structures)
  - Add static check to make sure the number of stats descriptors
    is the same as the number of stats defined in vm/vcpu stats
    structures
  - Fix missing/mismatched stats descriptor definition caused by
    rebase

* v7 -> v8
  - Rebase to kvm/queue, commit c1dc20e254b4 ("KVM: switch per-VM
  stats to u64")
  - Revise code to reflect the per-VM stats type from ulong to u64
  - Addressed some other nits

* v6 -> v7
  - Improve file descriptor allocation function by Krish suggestion
  - Use "generic stats" instead of "common stats" as Krish suggested
  - Addressed some other nits from Krish and David Matlack

* v5 -> v6
  - Use designated initializers for STATS_DESC
  - Change KVM_STATS_SCALE... to KVM_STATS_BASE...
  - Use a common function for kvm_[vm|vcpu]_stats_read
  - Fix some documentation errors/missings
  - Use TEST_ASSERT in selftest
  - Use a common function for [vm|vcpu]_stats_test in selftest

* v4 -> v5
  - Rebase to kvm/queue, commit a4345a7cecfb ("Merge tag
    'kvmarm-fixes-5.13-1'")
  - Change maximum stats name length to 48
  - Replace VM_STATS_COMMON/VCPU_STATS_COMMON macros with stats
    descriptor definition macros.
  - Fixed some errors/warnings reported by checkpatch.pl

* v3 -> v4
  - Rebase to kvm/queue, commit 9f242010c3b4 ("KVM: avoid "deadlock"
    between install_new_memslots and MMU notifier")
  - Use C-stype comments in the whole patch
  - Fix wrong count for x86 VCPU stats descriptors
  - Fix KVM stats data size counting and validity check in selftest

* v2 -> v3
  - Rebase to kvm/queue, commit edf408f5257b ("KVM: avoid "deadlock"
    between install_new_memslots and MMU notifier")
  - Resolve some nitpicks about format

* v1 -> v2
  - Use ARRAY_SIZE to count the number of stats descriptors
  - Fix missing `size` field initialization in macro STATS_DESC

[1] https://lore.kernel.org/kvm/20210402224359.2297157-1-jingzhangos@google.com
[2] https://lore.kernel.org/kvm/20210415151741.1607806-1-jingzhangos@google.com
[3] https://lore.kernel.org/kvm/20210423181727.596466-1-jingzhangos@google.com
[4] https://lore.kernel.org/kvm/20210429203740.1935629-1-jingzhangos@google.com
[5] https://lore.kernel.org/kvm/20210517145314.157626-1-jingzhangos@google.com
[6] https://lore.kernel.org/kvm/20210524151828.4113777-1-jingzhangos@google.com
[7] https://lore.kernel.org/kvm/20210603211426.790093-1-jingzhangos@google.com
[8] https://lore.kernel.org/kvm/20210611124624.1404010-1-jingzhangos@google.com
[9] https://lore.kernel.org/kvm/20210614212155.1670777-1-jingzhangos@google.com
[10] https://lore.kernel.org/kvm/20210617044146.2667540-1-jingzhangos@google.com

---

Jing Zhang (7):
  KVM: stats: Separate generic stats from architecture specific ones
  KVM: stats: Add fd-based API to read binary stats data
  KVM: stats: Support binary stats retrieval for a VM
  KVM: stats: Support binary stats retrieval for a VCPU
  KVM: stats: Add documentation for binary statistics interface
  KVM: selftests: Add selftest for KVM statistics data binary interface
  KVM: stats: Remove code duplication for binary and debugfs stats

 Documentation/virt/kvm/api.rst                | 176 +++++++++++++-
 arch/arm64/include/asm/kvm_host.h             |   9 +-
 arch/arm64/kvm/Makefile                       |   2 +-
 arch/arm64/kvm/guest.c                        |  46 ++--
 arch/mips/include/asm/kvm_host.h              |   9 +-
 arch/mips/kvm/Makefile                        |   2 +-
 arch/mips/kvm/mips.c                          |  88 ++++---
 arch/powerpc/include/asm/kvm_host.h           |   9 +-
 arch/powerpc/kvm/Makefile                     |   2 +-
 arch/powerpc/kvm/book3s.c                     |  89 ++++---
 arch/powerpc/kvm/book3s_hv.c                  |  12 +-
 arch/powerpc/kvm/book3s_pr.c                  |   2 +-
 arch/powerpc/kvm/book3s_pr_papr.c             |   2 +-
 arch/powerpc/kvm/booke.c                      |  74 ++++--
 arch/s390/include/asm/kvm_host.h              |   9 +-
 arch/s390/kvm/Makefile                        |   3 +-
 arch/s390/kvm/kvm-s390.c                      | 230 ++++++++++--------
 arch/x86/include/asm/kvm_host.h               |   9 +-
 arch/x86/kvm/Makefile                         |   2 +-
 arch/x86/kvm/x86.c                            | 107 ++++----
 include/linux/kvm_host.h                      | 182 ++++++++++++--
 include/linux/kvm_types.h                     |  12 +
 include/uapi/linux/kvm.h                      |  44 ++++
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +
 .../selftests/kvm/kvm_binary_stats_test.c     | 225 +++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
 virt/kvm/binary_stats.c                       | 130 ++++++++++
 virt/kvm/kvm_main.c                           | 218 ++++++++++++++---
 30 files changed, 1355 insertions(+), 357 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/kvm_binary_stats_test.c
 create mode 100644 virt/kvm/binary_stats.c


base-commit: f1b8325508327a302f1d5cd8a4bf51e2c9c72fa9
-- 
2.32.0.288.g62a8d224e6-goog

