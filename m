Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60383349F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Mar 2021 22:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhCJVmR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Mar 2021 16:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbhCJVmA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Mar 2021 16:42:00 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD26C061760
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Mar 2021 13:41:59 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p21so36031183lfu.11
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Mar 2021 13:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1aCWly0eHYOBMX2QbB2MVQEtisRq+kLH3ylpaLZI0cc=;
        b=BwXgkRlIC4KTvskQmfIRT1UpL8FUSVcbmMR/10Xjal9SvwnJMSNCtMz4ebGfjZEpwl
         HCKgLGqmaBchqQkax5bvx+rjJAcaO8g0WZ2ZWmXxQ4vS1uLC6HEi952fLlwgPn3Wd4/q
         vqoybvVvV+lDlyFafHyb1AQmj59H1UWu6vilft7PMlZn1CkgPU9esxjzW1aIIW+ywWBj
         Udj5I9gR1kMtWjutL1NRbhChAuUHbUnPbNGqzqbYkjkbI7sy94gi6OuNkgkvUFI0515F
         8abSIYRh9W1om06VP1Y1rY1/9BRsh8VfgJuLmZ+BZIgJ3nbpC1hAYP0ed0rHqB2zazZ5
         +JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1aCWly0eHYOBMX2QbB2MVQEtisRq+kLH3ylpaLZI0cc=;
        b=UDpR45PGVNrZNqCdGpU6EUpGE2q5/3ENEISnq///gbqbKy7A+dbL9JWlfQZWfddnNP
         /IIg8ixJwrA5wXJHKLzkFy9Qs19caoWyr0dpnmZCHyzzwGXD+N/RRdBVsAlgIrhw5n7+
         UCnxEB2xfSnBV+jWrYL0uNWS+MvqkFt7dGcDB0A/IwPAqEqXDtizsnrIu23klglly61A
         P+ex2vBGc1MSb8kdj+S5knr+PuaSX3xuuIlSLXWeOHKNtMVM5CBbt5zKfe7tTYmQeAC1
         VeGwF2RTkVRAAV9tzoGjwZY4J7dXF3j7k7QfElKA/667xzgVYDpXjjaXXjxwVPku2VK2
         RmGg==
X-Gm-Message-State: AOAM532FBL3ar4zvj00gUuSs0Q0SW7KRJ7iXqrICIfqG/TJ1h1x9HuP/
        BmwTxQNTX8EjZb/hSDRvK8H/RB9KE1nvSCR1D7fC7g==
X-Google-Smtp-Source: ABdhPJzddr7Z3ChXsEeTaXJHTGvoL/NEnML3O1DtWcsC2600kv1w2ebi95vsyLg0smm0e43j3ORQP/5lcH5lDtVqU9E=
X-Received: by 2002:a05:6512:32ab:: with SMTP id q11mr306450lfe.106.1615412517738;
 Wed, 10 Mar 2021 13:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20210310003024.2026253-1-jingzhangos@google.com>
 <20210310003024.2026253-4-jingzhangos@google.com> <bb03107c-a413-50da-e228-d338dd471fb3@redhat.com>
In-Reply-To: <bb03107c-a413-50da-e228-d338dd471fb3@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Wed, 10 Mar 2021 15:41:46 -0600
Message-ID: <CAAdAUtjj52+cAhD4KUzAaqrMSJXHD0g=ecQNG-a92Mqn3BCxiQ@mail.gmail.com>
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
Agreed. I am considering returning the length of stats name strings in
the kvm_stats_info structure instead of exporting it as a constant in uapi,
which would put no limit on the length of the stats name strings.
>
> I would prefer a completely different interface, where you have a file
> descriptor that can be created and associated to a vCPU or VM (or even
> to /dev/kvm).  Having a file descriptor is important because the fd can
> be passed to a less-privileged process that takes care of gathering the
> metrics
Separate file descriptor solution is very tempting. We are still considering it
seriously. Our biggest concern is that the metrics gathering/handling process
is not necessary running on the same node as the one file descriptor belongs to.
It scales better to pass metrics data directly than to pass file descriptors.
>
> The result of reading the file descriptor could be either ASCII or
> binary.  IMO the real cost lies in opening and reading a multitude of
> files rather than in the ASCII<->binary conversion.
Agreed.
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
The binary format presented above is very flexible. I understand why it is
organized this way.
In our situation, the metrics data could be pulled periodically as short as
half second. They are used by different kinds of monitors/triggers/alerts.
To enhance efficiency and reduce traffic caused by metrics passing, we
treat all metrics info/data as two kinds. One is immutable information,
which doesn't change in a given system boot. The other is mutable
data (statistics data), which is pulled/transferred periodically at a high
frequency.

>
> Paolo
>

Thanks,
Jing
