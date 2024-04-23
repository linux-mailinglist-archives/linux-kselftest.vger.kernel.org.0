Return-Path: <linux-kselftest+bounces-8738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAB58AFCE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 01:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A906B24A7C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 23:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997C854645;
	Tue, 23 Apr 2024 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5cdYMNi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2365537F1
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916223; cv=none; b=jF6L0jreL4dMAqj4V3dyhE6ULit6gfG+Zik9VYQzqqzafydXS7/T6tLMm9zR+uIukUgeJ5vAkdNAm1cG9H/TOvyVjqg1Bm4k+fORWvjgU/CamXrf4NSTIdiUNZKMhSejerLgHjb6d9CNR7059JDolCwFgycYg8ae/8wB72jg6MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916223; c=relaxed/simple;
	bh=I2QIzgpb/mSP4CG+9bGvMJ9ef//nb7Nd1NdK/yAqP+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MR1lu2LGRzXU1NYMh07YgwIepHV5xNmMVG07NXa79CIpvhboE6pwfJiyIH7AgI0Edmg5a3y7x0n8suV6z0KjDmV0S4Q/2YNx3p3VsyOku2VcIB7AOYFB86H8CBXi6G0QK4k1S1i7OsVoK6g99JH8kKKVnNkC8aJI9xGd5A7B4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e5cdYMNi; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ed4298be39so5489607b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 16:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713916220; x=1714521020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S0XgZKcpp0Rc9lwkgVkwCs//I4YyNrUEqhi1oEZOUlk=;
        b=e5cdYMNifn+b/6IfY9LI0VxitVnxys7/K5a6RB+sKyocuSUN0upyXhMKYyYxhQJ5kd
         fVLup5BWI7w5RB0Z4iAzcCBeoubMRyMS2dS9sTuLe098hXMWdehC7Hk5bOUs+3epm+9W
         5cFK5MEV1CgWZOMLMr0fjLVZMqbr/XDLXOweZ15iWOZvD85v/AwTSX/2nZxidhZ4JhVS
         LUCdaZE34/wMWaoY065BDGmh+f7G4Rm9BWYcuU4tbUjDpsvQnwDg4jmpsUZYGA0eOknj
         DmhTGriflCtOezLY3gwloOo8WQXLTPg/mxdaMrc1bNliMvFEvDXViiaVdjI1TE8ayADe
         tC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713916220; x=1714521020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0XgZKcpp0Rc9lwkgVkwCs//I4YyNrUEqhi1oEZOUlk=;
        b=EOgXZPT4U9WjbxbiyhqH2myh6wgK4Q2DD6GOV5+N9c6QjqYzYOSMI6LUe6qq10w4Yc
         NBrSYbaSktIpUboD7TiPEOfNEWvIPo1KabePo7/8tc2s3eEh1Uh/ggFjV4q42cC3DggW
         fe7FR3rEANfPacXldIaULPz49jXpNztl0vbSDcT9e7KnmOEATRdlX2izmEMszDtNBUz3
         8omF3P2tp3hpBGimj7IDPHfS87wXlVDGpB3BA/WfIm6ilaX4uIW+y0jgJiaY7kq9WlVt
         nHBkwq2xC9f5Pvc6J6+iFXVrnjCPB1bmqGwCoq5k9ZC9hViKQBjyIcFdZbT1ilsW46/N
         Kc2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjwmL0K5bElO/v3mo2vE2ehfhfs1xNQTO6BONRuoIimLCPiCSCcvdgdwqv8swLtt+5vxGcXqiwPHrWqogskjMrt0GtDv+RelX7V1ggwhlG
X-Gm-Message-State: AOJu0YwfU8Dm1cEXLBg9oER8ayOqnZ7MtL0uBdhWDpNkqy89k84ucw4n
	mXiP3duMzbnPiPNyWCgAVOvjfq//l/7qZByLbbroun1JBFjcFTGbx0QgosejCt3rxy8Br9+Ll3t
	NBQ==
X-Google-Smtp-Source: AGHT+IHXAum89R+L84ez8ZLdeYXwHg5utst71NXVdIMIUYfKYaITD4P0qipj/L5juka0M2ylpFOroAjDd0c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3cc1:b0:6ea:c43c:a666 with SMTP id
 ln1-20020a056a003cc100b006eac43ca666mr112162pfb.6.1713916220080; Tue, 23 Apr
 2024 16:50:20 -0700 (PDT)
Date: Tue, 23 Apr 2024 16:50:18 -0700
In-Reply-To: <20240409133959.2888018-7-pgonda@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409133959.2888018-1-pgonda@google.com> <20240409133959.2888018-7-pgonda@google.com>
Message-ID: <ZihJOorvMU8GpUBN@google.com>
Subject: Re: [PATCH 6/6] Add ability for SEV-ES guests to use ucalls via GHCB
From: Sean Christopherson <seanjc@google.com>
To: Peter Gonda <pgonda@google.com>
Cc: linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 09, 2024, Peter Gonda wrote:
> Modifies ucall handling for SEV-ES VMs. 

Please follow the preferred changelog style as described in
Documentation/process/maintainer-kvm-x86.rst

> Instead of using an out instruction and storing the ucall pointer in RDI,
> SEV-ES guests use a outsb VMGEXIT to move the ucall pointer as the data.

Explain _why_.  After poking around, I think I agree that string I/O is the least
awful choice, but string I/O is generally unpleasant.  E.g. my initial reaction
to this
		addr = *(uint64_t *)((uint8_t *)(run) + run->io.data_offset);

was quite literally, "LOL, what?".

We could use MMIO, because there is no *real* instruction in the guest, it's all
make believe, i.e. there doesn't actually need to be MMIO anywhere.  But then we
need to define an address; it could simply be the ucall address, but then SEV-ES
ends up with a completely different flow then the regular magic I/O port.

The changelog should capture explain why string I/O was chosen over the "obvious"
alternatives so that readers and reviewers aren't left wondering why on earth
we *chose* to use string I/O.

> Allows for SEV-ES to use ucalls instead of relying the SEV-ES MSR based
> termination protocol.
> 
> Cc: Vishal Annapurve <vannapurve@google.com>
> Cc: Ackerley Tng <ackerleytng@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Carlos Bilbao <carlos.bilbao@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Peter Gonda <pgonda@google.com>
> ---
>  .../selftests/kvm/include/x86_64/sev.h        |  2 +
>  tools/testing/selftests/kvm/lib/x86_64/sev.c  | 67 ++++++++++++++++++-
>  .../testing/selftests/kvm/lib/x86_64/ucall.c  | 17 +++++
>  .../selftests/kvm/x86_64/sev_smoke_test.c     | 17 +----
>  4 files changed, 84 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
> index 691dc005e2a1..26447caccd40 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/sev.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
> @@ -109,4 +109,6 @@ static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
>  bool is_sev_enabled(void);
>  bool is_sev_es_enabled(void);
>  
> +void sev_es_ucall_port_write(uint32_t port, uint64_t data);
> +
>  #endif /* SELFTEST_KVM_SEV_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> index 5b3f0a8a931a..276477f2c2cf 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> @@ -8,11 +8,18 @@
>  #include "svm.h"
>  #include "svm_util.h"
>  
> +#define IOIO_TYPE_STR (1 << 2)
> +#define IOIO_SEG_DS (1 << 11 | 1 << 10)
> +#define IOIO_DATA_8 (1 << 4)
> +#define IOIO_REP (1 << 3)
> +
> +#define SW_EXIT_CODE_IOIO 0x7b
> +
>  struct ghcb_entry {
>  	struct ghcb ghcb;
>  
>  	/* Guest physical address of this GHCB. */
> -	void *gpa;
> +	uint64_t gpa;
>  
>  	/* Host virtual address of this struct. */
>  	struct ghcb_entry *hva;
> @@ -45,16 +52,22 @@ void ghcb_init(struct kvm_vm *vm)
>  	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
>  		entry = &hdr->ghcbs[i];
>  		entry->hva = entry;
> -		entry->gpa = addr_hva2gpa(vm, &entry->ghcb);
> +		entry->gpa = (uint64_t)addr_hva2gpa(vm, &entry->ghcb);
>  	}
>  
>  	write_guest_global(vm, ghcb_pool, (struct ghcb_header *)vaddr);
>  }
>  
> +static void sev_es_terminate(void)
> +{
> +	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
> +}
> +
>  static struct ghcb_entry *ghcb_alloc(void)
>  {
>  	return &ghcb_pool->ghcbs[0];
>  	struct ghcb_entry *entry;
> +	struct ghcb *ghcb;
>  	int i;
>  
>  	if (!ghcb_pool)
> @@ -63,12 +76,18 @@ static struct ghcb_entry *ghcb_alloc(void)
>  	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
>  		if (!test_and_set_bit(i, ghcb_pool->in_use)) {
>  			entry = &ghcb_pool->ghcbs[i];
> -			memset(&entry->ghcb, 0, sizeof(entry->ghcb));
> +			ghcb = &entry->ghcb;
> +
> +			memset(&ghcb, 0, sizeof(*ghcb));
> +			ghcb->ghcb_usage = 0;
> +			ghcb->protocol_version = 1;
> +
>  			return entry;
>  		}
>  	}
>  
>  ucall_failed:
> +	sev_es_terminate();
>  	return NULL;
>  }
>  
> @@ -200,3 +219,45 @@ bool is_sev_es_enabled(void)
>  	return is_sev_enabled() &&
>  	       rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED;
>  }
> +
> +static uint64_t setup_exitinfo1_portio(uint32_t port)
> +{
> +	uint64_t exitinfo1 = 0;
> +
> +	exitinfo1 |= IOIO_TYPE_STR;
> +	exitinfo1 |= ((port & 0xffff) << 16);
> +	exitinfo1 |= IOIO_SEG_DS;
> +	exitinfo1 |= IOIO_DATA_8;
> +	exitinfo1 |= IOIO_REP;
> +
> +	return exitinfo1;
> +}
> +
> +static void do_vmg_exit(uint64_t ghcb_gpa)
> +{
> +	wrmsr(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
> +	__asm__ __volatile__("rep; vmmcall");
> +}
> +
> +void sev_es_ucall_port_write(uint32_t port, uint64_t data)
> +{
> +	struct ghcb_entry *entry;
> +	struct ghcb *ghcb;
> +	const uint64_t exitinfo1 = setup_exitinfo1_portio(port);
> +
> +	entry = ghcb_alloc();
> +	ghcb = &entry->ghcb;
> +
> +	ghcb_set_sw_exit_code(ghcb, SW_EXIT_CODE_IOIO);
> +	ghcb_set_sw_exit_info_1(ghcb, exitinfo1);
> +	ghcb_set_sw_exit_info_2(ghcb, sizeof(data));
> +
> +	// Setup the SW Stratch buffer pointer.
> +	ghcb_set_sw_scratch(ghcb,
> +			    entry->gpa + offsetof(struct ghcb, shared_buffer));
> +	memcpy(&ghcb->shared_buffer, &data, sizeof(data));
> +
> +	do_vmg_exit(entry->gpa);
> +
> +	ghcb_free(entry);
> +}
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/ucall.c b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
> index 1265cecc7dd1..24da2f4316d8 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
> @@ -5,6 +5,8 @@
>   * Copyright (C) 2018, Red Hat, Inc.
>   */
>  #include "kvm_util.h"
> +#include "processor.h"
> +#include "sev.h"
>  
>  #define UCALL_PIO_PORT ((uint16_t)0x1000)
>  
> @@ -21,6 +23,10 @@ void ucall_arch_do_ucall(vm_vaddr_t uc)
>  #define HORRIFIC_L2_UCALL_CLOBBER_HACK	\
>  	"rcx", "rsi", "r8", "r9", "r10", "r11"
>  
> +	if (is_sev_es_enabled()) {

No curly braces needed.

> +		sev_es_ucall_port_write(UCALL_PIO_PORT, uc);
> +	}

This will clearly fall through to the standard IN, which I suspect is wrong and
only "works" because the only usage is a single GUEST_DONE(), i.e. no test
actually resumes to this point.

> +
>  	asm volatile("push %%rbp\n\t"
>  		     "push %%r15\n\t"
>  		     "push %%r14\n\t"
> @@ -48,8 +54,19 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
>  
>  	if (run->exit_reason == KVM_EXIT_IO && run->io.port == UCALL_PIO_PORT) {
>  		struct kvm_regs regs;
> +		uint64_t addr;
> +
> +		if (vcpu->vm->subtype == VM_SUBTYPE_SEV_ES) {
> +			TEST_ASSERT(

No Google3 style please.  I'm going to start charging folks for these violations.
I don't know _how_, but darn it, I'll find a way :-)

> +				run->io.count == 8 && run->io.size == 1,
> +				"SEV-ES ucall exit requires 8 byte string out\n");
> +
> +			addr = *(uint64_t *)((uint8_t *)(run) + run->io.data_offset);

Rather than this amazing bit of casting, I'm tempted to say we should add
kvm_vcpu_arch{} and then map the PIO page in vm_arch_vcpu_add().  Then this
is more sanely:

			return *(uint64_t *)vcpu->arch.pio);

where vcpu->arch.pio is a "void *".  At least, I think that would work?


> +			return (void *)addr;
> +		}
>  
>  		vcpu_regs_get(vcpu, &regs);
> +

Spurious whitespace.

