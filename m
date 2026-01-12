Return-Path: <linux-kselftest+bounces-48785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD925D14C8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 19:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69F8C30087B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 18:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7D138759D;
	Mon, 12 Jan 2026 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TTXmfXNR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF835F8A1
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243000; cv=pass; b=aTWuKJYI8EntG/vjk8qTS7HLqqfrffl+BMUSN6yVkounmguy0q/7xtcQkNb+aG3Y/HsXk4QTGrn5EWbhlli+8qsV0Tv2Qy0DK8E9Kd5c5iYkDLC5xQfwYPrshfoxqSb1W2SFqGQ0ycrPVcVvh4H0/O2BF2xnJpia2X7cAN4V8Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243000; c=relaxed/simple;
	bh=EIrMm4XF6YXDK5QFU6GazWT7Q5wK9ZblkKgC5n9hRM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkhp8vWOphQOAdnq6F/XkpPsxjgNr5QSFpz3teOphVGy5714qthq8vnqZxVLSuoCJJuXrAXJgYE0ey1jUKWdK/+t5/QuUtZeGK0s6E98G0NrzcZQKhq/p+rHmJ1nHXF9cPpMEB2HFwyl2+O7izs09gWepZwQnCV/dSk/oFBgahM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TTXmfXNR; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee243b98caso29431cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 10:36:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768242997; cv=none;
        d=google.com; s=arc-20240605;
        b=Lwft7GnLh3B4eM2ufJPq7VMdOj6p9hvGsIZRUl7W0LWelsP4sdE7jSO51/d76xjSk5
         2cjdJqCcC9e62aDrC019u2jl9zUWxn47L22PFe7iAVukOpqPCiIa6VRz50D676gtaidb
         /RYALWoHR5bm4R1r7RqJul8H0O0GwniG00+XNADeBsm2wg2gP+ahZTir6L9aG5bTF7kd
         lHD2CeVSV/0Iw5hSNVz5kmk84jCzSr0LeaZtA80jvUus5Ck0PrR693BaPinrrqic1cPE
         4E/N/5cAOYFG5ThNavjxYI3sH4uk293bqwvjmIgPF8RLncPBUtZuJ8gehGw7dVmLeTeQ
         3SlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YeVorztV8L2661ciMsTJRNHNSwWuFDTDQ9Xn6dJSHXo=;
        fh=x4E7yr9br2uzaI2OSBpFSwC5wV4yKYDRJl+hQAnTrOE=;
        b=K/RmbwOwL/lCNzH8rXFvpSwyJ6COin66AkWlMFsWypPZEdnfeZCr14NQJ+FxsA2q5G
         2QCP30U91fwhmwoIISlb69cmyuhjWOYdxAoxoHWMRXRuVULPdA4xfzDSPQawjB4c4usK
         P455MsRIdqmMP/FoJWh9ZEIzYFCLoTcT6HSJ2/0ElRilL/DwBmlAjIIaOPgez9L4X3BF
         I1xZeRO7gK5QCjVpHL6tkCY7+O7LNjeYTbXZl4wo18xjvxp6dosxGLTT7nPmw4T+V67c
         W4Qrzz3emdvgsQmm+aDWtsTQ/Gr0j5UkQI9YXqc6G78RgSN0Pz3AwBWZ/PQynli4SvwE
         XQpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768242997; x=1768847797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YeVorztV8L2661ciMsTJRNHNSwWuFDTDQ9Xn6dJSHXo=;
        b=TTXmfXNRpK5BjEGnPo2Ny+2wKrAZFDF21FlLYOqEzhrIJfy5ixbDTtNTuvDhtuEYMY
         guUoTMMoH4MW735ULy5rRLyPDGRAQuN6JPByzEHhem6nUYMi4q40uPpdotyNaLgDzHUS
         yTlPjkOicu0IWw8sL40+NIqZn0H9+7EMKBjqJu1wDsNq6cY87+TaBtSZuWuLyGlaUBgQ
         acCEqYH7yNLbq+04MHW7+2hNqUILzv4SGoY8sXqdfPNmgEA005011Z0g6rWMIrjwHVhj
         BvhmCjFNJWAKoVYlLurmZYVxfXmpXLowAp0h+Iatc+LoZA42mbNobb3+oXmTPF2symw2
         dZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768242997; x=1768847797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeVorztV8L2661ciMsTJRNHNSwWuFDTDQ9Xn6dJSHXo=;
        b=cIfYwwSPU3lBtJreGVuvEY+gzB5vtpYJWgS7M5fOW7+eTKhooQWmOb/qruqEvaymYv
         oi9WZjKb22s/wX+oqnKdtdqJ4VDrSEsz28vyDdgBG1IZldQfofWS7uhfaAyOdchaW+GO
         4vYLMzK43JCgqJz0YclSqt65jDM+YcYnD3Mkct+b7v9V+g0U0d+KhD5HKemgNK89jWA9
         XqfYbp7pTU+Sa4f+cA9KYFfP6xVssdHfwCLozdxELdYXgy3vniBHLufeJ+2Ziu7pw0no
         3WYeSUCoJmS07X0RFadXrcNBsWmfjpx3tNZPE05sL78w4qwQOzM4ZP9UO+2/TYdWU86m
         f7+A==
X-Forwarded-Encrypted: i=1; AJvYcCW6I6U+K6jjtNn4oh/4yeqeAsyg162ctRFveNG2wD5lMLcCOXU+1vwjojZRTDUkrk4Fifa9X0qqwL4Ht4uqdwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDlRI1Xkl5HKHwedTMmyn2ZrJ59XgkaAbK6XRrTzXilNUMBC/j
	MJ1LIOB/zHtnlo5zYDvGiJg3WPjthOx1DcpzUs84XwLTJheHC08NTkmhjXpEDdYYZLs28sxS1ay
	lLofSxuKBGLoIX5G0i0k7aeB3+rFKuOGQI4ubq9zO
X-Gm-Gg: AY/fxX4fDThE18FMmGB3G6zvcRVp4yb06KjwcmVSwWfBg+08LuNMK0LHomJ2lSFbHTR
	USw+uUxibwauMH4reRaGrZgnKgtilPm329sVSdOiDwdwmayWF9xKlxpOVAhVDHWwSHTabBv73/E
	3qhH93akt8Q0lD2PVZfu3FLt/pR83RrnzW6FkbDh5bbjX+6uMixegqRPFyK75GuocYAwUSA+Es3
	w7qt9D1k7nxv/LrIC6PRxDR1UDXTf0PKMW3QmwxBT20wTryBl/w+u3c4iMK0xDGt5vW1tE9
X-Received: by 2002:ac8:505a:0:b0:4f3:54eb:f26e with SMTP id
 d75a77b69052e-5013a3c78b1mr163381cf.1.1768242996667; Mon, 12 Jan 2026
 10:36:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-20-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-20-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 12 Jan 2026 18:35:00 +0000
X-Gm-Features: AZwV_Qio1zjivzMeQYMIWVOvizuY7XatkfCAEo9m4hnoTRYK322NCwDdKHaZ9i8
Message-ID: <CA+EHjTyovGEkb6svw-=wR=DF52j-wWTawJ5a19EuvSt4i9Re2Q@mail.gmail.com>
Subject: Re: [PATCH v9 20/30] KVM: arm64: Support userspace access to
 streaming mode Z and P registers
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
> SME introduces a mode called streaming mode where the Z, P and optionally
> FFR registers can be accessed using the SVE instructions but with the SME
> vector length. Reflect this in the ABI for accessing the guest registers by
> making the vector length for the vcpu reflect the vector length that would
> be seen by the guest were it running, using the SME vector length when the
> guest is configured for streaming mode.
>
> Since SME may be present without SVE we also update the existing checks for
> access to the Z, P and V registers to check for either SVE or streaming
> mode. When not in streaming mode the guest floating point state may be
> accessed via the V registers.
>
> Any VMM that supports SME must be aware of the need to configure streaming
> mode prior to writing the floating point registers that this creates.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kvm/guest.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 2a1fdcb0ec49..90dcacb35f01 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -73,6 +73,11 @@ static u64 core_reg_offset_from_id(u64 id)
>         return id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_CORE);
>  }
>
> +static bool vcpu_has_sve_regs(const struct kvm_vcpu *vcpu)
> +{
> +       return vcpu_has_sve(vcpu) || vcpu_in_streaming_mode(vcpu);
> +}
> +
>  static int core_reg_size_from_offset(const struct kvm_vcpu *vcpu, u64 off)
>  {
>         int size;
> @@ -110,9 +115,10 @@ static int core_reg_size_from_offset(const struct kvm_vcpu *vcpu, u64 off)
>         /*
>          * The KVM_REG_ARM64_SVE regs must be used instead of
>          * KVM_REG_ARM_CORE for accessing the FPSIMD V-registers on
> -        * SVE-enabled vcpus:
> +        * SVE-enabled vcpus or when a SME enabled vcpu is in
> +        * streaming mode:
>          */
> -       if (vcpu_has_sve(vcpu) && core_reg_offset_is_vreg(off))
> +       if (vcpu_has_sve_regs(vcpu) && core_reg_offset_is_vreg(off))
>                 return -EINVAL;
>
>         return size;
> @@ -426,6 +432,24 @@ struct vec_state_reg_region {
>         unsigned int upad;      /* extra trailing padding in user memory */
>  };
>
> +/*
> + * We represent the Z and P registers to userspace using either the
> + * SVE or SME vector length, depending on which features the guest has
> + * and if the guest is in streaming mode.
> + */
> +static unsigned int vcpu_sve_cur_vq(struct kvm_vcpu *vcpu)
> +{
> +       unsigned int vq = 0;
> +
> +       if (vcpu_has_sve(vcpu))
> +               vq = vcpu_sve_max_vq(vcpu);
> +
> +       if (vcpu_in_streaming_mode(vcpu))
> +               vq = vcpu_sme_max_vq(vcpu);
> +
> +       return vq;
> +}
> +
>  /*
>   * Validate SVE register ID and get sanitised bounds for user/kernel SVE
>   * register copy
> @@ -466,7 +490,7 @@ static int sve_reg_to_region(struct vec_state_reg_region *region,
>                 if (!vcpu_has_sve(vcpu) || (reg->id & SVE_REG_SLICE_MASK) > 0)

Should this be vcpu_has_sve_regs()? (zreg range)

>                         return -ENOENT;
>
> -               vq = vcpu_sve_max_vq(vcpu);
> +               vq = vcpu_sve_cur_vq(vcpu);
>
>                 reqoffset = SVE_SIG_ZREG_OFFSET(vq, reg_num) -
>                                 SVE_SIG_REGS_OFFSET;
> @@ -476,7 +500,7 @@ static int sve_reg_to_region(struct vec_state_reg_region *region,
>                 if (!vcpu_has_sve(vcpu) || (reg->id & SVE_REG_SLICE_MASK) > 0)

And should this also be vcpu_has_sve_regs()? (preg range)

Should you also handle FFR here, considering that in streaming mode
it's optional?

Cheers,
/fuad



>                         return -ENOENT;
>
> -               vq = vcpu_sve_max_vq(vcpu);
> +               vq = vcpu_sve_cur_vq(vcpu);
>
>                 reqoffset = SVE_SIG_PREG_OFFSET(vq, reg_num) -
>                                 SVE_SIG_REGS_OFFSET;
> @@ -515,6 +539,9 @@ static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>         if (!kvm_arm_vcpu_vec_finalized(vcpu))
>                 return -EPERM;
>
> +       if (!vcpu_has_sve_regs(vcpu))
> +               return -EBUSY;
> +
>         if (copy_to_user(uptr, vcpu->arch.sve_state + region.koffset,
>                          region.klen) ||
>             clear_user(uptr + region.klen, region.upad))
> @@ -541,6 +568,9 @@ static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>         if (!kvm_arm_vcpu_vec_finalized(vcpu))
>                 return -EPERM;
>
> +       if (!vcpu_has_sve_regs(vcpu))
> +               return -EBUSY;
> +
>         if (copy_from_user(vcpu->arch.sve_state + region.koffset, uptr,
>                            region.klen))
>                 return -EFAULT;
>
> --
> 2.47.3
>

