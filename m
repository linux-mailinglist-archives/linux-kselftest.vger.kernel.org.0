Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC02B149FF3
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2020 09:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgA0Iiu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jan 2020 03:38:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28046 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726260AbgA0Iiu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jan 2020 03:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580114328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6xHjqcGoKCBGKlL3qdqNz6iPbD1SCDfAlhNTZTWBwQI=;
        b=eHeZzyJ6Kixq1gnlmegS4dheSiSHWXTpdTIbi/V8Cn/ptVqwCtyC6gMNPLxsL2yX3p0lS7
        RvKIHwa+pWClkPwDst4fS8oGqd1K7IqTpd4jTrvuoZkzlpbPgEv7+p4my4teotGQkLKwoB
        hDxQvNSUEINDORJIkq+4Glns/rOxu3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-7JGMZ4wYPHaLPIBsHxr0GA-1; Mon, 27 Jan 2020 03:38:47 -0500
X-MC-Unique: 7JGMZ4wYPHaLPIBsHxr0GA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFC6D1800D41;
        Mon, 27 Jan 2020 08:38:45 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CEA4863C5;
        Mon, 27 Jan 2020 08:38:41 +0000 (UTC)
Date:   Mon, 27 Jan 2020 09:38:38 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 06/10] KVM: selftests: Add support for vcpu_args_set
 to aarch64 and s390x
Message-ID: <20200127083838.u32bylca2n4om6zx@kamzik.brq.redhat.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-7-bgardon@google.com>
 <6061cd22-59bb-c191-bd98-f14d7cd274ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6061cd22-59bb-c191-bd98-f14d7cd274ae@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 25, 2020 at 10:34:16AM +0100, Paolo Bonzini wrote:
> On 23/01/20 19:04, Ben Gardon wrote:
> > Currently vcpu_args_set is only implemented for x86. This makes writing
> > tests with multiple vCPUs difficult as each guest vCPU must either a.)
> > do the same thing or b.) derive some kind of unique token from it's
> > registers or the architecture. To simplify the process of writing tests
> > with multiple vCPUs for s390 and aarch64, add set args functions for
> > those architectures.
> > 
> > Signed-off-by: Ben Gardon <bgardon@google.com>
> > ---
> >  .../selftests/kvm/lib/aarch64/processor.c     | 33 +++++++++++++++++
> >  .../selftests/kvm/lib/s390x/processor.c       | 35 +++++++++++++++++++
> >  2 files changed, 68 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> > index 86036a59a668e..a2ff90a75f326 100644
> > --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> > @@ -333,3 +333,36 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
> >  {
> >  	aarch64_vcpu_add_default(vm, vcpuid, NULL, guest_code);
> >  }
> > +
> > +/* VM VCPU Args Set
> > + *
> > + * Input Args:
> > + *   vm - Virtual Machine
> > + *   vcpuid - VCPU ID
> > + *   num - number of arguments
> > + *   ... - arguments, each of type uint64_t
> > + *
> > + * Output Args: None
> > + *
> > + * Return: None
> > + *
> > + * Sets the first num function input arguments to the values
> > + * given as variable args.  Each of the variable args is expected to
> > + * be of type uint64_t. The registers set by this function are r0-r7.
> > + */
> > +void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
> > +{
> > +	va_list ap;
> > +
> > +	TEST_ASSERT(num >= 1 && num <= 8, "Unsupported number of args,\n"
> > +		    "  num: %u\n",
> > +		    num);
> > +
> > +	va_start(ap, num);
> > +
> > +	for (i = 0; i < num; i++)
> > +		set_reg(vm, vcpuid, ARM64_CORE_REG(regs.regs[num]),

For AArch64 you also need to squash s/num/i/ for this line.

(Plus I'm still not that pleased with adding this big header to this
file for this function, or the weird line breaks in the assert.)

> > +			va_arg(ap, uint64_t));
> > +
> > +	va_end(ap);
> > +}
> > diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
> > index 32a02360b1eb0..680f37be9dbc9 100644
> > --- a/tools/testing/selftests/kvm/lib/s390x/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
> > @@ -269,6 +269,41 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
> >  	run->psw_addr = (uintptr_t)guest_code;
> >  }
> >  
> > +/* VM VCPU Args Set
> > + *
> > + * Input Args:
> > + *   vm - Virtual Machine
> > + *   vcpuid - VCPU ID
> > + *   num - number of arguments
> > + *   ... - arguments, each of type uint64_t
> > + *
> > + * Output Args: None
> > + *
> > + * Return: None
> > + *
> > + * Sets the first num function input arguments to the values
> > + * given as variable args.  Each of the variable args is expected to
> > + * be of type uint64_t. The registers set by this function are r2-r6.
> > + */
> > +void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
> > +{
> > +	va_list ap;
> > +	struct kvm_regs regs;
> > +
> > +	TEST_ASSERT(num >= 1 && num <= 5, "Unsupported number of args,\n"
> > +		    "  num: %u\n",
> > +		    num);
> > +
> > +	va_start(ap, num);
> > +	vcpu_regs_get(vm, vcpuid, &regs);
> > +
> > +	for (i = 0; i < num; i++)
> > +		regs.gprs[i + 2] = va_arg(ap, uint64_t);
> > +
> > +	vcpu_regs_set(vm, vcpuid, &regs);
> > +	va_end(ap);
> > +}
> > +
> >  void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
> >  {
> >  	struct vcpu *vcpu = vm->vcpu_head;
> > 
> 
> Squashing this:
> 
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> index a2ff90a75f32..839a76c96f01 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> @@ -353,6 +353,7 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
>  void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
>  {
>  	va_list ap;
> +	int i;
>  
>  	TEST_ASSERT(num >= 1 && num <= 8, "Unsupported number of args,\n"
>  		    "  num: %u\n",
> diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
> index 680f37be9dbc..a0b84235c848 100644
> --- a/tools/testing/selftests/kvm/lib/s390x/processor.c
> +++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
> @@ -289,6 +289,7 @@ void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
>  {
>  	va_list ap;
>  	struct kvm_regs regs;
> +	int i;
>  
>  	TEST_ASSERT(num >= 1 && num <= 5, "Unsupported number of args,\n"
>  		    "  num: %u\n",
> 
> Paolo
> 

