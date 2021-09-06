Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EBF4020FC
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Sep 2021 23:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhIFVEd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Sep 2021 17:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231246AbhIFVEd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Sep 2021 17:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630962207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6zz5nxlrQtpfoMyc8K53x2jtzybHx8hYr7zwDuDWfXs=;
        b=hviGSOUK7IkFfErGyBqH+JMRjocysbTgSezPfHh9ajZ1FF1g5cw/BIemUnFv/6fBnQxQHH
        P4rReYwA0eHBkaU1Ga3KNRaHbM8g/bNjN+ImSj9mhuBQqL7ZL2Ya2C5pRMrAlZqFj0yioG
        s9VYGWtfNnTduZF0mX3HdLcWUbngj5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-uZc-LRAoNMyRVS2c3iyUSw-1; Mon, 06 Sep 2021 17:03:26 -0400
X-MC-Unique: uZc-LRAoNMyRVS2c3iyUSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23486107ACCD;
        Mon,  6 Sep 2021 21:03:22 +0000 (UTC)
Received: from starship (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91FD05C1BB;
        Mon,  6 Sep 2021 21:03:15 +0000 (UTC)
Message-ID: <37b82ee53a3a84563b65be8e63193d4b823ea139.camel@redhat.com>
Subject: Re: [PATCH v3 6/6] KVM: selftests: test KVM_GUESTDBG_BLOCKIRQ
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
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
Date:   Tue, 07 Sep 2021 00:03:14 +0300
In-Reply-To: <137f2dcc-75d2-9d71-e259-dd66d43ad377@redhat.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
         <20210811122927.900604-7-mlevitsk@redhat.com>
         <137f2dcc-75d2-9d71-e259-dd66d43ad377@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2021-09-06 at 13:20 +0200, Paolo Bonzini wrote:
> On 11/08/21 14:29, Maxim Levitsky wrote:
> > Modify debug_regs test to create a pending interrupt
> > and see that it is blocked when single stepping is done
> > with KVM_GUESTDBG_BLOCKIRQ
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >   .../testing/selftests/kvm/x86_64/debug_regs.c | 24 ++++++++++++++++---
> >   1 file changed, 21 insertions(+), 3 deletions(-)
> 
> I haven't looked very much at this, but the test fails.

Works for me :-(

[mlevitsk@starship ~/Kernel/master/src/tools/testing/selftests/kvm]$./x86_64/debug_regs 
[mlevitsk@starship ~/Kernel/master/src/tools/testing/selftests/kvm]$echo $?
0


Maybe you run the test on kernel that doesn't support KVM_GUESTDBG_BLOCKIRQ?

Best regards,
	Maxim Levitsky

> 
> Paolo
> 
> > diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
> > index 6097a8283377..5f078db1bcba 100644
> > --- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
> > +++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
> > @@ -8,12 +8,15 @@
> >   #include <string.h>
> >   #include "kvm_util.h"
> >   #include "processor.h"
> > +#include "apic.h"
> >   
> >   #define VCPU_ID 0
> >   
> >   #define DR6_BD		(1 << 13)
> >   #define DR7_GD		(1 << 13)
> >   
> > +#define IRQ_VECTOR 0xAA
> > +
> >   /* For testing data access debug BP */
> >   uint32_t guest_value;
> >   
> > @@ -21,6 +24,11 @@ extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
> >   
> >   static void guest_code(void)
> >   {
> > +	/* Create a pending interrupt on current vCPU */
> > +	x2apic_enable();
> > +	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
> > +			 APIC_DM_FIXED | IRQ_VECTOR);
> > +
> >   	/*
> >   	 * Software BP tests.
> >   	 *
> > @@ -38,12 +46,19 @@ static void guest_code(void)
> >   		     "mov %%rax,%0;\n\t write_data:"
> >   		     : "=m" (guest_value) : : "rax");
> >   
> > -	/* Single step test, covers 2 basic instructions and 2 emulated */
> > +	/*
> > +	 * Single step test, covers 2 basic instructions and 2 emulated
> > +	 *
> > +	 * Enable interrupts during the single stepping to see that
> > +	 * pending interrupt we raised is not handled due to KVM_GUESTDBG_BLOCKIRQ
> > +	 */
> >   	asm volatile("ss_start: "
> > +		     "sti\n\t"
> >   		     "xor %%eax,%%eax\n\t"
> >   		     "cpuid\n\t"
> >   		     "movl $0x1a0,%%ecx\n\t"
> >   		     "rdmsr\n\t"
> > +		     "cli\n\t"
> >   		     : : : "eax", "ebx", "ecx", "edx");
> >   
> >   	/* DR6.BD test */
> > @@ -72,11 +87,13 @@ int main(void)
> >   	uint64_t cmd;
> >   	int i;
> >   	/* Instruction lengths starting at ss_start */
> > -	int ss_size[4] = {
> > +	int ss_size[6] = {
> > +		1,		/* sti*/
> >   		2,		/* xor */
> >   		2,		/* cpuid */
> >   		5,		/* mov */
> >   		2,		/* rdmsr */
> > +		1,		/* cli */
> >   	};
> >   
> >   	if (!kvm_check_cap(KVM_CAP_SET_GUEST_DEBUG)) {
> > @@ -154,7 +171,8 @@ int main(void)
> >   	for (i = 0; i < (sizeof(ss_size) / sizeof(ss_size[0])); i++) {
> >   		target_rip += ss_size[i];
> >   		CLEAR_DEBUG();
> > -		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
> > +		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP |
> > +				KVM_GUESTDBG_BLOCKIRQ;
> >   		debug.arch.debugreg[7] = 0x00000400;
> >   		APPLY_DEBUG();
> >   		vcpu_run(vm, VCPU_ID);
> > 


