Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8197441DEF
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 17:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhKAQV5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 12:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232633AbhKAQV4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 12:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635783562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dO/4QsOfeW35SZcn1WG7FeeE85F7kQHGfg1XlWtfu7s=;
        b=dGjxbARhmrqmSP2VMok+6FWlR5vfsJlCkA2ICczieAwQkB9r8jAuMlesyXmd6Ti7pHOYfw
        jInSjckBY8/k3PkCV7oFnaMosuHx8uAurrVHuKpq+u0S5A6Xuj3mOqJXCLhEaKaUS7on6n
        mO0qSPYfLrNhHSu7Y3NK6nHfZyTVUak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-5OdkIJTLOe-Ds0UpIdB-uA-1; Mon, 01 Nov 2021 12:19:19 -0400
X-MC-Unique: 5OdkIJTLOe-Ds0UpIdB-uA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB26E18125C4;
        Mon,  1 Nov 2021 16:19:16 +0000 (UTC)
Received: from starship (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 442D75D9DC;
        Mon,  1 Nov 2021 16:19:10 +0000 (UTC)
Message-ID: <b48210a35b3bc6d63beeb33c19b609b3014191dd.camel@redhat.com>
Subject: Re: [PATCH v3 6/6] KVM: selftests: test KVM_GUESTDBG_BLOCKIRQ
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
Date:   Mon, 01 Nov 2021 18:19:09 +0200
In-Reply-To: <87sfwfkhk5.fsf@vitty.brq.redhat.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
         <20210811122927.900604-7-mlevitsk@redhat.com>
         <137f2dcc-75d2-9d71-e259-dd66d43ad377@redhat.com>
         <87sfwfkhk5.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2021-11-01 at 16:43 +0100, Vitaly Kuznetsov wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > On 11/08/21 14:29, Maxim Levitsky wrote:
> > > Modify debug_regs test to create a pending interrupt
> > > and see that it is blocked when single stepping is done
> > > with KVM_GUESTDBG_BLOCKIRQ
> > > 
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >   .../testing/selftests/kvm/x86_64/debug_regs.c | 24 ++++++++++++++++---
> > >   1 file changed, 21 insertions(+), 3 deletions(-)
> > 
> > I haven't looked very much at this, but the test fails.
> > 
> 
> Same here,
> 
> the test passes on AMD but fails consistently on Intel:
> 
> # ./x86_64/debug_regs 
> ==== Test Assertion Failure ====
>   x86_64/debug_regs.c:179: run->exit_reason == KVM_EXIT_DEBUG && run->debug.arch.exception == DB_VECTOR && run->debug.arch.pc == target_rip && run->debug.arch.dr6 == target_dr6
>   pid=13434 tid=13434 errno=0 - Success
>      1	0x00000000004027c6: main at debug_regs.c:179
>      2	0x00007f65344cf554: ?? ??:0
>      3	0x000000000040294a: _start at ??:?
>   SINGLE_STEP[1]: exit 8 exception 1 rip 0x402a25 (should be 0x402a27) dr6 0xffff4ff0 (should be 0xffff4ff0)
> 
> (I know I'm late to the party).

Well that is strange. It passes on my intel laptop. Just tested 
(kvm/queue + qemu master, compiled today) :-(

It fails on iteration 1 (and there is iteration 0) which I think means that we
start with RIP on sti, and get #DB on start of xor instruction first (correctly), 
and then we get #DB again on start of xor instruction again?

Something very strange. My laptop has i7-7600U.

Best regards,
	Maxim Levitsky




> 
> > Paolo
> > 
> > > diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
> > > index 6097a8283377..5f078db1bcba 100644
> > > --- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
> > > +++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
> > > @@ -8,12 +8,15 @@
> > >   #include <string.h>
> > >   #include "kvm_util.h"
> > >   #include "processor.h"
> > > +#include "apic.h"
> > >   
> > >   #define VCPU_ID 0
> > >   
> > >   #define DR6_BD		(1 << 13)
> > >   #define DR7_GD		(1 << 13)
> > >   
> > > +#define IRQ_VECTOR 0xAA
> > > +
> > >   /* For testing data access debug BP */
> > >   uint32_t guest_value;
> > >   
> > > @@ -21,6 +24,11 @@ extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
> > >   
> > >   static void guest_code(void)
> > >   {
> > > +	/* Create a pending interrupt on current vCPU */
> > > +	x2apic_enable();
> > > +	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
> > > +			 APIC_DM_FIXED | IRQ_VECTOR);
> > > +
> > >   	/*
> > >   	 * Software BP tests.
> > >   	 *
> > > @@ -38,12 +46,19 @@ static void guest_code(void)
> > >   		     "mov %%rax,%0;\n\t write_data:"
> > >   		     : "=m" (guest_value) : : "rax");
> > >   
> > > -	/* Single step test, covers 2 basic instructions and 2 emulated */
> > > +	/*
> > > +	 * Single step test, covers 2 basic instructions and 2 emulated
> > > +	 *
> > > +	 * Enable interrupts during the single stepping to see that
> > > +	 * pending interrupt we raised is not handled due to KVM_GUESTDBG_BLOCKIRQ
> > > +	 */
> > >   	asm volatile("ss_start: "
> > > +		     "sti\n\t"
> > >   		     "xor %%eax,%%eax\n\t"
> > >   		     "cpuid\n\t"
> > >   		     "movl $0x1a0,%%ecx\n\t"
> > >   		     "rdmsr\n\t"
> > > +		     "cli\n\t"
> > >   		     : : : "eax", "ebx", "ecx", "edx");
> > >   
> > >   	/* DR6.BD test */
> > > @@ -72,11 +87,13 @@ int main(void)
> > >   	uint64_t cmd;
> > >   	int i;
> > >   	/* Instruction lengths starting at ss_start */
> > > -	int ss_size[4] = {
> > > +	int ss_size[6] = {
> > > +		1,		/* sti*/
> > >   		2,		/* xor */
> > >   		2,		/* cpuid */
> > >   		5,		/* mov */
> > >   		2,		/* rdmsr */
> > > +		1,		/* cli */
> > >   	};
> > >   
> > >   	if (!kvm_check_cap(KVM_CAP_SET_GUEST_DEBUG)) {
> > > @@ -154,7 +171,8 @@ int main(void)
> > >   	for (i = 0; i < (sizeof(ss_size) / sizeof(ss_size[0])); i++) {
> > >   		target_rip += ss_size[i];
> > >   		CLEAR_DEBUG();
> > > -		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
> > > +		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP |
> > > +				KVM_GUESTDBG_BLOCKIRQ;
> > >   		debug.arch.debugreg[7] = 0x00000400;
> > >   		APPLY_DEBUG();
> > >   		vcpu_run(vm, VCPU_ID);
> > > 


