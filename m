Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1084C2D769C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 14:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391312AbgLKNb0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Dec 2020 08:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393521AbgLKNbQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Dec 2020 08:31:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3246FC0613CF;
        Fri, 11 Dec 2020 05:30:36 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607693434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vPs+PXjGVHxlOB/Nvchr1edaRAyM1X+O6QVeZcxHz34=;
        b=3MTDNYN7cIuhRhHt2eUJgMlAQzexhjLVGow1jvZps2MmDM1h8FFmjfFTu4VeRqE2HPQx/v
        oLcsvEbjdF3roZDfgWgaEWQ1un6T97YP5Zhjg+S9rveXU0ixrEcZ/jvGtZaG41pdwDL1J5
        chogprmkOqU7XIKuYHBp5YOFPlt9VEUT92lPuvrM+VmQXI9t0iX6d4NOkbPDWTGZ8kQAul
        gsN3VU2Cpa6nO9IbFC1V3YI0zCufWfcGWZw8pvfCkbMIiSFxaz/4SXKygRQdCXnq6raK/t
        k9V2063qDuPcdS7JZ9cDOkfeHQD2HWRc6e4EJyDJL192Yef5R5fJ6ocqk7hoNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607693434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vPs+PXjGVHxlOB/Nvchr1edaRAyM1X+O6QVeZcxHz34=;
        b=um+pwlsgKjHt5srVyxPU5j7MMAhBot9S4ux0OggFrgjXX4Pgs4iBir3DISdYhOj8HUFUdS
        WaaNGcqU/DjnkYDQ==
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
In-Reply-To: <20201211002703.GA47016@fuller.cnet>
References: <20201203171118.372391-2-mlevitsk@redhat.com> <20201207232920.GD27492@fuller.cnet> <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com> <87sg8g2sn4.fsf@nanos.tec.linutronix.de> <20201208181107.GA31442@fuller.cnet> <875z5c2db8.fsf@nanos.tec.linutronix.de> <20201209163434.GA22851@fuller.cnet> <87r1nyzogg.fsf@nanos.tec.linutronix.de> <20201210152618.GB23951@fuller.cnet> <87zh2lib8l.fsf@nanos.tec.linutronix.de> <20201211002703.GA47016@fuller.cnet>
Date:   Fri, 11 Dec 2020 14:30:34 +0100
Message-ID: <87v9d8h3lx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10 2020 at 21:27, Marcelo Tosatti wrote:
> On Thu, Dec 10, 2020 at 10:48:10PM +0100, Thomas Gleixner wrote:
>> You really all live in a seperate universe creating your own rules how
>> things which other people work hard on to get it correct can be screwed
>> over.
>
> 	1. T = read timestamp.
> 	2. migrate (VM stops for a certain period).
> 	3. use timestamp T.

This is exactly the problem. Time stops at pause and continues where it
stopped on resume.

But CLOCK_REALTIME and CLOCK_TAI advanced in reality. So up to the point
where NTP fixes this - if there is NTP at all - the guest CLOCK_REALTIME
and CLOCK_TAI are off by tpause.

Now the application gets a packet from the outside world with a
CLOCK_REALTIME timestamp which is suddenly ahead of the value it reads
from clock_gettime(CLOCK_REALTIME) by tpause. So what is it supposed to
do with that? Make stupid assumptions that the other end screwed up
timekeeping, throw an error that the system it is running on screwed up
timekeeping? And a second later when NTP catched up it gets the next
surprise because the systems CLOCK_REALTIME jumped forward unexpectedly
or if there is no NTP it's confused forever.

How can you even assume that this is correct?

It is exactly the same problem as we had many years ago with hardware
clocks suddenly stopping to tick which caused quite some stuff to go
belly up.

In a proper suspend/resume scenario CLOCK_REALTIME/TAI are advanced
(with a certain degree of accuracy) to compensate for the sleep time, so
the other end of a communication is at least in the same ballpark, but
not 50 seconds off.

>> This features first, correctness later frenzy is insane and it better
>> stops now before you pile even more crap on the existing steaming pile
>> of insanities.
>
> Sure.

I wish that would be true. OS people - you should know that - are
fighting forever with hardware people over feature madness and the
attitude of 'we can fix that in software' which turns often enough out
to be wrong.

Now sadly enough people who suffered from that madness work on
virtualization and instead of trying to avoid the same problem they go
off and make it even worse.

It's the same problem again as with hardware people. Not talking to the
other people _before_ making uninformed assumptions and decisions.

We did it that way because big customer asked for it is not a
justification for inflicting this on everybody else and thereby
violating correctness. Works for me and my big customer is not a proof
of correctness either.

It's another proof that this industry just "works" by chance.

Thanks,

        tglx
