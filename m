Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F7A44320B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Nov 2021 16:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhKBPzr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Nov 2021 11:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbhKBPzq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Nov 2021 11:55:46 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3F1C0613F5
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Nov 2021 08:53:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 75so20549511pga.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Nov 2021 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uXG46CNq1yzX39v2pBF3aSKlrNsVM6oau9TO8Y5/ynw=;
        b=pAs2y+ijAdLSwVnN/iXoGJIDLS2TO7pznZDqrBgEiymfJ5fMb7bmsUqig8SFz/Xfz9
         j6el+hpRpb/l8ztcGtA143m4jBw95nEruKEKLZflgyH0d2cKE1Vm3WPi9wOqO5i1+Got
         XoLGG8E6DHHL/sQ7ohtI+bDXXVanHnKjoPPgFat2aSGVzvixVFf5qEt0Ofs/Rn/gfo/M
         z0d3eH1FlZFlKYHdt3NTZ5BlT9ik94kSiECQBj3WqPjPXKf+mh8TnEQje+pknFsZ5NZd
         i4H1RfdoBxpT3Fcp/BBPgnShbHpk6nXoYfhmhoGPoZS/pZcuC6RVsf3d2+Y8t8vBgnBj
         9oPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uXG46CNq1yzX39v2pBF3aSKlrNsVM6oau9TO8Y5/ynw=;
        b=ybQAa5yomK9MJLrHh/Svia+L4q76F4GsG5R/+OC7v99pVEj9mpg3X0H9cjZMOKmXiv
         bNONQ8kQKoMH6/bdPlfXsLnTPAtWmR1g/og7i0kVeRxPZ126hOoMxpUPqtpdBwbHoCGz
         YMCf1LgnL0hOEGDyJql0lYsiKfLMxR1DjjPIn7FaNFCxUtGMy9aNEML3LTG4fNo0rYzs
         5zR5xuctQld552I4wmCKYoJvV58gzIlr/GhuMRoOducmc2opUPCpvoxpKUtqAsuS1nRn
         TvPVogHGUjQOxH4rcP32hWc99N6EOYsqyTuZ0DGQpvXmtobInfyqnfJdJc5elceZmJxI
         GcLA==
X-Gm-Message-State: AOAM5317bDcevuXFgc4xF1LapPOt3DXLdgV1EHzMsWZoXNBmnyPflZ3X
        LC0t086JOamKPYUiFtnxnskPfA==
X-Google-Smtp-Source: ABdhPJxNtDKLBpxoiRVYVgHQ8HO9yQL5vu6uWpAHtSkKWriSHm706e6zFB2nNeZItuHLc1BNhEWGrA==
X-Received: by 2002:a63:e24b:: with SMTP id y11mr28060654pgj.452.1635868389352;
        Tue, 02 Nov 2021 08:53:09 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id nr14sm2839945pjb.24.2021.11.02.08.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:53:08 -0700 (PDT)
Date:   Tue, 2 Nov 2021 15:53:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
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
Message-ID: <YYFe4LKXiuV+DyZh@google.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
 <20210811122927.900604-7-mlevitsk@redhat.com>
 <137f2dcc-75d2-9d71-e259-dd66d43ad377@redhat.com>
 <87sfwfkhk5.fsf@vitty.brq.redhat.com>
 <b48210a35b3bc6d63beeb33c19b609b3014191dd.camel@redhat.com>
 <YYB2l9bzFhKzobZB@google.com>
 <87k0hqkf6p.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0hqkf6p.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 02, 2021, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > I haven't verified on hardware, but my guess is that this code in vmx_vcpu_run()
> >
> > 	/* When single-stepping over STI and MOV SS, we must clear the
> > 	 * corresponding interruptibility bits in the guest state. Otherwise
> > 	 * vmentry fails as it then expects bit 14 (BS) in pending debug
> > 	 * exceptions being set, but that's not correct for the guest debugging
> > 	 * case. */
> > 	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)
> > 		vmx_set_interrupt_shadow(vcpu, 0);
> >
> > interacts badly with APICv=1.  It will kill the STI shadow and cause the IRQ in
> > vmcs.GUEST_RVI to be recognized when it (micro-)architecturally should not.  My
> > head is going in circles trying to sort out what would actually happen.  Maybe
> > comment out that and/or disable APICv to see if either one makes the test pass?
> >
> 
> Interestingly,
> 
> loading 'kvm-intel' with 'enable_apicv=0' makes the test pass, however,
> commenting out "vmx_set_interrupt_shadow()" as suggested gives a
> different result (with enable_apicv=1):
> 
> # ./x86_64/debug_regs 
> ==== Test Assertion Failure ====
>   x86_64/debug_regs.c:179: run->exit_reason == KVM_EXIT_DEBUG && run->debug.arch.exception == DB_VECTOR && run->debug.arch.pc == target_rip && run->debug.arch.dr6 == target_dr6
>   pid=16352 tid=16352 errno=0 - Success
>      1	0x0000000000402b33: main at debug_regs.c:179 (discriminator 10)
>      2	0x00007f36401bd554: ?? ??:0
>      3	0x00000000004023a9: _start at ??:?
>   SINGLE_STEP[1]: exit 9 exception -2147483615 rip 0x1 (should be 0x4024d9) dr6 0xffff4ff0 (should be 0xffff4ff0)

Exit 9 is KVM_EXIT_FAIL_ENTRY, which in this case VM-Entry likely failed due to
invalid guest state because there was STI blocking with single-step enabled but
no pending BS #DB:

  Bit 14 (BS) must be 1 if the TF flag (bit 8) in the RFLAGS field is 1 and the
  BTF flag (bit 1) in the IA32_DEBUGCTL field is 0.

Which is precisely what that hack-a-fix avoids.  There isn't really a clean
solution for legacy single-step, AFAIK the only way to avoid this would be to
switch KVM_GUESTDBG_SINGLESTEP to use MTF.

But that mess is a red herring, the test fails with the same signature with APICv=1
if the STI is replaced by PUSHF+BTS+POPFD (to avoid the STI shadow).  We all missed
this key detail from Vitaly's report:

SINGLE_STEP[1]: exit 8 exception 1 rip 0x402a25 (should be 0x402a27) dr6 0xffff4ff0 (should be 0xffff4ff0)
                ^^^^^^

Exit '8' is KVM_EXIT_SHUTDOWN, i.e. the arrival of the IRQ hosed the guest because
the test doesn't invoke vm_init_descriptor_tables() to install event handlers.
The "exception 1" shows up because the run page isn't sanitized by the test, i.e.
it's stale data that happens to match.

So I would fully expect this test to fail with AVIC=1.  The problem is that
KVM_GUESTDBG_BLOCKIRQ does absolutely nothing to handle APICv interrupts.  And
even if KVM does something to fudge that behavior in the emulated local APIC, the
test will then fail miserably virtual IPIs (currently AVIC only).

I stand by my original comment that "Deviating this far from architectural behavior
will end in tears at some point."  Rather than try to "fix" APICv, I vote to instead
either reject KVM_GUESTDBG_BLOCKIRQ if APICv=1, or log a debug message saying that
KVM_GUESTDBG_BLOCKIRQ is ineffective with APICv=1.
