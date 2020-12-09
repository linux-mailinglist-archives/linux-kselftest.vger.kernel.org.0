Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EC82D3972
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Dec 2020 05:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgLIEJu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 23:09:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgLIEJu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 23:09:50 -0500
X-Gm-Message-State: AOAM533tPoe5vnmamSoL7++ufs1GFCzAbhkyDDDlHvymJc+aXUaBoQFW
        58UeEc8flkmn3Q/MP/KQPwDbIp5rrZrLnYSytEMyeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607486949;
        bh=oYWxHXQ62C0mJPCCULJOFjbEn8mPiFRGhNAfsRwo+mY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gZUlSCsh09rf2zhL5Bh0chn4eXVlp7Awkzq0RldKYyb9pnGpVpj4rBL3vKOYRzg9f
         bVt7+1tmu2vRnb8/dV+EAWWnGnSVHs7erF15Vl/9Vm7eyf/+uhC1xAAqVN9D+Q8ebR
         yswYQwBqFuj2KX+FHAsKN9Wr7ORUdO/IsQwJLozT3EIqveFEX27nuo3N3ophCC0hHw
         nPYh+hlRw4oJkZhUUeOIczvCbP8t5c2a3wwnzFq4972o382rIKInykpxPejxpn5ZbK
         4RK+Ddim/dJzBLZLje0OdZ0mfm6hOw8p0O2GwaANO1d/7jX4/MrFz93HeSqY7m70u7
         K+9+PPDq36H/g==
X-Google-Smtp-Source: ABdhPJyPreMEtl1P7lQQQDkaaodeKWAa7yzPM9UvV4cRoYUa/4FCUz55VfV8kjpchfi0VRMnuLRmsm2k3UBpYxyIZ1k=
X-Received: by 2002:a5d:4a10:: with SMTP id m16mr403401wrq.18.1607486947915;
 Tue, 08 Dec 2020 20:09:07 -0800 (PST)
MIME-Version: 1.0
References: <87h7ow2j91.fsf@nanos.tec.linutronix.de> <301491B7-DEB6-41ED-B8FD-657B864696CF@amacapital.net>
 <87v9db25me.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87v9db25me.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 8 Dec 2020 20:08:56 -0800
X-Gmail-Original-Message-ID: <CALCETrXeXCvbxAuRuLwWoF3-zvjhzzjj46VZ3RfgUEhb0SeK6A@mail.gmail.com>
Message-ID: <CALCETrXeXCvbxAuRuLwWoF3-zvjhzzjj46VZ3RfgUEhb0SeK6A@mail.gmail.com>
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

On Tue, Dec 8, 2020 at 4:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Dec 08 2020 at 12:32, Andy Lutomirski wrote:
> >> On Dec 8, 2020, at 11:25 AM, Thomas Gleixner <tglx@linutronix.de> wrot=
e:
> >> One issue here is that guests might want to run their own NTP/PTP. One
> >> reason to do that is that some people prefer the leap second smearing
> >> NTP servers.
> >
> > I would hope that using this part would be optional on the guest=E2=80=
=99s
> > part. Guests should be able to use just the CLOCK_MONOTONIC_RAW part
> > or fancier stuff at their option.
> >
> > (Hmm, it would, in principle, be possible for a guest to use the
> > host=E2=80=99s TAI but still smear leap seconds. Even without virt, sme=
aring
> > could be a per-timens option.)
>
> No. Don't even think about it. Read the thread:
>
>   https://lore.kernel.org/r/20201030110229.43f0773b@jawa
>
> all the way through the end and then come up with a real proposal which
> solves all of the issues mentioned there.

You're misunderstanding me, which is entirely reasonable, since my
description was crap.  In particular, what I meant by smearing is not
at all what's done today.  Let me try again.  The thing below is my
proposal, not necessarily a description of exactly what happens now.

(I read most of that thread, and I read most of this thread, and I've
hacked on the time code, cursed at the KVM code, modified the KVM
code, cursed at the KVM code some more, etc.  None of which is to say
that I have a full understanding of every possible timekeeping nuance,
but I'm pretty sure I can at least pretend to understand some of it.)

We have some time source that we can read (e.g. TSC).  Let's call it
read_time().  It returns an integer (64-bits would be nice, but we'll
take what we can get).  From the output of read_time(), Linux user
programs, and the kernel itself (and guests perhaps, see below) would
like to produce various outputs.  Each of them is protected by a
seqlock that I'll omit in the descriptions below.  The operations
below are all protected by a seqlock retry loop.  Also, when I say *
below, I mean the usual calculation with a multiplication and a shift.

All of these are only valid if t_start <=3D read_time() <=3D t_end and,
and they all assume that read_time() hasn't wrapped and gotten into
that interval again.  There is nothing at all we can do in software if
we wrap like this.  t_end isn't necessarily something we compute
explicitly --- it might just be the case that, if read_time() > t_end,
our arithmetic overflows and we return garbage.  But t_end might be a
real thing on architectures where vdso_cycles_ok() actually does
something (sigh, x86).

CLOCK_MONOTONIC_RAW: not affected by NTP, adjtimex, etc.
return mult[monotonic_raw] * (read_time() - t_start) + offset[monotonic_raw=
];

CLOCK_MONOTONIC:  This is never affected by leap-second smearing.  If
userspace tries to smear it in the new mode, userspace gets to keep
all the pieces.
return mult[monotonic] * (read_time() - t_start) + offset[monotonic];

CLOCK_TAI:  This is not smeared.
return mult[tai] * (read_time() - t_start) + offset[tai];

CLOCK_SANE_REALTIME: This is not smeared either.
return mult[sane_realtime] * (read_time() - t_start) + offset[sane_realtime=
];

And yes, we require that mult[monotonic] =3D=3D mult[tai] =3D=3D mult[sane_=
realtime].

CLOCK_SMEARED_REALTIME:
return mult[smeared_realtime] * (read_time() - t_start) +
offset[smeared_realtime]
This is a leap-second-smeared variant of CLOCK_SANE_REALTIME.

CLOCK_REALTIME: maps to CLOCK_SANE_REALTIME or CLOCK_SMEARED_REALTIME
depending on user preference.  Doing this without an extra branch
somewhere might take a bit of thought.

If t > t_end, then we fall back to a syscall if we're in user mode and
we fall back to hypercall or we just spin if we're in the kernel.  But
see below.

As far as I can tell, if the kernel were to do something utterly
asinine like adding some arbitrary value to TSC_ADJUST on all CPUs,
the kernel could do so correctly by taking the seqlock, making the
change, updating everything, and releasing the seqlock.  This would be
nuts, but it's more or less the same thing that happens when a VM
migrates.  So I think a VM could migrate a guest without any
particular magic, except that there's a potential race if the old and
new systems happen to have close enough seqlock values that the guest
might start reading on the old host, finish on the new host, see the
same seqlock value, and end up with utter garbage.  One way to
mitigate this would be, in paravirt mode, to have an extra per-guest
page that contains a count of how many times the guest has migrated.

Timens would work a lot like it does today, but the mechanism that
tells the vdso code to use timens might need tweaking.

I could easily be missing something that prevents this from working,
but I'm not seeing any fundamental problems.

If we want to get fancy, we can make a change that I've contemplated
for a while -- we could make t_end explicit and have two copies of all
these data structures.  The reader would use one copy if t < t_change
and a different copy if t >=3D t_change.  This would allow NTP-like code
in usermode to schedule a frequency shift to start at a specific time.
With some care, it would also allow the timekeeping code to update the
data structures without causing clock_gettime() to block while the
timekeeping code is running on a different CPU.

One other thing that might be worth noting: there's another thread
about "vmgenid".  It's plausible that it's worth considering stopping
the guest or perhaps interrupting all vCPUs to allow it to take some
careful actions on migration for reasons that have nothing to do with
timekeeping.
