Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE083AAA4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 06:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhFQEn7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 00:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhFQEn6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 00:43:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4ACC061574
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jun 2021 21:41:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m205-20020a25d4d60000b029052a8de1fe41so6676605ybf.23
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jun 2021 21:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3s1eozoLTG+O62g1UQDRz9lp8lZhA9dilcFNCLVNrmc=;
        b=db0YxvYVAksAIvRn8DzguGB76wytBIFVDrzngep7lWWXtMo8kZQa5rchHf2uteEu+K
         HxS1Dw/r8AqDIq6UtA5zCFjMeBoLgyDHUXbdcvAFijzMFX66eyfRqi72Z8wBXua8HAx+
         6NO8WoBZ/BWJoOv+5U3aOXqkawAw2myIX9n4COBU6wnRCFBcavbfvqPW2uqMrbnsNQeb
         AscXOEU2JShseLT0EAKG5/FLqPqqnwaf2Pi/QlqymJX/z0OrhAfhQbsGHktJVGLCeWAZ
         9VG7lh6B3+dyfQiHQQSV+Fp63MWKIunrezw9OfpZdsVZl/EoLoWDtsA2zqj0uaY65esP
         /QNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3s1eozoLTG+O62g1UQDRz9lp8lZhA9dilcFNCLVNrmc=;
        b=XYK/fQ6okHcJ/R7KtKdnyXgS0Tx2Kl+CECCD0inm/Bp5mXycXtUy7fmrXUF9fHw/tT
         qN85tvCMM3DC8/+66wE97fIL7+XmTkt6qkRqV80xuow05pZuezUDYYP/DkGGMsTl3t3A
         XF6ibTMsiUPZGgG/FQ/IxCtYoIjVXKO+jy1yDZIEq0inf4UhVW4FIxcM4aVheDu/ihUJ
         8duW1fYw6/3ouzrdh5Y3HqYmpTwYxi0SxNhqYO9mLCNTNt0+cn3nEnK5irm5+0ukAdCH
         a4RK+7SPVlky8qMB3iBY47wh8twnw0iegP3Yod3ww7n9btBcWFTUNMgMyfIUvk+nalo5
         bmiQ==
X-Gm-Message-State: AOAM530VdHvh4kW+M/AUBFnpWemHk3P8uW5AvKX89pTyhj35qmxRRS4R
        4xOQP4TEwMe045ZkhH6MyOiHjFPSGBVqOiVo3Q==
X-Google-Smtp-Source: ABdhPJwOgJClowYYNO7/RLiARDkMAJNcFXI3q8kTYlz9mBs1EHYvPdFwazYpeod5q8BGxxGHGgHEjkMc4EAD1OxX+w==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a25:bb46:: with SMTP id
 b6mr3371267ybk.346.1623904909931; Wed, 16 Jun 2021 21:41:49 -0700 (PDT)
Date:   Thu, 17 Jun 2021 04:41:41 +0000
Message-Id: <20210617044146.2667540-1-jingzhangos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v10 0/5] KVM statistics data fd-based binary interface
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
        Fuad Tabba <tabba@google.com>
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

---

Jing Zhang (5):
  KVM: stats: Separate generic stats from architecture specific ones
  KVM: stats: Add fd-based API to read binary stats data
  KVM: stats: Add documentation for binary statistics interface
  KVM: selftests: Add selftest for KVM statistics data binary interface
  KVM: stats: Remove code duplication for binary and debugfs stats

 Documentation/virt/kvm/api.rst                | 177 +++++++++++-
 arch/arm64/include/asm/kvm_host.h             |   9 +-
 arch/arm64/kvm/guest.c                        |  50 +++-
 arch/mips/include/asm/kvm_host.h              |   9 +-
 arch/mips/kvm/mips.c                          |  92 +++---
 arch/powerpc/include/asm/kvm_host.h           |   9 +-
 arch/powerpc/kvm/book3s.c                     |  93 ++++--
 arch/powerpc/kvm/book3s_hv.c                  |  12 +-
 arch/powerpc/kvm/book3s_pr.c                  |   2 +-
 arch/powerpc/kvm/book3s_pr_papr.c             |   2 +-
 arch/powerpc/kvm/booke.c                      |  78 +++--
 arch/s390/include/asm/kvm_host.h              |   9 +-
 arch/s390/kvm/kvm-s390.c                      | 234 ++++++++-------
 arch/x86/include/asm/kvm_host.h               |   9 +-
 arch/x86/kvm/x86.c                            | 111 ++++---
 include/linux/kvm_host.h                      | 180 +++++++++++-
 include/linux/kvm_types.h                     |  12 +
 include/uapi/linux/kvm.h                      |  48 ++++
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +
 .../selftests/kvm/kvm_binary_stats_test.c     | 225 +++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
 virt/kvm/kvm_main.c                           | 270 +++++++++++++++---
 24 files changed, 1299 insertions(+), 351 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/kvm_binary_stats_test.c


base-commit: 8331a2bc089881d7fd2fc9a6658f39780817e4e0
-- 
2.32.0.272.g935e593368-goog

