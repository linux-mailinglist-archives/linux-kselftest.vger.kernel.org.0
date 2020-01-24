Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C126D147A9E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 10:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgAXJf5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 04:35:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32450 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727295AbgAXJf5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 04:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579858556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KkR9XsyYszWewqqmOrVzZ1ik4TqqddD7Z9JTAAFoEcA=;
        b=IBmc5q1wcP1F7aKhwG108GEyx/J3ix5QqeSus0dGe1VzSQ9lmiknffAu8PyEhMcXLo9VF+
        CO5cQLsyJUetR6XRFfcHttpYnC/21kUdLMwL55wu85GFtNqt0WstnlRe8NcTmV75D60kds
        YNQ6O6gVK0XFOrGsObg5a+l14lEIEvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-OIjQAVdYPbepnMZWON9ngw-1; Fri, 24 Jan 2020 04:35:52 -0500
X-MC-Unique: OIjQAVdYPbepnMZWON9ngw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84FB28C5C9B;
        Fri, 24 Jan 2020 09:35:50 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA1A6863BC;
        Fri, 24 Jan 2020 09:35:45 +0000 (UTC)
Date:   Fri, 24 Jan 2020 10:35:43 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v4 06/10] KVM: selftests: Add support for vcpu_args_set
 to aarch64 and s390x
Message-ID: <20200124093543.m5oqo7fnjnc2scko@kamzik.brq.redhat.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-7-bgardon@google.com>
 <4dbb6d1b-3162-d9b3-4ebb-5e4061776bb6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dbb6d1b-3162-d9b3-4ebb-5e4061776bb6@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 24, 2020 at 10:03:08AM +0100, Paolo Bonzini wrote:
> CCing Marc, Conny and Christian (plus Thomas and Drew who were already
> in the list) for review.
> 
> Thanks,
> 
> Paolo
> 
> On 23/01/20 19:04, Ben Gardon wrote:
> > Currently vcpu_args_set is only implemented for x86. This makes writing
> > tests with multiple vCPUs difficult as each guest vCPU must either a.)
> > do the same thing or b.) derive some kind of unique token from it's
> > registers or the architecture. To simplify the process of writing tests
> > with multiple vCPUs for s390 and aarch64, add set args functions for
> > those architectures.

It'd be nice to keep the separate architecture changes in separate
patches. Otherwise I can't really give an r-b.

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

lib/aarch64/processor.c so far doesn't have big function headers like
this. Also, since this function is common for all architectures [now],
I feel like the documentation should be in common code - so in the header
file.

> > +void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
> > +{
> > +	va_list ap;
> > +
> > +	TEST_ASSERT(num >= 1 && num <= 8, "Unsupported number of args,\n"
> > +		    "  num: %u\n",
> > +		    num);

Weird line breaking. I see it came from the x86 implementation, but it's
weird there too... Personally I'd just put it all on one line, because
my vt100 died two decades ago.

> > +
> > +	va_start(ap, num);
> > +
> > +	for (i = 0; i < num; i++)
> > +		set_reg(vm, vcpuid, ARM64_CORE_REG(regs.regs[num]),
                                                             ^^ should be 'i'

> > +			va_arg(ap, uint64_t));

nit: I'd use {} because of the line break. Or just not break the line and
bust the 80 char "limit" (RIP vt100).

Thanks,
drew

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

