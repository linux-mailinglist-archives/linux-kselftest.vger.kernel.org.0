Return-Path: <linux-kselftest+bounces-48786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0B6D14DD9
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 20:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A65530321EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 19:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF1F3128D2;
	Mon, 12 Jan 2026 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1TkGW3R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AD7311C38
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244965; cv=pass; b=ce2eiTnIejXgaobYeS1qC2uPHJb+qmhMKwbxlxBBKNqhrfNMIBaBH9HUAgkCtpX7mf8NUT/iKhLPD2/KxOp+PM3Ks2lCwULq5q4njNzpK8O735i37+a+VwIHG74O43E/83ie/bwxNB2sAGgKQqOWWWfJ3Jerwy5ijOnQu95ywDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244965; c=relaxed/simple;
	bh=xheA9QOjQXvJoAbTTZVMmFI6y8wl+wMqp+t7iExkGCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pI1u/GNu+5FLM/B5erI3qP+AyT31EcntjgV6+0xdbbhZSYtriBCiImkq3rA7AOMNcc3W2Y6ABQzLWQujTQuoWrMLH5g9dpKP2unKsYtGEFnPQG+wsDqF1plf1C8ml4xsI2MEKthSbY9F2/KvmSXEznP1DKSEyB2j5fKyRXgKOjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1TkGW3R; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee147baf7bso30151cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 11:09:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768244962; cv=none;
        d=google.com; s=arc-20240605;
        b=VRXu1FarH3IG3FGWV1wyAtbVRNb8+ofcEMaXQKlSKNbgxGjcR6LV7dsfbKcunIzHP4
         fQPStoOPL2utrMFaMRJb6SQUe4q10/9c4bODif/XIZndg6BmEudFE1YMtCyE7Wn532X3
         zOXVrzDhqrE0mAvNCmizURA7TLyQ6e2cpIofjBjJerZQzRkVuUxhTwnDN9YhNcSmgMtG
         nHfRPcnqvyefInxWoP3j/FbUXzpHgSNEUbQTTDznbtwdQUCIkCh1pNRDWQnd0sVlr8ln
         3hLna6ACRBzHcsBUNDKzMd/pOFQvUpuvhW73Wp0PpTqgg5txVALgxdQ2bPqiccCbdWij
         xASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CI3Qkkbb89cv5bbaE9HcvbYXyBW2GfCAOd3nwRVqS/M=;
        fh=ehYwiw6QGZ5g21dAWFSxy18vaBMYQzeM9fDIf34n7mg=;
        b=Fxl0xj+OBrviGGetYxHiyhj1ATdkeCEac3JQTwkjsAONvx0ojDGcilgD7Y0K0b9YKN
         NFHrsnxtAyGcV7ijgnkrqn+XvY4Y0nkV1PocxoOmQWNPYaR2dzDaoUP+On9yDTzX3EYs
         KqSZaf3O+6guv0U6B/scwn4Ofy59XnO2kd0kShyokAw1QbjCHllBq0BAJ5tCLGkL4FTy
         yKj4ylbzkIKgw7gQYuOwRF0sbxHqD6rbw66XYUL8CEQow/LZnzNUVOguigrLT1WU6cF7
         2tZfu/FziivOVHSDXqspiqhGrFYTPCUwJdaXqducBUymVrNs/vDEr5rwWYaxWzp+UNPE
         UPkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768244962; x=1768849762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CI3Qkkbb89cv5bbaE9HcvbYXyBW2GfCAOd3nwRVqS/M=;
        b=U1TkGW3R2x+Jm1Pqun+QQoL77XNSM9nOE+Fz+CrfJ93zk0CE7+AJwyG98eqiZmyiej
         L9KNXhyjWHI5cayiwuTkfCGdFUg7mDGoQcKiKKbskcsjbhY+r10zKCoFmkWjT8DMWPlS
         rPlU+ORQYeoGommPU8tNnoL6uPjteH3Uz3B3Mj/57WWR6/CNrBfp6hHXQ9P+EFdlAAV6
         WcsBWaiDdpwin02CD4Zq50j4qZU7/M+QfcguzRufpcImsoCsqAyOSnl9z9OY825EtGaO
         bb1MwRlr5G2xLxwYbJgx5t61IdQwipA+NrmEfZvfyvIM66HgJRffSjO3mkPBAu0M8zgh
         vmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768244962; x=1768849762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI3Qkkbb89cv5bbaE9HcvbYXyBW2GfCAOd3nwRVqS/M=;
        b=KahQCCCeFqcuzXtXy5tgZq4f5IqhH7FIFRx4um7sN0X9xURp4hFyr0EcmZweOGs9Tp
         EaTbBjnPAF5SAy9EwSn0G1/Iy+zhtjCI3Xk38C1iF501oOq9xTmfzklhy+xQvgPjmJIa
         jDdvVDPy205BwMNLAm5QKy4Djb5e5YZOtuifPh53QmEiO0THj2YsQpGBy5MukQpsKuJ/
         kBGem2LNdL4PoY+sGOkhx1vbwtTPIgUURZobS+naAQfWZvPrBrU6/ZGux0BdiRz2Yn7Q
         cuiIpLkfQ9/snGPvLY4DakSEPewWGLOf+ThWJamnOxDpxYtYvHlK6sk+F+xeUqLLf1WS
         Nn5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPMyrHPR8mm6plFKiVL4mrH+RnngKhJnSHuP6Tja9gA6u3uruc0LPl4DTeAe/1AmaozFn1IiuWYfJx+WtbWu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy15s0V60/cKKAvxd6cG9syiBHQYcq7NhgRZHlZLPHIwiKb5yFY
	K52j/ejBxrCMg+/oHVjQmP3XLlIh7SAoffGeGqto71bJuP/1QAh4w+pONNcpjuLfEqsFSjIzcI8
	df9zMMWKt/pAfHLFdV3tCuFgUBG+3UYe8ZsCmri1L
X-Gm-Gg: AY/fxX6pcvzJPIGTIKbhjWh1HWqfvyhjJyIxx+7h8HG0MDoOKT5IghBV6pBuslFjEPy
	M+mVPe2cOE+2bYFPSUDeRs5UQ5UGFqlQtm1OWK6F68gZpdCrbrZD9Le+y1hAfBFMkVHK8M26RFN
	+8O00RfMVHuY2OgwwGplnXQIMCk1RuLiMxo2o28tKA8a3AiLgj7S30GDViQLyuGq6ryBJT8tELY
	PkC2FuO5Y3Rp4bws4Hzgx527MD6ERvVhMNMOw8WbMqXzOQzJoX20PiiHXo6UviCR4RgMpLw
X-Received: by 2002:ac8:5d42:0:b0:4f1:9c6e:cf1c with SMTP id
 d75a77b69052e-5013a41792cmr752671cf.17.1768244961509; Mon, 12 Jan 2026
 11:09:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-21-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-21-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 12 Jan 2026 19:08:00 +0000
X-Gm-Features: AZwV_Qjgu-sXQZIHm3TAlOW62aUWk-t7wcra038ZJt2_3BJ_d28PSVA3xv4zVCM
Message-ID: <CA+EHjTz4vDFdhbZMz6mNacdzSJLFfVbQKMGmSo=Vt9bSB4ho0Q@mail.gmail.com>
Subject: Re: [PATCH v9 21/30] KVM: arm64: Flush register state on writes to
 SVCR.SM and SVCR.ZA
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

On Tue, 23 Dec 2025 at 01:23, Mark Brown <broonie@kernel.org> wrote:
>
> Writes to the physical SVCR.SM and SVCR.ZA change the state of PSTATE.SM
> and PSTATE.ZA, causing other floating point state to reset. Emulate this
> behaviour for writes done via the KVM userspace ABI.
>
> Setting PSTATE.ZA to 1 causes ZA and ZT0 to be reset to 0, these are stored
> in sme_state. Setting PSTATE.ZA to 0 causes ZA and ZT0 to become inaccesible
> so no reset is needed.

nit: inaccesible -> inaccessible

>
> Any change in PSTATE.SM causes the V, Z, P, FFR and FPMR registers to be
> reset to 0 and FPSR to be reset to 0x800009f.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h | 24 ++++++++++++++++++++++++
>  arch/arm64/kvm/sys_regs.c         | 29 ++++++++++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 44595a789a97..bd7a9a4efbc3 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -1147,6 +1147,30 @@ struct kvm_vcpu_arch {
>
>  #define vcpu_sve_state_size(vcpu) sve_state_size_from_vl((vcpu)->arch.max_vl[ARM64_VEC_SVE])
>
> +#define vcpu_sme_state(vcpu) (kern_hyp_va((vcpu)->arch.sme_state))
> +
> +#define sme_state_size_from_vl(vl, sme2) ({                            \
> +       size_t __size_ret;                                              \
> +       unsigned int __vq;                                              \
> +                                                                       \
> +       if (WARN_ON(!sve_vl_valid(vl))) {                               \
> +               __size_ret = 0;                                         \
> +       } else {                                                        \
> +               __vq = sve_vq_from_vl(vl);                              \
> +               __size_ret = ZA_SIG_REGS_SIZE(__vq);                    \
> +               if (sme2)                                               \
> +                       __size_ret += ZT_SIG_REG_SIZE;                  \
> +       }                                                               \
> +                                                                       \
> +       __size_ret;                                                     \
> +})
> +
> +#define vcpu_sme_state_size(vcpu) ({                                   \
> +       unsigned long __vl;                                             \
> +       __vl = (vcpu)->arch.max_vl[ARM64_VEC_SME];                      \
> +       sme_state_size_from_vl(__vl, vcpu_has_sme2(vcpu));              \
> +})
> +
>  /*
>   * Only use __vcpu_sys_reg/ctxt_sys_reg if you know you want the
>   * memory backed version of a register, and not the one most recently
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 51f175bbe8d1..4ecfcb0af24c 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -927,6 +927,33 @@ static unsigned int hidden_visibility(const struct kvm_vcpu *vcpu,
>         return REG_HIDDEN;
>  }
>
> +static int set_svcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
> +                   u64 val)
> +{
> +       u64 old = __vcpu_sys_reg(vcpu, rd->reg);
> +
> +       if (val & SVCR_RES0)
> +               return -EINVAL;
> +
> +       if ((val & SVCR_ZA) && !(old & SVCR_ZA) && vcpu->arch.sme_state)
> +               memset(vcpu->arch.sme_state, 0, vcpu_sme_state_size(vcpu));
> +
> +       if ((val & SVCR_SM) != (old & SVCR_SM)) {
> +               memset(vcpu->arch.ctxt.fp_regs.vregs, 0,
> +                      sizeof(vcpu->arch.ctxt.fp_regs.vregs));
> +
> +               if (vcpu->arch.sve_state)
> +                       memset(vcpu->arch.sve_state, 0,
> +                              vcpu_sve_state_size(vcpu));

If sve_state isn't allocated, this means that we've gotten here before
finalization. Is it better to return an error rather than silently
skipping this?

> +
> +               __vcpu_assign_sys_reg(vcpu, FPMR, 0);
> +               vcpu->arch.ctxt.fp_regs.fpsr = 0x800009f;

This matches the Arm Arm, but can we use a define or construct it,
rather than using a magic number?

Cheers,
/fuad


> +       }
> +
> +       __vcpu_assign_sys_reg(vcpu, rd->reg, val);
> +       return 0;
> +}
> +
>  static unsigned int pmu_visibility(const struct kvm_vcpu *vcpu,
>                                    const struct sys_reg_desc *r)
>  {
> @@ -3512,7 +3539,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>                     CTR_EL0_DminLine_MASK |
>                     CTR_EL0_L1Ip_MASK |
>                     CTR_EL0_IminLine_MASK),
> -       { SYS_DESC(SYS_SVCR), undef_access, reset_val, SVCR, 0, .visibility = sme_visibility  },
> +       { SYS_DESC(SYS_SVCR), undef_access, reset_val, SVCR, 0, .visibility = sme_visibility, .set_user = set_svcr },
>         { SYS_DESC(SYS_FPMR), undef_access, reset_val, FPMR, 0, .visibility = fp8_visibility },
>
>         { PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,
>
> --
> 2.47.3
>

