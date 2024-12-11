Return-Path: <linux-kselftest+bounces-23188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 696FE9ED49D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 19:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FDD2810D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 18:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21EB20126B;
	Wed, 11 Dec 2024 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x1KBqYF4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B87201258
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941183; cv=none; b=IV2ipmsU9LBCaEreBJqB/dhzhCfLO44ucYq0irsWQM+Dad61icLtlL42950o48bWGy6bwUSvK7mPX1gSX0jIuPXb8AEmdTkwphQvz9Pip0joEafdIK2Lmx8D/8hh7qaRtM88Vra4h4xluDSMG7s24XLZSLTbml+1PXb/jQ3ta9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941183; c=relaxed/simple;
	bh=ZbCbmR5jMjwAnZZJyPRIhcuLAcSixii4vmbFPSCb34E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H4z3yBFL15YKfa64oCUZXk2dd7Ge/g9ZVQCPlOUWw9ojQ45Js3CvIC46Rle8Hn4bueRRxdJvG7xUMPP4kRtYrp+14SpbzgisvouyluWZCGoHVj3DN3vZAbQM/grLPuBG8cb4FHIQKZqUiZjkbAa3Hj6VxsqwfANYwG4GDTs74jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x1KBqYF4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso3713165a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 10:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733941182; x=1734545982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRvlwWxZGciZrSI2v4VPIECYyumLg4e7Uoks/odo7g8=;
        b=x1KBqYF4CpAI7Vlpul6bsyBLkkmzPiDAdJ2ueBbeUM3QdWkcplyYFvhUrekbehWxlb
         fBCAMBO5EQJgrtG24WoOertvLDPAP2p5ZCq4JRLckQPcxxkPPZ3LZeYMDjhippvl6NPF
         YaTsEGl/nGMALv6fmcWlWrgsht2jgsS5ugSBoJh93+29W9/PKuUh9ftsztKR81rUpGRB
         1jxX8PfiXxIIVq3LPTAfFMVJZgNGJXnMc3csPGOW8QG9C0aJjUw4dWaby7y1WMA6cM8k
         PvV5Syi7Lwo9Zp3LXZKmnBD2+6xf7L279Mny0f7BsHxRFDZy4xNuE0itUJ5s+1IH3ssn
         2uCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733941182; x=1734545982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRvlwWxZGciZrSI2v4VPIECYyumLg4e7Uoks/odo7g8=;
        b=l1ur0nu1n5nxd5rvzAOv4iGxjT6IxVNO8ygq2+JrAmAiUzSTlyW4ZtyF59qLeK0uTf
         wKMsUL775xBd2i7b3CPlPax1xH2FerCklqPZyscFV+KlTiX7ybpW2oRIJ8dVJXOHtL19
         2f3iJeff4gN6jE4aayW9zd2ZWgprz1+Tj60yP3fGRJ2Dzsm80LQhP3Dxw/AZYZx4c/vy
         67itdL+AhDoTlOKavQG1LC+G1/KfIFaasWtk/82YcG5LXSoCg20660bfpIfOL9ilho98
         lxwerTB+EA9fM8PlI/GXFbhAv2QJNv+M40/uVxQG8xwYSCa2dd7f9FmNk2g9D7kKXEw6
         ihUA==
X-Forwarded-Encrypted: i=1; AJvYcCWJHj4Iaes1ZAgDb0MBkiBsF0TgfwSc+4MSlogovLQHZbLz7FrljPsqwZL2DQkoXyVoEZpRCR2p6GMcm+0ZnSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJ5EcW7ocfQK7cu8+EHFIerm8EuCtZCxjBPrJAKt9LFZN2LTe
	2s72W2Lo5ud1SPNqCoM1/ATJiF0k69vGiZUYgMyafSKxDeRh/WfZnoSG//6tCRXffupy9jiA+8+
	K2w==
X-Google-Smtp-Source: AGHT+IGAQad98x+9buqedyejzr8w3DIDOOBuC1wPAHcLmV8x5kvdALMYM6oNb2Usre2fXUAEDTniyhyr28c=
X-Received: from pjbrr8.prod.google.com ([2002:a17:90b:2b48:b0:2e5:8726:a956])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d06:b0:2ee:c2df:5d30
 with SMTP id 98e67ed59e1d1-2f12808c011mr5454846a91.26.1733941181703; Wed, 11
 Dec 2024 10:19:41 -0800 (PST)
Date: Wed, 11 Dec 2024 10:19:40 -0800
In-Reply-To: <20241111102749.82761-7-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111102749.82761-1-iorlov@amazon.com> <20241111102749.82761-7-iorlov@amazon.com>
Message-ID: <Z1nXvL05VXShYpYR@google.com>
Subject: Re: [PATCH v2 6/6] selftests: KVM: Add test case for MMIO during vectoring
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, pdurrant@amazon.co.uk, 
	dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 11, 2024, Ivan Orlov wrote:
> Extend the 'set_memory_region_test' with a test case which covers the
> MMIO during vectoring error handling. The test case
> 
> 1) Sets an IDT descriptor base to point to an MMIO address
> 2) Generates a #GP in the guest
> 3) Verifies that we got a correct exit reason and suberror code
> 4) Verifies that we got a corrent reported GPA in internal.data[3]
> 
> Also, add a definition of non-canonical address to processor.h
> 
> Signed-off-by: Ivan Orlov <iorlov@amazon.com>
> ---
> V1 -> V2:
> - Get rid of pronouns, redundant comments and incorrect wording
> - Define noncanonical address in processor.h
> - Fix indentation and wrap lines at 80 columns
> 
>  .../selftests/kvm/include/x86_64/processor.h  |  2 +
>  .../selftests/kvm/set_memory_region_test.c    | 51 +++++++++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 1a60c99b5833..997df5003edb 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -1165,6 +1165,8 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector,
>  /* If a toddler were to say "abracadabra". */
>  #define KVM_EXCEPTION_MAGIC 0xabacadabaULL
>  
> +#define NONCANONICAL 0xaaaaaaaaaaaaaaaaull

Uber nit, I much prefer to place this definition at the top of the header.  More
specifically, it needs to not be in the middle of the selftest's exception fixup
code.

> +
>  /*
>   * KVM selftest exception fixup uses registers to coordinate with the exception
>   * handler, versus the kernel's in-memory tables and KVM-Unit-Tests's in-memory
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
> index a1c53cc854a5..d65a9f20aa1a 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -553,6 +553,56 @@ static void test_add_overlapping_private_memory_regions(void)
>  	close(memfd);
>  	kvm_vm_free(vm);
>  }
> +
> +static void guest_code_mmio_during_vectoring(void)
> +{
> +	const struct desc_ptr idt_desc = {
> +		.address = MEM_REGION_GPA,
> +		.size = 0xFFF,
> +	};
> +
> +	set_idt(&idt_desc);
> +
> +	/* Generate a #GP by dereferencing a non-canonical address */
> +	*((uint8_t *)NONCANONICAL) = 0x1;

Now I'm curious what happens if this uses vcpu_arch_put_guest(), i.e. if the
test forces KVM to emulate the write.

No action needed, the test is a-ok as-is.  I'm really just curious :-)

