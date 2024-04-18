Return-Path: <linux-kselftest+bounces-8334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B618A9B1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 15:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057FF1C2267A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821C515FA91;
	Thu, 18 Apr 2024 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="gUTmnMoj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064E15F404
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446490; cv=none; b=JxCbFWSONR9+q82PvYI2z/lzXWOGWxO2qm394RS6XkZ6IXuSrfJRirEViMP4dIZYZAkhdEQECO69/d/Y++RwRdFBwpbVLQxQjaWibI4GmRFC1k3pqAWce+8dx1Io0CeYL/2zHvX3Br5kn+AV7M++WgAhE0fMCNlM5eCotTByMTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446490; c=relaxed/simple;
	bh=xCkZWZsd5MbyA9NOc8fkXFwd6tpKTJgqXPaccDVFJJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtCxcF1OCeFNIQJyrMSEBv9S/zI7mkl+2r8TvzS1KEtIh+wuLFLMzULVF4I0taANGg5lCEko6REkE5aBZGVYvMMjF/A5O6zLaeR5T/HbQ8JoYYB5xFkM1UmVGgERxYiWECUl8s9iy5gT3aunP0QhhDKbZRMuCs/tPbSBmJE9JTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=gUTmnMoj; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36b30909b01so3067105ab.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713446488; x=1714051288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JO0ozNsqTpxBsROn3x3SanAr//Rutf3lUig74CS14aw=;
        b=gUTmnMojQcAZ+zR440uQFQcsuAARj0DB1VvGNV3zfZfs6KmN/un01BR93KkxEVK86b
         Yy2I/YRMBjV0P065f6RFwCj+HAT2J8VWhJUkAdFDFu2LQ0S7M7AtUOD3Snw1yDt/C8Rl
         hVIUXUW5+JosBkUvozfCGSpFuL0tKjcg35iSDM44XTsv8Q5Dg1YJTYdaq8tK8Ph9GtbV
         ITw9lBGrsyEkmdf0s0lORQuHWvz6crD3QduRWDhDNdHivK/9RyyOE6Y3U6qvOq+5dGkM
         JEs0Bk9b6VwLGXavabelFkzHaS3ZEysoXLLvjhD8BpdOUVzgDKpr9uBUdohcudRZvX8Q
         Px3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713446488; x=1714051288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JO0ozNsqTpxBsROn3x3SanAr//Rutf3lUig74CS14aw=;
        b=DLBXyBDQQEG6uTcyFvhEU7LJrb0neQ/tObADpPMcpMBldb6+xxPw2oyDsW6hZzeBzA
         RS1iQSkx/hx62MtoLsPXs5+7saLW9f/fj+TMW3oV48upd8cBYP/AzrOM3ZsVB7S9dq+m
         d7DgEkAs6sDzlirqpFhGdkgr+SDfPGULCFA5C/W3aXtAJQMRJKJj3dvBY15bMg5EVtt2
         ayjGmnzpODeDCf434kgODzs01HmtbtXLUucGczFnvhmK2W6A3uBKmOTwqzRK243yXRQM
         UU9l8mcoTS0g+Uzc84KuD0GQL1Fm3TRIBZRecQ/lSv/veOZCVGIWKjAKopf0h7Or7hre
         rUnw==
X-Forwarded-Encrypted: i=1; AJvYcCXeXX9orBY9qrv7MRfTWm/XTnGZuB2ILfpk+DPAqCi/aO1cO9YwP9me3P3DYUqVGLpzqFYhrKOUoBd6UkQI8XWyeBH2otYSBMJYaYTghlAT
X-Gm-Message-State: AOJu0Yxxw3i425xdzw6uqHHOHfdaIuEn2HyWhMQVCzNLxZ+tVj3kRSgW
	wqjDRm4MHWX/217ULKP+H2n7gj9a5T2ys1S+C/GwSKgWPWhUneSAkEEMyRl9C33nsy1/XHM6Nj2
	F+NMHgbmVaZCHHyr0Lt0edSDAcPqYpAluuHpOnQ==
X-Google-Smtp-Source: AGHT+IFYxMvNR0jXCZIG1KPR1/WCDVRMgUDvpXntlv1WYC3zuUPdvb9LjVkJtYSDV5Al2WTKHOMIUCYgVBtJncbys6A=
X-Received: by 2002:a05:6e02:219c:b0:36a:3ef4:aa0a with SMTP id
 j28-20020a056e02219c00b0036a3ef4aa0amr3216818ila.24.1713446488311; Thu, 18
 Apr 2024 06:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418124300.1387978-1-cleger@rivosinc.com> <20240418124300.1387978-12-cleger@rivosinc.com>
In-Reply-To: <20240418124300.1387978-12-cleger@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 18 Apr 2024 18:51:16 +0530
Message-ID: <CAAhSdy3bjKQhRRFLhNtCGNG=f9cj=LHhr0sPWdeFFR9KpC3RVw@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] RISC-V: KVM: Allow Zcmop extension for Guest/VM
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 6:14=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> Extend the KVM ISA extension ONE_REG interface to allow KVM user space
> to detect and enable Zcmop extension for Guest/VM.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/include/uapi/asm/kvm.h | 1 +
>  arch/riscv/kvm/vcpu_onereg.c      | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 57db3fea679f..0366389a0bae 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -172,6 +172,7 @@ enum KVM_RISCV_ISA_EXT_ID {
>         KVM_RISCV_ISA_EXT_ZCB,
>         KVM_RISCV_ISA_EXT_ZCD,
>         KVM_RISCV_ISA_EXT_ZCF,
> +       KVM_RISCV_ISA_EXT_ZCMOP,
>         KVM_RISCV_ISA_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index a2747a6dbdb6..77a0d337faeb 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -52,6 +52,7 @@ static const unsigned long kvm_isa_ext_arr[] =3D {
>         KVM_ISA_EXT_ARR(ZCB),
>         KVM_ISA_EXT_ARR(ZCD),
>         KVM_ISA_EXT_ARR(ZCF),
> +       KVM_ISA_EXT_ARR(ZCMOP),
>         KVM_ISA_EXT_ARR(ZFA),
>         KVM_ISA_EXT_ARR(ZFH),
>         KVM_ISA_EXT_ARR(ZFHMIN),
> @@ -136,6 +137,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsign=
ed long ext)
>         case KVM_RISCV_ISA_EXT_ZCB:
>         case KVM_RISCV_ISA_EXT_ZCD:
>         case KVM_RISCV_ISA_EXT_ZCF:
> +       case KVM_RISCV_ISA_EXT_ZCMOP:
>         case KVM_RISCV_ISA_EXT_ZFA:
>         case KVM_RISCV_ISA_EXT_ZFH:
>         case KVM_RISCV_ISA_EXT_ZFHMIN:
> --
> 2.43.0
>

