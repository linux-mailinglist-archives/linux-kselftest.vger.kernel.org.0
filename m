Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D26E2D338B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 21:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgLHUVM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 15:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgLHUVL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 15:21:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A324C061793;
        Tue,  8 Dec 2020 12:20:31 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607455499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NX+dI+aPvVmZ5UT6T3bLtK8/usUYcfZFeQOezcWF6Rk=;
        b=Sctv5n3ThdqVixQDelXHXC/ev7xo7ehTkhbjfUrC7hycj0+zZ29XXZwuqwwUQWQpWRGg8N
        LBtExKBXpkMXb339lKTamEs/1cp2PoSc8bE+PdPcUJ+SvpyRwR6+Kb+VcNNUXcdHWbKpJ5
        SNgkFlINgd7vcLsxxcNIsMj0ySJ8UqCviWDeLByig7/g+MBrxQ7EHuQswizA0umGsTAmwg
        ap8k3zOTSHcxn1poq/7KQVDAd573qazuVf2u+/+9gXmxjDzBXWAUHHhKtlYCi8Tp0Vhuvi
        W6UlxzS4nAC4b8yil0PkOpg1KCrddZwHeH7rBtWrTOZjlB1/338G9OzDHIbj0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607455499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NX+dI+aPvVmZ5UT6T3bLtK8/usUYcfZFeQOezcWF6Rk=;
        b=wVYWw0bZ7SshnZxg3VzTml/7fZs5zRgfWibCjgLe16SxoTlPTl99hGujbncMlsWgu2+oIV
        K/jrb432XCUI5WCQ==
To:     Andy Lutomirski <luto@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
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
In-Reply-To: <CALCETrX7F3EgshyTfsNZy8R=NzyQNOY6JAULfiuOCxc1Fz8mPQ@mail.gmail.com>
References: <636fecc20b0143128b484f159ff795ff65d05b82.camel@redhat.com> <885C1725-B479-47F6-B08D-A7181637A80A@amacapital.net> <20201207231127.GB27492@fuller.cnet> <CALCETrX7F3EgshyTfsNZy8R=NzyQNOY6JAULfiuOCxc1Fz8mPQ@mail.gmail.com>
Date:   Tue, 08 Dec 2020 20:24:58 +0100
Message-ID: <87h7ow2j91.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 08 2020 at 09:43, Andy Lutomirski wrote:
> On Tue, Dec 8, 2020 at 6:23 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> It looks like it tries to accomplish the right goal, but in a rather
> roundabout way.  The host knows how to convert from TSC to
> CLOCK_REALTIME, and ptp_kvm.c exposes this data to the guest.  But,
> rather than just making the guest use the same CLOCK_REALTIME data as
> the host, ptp_kvm.c seems to expose information to usermode that a
> user daemon could use to attempt (with some degree of error?) to use
> to make the guest kernel track CLOCK_REALTIME.  This seems inefficient
> and dubiously accurate.
>
> My feature request is for this to be fully automatic and completely
> coherent.  I would like for a host user program and a guest user
> program to be able to share memory, run concurrently, and use the
> shared memory to exchange CLOCK_REALTIME values without ever observing
> the clock going backwards.  This ought to be doable.  Ideally the
> result should even be usable for Spanner-style synchronization
> assuming the host clock is good enough.  Also, this whole thing should
> work without needing to periodically wake the guest to remain
> synchronized.  If the guest sleeps for two minutes (full nohz-idle, no
> guest activity at all), the host makes a small REALTIME frequency
> adjustment, and then the guest runs user code that reads
> CLOCK_REALTIME, the guest clock should still be fully synchronized
> with the host.  I don't think that ptp_kvm.c-style synchronization can
> do this.

One issue here is that guests might want to run their own NTP/PTP. One
reason to do that is that some people prefer the leap second smearing
NTP servers. 

> tglx etc, I think that doing this really really nicely might involve
> promoting something like the current vDSO data structures to ABI -- a
> straightforward-ish implementation would be for the KVM host to export
> its vvar clock data to the guest and for the guest to use it, possibly
> with an offset applied.  The offset could work a lot like timens works
> today.

Works nicely if the guest TSC is not scaled. But that means that on
migration the raw TSC usage in the guest is borked because the new host
might have a different TSC frequency.

If you use TSC scaling then the conversion needs to take TSC scaling
into account which needs some thought. And the guest would need to read
the host conversion from 'vdso data' and the scaling from the next page
(per guest) and then still has to support timens. Doable but adds extra
overhead on every time read operation.

If you want to avoid that you are back to the point where you need to
chase all guest data when the host NTP/PTP adjusts the host side.
Chasing and updating all this stuff in the tick was the reason why I was
fighting the idea of clock realtime in namespaces.

Thanks,

        tglx
