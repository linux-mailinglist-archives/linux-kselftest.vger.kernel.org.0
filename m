Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622CF383998
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 May 2021 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243178AbhEQQZD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 May 2021 12:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346311AbhEQQY2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 May 2021 12:24:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5674FC034613
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 07:53:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e75-20020a25d34e0000b02904f982184581so9576075ybf.4
        for <linux-kselftest@vger.kernel.org>; Mon, 17 May 2021 07:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4HJ66++ZeWXgUMvYaSH59XIw9b5t7+bKx/IVCdRe4G0=;
        b=tEchB3/NvHaS2iYBDSPPFoO6QDvpctN/kh8GNdmz+3BV51fgxznShQgFUWKmVHsnCB
         aIexAfoWXg6sUKvOWx3mQ0ROzie/dXZfhTjzynlDE/FK5ic3y2TmhEJfI8B7wwhTPFpn
         5h+DUByZwY/YPA72ASBm/UMCFkrOZA/0KTlulemK4yZ/LlMl38QNjbYECaAyv39jZ2PN
         kDcNISNoaDXMKrAuVsEts6T5iHO9gRSmdqijjd9/w146GvRse1G4R+oaPhYi9pQfgSH5
         oDg000282+nVSW7qP3y3olOlbJ9JWfuRlxcA2Gv3VnuXIzwfdrZZ4BCdlEpRaNi4S8X0
         BP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4HJ66++ZeWXgUMvYaSH59XIw9b5t7+bKx/IVCdRe4G0=;
        b=jSD9LF3dxwpKojXCqyV2HyMXZWrRBnv/Opk+U3t+Vu6ldKGwm59EBznpiHP/xrcmR/
         bOivYd2PPyrVTTOpI7zv96vhlDgCU1HwBAp7BmAwy6IwP8HsUejse5oYPoE1hUJJAeKB
         hz4baUOotCufn85zW/hZZfRRBoathXbi5TDXfWnWg+Kbm6jm/G5VHTFBtUvUumQrnc6F
         Ok96E3x9ltYLuIisv7Ot+VREwGgPnDQjc/8Td0XoV+OYGO5v+iDfe0Pxei7vopAWU7hh
         i/bIqJsfd28+cXy4DXNU5FUYmIqIqik0lHHOXuGk35sP0t96C4Y835MxbNEMk+lpvSap
         u/Aw==
X-Gm-Message-State: AOAM532cGdWfDXo6pLDfKw8nMZOA0VwzcoxYYcaamhKsZE0qp71Y9RfR
        ZI+6SaZPE6gDO+flofKF5FnNA/K36QE6io+LwA==
X-Google-Smtp-Source: ABdhPJxVSYPxCoq4VDHfaNcpUYnOeavMMHtUfXfKI9+aR8ach/FPO0fxCU0HVpVBmnunXxkvJEfDJDgTUXDf+b1H8A==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a5b:1c8:: with SMTP id
 f8mr317938ybp.44.1621263199546; Mon, 17 May 2021 07:53:19 -0700 (PDT)
Date:   Mon, 17 May 2021 14:53:10 +0000
Message-Id: <20210517145314.157626-1-jingzhangos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v5 0/4] KVM statistics data fd-based binary interface
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
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
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
  * architecture dependent or common
  * VM statistics data or VCPU statistics data
  * type: cumulative, instantaneous,
  * unit: none for simple counter, nanosecond, microsecond,
    millisecond, second, Byte, KiByte, MiByte, GiByte. Clock Cycles
Since no lock/synchronization is used, the consistency between all
the statistics data is not guaranteed. That means not all statistics
data are read out at the exact same time, since the statistics date
are still being updated by KVM subsystems while they are read out.

---

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

---

Jing Zhang (4):
  KVM: stats: Separate common stats from architecture specific ones
  KVM: stats: Add fd-based API to read binary stats data
  KVM: stats: Add documentation for statistics data binary interface
  KVM: selftests: Add selftest for KVM statistics data binary interface

 Documentation/virt/kvm/api.rst                | 171 ++++++++
 arch/arm64/include/asm/kvm_host.h             |   9 +-
 arch/arm64/kvm/guest.c                        |  38 +-
 arch/mips/include/asm/kvm_host.h              |   9 +-
 arch/mips/kvm/mips.c                          |  64 ++-
 arch/powerpc/include/asm/kvm_host.h           |   9 +-
 arch/powerpc/kvm/book3s.c                     |  64 ++-
 arch/powerpc/kvm/book3s_hv.c                  |  12 +-
 arch/powerpc/kvm/book3s_pr.c                  |   2 +-
 arch/powerpc/kvm/book3s_pr_papr.c             |   2 +-
 arch/powerpc/kvm/booke.c                      |  59 ++-
 arch/s390/include/asm/kvm_host.h              |   9 +-
 arch/s390/kvm/kvm-s390.c                      | 129 +++++-
 arch/x86/include/asm/kvm_host.h               |   9 +-
 arch/x86/kvm/x86.c                            |  67 +++-
 include/linux/kvm_host.h                      | 136 ++++++-
 include/linux/kvm_types.h                     |  12 +
 include/uapi/linux/kvm.h                      |  50 +++
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +
 .../selftests/kvm/kvm_bin_form_stats.c        | 379 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
 virt/kvm/kvm_main.c                           | 237 ++++++++++-
 24 files changed, 1396 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/kvm_bin_form_stats.c


base-commit: a4345a7cecfb91ae78cd43d26b0c6a956420761a
-- 
2.31.1.751.gd2f1c929bd-goog

