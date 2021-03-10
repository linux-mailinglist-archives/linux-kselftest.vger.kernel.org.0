Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507B733472E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Mar 2021 19:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhCJSwa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Mar 2021 13:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbhCJSwK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Mar 2021 13:52:10 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BF5C061762
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Mar 2021 10:52:09 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f1so35307581lfu.3
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Mar 2021 10:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PuEmabyl2s2MzgXl00WwcqLBagPG3pVCuCKCrjVk8Ks=;
        b=IT8UgO0PY2MgMXUJI6VFJrdyurLARMOU71FMvxq00ydHjkwt2FN4pfNiHBTnIdp+Bx
         q81G7g7DEIdkICSp7PqKa+fDO6DSJ76isMMjTv3wInZw/NvFs2xsOxWam71ulAo7NX3S
         YXCGAJlFGyKeuyQG5PTBOrNSaNiHfBe8Yvt+6RrE6WOssOg1ie77ATll7YoJCFZJgWah
         tpN2cXnhgxWQZDp6c117CLRvKJAdlgCahNK7CNj6hjYDR01+akl0nSEqYm8qRBNIF0kZ
         QOgESwgJvCGUyM5PK4FXVaBBK9cvMsFGd+TnJjppb/pdrRBMrn2LxfwWpFdd2pu2wM6l
         5gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PuEmabyl2s2MzgXl00WwcqLBagPG3pVCuCKCrjVk8Ks=;
        b=KayyUp4LVUeCGHhVlHe/za1jYHWGEYigROcpxzJ3i97hfSSHmNsHwFIFQIrs/F7vY0
         KcAaMZibtQvq+/M7OoTw9o3dUueURbrTKnoIncsRY0VUWLwO4hLWj8Sy5rbduesvte8E
         7vrPXlwojR3GisXk9TX8+AEoqr3xxJLu07iPcQOl8FdjFnJJ6CfFsg5HRzAuqtzQcsq9
         Cw9w6XsZ+50ICfyW+BWi+ZScxvs7LEqIo+BP3YdvhsOhB0YSVog2u6td1Wlfu8exiww2
         DSckpVDLr4nOE5KWkEuZ48SZVliRFtiqynceA4R7J0RNKS7I1WRwV9r4oC02yrAq3rmX
         EobA==
X-Gm-Message-State: AOAM533Hs+1z5QxM4TM6gwfalIqJSLGH7uzEAIp3GVHadSULtQnU+aXI
        tOxMGCnHHonkycFma+Jccu0Sn5E0VZXhnUM9am9wKQ==
X-Google-Smtp-Source: ABdhPJxJAGrapXb8FGSApU1K+Acwo9cKRvdxncl71pp0g2SZyVr4Nv1TUqUYKDR1eRt1PMXSAJLF3tPcaX75weBeM+Q=
X-Received: by 2002:ac2:5ca7:: with SMTP id e7mr2824097lfq.646.1615402327931;
 Wed, 10 Mar 2021 10:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20210310003024.2026253-1-jingzhangos@google.com>
 <20210310003024.2026253-2-jingzhangos@google.com> <878s6vxfad.wl-maz@kernel.org>
In-Reply-To: <878s6vxfad.wl-maz@kernel.org>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Wed, 10 Mar 2021 12:51:56 -0600
Message-ID: <CAAdAUtjDe1Sm8GSsMDiiCMxvqT8DkWJ7OqOQmeMa4q0AcDFxwQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] KVM: stats: Separate statistics name strings from
 debugfs code
To:     Marc Zyngier <maz@kernel.org>
Cc:     KVM <kvm@vger.kernel.org>, KVM ARM <kvmarm@lists.cs.columbia.edu>,
        Linux MIPS <linux-mips@vger.kernel.org>,
        KVM PPC <kvm-ppc@vger.kernel.org>,
        Linux S390 <linux-s390@vger.kernel.org>,
        Linux kselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Marc,

On Wed, Mar 10, 2021 at 8:19 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Jing,
>
> On Wed, 10 Mar 2021 00:30:21 +0000,
> Jing Zhang <jingzhangos@google.com> wrote:
> >
> > Prepare the statistics name strings for supporting binary format
> > aggregated statistics data retrieval.
> >
> > No functional change intended.
> >
> > Signed-off-by: Jing Zhang <jingzhangos@google.com>
> > ---
> >  arch/arm64/kvm/guest.c    |  47 ++++--
> >  arch/mips/kvm/mips.c      | 114 ++++++++++----
> >  arch/powerpc/kvm/book3s.c | 107 +++++++++----
> >  arch/powerpc/kvm/booke.c  |  84 +++++++---
> >  arch/s390/kvm/kvm-s390.c  | 320 ++++++++++++++++++++++++++------------
> >  arch/x86/kvm/x86.c        | 127 ++++++++++-----
> >  include/linux/kvm_host.h  |  31 +++-
> >  7 files changed, 589 insertions(+), 241 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> > index 9bbd30e62799..fb3aafe76b52 100644
> > --- a/arch/arm64/kvm/guest.c
> > +++ b/arch/arm64/kvm/guest.c
> > @@ -28,19 +28,42 @@
> >
> >  #include "trace.h"
> >
> > +const char kvm_vm_stat_strings[][KVM_STATS_NAME_LEN] = {
> > +     "remote_tlb_flush",
> > +};
> > +static_assert(sizeof(kvm_vm_stat_strings) ==
> > +             VM_STAT_COUNT * KVM_STATS_NAME_LEN);
> > +
> > +const char kvm_vcpu_stat_strings[][KVM_STATS_NAME_LEN] = {
> > +     "halt_successful_poll",
> > +     "halt_attempted_poll",
> > +     "halt_poll_success_ns",
> > +     "halt_poll_fail_ns",
> > +     "halt_poll_invalid",
> > +     "halt_wakeup",
> > +     "hvc_exit_stat",
> > +     "wfe_exit_stat",
> > +     "wfi_exit_stat",
> > +     "mmio_exit_user",
> > +     "mmio_exit_kernel",
> > +     "exits",
> > +};
> > +static_assert(sizeof(kvm_vcpu_stat_strings) ==
> > +             VCPU_STAT_COUNT * KVM_STATS_NAME_LEN);
> > +
> >  struct kvm_stats_debugfs_item debugfs_entries[] = {
> > -     VCPU_STAT("halt_successful_poll", halt_successful_poll),
> > -     VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
> > -     VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
> > -     VCPU_STAT("halt_wakeup", halt_wakeup),
> > -     VCPU_STAT("hvc_exit_stat", hvc_exit_stat),
> > -     VCPU_STAT("wfe_exit_stat", wfe_exit_stat),
> > -     VCPU_STAT("wfi_exit_stat", wfi_exit_stat),
> > -     VCPU_STAT("mmio_exit_user", mmio_exit_user),
> > -     VCPU_STAT("mmio_exit_kernel", mmio_exit_kernel),
> > -     VCPU_STAT("exits", exits),
> > -     VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
> > -     VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
> > +     VCPU_STAT(halt_successful_poll),
> > +     VCPU_STAT(halt_attempted_poll),
> > +     VCPU_STAT(halt_poll_invalid),
> > +     VCPU_STAT(halt_wakeup),
> > +     VCPU_STAT(hvc_exit_stat),
> > +     VCPU_STAT(wfe_exit_stat),
> > +     VCPU_STAT(wfi_exit_stat),
> > +     VCPU_STAT(mmio_exit_user),
> > +     VCPU_STAT(mmio_exit_kernel),
> > +     VCPU_STAT(exits),
> > +     VCPU_STAT(halt_poll_success_ns),
> > +     VCPU_STAT(halt_poll_fail_ns),
>
> So we now have two arrays that can easily deviate in their order,
> whilst we didn't have that risk before. What is the advantage of doing
> this? The commit message doesn't really say...
You are right about the risk here. The new string array would be returned
to userspace by the new Ioctl API. I didn't figure out any other good
way for this.
Will add this into commit message.
>
> [...]
>
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 1b65e7204344..1ea297458306 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -1162,6 +1162,18 @@ static inline bool kvm_is_error_gpa(struct kvm *kvm, gpa_t gpa)
> >       return kvm_is_error_hva(hva);
> >  }
> >
> > +#define VM_STAT_COUNT                (sizeof(struct kvm_vm_stat)/sizeof(ulong))
> > +#define VCPU_STAT_COUNT              (sizeof(struct kvm_vcpu_stat)/sizeof(u64))
> > +#define KVM_STATS_NAME_LEN   32
> > +
> > +/* Make sure it is synced with fields in struct kvm_vm_stat. */
> > +extern const char kvm_vm_stat_strings[][KVM_STATS_NAME_LEN];
> > +/* Make sure it is synced with fields in struct kvm_vcpu_stat. */
> > +extern const char kvm_vcpu_stat_strings[][KVM_STATS_NAME_LEN];
> > +
> > +#define VM_STAT_NAME(id)        (kvm_vm_stat_strings[id])
> > +#define VCPU_STAT_NAME(id)      (kvm_vcpu_stat_strings[id])
> > +
> >  enum kvm_stat_kind {
> >       KVM_STAT_VM,
> >       KVM_STAT_VCPU,
> > @@ -1182,10 +1194,21 @@ struct kvm_stats_debugfs_item {
> >  #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
> >       ((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
> >
> > -#define VM_STAT(n, x, ...)                                                   \
> > -     { n, offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__ }
> > -#define VCPU_STAT(n, x, ...)                                                 \
> > -     { n, offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__ }
> > +#define VM_STAT(x, ...)                                                        \
> > +     {                                                                      \
> > +             VM_STAT_NAME(offsetof(struct kvm_vm_stat, x)/sizeof(ulong)),   \
> > +             offsetof(struct kvm, stat.x),                                  \
> > +             KVM_STAT_VM,                                                   \
> > +             ## __VA_ARGS__                                                 \
> > +     }
> > +
> > +#define VCPU_STAT(x, ...)                                                      \
> > +     {                                                                      \
> > +             VCPU_STAT_NAME(offsetof(struct kvm_vcpu_stat, x)/sizeof(u64)), \
> > +             offsetof(struct kvm_vcpu, stat.x),                             \
> > +             KVM_STAT_VCPU,                                                 \
> > +             ## __VA_ARGS__                                                 \
> > +     }
>
> Is there any reason why we want to keep kvm_vm_stat populated with
> ulong, while kvm_vcpu_stat is populated with u64? I have the feeling
> that this is a fairly pointless difference, and that some of the
> macros could be unified.
The use of ulong for vm stats is to avoid the overhead of atomics,
since vm stats
could potentially be updated by multiple vcpus from that vm at a time.
Check commit 8a7e75d47b68193339f8727cf4503271d0a0b1d0 for details.
>
> Also, using names initialisers would help with the readability of the
> macros.
Sure, will do.
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Thanks,
Jing
