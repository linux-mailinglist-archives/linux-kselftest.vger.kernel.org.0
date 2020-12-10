Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D1C2D6C18
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 01:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394399AbgLJXnw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 18:43:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:59820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394389AbgLJXnZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 18:43:25 -0500
X-Gm-Message-State: AOAM530rIwQTuVUyyBeXtb7r3ui/LNHYctlGM7SkMJEjLOWHv7JM+UZz
        KyaxUMoLqSPr6gcWSTpuoxPNNSzphG5gkwRUiFU+7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607643764;
        bh=aDUgcrOjJHp0mQjbB5wZvqYkGsM2qYU6k/VAqT3R+WA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FGp9IaKzuRbglOgmHOQ9u10r1PAKxq7XnvEyrgno+yD7EMzhvrpFCTTmqmM6zr3hL
         70swxxWYHlGhnNeazzooH5aPD5LM2wnNvBmfe3kH0T614BKdOg1Zuf19En9CdY4+Ka
         HHWaSxgfsfQiqh5Kq1ctb+Hd4NJffdgAONG0PJeTxLObSF/iyTMBzodFCJLUk0XYrf
         DeXaHqpaS9NPaIW3KBOzcqy1BuNSo4wTzp6UJIyt6a6FM/P6CVM6ygw82v8VUKYpGm
         /LAg8+uC1r3pgbNrnHTEID8KGqqUph82lhnwwdocKEIn7FJr+YZIY84jIgW6EQ5x5y
         ukAH2EJvj2UIg==
X-Google-Smtp-Source: ABdhPJziwLtAmmpO/LbhskFlxkb1P0wMIysjlNojkf8wrbc3mNp641j73CHEkz/5cnjDHvWhRXkgCyZELNAG2ldvgYw=
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr10897421wmd.49.1607643762611;
 Thu, 10 Dec 2020 15:42:42 -0800 (PST)
MIME-Version: 1.0
References: <87h7ow2j91.fsf@nanos.tec.linutronix.de> <301491B7-DEB6-41ED-B8FD-657B864696CF@amacapital.net>
 <87v9db25me.fsf@nanos.tec.linutronix.de> <CALCETrXeXCvbxAuRuLwWoF3-zvjhzzjj46VZ3RfgUEhb0SeK6A@mail.gmail.com>
 <87lfe71e1z.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87lfe71e1z.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 10 Dec 2020 15:42:30 -0800
X-Gmail-Original-Message-ID: <CALCETrVpW3m45opNRzF-xzuZ6xS90HYo_a74JzACrdj8zutE5w@mail.gmail.com>
Message-ID: <CALCETrVpW3m45opNRzF-xzuZ6xS90HYo_a74JzACrdj8zutE5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Dec 9, 2020, at 2:14 AM, Thomas Gleixner <tglx@linutronix.de> wrote:


>
> But what's more problematic is the basic requirement that time all over
> the place has to be consistent.
>
> On machines which use DISTORTED_REALTIME everything _IS_ consistent
> within the distorted universe they created. It's still inconsistent
> vs. the outside, but that's unsolvable and none of our problems.
>
> TLDR: Do not even think about opening pandoras box.

This could be a per-machine/per-vm setting that nonetheless uses the
same underlying implementation. There are, sadly, lots of people using
smeared time, and there will probably be VM hosts that simultaneously
have both styles of guest. Supporting full PV time for both would be
nice.  Obviously this gets a bit screwy if they are using a paravirt
fs, but it=E2=80=99s also a problem with NFS, etc. So maybe the nasty corne=
rs
could be narrow enough to just say =E2=80=9Cdon=E2=80=99t do that=E2=80=9D.

>
>> If we want to get fancy, we can make a change that I've contemplated
>> for a while -- we could make t_end explicit and have two copies of all
>> these data structures.  The reader would use one copy if t < t_change
>> and a different copy if t >=3D t_change.
>
> See below.
>
>> This would allow NTP-like code in usermode to schedule a frequency
>> shift to start at a specific time.
>
> That's an orthogonal problem and can be done without changing the
> reader side.

Really?  Right now, the switch happens whenever the kernel takes the
seqlock, which it doesn=E2=80=99t have exact control over. But I meant
something a little different:

>
>> With some care, it would also allow the timekeeping code to update the
>> data structures without causing clock_gettime() to block while the
>> timekeeping code is running on a different CPU.
>
> It still has to block, i.e. retry, because the data set becomes invalid
> when t_end is reached. So the whole thing would be:
>
>       do {
>               seq =3D read_seqcount_latch();
>                data =3D select_data(seq);
>                delta =3D read_clocksource() - data->base;
>                if (delta >=3D data->max_delta)
>                    continue;
>                ....
>      } while (read_seqcount_latch_retry());
>
> TBH, I like the idea for exactly one reason: It increases robustness.

I like the max_delta for robustness, too.

What do you have in mind for select_data()?  Is the idea that
select_data() returns something like &data[seq & 1]?

But I actually meant something a little bit different: you would use
delta >=3D data->max_delta as an indication that you need to look at the
other copy.  Perhaps the lower three bits of the seqcount would work
like:

00: both copies are valid, but start with the first copy.
10: only the first copy is valid.
01: both copies are valid, but start with the second copy.
11: only the second copy is valid

You'd read it like this (with all the bugs that I surely have fixed);

do {
  seq =3D read_seqcount();
  data =3D &data_array[seq & 1];
  clock =3D read_clocksource();
  delta =3D clock - data->base;
  if (delta->data->max_delta) {
    if (seq & 2)
      continue;
    data =3D &data_array[(seq + 1) & 1];  // <-- the other copy
    delta =3D clock - data->base;
    if (delta >=3D data->max_delta)
      continue;
  }
  ...;
} while (seq =3D=3D read_seqcount());

This has two main benefits.  First, it allows the timekeeping code to
run concurrently with readers, which is nice for tail latency --
readers would only ever need to spin if the timekeeper falls behind,
intentionally disables both copies, or somehow manages to run one
iteration for each reader attempt and livelocks the reader.  The
latter is very unlikely.)  Second, it allows the timekeeping code to
literally schedule an update to occur at a precise clocksource tick,
which seems to be like it could make the timekeeping code simpler and
more robust.

(If the timekeeper wants to simultaneously disable both copies, it
sets one copy's max_delta to zero and uses seq to disable the other
copy.)

--Andy






>
> For X86 we already have the comparison for dealing with TSC < base
> which would be covered by
>
>                if (delta >=3D data->max_delta)
>                    continue;
>
> automatically. Non X86 gains this extra conditional, but I think it's
> worth to pay that price.
>
> It won't solve the VM migration problem on it's own though. You still
> have to be careful about the inner workings of everything related to
> timekeeping itself.
>
>> One other thing that might be worth noting: there's another thread
>> about "vmgenid".  It's plausible that it's worth considering stopping
>> the guest or perhaps interrupting all vCPUs to allow it to take some
>> careful actions on migration for reasons that have nothing to do with
>> timekeeping.
>
> How surprising. Who could have thought about that?
>
> OMG, virtualization seems to have gone off into a virtual reality long
> ago.
>
> Thanks,
>
>        tglx
>
