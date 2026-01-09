Return-Path: <linux-kselftest+bounces-48622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B02B4D0B4A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 17:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 911AC30501A0
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777FD364041;
	Fri,  9 Jan 2026 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SUmEcPMt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF56330D27
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976287; cv=pass; b=MiAt6QatgUO0WOgTX582+0o/AE7+uxSph/BjGjFC9M2R4OqIwPNnxMkVQSvKOyzx+KrRUatho2Vx50YOYTv3oU1dGSiSkrFd2jsRoRhA/VLEPcvhfqwTJ3mdiR2zsjZ2Ye9Ju2kunWBeAh0Hh3T5+GlKlOXAqGeaqKsroAcT2dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976287; c=relaxed/simple;
	bh=TvYZA4dBSlsSpGSZUaKtQ+jUGYaXayrnDE16b2gj2N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kl98FPMM7bbhNrpxCKJGAp9H4kF6JP0E6AlXCGq1clap5gNLzZxGyLfnPDxYGBOB5yBa85a1nkreAhHEdZAejIw/fQt5iGsJohF0R/DFSQQ6XZqmtqTW1B5c1GmiZEX7TRICKjPauhKiwzxf38IPLWmUTmrmrdtgKgU46BcPgt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SUmEcPMt; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4edb8d6e98aso600011cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 08:31:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767976284; cv=none;
        d=google.com; s=arc-20240605;
        b=C4HkY+JCPtnwt8A58ZqbkPqvVxBM/l85lD9HmwEzCrKDSracxq7KYAROFHYNrTHFVF
         KEW6MOloOq3pJQdtZFO1lUyzV6oFWQdWu7kH02ZQPlPZMvPtKj+uJ094fSet2F/iOphG
         UYoLvrep7xgSIWxD5UrdjM1pHtMqIBuR8jLeOP4Vyv9nBPDFGfhr6H8CuvBYjR3T5tc5
         GKCyQvoagCttDzIzfE1bfbUOMi4+3E/dvywJY6Ds4Sd54ruquNp30jfdR3vIB6ftMR47
         fcE4l99xMuJfxx1StRu8WtY8MDZ+UodnuT+55w06OckJCFzFMmFkPCSVOz5kceaHdpcs
         ZZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bOqelCfA+niHr585Q7gjhs1CWJtFJzsgDt10/9RfHhM=;
        fh=Gojr8XaOUNFIWmw7aJRisFQpWbl7jy8iJkEcoQptTUQ=;
        b=ZudD3INJYXnp6tArgbzItYEBC6wMa9vZybPSEsB53AtEdtEOqbvRiWA7P3jFI5Te23
         eM0zr7/9IxYpKFgx/BAPdC4KWIB6GSDyop8DPeUg8apl4kDXh1pM6Kl+dkp5LjlLDiFg
         sJidiRO8q8qjM6Uao2Xf1Iz7WkBV0QvcglLdJFGG034XbETSClPxstPOaHGc75Ur05e2
         f5F8vXdg/nKAE6i6ecAIt+apVHYLeF+0+XlTCIdFlP0YUnW13ERV5bdl+HJwCHL8ZI3H
         M18E75zAvqS+c4ZjW+sP7200+oqEuGUVYZkwnf8kUzsdgNopYHcdtwrMzJi4M799g+xy
         L6lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767976284; x=1768581084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bOqelCfA+niHr585Q7gjhs1CWJtFJzsgDt10/9RfHhM=;
        b=SUmEcPMtZxpzkG7Bxjg/Em0Y4U4kQ4BXBdxvHw88nWLlZMLlpnYJhGMRvUYt14OuAr
         XvU8EGNgnCG4EmyCZq9crSxUQvfbljbQQlBriYJqhvTaHOved4CPzrhOgh2VK7owO+G7
         EsTEmaMk7C2ctWZ7Qdf8qvEwmh+gs1zF/LK2F4JfPBu4SED8gGVrQi1B0hZS3fTqsLaT
         HdTsCbGc+dFII0ZaEMeBMXSZ4pqDqyGT7sPUCa6FyqQZ68/r8EziJQEhUvjiE5jfeett
         xHup5hSV99h75/7VoiuhOp8RxmhBXGnAsaIzSx2nJO7tS53TZuGc2KdLfR2Iboequ6Ov
         bLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767976284; x=1768581084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOqelCfA+niHr585Q7gjhs1CWJtFJzsgDt10/9RfHhM=;
        b=u1R7qOyWWwFUl07aA8LbdcXwosD3PhDvflC7l0G1QFn1pAmCwDLZCwzkuBQfxdmw9n
         PRWbw5NDNHRBj6ZujGNxL4iwwRoBQz729fpSyWLoQdKi8o+/rWWGnoaSsQXA9zmZFMQY
         IOm5FDjpDnDomElJO0UvLgeNlkPqnBxAHzVYuMVt842F99XP7U2PV99re3sV3S7PRlCM
         AjudrpOPXcydiMSWfquP6vNBKILhPJSlvvUR3Lt8OLygExq2aAbdG9q6mluYS8zv6MlG
         xEI+ff3OH/ziW9vJmx+jEQm9azTFpl67ntHfniUDd1drvJ2J90i0wmySg3b/NDKtIWf1
         AVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfutQnXa7S4TjXA3v+oe3OG0gbqfKeO2BAGRMyoB1Q2haEb+wVNSiovZNTJ3GXIaN972XgKkfhUb6qImMMi8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7W9dZXb0JMIao+mLv1PDGfTaHJEx5Z67kbGphKgKH8diQlnnk
	myijZQCJsw6B0F4nTStTxDIJfdsw9RUWYFGjYi3Ls9bsPmKYh4jglE/iSDaKFCWxAGfrCqb2DVn
	VNUdyu1IJtyD7beYdGfF44XFW2P1O1Wz90PBdoXDO
X-Gm-Gg: AY/fxX7xNHzDErN3m/E7L0FZsYFxTO73bwBrnNeY6uR0ia6WX8XF91ryj8tUsqVUgSv
	KxUb4/e/0+UFhgFIqC1yCtbLJKjOBhj13u8OT1BfHvXj8bc78QFNY77vyskumnyoGSRLYr8CO59
	n2NWiGQn0cLQMPFUZLNn0JH93JEGFVh2lJSj5rW7mjRA1B+OlCgI2iHOrKPXbPthJJQeEU+mwUw
	khgpeK5pVI4mieCIFLPSl/UJn0itCmW0XJtOvIc5CPDzeXfnDKlJV5trNxrgzy3CNHOi5Wa
X-Received: by 2002:ac8:5d8d:0:b0:4ed:70d6:6618 with SMTP id
 d75a77b69052e-4ffca3899e0mr12373901cf.10.1767976283510; Fri, 09 Jan 2026
 08:31:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-15-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-15-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 9 Jan 2026 16:31:00 +0000
X-Gm-Features: AZwV_Qg_Mx3Uve2Ajz9vtAn4ZY1Okl_E_qqP5nAl07n9Fwy2xIITsZXnkaSndwU
Message-ID: <CA+EHjTzP9roJNcHhVrcGm9RMAn0E+RGPkJ57w44OL4fy3EW-wA@mail.gmail.com>
Subject: Re: [PATCH v9 15/30] KVM: arm64: Support SME control registers
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
> SME is configured by the system registers SMCR_EL1 and SMCR_EL2, add
> definitions and userspace access for them.  These control the SME vector
> length in a manner similar to that for SVE and also have feature enable
> bits for SME2 and FA64.  A subsequent patch will add management of them
> for guests as part of the general floating point context switch, as is
> done for the equivalent SVE registers.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h     |  2 ++
>  arch/arm64/include/asm/vncr_mapping.h |  1 +
>  arch/arm64/kvm/sys_regs.c             | 36 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index b41700df3ce9..f24441244a68 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -504,6 +504,7 @@ enum vcpu_sysreg {
>         CPTR_EL2,       /* Architectural Feature Trap Register (EL2) */
>         HACR_EL2,       /* Hypervisor Auxiliary Control Register */
>         ZCR_EL2,        /* SVE Control Register (EL2) */
> +       SMCR_EL2,       /* SME Control Register (EL2) */
>         TTBR0_EL2,      /* Translation Table Base Register 0 (EL2) */
>         TTBR1_EL2,      /* Translation Table Base Register 1 (EL2) */
>         TCR_EL2,        /* Translation Control Register (EL2) */
> @@ -542,6 +543,7 @@ enum vcpu_sysreg {
>         VNCR(ACTLR_EL1),/* Auxiliary Control Register */
>         VNCR(CPACR_EL1),/* Coprocessor Access Control */
>         VNCR(ZCR_EL1),  /* SVE Control */
> +       VNCR(SMCR_EL1), /* SME Control */
>         VNCR(TTBR0_EL1),/* Translation Table Base Register 0 */
>         VNCR(TTBR1_EL1),/* Translation Table Base Register 1 */
>         VNCR(TCR_EL1),  /* Translation Control Register */
> diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
> index c2485a862e69..44b12565321b 100644
> --- a/arch/arm64/include/asm/vncr_mapping.h
> +++ b/arch/arm64/include/asm/vncr_mapping.h
> @@ -44,6 +44,7 @@
>  #define VNCR_HDFGWTR_EL2       0x1D8
>  #define VNCR_ZCR_EL1            0x1E0
>  #define VNCR_HAFGRTR_EL2       0x1E8
> +#define VNCR_SMCR_EL1          0x1F0
>  #define VNCR_TTBR0_EL1          0x200
>  #define VNCR_TTBR1_EL1          0x210
>  #define VNCR_FAR_EL1            0x220
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 3576e69468db..5c912139d264 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -2827,6 +2827,37 @@ static bool access_gic_elrsr(struct kvm_vcpu *vcpu,
>         return true;
>  }
>
> +static unsigned int sme_el2_visibility(const struct kvm_vcpu *vcpu,
> +                                      const struct sys_reg_desc *rd)
> +{
> +       return __el2_visibility(vcpu, rd, sme_visibility);
> +}
> +
> +static bool access_smcr_el2(struct kvm_vcpu *vcpu,
> +                           struct sys_reg_params *p,
> +                           const struct sys_reg_desc *r)
> +{
> +       unsigned int vq;
> +       u64 smcr;
> +
> +       if (guest_hyp_sve_traps_enabled(vcpu)) {

Should this be guest_hyp_sme_traps_enabled() ?

> +               kvm_inject_nested_sve_trap(vcpu);

And by the same token, should this be kvm_inject_nested_sme_trap()?
That function doesn't exist, but would inject ESR_ELx_EC_SME instead
of ESR_ELx_EC_SVE.

> +               return false;
> +       }
> +
> +       if (!p->is_write) {
> +               p->regval = __vcpu_sys_reg(vcpu, SMCR_EL2);
> +               return true;
> +       }
> +
> +       smcr = p->regval;
> +       vq = SYS_FIELD_GET(SMCR_ELx, LEN, smcr) + 1;
> +       vq = min(vq, vcpu_sme_max_vq(vcpu));
> +       __vcpu_assign_sys_reg(vcpu, SMCR_EL2, SYS_FIELD_PREP(SMCR_ELx, LEN,
> +                                                            vq - 1));

I think this might be wrong. This code only writes the LEN, discarding
other fields in SMCR_EL2. The analogous SVE code in access_zcr_el2()
is only concerned with the length, and doesn't need to worry about
other bits to preserve.

Should this be something along the lines of the below instead?

+       smcr = p->regval;
+       vq = SYS_FIELD_GET(SMCR_ELx, LEN, smcr) + 1;
+       vq = min(vq, vcpu_sme_max_vq(vcpu));
+       smcr &= ~SMCR_ELx_LEN_MASK;
+       smcr |= SYS_FIELD_PREP(SMCR_ELx, LEN, vq - 1);
+       __vcpu_assign_sys_reg(vcpu, SMCR_EL2, smcr);

Cheers,
/fuad




> +       return true;
> +}
> +
>  static unsigned int s1poe_visibility(const struct kvm_vcpu *vcpu,
>                                      const struct sys_reg_desc *rd)
>  {
> @@ -3291,7 +3322,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>         { SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
>         { SYS_DESC(SYS_TRFCR_EL1), undef_access },
>         { SYS_DESC(SYS_SMPRI_EL1), undef_access },
> -       { SYS_DESC(SYS_SMCR_EL1), undef_access },
> +       { SYS_DESC(SYS_SMCR_EL1), NULL, reset_val, SMCR_EL1, 0, .visibility = sme_visibility },
>         { SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
>         { SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },
>         { SYS_DESC(SYS_TCR_EL1), access_vm_reg, reset_val, TCR_EL1, 0 },
> @@ -3655,6 +3686,9 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>
>         EL2_REG_VNCR(HCRX_EL2, reset_val, 0),
>
> +       EL2_REG_FILTERED(SMCR_EL2, access_smcr_el2, reset_val, 0,
> +                        sme_el2_visibility),
> +
>         EL2_REG(TTBR0_EL2, access_rw, reset_val, 0),
>         EL2_REG(TTBR1_EL2, access_rw, reset_val, 0),
>         EL2_REG(TCR_EL2, access_rw, reset_val, TCR_EL2_RES1),
>
> --
> 2.47.3
>

