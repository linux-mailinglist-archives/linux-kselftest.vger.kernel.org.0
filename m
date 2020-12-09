Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C472D3FB7
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Dec 2020 11:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgLIKPc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Dec 2020 05:15:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44990 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgLIKPc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Dec 2020 05:15:32 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607508889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G7zJ9/cQdln9yZDKFiAc3/8AMDkZ6a+11QkBdXTHQbU=;
        b=t0Nx/aJmMYdTYtM8z1EdPXRWes0648Uz0Ey4k7Fd45HnLY2nqUsIpCTL3z+YnbnKBYdgHv
        0hhVz4zzPw1vZk4MV1l9LBtedGA0obCsmKj0l/2SAYV1lLvum6pH2eAOKbInW/rqAsNmk8
        oGwV8LCJNOsHex345aPn5k8aoI3YEYDpgZVN+63+aQf/jCtEHxDob+uO57fYdhfP9XvtOU
        CQN+9UjDKWX/+/ZcVypoiv71Mq0PM/Uvr39eO+JRsYOAz5I0KKUtaWw/A3nO5VOTIr65H7
        ZBQq6PQXo9OpENbrelSZkdkxburQ1VSJ24wWfwd6jt5iJZlznovj6Ccv2GwrVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607508889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G7zJ9/cQdln9yZDKFiAc3/8AMDkZ6a+11QkBdXTHQbU=;
        b=oxalrgPh8GBDj3l7TIx+Vk1rhEGDqMYVTQjeyLm9SWe8jYmLbL0ProS/4FpF/tn2h5942f
        C8E5x3vZ/lDKbXCA==
To:     Andy Lutomirski <luto@kernel.org>
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
In-Reply-To: <CALCETrXeXCvbxAuRuLwWoF3-zvjhzzjj46VZ3RfgUEhb0SeK6A@mail.gmail.com>
References: <87h7ow2j91.fsf@nanos.tec.linutronix.de> <301491B7-DEB6-41ED-B8FD-657B864696CF@amacapital.net> <87v9db25me.fsf@nanos.tec.linutronix.de> <CALCETrXeXCvbxAuRuLwWoF3-zvjhzzjj46VZ3RfgUEhb0SeK6A@mail.gmail.com>
Date:   Wed, 09 Dec 2020 11:14:48 +0100
Message-ID: <87lfe71e1z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Andy,

On Tue, Dec 08 2020 at 20:08, Andy Lutomirski wrote:
> On Tue, Dec 8, 2020 at 4:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Tue, Dec 08 2020 at 12:32, Andy Lutomirski wrote:
>> all the way through the end and then come up with a real proposal which
>> solves all of the issues mentioned there.
>
> You're misunderstanding me, which is entirely reasonable, since my
> description was crap.  In particular, what I meant by smearing is not
> at all what's done today.  Let me try again.  The thing below is my
> proposal, not necessarily a description of exactly what happens now.

Fair enough. /me rewinds grump and starts over.

> All of these are only valid if t_start <= read_time() <= t_end and,
> and they all assume that read_time() hasn't wrapped and gotten into
> that interval again.  There is nothing at all we can do in software if
> we wrap like this.  t_end isn't necessarily something we compute
> explicitly --- it might just be the case that, if read_time() > t_end,
> our arithmetic overflows and we return garbage.  But t_end might be a
> real thing on architectures where vdso_cycles_ok() actually does
> something (sigh, x86).
>
> If t > t_end, then we fall back to a syscall if we're in user mode and
> we fall back to hypercall or we just spin if we're in the kernel.  But
> see below.

Yes, we could do that.

> CLOCK_SMEARED_REALTIME:
> return mult[smeared_realtime] * (read_time() - t_start) +
> offset[smeared_realtime]
> This is a leap-second-smeared variant of CLOCK_SANE_REALTIME.
>
> CLOCK_REALTIME: maps to CLOCK_SANE_REALTIME or CLOCK_SMEARED_REALTIME
> depending on user preference.  Doing this without an extra branch
> somewhere might take a bit of thought.

Plus adding support for clock_*(CLOCK_DISTORTED_TIME) and make that work
correctly. Plus dealing with all the other interesting problems vs. file
time stamps and whatever. Time is all over the place and not just in
clock_gettime(CLOCK*).

But what's more problematic is the basic requirement that time all over
the place has to be consistent.

On machines which use DISTORTED_REALTIME everything _IS_ consistent
within the distorted universe they created. It's still inconsistent
vs. the outside, but that's unsolvable and none of our problems.

TLDR: Do not even think about opening pandoras box.

> As far as I can tell, if the kernel were to do something utterly
> asinine like adding some arbitrary value to TSC_ADJUST on all CPUs,
> the kernel could do so correctly by taking the seqlock, making the
> change, updating everything, and releasing the seqlock.

Plus a few other things, but yes that's similar to the scheme I
outlined. Using stomp_machine() ensures that _all_ possible ways to
wreckage things are covered.

> This would be nuts, but it's more or less the same thing that happens
> when a VM migrates.  So I think a VM could migrate a guest without any
> particular magic, except that there's a potential race if the old and
> new systems happen to have close enough seqlock values that the guest
> might start reading on the old host, finish on the new host, see the
> same seqlock value, and end up with utter garbage.  One way to
> mitigate this would be, in paravirt mode, to have an extra per-guest
> page that contains a count of how many times the guest has migrated.
>
> Timens would work a lot like it does today, but the mechanism that
> tells the vdso code to use timens might need tweaking.
>
> I could easily be missing something that prevents this from working,
> but I'm not seeing any fundamental problems.

It can be made work.

> If we want to get fancy, we can make a change that I've contemplated
> for a while -- we could make t_end explicit and have two copies of all
> these data structures.  The reader would use one copy if t < t_change
> and a different copy if t >= t_change.

See below.

> This would allow NTP-like code in usermode to schedule a frequency
> shift to start at a specific time.

That's an orthogonal problem and can be done without changing the
reader side.

> With some care, it would also allow the timekeeping code to update the
> data structures without causing clock_gettime() to block while the
> timekeeping code is running on a different CPU.

It still has to block, i.e. retry, because the data set becomes invalid
when t_end is reached. So the whole thing would be:

       do {
       		seq = read_seqcount_latch();
                data = select_data(seq);
                delta = read_clocksource() - data->base;
                if (delta >= data->max_delta)
                	continue;
                ....
      } while (read_seqcount_latch_retry());

TBH, I like the idea for exactly one reason: It increases robustness.

For X86 we already have the comparison for dealing with TSC < base
which would be covered by

                if (delta >= data->max_delta)
                	continue;

automatically. Non X86 gains this extra conditional, but I think it's
worth to pay that price.

It won't solve the VM migration problem on it's own though. You still
have to be careful about the inner workings of everything related to
timekeeping itself.

> One other thing that might be worth noting: there's another thread
> about "vmgenid".  It's plausible that it's worth considering stopping
> the guest or perhaps interrupting all vCPUs to allow it to take some
> careful actions on migration for reasons that have nothing to do with
> timekeeping.

How surprising. Who could have thought about that?

OMG, virtualization seems to have gone off into a virtual reality long
ago.

Thanks,

        tglx

