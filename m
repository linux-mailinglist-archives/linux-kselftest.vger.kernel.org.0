Return-Path: <linux-kselftest+bounces-34815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00AEAD71FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 15:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DCC3B0EED
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 13:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DC9257422;
	Thu, 12 Jun 2025 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="LivYC/g0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D51256C9E
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734751; cv=none; b=RKPQhk/Uo/2zqeq8VeDJuSK8nrhCHcKS1+dQAOASF12zV5rrj0zXlHtWWW6V6lCXkuXw7qZQ8auParBhgoX6KQaOji2QC0wKedTL2hE4GVyI213hLNz9nPafc+z0N7BUJnykRG+3agGXp/lFfQVnMNWlYtXgDDWQWOa3FRfI2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734751; c=relaxed/simple;
	bh=fZJR3NV0cRGsrfTg7wRUswvgKBH8YB5HL2MnSD+NlVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MppImsfkuVWNVM2OoRS/EcNQXNR/UVJ+hYnDgX0CgoWlO9Tv4C+SV1yNfoSyRtbzYyQl/qhjXgdMe9LfrZXK2mc7+LeCtVyc2KPVPaJJmkYfd6ZfEqzCFz900YmnjaZde2j4Zx3WqEE3q0g5wDPUt+PqOnK4S4iWckFItXqG2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=LivYC/g0; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3ddd38ee5b8so8225145ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 06:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1749734749; x=1750339549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1weUA8id5AE6NfxqG74XbUonfeZX0lj6qhl+0d8DSPM=;
        b=LivYC/g0sW0HjOG9YOAjc8vE18AajbkRpeNdGTHHeyZCKU221IlRpN8p6d5MlF1cLw
         uceIE4vr5dp0/zzC1TKb3EY4svKOQMozmXY64GVR3cWTYeq62liol8Dn6710CjfjqlrR
         I4LW8NZb7lGauy1W8yai70PxjprpjsZtbcbjwmMubLFo0lCO1N/lh80vL4RN4obobK9P
         mkEHL5OJDQkPVddSbFs13GAg+Af+vVQy0zsnuCxlaCGPMXPx79085lXYKDKi+oI7FPQM
         Mje5/bREkE86OqaoCvrmb1A7ZnMiUnO4tZhAT7y/kMPMKlHPJfL4uchRP7vSD0OIp3tJ
         bPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749734749; x=1750339549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1weUA8id5AE6NfxqG74XbUonfeZX0lj6qhl+0d8DSPM=;
        b=NeTifQYblqCebLwkmAMa4B74YHZnoOX/eMC2+TpWzOOWqXEYCixtNZDg8brAORhEoJ
         RRt1gP1dmZvPfjFQXQ9NI7Oj4AmM1jkU0L3XKNVxBScEyHzYScab+Ierxac1Dl2Xu4oq
         heL0feQerOO/dwSbgBQfjfJRv9gqaWBIzRHi/xcYMCKlGPYBR3cXDCHrhVUu8yf9UNf+
         akzGygehGcqh8VBqZ9Gkp+mYK1d+ab+CeIbkGFkxn6x2zXYac+HyDfoQgzNxJNTRQJYa
         wN3YzAimOFdrKAe1F2rt7UtgTN7dfePkIa3yt8+ez+BrTJFANbOVoAL3H6xyCtBBQuZL
         db8g==
X-Forwarded-Encrypted: i=1; AJvYcCX4dO8JmfNAfCZMABar1dmqvJ9WMbQvWYgkliC6p4nG+EulqBT8mzWi4PZFgshZ7gVBCu5xirFVS71Gg7v1sVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1VFpOQiCqzizUqoYwhvgDb95eOrhELFhzlHbHAFqqc+ehih9U
	jBHxSBWnFPYBqk0TZAlXaIBkN3CSXh/0yU9siqzcHjNY4Z0iHXYOYIqurPYs3i14ii0dPFUige4
	sVTIg4Axbhj7/5qRgwIyZXzyWhI6OAKmWvQx8Y1ANzw==
X-Gm-Gg: ASbGncuG1MrRi/OV27feAjR0G0WAjT5BCj98InMa1e/EgYuJ0+Ker0UqMUkytCz8+8a
	RIlwvyQNipsDOLHclkg/7JQXcuxVwTsrLtem/5wRWsLo7ActsVZ7A7Uxqq1ZyIp+R3mtfoU9tvQ
	k7EP58nIyRZHaEsSgcSIkwmoyNlLRBKLmMIQUscCsbID2M
X-Google-Smtp-Source: AGHT+IGQ0K6TdD17j0zYHYf4GUMSVEDpfMuaxvlei9cIKMYkpxSB9dCWrPkla92Oi6O709KnFS2hkfcOfCYTHz+udUk=
X-Received: by 2002:a05:6e02:3b07:b0:3dc:79e5:e6a8 with SMTP id
 e9e14a558f8ab-3ddf4305361mr85364955ab.15.1749734748967; Thu, 12 Jun 2025
 06:25:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523101932.1594077-1-cleger@rivosinc.com> <20250523101932.1594077-14-cleger@rivosinc.com>
In-Reply-To: <20250523101932.1594077-14-cleger@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 12 Jun 2025 18:55:37 +0530
X-Gm-Features: AX0GCFtRWvbG8ZIGWz91EOFFq4Am9HlN0v-k_UzF3rM3BaVpkbYlsqTs93zJo2w
Message-ID: <CAAhSdy0BYXZazQfKGrxS6MwadTeK5JwQRRT-SRvxCWfAUAj0Bg@mail.gmail.com>
Subject: Re: [PATCH v8 13/14] RISC-V: KVM: add support for FWFT SBI extension
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
> Add basic infrastructure to support the FWFT extension in KVM.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

Queued this patch for Linux-6.17

Thanks,
Anup

> ---
>  arch/riscv/include/asm/kvm_host.h          |   4 +
>  arch/riscv/include/asm/kvm_vcpu_sbi.h      |   1 +
>  arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h |  29 +++
>  arch/riscv/include/uapi/asm/kvm.h          |   1 +
>  arch/riscv/kvm/Makefile                    |   1 +
>  arch/riscv/kvm/vcpu_sbi.c                  |   4 +
>  arch/riscv/kvm/vcpu_sbi_fwft.c             | 216 +++++++++++++++++++++
>  7 files changed, 256 insertions(+)
>  create mode 100644 arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
>  create mode 100644 arch/riscv/kvm/vcpu_sbi_fwft.c
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 4fa02e082142..c3f880763b9a 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -19,6 +19,7 @@
>  #include <asm/kvm_vcpu_fp.h>
>  #include <asm/kvm_vcpu_insn.h>
>  #include <asm/kvm_vcpu_sbi.h>
> +#include <asm/kvm_vcpu_sbi_fwft.h>
>  #include <asm/kvm_vcpu_timer.h>
>  #include <asm/kvm_vcpu_pmu.h>
>
> @@ -281,6 +282,9 @@ struct kvm_vcpu_arch {
>         /* Performance monitoring context */
>         struct kvm_pmu pmu_context;
>
> +       /* Firmware feature SBI extension context */
> +       struct kvm_sbi_fwft fwft_context;
> +
>         /* 'static' configurations which are set only once */
>         struct kvm_vcpu_config cfg;
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/a=
sm/kvm_vcpu_sbi.h
> index cb68b3a57c8f..ffd03fed0c06 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
> @@ -98,6 +98,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext=
_hsm;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_dbcn;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_susp;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_sta;
> +extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
>  extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h b/arch/riscv/incl=
ude/asm/kvm_vcpu_sbi_fwft.h
> new file mode 100644
> index 000000000000..9ba841355758
> --- /dev/null
> +++ b/arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2025 Rivos Inc.
> + *
> + * Authors:
> + *     Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> + */
> +
> +#ifndef __KVM_VCPU_RISCV_FWFT_H
> +#define __KVM_VCPU_RISCV_FWFT_H
> +
> +#include <asm/sbi.h>
> +
> +struct kvm_sbi_fwft_feature;
> +
> +struct kvm_sbi_fwft_config {
> +       const struct kvm_sbi_fwft_feature *feature;
> +       bool supported;
> +       unsigned long flags;
> +};
> +
> +/* FWFT data structure per vcpu */
> +struct kvm_sbi_fwft {
> +       struct kvm_sbi_fwft_config *configs;
> +};
> +
> +#define vcpu_to_fwft(vcpu) (&(vcpu)->arch.fwft_context)
> +
> +#endif /* !__KVM_VCPU_RISCV_FWFT_H */
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 5f59fd226cc5..5ba77a3d9f6e 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -204,6 +204,7 @@ enum KVM_RISCV_SBI_EXT_ID {
>         KVM_RISCV_SBI_EXT_DBCN,
>         KVM_RISCV_SBI_EXT_STA,
>         KVM_RISCV_SBI_EXT_SUSP,
> +       KVM_RISCV_SBI_EXT_FWFT,
>         KVM_RISCV_SBI_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
> index 4e0bba91d284..06e2d52a9b88 100644
> --- a/arch/riscv/kvm/Makefile
> +++ b/arch/riscv/kvm/Makefile
> @@ -26,6 +26,7 @@ kvm-y +=3D vcpu_onereg.o
>  kvm-$(CONFIG_RISCV_PMU_SBI) +=3D vcpu_pmu.o
>  kvm-y +=3D vcpu_sbi.o
>  kvm-y +=3D vcpu_sbi_base.o
> +kvm-y +=3D vcpu_sbi_fwft.o
>  kvm-y +=3D vcpu_sbi_hsm.o
>  kvm-$(CONFIG_RISCV_PMU_SBI) +=3D vcpu_sbi_pmu.o
>  kvm-y +=3D vcpu_sbi_replace.o
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index 50be079b5528..0748810c0252 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -78,6 +78,10 @@ static const struct kvm_riscv_sbi_extension_entry sbi_=
ext[] =3D {
>                 .ext_idx =3D KVM_RISCV_SBI_EXT_STA,
>                 .ext_ptr =3D &vcpu_sbi_ext_sta,
>         },
> +       {
> +               .ext_idx =3D KVM_RISCV_SBI_EXT_FWFT,
> +               .ext_ptr =3D &vcpu_sbi_ext_fwft,
> +       },
>         {
>                 .ext_idx =3D KVM_RISCV_SBI_EXT_EXPERIMENTAL,
>                 .ext_ptr =3D &vcpu_sbi_ext_experimental,
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> new file mode 100644
> index 000000000000..b0f66c7bf010
> --- /dev/null
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Rivos Inc.
> + *
> + * Authors:
> + *     Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/kvm_host.h>
> +#include <asm/cpufeature.h>
> +#include <asm/sbi.h>
> +#include <asm/kvm_vcpu_sbi.h>
> +#include <asm/kvm_vcpu_sbi_fwft.h>
> +
> +struct kvm_sbi_fwft_feature {
> +       /**
> +        * @id: Feature ID
> +        */
> +       enum sbi_fwft_feature_t id;
> +
> +       /**
> +        * @supported: Check if the feature is supported on the vcpu
> +        *
> +        * This callback is optional, if not provided the feature is assu=
med to
> +        * be supported
> +        */
> +       bool (*supported)(struct kvm_vcpu *vcpu);
> +
> +       /**
> +        * @set: Set the feature value
> +        *
> +        * Return SBI_SUCCESS on success or an SBI error (SBI_ERR_*)
> +        *
> +        * This callback is mandatory
> +        */
> +       long (*set)(struct kvm_vcpu *vcpu, struct kvm_sbi_fwft_config *co=
nf, unsigned long value);
> +
> +       /**
> +        * @get: Get the feature current value
> +        *
> +        * Return SBI_SUCCESS on success or an SBI error (SBI_ERR_*)
> +        *
> +        * This callback is mandatory
> +        */
> +       long (*get)(struct kvm_vcpu *vcpu, struct kvm_sbi_fwft_config *co=
nf, unsigned long *value);
> +};
> +
> +static const enum sbi_fwft_feature_t kvm_fwft_defined_features[] =3D {
> +       SBI_FWFT_MISALIGNED_EXC_DELEG,
> +       SBI_FWFT_LANDING_PAD,
> +       SBI_FWFT_SHADOW_STACK,
> +       SBI_FWFT_DOUBLE_TRAP,
> +       SBI_FWFT_PTE_AD_HW_UPDATING,
> +       SBI_FWFT_POINTER_MASKING_PMLEN,
> +};
> +
> +static bool kvm_fwft_is_defined_feature(enum sbi_fwft_feature_t feature)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(kvm_fwft_defined_features); i++) {
> +               if (kvm_fwft_defined_features[i] =3D=3D feature)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static const struct kvm_sbi_fwft_feature features[] =3D {
> +};
> +
> +static struct kvm_sbi_fwft_config *
> +kvm_sbi_fwft_get_config(struct kvm_vcpu *vcpu, enum sbi_fwft_feature_t f=
eature)
> +{
> +       int i;
> +       struct kvm_sbi_fwft *fwft =3D vcpu_to_fwft(vcpu);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(features); i++) {
> +               if (fwft->configs[i].feature->id =3D=3D feature)
> +                       return &fwft->configs[i];
> +       }
> +
> +       return NULL;
> +}
> +
> +static int kvm_fwft_get_feature(struct kvm_vcpu *vcpu, u32 feature,
> +                               struct kvm_sbi_fwft_config **conf)
> +{
> +       struct kvm_sbi_fwft_config *tconf;
> +
> +       tconf =3D kvm_sbi_fwft_get_config(vcpu, feature);
> +       if (!tconf) {
> +               if (kvm_fwft_is_defined_feature(feature))
> +                       return SBI_ERR_NOT_SUPPORTED;
> +
> +               return SBI_ERR_DENIED;
> +       }
> +
> +       if (!tconf->supported)
> +               return SBI_ERR_NOT_SUPPORTED;
> +
> +       *conf =3D tconf;
> +
> +       return SBI_SUCCESS;
> +}
> +
> +static int kvm_sbi_fwft_set(struct kvm_vcpu *vcpu, u32 feature,
> +                           unsigned long value, unsigned long flags)
> +{
> +       int ret;
> +       struct kvm_sbi_fwft_config *conf;
> +
> +       ret =3D kvm_fwft_get_feature(vcpu, feature, &conf);
> +       if (ret)
> +               return ret;
> +
> +       if ((flags & ~SBI_FWFT_SET_FLAG_LOCK) !=3D 0)
> +               return SBI_ERR_INVALID_PARAM;
> +
> +       if (conf->flags & SBI_FWFT_SET_FLAG_LOCK)
> +               return SBI_ERR_DENIED_LOCKED;
> +
> +       conf->flags =3D flags;
> +
> +       return conf->feature->set(vcpu, conf, value);
> +}
> +
> +static int kvm_sbi_fwft_get(struct kvm_vcpu *vcpu, unsigned long feature=
,
> +                           unsigned long *value)
> +{
> +       int ret;
> +       struct kvm_sbi_fwft_config *conf;
> +
> +       ret =3D kvm_fwft_get_feature(vcpu, feature, &conf);
> +       if (ret)
> +               return ret;
> +
> +       return conf->feature->get(vcpu, conf, value);
> +}
> +
> +static int kvm_sbi_ext_fwft_handler(struct kvm_vcpu *vcpu, struct kvm_ru=
n *run,
> +                                   struct kvm_vcpu_sbi_return *retdata)
> +{
> +       int ret;
> +       struct kvm_cpu_context *cp =3D &vcpu->arch.guest_context;
> +       unsigned long funcid =3D cp->a6;
> +
> +       switch (funcid) {
> +       case SBI_EXT_FWFT_SET:
> +               ret =3D kvm_sbi_fwft_set(vcpu, cp->a0, cp->a1, cp->a2);
> +               break;
> +       case SBI_EXT_FWFT_GET:
> +               ret =3D kvm_sbi_fwft_get(vcpu, cp->a0, &retdata->out_val)=
;
> +               break;
> +       default:
> +               ret =3D SBI_ERR_NOT_SUPPORTED;
> +               break;
> +       }
> +
> +       retdata->err_val =3D ret;
> +
> +       return 0;
> +}
> +
> +static int kvm_sbi_ext_fwft_init(struct kvm_vcpu *vcpu)
> +{
> +       struct kvm_sbi_fwft *fwft =3D vcpu_to_fwft(vcpu);
> +       const struct kvm_sbi_fwft_feature *feature;
> +       struct kvm_sbi_fwft_config *conf;
> +       int i;
> +
> +       fwft->configs =3D kcalloc(ARRAY_SIZE(features), sizeof(struct kvm=
_sbi_fwft_config),
> +                               GFP_KERNEL);
> +       if (!fwft->configs)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(features); i++) {
> +               feature =3D &features[i];
> +               conf =3D &fwft->configs[i];
> +               if (feature->supported)
> +                       conf->supported =3D feature->supported(vcpu);
> +               else
> +                       conf->supported =3D true;
> +
> +               conf->feature =3D feature;
> +       }
> +
> +       return 0;
> +}
> +
> +static void kvm_sbi_ext_fwft_deinit(struct kvm_vcpu *vcpu)
> +{
> +       struct kvm_sbi_fwft *fwft =3D vcpu_to_fwft(vcpu);
> +
> +       kfree(fwft->configs);
> +}
> +
> +static void kvm_sbi_ext_fwft_reset(struct kvm_vcpu *vcpu)
> +{
> +       int i;
> +       struct kvm_sbi_fwft *fwft =3D vcpu_to_fwft(vcpu);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(features); i++)
> +               fwft->configs[i].flags =3D 0;
> +}
> +
> +const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft =3D {
> +       .extid_start =3D SBI_EXT_FWFT,
> +       .extid_end =3D SBI_EXT_FWFT,
> +       .handler =3D kvm_sbi_ext_fwft_handler,
> +       .init =3D kvm_sbi_ext_fwft_init,
> +       .deinit =3D kvm_sbi_ext_fwft_deinit,
> +       .reset =3D kvm_sbi_ext_fwft_reset,
> +};
> --
> 2.49.0
>

