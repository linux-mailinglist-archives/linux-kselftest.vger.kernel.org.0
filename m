Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894102D6893
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 21:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390094AbgLJUV2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 15:21:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58230 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390123AbgLJUV2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 15:21:28 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607631646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D3gx9tD13PRnQ68uO/rN8uV1XzJuse8JvLydTkrM0tk=;
        b=WrALyDckvkeuNaz+eI3yDgM9uYSMWTyVSVNx6RXFUVljR2IFqs4rRLYbwUTCaqCBcHEcGO
        eEIuOOOJ+WvE2haTJWd38VMUsEbHZK4EdsqTLMHSnoZJ4lYI1UNdqA7IOFCVGLLCz3JPN4
        d7rB4e/IQ8NXDOAfz46Jz2WYWuDTSRdNjb0qKEaECflRKVMQCaXkBwiQzFSSbSI+Y32V2N
        rpFRwWPEZI2d0bMPj+yhue74HKpNzxYf1SYNXeAroAYCa1KfxXFVFPmigjIFds2DfZedam
        OKPFXaDSQDmRJGBsS52xgGXJu9aJbQsrQKoG7g9srYv2cS2H2lgHB4jqA8VLbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607631646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D3gx9tD13PRnQ68uO/rN8uV1XzJuse8JvLydTkrM0tk=;
        b=F7nNySYnHzOdMdxy6HIl8ySMogAvGhi8kpKyKtBfAF0v3BxJPZP0l5Oo3+V/Xw13N/6lE7
        I6WyyeFvL5LWxYCA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
In-Reply-To: <20201210130131.GP2414@hirez.programming.kicks-ass.net>
References: <20201203171118.372391-1-mlevitsk@redhat.com> <20201203171118.372391-2-mlevitsk@redhat.com> <87a6uq9abf.fsf@nanos.tec.linutronix.de> <1dbbeefc7c76c259b55582468ccd3aab35a6de60.camel@redhat.com> <87im9dlpsw.fsf@vitty.brq.redhat.com> <875z5d5x9m.fsf@nanos.tec.linutronix.de> <b6e0656b-4e3f-cf47-5ec9-eead44b2f2e9@redhat.com> <20201210121417.GN2414@hirez.programming.kicks-ass.net> <fe3e4637-b74b-864a-9d2f-c4f2d9450f2e@redhat.com> <20201210130131.GP2414@hirez.programming.kicks-ass.net>
Date:   Thu, 10 Dec 2020 21:20:45 +0100
Message-ID: <87blf1jtuq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10 2020 at 14:01, Peter Zijlstra wrote:
> On Thu, Dec 10, 2020 at 01:22:02PM +0100, Paolo Bonzini wrote:
>> On 10/12/20 13:14, Peter Zijlstra wrote:
>> > On Thu, Dec 10, 2020 at 12:42:36PM +0100, Paolo Bonzini wrote:
>> > > On 07/12/20 18:41, Thomas Gleixner wrote:
>> > > > Right this happens still occasionally, but for quite some time this is
>> > > > 100% firmware sillyness and not a fundamental property of the hardware
>> > > > anymore.
>> > > 
>> > > It's still a fundamental property of old hardware.  Last time I tried to
>> > > kill support for processors earlier than Core 2, I had to revert it. That's
>> > > older than Nehalem.
>> > 
>> > Core2 doesn't use TSC for timekeeping anyway. KVM shouldn't either.
>> 
>> On Core2, KVM guests pass TSC through kvmclock in order to get something
>> usable and not incredibly slow.
>
> Which is incredibly wrong.

Core2 is really not something which should prevent making all of this
correct and robust. That'd be not only wrong, that'd be outright insane.

Thanks,

        tglx
