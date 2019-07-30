Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 456CD7A638
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2019 12:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfG3KsU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jul 2019 06:48:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbfG3KsU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jul 2019 06:48:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9241E30C5843;
        Tue, 30 Jul 2019 10:48:19 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F7355C1B4;
        Tue, 30 Jul 2019 10:48:09 +0000 (UTC)
Date:   Tue, 30 Jul 2019 12:48:07 +0200
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
Message-ID: <20190730104807.7uzuvd52foybakgu@kamzik.brq.redhat.com>
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-2-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730100112.18205-2-thuth@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 30 Jul 2019 10:48:19 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 30, 2019 at 12:01:11PM +0200, Thomas Huth wrote:
> On s390x, we can neither exit via PIO nor MMIO, but have to use
> an instruction like DIAGNOSE. While we're at it, rename UCALL_PIO
> to UCALL_DEFAULT, since PIO only works on x86 anyway, and this
> way we can re-use the "default" type for the DIAGNOSE exit on s390x.
> 
> Now that ucall() is implemented, we can use it in the sync_reg_test
> on s390x, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  |  2 +-
>  tools/testing/selftests/kvm/lib/ucall.c       | 34 +++++++++++++++----
>  .../selftests/kvm/s390x/sync_regs_test.c      |  6 ++--
>  3 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index e0e66b115ef2..c37aea2e33e5 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -167,7 +167,7 @@ int vm_create_device(struct kvm_vm *vm, struct kvm_create_device *cd);
>  
>  /* ucall implementation types */
>  typedef enum {
> -	UCALL_PIO,
> +	UCALL_DEFAULT,

I'd rather we keep explicit types defined; keep PIO and add DIAG. Then
we can have

/*  Set default ucall types */
#if defined(__x86_64__)
  ucall_type = UCALL_PIO;
#elif defined(__aarch64__)
  ucall_type = UCALL_MMIO;
  ucall_requires_init = true;
#elif defined(__s390x__)
  ucall_type = UCALL_DIAG;
#endif

And add an assert in get_ucall()

 assert(!ucall_requires_init || ucall_initialized);


>  	UCALL_MMIO,
>  } ucall_type_t;
>  
> diff --git a/tools/testing/selftests/kvm/lib/ucall.c b/tools/testing/selftests/kvm/lib/ucall.c
> index dd9a66700f96..55534dd014dc 100644
> --- a/tools/testing/selftests/kvm/lib/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/ucall.c
> @@ -30,7 +30,7 @@ void ucall_init(struct kvm_vm *vm, ucall_type_t type, void *arg)
>  	ucall_type = type;
>  	sync_global_to_guest(vm, ucall_type);
>  
> -	if (type == UCALL_PIO)
> +	if (type == UCALL_DEFAULT)
>  		return;
>  
>  	if (type == UCALL_MMIO) {
> @@ -84,11 +84,18 @@ void ucall_uninit(struct kvm_vm *vm)
>  	sync_global_to_guest(vm, ucall_exit_mmio_addr);
>  }
>  
> -static void ucall_pio_exit(struct ucall *uc)
> +static void ucall_default_exit(struct ucall *uc)
>  {
> -#ifdef __x86_64__
> +#if defined(__x86_64__)
> +	/* Exit via PIO */
>  	asm volatile("in %[port], %%al"
>  		: : [port] "d" (UCALL_PIO_PORT), "D" (uc) : "rax");
> +#elif defined(__s390x__)
> +	/* Exit via DIAGNOSE 0x501 (normally used for breakpoints) */
> +	asm volatile ("diag 0,%0,0x501" : : "a"(uc) : "memory");
> +#else
> +	fprintf(stderr, "No default ucall available on this architecture.\n");
> +	exit(1);
>  #endif
>  }
>  
> @@ -113,8 +120,8 @@ void ucall(uint64_t cmd, int nargs, ...)
>  	va_end(va);
>  
>  	switch (ucall_type) {
> -	case UCALL_PIO:
> -		ucall_pio_exit(&uc);
> +	case UCALL_DEFAULT:
> +		ucall_default_exit(&uc);
>  		break;
>  	case UCALL_MMIO:
>  		ucall_mmio_exit(&uc);
> @@ -128,15 +135,28 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
>  	struct ucall ucall = {};
>  	bool got_ucall = false;
>  
> -#ifdef __x86_64__
> -	if (ucall_type == UCALL_PIO && run->exit_reason == KVM_EXIT_IO &&
> +#if defined(__x86_64__)
> +	if (ucall_type == UCALL_DEFAULT && run->exit_reason == KVM_EXIT_IO &&
>  	    run->io.port == UCALL_PIO_PORT) {
>  		struct kvm_regs regs;
>  		vcpu_regs_get(vm, vcpu_id, &regs);
>  		memcpy(&ucall, addr_gva2hva(vm, (vm_vaddr_t)regs.rdi), sizeof(ucall));
>  		got_ucall = true;
>  	}
> +#elif defined(__s390x__)
> +	if (ucall_type == UCALL_DEFAULT &&
> +	    run->exit_reason == KVM_EXIT_S390_SIEIC &&
> +	    run->s390_sieic.icptcode == 4 &&
> +	    (run->s390_sieic.ipa >> 8) == 0x83 &&    /* 0x83 means DIAGNOSE */
> +	    (run->s390_sieic.ipb >> 16) == 0x501) {
> +		int reg = run->s390_sieic.ipa & 0xf;
> +
> +		memcpy(&ucall, addr_gva2hva(vm, run->s.regs.gprs[reg]),
> +		       sizeof(ucall));
> +		got_ucall = true;
> +	}
>  #endif
> +
>  	if (ucall_type == UCALL_MMIO && run->exit_reason == KVM_EXIT_MMIO &&
>  	    run->mmio.phys_addr == (uint64_t)ucall_exit_mmio_addr) {
>  		vm_vaddr_t gva;
> diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> index e85ff0d69548..bbc93094519b 100644
> --- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> +++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
> @@ -25,9 +25,11 @@
>  
>  static void guest_code(void)
>  {
> +	register u64 stage asm("11") = 0;
> +
>  	for (;;) {
> -		asm volatile ("diag 0,0,0x501");
> -		asm volatile ("ahi 11,1");
> +		GUEST_SYNC(0);
> +		asm volatile ("ahi %0,1" : : "r"(stage));
>  	}
>  }
>  
> -- 
> 2.21.0
>

Thanks,
drew
