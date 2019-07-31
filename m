Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D36417BE68
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2019 12:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbfGaK3C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Jul 2019 06:29:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387399AbfGaK3C (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Jul 2019 06:29:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44D6EC01DE0D;
        Wed, 31 Jul 2019 10:29:01 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F173019C70;
        Wed, 31 Jul 2019 10:28:51 +0000 (UTC)
Date:   Wed, 31 Jul 2019 12:28:49 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 1/2] KVM: selftests: Implement ucall() for s390x
Message-ID: <20190731102849.x26rdan7cddmpvhe@kamzik.brq.redhat.com>
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-2-thuth@redhat.com>
 <20190730104807.7uzuvd52foybakgu@kamzik.brq.redhat.com>
 <d9cb3c86-6390-3803-f2c6-d47f5c24139f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9cb3c86-6390-3803-f2c6-d47f5c24139f@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 31 Jul 2019 10:29:01 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 31, 2019 at 11:43:16AM +0200, Thomas Huth wrote:
> On 30/07/2019 12.48, Andrew Jones wrote:
> > On Tue, Jul 30, 2019 at 12:01:11PM +0200, Thomas Huth wrote:
> >> On s390x, we can neither exit via PIO nor MMIO, but have to use
> >> an instruction like DIAGNOSE. While we're at it, rename UCALL_PIO
> >> to UCALL_DEFAULT, since PIO only works on x86 anyway, and this
> >> way we can re-use the "default" type for the DIAGNOSE exit on s390x.
> >>
> >> Now that ucall() is implemented, we can use it in the sync_reg_test
> >> on s390x, too.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  .../testing/selftests/kvm/include/kvm_util.h  |  2 +-
> >>  tools/testing/selftests/kvm/lib/ucall.c       | 34 +++++++++++++++----
> >>  .../selftests/kvm/s390x/sync_regs_test.c      |  6 ++--
> >>  3 files changed, 32 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> >> index e0e66b115ef2..c37aea2e33e5 100644
> >> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> >> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> >> @@ -167,7 +167,7 @@ int vm_create_device(struct kvm_vm *vm, struct kvm_create_device *cd);
> >>  
> >>  /* ucall implementation types */
> >>  typedef enum {
> >> -	UCALL_PIO,
> >> +	UCALL_DEFAULT,
> > 
> > I'd rather we keep explicit types defined; keep PIO and add DIAG. Then
> > we can have
> > 
> > /*  Set default ucall types */
> > #if defined(__x86_64__)
> >   ucall_type = UCALL_PIO;
> > #elif defined(__aarch64__)
> >   ucall_type = UCALL_MMIO;
> >   ucall_requires_init = true;
> > #elif defined(__s390x__)
> >   ucall_type = UCALL_DIAG;
> > #endif
> > 
> > And add an assert in get_ucall()
> > 
> >  assert(!ucall_requires_init || ucall_initialized);
> 
> I'm not sure whether I really like that. It's yet another additional
> #ifdef block, and yet another variable ...
> 
> What do you think about removing the enum completely and simply code it
> directly, without the ucall_type indirection, i.e.:
> 
> void ucall(uint64_t cmd, int nargs, ...)
> {
> 	struct ucall uc = {
> 		.cmd = cmd,
> 	};
> 	va_list va;
> 	int i;
> 
> 	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> 
> 	va_start(va, nargs);
> 	for (i = 0; i < nargs; ++i)
> 		uc.args[i] = va_arg(va, uint64_t);
> 	va_end(va);
> 
> #if defined(__x86_64__)
> 
> 	/* Exit via PIO */
> 	asm volatile("in %[port], %%al"
> 		: : [port] "d" (UCALL_PIO_PORT), "D" (&uc) : "rax");
> 
> #elif defined(__aarch64__)
> 
> 	*ucall_exit_mmio_addr = (vm_vaddr_t)&uc;
> 
> #elif defined(__s390x__)
> 
> 	/* Exit via DIAGNOSE 0x501 (normally used for breakpoints) */
> 	asm volatile ("diag 0,%0,0x501" : : "a"(&uc) : "memory");
> 
> #endif
> }
> 
> I think that's way less confusing than having to understand the meaning
> of ucall_type etc. before...?
>

Sounds good to me.

Thanks,
drew 
