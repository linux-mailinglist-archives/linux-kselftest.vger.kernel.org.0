Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7706938F0C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 May 2021 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbhEXQGO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 May 2021 12:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbhEXQFI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 May 2021 12:05:08 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7060EC0612F2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 May 2021 08:18:32 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id a23-20020a6370570000b029021b0f92a171so11420894pgn.16
        for <linux-kselftest@vger.kernel.org>; Mon, 24 May 2021 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hsUoOGhK41uMiUMibdY4aJzD3L98/UiwuU5d74aCT5c=;
        b=grl3R4lWY+xXFxpFitAl3zhdfmFAs89StA2Ji9s3d/B2KH6pdBk72CLWtEduhvKNfo
         iIz00QlLOwJ6Y6Ai8wBpzGPfcGEwBACfhGYtOGLvLrgSDG4mnLPIk5zIThj/UOzmczx7
         p/SP0aizUe+vwZfezt4kWxQh9FvmJN7ScVdPnbFt3b3X2xhWLbgRMBhpWhOFdVnuNrLA
         JoZSB7oVUumnRupw3HeRzO6TaAwLVK8M7I4kcWjBtBGLSCfRzB9++ypo8b2OSo+qG124
         gYSQWV6jgypmwYgMZyfG/lE973elU2q2ykhk6ZZDeN6dBwjT+sBsDlwg86sgs0sGLfdL
         9Ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hsUoOGhK41uMiUMibdY4aJzD3L98/UiwuU5d74aCT5c=;
        b=ZZbyYSyh7HlYvJs3jy5fF7OG1MHOeLh2mQCC8rvpySwvCblftTQt2MO/+8WdWxkUkX
         S0zQMaVDII0UYtonD4U99ltcBhx0cnuzOEutaRCnszZUxp/0ejmUDy4LeLD/t0MfSntD
         3npZm0Jj12dfTNw7A7pHJkBpeNFk/F44cvv1+wzD22VRcbp6Iy04dNFEmS6vJ7qdNaz/
         tmO0q3kI4Aj+76g3Jaof+SHAGAJUTrl7n1s6YeCM4Kss7p8RvWFVqNWQZEkV21fGyxP2
         rFFDkQUHqa3ExonpBd2hMca5oFM+ntl9m66O7a4p5uZkhBUCcppJXv7WOAjFTTR88OAm
         gO9A==
X-Gm-Message-State: AOAM532rkVqUwPwBretbs9DKJW0Jxkc67zAcrVZKHlXPGLNzpGhmKXus
        NqYlOVc40oX1wkUPulmRejva/bOZBJLit2qCGQ==
X-Google-Smtp-Source: ABdhPJxXtI/1dIGUSOnlwdZP5pVxH5ZIpkvTAxwzuzAnLE0CS16jMydJPMj+BH0vIgpLcLjWr90NhFsWDjXmEfhRlA==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a05:6a00:882:b029:2de:b01d:755a with
 SMTP id q2-20020a056a000882b02902deb01d755amr25260828pfj.43.1621869511859;
 Mon, 24 May 2021 08:18:31 -0700 (PDT)
Date:   Mon, 24 May 2021 15:18:24 +0000
Message-Id: <20210524151828.4113777-1-jingzhangos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v6 0/4] KVM statistics data fd-based binary interface
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
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
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

---

Jing Zhang (4):
  KVM: stats: Separate common stats from architecture specific ones
  KVM: stats: Add fd-based API to read binary stats data
  KVM: stats: Add documentation for statistics data binary interface
  KVM: selftests: Add selftest for KVM statistics data binary interface

 Documentation/virt/kvm/api.rst                | 179 +++++++++++++++
 arch/arm64/include/asm/kvm_host.h             |   9 +-
 arch/arm64/kvm/guest.c                        |  38 ++-
 arch/mips/include/asm/kvm_host.h              |   9 +-
 arch/mips/kvm/mips.c                          |  64 +++++-
 arch/powerpc/include/asm/kvm_host.h           |   9 +-
 arch/powerpc/kvm/book3s.c                     |  64 +++++-
 arch/powerpc/kvm/book3s_hv.c                  |  12 +-
 arch/powerpc/kvm/book3s_pr.c                  |   2 +-
 arch/powerpc/kvm/book3s_pr_papr.c             |   2 +-
 arch/powerpc/kvm/booke.c                      |  59 ++++-
 arch/s390/include/asm/kvm_host.h              |   9 +-
 arch/s390/kvm/kvm-s390.c                      | 129 ++++++++++-
 arch/x86/include/asm/kvm_host.h               |   9 +-
 arch/x86/kvm/x86.c                            |  67 +++++-
 include/linux/kvm_host.h                      | 141 +++++++++++-
 include/linux/kvm_types.h                     |  12 +
 include/uapi/linux/kvm.h                      |  50 ++++
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +
 .../selftests/kvm/kvm_bin_form_stats.c        | 216 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
 virt/kvm/kvm_main.c                           | 179 ++++++++++++++-
 24 files changed, 1188 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/kvm_bin_form_stats.c


base-commit: a4345a7cecfb91ae78cd43d26b0c6a956420761a
-- 
2.31.1.818.g46aad6cb9e-goog

