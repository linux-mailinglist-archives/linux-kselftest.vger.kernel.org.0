Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799533A321F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 19:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFJRce (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 13:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFJRcd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 13:32:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A81C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jun 2021 10:30:26 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n12so4455682lft.10
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jun 2021 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ioyoetTgICcLM1co3hfV64SuUDGjPwWrOEhUg6YRdzA=;
        b=sB636TtZaglUv0NqmI1HpIzfYrhUSTp9FixNWI9fognuH/4ofXLUg+MSlnb2BDSSyN
         bgnFZfMxacXrj0hNr6tDOdoml3bY+2lbyLUAyEKLvnLWT7tJSaxJLC0mgWCmXMvMnyAQ
         bMs2u4sRM1T3OLRa51TrmGDRFH7Vf5Wiy85zTz2MqnpRupCEb/JjKxMw1Agfj3wZFoPK
         ooNOedia0wjF8Pc4yXynatPRf2IlXw+bcRHe4XFCZF+nbbTf6RpzpD5vzpDgsG9SDJZY
         OEHcYcSHBHpXfdz2wuVM6nBemDB70pPK+Ah47MF4RTTc4GV8pH3D2tehvv7lI3OgNyw+
         8cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ioyoetTgICcLM1co3hfV64SuUDGjPwWrOEhUg6YRdzA=;
        b=VigmiaaTr5qTOL4jYF6oP1FewvjPzh6xUXjrXrnmyEuL/nNQ8rTumA7NLG5CZmOoyF
         NRNPlwhFdJB2+YnDroZSpJRWrxS5r76PJ5jmZqFEbBxQgq1E47xyDJ+1p7qMuwNbbDfz
         IQrFXY2pBNk5fConUQYuBF6gBRhseZkEh4JE+atLbvCU7U8juv5z/THRuPQSIMWzGUcu
         RLL5ee5EGPdl0fKfBd0YFO6Id2P43s/mnP0mEy5LkowYf/08NatILXiCLOj28UJrytpy
         6oJlbpqcq0SGt0qSj+2Z1SbKswmfTOuWKbvR/er81TH+MwttW9KceXj6LN3cl6bgWv7E
         NxqA==
X-Gm-Message-State: AOAM533v/gT6tXbI0ZeJoJBGiDUKUuf7TOXSPsYbAgwpOPGfF/tAKBw6
        6wzyLA/Tu+wfXuAHCw8DNqrJkTRr4jpcHZdn6EED0g==
X-Google-Smtp-Source: ABdhPJwPGuxT6GUgLlFj7a9bOlaihGu3nNRoyK0hl7HhJBQt4QwWOrlUmuo32S6AzGUwSWFJG1S+/nJgxpSqyKrjqNw=
X-Received: by 2002:a05:6512:3ea:: with SMTP id n10mr2590829lfq.178.1623346224387;
 Thu, 10 Jun 2021 10:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210603211426.790093-1-jingzhangos@google.com> <873a0398-09fc-0278-3f0c-884b73dad3aa@redhat.com>
In-Reply-To: <873a0398-09fc-0278-3f0c-884b73dad3aa@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Thu, 10 Jun 2021 12:30:12 -0500
Message-ID: <CAAdAUtiVDqFdq-ckcBqcj6DZjt+g0uhqNoWsVn_axDVi0+n9Fw@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] KVM statistics data fd-based binary interface
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paolo,

On Thu, Jun 10, 2021 at 11:46 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 03/06/21 23:14, Jing Zhang wrote:
> > This patchset provides a file descriptor for every VM and VCPU to read
> > KVM statistics data in binary format.
> > It is meant to provide a lightweight, flexible, scalable and efficient
> > lock-free solution for user space telemetry applications to pull the
> > statistics data periodically for large scale systems. The pulling
> > frequency could be as high as a few times per second.
> > In this patchset, every statistics data are treated to have some
> > attributes as below:
> >    * architecture dependent or generic
> >    * VM statistics data or VCPU statistics data
> >    * type: cumulative, instantaneous,
> >    * unit: none for simple counter, nanosecond, microsecond,
> >      millisecond, second, Byte, KiByte, MiByte, GiByte. Clock Cycles
> > Since no lock/synchronization is used, the consistency between all
> > the statistics data is not guaranteed. That means not all statistics
> > data are read out at the exact same time, since the statistics date
> > are still being updated by KVM subsystems while they are read out.
> >
> > ---
> >
> > * v6 -> v7
> >    - Improve file descriptor allocation function by Krish suggestion
> >    - Use "generic stats" instead of "common stats" as Krish suggested
> >    - Addressed some other nits from Krish and David Matlack
> >
> > * v5 -> v6
> >    - Use designated initializers for STATS_DESC
> >    - Change KVM_STATS_SCALE... to KVM_STATS_BASE...
> >    - Use a common function for kvm_[vm|vcpu]_stats_read
> >    - Fix some documentation errors/missings
> >    - Use TEST_ASSERT in selftest
> >    - Use a common function for [vm|vcpu]_stats_test in selftest
> >
> > * v4 -> v5
> >    - Rebase to kvm/queue, commit a4345a7cecfb ("Merge tag
> >      'kvmarm-fixes-5.13-1'")
> >    - Change maximum stats name length to 48
> >    - Replace VM_STATS_COMMON/VCPU_STATS_COMMON macros with stats
> >      descriptor definition macros.
> >    - Fixed some errors/warnings reported by checkpatch.pl
> >
> > * v3 -> v4
> >    - Rebase to kvm/queue, commit 9f242010c3b4 ("KVM: avoid "deadlock"
> >      between install_new_memslots and MMU notifier")
> >    - Use C-stype comments in the whole patch
> >    - Fix wrong count for x86 VCPU stats descriptors
> >    - Fix KVM stats data size counting and validity check in selftest
> >
> > * v2 -> v3
> >    - Rebase to kvm/queue, commit edf408f5257b ("KVM: avoid "deadlock"
> >      between install_new_memslots and MMU notifier")
> >    - Resolve some nitpicks about format
> >
> > * v1 -> v2
> >    - Use ARRAY_SIZE to count the number of stats descriptors
> >    - Fix missing `size` field initialization in macro STATS_DESC
> >
> > [1] https://lore.kernel.org/kvm/20210402224359.2297157-1-jingzhangos@google.com
> > [2] https://lore.kernel.org/kvm/20210415151741.1607806-1-jingzhangos@google.com
> > [3] https://lore.kernel.org/kvm/20210423181727.596466-1-jingzhangos@google.com
> > [4] https://lore.kernel.org/kvm/20210429203740.1935629-1-jingzhangos@google.com
> > [5] https://lore.kernel.org/kvm/20210517145314.157626-1-jingzhangos@google.com
> > [6] https://lore.kernel.org/kvm/20210524151828.4113777-1-jingzhangos@google.com
> >
> > ---
> >
> > Jing Zhang (4):
> >    KVM: stats: Separate generic stats from architecture specific ones
> >    KVM: stats: Add fd-based API to read binary stats data
> >    KVM: stats: Add documentation for statistics data binary interface
> >    KVM: selftests: Add selftest for KVM statistics data binary interface
> >
> >   Documentation/virt/kvm/api.rst                | 180 +++++++++++++++
> >   arch/arm64/include/asm/kvm_host.h             |   9 +-
> >   arch/arm64/kvm/guest.c                        |  38 +++-
> >   arch/mips/include/asm/kvm_host.h              |   9 +-
> >   arch/mips/kvm/mips.c                          |  64 +++++-
> >   arch/powerpc/include/asm/kvm_host.h           |   9 +-
> >   arch/powerpc/kvm/book3s.c                     |  64 +++++-
> >   arch/powerpc/kvm/book3s_hv.c                  |  12 +-
> >   arch/powerpc/kvm/book3s_pr.c                  |   2 +-
> >   arch/powerpc/kvm/book3s_pr_papr.c             |   2 +-
> >   arch/powerpc/kvm/booke.c                      |  59 ++++-
> >   arch/s390/include/asm/kvm_host.h              |   9 +-
> >   arch/s390/kvm/kvm-s390.c                      | 129 ++++++++++-
> >   arch/x86/include/asm/kvm_host.h               |   9 +-
> >   arch/x86/kvm/x86.c                            |  67 +++++-
> >   include/linux/kvm_host.h                      | 141 +++++++++++-
> >   include/linux/kvm_types.h                     |  12 +
> >   include/uapi/linux/kvm.h                      |  50 ++++
> >   tools/testing/selftests/kvm/.gitignore        |   1 +
> >   tools/testing/selftests/kvm/Makefile          |   3 +
> >   .../testing/selftests/kvm/include/kvm_util.h  |   3 +
> >   .../selftests/kvm/kvm_binary_stats_test.c     | 215 ++++++++++++++++++
> >   tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
> >   virt/kvm/kvm_main.c                           | 169 +++++++++++++-
> >   24 files changed, 1178 insertions(+), 90 deletions(-)
> >   create mode 100644 tools/testing/selftests/kvm/kvm_binary_stats_test.c
> >
> >
> > base-commit: a4345a7cecfb91ae78cd43d26b0c6a956420761a
> >
>
> I had a few remarks, but it looks very nice overall.
>
> Thanks!
>
> Paolo
>
Happy to see per-VM stats use u64 too.
Will send out another patchset based on your remarks.

Thanks,
Jing
