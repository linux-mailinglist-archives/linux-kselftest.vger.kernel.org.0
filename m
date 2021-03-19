Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABC8341802
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 10:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCSJLd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 05:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35762 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229780AbhCSJL0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 05:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616145086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8io2IJ6KWUcM3lZUql+YWG5SEcwRMojg79JpmzqXaPM=;
        b=L7zkaGPCpHB4f7TDOrvNl8jAvf5NQjTVKmw/T9GVApBqtskL3zwZwcbqyJwsSSnBZFf4iH
        qvriISG4Nm2wJ+KpZRhUZlTBkyIrjrzFodleFyxe3g5YDpGuiqRGHi7zSi1jkL9LuEik0e
        2lQ4Oa9I4xgEGEd7tzYXaf62DygB36A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-tsjrav6cP7afHvB1Kmuk5w-1; Fri, 19 Mar 2021 05:11:24 -0400
X-MC-Unique: tsjrav6cP7afHvB1Kmuk5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31BE783DD21;
        Fri, 19 Mar 2021 09:11:23 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.242])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B2CD6F98A;
        Fri, 19 Mar 2021 09:11:17 +0000 (UTC)
Date:   Fri, 19 Mar 2021 10:11:14 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/kvm: add set_boot_cpu_id test
Message-ID: <20210319091114.agftfyhb2ispaktv@kamzik.brq.redhat.com>
References: <20210318151624.490861-1-eesposit@redhat.com>
 <20210318151624.490861-2-eesposit@redhat.com>
 <20210318162036.sf6vgq2ntbgulpzb@kamzik.brq.redhat.com>
 <a81f1f39-8ff0-4fd9-d859-57569c437f39@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a81f1f39-8ff0-4fd9-d859-57569c437f39@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 19, 2021 at 09:34:40AM +0100, Emanuele Giuseppe Esposito wrote:
> On 18/03/2021 17:20, Andrew Jones wrote:
> > On Thu, Mar 18, 2021 at 04:16:24PM +0100, Emanuele Giuseppe Esposito wrote:
> > > +static void run_vm_bsp(uint32_t bsp_vcpu)
> > 
> > I think the 'bsp' suffixes and prefixes make the purpose of this function
> > and its argument more confusing. Just
> > 
> >   static void run_vm(uint32_t vcpu)
> > 
> > would be more clear to me.
> 
> The idea here was "run vm with this vcpu as BSP", implicitly assuming that
> there are alwasy 2 vcpu inside, so we are picking one as BSP.
> 
> Maybe
> 
> run_vm_2_vcpu(uint32_t bsp_vcpid)
> 
> is better?

run_vm() is probably still sufficient for the function name. I better
understand the naming of the function's argument now, so the bsp prefix
does make sense.

> 
> > 
> > > +{
> > > +	struct kvm_vm *vm;
> > > +	bool is_bsp_vcpu1 = bsp_vcpu == VCPU_ID1;
> > 
> > Could add another define
> > 
> >   #define BSP_VCPU VCPU_ID1
> > 
> > And then instead of creating the above bool, just do
> > 
> >   if (vcpu == BSP_VCPU)
> 
> I think it will be even more confusing to have BSP_VCPU fixed to VCPU_ID1,
> because in the tests before and after I use VCPU_ID0 as BSP.
> 
> 	run_vm_bsp(VCPU_ID0);
> 	run_vm_bsp(VCPU_ID1);
> 	run_vm_bsp(VCPU_ID0);

Agreed. I hadn't read that far down and hadn't grasped the purpose
of run_vm[_bsp]'s argument before. But, can we get rid of the
is_bsp_vcpu1 boolean anyway? 'if (bsp_vcpu == VCPU_ID1)' is terse
enough, and it better exposes the logic.

> 
> > 
> > > +
> > > +	vm = create_vm();
> > > +
> > > +	if (is_bsp_vcpu1)
> > > +		vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
> > 
> > Does this ioctl need to be called before creating the vcpus? The
> > documentation in Documentation/virt/kvm/api.rst doesn't say that.
> 
> Yes, it has to be called before creating the vcpus, as also shown in the
> test function "check_set_bsp_busy". KVM checks that created_vcpus is 0
> before setting the bsp field.
> 
> arch/x86/kvm/x86.c
> 		case KVM_SET_BOOT_CPU_ID:
> 		...
> 		if (kvm->created_vcpus)
> 			r = -EBUSY;
> 		else
> 			kvm->arch.bsp_vcpu_id = arg;
> 
> I will update the documentation to include also this information.

Great!

And I'll try to improve the KVM selftests API to better support these
types of tests without having to copy so much code.

> 
> > If it can be called after creating the vcpus, then
> > vm_create_default_with_vcpus() can be used and there's no need
> > for the create_vm() and add_x86_vcpu() functions.
> 
> Just use the
> > same guest code for both, but pass the cpu index to the guest
> > code function allowing something like
> > 
> >     if (cpu == BSP_VCPU)
> > 	GUEST_ASSERT(get_bsp_flag() != 0);
> >     else
> > 	GUEST_ASSERT(get_bsp_flag() == 0);
> > 
> I might be wrong, but there seems not to be an easy way to pass arguments to
> the guest function.

There are several tests that pass the CPU index to the guest function
which you can use as examples. Take a look at e.g. steal_time.c. The
trick is to set the argument(s) with vcpu_args_set().

Thanks,
drew

