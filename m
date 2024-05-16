Return-Path: <linux-kselftest+bounces-10293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF79A8C7826
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 16:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39A0284A27
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7179314B94A;
	Thu, 16 May 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BclPoID/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600914A60F
	for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868029; cv=none; b=B7U+j/GYCGyqXtJYtEfYaflWmElpRg2bNwyg5zBnna8WRr7NChY0ckGDgftY9LlGU+5K8SS7e4rgu0UxZrJYLjnFBcAUOPK9ibPBkG4FVLsBOPVW/Wu2ZN9O52PgrRUy64eMrmkp7U0KzmwnDAAsujNRKB+6GplNQPWhQN926TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868029; c=relaxed/simple;
	bh=N0mPA+arP6XJeVtdFeMPRAWdHbtc4Ku64hU43AeRhbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGUSZuscdMAWMZl0SzL0/7KHnGL4vbxJurScGjktoxSuCbYSM95CTJEb3pMFvc5nk/KtkhumBGRdenDIvMiwW+94v5XCF0Kx0Ud9V9/3Ik33NUsUXT2VBncG6h02ELPByny7rFsrW9qsGZcY7Jy16sglmXAmbj/0uXJVXBc7SQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=BclPoID/; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61be4b98766so93590047b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 07:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715868027; x=1716472827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cD8EYomjv0kIIk3OrzTD6Ca/3+CIlst2MLQc78I7jZU=;
        b=BclPoID/Ts7KHclBqi2U2kpM9STPSbLEHZwScHjbJjPZFMzKLNwk0UmMy4gH8Z9ej5
         rqC8I9SR/YYkUxOviRR86VppM95QPWA1F4PNfHVp6wTt6mdr6/qzVhJ4GSV2qpNdbAib
         bguJAZjVFlYIPwRb5SwoJBQte1xWY3svvm9hKiS4TuT22QCjJ6nIMSJP0wS/vysMe5WW
         /YBs19Ky+rZpVpnooSsEHI/kwaJ+TeIfgjd7mAtJ3n7Y/KS7SQtdkPOXUfRzrRrV+aWZ
         36O7UKpad9E0E200Y0KE9HEW2Qyn/jdQqqYWneeyKITstjeAYpGlQOWWuK66W7REJQ8F
         h2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715868027; x=1716472827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cD8EYomjv0kIIk3OrzTD6Ca/3+CIlst2MLQc78I7jZU=;
        b=jFMTjrSnbvl88Vie6Vy6EF3gM1vvQnGWrhfSzFIKEFYA/AhVVI/3y3X17yTlnjPMx4
         qudwDrD6ymvfg8cwwnDXLEKSeJjpLc4RuUARDcAR2TrG8gnVP/T7gGOFBivaO02ZNPkL
         Q+3nGiaOgfEplEherm/kOFeiSES8FQxAFqUfc3MjgPawHdw8oL32iKX4yIbNv5ACqwNN
         0O8T3Wo6+bDKbR2MtZaOn0mXhy+ZWTPvafVLs3a2owHiPWv7NjS6fPLN3GZiPHMM6roQ
         QKH7lBUa74/0QJy+M8I+n5nhso7aOgBB+9f7s4ljdDNMpSjzxQCMqrsroMoknDt+RXfN
         7vdA==
X-Forwarded-Encrypted: i=1; AJvYcCWOWj9zJ+/6Y5B8dVvlDW4zIj1tNZ0KplgKl3bPHJoyKsecVV8upmErT96tjMbuui09mPYe59+KFjPMa/VCKpLPS+Onv992+07y3KZJjt4v
X-Gm-Message-State: AOJu0YzsPv74PkcXiaQ/vm5QaumM4cxfqiG3lmibxGzXvusYZ6Bg7kBV
	L0KbSST9id2uGOqbDtINLbfiW5xo/W86YgzxDJurIDa2OZLXmP3vUPYp2GXHr6AteoH2PnKU9X6
	xPs94hwEk2P2G7O2RAa0/ryx91eqMzvy7gPysxg==
X-Google-Smtp-Source: AGHT+IEiXLNHmQcW5RA/wgj6ioJ1XAjnfrpiTrNjDqI8fGRd+D3gGsZcnD/VKszGvYjANziq7R0rmzEGrccihxPdLyI=
X-Received: by 2002:a81:480f:0:b0:61a:dfd6:fd6d with SMTP id
 00721157ae682-622aff831a4mr186279727b3.25.1715868023507; Thu, 16 May 2024
 07:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-3-cb7624e65d82@rivosinc.com>
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-3-cb7624e65d82@rivosinc.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 16 May 2024 22:00:12 +0800
Message-ID: <CABgGipXg68VEGt=oZZSENmbqs4-g3PB=CBobNwgqQjLHfxo+VQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/17] riscv: vector: Use vlenb from DT
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry Charlie, I forgot to include the mailing list. Here is the same as
what I sent in the private message.

On Sat, May 4, 2024 at 2:21=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> If vlenb is provided in the device tree, prefer that over reading the
> vlenb csr.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/cpufeature.h |  2 ++
>  arch/riscv/kernel/cpufeature.c      | 47 +++++++++++++++++++++++++++++++=
++++++
>  arch/riscv/kernel/vector.c          | 12 +++++++++-
>  3 files changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 347805446151..0c4f08577015 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -31,6 +31,8 @@ DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
>  /* Per-cpu ISA extensions. */
>  extern struct riscv_isainfo hart_isa[NR_CPUS];
>
> +extern u32 riscv_vlenb_of;
> +
>  void riscv_user_isa_enable(void);
>
>  #if defined(CONFIG_RISCV_MISALIGNED)
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 3ed2359eae35..6c143ea9592b 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -35,6 +35,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __r=
ead_mostly;
>  /* Per-cpu ISA extensions. */
>  struct riscv_isainfo hart_isa[NR_CPUS];
>
> +u32 riscv_vlenb_of;
> +
>  /**
>   * riscv_isa_extension_base() - Get base extension word
>   *
> @@ -648,6 +650,46 @@ static int __init riscv_isa_fallback_setup(char *__u=
nused)
>  early_param("riscv_isa_fallback", riscv_isa_fallback_setup);
>  #endif
>
> +static int has_riscv_homogeneous_vlenb(void)
> +{
> +       int cpu;
> +       u32 prev_vlenb =3D 0;
> +       u32 vlenb;
> +
> +       /* Ignore vlenb if vector is not enabled in the kernel */
> +       if (!IS_ENABLED(CONFIG_RISCV_ISA_V))
> +               return 0;
> +
> +       for_each_possible_cpu(cpu) {
> +               struct device_node *cpu_node;
> +
> +               cpu_node =3D of_cpu_device_node_get(cpu);
> +               if (!cpu_node) {
> +                       pr_warn("Unable to find cpu node\n");
> +                       return -ENOENT;
> +               }
> +
> +               if (of_property_read_u32(cpu_node, "riscv,vlenb", &vlenb)=
) {
> +                       of_node_put(cpu_node);
> +
> +                       if (prev_vlenb)
> +                               return -ENOENT;
> +                       continue;
> +               }
> +
> +               if (prev_vlenb && vlenb !=3D prev_vlenb) {
> +                       of_node_put(cpu_node);
> +                       return -ENOENT;
> +               }
> +
> +               prev_vlenb =3D vlenb;
> +               of_node_put(cpu_node);
> +       }
> +
> +       riscv_vlenb_of =3D vlenb;
> +       return 0;
> +}
> +
>  void __init riscv_fill_hwcap(void)
>  {
>         char print_str[NUM_ALPHA_EXTS + 1];
> @@ -671,6 +713,11 @@ void __init riscv_fill_hwcap(void)
>                         pr_info("Falling back to deprecated \"riscv,isa\"=
\n");
>                         riscv_fill_hwcap_from_isa_string(isa2hwcap);
>                 }
> +
> +               if (elf_hwcap & COMPAT_HWCAP_ISA_V && has_riscv_homogeneo=
us_vlenb() < 0) {
> +                       pr_warn("Unsupported heterogeneous vlen detected,=
 vector extension disabled.\> +                       elf_hwcap &=3D ~COMPA=
T_HWCAP_ISA_V;
> +               }

We only touch COMPAT_HWCAP_ISA_V and the failed case only turns off the
rectified V. So here we have nothing to do with the Xtheadvector.

However, I am still confused because I think Xtheadvector would also
need to call into this check, so as to setup vlenb.

Apart from that, it seems like some vendor stating Xtheadvector is
actually vector-0.7. Please correct me if I speak anything wrong. One
thing I noticed is that Xtheadvector wouldn't trap on reading
th.vlenb but vector-0.7 would. If that is the case, should we require
Xtheadvector to specify `riscv,vlenb` on the device tree?

>         }
>
>         /*
> diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
> index 6727d1d3b8f2..e04586cdb7f0 100644
> --- a/arch/riscv/kernel/vector.c
> +++ b/arch/riscv/kernel/vector.c
> @@ -33,7 +33,17 @@ int riscv_v_setup_vsize(void)
>  {
>         unsigned long this_vsize;
>
> -       /* There are 32 vector registers with vlenb length. */
> +       /*
> +        * There are 32 vector registers with vlenb length.
> +        *
> +        * If the riscv,vlenb property was provided by the firmware, use =
that
> +        * instead of probing the CSRs.
> +        */
> +       if (riscv_vlenb_of) {
> +               this_vsize =3D riscv_vlenb_of * 32;
> +               return 0;
> +       }
> +
>         riscv_v_enable();
>         this_vsize =3D csr_read(CSR_VLENB) * 32;
>         riscv_v_disable();
>
> --
> 2.44.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Thanks,
Andy

