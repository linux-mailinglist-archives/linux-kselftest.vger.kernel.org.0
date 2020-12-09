Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C832D3781
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Dec 2020 01:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgLIAUG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 19:20:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42222 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgLIAUG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 19:20:06 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607473161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dB3FaQD65hJ9XsSWC9J+0ud8HQXWI4+epYGVfEmS9H0=;
        b=V70Fs8VHpdHaRMIyCVrUXQNCNrkqfhkzcKfqEoh61XUC4Fhf2A4Sj0dhUK1/C4j94E5474
        xG/0j3cA7DZdCD7xYUM2jnYkmAglgjMhapmWV+gOuuy/lCLUJR74vF/n/9Hfj2uHO9B7WE
        LutmVb2TbnDAlLRB0nVwqjbIyMmFpZ7sDoZkWIlPZqh103jjf08rJtP8FQJovWVsR3OHBo
        T5lZj1fXh/N2Xcin9QLaQI/DrNAgkk1U+yQauHmh/7vQZtRIWQln+xN63H8yKFJbJ7C5oK
        q07sH7/c0D5td5s6x/ooL8xyF8z/18xGN7eq4kslBCRJWmSBfmkKjtmGGGSl2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607473161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dB3FaQD65hJ9XsSWC9J+0ud8HQXWI4+epYGVfEmS9H0=;
        b=5fmzqM5m1ODVJj0sDIioZZSr2M26neNDSyzFEIz19X4vzeBrLp4aZzlcsVpgmTldL6XfGB
        eMcT13Plnp+zdlDQ==
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
In-Reply-To: <301491B7-DEB6-41ED-B8FD-657B864696CF@amacapital.net>
References: <87h7ow2j91.fsf@nanos.tec.linutronix.de> <301491B7-DEB6-41ED-B8FD-657B864696CF@amacapital.net>
Date:   Wed, 09 Dec 2020 01:19:21 +0100
Message-ID: <87v9db25me.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 08 2020 at 12:32, Andy Lutomirski wrote:
>> On Dec 8, 2020, at 11:25 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> One issue here is that guests might want to run their own NTP/PTP. One
>> reason to do that is that some people prefer the leap second smearing
>> NTP servers.=20
>
> I would hope that using this part would be optional on the guest=E2=80=99s
> part. Guests should be able to use just the CLOCK_MONOTONIC_RAW part
> or fancier stuff at their option.
>
> (Hmm, it would, in principle, be possible for a guest to use the
> host=E2=80=99s TAI but still smear leap seconds. Even without virt, smear=
ing
> could be a per-timens option.)

No. Don't even think about it. Read the thread:

  https://lore.kernel.org/r/20201030110229.43f0773b@jawa

all the way through the end and then come up with a real proposal which
solves all of the issues mentioned there.

I might be missing the obvious, but please before you make proposals
about time keeping out of thin air, please do your homework. You would
not ask these questions otherwise.

If it would be that simple we wouldn't be discussing this in the first
place.

Sorry for being blunt, but this has been discussed to death already.

It can be solved on the theory level, but it's not practical.

You _cannot_ make leap second smearing or different notions of clock
realtime an isolated problem. We have

   CLOCK_MONOTONIC
   CLOCK_BOOTTIME
   CLOCK_REALTIME
   CLOCK_TAI

They share one fundamental property:

     All frequency adjustments done by NTP/PTP/PPS or whatever affect
     _ALL_ of them in the exactly same way.

I.e. leap second smearing whether you like it or not is affecting all of
them and there is nothing we can do about that. Why?

 1) Because it's wrong to begin with. It creates a seperate universe of
    CLOCK_REALTIME and therefore of CLOCK_TAI because they are strictly
    coupled by definition.

 2) It's user space ABI. adjtimex() can make the kernel do random
    crap. So if you extend that to time namespaces (which is pretty much
    the same as a guest time space) then you have to solve the following
    problems:

    A) The tick based gradual adjustment of adjtimex() to avoid time
       jumping around have to be done for every time universe which has
       different parameters than the host.

       Arguably this can be solved by having a seqcount based magic hack
       which forces the first time name space consumer into updating the
       per time name space notion of time instead of doing it from the
       host tick, but that requires to have fully synchronized nested
       sequence counts and if you extend this to nested virt it creates
       an exponential problem.

    B) What to do about enforced time jumps on the host (settimeofday,
       adjtimex)?=20

    C) Once you have solved #1 and #2 explain how timers (nanosleep,
       interval timers, ....) which are all user space ABI and have the
       fundamental guarantee to not expire early can be handled in a sane
       and scalable way.

Once you have a coherent answer for all of the above I'm happy to step
down and hand over. In that case I'm more than happy not to have to deal
with the inevitable regression reports.

>>> tglx etc, I think that doing this really really nicely might involve
>>> promoting something like the current vDSO data structures to ABI -- a
>>> straightforward-ish implementation would be for the KVM host to export
>>> its vvar clock data to the guest and for the guest to use it, possibly
>>> with an offset applied.  The offset could work a lot like timens works
>>> today.
>>=20
>> Works nicely if the guest TSC is not scaled. But that means that on
>> migration the raw TSC usage in the guest is borked because the new host
>> might have a different TSC frequency.
>>=20
>> If you use TSC scaling then the conversion needs to take TSC scaling
>> into account which needs some thought. And the guest would need to read
>> the host conversion from 'vdso data' and the scaling from the next page
>> (per guest) and then still has to support timens. Doable but adds extra
>> overhead on every time read operation.
>
> Is the issue that scaling would result in a different guest vs host
> frequency?  Perhaps we could limit each physical machine to exactly
> two modes: unscaled (use TSC ticks, convert in software) and scaled to
> nanoseconds (CLOCK_MONOTONIC_RAW is RDTSC + possible offset).  Then
> the host could produce its data structures in exactly those two
> formats and export them as appropriate.

The latter - nanoseconds scaling - is the only reasonable solution but
then _ALL_ involved hosts must agree on that.

>> If you want to avoid that you are back to the point where you need to
>> chase all guest data when the host NTP/PTP adjusts the host side.
>> Chasing and updating all this stuff in the tick was the reason why I was
>> fighting the idea of clock realtime in namespaces.
>
> I think that, if we can arrange for a small, bounded number of pages
> generated by the host, then this problem isn=E2=80=99t so bad.

Whishful thinking unless we have a very strict contract about

 - scaling to 1 GHz, aka nanoseconds,
 - all guest argree with the host defined management of clock
   REALTIME and TAI

> Hmm, leap second smearing is just a different linear mapping. I=E2=80=99m=
 not
> sure how leap second smearing should interact with timens, but it
> seems to be that the host should be able to produce four data pages
> (scaled vs unscaled and smeared vs unsmeared) and one per-guest/timens
> offset page (where offset applies to MONOTONIC and MONOTONIC_RAW only)
> and cover all bases.  Or do people actually want to offset their TAI
> and/or REALTIME, and what would that even mean if the offset crosses a
> leap second?
>

See above.

And yes people want to run different time universes where TAI !=3D TAI.

> (I haven=E2=80=99t though about the interaction of any of this with ART.)

Obviously not:) And I'm pretty sure that nobody else did, but ART is the
least of my worries so far.

The current VM migration approach is: Get it done no matter what, we
deal with the fallout later. Which means endless tinkering because you
can't fix essential design fails after the fact.

Thanks,

        tglx
