Return-Path: <linux-kselftest+bounces-5684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A5786DACC
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 05:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0899D1F223FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 04:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F434F5EA;
	Fri,  1 Mar 2024 04:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="aJlOJzgu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0D4CB38
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709268165; cv=none; b=NYLubX2vybig/YJVEVMjk1EK7oxH2k4RN7HQXnQ5bK6zxlpvQerZ3AQkIeqoeip9qwcq97sdhVyGa9zlatFyR2fhWsbkUXqOhJni411/UbL4CSNFedeQCsIc2Z3wHA6UYsHkhjPepNbIT7rhoG/HzmmfZqbG7ZNvmeeVwEojLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709268165; c=relaxed/simple;
	bh=H2hnTB5lBI7E2U+Jl5DtMSrqK3/l4VCxpxuTdflPYX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n462jBGrrcfd3PwOLRbWgQgp4ALMKmK+IC1UpMduDeOtYNrEyE/bKEsiNtu/kc3+faSd34YDW3fZSrCTenXTjxvWu05zC2IdTwZM4rrgF+727ke8cUUAtHyUzdM5L9my25aEbl8VVdzODPp8hpx2gEbb+4Z/IhsKCrnafxfV7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=aJlOJzgu; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3657c437835so5319935ab.2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 20:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1709268163; x=1709872963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvBduY4sAnPPjxO+Xfm+PRZxCbldlxfEFEFnzNm66ao=;
        b=aJlOJzguOkNb0LTjypIgjXwocUoUWDCgmS7NX80jxLd8AIajEEgkbdl1V/ATjicV6i
         x3cvGq1uDIFZQdU/I2i/Tq5X6Kh439V60Auv44NsEE/RAnXvc9dVHRzb9gfv0VZlmzdf
         /KtZ29/ngd+sADa1MGE5qOgiTOlRbBw4bzukyp3X3YPPmhJ/ROBmoMc/IJEkIe/6myLJ
         FiCEjBe49iDMcznO0MXfU9ws5gowL5AGqSbfOoT4ojru5fqtykJramWUQ45WTXo5F16/
         NQpBPt/Y9juEwKp6KJyeDk9RfN323gTh4+tCw3i4kHkX2AeIT3eR9J0m/eR3DJE78FJX
         u2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709268163; x=1709872963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvBduY4sAnPPjxO+Xfm+PRZxCbldlxfEFEFnzNm66ao=;
        b=SLKCsXGJC5sLgctX/IRc0SyRhSsDtoGBAk31nz1Y2wOTNlNBzuHx2XD9BRW8KfDrdJ
         I+JdhrahwuEG4qBLvqboY7frefN4yvlTJY5SoU3quHLsbjgc/yVUtFXxt53Ze1gGSn5o
         hmq6FLT3as4ChMzEYHJ54tTut3nE+o1KTHUnT8HDl6mTgcRDYw0nDEOahNg20HlyPjjM
         +Rmw3FhIFKh46A2vST8uMQ1IekUKTMZrvrSXkipK1WdnypHwjmv4Bu6Kt5bWKZAjtOj0
         m0mlhvZut+lPBXp9i9vWjkzm5vMduMDzG5O44ZnpkZQlJ1h3X0roT7Tga7pg15W0uATW
         tmRg==
X-Forwarded-Encrypted: i=1; AJvYcCV1aPzZDpFGLI9HiEHHcpPqNyGNfhr+cBI31NwmFIPqSTovcebaVH59CEW7K4xi1KSnKHTaTT0jwNqunI3tB1oYO1lagxdj+jhBufMDiQ8V
X-Gm-Message-State: AOJu0Yze19CO8ohVlG/JyMO+sOBHsX2cNEFbxvkXLP3olKdplKqW9jhp
	Ew10EACD+n/uPPDYZzBHHdOqIU4ANWRuL5dScCH4/INH6hcMMmcS9tB4bZeyiKtAaMSh+imu78a
	injNBuvB2cV3qhU+mxVUsQLPo9VOWdhmmdZlXwg==
X-Google-Smtp-Source: AGHT+IEiwLynSQVhGquKm7KUUZTdCWl6lpF6xy6jzlGvVXpd+rZtIhRUJOkknsYJ2UtSLC0OjSs3410EETlKnHWqOKg=
X-Received: by 2002:a05:6e02:1e01:b0:365:1ee3:ca8a with SMTP id
 g1-20020a056e021e0100b003651ee3ca8amr792980ila.29.1709268162757; Thu, 29 Feb
 2024 20:42:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229010130.1380926-1-atishp@rivosinc.com> <20240229010130.1380926-12-atishp@rivosinc.com>
In-Reply-To: <20240229010130.1380926-12-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 1 Mar 2024 10:12:32 +0530
Message-ID: <CAAhSdy3MAMPJDZhRfFXY3d3d3BOpTJiPBAqVRAYKgzYNLFWyXg@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] KVM: riscv: selftests: Add Sscofpmf to
 get-reg-list test
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@atishpatra.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:32=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> The KVM RISC-V allows Sscofpmf extension for Guest/VM so let us
> add this extension to get-reg-list test.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index 8cece02ca23a..ca6d98a5dce5 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -43,6 +43,7 @@ bool filter_reg(__u64 reg)
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_V:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_SMSTATEEN:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_SSAIA:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_SSCOFPMF:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_SSTC:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_SVINVAL:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_SVNAPOT:
> @@ -406,6 +407,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg=
_off)
>                 KVM_ISA_EXT_ARR(V),
>                 KVM_ISA_EXT_ARR(SMSTATEEN),
>                 KVM_ISA_EXT_ARR(SSAIA),
> +               KVM_ISA_EXT_ARR(SSCOFPMF),
>                 KVM_ISA_EXT_ARR(SSTC),
>                 KVM_ISA_EXT_ARR(SVINVAL),
>                 KVM_ISA_EXT_ARR(SVNAPOT),
> @@ -927,6 +929,7 @@ KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
>  KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
>  KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
>  KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
> +KVM_ISA_EXT_SIMPLE_CONFIG(sscofpmf, SSCOFPMF);
>  KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
> @@ -980,6 +983,7 @@ struct vcpu_reg_list *vcpu_configs[] =3D {
>         &config_fp_d,
>         &config_h,
>         &config_smstateen,
> +       &config_sscofpmf,
>         &config_sstc,
>         &config_svinval,
>         &config_svnapot,
> --
> 2.34.1
>

