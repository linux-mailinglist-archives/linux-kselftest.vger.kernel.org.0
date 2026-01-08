Return-Path: <linux-kselftest+bounces-48516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99828D03732
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 15:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEA4332D8D23
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 14:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889724B9E5F;
	Thu,  8 Jan 2026 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hh+edRsd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA1B4ABFC0
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881430; cv=pass; b=PL0Z6PUPBw4s53dReSCLuEjOCSwX4ahczfc0bWf39hwPII2hXMl0SeG6riAnHhsR5RvHY9p31gFcvZd/sKmkQguxHILSmJ1LccwgnSvchX7A+8/RmiHxC+o6yMBpd1lXfXu5zRCyZjSgX/M7+DJv6f8tigVcWt44wLYkkG4Y7ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881430; c=relaxed/simple;
	bh=6s+1Fa+lgma2W6VO//e9W/EKZ99EnAtWNWD0KjYryo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3ciWbqh15rNN13VHpeMQQLub0ntbmVFQB/4q6qnTDW7ikmhdV1rFRMZ0IdrXuBPwfcvplNp274OCVCCQqpUoPp8td6vD3cHrQF1o3+lXDqeP1OSza1lXLh3Q3p7E4eWoIfnAYBFL4K+8pvlKzHdk/K4vQGMgCqOd8Fo5juhdw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hh+edRsd; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4edb8d6e98aso1158381cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 06:10:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767881427; cv=none;
        d=google.com; s=arc-20240605;
        b=cGqk1YHUwsD5tQJHaU9szLi9lKvsS4FQF4N15yloNbmcWjAfWTG1Rzk8DVbyU2TIV9
         aiN8Phs3NGtUuI2btfoj6fKNJ1cjemXPRTy6unYODss1UwWjkYcDciRjetqYDJRzdj7E
         KyboUaHwUQfBac6jwyLKSIWgrXcZ5ryDToh7LVhLN/QEaAU7O3uvlS2i7hr8LziGXn+p
         /T4siLd/49xCxa+Yqp4ZXNIFs5K6M8otXLw8CQ+AWzPeiYDMrcE/FHvd7TQTZS7NPAct
         S1AiNsO+UDK404Kd84O8VGlVg9E2azmbPZsZjQ6bDQk8+2Lzb1QlqyjWXThwQILNvFpB
         pW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UkFBVVF2FUVuKrFgmcHW8CUldvJtVwVqevSTZGxcxL0=;
        fh=wN7JJ1xuR7N+EcWn+tv8MOJutzbmmfzURlsPhBPjOio=;
        b=bd2wD75JvHOpA08MkLjwCgvnYSj6P6WzZ2utY3n+ezdaQ6SsrqmLs2SmDrc1SdIiBq
         3yRVNkmFuOLG7Op/ObFvrnz5QHfFGtv5/ss+yke3zsNxx21CX0+Ml+bkRqrhHpyXe0rw
         g96OTNSpXI++Zxs2oa9yDEdUkBZlG9hiq/X2fkVHYUgZ3B1PVf6zGjKTdn5OgPswoC2x
         JrmTR8ZdhkRWf9a2utTIA0+fBwwrh2uJe2CmtxzzyLhKzbqsL1nAgGABCfJm1Qag9HZ5
         JHhJBObyXHeEnccW0kmLt2hZ6bNGGOS4OYvejPoETl7mLdFmMZdyLdKMP91VM1IVsyDg
         Ehxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767881427; x=1768486227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UkFBVVF2FUVuKrFgmcHW8CUldvJtVwVqevSTZGxcxL0=;
        b=hh+edRsdP3j8FirfLiyEGrzOOXApW88U+v02QYWE5AV+tspa/pUm0oPm2EnxRQ+E6h
         QW4ucjynddmBipIgLDIXu4/CCUKDoFB8gHMsOdRYtT2bXy3+Ri3CAL/hxf9XMsLTiBr6
         OWbmMXnkdmF1TbddIf52CIftJ7VwuHOaAVmxCNMeDbXyVXD0kL1+XVOBNSHF6rjjz9bX
         LLo59wasQtkhD0QQqjeG96GJGVlL/eV26LzzQ/lTwj4kY5K6FYYYImicoyoyWwB/PmNU
         ECV8p92C0RDkSBloU3DBjN9PdlfKTticCX+3dLI/mlCHj4+SB6nT25+0Ir6ara6oI98s
         mTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881427; x=1768486227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkFBVVF2FUVuKrFgmcHW8CUldvJtVwVqevSTZGxcxL0=;
        b=YKUhGq0YAL96QORC7xc4yomuE7ULoNWRT/gzWeuxAnMvWBeqbKDQ4D+PQC2vCFSFPJ
         NNj5iMSQ9FDoRnhhFlSxJWF4NLpOn/KScxLRN21nCRzXv/dK0uKcdr/Va3tNfLGwKasZ
         fHebJohX9A0JxC+hDq1+22yj7xbIts456sqhA3c4epMDl7YrpdG6uLqoWYtf8HmG86a/
         YxSMIJ6ITWcy9ONYD7WYLDFZNDhYlZ7OcYI440Ip8WfW50h9hrFUiy85mlvbQYckI0xs
         FkzUiXs8eYXd5ElktJqrnI2yDQH6yC488+eJWTQym1Zmb70WCNVY8aFy+e5sdc06CP0S
         k6PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQIxDZNG16+uBflCoa/wkrmAZ13ZTfymt7+IDrV6VMdH28/jQqG/3ZIEaByHRFv3pqinsgHo0nqy7TB42Y7C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgoI3NIzCLuwfuQxffL81Xh/P04chAFfC/rDJSrrx/ByIsxNhP
	VYjCyiJT0rT/h6DBO6nmwK4T9EmtwTs26hydTRvy89xu/4UadE68e92IeyDlWg6XsTBqOdXkSI6
	zvJYR4Nk4GBHizHAFhr440cqcUwwcaSqc1EbhqpRr
X-Gm-Gg: AY/fxX7/bKhc1Dif6u9RITce9P3JwoJ+6sspM8lwz1cKLwdAK4wgQyz6L91JY6o9yoF
	EkM9T8Hui8Ki4/ml1e4PVWtUa63f7SX1miU8OwFq4RjzFc01mpAQ9QenxPjixpi7fYCyUuK3Qu1
	kQIX40+4O7Hj33xuFT2Zp/fJwDlYzNQHv/lXGRL6kq1Z4ZpvJ36j1PIUTtpz1LwG7pi9h14ZUb/
	18E1czHKACzILyIO05kjFKZv8zIiTb46OLtMOFcTNfyv34HOYIQ5RVd00KKbZSl/rZP00Z3Sq4l
	72VQRNo=
X-Received: by 2002:a05:622a:54a:b0:4f4:bb86:504f with SMTP id
 d75a77b69052e-4ffc0a70687mr8479691cf.16.1767881426893; Thu, 08 Jan 2026
 06:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-8-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-8-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 8 Jan 2026 14:09:50 +0000
X-Gm-Features: AQt7F2q2Xuj85YtjC8aNYrYefXO_WXhklsHw1E8DTYu1HFx1qzlPPDyk9yC5egA
Message-ID: <CA+EHjTx8hu=WEu54Bt82PtcsOdQHaVkw9ivQSSC9=SV7bf1Zvg@mail.gmail.com>
Subject: Re: [PATCH v9 08/30] KVM: arm64: Move SVE state access macros after
 feature test macros
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

On Tue, 23 Dec 2025 at 01:22, Mark Brown <broonie@kernel.org> wrote:
>
> In preparation for SME support move the macros used to access SVE state
> after the feature test macros, we will need to test for SME subfeatures to
> determine the size of the SME state.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad



> ---
>  arch/arm64/include/asm/kvm_host.h | 50 +++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index ac7f970c7883..e6d25db10a6b 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -1048,31 +1048,6 @@ struct kvm_vcpu_arch {
>  #define NESTED_SERROR_PENDING  __vcpu_single_flag(sflags, BIT(8))
>
>
> -/* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
> -#define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +     \
> -                            sve_ffr_offset((vcpu)->arch.sve_max_vl))
> -
> -#define vcpu_sve_max_vq(vcpu)  sve_vq_from_vl((vcpu)->arch.sve_max_vl)
> -
> -#define vcpu_sve_zcr_elx(vcpu)                                         \
> -       (unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
> -
> -#define sve_state_size_from_vl(sve_max_vl) ({                          \
> -       size_t __size_ret;                                              \
> -       unsigned int __vq;                                              \
> -                                                                       \
> -       if (WARN_ON(!sve_vl_valid(sve_max_vl))) {                       \
> -               __size_ret = 0;                                         \
> -       } else {                                                        \
> -               __vq = sve_vq_from_vl(sve_max_vl);                      \
> -               __size_ret = SVE_SIG_REGS_SIZE(__vq);                   \
> -       }                                                               \
> -                                                                       \
> -       __size_ret;                                                     \
> -})
> -
> -#define vcpu_sve_state_size(vcpu) sve_state_size_from_vl((vcpu)->arch.sve_max_vl)
> -
>  #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
>                                  KVM_GUESTDBG_USE_SW_BP | \
>                                  KVM_GUESTDBG_USE_HW | \
> @@ -1108,6 +1083,31 @@ struct kvm_vcpu_arch {
>
>  #define vcpu_gp_regs(v)                (&(v)->arch.ctxt.regs)
>
> +/* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
> +#define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +     \
> +                            sve_ffr_offset((vcpu)->arch.sve_max_vl))
> +
> +#define vcpu_sve_max_vq(vcpu)  sve_vq_from_vl((vcpu)->arch.sve_max_vl)
> +
> +#define vcpu_sve_zcr_elx(vcpu)                                         \
> +       (unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
> +
> +#define sve_state_size_from_vl(sve_max_vl) ({                          \
> +       size_t __size_ret;                                              \
> +       unsigned int __vq;                                              \
> +                                                                       \
> +       if (WARN_ON(!sve_vl_valid(sve_max_vl))) {                       \
> +               __size_ret = 0;                                         \
> +       } else {                                                        \
> +               __vq = sve_vq_from_vl(sve_max_vl);                      \
> +               __size_ret = SVE_SIG_REGS_SIZE(__vq);                   \
> +       }                                                               \
> +                                                                       \
> +       __size_ret;                                                     \
> +})
> +
> +#define vcpu_sve_state_size(vcpu) sve_state_size_from_vl((vcpu)->arch.sve_max_vl)
> +
>  /*
>   * Only use __vcpu_sys_reg/ctxt_sys_reg if you know you want the
>   * memory backed version of a register, and not the one most recently
>
> --
> 2.47.3
>

