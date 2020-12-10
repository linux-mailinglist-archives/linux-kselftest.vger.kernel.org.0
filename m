Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A122D6AA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 23:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404710AbgLJV0B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 16:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404833AbgLJVZz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 16:25:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335FAC06179C;
        Thu, 10 Dec 2020 13:25:13 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607635509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ajw6S0ecP5JyDk4B2mqzjZj/OHXUcKEye3wFwM30n/w=;
        b=aeDeoP2OMb6W1yTcNPLUJ7wTG3iLhIrafwxO3scwUbegxx08gBtU4kPrN4ODASzLSPXzwQ
        XobemNt/pYeltS25uDGXmbV3GcNLJ0Px9AqcUqfHH9QjmKdlsMu9C2KveBrh8D6WLyVQin
        HMwpE3Yd6Zsit+r9vYhdDGbiSRY/VqrX00NDXloesms1kq2YZxcq4M6oMkQAzowXMOz4Lc
        gkQyx3nDfFA0NkzkwNhdTPK+ycLYpQnNY8iS+jxO4gYkKH6ssnTImlyf2MKMIwDekl521L
        mwambQN10d9AVw1RmPeaLvQ7xs2Uqtpi9o4yWIC0WB7be6+xSSdTYp2ro5V6UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607635509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ajw6S0ecP5JyDk4B2mqzjZj/OHXUcKEye3wFwM30n/w=;
        b=h9cVxZlo/qnGFMbdP7Cl4Ja1S4XsFkUxh4B0G8WAAbAbstUjgxp3XvbTLJFjBbC8sux1U7
        p4gLQNs44O7wRGBg==
To:     Andy Lutomirski <luto@amacapital.net>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
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
In-Reply-To: <E4F263BE-6CAA-4152-8818-187D34D8D0FD@amacapital.net>
References: <9389c1198da174bcc9483d6ebf535405aa8bdb45.camel@redhat.com> <E4F263BE-6CAA-4152-8818-187D34D8D0FD@amacapital.net>
Date:   Thu, 10 Dec 2020 22:25:09 +0100
Message-ID: <87360djqve.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Andy,

On Thu, Dec 10 2020 at 07:16, Andy Lutomirski wrote:
>> On Dec 10, 2020, at 6:52 AM, Maxim Levitsky <mlevitsk@redhat.com> wrote:
>> =EF=BB=BFOn Thu, 2020-12-10 at 12:48 +0100, Paolo Bonzini wrote:
>>>> On 08/12/20 22:20, Thomas Gleixner wrote:
>>>> So now life migration comes a long time after timekeeping had set the
>>>> limits and just because it's virt it expects that everything works and=
 it
>>>> just can ignore these limits.
>>>>=20
>>>> TBH. That's not any different than SMM or hard/firmware taking the
>>>> machine out for lunch. It's exactly the same: It's broken.
>>>=20
>>> I agree.  If *live* migration stops the VM for 200 seconds, it's broken.

I'm glad we are on the same page here.

>>> Sure, there's the case of snapshotting the VM over the weekend.  My=20
>>> favorite solution would be to just put it in S3 before doing that.  *Do=
=20
>>> what bare metal does* and you can't go that wrong.

:)

>> Note though that qemu has a couple of issues with s3, and it is disabled=
=20
>> by default in libvirt.=20
>> I would be very happy to work on improving this if there is a need for t=
hat.
>
> There=E2=80=99s also the case where someone has a VM running on a laptop =
and
> someone closes the lid. The host QEMU might not have a chance to
> convince the guest to enter S3.

But the host kernel can do something sensible before going off into lala
land. It knows that it is about to do that and it knows that there are
guests running.

>> I still think though that we should have a discussion on feasibility
>> of making the kernel time code deal with large *forward* tsc jumps=20
>> without crashing.

I'm not opposed against that as I said before.
=20
>> If that is indeed hard to do, or will cause performance issues,
>> then I agree that we might indeed inform the guest of time jumps instead.
>>=20
>
> Tglx, even without fancy shared host/guest timekeeping, count the
> guest kernel manage to update its timekeeping if the host sent the
> guest an interrupt or NMI on all CPUs synchronously on resume?

Tell it before it takes a nap is simpler and does not require an NMI
which is horrible anyway because we can't do much in the NMI and
scheduling irq_work from NMI does not help either because the guest
could be in the middle of ... timekeeping. See below.

> Alternatively, if we had the explicit =E2=80=9Cmax TSC value that makes s=
ense
> right now=E2=80=9D in the timekeeping data, the guest would reliably noti=
ce
> the large jump and could at least do something intelligent about it
> instead of overflowing its internal calculation.

Yes. We can do that and we should do that for robustness sake.

But, there is more than the robustness problem on the reader side, which
is trivial as we discussed in the other part of this thread already.

There is also the problem on the timekeeping core in various aspects
which need a very close look.

So there are various things to solve:

   1) Readerside delta limit

      Trivial to provide and trivial to implement for the VDSO because
      the VDSO just can loop forever.

      Not so trivial for kernel side usage due to the fact that being
      caught in a read can prevent timekeeping from being updated.

      Hint: NOHZ entry path. That would simply livelock and never reach
      the timekeeping code. Also any interrupt disabled region can cause
      that.

      I looked into using 128 bit math as well, but that only works for
      wide clock sources like TSC and needs to be conditional on 64bit
      as 32bit would really suffer badly in the hotpath and even on
      64bit it's measurable.

      So we could keep 64bit math, use the limit and if the delta is
      larger than the limit take a slowpath which does wider math.

      But that still needs thoughts about clocksources with smaller
      counterwidth and therefore a fast wraparound time.

      There is another issue with larger deltas. The extrapolation might
      be off and then cause other side effects like observable time
      going backwards etc.

      That has to be analyzed together with the writer side because
      that's where we need to ensure the continuity/monotonicity etc.

   2) Writer side issues

      The core timekeeping code is pretty robust against large deltas
      already, but there are some limitations nevertheless and it was
      obviously not designed to be taken out in the middle of the
      updates. Haven't wrapped my head around that yet.

      But there is more than the timekeeper update, there are other
      things like NTP, PTP and consumers of the more raw timekeeping
      internals which might get surprised by large deltas and run into
      similar problems because they were not designed to deal with that.

So yes, it can and should be done, but it's not a project for friday
afternoon and it's going to be hard to backport. I know that distro
people do not care because another 500 patches on their frankenkernels
are just noise, but it leaves everybody else out in the dark and I have
zero interest to proliferate that.

I'm still convinced that a notification about 'we take a nap' will be
more robust, less complex and more trivial to backport.

Both life migration and suspend on the host know it upfront which means
that not using this knowledge and instead of that trying to cure the
symptom is violating the basic engineering principles and TBH outright
stupid.

As I said before we have most of the bits and pieces in place and I'm
sure we can come up with an even simpler solution as the one I outlined
before and once that is solved (or in parallel) make the time keeping
more robust.=20

Thanks,

        tglx
