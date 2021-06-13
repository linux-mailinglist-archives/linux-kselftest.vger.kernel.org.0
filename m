Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB7F3A59AE
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jun 2021 18:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhFMQpm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Jun 2021 12:45:42 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:43699 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhFMQpm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Jun 2021 12:45:42 -0400
Received: by mail-lf1-f48.google.com with SMTP id x24so11293787lfr.10
        for <linux-kselftest@vger.kernel.org>; Sun, 13 Jun 2021 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxzTFYde32gCxGm7VD9c8WrVhW6uOqbg2XOezgA3w1M=;
        b=uAls7Q9BUuSExyGzQpy/Gep0pvL6WL1Tytl3elWE4SPGsH0jUuc49ekOegfYgr4Cvl
         rstznzF78YbSiYvnDWuX7SprWF4UC6mIsnI3TlreUMSw6zPghz5xgOBJheb736ALR+1b
         mJ9s7/41+1KMFMTNfU/bzelOTsFdruHbsvwGQvRha+HqEl4atETIzoPRpAuayxXy61bG
         37yjnlx9bYF/sYOaTMrQ01cOhfZuicjXc+nEnLobbwTT3NVhLeQguJop0gqKtooCLtNt
         qXXivRq2YX32aR3e06p0mgWtUG0qiraZJeEo0uXf7BqsbNo6BxJVcObpEA6B6pxeTleV
         U+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxzTFYde32gCxGm7VD9c8WrVhW6uOqbg2XOezgA3w1M=;
        b=m8iV9A9pMFx1tK1IfzPg5uljwgYQJVuhzPRM1ltNsSbesmNgIFz3m3oHXUTdIggEws
         m/3Krh057neio+snjcUzPwblXN540oYi3Ec5D/Y1RGIL1kLjn65YoMHsb1mF92J7iWjY
         pLDuJnRzfHKLsQ0IGG09iWzWVUCILsTrlDL4GKrbZ/0wtaJXHFSMyWlhXaGOVbxrUYle
         cQYlp77s1+WCZHegEB3Qvz8YYtGQLwuJ7A3lfEesY9i/jRYcd/3Vn+vjCZqIE4REfIsj
         m5W8dHljBgyLPC/UMTWsAFczpRnIx88y6a2L3X5NI/nrMighS68nHvyOigF3jbMpbcLd
         fbXw==
X-Gm-Message-State: AOAM5332okLb3YXicWqTYjtMNmXQCMD7GD36smAW0VdOi/ddl3yvsT/n
        TuLvAjbWNwBPCGdCK0ymnHarGVenixy+Ihx8OWFJnQ==
X-Google-Smtp-Source: ABdhPJycFHQHPQHXjaoXuj681GBbHMFvW+w3scaZxofxXTQiuO2kcKxHz9x/hsWp9ivQ225Z6TckNWZTUug5ei6Wb/4=
X-Received: by 2002:a05:6512:318d:: with SMTP id i13mr9789771lfe.407.1623602559055;
 Sun, 13 Jun 2021 09:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210603211426.790093-1-jingzhangos@google.com>
 <20210603211426.790093-3-jingzhangos@google.com> <CA+EHjTyo0RDW9qcUTRMpAkTgRi32W_Fh7XL-F27dv4ogRAxJjg@mail.gmail.com>
In-Reply-To: <CA+EHjTyo0RDW9qcUTRMpAkTgRi32W_Fh7XL-F27dv4ogRAxJjg@mail.gmail.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Sun, 13 Jun 2021 11:42:27 -0500
Message-ID: <CAAdAUthE9Lj8GPb0U79xr+Wmpf2BGhmcgqmeYV+Q=GBgRM+nPw@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] KVM: stats: Add fd-based API to read binary stats data
To:     Fuad Tabba <tabba@google.com>
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
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Faud,

On Sun, Jun 13, 2021 at 10:20 AM Fuad Tabba <tabba@google.com> wrote:
>
> Hi Jing,
>
> > diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> > index ff205b35719b..eb8fd4a96952 100644
> > --- a/arch/mips/kvm/mips.c
> > +++ b/arch/mips/kvm/mips.c
> > @@ -38,6 +38,58 @@
> >  #define VECTORSPACING 0x100    /* for EI/VI mode */
> >  #endif
> >
> > +struct _kvm_stats_desc kvm_vm_stats_desc[] = DEFINE_VM_STATS_DESC();
> > +
> > +struct _kvm_stats_header kvm_vm_stats_header = {
> > +       .name_size = KVM_STATS_NAME_LEN,
> > +       .count = ARRAY_SIZE(kvm_vm_stats_desc),
> > +       .desc_offset = sizeof(struct kvm_stats_header),
> > +       .data_offset = sizeof(struct kvm_stats_header) +
> > +               sizeof(kvm_vm_stats_desc),
> > +};
> > +
> > +struct _kvm_stats_desc kvm_vcpu_stats_desc[] = DEFINE_VCPU_STATS_DESC(
> > +       STATS_DESC_COUNTER("wait_exits"),
> > +       STATS_DESC_COUNTER("cache_exits"),
> > +       STATS_DESC_COUNTER("signal_exits"),
> > +       STATS_DESC_COUNTER("int_exits"),
> > +       STATS_DESC_COUNTER("cop_unusable_exits"),
> > +       STATS_DESC_COUNTER("tlbmod_exits"),
> > +       STATS_DESC_COUNTER("tlbmiss_ld_exits"),
> > +       STATS_DESC_COUNTER("tlbmiss_st_exits"),
> > +       STATS_DESC_COUNTER("addrerr_st_exits"),
> > +       STATS_DESC_COUNTER("addrerr_ld_exits"),
> > +       STATS_DESC_COUNTER("syscall_exits"),
> > +       STATS_DESC_COUNTER("resvd_inst_exits"),
> > +       STATS_DESC_COUNTER("break_inst_exits"),
> > +       STATS_DESC_COUNTER("trap_inst_exits"),
> > +       STATS_DESC_COUNTER("msa_fpe_exits"),
> > +       STATS_DESC_COUNTER("fpe_exits"),
> > +       STATS_DESC_COUNTER("msa_disabled_exits"),
> > +       STATS_DESC_COUNTER("flush_dcache_exits"),
> > +#ifdef CONFIG_KVM_MIPS_VZ
> > +       STATS_DESC_COUNTER("vz_gpsi_exits"),
> > +       STATS_DESC_COUNTER("vz_gsfc_exits"),
> > +       STATS_DESC_COUNTER("vz_hc_exits"),
> > +       STATS_DESC_COUNTER("vz_grr_exits"),
> > +       STATS_DESC_COUNTER("vz_gva_exits"),
> > +       STATS_DESC_COUNTER("vz_ghfc_exits"),
> > +       STATS_DESC_COUNTER("vz_gpa_exits"),
> > +       STATS_DESC_COUNTER("vz_resvd_exits"),
> > +#ifdef CONFIG_CPU_LOONGSON64
> > +       STATS_DESC_COUNTER("vz_cpucfg_exits"),
> > +#endif
> > +#endif
> > +       );
>
> I'm not sure if this is because I've applied your patches on a
> different base than the one you're using (I'm using 5.13-rc6), but it
> seems that CONFIG_KVM_MIPS_VZ isn't there anymore. Moreover, looking
> at your earlier patch (v7 1/4), although truncated, it doesn't seem
> that your version of arch/mips/include/asm/kvm_host.h has that config
> either. Again, could be a user-error on my part, but might be worth
> checking.
>
Good eyes! The removal of CONFIG_KVM_MIPS_VZ came in after my early
version of patchset. My later auto rebase didn't catch that change.
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 96d10253218a..8e900c482626 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -214,6 +214,59 @@ EXPORT_SYMBOL_GPL(host_xss);
> >  u64 __read_mostly supported_xss;
> >  EXPORT_SYMBOL_GPL(supported_xss);
> >
> > +struct _kvm_stats_desc kvm_vm_stats_desc[] = DEFINE_VM_STATS_DESC(
> > +       STATS_DESC_COUNTER("mmu_shadow_zapped"),
> > +       STATS_DESC_COUNTER("mmu_pte_write"),
> > +       STATS_DESC_COUNTER("mmu_pde_zapped"),
> > +       STATS_DESC_COUNTER("mmu_flooded"),
> > +       STATS_DESC_COUNTER("mmu_recycled"),
> > +       STATS_DESC_COUNTER("mmu_cache_miss"),
> > +       STATS_DESC_ICOUNTER("mmu_unsync"),
> > +       STATS_DESC_ICOUNTER("largepages"),
> > +       STATS_DESC_ICOUNTER("nx_largepages_splits"),
> > +       STATS_DESC_ICOUNTER("max_mmu_page_hash_collisions"));
> > +
> > +struct _kvm_stats_header kvm_vm_stats_header = {
> > +       .name_size = KVM_STATS_NAME_LEN,
> > +       .count = ARRAY_SIZE(kvm_vm_stats_desc),
> > +       .desc_offset = sizeof(struct kvm_stats_header),
> > +       .data_offset = sizeof(struct kvm_stats_header) +
> > +               sizeof(kvm_vm_stats_desc),
> > +};
> > +
> > +struct _kvm_stats_desc kvm_vcpu_stats_desc[] = DEFINE_VCPU_STATS_DESC(
> > +       STATS_DESC_COUNTER("pf_fixed"),
> > +       STATS_DESC_COUNTER("pf_guest"),
> > +       STATS_DESC_COUNTER("tlb_flush"),
> > +       STATS_DESC_COUNTER("invlpg"),
> > +       STATS_DESC_COUNTER("exits"),
> > +       STATS_DESC_COUNTER("io_exits"),
> > +       STATS_DESC_COUNTER("mmio_exits"),
> > +       STATS_DESC_COUNTER("signal_exits"),
> > +       STATS_DESC_COUNTER("irq_window_exits"),
> > +       STATS_DESC_COUNTER("nmi_window_exits"),
> > +       STATS_DESC_COUNTER("l1d_flush"),
> > +       STATS_DESC_COUNTER("halt_exits"),
> > +       STATS_DESC_COUNTER("request_irq_exits"),
> > +       STATS_DESC_COUNTER("irq_exits"),
> > +       STATS_DESC_COUNTER("host_state_reload"),
> > +       STATS_DESC_COUNTER("fpu_reload"),
> > +       STATS_DESC_COUNTER("insn_emulation"),
> > +       STATS_DESC_COUNTER("insn_emulation_fail"),
> > +       STATS_DESC_COUNTER("hypercalls"),
> > +       STATS_DESC_COUNTER("irq_injections"),
> > +       STATS_DESC_COUNTER("nmi_injections"),
> > +       STATS_DESC_COUNTER("req_event"),
> > +       STATS_DESC_COUNTER("nested_run"));
>
> Have you deliberately left out directed_yield_attempted and
> directed_yield_successful (from struct kvm_vcpu_stat in
> arch/x86/include/asm/kvm_host.h), or should they be here as well?
>
> Thanks,
> /fuad
>
Thanks. Same problem caused from rebase. Also another one "guest_mode"
is missing too.
Will double check similar issues and add static assertion to make sure the
number of stats descriptors matches the number of stats defined in vm and
vcpu stats structures.
> > +struct _kvm_stats_header kvm_vcpu_stats_header = {
> > +       .name_size = KVM_STATS_NAME_LEN,
> > +       .count = ARRAY_SIZE(kvm_vcpu_stats_desc),
> > +       .desc_offset = sizeof(struct kvm_stats_header),
> > +       .data_offset = sizeof(struct kvm_stats_header) +
> > +               sizeof(kvm_vcpu_stats_desc),
> > +};
> > +
> >  struct kvm_stats_debugfs_item debugfs_entries[] = {
> >         VCPU_STAT("pf_fixed", pf_fixed),
> >         VCPU_STAT("pf_guest", pf_guest),
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 1870fa928762..873e21af36be 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -1240,6 +1240,19 @@ struct kvm_stats_debugfs_item {
> >         int mode;
> >  };
> >
> > +struct _kvm_stats_header {
> > +       __u32 name_size;
> > +       __u32 count;
> > +       __u32 desc_offset;
> > +       __u32 data_offset;
> > +};
> > +
> > +#define KVM_STATS_NAME_LEN     48
> > +struct _kvm_stats_desc {
> > +       struct kvm_stats_desc desc;
> > +       char name[KVM_STATS_NAME_LEN];
> > +};
> > +
> >  #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
> >         ((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
> >
> > @@ -1253,8 +1266,127 @@ struct kvm_stats_debugfs_item {
> >         { n, offsetof(struct kvm_vcpu, stat.generic.x),                        \
> >           KVM_STAT_VCPU, ## __VA_ARGS__ }
> >
> > +#define STATS_DESC(stat, type, unit, scale, exp)                              \
> > +       {                                                                      \
> > +               {                                                              \
> > +                       .flags = type | unit | scale,                          \
> > +                       .exponent = exp,                                       \
> > +                       .size = 1                                              \
> > +               },                                                             \
> > +               .name = stat,                                                  \
> > +       }
> > +#define STATS_DESC_CUMULATIVE(name, unit, scale, exponent)                    \
> > +       STATS_DESC(name, KVM_STATS_TYPE_CUMULATIVE, unit, scale, exponent)
> > +#define STATS_DESC_INSTANT(name, unit, scale, exponent)                               \
> > +       STATS_DESC(name, KVM_STATS_TYPE_INSTANT, unit, scale, exponent)
> > +
> > +/* Cumulative counter */
> > +#define STATS_DESC_COUNTER(name)                                              \
> > +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_NONE,                       \
> > +               KVM_STATS_BASE_POW10, 0)
> > +/* Instantaneous counter */
> > +#define STATS_DESC_ICOUNTER(name)                                             \
> > +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_NONE,                          \
> > +               KVM_STATS_BASE_POW10, 0)
> > +
> > +/* Cumulative clock cycles */
> > +#define STATS_DESC_CYCLE(name)                                                \
> > +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_CYCLES,                     \
> > +               KVM_STATS_BASE_POW10, 0)
> > +/* Instantaneous clock cycles */
> > +#define STATS_DESC_ICYCLE(name)                                                       \
> > +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_CYCLES,                        \
> > +               KVM_STATS_BASE_POW10, 0)
> > +
> > +/* Cumulative memory size in Byte */
> > +#define STATS_DESC_SIZE_BYTE(name)                                            \
> > +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_BYTES,                      \
> > +               KVM_STATS_BASE_POW2, 0)
> > +/* Cumulative memory size in KiByte */
> > +#define STATS_DESC_SIZE_KBYTE(name)                                           \
> > +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_BYTES,                      \
> > +               KVM_STATS_BASE_POW2, 10)
> > +/* Cumulative memory size in MiByte */
> > +#define STATS_DESC_SIZE_MBYTE(name)                                           \
> > +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_BYTES,                      \
> > +               KVM_STATS_BASE_POW2, 20)
> > +/* Cumulative memory size in GiByte */
> > +#define STATS_DESC_SIZE_GBYTE(name)                                           \
> > +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_BYTES,                      \
> > +               KVM_STATS_BASE_POW2, 30)
> > +
> > +/* Instantaneous memory size in Byte */
> > +#define STATS_DESC_ISIZE_BYTE(name)                                           \
> > +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_BYTES,                         \
> > +               KVM_STATS_BASE_POW2, 0)
> > +/* Instantaneous memory size in KiByte */
> > +#define STATS_DESC_ISIZE_KBYTE(name)                                          \
> > +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_BYTES,                         \
> > +               KVM_STATS_BASE_POW2, 10)
> > +/* Instantaneous memory size in MiByte */
> > +#define STATS_DESC_ISIZE_MBYTE(name)                                          \
> > +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_BYTES,                         \
> > +               KVM_STATS_BASE_POW2, 20)
> > +/* Instantaneous memory size in GiByte */
> > +#define STATS_DESC_ISIZE_GBYTE(name)                                          \
> > +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_BYTES,                         \
> > +               KVM_STATS_BASE_POW2, 30)
> > +
> > +/* Cumulative time in second */
> > +#define STATS_DESC_TIME_SEC(name)                                             \
> > +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_SECONDS,                    \
> > +               KVM_STATS_BASE_POW10, 0)
> > +/* Cumulative time in millisecond */
> > +#define STATS_DESC_TIME_MSEC(name)                                            \
> > +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_SECONDS,                    \
> > +               KVM_STATS_BASE_POW10, -3)
> > +/* Cumulative time in microsecond */
> > +#define STATS_DESC_TIME_USEC(name)                                            \
> > +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_SECONDS,                    \
> > +               KVM_STATS_BASE_POW10, -6)
> > +/* Cumulative time in nanosecond */
> > +#define STATS_DESC_TIME_NSEC(name)                                            \
> > +       STATS_DESC_CUMULATIVE(name, KVM_STATS_UNIT_SECONDS,                    \
> > +               KVM_STATS_BASE_POW10, -9)
> > +
> > +/* Instantaneous time in second */
> > +#define STATS_DESC_ITIME_SEC(name)                                            \
> > +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_SECONDS,                       \
> > +               KVM_STATS_BASE_POW10, 0)
> > +/* Instantaneous time in millisecond */
> > +#define STATS_DESC_ITIME_MSEC(name)                                           \
> > +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_SECONDS,                       \
> > +               KVM_STATS_BASE_POW10, -3)
> > +/* Instantaneous time in microsecond */
> > +#define STATS_DESC_ITIME_USEC(name)                                           \
> > +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_SECONDS,                       \
> > +               KVM_STATS_BASE_POW10, -6)
> > +/* Instantaneous time in nanosecond */
> > +#define STATS_DESC_ITIME_NSEC(name)                                           \
> > +       STATS_DESC_INSTANT(name, KVM_STATS_UNIT_SECONDS,                       \
> > +               KVM_STATS_BASE_POW10, -9)
> > +
> > +#define DEFINE_VM_STATS_DESC(...) {                                           \
> > +       STATS_DESC_COUNTER("remote_tlb_flush"),                                \
> > +       ## __VA_ARGS__                                                         \
> > +}
> > +
> > +#define DEFINE_VCPU_STATS_DESC(...) {                                         \
> > +       STATS_DESC_COUNTER("halt_successful_poll"),                            \
> > +       STATS_DESC_COUNTER("halt_attempted_poll"),                             \
> > +       STATS_DESC_COUNTER("halt_poll_invalid"),                               \
> > +       STATS_DESC_COUNTER("halt_wakeup"),                                     \
> > +       STATS_DESC_TIME_NSEC("halt_poll_success_ns"),                          \
> > +       STATS_DESC_TIME_NSEC("halt_poll_fail_ns"),                             \
> > +       ## __VA_ARGS__                                                         \
> > +}
> > +
> >  extern struct kvm_stats_debugfs_item debugfs_entries[];
> >  extern struct dentry *kvm_debugfs_dir;
> > +extern struct _kvm_stats_header kvm_vm_stats_header;
> > +extern struct _kvm_stats_header kvm_vcpu_stats_header;
> > +extern struct _kvm_stats_desc kvm_vm_stats_desc[];
> > +extern struct _kvm_stats_desc kvm_vcpu_stats_desc[];
> >
> >  #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> >  static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 3fd9a7e9d90c..dcfa0315e3f9 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -1082,6 +1082,7 @@ struct kvm_ppc_resize_hpt {
> >  #define KVM_CAP_SGX_ATTRIBUTE 196
> >  #define KVM_CAP_VM_COPY_ENC_CONTEXT_FROM 197
> >  #define KVM_CAP_PTP_KVM 198
> > +#define KVM_CAP_STATS_BINARY_FD 199
> >
> >  #ifdef KVM_CAP_IRQ_ROUTING
> >
> > @@ -1898,4 +1899,53 @@ struct kvm_dirty_gfn {
> >  #define KVM_BUS_LOCK_DETECTION_OFF             (1 << 0)
> >  #define KVM_BUS_LOCK_DETECTION_EXIT            (1 << 1)
> >
> > +#define KVM_STATS_ID_MAXLEN            64
> > +
> > +struct kvm_stats_header {
> > +       char id[KVM_STATS_ID_MAXLEN];
> > +       __u32 name_size;
> > +       __u32 count;
> > +       __u32 desc_offset;
> > +       __u32 data_offset;
> > +};
> > +
> > +#define KVM_STATS_TYPE_SHIFT           0
> > +#define KVM_STATS_TYPE_MASK            (0xF << KVM_STATS_TYPE_SHIFT)
> > +#define KVM_STATS_TYPE_CUMULATIVE      (0x0 << KVM_STATS_TYPE_SHIFT)
> > +#define KVM_STATS_TYPE_INSTANT         (0x1 << KVM_STATS_TYPE_SHIFT)
> > +#define KVM_STATS_TYPE_MAX             KVM_STATS_TYPE_INSTANT
> > +
> > +#define KVM_STATS_UNIT_SHIFT           4
> > +#define KVM_STATS_UNIT_MASK            (0xF << KVM_STATS_UNIT_SHIFT)
> > +#define KVM_STATS_UNIT_NONE            (0x0 << KVM_STATS_UNIT_SHIFT)
> > +#define KVM_STATS_UNIT_BYTES           (0x1 << KVM_STATS_UNIT_SHIFT)
> > +#define KVM_STATS_UNIT_SECONDS         (0x2 << KVM_STATS_UNIT_SHIFT)
> > +#define KVM_STATS_UNIT_CYCLES          (0x3 << KVM_STATS_UNIT_SHIFT)
> > +#define KVM_STATS_UNIT_MAX             KVM_STATS_UNIT_CYCLES
> > +
> > +#define KVM_STATS_BASE_SHIFT           8
> > +#define KVM_STATS_BASE_MASK            (0xF << KVM_STATS_BASE_SHIFT)
> > +#define KVM_STATS_BASE_POW10           (0x0 << KVM_STATS_BASE_SHIFT)
> > +#define KVM_STATS_BASE_POW2            (0x1 << KVM_STATS_BASE_SHIFT)
> > +#define KVM_STATS_BASE_MAX             KVM_STATS_BASE_POW2
> > +
> > +struct kvm_stats_desc {
> > +       __u32 flags;
> > +       __s16 exponent;
> > +       __u16 size;
> > +       __u32 unused1;
> > +       __u32 unused2;
> > +       char name[0];
> > +};
> > +
> > +struct kvm_vm_stats_data {
> > +       unsigned long value[0];
> > +};
> > +
> > +struct kvm_vcpu_stats_data {
> > +       __u64 value[0];
> > +};
> > +
> > +#define KVM_GET_STATS_FD  _IOR(KVMIO,  0xcc, struct kvm_stats_header)
> > +
> >  #endif /* __LINUX_KVM_H */
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index f6ad5b080994..d84bb17bdea8 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -3409,6 +3409,115 @@ static int kvm_vcpu_ioctl_set_sigmask(struct kvm_vcpu *vcpu, sigset_t *sigset)
> >         return 0;
> >  }
> >
> > +static ssize_t kvm_stats_read(char *id, struct _kvm_stats_header *header,
> > +               struct _kvm_stats_desc *desc, void *stats, size_t size_stats,
> > +               char __user *user_buffer, size_t size, loff_t *offset)
> > +{
> > +       ssize_t copylen, len, remain = size;
> > +       size_t size_header, size_desc;
> > +       loff_t pos = *offset;
> > +       char __user *dest = user_buffer;
> > +       void *src;
> > +
> > +       size_header = sizeof(*header);
> > +       size_desc = header->count * sizeof(*desc);
> > +
> > +       len = KVM_STATS_ID_MAXLEN + size_header + size_desc + size_stats - pos;
> > +       len = min(len, remain);
> > +       if (len <= 0)
> > +               return 0;
> > +       remain = len;
> > +
> > +       /* Copy kvm stats header id string */
> > +       copylen = KVM_STATS_ID_MAXLEN - pos;
> > +       copylen = min(copylen, remain);
> > +       if (copylen > 0) {
> > +               src = id + pos;
> > +               if (copy_to_user(dest, src, copylen))
> > +                       return -EFAULT;
> > +               remain -= copylen;
> > +               pos += copylen;
> > +               dest += copylen;
> > +       }
> > +       /* Copy kvm stats header */
> > +       copylen = KVM_STATS_ID_MAXLEN + size_header - pos;
> > +       copylen = min(copylen, remain);
> > +       if (copylen > 0) {
> > +               src = header + pos - KVM_STATS_ID_MAXLEN;
> > +               if (copy_to_user(dest, src, copylen))
> > +                       return -EFAULT;
> > +               remain -= copylen;
> > +               pos += copylen;
> > +               dest += copylen;
> > +       }
> > +       /* Copy kvm stats descriptors */
> > +       copylen = header->desc_offset + size_desc - pos;
> > +       copylen = min(copylen, remain);
> > +       if (copylen > 0) {
> > +               src = desc + pos - header->desc_offset;
> > +               if (copy_to_user(dest, src, copylen))
> > +                       return -EFAULT;
> > +               remain -= copylen;
> > +               pos += copylen;
> > +               dest += copylen;
> > +       }
> > +       /* Copy kvm stats values */
> > +       copylen = header->data_offset + size_stats - pos;
> > +       copylen = min(copylen, remain);
> > +       if (copylen > 0) {
> > +               src = stats + pos - header->data_offset;
> > +               if (copy_to_user(dest, src, copylen))
> > +                       return -EFAULT;
> > +               remain -= copylen;
> > +               pos += copylen;
> > +               dest += copylen;
> > +       }
> > +
> > +       *offset = pos;
> > +       return len;
> > +}
> > +
> > +static ssize_t kvm_vcpu_stats_read(struct file *file, char __user *user_buffer,
> > +                             size_t size, loff_t *offset)
> > +{
> > +       char id[KVM_STATS_ID_MAXLEN];
> > +       struct kvm_vcpu *vcpu = file->private_data;
> > +
> > +       snprintf(id, sizeof(id), "kvm-%d/vcpu-%d",
> > +                       task_pid_nr(current), vcpu->vcpu_id);
> > +       return kvm_stats_read(id, &kvm_vcpu_stats_header,
> > +                       &kvm_vcpu_stats_desc[0], &vcpu->stat,
> > +                       sizeof(vcpu->stat), user_buffer, size, offset);
> > +}
> > +
> > +static const struct file_operations kvm_vcpu_stats_fops = {
> > +       .read = kvm_vcpu_stats_read,
> > +       .llseek = noop_llseek,
> > +};
> > +
> > +static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
> > +{
> > +       int fd;
> > +       struct file *file;
> > +       char name[15 + ITOA_MAX_LEN + 1];
> > +
> > +       snprintf(name, sizeof(name), "kvm-vcpu-stats:%d", vcpu->vcpu_id);
> > +
> > +       fd = get_unused_fd_flags(O_CLOEXEC);
> > +       if (fd < 0)
> > +               return fd;
> > +
> > +       file = anon_inode_getfile(name, &kvm_vcpu_stats_fops, vcpu, O_RDONLY);
> > +       if (IS_ERR(file)) {
> > +               put_unused_fd(fd);
> > +               return PTR_ERR(file);
> > +       }
> > +       file->f_mode |= FMODE_PREAD;
> > +       fd_install(fd, file);
> > +
> > +       return fd;
> > +}
> > +
> >  static long kvm_vcpu_ioctl(struct file *filp,
> >                            unsigned int ioctl, unsigned long arg)
> >  {
> > @@ -3606,6 +3715,10 @@ static long kvm_vcpu_ioctl(struct file *filp,
> >                 r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
> >                 break;
> >         }
> > +       case KVM_GET_STATS_FD: {
> > +               r = kvm_vcpu_ioctl_get_stats_fd(vcpu);
> > +               break;
> > +       }
> >         default:
> >                 r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
> >         }
> > @@ -3864,6 +3977,8 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
> >  #else
> >                 return 0;
> >  #endif
> > +       case KVM_CAP_STATS_BINARY_FD:
> > +               return 1;
> >         default:
> >                 break;
> >         }
> > @@ -3967,6 +4082,43 @@ static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
> >         }
> >  }
> >
> > +static ssize_t kvm_vm_stats_read(struct file *file, char __user *user_buffer,
> > +                             size_t size, loff_t *offset)
> > +{
> > +       char id[KVM_STATS_ID_MAXLEN];
> > +       struct kvm *kvm = file->private_data;
> > +
> > +       snprintf(id, sizeof(id), "kvm-%d", task_pid_nr(current));
> > +       return kvm_stats_read(id, &kvm_vm_stats_header, &kvm_vm_stats_desc[0],
> > +               &kvm->stat, sizeof(kvm->stat), user_buffer, size, offset);
> > +}
> > +
> > +static const struct file_operations kvm_vm_stats_fops = {
> > +       .read = kvm_vm_stats_read,
> > +       .llseek = noop_llseek,
> > +};
> > +
> > +static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
> > +{
> > +       int fd;
> > +       struct file *file;
> > +
> > +       fd = get_unused_fd_flags(O_CLOEXEC);
> > +       if (fd < 0)
> > +               return fd;
> > +
> > +       file = anon_inode_getfile("kvm-vm-stats",
> > +                       &kvm_vm_stats_fops, kvm, O_RDONLY);
> > +       if (IS_ERR(file)) {
> > +               put_unused_fd(fd);
> > +               return PTR_ERR(file);
> > +       }
> > +       file->f_mode |= FMODE_PREAD;
> > +       fd_install(fd, file);
> > +
> > +       return fd;
> > +}
> > +
> >  static long kvm_vm_ioctl(struct file *filp,
> >                            unsigned int ioctl, unsigned long arg)
> >  {
> > @@ -4149,6 +4301,9 @@ static long kvm_vm_ioctl(struct file *filp,
> >         case KVM_RESET_DIRTY_RINGS:
> >                 r = kvm_vm_ioctl_reset_dirty_pages(kvm);
> >                 break;
> > +       case KVM_GET_STATS_FD:
> > +               r = kvm_vm_ioctl_get_stats_fd(kvm);
> > +               break;
> >         default:
> >                 r = kvm_arch_vm_ioctl(filp, ioctl, arg);
> >         }
> > --
> > 2.32.0.rc1.229.g3e70b5a671-goog
> >
> > _______________________________________________
> > kvmarm mailing list
> > kvmarm@lists.cs.columbia.edu
> > https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

Thanks,
Jing
