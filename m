Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660C13ACB63
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 14:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhFRMzn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 08:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbhFRMzm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 08:55:42 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6EDC061768
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 05:53:33 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id d2so13878028ljj.11
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 05:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWVXxgAlLJQwG/+nBdkNxeMlnnFAIi5ArzaoyPaxm/8=;
        b=L86hZTuhzSqmB3lhNADSJ5B4ukqBLqQTpJa4OIJP0gCWv0U8PkSMYl5wgqAmcPF16o
         bGGTC3yOOWXQeg02RCSjQo91Q/G1hvw5LWuf4DaJpSEWtGU0nuAX0S7YyDIan1OjZP3e
         QQksemCviavqYm1qUc66K/o2+o/k5bhzLQdprzWx63qMWP9OU19dlTGhUlRbrZCDmBZO
         Jw5AzEzvQw1MhPtWpz68szEeOuaTYxWRU+ovE4XbvLgYANCaaOiEh3gmlhkEYakpSa9Q
         GuwHF+2C7dFpoURxpIP/dN0D0qFI0foe8iYVYGtJExUPXP0xucoTh+9JfpvSPEoBMLWn
         gPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWVXxgAlLJQwG/+nBdkNxeMlnnFAIi5ArzaoyPaxm/8=;
        b=KBDJgYk7TlU8gwR75FNvnS4CnMklRoleHAOtw9Z3KZoPUK/Gvfey+DJQrZ+zNJYXwk
         1FZHIWNgJ/CCyChyI6NJO9Qo9yZ3fkKA7B0kTalIhSuZ7PXR5RluaWX6gZ4cOw4c9XN3
         h1Yu8J62wDpiWXoIaZfEMMkSJMv/SZbPBBQeqBlX2H6Jk+4gX4DbqEFzqf2UhE/3LwFu
         LnPGFPuFQJgP1sRAtmL2oBoyGpCQBduXna3zynkLir0OgzqwZfrhueopBRhfWfC6gjay
         hMaH5GcOFnSzAjAGz9TAAtcsVfTeEYBY0ATpnT9gTJE6LdjD9yVICi6mSURFztI49Yc6
         MIxg==
X-Gm-Message-State: AOAM533Y954Bo+2XLdPfgo/hFVdpV0baXsCst8bhL++lo51Qtagm8S/S
        XCN4I0WOo73DE/fkhY35hu+O39d/RxI6+hdoJwLOFg==
X-Google-Smtp-Source: ABdhPJz174WfL0ctG8A7aAAyek5EQOs9lcsrVwrYiCMiolJT0pTpKD8pbuDQEyl0wcqBTg98AJfaToqrZ1fTGN2tjfI=
X-Received: by 2002:a05:651c:54a:: with SMTP id q10mr1486427ljp.216.1624020810989;
 Fri, 18 Jun 2021 05:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210618044819.3690166-1-jingzhangos@google.com>
 <20210618044819.3690166-3-jingzhangos@google.com> <YMxEqvKyGnZinMOS@kroah.com>
In-Reply-To: <YMxEqvKyGnZinMOS@kroah.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Fri, 18 Jun 2021 07:53:19 -0500
Message-ID: <CAAdAUtiQYdciOwPF49b1bbpMAgUFfe7vNqCKcCHKP4D7+S9dMw@mail.gmail.com>
Subject: Re: [PATCH v11 2/7] KVM: stats: Add fd-based API to read binary stats data
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 18, 2021 at 2:01 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jun 18, 2021 at 04:48:14AM +0000, Jing Zhang wrote:
> > This commit defines the API for userspace and prepare the common
> > functionalities to support per VM/VCPU binary stats data readings.
> >
> > The KVM stats now is only accessible by debugfs, which has some
> > shortcomings this change series are supposed to fix:
> > 1. The current debugfs stats solution in KVM could be disabled
> >    when kernel Lockdown mode is enabled, which is a potential
> >    rick for production.
> > 2. The current debugfs stats solution in KVM is organized as "one
> >    stats per file", it is good for debugging, but not efficient
> >    for production.
> > 3. The stats read/clear in current debugfs solution in KVM are
> >    protected by the global kvm_lock.
> >
> > Besides that, there are some other benefits with this change:
> > 1. All KVM VM/VCPU stats can be read out in a bulk by one copy
> >    to userspace.
> > 2. A schema is used to describe KVM statistics. From userspace's
> >    perspective, the KVM statistics are self-describing.
> > 3. With the fd-based solution, a separate telemetry would be able
> >    to read KVM stats in a less privileged environment.
> > 4. After the initial setup by reading in stats descriptors, a
> >    telemetry only needs to read the stats data itself, no more
> >    parsing or setup is needed.
> >
> > Reviewed-by: David Matlack <dmatlack@google.com>
> > Reviewed-by: Ricardo Koller <ricarkol@google.com>
> > Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
> > Reviewed-by: Fuad Tabba <tabba@google.com>
> > Tested-by: Fuad Tabba <tabba@google.com> #arm64
> > Signed-off-by: Jing Zhang <jingzhangos@google.com>
> > ---
> >  arch/arm64/kvm/Makefile   |   2 +-
> >  arch/mips/kvm/Makefile    |   2 +-
> >  arch/powerpc/kvm/Makefile |   2 +-
> >  arch/s390/kvm/Makefile    |   3 +-
> >  arch/x86/kvm/Makefile     |   2 +-
> >  include/linux/kvm_host.h  | 145 ++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/kvm.h  |  42 +++++++++++
> >  virt/kvm/binary_stats.c   | 130 ++++++++++++++++++++++++++++++++++
> >  8 files changed, 323 insertions(+), 5 deletions(-)
> >  create mode 100644 virt/kvm/binary_stats.c
> >
> > diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> > index 589921392cb1..989bb5dad2c8 100644
> > --- a/arch/arm64/kvm/Makefile
> > +++ b/arch/arm64/kvm/Makefile
> > @@ -11,7 +11,7 @@ obj-$(CONFIG_KVM) += kvm.o
> >  obj-$(CONFIG_KVM) += hyp/
> >
> >  kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
> > -      $(KVM)/vfio.o $(KVM)/irqchip.o \
> > +      $(KVM)/vfio.o $(KVM)/irqchip.o $(KVM)/binary_stats.o \
> >        arm.o mmu.o mmio.o psci.o perf.o hypercalls.o pvtime.o \
> >        inject_fault.o va_layout.o handle_exit.o \
> >        guest.o debug.o reset.o sys_regs.o \
> > diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
> > index 30cc060857c7..c67250a956b8 100644
> > --- a/arch/mips/kvm/Makefile
> > +++ b/arch/mips/kvm/Makefile
> > @@ -2,7 +2,7 @@
> >  # Makefile for KVM support for MIPS
> >  #
> >
> > -common-objs-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o eventfd.o)
> > +common-objs-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o eventfd.o binary_stats.o)
> >
> >  EXTRA_CFLAGS += -Ivirt/kvm -Iarch/mips/kvm
> >
> > diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
> > index 2bfeaa13befb..b347d043b932 100644
> > --- a/arch/powerpc/kvm/Makefile
> > +++ b/arch/powerpc/kvm/Makefile
> > @@ -6,7 +6,7 @@
> >  ccflags-y := -Ivirt/kvm -Iarch/powerpc/kvm
> >  KVM := ../../../virt/kvm
> >
> > -common-objs-y = $(KVM)/kvm_main.o $(KVM)/eventfd.o
> > +common-objs-y = $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
> >  common-objs-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
> >  common-objs-$(CONFIG_KVM_MMIO) += $(KVM)/coalesced_mmio.o
> >
> > diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
> > index 12decca22e7c..b3aaadc60ead 100644
> > --- a/arch/s390/kvm/Makefile
> > +++ b/arch/s390/kvm/Makefile
> > @@ -4,7 +4,8 @@
> >  # Copyright IBM Corp. 2008
> >
> >  KVM := ../../../virt/kvm
> > -common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o $(KVM)/irqchip.o $(KVM)/vfio.o
> > +common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o \
> > +           $(KVM)/irqchip.o $(KVM)/vfio.o $(KVM)/binary_stats.o
> >
> >  ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
> >
> > diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> > index 83331376b779..75dfd27b6e8a 100644
> > --- a/arch/x86/kvm/Makefile
> > +++ b/arch/x86/kvm/Makefile
> > @@ -11,7 +11,7 @@ KVM := ../../../virt/kvm
> >
> >  kvm-y                        += $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o \
> >                               $(KVM)/eventfd.o $(KVM)/irqchip.o $(KVM)/vfio.o \
> > -                             $(KVM)/dirty_ring.o
> > +                             $(KVM)/dirty_ring.o $(KVM)/binary_stats.o
> >  kvm-$(CONFIG_KVM_ASYNC_PF)   += $(KVM)/async_pf.o
> >
> >  kvm-y                        += x86.o emulate.o i8259.o irq.o lapic.o \
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 5a31e0696360..2f0d12064ae7 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -1272,6 +1272,12 @@ struct kvm_stats_debugfs_item {
> >       int mode;
> >  };
> >
> > +#define KVM_STATS_NAME_LEN   48
> > +struct _kvm_stats_desc {
> > +     struct kvm_stats_desc desc;
> > +     char name[KVM_STATS_NAME_LEN];
> > +};
> > +
> >  #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
> >       ((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
> >
> > @@ -1285,8 +1291,147 @@ struct kvm_stats_debugfs_item {
> >       { n, offsetof(struct kvm_vcpu, stat.generic.x),                        \
> >         KVM_STAT_VCPU, ## __VA_ARGS__ }
> >
> > +#define STATS_DESC_COMMON(type, unit, base, exp)                            \
> > +     .flags = type | unit | base |                                          \
> > +         BUILD_BUG_ON_ZERO(type & ~KVM_STATS_TYPE_MASK) |                   \
> > +         BUILD_BUG_ON_ZERO(unit & ~KVM_STATS_UNIT_MASK) |                   \
> > +         BUILD_BUG_ON_ZERO(base & ~KVM_STATS_BASE_MASK),                    \
> > +     .exponent = exp,                                                       \
> > +     .size = 1
> > +
> > +#define VM_GENERIC_STATS_DESC(stat, type, unit, base, exp)                  \
> > +     {                                                                      \
> > +             {                                                              \
> > +                     STATS_DESC_COMMON(type, unit, base, exp),              \
> > +                     .offset = offsetof(struct kvm_vm_stat, generic.stat)   \
> > +             },                                                             \
> > +             .name = #stat,                                                 \
> > +     }
> > +#define VCPU_GENERIC_STATS_DESC(stat, type, unit, base, exp)                \
> > +     {                                                                      \
> > +             {                                                              \
> > +                     STATS_DESC_COMMON(type, unit, base, exp),              \
> > +                     .offset = offsetof(struct kvm_vcpu_stat, generic.stat) \
> > +             },                                                             \
> > +             .name = #stat,                                                 \
> > +     }
> > +#define VM_STATS_DESC(stat, type, unit, base, exp)                          \
> > +     {                                                                      \
> > +             {                                                              \
> > +                     STATS_DESC_COMMON(type, unit, base, exp),              \
> > +                     .offset = offsetof(struct kvm_vm_stat, stat)           \
> > +             },                                                             \
> > +             .name = #stat,                                                 \
> > +     }
> > +#define VCPU_STATS_DESC(stat, type, unit, base, exp)                        \
> > +     {                                                                      \
> > +             {                                                              \
> > +                     STATS_DESC_COMMON(type, unit, base, exp),              \
> > +                     .offset = offsetof(struct kvm_vcpu_stat, stat)         \
> > +             },                                                             \
> > +             .name = #stat,                                                 \
> > +     }
> > +/* SCOPE: VM, VM_GENERIC, VCPU, VCPU_GENERIC */
> > +#define STATS_DESC(SCOPE, stat, type, unit, base, exp)                              \
> > +     SCOPE##_STATS_DESC(stat, type, unit, base, exp)
> > +
> > +#define STATS_DESC_CUMULATIVE(SCOPE, name, unit, base, exponent)            \
> > +     STATS_DESC(SCOPE, name, KVM_STATS_TYPE_CUMULATIVE,                     \
> > +                   unit, base, exponent)
> > +#define STATS_DESC_INSTANT(SCOPE, name, unit, base, exponent)                       \
> > +     STATS_DESC(SCOPE, name, KVM_STATS_TYPE_INSTANT, unit, base, exponent)  \
> > +
> > +/* Cumulative counter */
> > +#define STATS_DESC_COUNTER(SCOPE, name)                                             \
> > +     STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_NONE,                \
> > +             KVM_STATS_BASE_POW10, 0)
> > +/* Instantaneous counter */
> > +#define STATS_DESC_ICOUNTER(SCOPE, name)                                    \
> > +     STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_NONE,                   \
> > +             KVM_STATS_BASE_POW10, 0)
> > +
> > +/* Cumulative clock cycles */
> > +#define STATS_DESC_CYCLE(SCOPE, name)                                               \
> > +     STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_CYCLES,              \
> > +             KVM_STATS_BASE_POW10, 0)
> > +/* Instantaneous clock cycles */
> > +#define STATS_DESC_ICYCLE(SCOPE, name)                                              \
> > +     STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_CYCLES,                 \
> > +             KVM_STATS_BASE_POW10, 0)
> > +
> > +/* Cumulative memory size in Byte */
> > +#define STATS_DESC_SIZE_BYTE(SCOPE, name)                                   \
> > +     STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,               \
> > +             KVM_STATS_BASE_POW2, 0)
> > +/* Cumulative memory size in KiByte */
> > +#define STATS_DESC_SIZE_KBYTE(SCOPE, name)                                  \
> > +     STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,               \
> > +             KVM_STATS_BASE_POW2, 10)
> > +/* Cumulative memory size in MiByte */
> > +#define STATS_DESC_SIZE_MBYTE(SCOPE, name)                                  \
> > +     STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,               \
> > +             KVM_STATS_BASE_POW2, 20)
> > +/* Cumulative memory size in GiByte */
> > +#define STATS_DESC_SIZE_GBYTE(SCOPE, name)                                  \
> > +     STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_BYTES,               \
> > +             KVM_STATS_BASE_POW2, 30)
> > +
> > +/* Instantaneous memory size in Byte */
> > +#define STATS_DESC_ISIZE_BYTE(SCOPE, name)                                  \
> > +     STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,                  \
> > +             KVM_STATS_BASE_POW2, 0)
> > +/* Instantaneous memory size in KiByte */
> > +#define STATS_DESC_ISIZE_KBYTE(SCOPE, name)                                 \
> > +     STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,                  \
> > +             KVM_STATS_BASE_POW2, 10)
> > +/* Instantaneous memory size in MiByte */
> > +#define STATS_DESC_ISIZE_MBYTE(SCOPE, name)                                 \
> > +     STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,                  \
> > +             KVM_STATS_BASE_POW2, 20)
> > +/* Instantaneous memory size in GiByte */
> > +#define STATS_DESC_ISIZE_GBYTE(SCOPE, name)                                 \
> > +     STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_BYTES,                  \
> > +             KVM_STATS_BASE_POW2, 30)
> > +
> > +/* Cumulative time in second */
> > +#define STATS_DESC_TIME_SEC(SCOPE, name)                                    \
> > +     STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,             \
> > +             KVM_STATS_BASE_POW10, 0)
> > +/* Cumulative time in millisecond */
> > +#define STATS_DESC_TIME_MSEC(SCOPE, name)                                   \
> > +     STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,             \
> > +             KVM_STATS_BASE_POW10, -3)
> > +/* Cumulative time in microsecond */
> > +#define STATS_DESC_TIME_USEC(SCOPE, name)                                   \
> > +     STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,             \
> > +             KVM_STATS_BASE_POW10, -6)
> > +/* Cumulative time in nanosecond */
> > +#define STATS_DESC_TIME_NSEC(SCOPE, name)                                   \
> > +     STATS_DESC_CUMULATIVE(SCOPE, name, KVM_STATS_UNIT_SECONDS,             \
> > +             KVM_STATS_BASE_POW10, -9)
> > +
> > +/* Instantaneous time in second */
> > +#define STATS_DESC_ITIME_SEC(SCOPE, name)                                   \
> > +     STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,                \
> > +             KVM_STATS_BASE_POW10, 0)
> > +/* Instantaneous time in millisecond */
> > +#define STATS_DESC_ITIME_MSEC(SCOPE, name)                                  \
> > +     STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,                \
> > +             KVM_STATS_BASE_POW10, -3)
> > +/* Instantaneous time in microsecond */
> > +#define STATS_DESC_ITIME_USEC(SCOPE, name)                                  \
> > +     STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,                \
> > +             KVM_STATS_BASE_POW10, -6)
> > +/* Instantaneous time in nanosecond */
> > +#define STATS_DESC_ITIME_NSEC(SCOPE, name)                                  \
> > +     STATS_DESC_INSTANT(SCOPE, name, KVM_STATS_UNIT_SECONDS,                \
> > +             KVM_STATS_BASE_POW10, -9)
> > +
> >  extern struct kvm_stats_debugfs_item debugfs_entries[];
> >  extern struct dentry *kvm_debugfs_dir;
> > +ssize_t kvm_stats_read(char *id, struct kvm_stats_header *header,
> > +             struct _kvm_stats_desc *desc, void *stats, size_t size_stats,
> > +             char __user *user_buffer, size_t size, loff_t *offset);
> >
> >  #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> >  static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 9febe1412f7a..ab73e905105c 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -1086,6 +1086,7 @@ struct kvm_ppc_resize_hpt {
> >  #define KVM_CAP_HYPERV_ENFORCE_CPUID 199
> >  #define KVM_CAP_SREGS2 200
> >  #define KVM_CAP_EXIT_HYPERCALL 201
> > +#define KVM_CAP_BINARY_STATS_FD 202
> >
> >  #ifdef KVM_CAP_IRQ_ROUTING
> >
> > @@ -1905,4 +1906,45 @@ struct kvm_dirty_gfn {
> >  #define KVM_BUS_LOCK_DETECTION_OFF             (1 << 0)
> >  #define KVM_BUS_LOCK_DETECTION_EXIT            (1 << 1)
> >
> > +#define KVM_STATS_ID_MAXLEN          64
> > +
> > +struct kvm_stats_header {
> > +     __u32 name_size;
> > +     __u32 count;
> > +     __u32 desc_offset;
> > +     __u32 data_offset;
> > +     char id[];
> > +};
>
> You mentioned before that the size of this really is the size of the
> structure + KVM_STATS_ID_MAXLEN, right?  Or is it - KVM_STATS_ID_MAXLEN?
>
> If so, why not put that value explicitly in:
>         char id[THE_REST_OF_THE_HEADER_SPACE];
>
> As this is not a variable header size at all, and you can not change it
> going forward, so the variable length array here feels disingenuous.
The size of header is not supposed to change, it is sizeof(struct
kvm_stats_header) +
KVM_STATS_ID_MAXLEN. Userspace needs this when reading the header.
Sorry for the confusion, will make that clear.

The reason char id[] is used instead of char id[KVM_STATS_ID_MAXLEN] is because
the header is only defined (and can be const as you mentioned) for
every architecture, but
the id string is different for every VM and VCPU. The content of the
header is combined
on-the-fly in the kvm_stats_read function.
If we use id[KVM_STATS_ID_MAXLEN] here, then we will waste some memory in every
header definition.
Another option is to define another internal header structure without
id[] field, which can be
used to define the const part of header for every architecture. But
that will have two structures
for the same header, we need to make sure these two structures are the
same except the id[]
field.

So, Greg, Paolo, What do you think? Which solution should we choose
from 3 options?
>
>
>
> > +
> > +#define KVM_STATS_TYPE_SHIFT         0
> > +#define KVM_STATS_TYPE_MASK          (0xF << KVM_STATS_TYPE_SHIFT)
> > +#define KVM_STATS_TYPE_CUMULATIVE    (0x0 << KVM_STATS_TYPE_SHIFT)
> > +#define KVM_STATS_TYPE_INSTANT               (0x1 << KVM_STATS_TYPE_SHIFT)
> > +#define KVM_STATS_TYPE_MAX           KVM_STATS_TYPE_INSTANT
> > +
> > +#define KVM_STATS_UNIT_SHIFT         4
> > +#define KVM_STATS_UNIT_MASK          (0xF << KVM_STATS_UNIT_SHIFT)
> > +#define KVM_STATS_UNIT_NONE          (0x0 << KVM_STATS_UNIT_SHIFT)
> > +#define KVM_STATS_UNIT_BYTES         (0x1 << KVM_STATS_UNIT_SHIFT)
> > +#define KVM_STATS_UNIT_SECONDS               (0x2 << KVM_STATS_UNIT_SHIFT)
> > +#define KVM_STATS_UNIT_CYCLES                (0x3 << KVM_STATS_UNIT_SHIFT)
> > +#define KVM_STATS_UNIT_MAX           KVM_STATS_UNIT_CYCLES
> > +
> > +#define KVM_STATS_BASE_SHIFT         8
> > +#define KVM_STATS_BASE_MASK          (0xF << KVM_STATS_BASE_SHIFT)
> > +#define KVM_STATS_BASE_POW10         (0x0 << KVM_STATS_BASE_SHIFT)
> > +#define KVM_STATS_BASE_POW2          (0x1 << KVM_STATS_BASE_SHIFT)
> > +#define KVM_STATS_BASE_MAX           KVM_STATS_BASE_POW2
> > +
> > +struct kvm_stats_desc {
> > +     __u32 flags;
> > +     __s16 exponent;
> > +     __u16 size;
> > +     __u32 offset;
> > +     __u32 unused;
> > +     char name[];
> > +};
>
> What is the max length of name?
>
As Paolo mentioned, it is read from the header.
> Why aren't these structures defined here in kerneldoc so that we can
> understand them better?  Putting them in a .rst file guarantees they
> will get out of sync, and you can always directly import the kerneldoc
> into the .rst file.
>
> thanks,
>
> greg k-h
