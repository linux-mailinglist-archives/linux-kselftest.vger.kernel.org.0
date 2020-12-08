Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2585D2D351F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 22:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgLHVVf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 16:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgLHVVf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 16:21:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514E9C0613CF;
        Tue,  8 Dec 2020 13:20:55 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607462453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3mKMgeVNoXnCbOxJY3c2Qk9xN0c/9glFEs7WvwfcFyk=;
        b=BTSfQCoOvgPTEWGzfAZFUu6pNPO6SALgqYR+oiYjcgZh9h8p4vtuC4xA3zE/XXnjOz6fOL
        za8Umn43pevJ0mgjQ6EEx17DsqzB3ujb0tanXigm5/SJ+B0vxnkJnczdUCF2plX9iAUnX9
        McOOIRswZUPN2JPf2RxzSEu6KTt60AQbEk1nUaKOvs5S0RV+WirbY3pSGHbyPmbP0a9Hbb
        0UDi7yfaspBcgv1U2lRR3d8rSvurkdNKdjDSMvDPdx2UFluJowy1PSQZWENFx1dm5SYCuH
        JmDucT7JOlIjQdUn+mW5RxFS75ah+95Kt0+EMexRUft40QJ8QzhyXI2Vq+xUSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607462453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3mKMgeVNoXnCbOxJY3c2Qk9xN0c/9glFEs7WvwfcFyk=;
        b=9sFzMxntmhFfsRJ92ruQeL0ohbVzXVxQx/Gc6HYbxFVHhl/djmTCPFlUhcSRUR2n+IWtOz
        doj5IYXZzw/S5aDw==
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     kvm@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
In-Reply-To: <6f64558a029574444da417754786f711c2fec407.camel@redhat.com>
References: <20201203171118.372391-1-mlevitsk@redhat.com> <20201203171118.372391-2-mlevitsk@redhat.com> <20201207232920.GD27492@fuller.cnet> <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com> <87sg8g2sn4.fsf@nanos.tec.linutronix.de> <6f64558a029574444da417754786f711c2fec407.camel@redhat.com>
Date:   Tue, 08 Dec 2020 22:20:52 +0100
Message-ID: <87blf42dvv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 08 2020 at 18:25, Maxim Levitsky wrote:
> On Tue, 2020-12-08 at 17:02 +0100, Thomas Gleixner wrote:
>> For one I have no idea which bug you are talking about and if the bug is
>> caused by the VMM then why would you "fix" it in the guest kernel.
>
> The "bug" is that if VMM moves a hardware time counter (tsc or anything else) 
> forward by large enough value in one go, 
> then the guest kernel will supposingly have an overflow in the time code.
> I don't consider this to be a buggy VMM behavior, but rather a kernel
> bug that should be fixed (if this bug actually exists)

Well, that's debatable. The kernel has a safe guard in place for each
clocksource which calculates the maximum time before an update needs to
take place. That limit comes from:

 1) Hardware counter wraparound time
 2) Math limitation

#1 is a non-issue on TSC, but it is on pm-timer, hpet and lots of other
   non-x86 devices

#2 The overflow surely can happen if you're long enough out. For TSC
   it's ~ 800 / f [seconds/GHz TSC frequency], i.e. 200 seconds for a
   4Ghz TSC.

> Purely in theory this can even happen on real hardware if for example
> SMM handler blocks a CPU from running for a long duration, or hardware
> debugging interface does, or some other hardware transparent sleep
> mechanism kicks in and blocks a CPU from running.  (We do handle this
> gracefully for S3/S4)

We had this discussion before. People got upset the stuff didn't work
when they resumed debugging after leaving the box in the breakpoint over
the weekend. *Shrug*

If SMM goes out for lunch for > 200 seconds it's broken. End of story,
really. There are bigger problems than timekeeping when that happens.

Hardware transparent sleep mechanisms which are doing this behind the
kernels back without giving it a mechanism to configure it is pretty
much like SMM: It's broken.

So now life migration comes a long time after timekeeping had set the
limits and just because it's virt it expects that everything works and it
just can ignore these limits.

TBH. That's not any different than SMM or hard/firmware taking the
machine out for lunch. It's exactly the same: It's broken.

And of course since that migration muck started _nobody_ bothered until
today to talk to me about that.

It's not a kernel bug. The kernel works as designed for the purpose and
the design clearly had these goals:

    1) Correctness
    2) Performance
    3) Scalability

and for that we introduced limitations which were perfectly reasonable
at the time because SMM and hardware/firmware wreckage definitely cannot
be the limiting factor and for the fast wrapping stuff there is no
design at all. These limitations are still reasonable because lifting
them hurts performance and depending on the length has effects on
correctness as well. Timekeeping is a complex problem.

It's a virt bug caused by pure ignorance of the underlying and already
existing technology and the unwillingness to talk to people who actually
understand it. I don't even want to know what kind of magic workarounds
VMMs have dreamed up for that. I'm seriously grumpy that more than 10
years after I reported that time can be observed going backwards this is
still not fixed and that has absolutely nothing to do with guest
migration.  Ignoring the simple and trivial requirement for timekeeping
correctness in the first place and then having the chuzpah to claim that
the kernel is buggy because virt decided it can do what it wants is
beyond my comprehension and yet another proof for the theorem that virt
creates more problems than it solves.

</rant>

The question how it can be made work is a different problem. I carefully
said 'made work' because you can't 'fix' it.

  - It can't be fixed at the VMM side at all

  - It can't be fixed for fast wrapping clock sources by just fiddling
    with the timekeeping and time accessor code at all.

  - Even for TSC it can't be just fixed without imposing overhead on
    every time read including VDSO. And just fixing it for x86 and TSC
    does not cut it. There is a whole world outside of x86 and we are
    not going to impose any x86/TSC specific insanity on everybody
    else. We are neither going to make generic code have TSC specific
    hoops and loops just to deal with that.

This needs orchestration and collaboration from both the VMM and the
guest kernel to make this work proper and reliably.

There are two ways to do that:

   1) Suspend / resume the guest kernel

   2) Have a protocol which is safe under all circumstances.

If #2 is not there then #1 is the only correct option unless the VMM can
guarantee that the guest is restarted _before_ time goes south.

Doing #2 correctly is not rocket science either. The kernel has
mechanisms to deal with such problems already. All it requires is to
expose and utilize them.

The only requirement there is to bring the kernel into a state where no
CPU can observe that the time goes backwards. The kernel has two
mechanisms for that:

   1) Suspend / resume. Trivial because all CPUs except the (usually)
      boot CPU are unplugged or in a state which does not matter

   2) Switching clocksources. A runtime operation which is safe and
      correct utilizing stop_machine()

If you really think about it then this migration problem is nothing else
than switching the underlying clocksource. The only difference is that
in case of a regular clocksource switch the previous clocksource is
still accessible up to the point where the switchover happens which is
obviously not the case for VM migration.

But instead of switching the clocksource via stop machine we can just
use the same mechanism to update the current clocksource so that the
time jump does not matter and cannot be observed.

That needs a few things to be done:

VMM:
        - Disable NMI delivery to the guest
        - Inject a magic VMM to guest IPI which starts the operation

Guest:
        - Schedule work from the IPI

        - work handles nested VMs if necessary        
        
        - work invokes stop_machine(update_guest_clocksource, NULL, NULL)

        - When all vCPUs rendevouzed then the one vCPU which actually
          runs update_guest_clocksource() and reports to the VMM via
          hypercall or whatever that it reached the state and spin waits
          on a hyperpage shared between guest and VMM to wait for the
          VMM to signal to proceed.

          At that point it's 100% safe to freeze it. Probably not only
          from a timekeeping POV.

VMM:
        - Freeze VM and send image to destination VMM

New VMM:

        - Install the image

        - Setup the vCPU TSC muck

        - Store necessary information in the hyperpage and then flip the
          bit which makes the guest waiting in update_guest_clocksource()
          proceed.

        - Schedule the guest vCPUs

Guest:

        - The one vCPU waiting in update_guest_clocksource() observes the
          GO bit, updates timekeeping and returns.

        - All CPUs leave stomp_machine() and everything is fine

        - work resumes and handles nested VMs

        - work tells VMM that everything is done

All the bits and pieces are there already except for the VMM/guest
contract and the extra 20 lines of code in the timekeeping core.

There is one caveat vs. the NMI safe time keeper, but we have the
mechanism to deal with that in place already for suspend so that's just
another 5 lines of code to deal with at the core side.

Now you combine this with a proper mechanism to deal with the TSC offset
as I outlined before and your problems are pretty much gone in a very
clean and understandable way.

Thanks,

        tglx





