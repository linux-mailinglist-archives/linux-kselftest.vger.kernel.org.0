Return-Path: <linux-kselftest+bounces-47339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E26E1CB128A
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 22:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98114301EDC8
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 21:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7BA30CDBD;
	Tue,  9 Dec 2025 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EE6P6mO9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CF32EBB89;
	Tue,  9 Dec 2025 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765315151; cv=none; b=TsJA+3E1uZgX60HbFoOLBhQ1uDyEsIEkx3HXX9Xl+mYS3yVBizh/t6emlhnYhlb5dJqEBYBGl/gO9YQpS6oAgsbdMiaEACu8xWnFKwuOT76SHlfZKPxh/e+nTaWULC0MN8cTPdEihrFSbC3ktXDZyLDLbnpe2tj8tbgKMQrL7l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765315151; c=relaxed/simple;
	bh=CT4qAWPdZvEtbycxJ4ObqKwT1R9e3YjH2bRTZc2PLgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMljfZ6fJ792AvZIvNfU9SIPdSRP/mma9BF8XtUk9w4gc21IZ3xHOp7VB1CQt1bBP7LrJJJs3k7N3Rz/qeGIMXU2gKtEde0XXWtO2Z8ASqF5f0ST1CzZDzQ8aYmZbDSdYl8Eh5aR2Zr7ic1QRUw1rHz3V1NLP0TOTeifRcdoOXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EE6P6mO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE793C4CEF5;
	Tue,  9 Dec 2025 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765315150;
	bh=CT4qAWPdZvEtbycxJ4ObqKwT1R9e3YjH2bRTZc2PLgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EE6P6mO9ijeLBkT6QwQgQBOQPIMu0fOqejSIn2W6QC83goR/f6/DbF6p9NEGTDkMJ
	 yJYGChp4TGWyt7//LRy8ByBf1/W8Ed6fyWTcvF0y7h+Czkxa8h5oknYj/PRc8ZvyCr
	 7jyKdtyEdkeWtKxuafUajHl6fw946IT03T29xXALsYPeFwxgj3bQ0+RTHxkOWO77cD
	 JRFS/80bRtk2VR4BOzfuxSAiARypvid3iiXmoEoZu69ERtoAIttvnD46jpgOrBn9aZ
	 ioaQ7YHObMsyDrNkJAPOGoOZtEsNJUyW+2IhlVVB/EsMiPn7HM0KH2i2+htaKtFDDx
	 qhc3pFLfQo5Rg==
Date: Tue, 9 Dec 2025 13:19:08 -0800
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
Subject: Re: [PATCH v5 13/24] KVM: arm64: Writethrough trapped PMOVS register
Message-ID: <aTiSTODjzaLzwAPN@kernel.org>
References: <20251209205121.1871534-1-coltonlewis@google.com>
 <20251209205121.1871534-14-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209205121.1871534-14-coltonlewis@google.com>

On Tue, Dec 09, 2025 at 08:51:10PM +0000, Colton Lewis wrote:
> Because PMOVS remains trapped, it needs to be written through when
> partitioned to affect PMU hardware when expected.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  arch/arm64/include/asm/arm_pmuv3.h | 10 ++++++++++
>  arch/arm64/kvm/sys_regs.c          | 17 ++++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
> index 60600f04b5902..3e25c0313263c 100644
> --- a/arch/arm64/include/asm/arm_pmuv3.h
> +++ b/arch/arm64/include/asm/arm_pmuv3.h
> @@ -140,6 +140,16 @@ static inline u64 read_pmicfiltr(void)
>  	return read_sysreg_s(SYS_PMICFILTR_EL0);
>  }
>  
> +static inline void write_pmovsset(u64 val)
> +{
> +	write_sysreg(val, pmovsset_el0);
> +}
> +
> +static inline u64 read_pmovsset(void)
> +{
> +	return read_sysreg(pmovsset_el0);
> +}
> +
>  static inline void write_pmovsclr(u64 val)
>  {
>  	write_sysreg(val, pmovsclr_el0);
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 2e6d907fa8af2..bee892db9ca8b 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1307,6 +1307,19 @@ static bool access_pminten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  	return true;
>  }
>  
> +static void writethrough_pmovs(struct kvm_vcpu *vcpu, struct sys_reg_params *p, bool set)
> +{
> +	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
> +
> +	if (set) {
> +		__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, |=, (p->regval & mask));
> +		write_pmovsset(p->regval & mask);
> +	} else {
> +		__vcpu_rmw_sys_reg(vcpu, PMOVSSET_EL0, &=, ~(p->regval & mask));
> +		write_pmovsclr(p->regval & mask);
> +	}

There's only ever a single canonical guest view of a register. Either it has
been loaded onto the CPU or it is in memory, writing the value to two
different locations is odd. What guarantees the guest context is on the
CPU currently? And what about preemption?

Thanks,
Oliver

