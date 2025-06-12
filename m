Return-Path: <linux-kselftest+bounces-34813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB26AD71B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 15:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E8F16FE5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 13:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C213523E336;
	Thu, 12 Jun 2025 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="USL7PAmy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1323D284
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734696; cv=none; b=FibwHiiNcgiRmH94O4hPgGmqbPPZLxpXeNZnjZdrWFwODmjt7K0t8e8NhZj2gQqFtobRmXSdfQyG0dppZww+b6lWWQR0EWSr9p4Lde8NJTMV0fqJxzPofzm2nvw8Bly03FdGvLRkQmPTYhzaCYSPG9zuyZEmtX2QNK3YheeU4SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734696; c=relaxed/simple;
	bh=nSjx51XwsDM238FSIikQC+yI/Iljj0NBnR2BVO64huc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZQiY6FFUk73U6yAABFkxGmbTkWSuCgovNBnF7Np8mZA2obZlh4388V3ZV9IMRURZBQATqXGUWPJX9RcMYps0M7Bt9ZbZLojypNPiLHOlsZNxggn0GLE1KEdjf0ukNX22V7iZwoy533/Kji4MavT72b9gDozwG5BIKq46xNTVqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=USL7PAmy; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fad8b4c927so8692996d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 06:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1749734694; x=1750339494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yO42KCFFAU1JaE5snqlMD+WeNGQUfTluFPre84YIRbg=;
        b=USL7PAmyjBqjvLTTZ0N7ITv/cMyLL/ILxBJdSWH5hw0LBRwJik1N7ohefT3h/drDIg
         mIeL1iWWS4F4aTMqLU+BEp2/Z3bOzTQf9inqk8cZhqM5dNRNwjBbNnEmNSuQAQ+9S9YH
         q1pzlGs5zBKIt8wiEr3qvX3LmaXqh4KlTN87e+7gO+f1ZbtP8f3u94iwBZ6dxNEZvsQz
         3MPGVksFhtrDEyZtnJXSEVZmxsMUzuJDecfyxsX0hZK64xii5W2/FjMQJOqOOLIYdqEJ
         mP7byCXZwyA7yFAbdp/u/DSOU4dAdeHW1XAnwvkHg6Wq7rJcfX4BEPt7vNbnjNXwnDAm
         A+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749734694; x=1750339494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yO42KCFFAU1JaE5snqlMD+WeNGQUfTluFPre84YIRbg=;
        b=EW4AiLNsGcAJ3sFKeHJTXsSXpy8E8IfY8cuTkFASp2kfXFnr814MOh8lNu/Sw7BCQw
         bzWXeDQasnFKovM6cihdBOPmWr6Nr8LCQ+3oi7+xZgMkv+whoTdoLLR4GbcT1GXEh2yh
         irr58JqQd86DSxCM+n2fHOVSgggMY5bfm4icS/qyNZI0ehHZEe7qc8UJPJH1+74fY41f
         diPFrK/ujw/cA//7ulK0eszhnLQR9BrsddJatx+Cdhy/yUzyVO3tuCzbGYCjrlIzggV7
         5y78kl9160zuGn5xK/hkxKiccrbfwJ+ngCKlD2kTwXNuHFixJd7eEivKCKIlY5k1eymH
         K80A==
X-Forwarded-Encrypted: i=1; AJvYcCWtPEWhdfiGLp1NhZB9gm0RhBFPw76PV7LTagsm6OlH4zT7jQzr1uG4j3CEqbLfa4Jp7L/M9QfivNEduya3y58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQeRLNKi40u5sFy6XJBATQQFEY0YBiqyenVrrRA5JzTX2Dpom7
	PnvLGQ57eKBRZM02Ausa3rwSZdNufy5vzbc1j5v8rJm67qJlOe0OCqqe3O1zSGiFa1g7V3JNzll
	+Z8gupCI66Jeu1p8aqNL4SO9Ys3+TDsu70bLZgMYZqTTYw3Pj0uRN
X-Gm-Gg: ASbGncvgn46kD+/XrckUU5/Ih1UNKoK+PfCo3z3bS2swumhkrYKa67OGKgwPOWfhXq7
	rube+JO7e1pE2gP12NgKPJdjVaGHoFWNC5/nLHT2aGwgItKojIxUK1a71fqGZe6K/TG9IE+spKF
	4t7Ppc9T0CzrjUwVhogcY3hah+5Ig54QqlUmq58K0fLAYM
X-Google-Smtp-Source: AGHT+IEQ8/gBtL0M7nfyYdA1Q09mRUvmfJss0qUxYGME0df67gFne3lBmXn745akWi2zsvhSTtgFKgn2YK7q1n6XKl8=
X-Received: by 2002:a05:6e02:2783:b0:3dd:c40d:787e with SMTP id
 e9e14a558f8ab-3ddfa80be5fmr50613855ab.2.1749734681937; Thu, 12 Jun 2025
 06:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523101932.1594077-1-cleger@rivosinc.com> <20250523101932.1594077-12-cleger@rivosinc.com>
In-Reply-To: <20250523101932.1594077-12-cleger@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 12 Jun 2025 18:54:30 +0530
X-Gm-Features: AX0GCFu-M1pG9OAlM2fvsx7DbIa0rvE-jQkn0nAnykhBaLvlREw8Qci06BqSqC4
Message-ID: <CAAhSdy10FcQxWR3PCA0502AAEQ7S=TxkX-Jtuh+yVDh5ZgNnSg@mail.gmail.com>
Subject: Re: [PATCH v8 11/14] RISC-V: KVM: add SBI extension init()/deinit() functions
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Deepak Gupta <debug@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 3:52=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> The FWFT SBI extension will need to dynamically allocate memory and do
> init time specific initialization. Add an init/deinit callbacks that
> allows to do so.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

Queued this patch for Linux-6.17

Thanks,
Anup

> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h |  9 +++++++++
>  arch/riscv/kvm/vcpu.c                 |  2 ++
>  arch/riscv/kvm/vcpu_sbi.c             | 26 ++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/a=
sm/kvm_vcpu_sbi.h
> index 4ed6203cdd30..bcb90757b149 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -49,6 +49,14 @@ struct kvm_vcpu_sbi_extension {
>
>         /* Extension specific probe function */
>         unsigned long (*probe)(struct kvm_vcpu *vcpu);
> +
> +       /*
> +        * Init/deinit function called once during VCPU init/destroy. The=
se
> +        * might be use if the SBI extensions need to allocate or do spec=
ific
> +        * init time only configuration.
> +        */
> +       int (*init)(struct kvm_vcpu *vcpu);
> +       void (*deinit)(struct kvm_vcpu *vcpu);
>  };
>
>  void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *r=
un);
> @@ -69,6 +77,7 @@ const struct kvm_vcpu_sbi_extension *kvm_vcpu_sbi_find_=
ext(
>  bool riscv_vcpu_supports_sbi_ext(struct kvm_vcpu *vcpu, int idx);
>  int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run)=
;
>  void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu);
> +void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu);
>
>  int kvm_riscv_vcpu_get_reg_sbi_sta(struct kvm_vcpu *vcpu, unsigned long =
reg_num,
>                                    unsigned long *reg_val);
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 02635bac91f1..2259717e3b89 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -187,6 +187,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>
>  void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  {
> +       kvm_riscv_vcpu_sbi_deinit(vcpu);
> +
>         /* Cleanup VCPU AIA context */
>         kvm_riscv_vcpu_aia_deinit(vcpu);
>
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index d1c83a77735e..3139f171c20f 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -508,5 +508,31 @@ void kvm_riscv_vcpu_sbi_init(struct kvm_vcpu *vcpu)
>                 scontext->ext_status[idx] =3D ext->default_disabled ?
>                                         KVM_RISCV_SBI_EXT_STATUS_DISABLED=
 :
>                                         KVM_RISCV_SBI_EXT_STATUS_ENABLED;
> +
> +               if (ext->init && ext->init(vcpu) !=3D 0)
> +                       scontext->ext_status[idx] =3D KVM_RISCV_SBI_EXT_S=
TATUS_UNAVAILABLE;
> +       }
> +}
> +
> +void kvm_riscv_vcpu_sbi_deinit(struct kvm_vcpu *vcpu)
> +{
> +       struct kvm_vcpu_sbi_context *scontext =3D &vcpu->arch.sbi_context=
;
> +       const struct kvm_riscv_sbi_extension_entry *entry;
> +       const struct kvm_vcpu_sbi_extension *ext;
> +       int idx, i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(sbi_ext); i++) {
> +               entry =3D &sbi_ext[i];
> +               ext =3D entry->ext_ptr;
> +               idx =3D entry->ext_idx;
> +
> +               if (idx < 0 || idx >=3D ARRAY_SIZE(scontext->ext_status))
> +                       continue;
> +
> +               if (scontext->ext_status[idx] =3D=3D KVM_RISCV_SBI_EXT_ST=
ATUS_UNAVAILABLE ||
> +                   !ext->deinit)
> +                       continue;
> +
> +               ext->deinit(vcpu);
>         }
>  }
> --
> 2.49.0
>

