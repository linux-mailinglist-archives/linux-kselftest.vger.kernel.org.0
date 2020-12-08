Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECB42D3554
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 22:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgLHVd6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 16:33:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41428 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgLHVd6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 16:33:58 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607463195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FebrbWILKUR8Hgmz9i1mtULcgETiptdqLPMhWP7EMIU=;
        b=r1xECTHRQcb8hTX5txaTxq9Or8wTghetyMu2X2oy1RwU/RSqubXkPYlGK+vUnkhmp3PmA2
        wkxVTbHYTR4wTOoKC2Ud1x364nHZer7l30pa5ZEOnVdUFJeLE0q9wmOZxnx39ogNwwmCfx
        h35a0HUl66gG2cBpXkkZocb+LA6DeHZ6gBfkvMiB3+8WDM/WpdNql6AQ195ZVxLrirvfHU
        WXni0hEgauv88BfP4zKxL2C2XdXndhbYuk3CMxFHWObPKxeS09E6yJf+tTEEgKLqFnelje
        pr4BkDdM3rGMHgj+/TeFaPwGyE5VdKUkuMh8DP2ffqQrxYFLddFk/6oh9ndSlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607463195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FebrbWILKUR8Hgmz9i1mtULcgETiptdqLPMhWP7EMIU=;
        b=RtPIAb0xy9lmaw4yVIcuXS3FUaGVS+YVt2s2PMAKGKzRb6mr13bqE56dfW4N+aqsnmla2h
        zOS/81es/ovhRqAQ==
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
In-Reply-To: <20201208181107.GA31442@fuller.cnet>
References: <20201203171118.372391-1-mlevitsk@redhat.com> <20201203171118.372391-2-mlevitsk@redhat.com> <20201207232920.GD27492@fuller.cnet> <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com> <87sg8g2sn4.fsf@nanos.tec.linutronix.de> <20201208181107.GA31442@fuller.cnet>
Date:   Tue, 08 Dec 2020 22:33:15 +0100
Message-ID: <875z5c2db8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 08 2020 at 15:11, Marcelo Tosatti wrote:
> On Tue, Dec 08, 2020 at 05:02:07PM +0100, Thomas Gleixner wrote:
>> On Tue, Dec 08 2020 at 16:50, Maxim Levitsky wrote:
>> > On Mon, 2020-12-07 at 20:29 -0300, Marcelo Tosatti wrote:
>> >> > +This ioctl allows to reconstruct the guest's IA32_TSC and TSC_ADJUST value
>> >> > +from the state obtained in the past by KVM_GET_TSC_STATE on the same vCPU.
>> >> > +
>> >> > +If 'KVM_TSC_STATE_TIMESTAMP_VALID' is set in flags,
>> >> > +KVM will adjust the guest TSC value by the time that passed since the moment
>> >> > +CLOCK_REALTIME timestamp was saved in the struct and current value of
>> >> > +CLOCK_REALTIME, and set the guest's TSC to the new value.
>> >> 
>> >> This introduces the wraparound bug in Linux timekeeping, doesnt it?
>> 
>> Which bug?
>
> max_cycles overflow. Sent a message to Maxim describing it.

Truly helpful. Why the hell did you not talk to me when you ran into
that the first time?

>> For one I have no idea which bug you are talking about and if the bug is
>> caused by the VMM then why would you "fix" it in the guest kernel.
>
> 1) Stop guest, save TSC value of cpu-0 = V.
> 2) Wait for some amount of time = W.
> 3) Start guest, load TSC value with V+W.
>
> Can cause an overflow on Linux timekeeping.

Yes, because you violate the basic assumption which Linux timekeeping
makes. See the other mail in this thread.

Thanks,

        tglx

