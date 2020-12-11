Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7BC2D8062
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 22:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394740AbgLKVFw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Dec 2020 16:05:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37518 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392579AbgLKVFl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Dec 2020 16:05:41 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607720693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0fiMhIgezjMm4j4B451ig1YSH6sP5DgP4ssfWySwTGs=;
        b=AQYRNJvcxXd/HlimRdNjo1jnET0BBogqtVB+Ri+UcW9mLEHO290gRs/+90RaLXritQJb2i
        CODTbdo6SmBCi63OMkXnOeeSd6Ws1yDR9yzDddkR8t/LP9l/LrQ4eZdQbDRveb3SSL5aKZ
        066p2LnvLEsWNLyOe8sbOqVESUlrFFr5ku8/BNydTbz3w03wsxadl/EE4B/8tC8lNDQK8y
        8i8H3Q+qOVu9x95DBC9Gp2kUoNiFFchFz9UsxlV2K2vCIzKWSIQWz0MPjea6aJzZGUP4Aj
        gtoARwkvi5g5dT/9gWudhqt23Y5P6qjwjW5+42mKJkZUDRZGfzljBwounMc6XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607720693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0fiMhIgezjMm4j4B451ig1YSH6sP5DgP4ssfWySwTGs=;
        b=7iQ5hCbTFwAguKL6g6/ZBi2aTwaGL2TT/9TwwH+bT3LyWirf3PdhADoyPYz5c4Tpsay7uw
        r0JJjUFQ04wBM6AA==
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
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
In-Reply-To: <20201211141822.GA67764@fuller.cnet>
References: <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com> <87sg8g2sn4.fsf@nanos.tec.linutronix.de> <20201208181107.GA31442@fuller.cnet> <875z5c2db8.fsf@nanos.tec.linutronix.de> <20201209163434.GA22851@fuller.cnet> <87r1nyzogg.fsf@nanos.tec.linutronix.de> <20201210152618.GB23951@fuller.cnet> <87zh2lib8l.fsf@nanos.tec.linutronix.de> <20201211002703.GA47016@fuller.cnet> <87v9d8h3lx.fsf@nanos.tec.linutronix.de> <20201211141822.GA67764@fuller.cnet>
Date:   Fri, 11 Dec 2020 22:04:52 +0100
Message-ID: <87k0togikr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 11 2020 at 11:18, Marcelo Tosatti wrote:
> On Fri, Dec 11, 2020 at 02:30:34PM +0100, Thomas Gleixner wrote:
> Unless you notify applications to invalidate their time reads,
> i can't see a way to fix this.

This is just wrong. Suspend/resume handles that fine and the system is
guaranteed to come back with time which is very close to the reality.

And for suspend/resume everything from kernel to userspace can have a
notification before suspend and post resume. So applications or those
parts of the kernel which are e.g. time sensitive can prepare upfront
for the disruption and mop up on resume.

> Therefore if you use VM migration in the first place, a certain amount of
> timestamp accuracy error must be tolerated.

That's just because it was never designed in the right way. And you
simply declared that all applications have to deal with that.

Again, where is this documented? VMs are subject to migration whether
the customer who pays for it wants it or not. None of the virt tool docs
mentions that pausing a VM for a long time makes timekeeping go
south.

I still have no sensible explanation WHY time should not advance accross
a migration. All you told me is that customers complained. Which
customers? The ones running the hosts or the ones paying for the VM?

It's all just decided by some folks to "fix" a problem with the pause/
migration mechanism they designed instead of fixing the design fail.

>> How can you even assume that this is correct?
>
> As noted above, even without a window of unsynchronized time (due to
> delay for NTP to sync time), time reads can be stale.

So with suspend/resume we have:

app:
   t = clock_gettime()
        <---------------- tsuspend
        <-----------------tresume
        So t is now behind reality by tresume - tsuspend

  packet -> check timestamp .... ooops recheck
  t = clock_gettime()
  and t and timestamp are in the same ballpark again

Now with your thing:

app:
   t = clock_gettime()
        <---------------- tpause
        <-----------------tresume
        So t is now behind reality by tresume - tpause

  packet -> check timestamp .... ooops recheck
  t = clock_gettime()
  and t and timestamp are still apart by ~ (tresume - tpause)

this persists until NTP kicks in, if and only if NTP is running.

Can you spot the difference?

>> It is exactly the same problem as we had many years ago with hardware
>> clocks suddenly stopping to tick which caused quite some stuff to go
>> belly up.
>
> Customers complained when it was 5 seconds off, now its 0.1ms (and
> people seem happy).

And because customers complained you decided to create a scenario which
is completely different to all other scenarios and from a time keeping
POV not making any sense at all.

>> In a proper suspend/resume scenario CLOCK_REALTIME/TAI are advanced
>> (with a certain degree of accuracy) to compensate for the sleep time, so
>> the other end of a communication is at least in the same ballpark, but
>> not 50 seconds off.
>
> Its 100ms off with migration, and can be reduced further (customers
> complained about 5 seconds but seem happy with 0.1ms).

What is 100ms? Guaranteed maximum migration time?

CLOCK_REALTIME and CLOCK_TAI are off by the time the VM is paused and
this state persists up to the point where NTP corrects it with a time
jump.

So if migration takes 5 seconds then CLOCK_REALTIME is not off by 100ms
it's off by 5 seconds.

CLOCK_MONOTONIC/BOOTTIME might be off by 100ms between pause and resume.

> OK, makes sense, then reducing the 0.1ms window even further
> is a useful thing to do. What would be an acceptable 
> CLOCK_REALTIME accuracy error, on migration?

Can you please explain how you can achive 0.1ms accuracy when migration
time is more than that and guest TSC is just restored to the value at
which it was stopped?

Then ALL clocks including CLOCK_REALTIME and CLOCK_TAI continue from the
point at which they were stopped. Ergo:

      t(CLOCK_REALTIME) = t(REALITY) - t(STOPPED)

CLOCK_REALTIME and CLOCK_TAI are global clocks and they have rules which
have to be respected in order to make stuff work.

CLOCK_MONOTONIC and CLOCK_BOOTTIME are local to a system (host, guests).
So manipulating them is a completely different story albeit the kernel
has explicit guarantees for the relationship between CLOCK_MONOTONIC,
CLOCK_BOOTTIME and CLOCK_REALTIME/TAI

If you could guarantee t(STOPPED) < 100ms and therefore

   t(REALITY) - t(CLOCK_REALTIME) < 100ms

under _all_ circumstances then we would not even have that discussion.

Even < 1000ms might be acceptable. That's the margin of error which is
also happening accross bare metal suspend/resume in the case that the
sleep time has to be read from the RTC when TSC stops accross suspend.

But suspend/resume is still substantially different because everything
from kernel to userspace can have a notification before suspend. So
applications or those parts of the kernel which are e.g. time sensitive
can prepare upfront for the disruption. In your case, not at all. They
just have to cope with the fallout. Brilliant.

Your design or the lack of it just decides that everything has to cope
with what you decided is the right thing to do and for how long it
takes.

Yes it "works" by some definition of works, but that does not mean it
works correctly.

Thanks,

        tglx
