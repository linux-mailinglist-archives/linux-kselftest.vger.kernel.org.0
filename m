Return-Path: <linux-kselftest+bounces-7273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29249899C53
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 14:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5921C21028
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A77C16C6B1;
	Fri,  5 Apr 2024 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="L8E6eR8K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503D16C68C
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318709; cv=none; b=g24b6ANILHduoyuUHUpHCCYKvSVXe+GY9l+JAikRjaauZI+yhOY6iL6bC+A4+0Pu3iPTcm+zTRx8BU8AscOUTKnI/eeAEc+gaL9Jm/jivmrqzf2nx0BOZ7rb8KwJKQoYJEfOGGTFT1mir/7sjdzB90KlXvwy3IUYqLgn6n7JdvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318709; c=relaxed/simple;
	bh=80HGX1rBfdkCbl1leKPRwW3VkQK8pthaXxSNoatku0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHrg3n2y37vzwp1WCNPlRO8jNbUDMjB1ur4CDqzqFhyyhLjSTcLVFu6RJ6+a3LLkUhFZRqXgD4hwA9xOz3VVYW+alKCUHJWfDZsLgw/9hF7OOAzPnExnorSc9TyCrRZI4MuuwnCyaHAb344MVksHlQ+V2VjLiMiFjT59bnVoNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=L8E6eR8K; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a51ae869113so10919066b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 05:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712318706; x=1712923506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANigKjFKB20C56QgtDtNKw9YzFML+UBbBswsTMHl8ws=;
        b=L8E6eR8KrGH/smO9HW2Ibf3e2We+nq/F+KKakxicXZAaxFlph//AGSueTke3lZ3KZS
         NvUD6O3gvrKAjI9WI0qWdb93QhyWYS0KtVRG2okPK41VdiH6kqflu27e7zbIGCZsUJjh
         sZbO0m9eRrF2fXxAq4jXrwQXNrALN+8urj9T+rLYChb57eNkhOuE1fybIBn31XXocCRt
         7mAizkIUROzrZQAOsHdtkW1pIxkO8IYamMz63u6Ug8lmsL9qo2vXVkCfGekpuu9L7ua3
         O0bZjqGFo3sSLxZi+y62f5F8UfMVKz68E0lGWt40oFuqK1PDj7dY5zHptfcnI71lYU2U
         iAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712318706; x=1712923506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANigKjFKB20C56QgtDtNKw9YzFML+UBbBswsTMHl8ws=;
        b=q+cTOwS7NFzpqfcYwdR1VC96BtFswd/vs4tzopew6aT1jJKBGhROZAzL4SUGlVMBJX
         HH3tQqWfjVRSY/2oDn6hCbQZKvQKaYYs0hyGYQd+N5nABJRN4A9p7nBmDrop6dnAXg2z
         dCy6gRCQUKssKKFH6Ub0Tsl+FisqtkwR7eRk558gfmHbMBkyg0zOxOthDDUAhkcp2e9k
         f56zg9O6sJMoFwEdAyMDCzE9Xdin32b2t9Mt1z+xncGaexADjevqN1ysk0Pu1aHBykHT
         plhIY0cZpGHIWRhF8SBkyj0VcGnijKyEsXcDJGScCR3kSur2iJ3s62Gj8dtzN0xntiNl
         8O3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVC9qxyB6Ek2YWdTipuovVYZ+v6fZgvcHdaLokx2zDLddPr6Ti/GsIL2ZsjsOgivVgd4IKxz4TI1gs1D29O8qyl2jzqADOf9QEcaOVpo2Lw
X-Gm-Message-State: AOJu0YyLidzS5hAsHhNKYlpF41RNB3YD5h7Fcwa2fAQxaoNpqB6PNM5g
	C/U/ymuY5Kj0XoWwomvOrKLDgnWzAIzxT0PUR/IdA2UiOhnqfi55Y+/7C2z0dSk=
X-Google-Smtp-Source: AGHT+IESMNgkqXbtafANGbo2BARFo6uXoCxR7/FEaBsi9GwxuDZftgiVL+fjv6uvWjEhvAUc6QG2Uw==
X-Received: by 2002:a17:907:6d20:b0:a4e:48d6:b9d7 with SMTP id sa32-20020a1709076d2000b00a4e48d6b9d7mr1342167ejc.56.1712318706052;
        Fri, 05 Apr 2024 05:05:06 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id hd6-20020a170907968600b00a46da83f7fdsm763981ejc.145.2024.04.05.05.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 05:05:05 -0700 (PDT)
Date: Fri, 5 Apr 2024 14:05:04 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Atish Patra <atishp@atishpatra.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 09/15] RISC-V: KVM: Add perf sampling support for
 guests
Message-ID: <20240405-de92b25fdc1ecf53770c49d9@orel>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-10-atishp@rivosinc.com>
 <20240302-f9732d962e5f7c7760059f2e@orel>
 <c46c57c2-95bc-4289-ac99-efd5bad093b5@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c46c57c2-95bc-4289-ac99-efd5bad093b5@rivosinc.com>

On Tue, Apr 02, 2024 at 01:33:10AM -0700, Atish Patra wrote:
...
> > but it should be possible for the VMM to disable this extension in the
> > guest. We just need to change all the checks in KVM of the host's ISA
> > for RISCV_ISA_EXT_SSCOFPMF to checking the guest's ISA instead. Maybe
> > it's not worth it, though, if the guest PMU isn't useful without overflow.
> > But, sometimes it's nice to be able to disable stuff for debug and
> > workarounds.
> > 
> 
> As per my understanding, kvm_riscv_vcpu_isa_disable_allowed only returns
> true for those extensions which can be disabled architecturally.

I think kvm_riscv_vcpu_isa_disable_allowed can return true for any
extensions that KVM can guarantee won't be exposed in any way to the
guest. Extensions that cannot be disabled architecturally must return
false, since their instructions will still be present in the guest, even
if KVM doesn't want to expose them, but extensions which KVM emulates
can return true because KVM can choose not to emulate them. IIUC, sscofpmf
falls in this latter category.

> 
> VMM can still disable any extension by not adding to the device tree.
> In fact, that's how kvmtool can disable sstc or sscofpmf with
> --disable-<isa-ext command>.
> 
> The warning is bit confused though.
> 
> For example: if you run kvmtool with --disable-sstc
> 
> "Warning: Failed to disable sstc ISA exension"

I think Sstc should allow disabling since it has a corresponding henvcfg
bit which KVM could not set in order to force accesses to the Sstc CSRs
to raise ILL exceptions. So, let's put Sstc aside, since it's not a good
example. An extension like Zihintpause, OTOH, cannot be disabled since
the 'pause' instruction will be present even if KVM does not put
Zihintpause in the guest's ISA string. If a kvmtool user uses
--disable-zihintpause, then I think this warning about failing to disable
the extension is appropriate.

> 
> But sstc is disabled: Here is the cpuinfo output.
> # cat /proc/cpuinfo
> processor       : 0
> hart            : 0
> isa             : rv64imafdc_zicbom_zicboz_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zfa_zba_zbb_zbc_zbs_smstateen_sscofpmf
> mmu             : sv57
> mvendorid       : 0x0
> marchid         : 0x0
> mimpid          : 0x0
> hart isa        : rv64imafdc_zicbom_zicboz_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zfa_zba_zbb_zbc_zbs_smstateen_sscofpmf

Removing from the ISA string is the best we can do in cases like
Zihintpause, and is likely good enough for well-behaved guests, but the
VMM's warning to the user is good for these cases too, since not all
guests are well-behaved.

Thanks,
drew

