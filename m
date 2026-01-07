Return-Path: <linux-kselftest+bounces-48435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 504E0CFFDED
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 20:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB27F310DF52
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 19:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96D4335553;
	Wed,  7 Jan 2026 19:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lE6dYd02"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE25932D0D0
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767813944; cv=pass; b=qrlx784d7YkxS5rOCM2AzHYZPTk7JHlo89u03clMGJB5n/A3N7YiyMntR4X3uKPyVGPbPnwNRtLauUGmFw/Q/RidJHw3lXnaFXMJTwdcI14h/LNjgI7kM2B96aLWv8xVLtvHzknHgSl92p6e7OjKhCBWxaQbaW+D7MRL9Muj4sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767813944; c=relaxed/simple;
	bh=7pay+ra3qukgJdVWr8OMTC0IdtAVU2sAntJbg1GqfOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+VPRlNsDxs9jrFvHtppq2qV8tHnRAZb5ihq4HpDf7iEn1uSu996Mlz/tyk4n3G61Zxsf3kO3pXwkKsPJRDz4/L9EbjvwiQUkES4uqNzeXDcOMGVi+sQe2ieZaMPZLBYg15jERFJD+IwH79n5K1/+RzbMOBwcU1nHaH1spfEELY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lE6dYd02; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ee243b98caso480861cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 11:25:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767813941; cv=none;
        d=google.com; s=arc-20240605;
        b=klE4N7EVCFwFY4w0idkTBqxlNCLY69Dk7by6f2uTdgkeIWFzCx6GWKhfCRXPhBpJFa
         8suZxThj0Ehe6VdrFl1Rt1r9VptAvkJ2gIF1yK8qtu14PrdybaxwyQSBLR5F2cUsjsA/
         ijsJsrZLEo8p2sLBni5H9nL8qyNMZhbxt7n0dPva/+Td1DZL6ykPsdn3XWrp85ezhiBj
         oV9dTrzH+VgK/JV93sMp3tKVadm6f3owrJ9rdhbHqb8vvSpwfs6tQg/wwK1M4y5fa1KN
         8+eouCqsQt4SKrimnDrWEyRXH6Iclt3HdJ6YK7vox9mZgZG2cCPkwwSAS9u2HAZOiuLQ
         PGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gTH8jQvV1D0VfzMEkRl+QRl2D3Hkny/yjDSwKTi/xLY=;
        fh=RH4pTa8uwihOwq0jKxurvEcemnXYj/9dl/JWwvCp05I=;
        b=BSDUkGORbqeOTSahm5hFIvpqSUpgjHLz+aX4ZMZm3+6WpZyejVEJURsbqCyKJR23nG
         UcNtZdDW93B0ZOAcSiOYfFaJSoO+u0dPAG/2I5eRu+ykZBhKGSXdUMZuJ/jtFUjXl+7Y
         5GIZD2ApBQQpZyHEnB22TX1eAdh5Hib6pymZwTY7UdbMhmgYHtv+c01yjHEnMTpNV9mO
         nrDTxcEro8df3c5Pw7TJS0HFgH6ALjsMEL5U3CA3HuEuu19G39uk2/mvLPI5aHJFyKFB
         Fhdpa4JccQHnWJTzASXlIW+LGZbr4AIrMUXU1wGmKDJuPi1VmigA55I1b9XUK9P/NbO0
         s+zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767813941; x=1768418741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gTH8jQvV1D0VfzMEkRl+QRl2D3Hkny/yjDSwKTi/xLY=;
        b=lE6dYd02WK/Tcr+blOPCkh+ocEi3B8dwOyCjvjYYInLBl7EEfnjSIuXHMXmJvFaZCk
         sh3TNmHQiiSdNM+PslEXe9UESz+DUE1rCi6Q3kgPudVJInqxxgGfFGDBHz+L0qwOnPtQ
         jbIC0HAlzDxEvJTqhKH1OQMHyVKP22xY/GQvqUTj4DUw2J4mOuRzuNNTPOJgspBzLkgY
         KjVRVMTiUAUQGZT0NGwha3MbTVPs2ne6JDJI6sa3XE6BSJJbX/OYL54RsFm27gYV2dHE
         dnnOEzefHwrqR+m+PU2FpXt9ssefF7uy8AFka2HlZ6hoGJNXSuPfwfHeiB+nPOk7zWtJ
         VNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767813941; x=1768418741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTH8jQvV1D0VfzMEkRl+QRl2D3Hkny/yjDSwKTi/xLY=;
        b=DAh8vVmONhLvD56lvOhZ1DD8b4F1jJEtsMma/gE+za3Rh/cGgAvWP1jLtlYcbs8AT5
         F0hNPsA4KmIszSsUKX750nNWs0f0sy85MuEtepD07u3bmt1K6XGVrPY5S1k0torPi3cB
         DO6lXTTtPdU51fNXDOtIbyGxOxiWomBwg4rTMXo07OxI/Oc+aBVh+YTJLp1+QxwkcNN8
         R9mWcqeH48rmSJW78TrOeEbSXWsEhhKQzGhCaxRGdmJ63tNwB3Zpni/KOEQlLKrlRPhg
         v83t5zXiU3jYwmhXkQrt4/vn6xmyEWyR9/XxEHG6SWlV+LiaxJsv0GnwLdxOICTF7May
         Ig2A==
X-Forwarded-Encrypted: i=1; AJvYcCWkBv1BGavVoV2TL4qczhj5mufAXTng2UzLBnWN9eG+3V4CK2ZuNv/Znnjx2J/8DsYmBQdMtWtz7jiMQ6V0Tgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLG6TFL8aeAyeoGFVegoj9twx9Dv3oFP+KYyUdyNHNSphnU4u
	JKrc/cvw0myQhbweZdYpXTbqm8TeWt6BplYxPtUGimxnq9cA/WmU3JvFJz8nyU2wxqestPTzX7i
	iGlXymVQQS7LlhiOrXKAkDXkkV19xlXMIDHHGLSjm
X-Gm-Gg: AY/fxX4ip5kdtKqMXBmPw8aiUPVEi40U0850H+NVlwUMxWKgpBSLimE3+fZUdldoJ4i
	m+N4TroGsF7Kt9hoMrMNk5QAC/L3seT5M/1BLrJb0YGU7I53v6JUrjciIZYoZWHNuoMSF3uAbct
	HM5kS2o0M3OgQCGronJrVdS3Za4w7+Xcsrn7FVlCyHwv25fDDLwkxmhkVQP6wexqrMGIIglCYlo
	xXRvWRmrWOr+Y25slFky769pERiEWTobDaFs+l5JRLhtbbFNZ9YSSJfCd4tcKQZW2Q9toN1
X-Received: by 2002:ac8:5e06:0:b0:4f3:5474:3cb9 with SMTP id
 d75a77b69052e-4ffb3e48178mr14758401cf.14.1767813940920; Wed, 07 Jan 2026
 11:25:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-2-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-2-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 7 Jan 2026 19:25:04 +0000
X-Gm-Features: AQt7F2qijfqrn1SiSoVThoOMWciACqxsLrgyDpsjmJY9k2NsoSwPIOlWKacYC-Y
Message-ID: <CA+EHjTxdSnpFHkm6o85EtjQjAWemBfcv9Oq6omWyrrMdkOuuVA@mail.gmail.com>
Subject: Re: [PATCH v9 02/30] arm64/fpsimd: Update FA64 and ZT0 enables when
 loading SME state
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

Hi Mark,

On Tue, 23 Dec 2025 at 01:21, Mark Brown <broonie@kernel.org> wrote:
>
> Currently we enable EL0 and EL1 access to FA64 and ZT0 at boot and leave
> them enabled throughout the runtime of the system. When we add KVM support
> we will need to make this configuration dynamic, these features may be
> disabled for some KVM guests. Since the host kernel saves the floating
> point state for non-protected guests and we wish to avoid KVM having to
> reload the floating point state needlessly on guest reentry let's move the
> configuration of these enables to the floating point state reload.
>
> We provide a helper which does the configuration as part of a
> read/modify/write operation along with the configuration of the task VL,
> then update the floating point state load and SME access trap to use it.
> We also remove the setting of the enable bits from the CPU feature
> identification and resume paths.  There will be a small overhead from
> setting the enables one at a time but this should be negligable in the

nit: negligible

> context of the state load or access trap.  In order to avoid compiler
> warnings due to unused variables in !CONFIG_ARM64_SME cases we avoid
> storing the vector length in temporary variables.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/fpsimd.h | 14 ++++++++++++
>  arch/arm64/kernel/cpufeature.c  |  2 --
>  arch/arm64/kernel/fpsimd.c      | 47 +++++++++++------------------------------
>  3 files changed, 26 insertions(+), 37 deletions(-)
>
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index 1d2e33559bd5..ece65061dea0 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -428,6 +428,18 @@ static inline size_t sme_state_size(struct task_struct const *task)
>         return __sme_state_size(task_get_sme_vl(task));
>  }
>
> +#define sme_cond_update_smcr(vl, fa64, zt0, reg)               \
> +       do {                                                    \
> +               u64 __old = read_sysreg_s((reg));               \
> +               u64 __new = vl;                                 \
> +               if (fa64)                       \
> +                       __new |= SMCR_ELx_FA64;                 \
> +               if (zt0)                                        \
> +                       __new |= SMCR_ELx_EZT0;                 \
> +               if (__old != __new)                             \
> +                       write_sysreg_s(__new, (reg));           \
> +       } while (0)
> +

Should we cap the VL based on SMCR_ELx_LEN_MASK (as we do in
sve_cond_update_zcr_vq())?

Should we also preserve the remaining old bits from SMCR_EL1, i.e.,
copy over the bits that aren't
SMCR_ELx_LEN_MASK|SMCR_ELx_FA64|SMCR_ELx_EZT0? For now they are RES0,
but that could change.

Cheers,
/fuad


>  #else
>
>  static inline void sme_user_disable(void) { BUILD_BUG(); }
> @@ -456,6 +468,8 @@ static inline size_t sme_state_size(struct task_struct const *task)
>         return 0;
>  }
>
> +#define sme_cond_update_smcr(val, fa64, zt0, reg) do { } while (0)
> +
>  #endif /* ! CONFIG_ARM64_SME */
>
>  /* For use by EFI runtime services calls only */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index c840a93b9ef9..ca9e66cc62d8 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2965,7 +2965,6 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>                 .type = ARM64_CPUCAP_SYSTEM_FEATURE,
>                 .capability = ARM64_SME_FA64,
>                 .matches = has_cpuid_feature,
> -               .cpu_enable = cpu_enable_fa64,
>                 ARM64_CPUID_FIELDS(ID_AA64SMFR0_EL1, FA64, IMP)
>         },
>         {
> @@ -2973,7 +2972,6 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>                 .type = ARM64_CPUCAP_SYSTEM_FEATURE,
>                 .capability = ARM64_SME2,
>                 .matches = has_cpuid_feature,
> -               .cpu_enable = cpu_enable_sme2,
>                 ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, SME, SME2)
>         },
>  #endif /* CONFIG_ARM64_SME */
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index c154f72634e0..be4499ff6498 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -405,11 +405,15 @@ static void task_fpsimd_load(void)
>
>         /* Restore SME, override SVE register configuration if needed */
>         if (system_supports_sme()) {
> -               unsigned long sme_vl = task_get_sme_vl(current);
> -
> -               /* Ensure VL is set up for restoring data */
> +               /*
> +                * Ensure VL is set up for restoring data.  KVM might
> +                * disable subfeatures so we reset them each time.
> +                */
>                 if (test_thread_flag(TIF_SME))
> -                       sme_set_vq(sve_vq_from_vl(sme_vl) - 1);
> +                       sme_cond_update_smcr(sve_vq_from_vl(task_get_sme_vl(current)) - 1,
> +                                            system_supports_fa64(),
> +                                            system_supports_sme2(),
> +                                            SYS_SMCR_EL1);
>
>                 write_sysreg_s(current->thread.svcr, SYS_SVCR);
>
> @@ -1250,26 +1254,6 @@ void cpu_enable_sme(const struct arm64_cpu_capabilities *__always_unused p)
>         isb();
>  }
>
> -void cpu_enable_sme2(const struct arm64_cpu_capabilities *__always_unused p)
> -{
> -       /* This must be enabled after SME */
> -       BUILD_BUG_ON(ARM64_SME2 <= ARM64_SME);
> -
> -       /* Allow use of ZT0 */
> -       write_sysreg_s(read_sysreg_s(SYS_SMCR_EL1) | SMCR_ELx_EZT0_MASK,
> -                      SYS_SMCR_EL1);
> -}
> -
> -void cpu_enable_fa64(const struct arm64_cpu_capabilities *__always_unused p)
> -{
> -       /* This must be enabled after SME */
> -       BUILD_BUG_ON(ARM64_SME_FA64 <= ARM64_SME);
> -
> -       /* Allow use of FA64 */
> -       write_sysreg_s(read_sysreg_s(SYS_SMCR_EL1) | SMCR_ELx_FA64_MASK,
> -                      SYS_SMCR_EL1);
> -}
> -
>  void __init sme_setup(void)
>  {
>         struct vl_info *info = &vl_info[ARM64_VEC_SME];
> @@ -1314,17 +1298,9 @@ void __init sme_setup(void)
>
>  void sme_suspend_exit(void)
>  {
> -       u64 smcr = 0;
> -
>         if (!system_supports_sme())
>                 return;
>
> -       if (system_supports_fa64())
> -               smcr |= SMCR_ELx_FA64;
> -       if (system_supports_sme2())
> -               smcr |= SMCR_ELx_EZT0;
> -
> -       write_sysreg_s(smcr, SYS_SMCR_EL1);
>         write_sysreg_s(0, SYS_SMPRI_EL1);
>  }
>
> @@ -1439,9 +1415,10 @@ void do_sme_acc(unsigned long esr, struct pt_regs *regs)
>                 WARN_ON(1);
>
>         if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
> -               unsigned long vq_minus_one =
> -                       sve_vq_from_vl(task_get_sme_vl(current)) - 1;
> -               sme_set_vq(vq_minus_one);
> +               sme_cond_update_smcr(sve_vq_from_vl(task_get_sme_vl(current)) - 1,
> +                                    system_supports_fa64(),
> +                                    system_supports_sme2(),
> +                                    SYS_SMCR_EL1);
>
>                 fpsimd_bind_task_to_cpu();
>         } else {
>
> --
> 2.47.3
>

