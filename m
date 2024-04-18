Return-Path: <linux-kselftest+bounces-8332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E998A9B15
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D0A1C21DCC
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD61635B2;
	Thu, 18 Apr 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="TSCNfPRI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2CE16078C
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446435; cv=none; b=mJ/nqGto2QVzBZdiTSKHWrtzmdhquKbm5MFbJ0xxg9gls0yZ3TI09rpqz3cBThG2KUVsBVyfJeZKLSRNON7+HJmeB16UI1fcvTzXCOe23GYoSkma55Lktfq2zFf/PtVsjt31e11AelqboUy6ROUl09lxEfny0A3vnviWpY38Quw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446435; c=relaxed/simple;
	bh=cwotXz71csJK5NlYG6cUePZxsMutZ9CiCnXSbJcpnco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3DZ0D3fSBZxMp12vO49s2HxktPb6EnWaGv1mk/GkD5DVDmYj+VeIzJtrTKD+KIR7HKB6HjM3HlhdP9zArm5wJQec/QsdD5ly63iMcdPa4etUi6t8G4rRBD1JK879Qa9rnXRZiYa1vN4El4YPPRzNBLM0xttz1xFdBLVRIRcx5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=TSCNfPRI; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d03a66e895so84057039f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 06:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713446433; x=1714051233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gx9GnWevREtFfaeT4x816rwBBhgS4sWYP/+TT0BrELo=;
        b=TSCNfPRI1RBVqjumWW+SebIW/fHuwvPmbonl6jPsmmqibhiG+Shsj8O9jPbUptnrEc
         jj2QOifC1vrvquAmOPI7yIzYoZ3b6DQS6cUWLzHgOhcg8DMd14IgRdpR1Tl123fKkEeg
         bIoI76VZGQAVEbPgD3GqJbLE9CT24DrapGocyc1+lzAxVzYiGi05kNvs0sy7Ng/S3Jvj
         3jQoX6qnJHr9SHckphFFLSYaXM0RFdHdmv2oD+y1MwjYFEHy9VzWjfPF9hPk7moAmxeO
         pGEqoWLyDb0GeRxmTmqegs4Q/Jb1UVbSloOgmHf0NJbFklUEWYKHnEfLn5Hh1bF4+Xis
         DnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713446433; x=1714051233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gx9GnWevREtFfaeT4x816rwBBhgS4sWYP/+TT0BrELo=;
        b=KNCIhTXyMf4FQh5yJUVXyzPbDf+wRX7tA5ZmOfn1oDh2tyd5hH+SopF8ZNCCLRIEN+
         XkO/C3yptzlduOCBsvkznv0Ijxt9dfxds7hGs7G7Ki2g6MFpT8+8AydQ94b7lYWblhYI
         l6yI1pTnOGOmlnLl8YhDtHOjhGaR6hN3egRTDl6fDf79ZYo3xVJwD1Tz1Jy5rstZvGbM
         JC87LhSpWrrpTfZlzWiH8aoZegWdQV61EyVccwuvTkVIHdn4+zsjH5uUPyZcEVW48FgW
         Fo/o+ctYoUH1T7QH/EjkD34cN4R2piftqcy0ZLa0XBf0FSsG63J2DzTfkPWbEGCJoJ2N
         FyxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUcYSTP2nSHEtm4iFegNhjG5WLxsZpiE1UQ7G/53St7NqwYeHBrp0RgRWI0glOqZNzlokH6VgQT1pqpLJdpBsCDwTxI/OlXiRYzj2P85sw
X-Gm-Message-State: AOJu0Yx8auu6UVqBbsWPnsFU7epAZkuk2TRisfkrd81hG+yhhpbrJsHp
	OSVPLus6WuAp1vmlIZBweyfihMBF5VzeovYlKuIWwwY/Hu5V2Z3h6HkzPl0rSFOMyMWec42wgih
	5mdamq6zetzAjIjCbAb+gKHTdwBVPlNILyEHJpg==
X-Google-Smtp-Source: AGHT+IGMAebq+hy93GujthN3vp/oiNgylMXL32FxuMysUl+JA4YBKBsEzN18erjOu1anh/0QSxfZh2bW0X+CZoU6xFA=
X-Received: by 2002:a05:6e02:1d85:b0:36a:28a8:ca5 with SMTP id
 h5-20020a056e021d8500b0036a28a80ca5mr3399351ila.7.1713446433235; Thu, 18 Apr
 2024 06:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418124300.1387978-1-cleger@rivosinc.com> <20240418124300.1387978-7-cleger@rivosinc.com>
In-Reply-To: <20240418124300.1387978-7-cleger@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 18 Apr 2024 18:50:21 +0530
Message-ID: <CAAhSdy33=s_J=0HJ1VfbxPVkBgyTZ1rpM3G15R8rJGbnNA_zeg@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] RISC-V: KVM: Allow Zca, Zcf, Zcd and Zcb
 extensions for Guest/VM
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
> to detect and enable Zca, Zcf, Zcd and Zcb extensions for Guest/VM.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  arch/riscv/include/uapi/asm/kvm.h | 4 ++++
>  arch/riscv/kvm/vcpu_onereg.c      | 8 ++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 35a12aa1953e..57db3fea679f 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -168,6 +168,10 @@ enum KVM_RISCV_ISA_EXT_ID {
>         KVM_RISCV_ISA_EXT_ZTSO,
>         KVM_RISCV_ISA_EXT_ZACAS,
>         KVM_RISCV_ISA_EXT_ZIMOP,
> +       KVM_RISCV_ISA_EXT_ZCA,
> +       KVM_RISCV_ISA_EXT_ZCB,
> +       KVM_RISCV_ISA_EXT_ZCD,
> +       KVM_RISCV_ISA_EXT_ZCF,
>         KVM_RISCV_ISA_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index 12436f6f0d20..a2747a6dbdb6 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -48,6 +48,10 @@ static const unsigned long kvm_isa_ext_arr[] =3D {
>         KVM_ISA_EXT_ARR(ZBKC),
>         KVM_ISA_EXT_ARR(ZBKX),
>         KVM_ISA_EXT_ARR(ZBS),
> +       KVM_ISA_EXT_ARR(ZCA),
> +       KVM_ISA_EXT_ARR(ZCB),
> +       KVM_ISA_EXT_ARR(ZCD),
> +       KVM_ISA_EXT_ARR(ZCF),
>         KVM_ISA_EXT_ARR(ZFA),
>         KVM_ISA_EXT_ARR(ZFH),
>         KVM_ISA_EXT_ARR(ZFHMIN),
> @@ -128,6 +132,10 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsig=
ned long ext)
>         case KVM_RISCV_ISA_EXT_ZBKC:
>         case KVM_RISCV_ISA_EXT_ZBKX:
>         case KVM_RISCV_ISA_EXT_ZBS:
> +       case KVM_RISCV_ISA_EXT_ZCA:
> +       case KVM_RISCV_ISA_EXT_ZCB:
> +       case KVM_RISCV_ISA_EXT_ZCD:
> +       case KVM_RISCV_ISA_EXT_ZCF:
>         case KVM_RISCV_ISA_EXT_ZFA:
>         case KVM_RISCV_ISA_EXT_ZFH:
>         case KVM_RISCV_ISA_EXT_ZFHMIN:
> --
> 2.43.0
>

