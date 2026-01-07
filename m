Return-Path: <linux-kselftest+bounces-48436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 040D4CFFDAE
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 20:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68C7D3135433
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 19:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED91336ECC;
	Wed,  7 Jan 2026 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vb/zgt2G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E2335BCC
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767813950; cv=pass; b=ByUdgTtRlOJ7cn50TekO3bYg1iIiqy3gmTVIO+fmTSRe4De5G8kIkxqnvmLpYrymYqn8gM3ECwbSEr4kZBEDbVNWwAOIeEf6LkwUla71MjxzauoA0cxDN6R2vuzMVYoO61GXCWvs2rWjLDWdi2MU2nuGOiVTKTXru5ORfpXAXHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767813950; c=relaxed/simple;
	bh=XVk3XmBWD63lnU/aMftVkJSiVIzcUinFUGBwW7jj1II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7x2OIa/GPOCLBNkweSGS4tGQ/kelkxunRSCPNK2JCtII//9hQOqASJuDbqwHNxEjUD7c5ehEjgjMhtMqvwrWUfGp2b3h5f5h3YhVqiiyPSKjHkXxhWft9UdR8ohEVh9qnR16qVlrE0nrP2I6CXAGkh0AYjuuEXdJzULZI23VWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vb/zgt2G; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ffbaaafac4so345961cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 11:25:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767813947; cv=none;
        d=google.com; s=arc-20240605;
        b=S/3LvXw9EcQUuTbsVYGHaFDME8ycxmtUIhUOxFDcUIep78BQ+9oeg/EtmcKytIeRRO
         GsBuK1rrODzaWCnsmVB0HBbqGvYUTeOd+I6wHRM0gdOrCLs8KK9gxz2dfjWL1w+XHQ/l
         otogLpUioA4hUDD4wLaJuXEY1o+TUxZ/r7omKD4BGwTZKOen0pVwdVtxV4seiy0kvjiO
         ZIMis/mIEdHYuXQY7RPWhHm9vonKWL5ultnDx/wu//pV4QEz8Z6rv1/war0N/sNAolcR
         M8cea/7TOfqJrhH9vac4DtjgauCVjfb03rwLEJXhzgdOEUMFlLqyZ80ySDeYmLGszCpm
         H7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UL7Yi7Pvtp9vnv6DWf8Vlg3AdoCOpm+T6/ZVSqpBols=;
        fh=bChyO50poPs54ZPq1TKwqudV+ppDQO5Qx8sZ0TK3BoQ=;
        b=hv1SLlIIhah2N2EZUXwpOr8Fzy0uuUoBtgSU0cLDiZGDEGWpzfKiofmxMCel+7+Sli
         O3aBCWARnsV9o3JMapyWUWwUriNiALzQL13vW7YIHrhqUu/hvFj3b779hPcYe/uAlEhR
         UFIGCFTstUduyugfmyacrIJ5zz1piQcR4nlfPcsOcBRKXFHz2f47wzdWOhETHydtTX8I
         hog0D92KEYzCUQ0Zc7FOoLhMJxbQ9E1No1TW5zPJht1Klw0bshyBtiRd9xQG29csQUrX
         3IcyU2lYR2ztVbvhqsQxjT7kbeax4MZtZf11n1AKbRw04GohoTi1OyK2av/tN/M7B7Pt
         K4Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767813947; x=1768418747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UL7Yi7Pvtp9vnv6DWf8Vlg3AdoCOpm+T6/ZVSqpBols=;
        b=vb/zgt2GG47urxvxxevKpvOW+IAD7RIRDvojxsHb6lvtHrLhG6VtC7Gt6NefY05n5D
         LgQ2NPPlTDlywlfrjZRE9+GsUlo76FPqlVaMKS6ApHyZz3Nwwlg2Nbk1qljgS2q2Jjt3
         uoxwK9LFmWb96uBzza/SiOrtwy65hnIrl1X4hDGMz7QKEOhPIhOUUSU96mAbbt1gFjsw
         pePkJRCDsj9FVplxz45v+CTQj7LUifAtrAY4zMTBwDgvl0pxtreeQlJclWvBf88A5Hdp
         QKUBsXJcnhdNetgn1H5MT8Lm33LUFvmeKPGp1XDnnGSD2OHW3jRpqcscftt6S2NvHcdm
         YBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767813947; x=1768418747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UL7Yi7Pvtp9vnv6DWf8Vlg3AdoCOpm+T6/ZVSqpBols=;
        b=ZPQKU25T3D3NdI8eiSQNa+TJ5309CoRJMSeaHdXXjCmAtj+0siuOXc3TxYk3Q/PX6w
         DeylO8GbvM2jzwWf6Jb/JMWEVJz609BERvG8+sP46j0TWPOxfH7yqag/27xe7j1dIWPY
         ct0YEJAsDxq1GFEVqGgulOJbAMxHF8teBOnT3aNFQdD/CL7SHHzT/wZwFt4Gs5AJG9i2
         yd8cJCBCBFUZeIQZd7zRouiBOwB9mZZx1NbTM0Gfx0cxZ1mIIG/Yh37mywsV6XtOG1Xj
         6Y1/0YCQuxgxa7Nu45IYhJ/olGRRr8dNmqY+GfZo3jkyUN8QiWWWgK8yMYQkujvufyuS
         FYqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTGGIxMr4r5gKsIdB3Y/jSI8GZ82EjrdEwf4d9fZZ60o696qG1y8Gz4bsd7NBsU3erWiRHPO+8rDduX17ctrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM/1Ru30bk52TIEjjPak9Wp0dbXbduDAiDwIjxG8DyM5qM2eks
	rcPtHrY6guaHmvYsFFh6N1y1OkTa7CuZYRPohzUoLlmUSx87TSDLylpqYFsNuOxpNJVqkf3wReS
	iBEKG1mmZMS8KDvsz+/w/jiZKzceuMpCFtoISRAUW
X-Gm-Gg: AY/fxX4Zy6kuInRJ84u0UeHv1JVK4XNcwPnrxXkSTUwCtg9XcK6xyk3lS9lGzYJMYtv
	uivvWofiKOgtQtdJ6WPZA7VQTUe3Vm7O4qP134t/nGu2t4nPmxRtJlTkRQ7AUIgKwlgkpgSA4x4
	Gwi+86ezWHU7c5t9ZHj08WU3vecjJ+jSmKl7GLePC+XAH1vVvBcfSrHLpe77w0pttwMgV3S58bN
	4PR/B1wijl/piJ6s9+dShWsr+G+715oJiZ/wPatjH3/xAqkVsbRvodvTDg7nKWmLg7akIAriTiC
	BRF/juY=
X-Received: by 2002:ac8:5755:0:b0:4f1:a61a:1e8 with SMTP id
 d75a77b69052e-4ffb3e21616mr16125611cf.10.1767813946629; Wed, 07 Jan 2026
 11:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-3-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-3-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 7 Jan 2026 19:25:09 +0000
X-Gm-Features: AQt7F2qG7tZNiD_FEqhIhHEVb7oMgUHIgaIXPRg8ASWrsWZrjE8qelJTJPBe6w8
Message-ID: <CA+EHjTyZg=WH4GmAXzmNroAPVtRUM=LMvNWc38S4_Oh7UQi78w@mail.gmail.com>
Subject: Re: [PATCH v9 03/30] arm64/fpsimd: Decide to save ZT0 and streaming
 mode FFR at bind time
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, Dave Martin <Dave.Martin@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>, 
	Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Dec 2025 at 01:21, Mark Brown <broonie@kernel.org> wrote:
>
> Some parts of the SME state are optional, enabled by additional features
> on top of the base FEAT_SME and controlled with enable bits in SMCR_ELx. We
> unconditionally enable these for the host but for KVM we will allow the
> feature set exposed to guests to be restricted by the VMM. These are the
> FFR register (FEAT_SME_FA64) and ZT0 (FEAT_SME2).
>
> We defer saving of guest floating point state for non-protected guests to
> the host kernel. We also want to avoid having to reconfigure the guest
> floating point state if nothing used the floating point state while running
> the host. If the guest was running with the optional features disabled then
> traps will be enabled for them so the host kernel will need to skip
> accessing that state when saving state for the guest.
>
> Support this by moving the decision about saving this state to the point
> where we bind floating point state to the CPU, adding a new variable to
> the cpu_fp_state which uses the enable bits in SMCR_ELx to flag which
> features are enabled.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> ---
>  arch/arm64/include/asm/fpsimd.h |  1 +
>  arch/arm64/kernel/fpsimd.c      | 10 ++++++++--
>  arch/arm64/kvm/fpsimd.c         |  1 +
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index ece65061dea0..146c1af55e22 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -87,6 +87,7 @@ struct cpu_fp_state {
>         void *sme_state;
>         u64 *svcr;
>         u64 *fpmr;
> +       u64 sme_features;
>         unsigned int sve_vl;
>         unsigned int sme_vl;
>         enum fp_type *fp_type;
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index be4499ff6498..887fce177c92 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -490,12 +490,12 @@ static void fpsimd_save_user_state(void)
>
>                 if (*svcr & SVCR_ZA_MASK)
>                         sme_save_state(last->sme_state,
> -                                      system_supports_sme2());
> +                                      last->sme_features & SMCR_ELx_EZT0);
>
>                 /* If we are in streaming mode override regular SVE. */
>                 if (*svcr & SVCR_SM_MASK) {
>                         save_sve_regs = true;
> -                       save_ffr = system_supports_fa64();
> +                       save_ffr = last->sme_features & SMCR_ELx_FA64;
>                         vl = last->sme_vl;
>                 }
>         }
> @@ -1671,6 +1671,12 @@ static void fpsimd_bind_task_to_cpu(void)
>         last->to_save = FP_STATE_CURRENT;
>         current->thread.fpsimd_cpu = smp_processor_id();
>
> +       last->sme_features = 0;
> +       if (system_supports_fa64())
> +               last->sme_features |= SMCR_ELx_FA64;
> +       if (system_supports_sme2())
> +               last->sme_features |= SMCR_ELx_EZT0;
> +
>         /*
>          * Toggle SVE and SME trapping for userspace if needed, these
>          * are serialsied by ret_to_user().
> diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
> index 15e17aca1dec..9158353d8be3 100644
> --- a/arch/arm64/kvm/fpsimd.c
> +++ b/arch/arm64/kvm/fpsimd.c
> @@ -80,6 +80,7 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
>                 fp_state.svcr = __ctxt_sys_reg(&vcpu->arch.ctxt, SVCR);
>                 fp_state.fpmr = __ctxt_sys_reg(&vcpu->arch.ctxt, FPMR);
>                 fp_state.fp_type = &vcpu->arch.fp_type;
> +               fp_state.sme_features = 0;
>
>                 if (vcpu_has_sve(vcpu))
>                         fp_state.to_save = FP_STATE_SVE;
>
> --
> 2.47.3
>

