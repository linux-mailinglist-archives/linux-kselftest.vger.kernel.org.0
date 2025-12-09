Return-Path: <linux-kselftest+bounces-47338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6291ACB120E
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 22:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 629043009C2B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 21:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EB12EBBB4;
	Tue,  9 Dec 2025 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is12v/y4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53791261B9C;
	Tue,  9 Dec 2025 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765314847; cv=none; b=Cb8eisEDoE9wVtGEbCrpksM57ZfsXCweh96/XdI4pkPlEl32VETJuGitZ9OZPhvqSTpdePAzi/pJ7JyHLF8fG0xqLp5cnwv63YIxLzWlUWkr2TIz7UfECGC/1fdhZDh3OkyvYuZlTFUWhgQ7wHT56v9Hpm13Jvi3wNtVHSH3BDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765314847; c=relaxed/simple;
	bh=wrKMdhnv/lci1szVNE8yO/OkhzS84B5q7GQ6DcVQ5Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rF4Oau5vLvgx7BkGFa6HZUYbECkh6tLgvoyyukgEklbe2YlT7kz9On5LK1/khW2N5tP2abX1bQzRCki22HdAJBrG+7meyArEiBuAkYc5oUxDCEEI62fpVI5xO4/u1WncBrY5pW6MWSHFzsINJDrtFY7Efn5VX3jgqH3aA/9r1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is12v/y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766FCC4CEF5;
	Tue,  9 Dec 2025 21:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765314844;
	bh=wrKMdhnv/lci1szVNE8yO/OkhzS84B5q7GQ6DcVQ5Fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Is12v/y4WiB0S9HbOrzFDtXLS+fpcsdRBoEfwYav5vIK649imo3EuFfoAsHIUj6Iq
	 w6gfTsR9+O2/VfSPCSEdOJyw7LRgFbGph2Df+zVbPUBpKdPeVP0BJxSBld6Cv0JtOI
	 8IJCe9xvxDp/0XyhKE6DlPD+Ht0cm0kXoNGD1wKM1MigwvdB8zOt9sEXvm7QuAZBRo
	 HtoMgseVIOwaA48d2+Q7vbBeayHLraXGbB/XqkYsMpfACjIiZ/4Go3GRk1ArdANEhw
	 caGMdho5bNJ+H7KYK2SqHQvuAPtjco4gY+Yk+bDkhkj9vIt+LYgBVWcNffBHHqkYID
	 Cf5OrcOoYcpJw==
Date: Tue, 9 Dec 2025 13:14:03 -0800
From: Oliver Upton <oupton@kernel.org>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 12/24] KVM: arm64: Use physical PMSELR for PMXEVTYPER
 if partitioned
Message-ID: <aTiRG0I1FZzntHtH@kernel.org>
References: <20251209205121.1871534-1-coltonlewis@google.com>
 <20251209205121.1871534-13-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209205121.1871534-13-coltonlewis@google.com>

On Tue, Dec 09, 2025 at 08:51:09PM +0000, Colton Lewis wrote:
> Because PMXEVTYPER is trapped and PMSELR is not, it is not appropriate
> to use the virtual PMSELR register when it could be outdated and lead
> to an invalid write. Use the physical register when partitioned.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  arch/arm64/include/asm/arm_pmuv3.h | 7 ++++++-
>  arch/arm64/kvm/sys_regs.c          | 9 +++++++--
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
> index 27c4d6d47da31..60600f04b5902 100644
> --- a/arch/arm64/include/asm/arm_pmuv3.h
> +++ b/arch/arm64/include/asm/arm_pmuv3.h
> @@ -70,11 +70,16 @@ static inline u64 read_pmcr(void)
>  	return read_sysreg(pmcr_el0);
>  }
>  
> -static inline void write_pmselr(u32 val)
> +static inline void write_pmselr(u64 val)
>  {
>  	write_sysreg(val, pmselr_el0);
>  }
>  
> +static inline u64 read_pmselr(void)
> +{
> +	return read_sysreg(pmselr_el0);
> +}
> +
>  static inline void write_pmccntr(u64 val)
>  {
>  	write_sysreg(val, pmccntr_el0);
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 0c9596325519b..2e6d907fa8af2 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1199,14 +1199,19 @@ static bool writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct sys_reg_params
>  static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  			       const struct sys_reg_desc *r)
>  {
> -	u64 idx, reg;
> +	u64 idx, reg, pmselr;
>  
>  	if (pmu_access_el0_disabled(vcpu))
>  		return false;
>  
>  	if (r->CRn == 9 && r->CRm == 13 && r->Op2 == 1) {
>  		/* PMXEVTYPER_EL0 */
> -		idx = SYS_FIELD_GET(PMSELR_EL0, SEL, __vcpu_sys_reg(vcpu, PMSELR_EL0));
> +		if (kvm_vcpu_pmu_is_partitioned(vcpu))
> +			pmselr = read_pmselr();
> +		else
> +			pmselr = __vcpu_sys_reg(vcpu, PMSELR_EL0);

This isn't preemption safe. Nor should the "if (partitioned) do X else do Y" get
open-coded throughout the shop.

I would rather this be handled with a prepatory patch that provides
generic PMU register accessors to the rest of KVM (e.g.
vcpu_read_pmu_reg() / vcpu_write_pmu_reg()). Internally those helpers
can locate the vCPU's PMU registers (emulated, partitioned in-memory,
partitioned in-CPU).

Thanks,
Oliver

