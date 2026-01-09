Return-Path: <linux-kselftest+bounces-48625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8F9D0B6B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 17:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ED3530382B0
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 16:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE60364E81;
	Fri,  9 Jan 2026 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1MwnqwsA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81844350D74
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977855; cv=pass; b=WCCDDxz1pgz25o/coWVfqATXemki+dFmdy8ThJkyJ5ugT+6VAO2QZFd4iuiA524fwhQLj59LefdIU6P/pE6hY3GVYJcVwtayW6PKab8P+c3bK0MIvCssaqxaDQPunzNVF+/IYRmAq/K5w4oFEJvqy7DwxZbYTCZu01b1C7ybaQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977855; c=relaxed/simple;
	bh=SkjHGF8FR8F2ZPGg4e/H1IK+TJO92/b+hbarPM46pt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtK7NjvS9MSsdiEcceCiDlOHxeBImSg8u2AvmDLnwzvC6YzIrR4TFXei/XRWUyCXtMUJt3nV2IoWZM0Sn7B4A3QsCIA3Fx9X6XG9Ki3SnNXLVEXNBPSiFDgbxoItwmEc96l/EAjQR73soUIaQ2w3NKd9BpfVN5V/DSYAutyse+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1MwnqwsA; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee147baf7bso486521cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 08:57:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767977851; cv=none;
        d=google.com; s=arc-20240605;
        b=YUPC0AX5l5SbzUFDMnpO+VNfWmic3KiMrV00Aqox9z2Gp+kTLGJ2tbuzXQmm/ToO2K
         M8AgLa9qSgx1PiCX9A0Wcr5xTYV0sQHY+OO0HRx2OwYsrNbUVKJdN151mDA3lGTyvg+n
         +Fcafln3Qxfoz0tqf98vk8ro+ntcJ+fWHSLRpPYBq3FaiPudouBGWuOZXRW8fru4BurI
         JHVHp6W6JmEbXOIsiuEkRvQkUJCdgk4OFBU7Q9M2zlrEceITTuR+CQNDd8yET0HNg0gV
         kZAjV5iqDgrEIvylJy52K8kJF0ZVUjKHduJjNXuqYWah7SjssPK6k/LPwF/oTVQDJflt
         1EcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MpztCWy9ipsSXHs0mL6YjlVmfult44YS26X504J/dJw=;
        fh=0dVgN1G/glFs2dKK0mEp5QN3cMp59Xdgp/VNrl0ek9M=;
        b=EvRF8HW43xI0IYNo8nBoBXfE/LIpzR5L+METQqnRko0+kTtRMGeHhOyvbmgYvyjpH8
         VkDseynpDC3A43n1dAmXZmmxxlaG67r35jI85MkUjML9OZSNP9VKxDGY+rFsfyuXcZ3r
         Clt5nRB7hmsy6MgAFCyJl+AoHnW2UeM+yOnm6ISU6q7DY5pdA99az1o3+Pqy3Do5X5/X
         0/jIxeM5AroW7x0GoRCTyBA8tQ/PJEDArptDaHejzWppjMAoQslIdAiNQ5S/A6Wqclm/
         5pgkmIvjJOed5LtSowoM5z1hR2iuj5grwINt8U3sjBx8reakg6ZsNlAxK2dAgNxMcqSu
         QR1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767977851; x=1768582651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MpztCWy9ipsSXHs0mL6YjlVmfult44YS26X504J/dJw=;
        b=1MwnqwsA56nPfeMq/y0NAzhBtPXZtuG+jenGXdhITh3WJ0bs686hgm+uz1VQbtAw92
         TILHKrK3s4MDEwKMcWyWMHGLQUhqJEbWgiANkchDVj9ajkdbAak9B6m+LBQI9asPtn4m
         Uo2ckqThpv7ixB/7aZzhUYz5e6CWwJ1nYvo0gdCanSSBXKNjOLdMqhL2xf+BsELr1AF3
         t9QAzrTEqk6cWBDjaUsJEoI1x5iP2ZFlhm/WAtzTMuKb8J5YTLStQJ9b527ZraSR/z7j
         YUNzdCFhs9i3osWszSz8pAmjxkwduZB+L7nIg4Ca/LKmRoS7wzTLyoyCIcx85ypwapiR
         Wwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767977851; x=1768582651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpztCWy9ipsSXHs0mL6YjlVmfult44YS26X504J/dJw=;
        b=ao6BajJu8Nt6/RMNLh4ZHxPKqaAtTSDQ3bLdQsoX6rl+4p3c9lKy1bY0OdgHlvCVy2
         YEvwdCyMiYFZcj1vXEptlEmNgjbsFw+WPhEqTTBf3UzCqMm4HMKganH/KrVXKkVbyfo+
         FktWbNS4N2SP2vaVJUbHuvT65OTzoFXaa4554+F6sI1+olIHqfJjuLrksXf/+cOI47k0
         TwJIr6GpNOHDbwDrhRSvn9WTs7yM+uVzCZ2nQoA/i/t7w9DbOq+Qqs6vaamxQNO91mXQ
         557P5tHTm7FZYzR/ruVyVhohlMVwHQlqxR0LqQkmHeMz2VQAqeRh9S8sW9xFAudibTVr
         tXag==
X-Forwarded-Encrypted: i=1; AJvYcCV/PyvimZofWd8iGKZKAfJQ82iSGNjeIRLJQHAF7cYLTOJNbg5H/AqM55kXLSxiNK+Vi1ZOVdcniiNcAXeFtUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs3G63EqeLgdzJQXGgasxrftFlh3d7ab0M4lNSauGdIt28q9de
	MVLv3ACi97vThfXGsdCqbK06pc8ASlEPxBw+QfbR2K1ZMMp1CYBpZ4oufyoWVAEq1Fz86KeN2pP
	6veYfMPNjvTnm/qVyA9MflCLJvVPmJp00mFiDAE0V
X-Gm-Gg: AY/fxX7wLsjqbikNnPM6ZzofWPCZ6sAcrXGpEJwp/IDOpZ/FV+I4yfVD4FIXhgb13t3
	kmAwTWDxfpSmCBOwXm+XuIlSET0eT0DZg2Tboq3S3CUbit0+gcK7QHVAoWV0+41ZJ5myp/QP47I
	59lqm3CxHOMQqk7C2NyqoFkZ2DVN87yF/pKj7U1TONDNKz+4zjGsJcHaGXCwhRcz8i4UKQR4cHe
	JZH2KyPsc0Vn/tutqEpj7j/mXiltj99Ndl7N9yTcvo4qZ1GP0jyn75awW9o7sHeXee0E5v2
X-Received: by 2002:a05:622a:198e:b0:4e8:aa24:80ec with SMTP id
 d75a77b69052e-4ffca38a667mr12955411cf.14.1767977851098; Fri, 09 Jan 2026
 08:57:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org> <20251223-kvm-arm64-sme-v9-16-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-16-8be3867cb883@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 9 Jan 2026 16:57:00 +0000
X-Gm-Features: AZwV_QiwST85CNc25KZYMBDJwxaQzBlftzyvIde5n_9dAYz2SEbvmx43n1faTzI
Message-ID: <CA+EHjTwTmjNEV+4w8w=LXfR0g_v7yHk1pQD+Oos8V3vFfEVdMw@mail.gmail.com>
Subject: Re: [PATCH v9 16/30] KVM: arm64: Support TPIDR2_EL0
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
> SME adds a new thread ID register, TPIDR2_EL0. This is used in userspace
> for delayed saving of the ZA state but in terms of the architecture is
> not really connected to SME other than being part of FEAT_SME. It has an
> independent fine grained trap and the runtime connection with the rest
> of SME is purely software defined.
>
> Expose the register as a system register if the guest supports SME,
> context switching it along with the other EL0 TPIDRs.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> ---
>  arch/arm64/include/asm/kvm_host.h          |  1 +
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 15 +++++++++++++++
>  arch/arm64/kvm/sys_regs.c                  |  3 ++-
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index f24441244a68..825b74f752d6 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -448,6 +448,7 @@ enum vcpu_sysreg {
>         CSSELR_EL1,     /* Cache Size Selection Register */
>         TPIDR_EL0,      /* Thread ID, User R/W */
>         TPIDRRO_EL0,    /* Thread ID, User R/O */
> +       TPIDR2_EL0,     /* Thread ID, Register 2 */
>         TPIDR_EL1,      /* Thread ID, Privileged */
>         CNTKCTL_EL1,    /* Timer Control Register (EL1) */
>         PAR_EL1,        /* Physical Address Register */
> diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> index 5624fd705ae3..8c3b3d6df99f 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> @@ -88,6 +88,17 @@ static inline bool ctxt_has_sctlr2(struct kvm_cpu_context *ctxt)
>         return kvm_has_sctlr2(kern_hyp_va(vcpu->kvm));
>  }
>
> +static inline bool ctxt_has_sme(struct kvm_cpu_context *ctxt)
> +{
> +       struct kvm_vcpu *vcpu;
> +
> +       if (!system_supports_sme())
> +               return false;
> +
> +       vcpu = ctxt_to_vcpu(ctxt);
> +       return kvm_has_sme(kern_hyp_va(vcpu->kvm));
> +}
> +
>  static inline bool ctxt_is_guest(struct kvm_cpu_context *ctxt)
>  {
>         return host_data_ptr(host_ctxt) != ctxt;
> @@ -127,6 +138,8 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
>  {
>         ctxt_sys_reg(ctxt, TPIDR_EL0)   = read_sysreg(tpidr_el0);
>         ctxt_sys_reg(ctxt, TPIDRRO_EL0) = read_sysreg(tpidrro_el0);
> +       if (ctxt_has_sme(ctxt))
> +               ctxt_sys_reg(ctxt, TPIDR2_EL0)  = read_sysreg_s(SYS_TPIDR2_EL0);
>  }
>
>  static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
> @@ -204,6 +217,8 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
>  {
>         write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL0),     tpidr_el0);
>         write_sysreg(ctxt_sys_reg(ctxt, TPIDRRO_EL0),   tpidrro_el0);
> +       if (ctxt_has_sme(ctxt))
> +               write_sysreg_s(ctxt_sys_reg(ctxt, TPIDR2_EL0), SYS_TPIDR2_EL0);
>  }
>
>  static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt,
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 5c912139d264..7e550f045f4d 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -3504,7 +3504,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>           .visibility = s1poe_visibility },
>         { SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
>         { SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
> -       { SYS_DESC(SYS_TPIDR2_EL0), undef_access },
> +       { SYS_DESC(SYS_TPIDR2_EL0), NULL, reset_unknown, TPIDR2_EL0,
> +         .visibility = sme_visibility},
>
>         { SYS_DESC(SYS_SCXTNUM_EL0), undef_access },
>
>
> --
> 2.47.3
>

