Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9D933C969
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Mar 2021 23:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhCOWba (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Mar 2021 18:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhCOWb3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Mar 2021 18:31:29 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84D0C06175F
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Mar 2021 15:31:28 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u20so18170294lja.13
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Mar 2021 15:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t48JfE/I+ydsOOfkocl4ExwOYD4Cwrny9/Xf4iuVVeE=;
        b=YzOHwW9gU+2CCoT9hKyxcZQ9g6o779atEw1QSJLPBRAVTj7Gc0vDffISoB/Cd9mLvk
         keJsigpwHmgy2X42PpmONt7PB65J85QkeCx9fHcaIGkNovhredA86swM4cAXZwH+PSi8
         lRrPBaNDuKAYAs9HX13mcFnjNF4HVRXNtJQ97EfCuIjTjC3+fdoJesfZFgSy75Qsy3h5
         3KMoc/MoTsK7c1+mpTCTSVgVngYK9wFNZHp/tgw8qVex1AQ+P9QYvrUzbu9XpmNTz0v7
         2GyGh2j9ZBeGQ8E+jCJEwyRovr3E+WurRkyCDBICw0iCS9XJ4oKdl+9A7ZLiVshUP9R/
         VTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t48JfE/I+ydsOOfkocl4ExwOYD4Cwrny9/Xf4iuVVeE=;
        b=qFpgvsTqO9O3WFV4GbRShCWCLks0PnVax/Caj0Yr52m2No5SaHg3L1Skz7+ZU6KNbP
         ETld/oH4Rqc0P9iJFZFaA4BLxge81o8ckr35/yS1RrU1U0076yw2EQFs5TW3ZNoxnwiX
         PO/xDGUkCqdhcORfuf8XbdeMyXKsUq03nup+f/YXo9lgiDk61jzlhN9vdwR5lqsjthbP
         b0PB0E+0ehqnuCCIzYFTw1Ls7X/T7/VjKVwr0IDrQkjQEh9hZsS3bppwDBe3Yspc9rfh
         PCAKHH57trOVmJ8WxxHL9Mcn/3WSb6LwlV0hUL+u2CveyasVPE+vGT+IHWD46hjpkTch
         jVEw==
X-Gm-Message-State: AOAM531BYur7zdPmR4WuiPD+umaG+Ki2RLJR2q+Y6pzVRxu2t9fbWIO5
        G5mbuVCWC8CYS45CWqzoXO3N4QNqzKxvLI6IAX51xg==
X-Google-Smtp-Source: ABdhPJxjr/et45iqQeRMTErI0LQhEQm42DqVbpHRSpcjhEUlWFO96pLBoZaf9saYhs4q/r0gUqfHvBityBsZA51vteE=
X-Received: by 2002:a2e:988f:: with SMTP id b15mr751964ljj.394.1615847486669;
 Mon, 15 Mar 2021 15:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210310003024.2026253-1-jingzhangos@google.com>
 <20210310003024.2026253-4-jingzhangos@google.com> <bb03107c-a413-50da-e228-d338dd471fb3@redhat.com>
In-Reply-To: <bb03107c-a413-50da-e228-d338dd471fb3@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Mon, 15 Mar 2021 17:31:15 -0500
Message-ID: <CAAdAUth0J6z7fFpOkkmzKc83Bj+MST-jhsZ0uU0iYdRcE_-gMA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] KVM: stats: Add ioctl commands to pull statistics
 in binary format
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, KVM ARM <kvmarm@lists.cs.columbia.edu>,
        Linux MIPS <linux-mips@vger.kernel.org>,
        KVM PPC <kvm-ppc@vger.kernel.org>,
        Linux S390 <linux-s390@vger.kernel.org>,
        Linux kselftest <linux-kselftest@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paolo,

On Wed, Mar 10, 2021 at 8:55 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/03/21 01:30, Jing Zhang wrote:
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 383df23514b9..87dd62516c8b 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -3464,6 +3464,51 @@ static long kvm_vcpu_ioctl(struct file *filp,
> >               r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
> >               break;
> >       }
> > +     case KVM_STATS_GET_INFO: {
> > +             struct kvm_stats_info stats_info;
> > +
> > +             r = -EFAULT;
> > +             stats_info.num_stats = VCPU_STAT_COUNT;
> > +             if (copy_to_user(argp, &stats_info, sizeof(stats_info)))
> > +                     goto out;
> > +             r = 0;
> > +             break;
> > +     }
> > +     case KVM_STATS_GET_NAMES: {
> > +             struct kvm_stats_names stats_names;
> > +
> > +             r = -EFAULT;
> > +             if (copy_from_user(&stats_names, argp, sizeof(stats_names)))
> > +                     goto out;
> > +             r = -EINVAL;
> > +             if (stats_names.size < VCPU_STAT_COUNT * KVM_STATS_NAME_LEN)
> > +                     goto out;
> > +
> > +             r = -EFAULT;
> > +             if (copy_to_user(argp + sizeof(stats_names),
> > +                             kvm_vcpu_stat_strings,
> > +                             VCPU_STAT_COUNT * KVM_STATS_NAME_LEN))
>
> The only reason to separate the strings in patch 1 is to pass them here.
>   But this is a poor API because it imposes a limit on the length of the
> statistics, and makes that length part of the binary interface.
>
> I would prefer a completely different interface, where you have a file
> descriptor that can be created and associated to a vCPU or VM (or even
> to /dev/kvm).  Having a file descriptor is important because the fd can
We are considering about how to create the file descriptor. It might be risky
to create an extra fd for every vCPU. It will easily hit the fd limit for the
process or the system for machines running a ton of small VMs.
Looks like creating an extra file descriptor for every VM is a better option.
And then we can check per vCPU stats through Ioctl of this VM fd by
passing the vCPU index.
What do you think?
> be passed to a less-privileged process that takes care of gathering the
> metrics
>
> The result of reading the file descriptor could be either ASCII or
> binary.  IMO the real cost lies in opening and reading a multitude of
> files rather than in the ASCII<->binary conversion.
>
> The format could be one of the following:
>
> * binary:
>
> 4 bytes flags (always zero)
> 4 bytes number of statistics
> 4 bytes offset of the first stat description
> 4 bytes offset of the first stat value
> stat descriptions:
>    - 4 bytes for the type (for now always zero: uint64_t)
>    - 4 bytes for the flags (for now always zero)
>    - length of name
>    - name
> statistics in 64-bit format
>
> * text:
>
> stat1_name uint64 123
> stat2_name uint64 456
> ...
>
> What do you think?
>
> Paolo
>
