Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF88D44334F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Nov 2021 17:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhKBQom (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Nov 2021 12:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234722AbhKBQol (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Nov 2021 12:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635871326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wK3CplyUTs+rLFNGYkxFeT0xpcKz1YPPLC+3BDuT/aI=;
        b=UO+5W/N88ee+Dx8+k7sYJUYM/Pl0gwbmYptrYdElb1e3aBq/E5II2ElLimJ40i2vDx3Ojj
        3BYg5kwYm5cWCf4umF6puVBYmHNcZwdEYPNWNTxA7gvjr9Q9I//M6+9yAMd4l117xh5WQp
        NI72HW1fx1+f9tKgrAZMnKcOjAbXs60=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-JDpWKD27M_OLN3C2e4iQKg-1; Tue, 02 Nov 2021 12:18:53 -0400
X-MC-Unique: JDpWKD27M_OLN3C2e4iQKg-1
Received: by mail-wm1-f69.google.com with SMTP id u14-20020a05600c19ce00b0030d8549d49aso879320wmq.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Nov 2021 09:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wK3CplyUTs+rLFNGYkxFeT0xpcKz1YPPLC+3BDuT/aI=;
        b=7ZZVNRwK8KHDnWnatFPgyLXbnq+Wa6ojGez8TtOXlEGy6CST+Qzr85+KNreXv4qg5q
         u5lsK3TmDgEyKr5VJ4hTqOrm7dB5++8PPRAfvrNNwpTNofqTGy10ukdUs6opEq8tGn3v
         hOZiMotrmJfYwSqpRYFjBVSC/mM0KzM80+Gg5otrvg/n76thmQXIU+CzRGkqLVDUF3sz
         jIvza7I0aObCcl3q6dVr9uVaGnVWCrkaZKc4RjJEzfGQWiIC5CGjw/JYPnH9mK9JoLc0
         /5VSioo5x5UNQOmwtEzsFja/6iO0daL5TNjmifY/nRZJLX2Aosjw5YwcaZZQwvIKeIOQ
         66MQ==
X-Gm-Message-State: AOAM532uKyujzR9vaJmLM6FqTZbb24zum+VqmYJAfaTXIPWhrNmy24dU
        OYa4pgY1lY0TVPAPLv5+AmotMGXpvnEIINe15IW+nU0ygSzBOn/CYYodiPJ9D0a2Czog6TQ8xeY
        41XsO8WQmzzkaeYb1u+iKK3kQL5bV
X-Received: by 2002:adf:df0b:: with SMTP id y11mr24247330wrl.181.1635869932277;
        Tue, 02 Nov 2021 09:18:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRLgXOmmGYC7qrn6wZIz5rGaltkLk0p5nNwexOv2/BGr6u6CjLVcaCTf54oi69NKmWtoLxSQ==
X-Received: by 2002:adf:df0b:: with SMTP id y11mr24247300wrl.181.1635869932069;
        Tue, 02 Nov 2021 09:18:52 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x13sm13871373wrr.47.2021.11.02.09.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:18:51 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 6/6] KVM: selftests: test KVM_GUESTDBG_BLOCKIRQ
In-Reply-To: <YYFe4LKXiuV+DyZh@google.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
 <20210811122927.900604-7-mlevitsk@redhat.com>
 <137f2dcc-75d2-9d71-e259-dd66d43ad377@redhat.com>
 <87sfwfkhk5.fsf@vitty.brq.redhat.com>
 <b48210a35b3bc6d63beeb33c19b609b3014191dd.camel@redhat.com>
 <YYB2l9bzFhKzobZB@google.com> <87k0hqkf6p.fsf@vitty.brq.redhat.com>
 <YYFe4LKXiuV+DyZh@google.com>
Date:   Tue, 02 Nov 2021 17:18:49 +0100
Message-ID: <87fsseo7iu.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Nov 02, 2021, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> > I haven't verified on hardware, but my guess is that this code in vmx_vcpu_run()
>> >
>> > 	/* When single-stepping over STI and MOV SS, we must clear the
>> > 	 * corresponding interruptibility bits in the guest state. Otherwise
>> > 	 * vmentry fails as it then expects bit 14 (BS) in pending debug
>> > 	 * exceptions being set, but that's not correct for the guest debugging
>> > 	 * case. */
>> > 	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
>> > 		vmx_set_interrupt_shadow(vcpu, 0);
>> >
>> > interacts badly with APICv=1.  It will kill the STI shadow and cause the IRQ in
>> > vmcs.GUEST_RVI to be recognized when it (micro-)architecturally should not.  My
>> > head is going in circles trying to sort out what would actually happen.  Maybe
>> > comment out that and/or disable APICv to see if either one makes the test pass?
>> >
>> 
>> Interestingly,
>> 
>> loading 'kvm-intel' with 'enable_apicv=0' makes the test pass, however,
>> commenting out "vmx_set_interrupt_shadow()" as suggested gives a
>> different result (with enable_apicv=1):
>> 
>> # ./x86_64/debug_regs 
>> ==== Test Assertion Failure ====
>>   x86_64/debug_regs.c:179: run->exit_reason == KVM_EXIT_DEBUG && run->debug.arch.exception == DB_VECTOR && run->debug.arch.pc == target_rip && run->debug.arch.dr6 == target_dr6
>>   pid=16352 tid=16352 errno=0 - Success
>>      1	0x0000000000402b33: main at debug_regs.c:179 (discriminator 10)
>>      2	0x00007f36401bd554: ?? ??:0
>>      3	0x00000000004023a9: _start at ??:?
>>   SINGLE_STEP[1]: exit 9 exception -2147483615 rip 0x1 (should be 0x4024d9) dr6 0xffff4ff0 (should be 0xffff4ff0)
>
> Exit 9 is KVM_EXIT_FAIL_ENTRY, which in this case VM-Entry likely failed due to
> invalid guest state because there was STI blocking with single-step enabled but
> no pending BS #DB:
>
>   Bit 14 (BS) must be 1 if the TF flag (bit 8) in the RFLAGS field is 1 and the
>   BTF flag (bit 1) in the IA32_DEBUGCTL field is 0.
>
> Which is precisely what that hack-a-fix avoids.  There isn't really a clean
> solution for legacy single-step, AFAIK the only way to avoid this would be to
> switch KVM_GUESTDBG_SINGLESTEP to use MTF.
>
> But that mess is a red herring, the test fails with the same signature with APICv=1
> if the STI is replaced by PUSHF+BTS+POPFD (to avoid the STI shadow).  We all missed
> this key detail from Vitaly's report:
>
> SINGLE_STEP[1]: exit 8 exception 1 rip 0x402a25 (should be 0x402a27) dr6 0xffff4ff0 (should be 0xffff4ff0)
>                 ^^^^^^
>
> Exit '8' is KVM_EXIT_SHUTDOWN, i.e. the arrival of the IRQ hosed the guest because
> the test doesn't invoke vm_init_descriptor_tables() to install event handlers.
> The "exception 1" shows up because the run page isn't sanitized by the test, i.e.
> it's stale data that happens to match.
>
> So I would fully expect this test to fail with AVIC=1.  The problem is that
> KVM_GUESTDBG_BLOCKIRQ does absolutely nothing to handle APICv interrupts.  And
> even if KVM does something to fudge that behavior in the emulated local APIC, the
> test will then fail miserably virtual IPIs (currently AVIC only).

FWIW, the test doesn't seem to fail on my AMD EPYC system even with "avic=1" ...

>
> I stand by my original comment that "Deviating this far from architectural behavior
> will end in tears at some point."  Rather than try to "fix" APICv, I vote to instead
> either reject KVM_GUESTDBG_BLOCKIRQ if APICv=1, or log a debug message saying that
> KVM_GUESTDBG_BLOCKIRQ is ineffective with APICv=1.
>

-- 
Vitaly

