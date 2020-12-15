Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E072DB68F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Dec 2020 23:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgLOWfi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Dec 2020 17:35:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35416 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgLOWfc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Dec 2020 17:35:32 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608071687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AodAqwSxT8qVb0KNVb01jp7kOxVR15QYTpc+MfSTHL8=;
        b=nk8VxAGN4PWz+BZskR1A7Ox9M88LfWpTvQWvEPGbIR3e9QpAkHchvLHzTskPnzzCRwPm7J
        VSKPwzdwmkABT8U6CFK18RmwXjRPIRS+FK8Wvqb0tmzRjU+cGXOoUdSRPUqEztcrFRsMHK
        yOvLBc+okyF+4Lm6Shyr04IBSmLzrLU4KAi3v6xYNYG1TUOv+zutwS8xDLSgz8+d/Pfl3S
        VEalFA2RgvrGIa1gYOqMREPl6f+bPfOfAQOGCd5Y+b90FjfoMVNijAFIUE6QdmDodiG9QE
        KSN7/xLQEOsXElnUhWGZFzVxCbpHtyBVqzMKmHXpmkF1QY6QUuJ9SDEioNOMfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608071687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AodAqwSxT8qVb0KNVb01jp7kOxVR15QYTpc+MfSTHL8=;
        b=1rEbFhcEjnOMCATHobfWvWljuRdE7JwGMfjuCVGsmjXXD7enxnAJLHm2POzi+c7JPQLhM+
        mpYzmpNZp1Ti6LDg==
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
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
In-Reply-To: <20201215105927.GA3321@fuller.cnet>
References: <875z5c2db8.fsf@nanos.tec.linutronix.de> <20201209163434.GA22851@fuller.cnet> <87r1nyzogg.fsf@nanos.tec.linutronix.de> <20201210152618.GB23951@fuller.cnet> <87zh2lib8l.fsf@nanos.tec.linutronix.de> <20201211002703.GA47016@fuller.cnet> <87v9d8h3lx.fsf@nanos.tec.linutronix.de> <20201211141822.GA67764@fuller.cnet> <87k0togikr.fsf@nanos.tec.linutronix.de> <d9063c37-a965-d5cf-e923-c0c9f6ddc044@redhat.com> <20201215105927.GA3321@fuller.cnet>
Date:   Tue, 15 Dec 2020 23:34:46 +0100
Message-ID: <877dpiu29l.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 15 2020 at 07:59, Marcelo Tosatti wrote:
> On Fri, Dec 11, 2020 at 10:59:59PM +0100, Paolo Bonzini wrote:
>> So it's still true that the time advances during live migration brownout;
>> 0.1 seconds is just the final part of the live migration process.  But for
>> _live_ migration there is no need to design things according to "people are
>> happy if their clock is off by 0.1 seconds only".  
>
> Agree. What would be a good way to fix this?

None of what's proposed is fixing the underlying problem of wreckaging
CLOCK_REALTIME.

Stop proliferating broken behaviour and please answer the questions I
asked several times now:

   1) Why has the TSC has to restart at the same value?

   2) What is the technical argument that it is correct and acceptable
      to wreckage CLOCK_REALTIME by doing #1?

Thanks,

        tglx


