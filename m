Return-Path: <linux-kselftest+bounces-10291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9888E8C76E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 14:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9621F21915
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 12:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B1914601C;
	Thu, 16 May 2024 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eBSLS7j8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4572B145FE2
	for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863858; cv=none; b=HA34G/Z9/+Bz3cqS9AD+PI+3ek9VjAaoKEQpCoJrJ/xD4nbum2BeD06dUL++80XxABmXwJQ44mLmqNVTArkQKoI5R16AiBLrNHdo0e40td01vJrV+PJjRm707NGtZWbdPvLzs/KEhRE3p7X4vPEtWoWwrpnclbKMP0OSbG/wfME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863858; c=relaxed/simple;
	bh=kZU55I/RDRwDthGYCDmfPc+xZ2lz+hR5qGvHj4RkRqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjVGkibad/hvW6xWawRXUie1Xzn9sUTAzCdhKNeP9E7PxVrMT3Sv/XxBy3yXJWKQ7loXnfkTsFI+nJaNgmERvtUKCuGlHAxtBeIdmq5dAVKEy2iGwL3LNoKeNGJqo65w1xt9wNOvx/k9CSPlid16+Vrul0bOKxsx2ZJdcTYadmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=eBSLS7j8; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61bed5ce32fso86132047b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715863856; x=1716468656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Od+pJB6mZAnjsfvS954bc7TMJjR9/PUts1oYAKpTsg=;
        b=eBSLS7j8sF2FCizeCUCxtHWs1+I0yYcNl+5SKyakicYBlPNYYkJb9bsmn2bmNHn+Kj
         bSeaj3XTbD7GD1qbi0t59VL2/hINVjg+DpC4o8IgCu1DJdIOyWs1wmJH1eBgwedbuf7Z
         k2bhuC0G9GX1mzhxaTjBwZFcBbbe+b5YJJSSk7gwAlg6yflflUVHG/ZuQOnNcoMx/Vpr
         rLl3wY/Y+g3Rh6OIXP1mXwFrLxxlD9jDvvBXnFqt9sLm3bCl/nqPxG6tRag00m+zhgOy
         U8cyjrlYSHwMfNwog5uZOKuLmonDYnVQabAA447CY3pQ16bkGJzPqs5LF0upOW8zM7vF
         6l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715863856; x=1716468656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Od+pJB6mZAnjsfvS954bc7TMJjR9/PUts1oYAKpTsg=;
        b=cOMunsG/AJnajQVbaCX8W1lOSGI55TllnHJMVNtZ4W+0pMGzfr5P74GOOctZqQ7eK6
         d78+FLqwWMPClOsQU80M01RqtjBeq1HrrzHtM52ISZnC1cfoiqiG0SuLfTXem7E+TcLv
         TZEL1OKAzE8sjTbliu4jme3UcDI7t5FXNQK0z+5orTMkFTtiFK8YvuYEps+3kT+TbsGI
         v//ZHSBy7X+3irdcRvSiLHV1hPkfE1a1HnbQiJuhIPPkjUhxgfAgqd6Ng6N4/7SP62w+
         39QGlR3oFNfrcop1dhmBMEmistQyZEbsmB/NSqsCXt+z1Ll9tnA/NTzBrx6aOegAeZ74
         ibGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtOibE/uFod3C1dGN6P6otcb8hETslCFZw4xMBCFEeXa4achkbWMFAtQG0wBEatYihaYWZm1j5w3sd8zdshEEUVgObztKSEHoqEPoQIDp8
X-Gm-Message-State: AOJu0YzLoNBkkrpoWFw9y1DJocksMwMSkO964+JB3sSS5rRU7bjMHoWl
	/BbDBz0DBXVAhHI4EK9DClxixhKjXevrL5+cDfJ+qctzwJQagunZXcV74ZylKbGH1eOvHyvVlxA
	CEstFYhBqdLGAz9c1BfMbXzDNlAY7dny1FWa6Bg==
X-Google-Smtp-Source: AGHT+IGs7lVMK92YN+1HJCcotmujY/ztr2anQuNr3U+Iebkb2i92DLwZmM+D3pTVHWKs6H4058jiuMgZuuev28xE+eY=
X-Received: by 2002:a0d:cb52:0:b0:615:46dc:44db with SMTP id
 00721157ae682-622b013ca1bmr180898027b3.35.1715863856375; Thu, 16 May 2024
 05:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-2-cb7624e65d82@rivosinc.com>
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-2-cb7624e65d82@rivosinc.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 16 May 2024 20:50:45 +0800
Message-ID: <CABgGipXNoiQ-+R3CzFS_hGT+d9L9vhqyB1famkDmm=v8XcYavg@mail.gmail.com>
Subject: Re: [PATCH v6 02/17] dt-bindings: riscv: cpus: add a vlen register
 length property
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

On Sat, May 4, 2024 at 3:33=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Add a property analogous to the vlenb CSR so that software can detect
> the vector length of each CPU prior to it being brought online.
> Currently software has to assume that the vector length read from the
> boot CPU applies to all possible CPUs. On T-Head CPUs implementing
> pre-ratification vector, reading the th.vlenb CSR may produce an illegal
> instruction trap, so this property is required on such systems.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>

> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index d87dd50f1a4b..edcb6a7d9319 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -94,6 +94,12 @@ properties:
>      description:
>        The blocksize in bytes for the Zicboz cache operations.
>
> +  riscv,vlenb:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      VLEN/8, the vector register length in bytes. This property is requ=
ired in
> +      systems where the vector register length is not identical on all h=
arts.
> +
>    # RISC-V has multiple properties for cache op block sizes as the sizes
>    # differ between individual CBO extensions
>    cache-op-block-size: false
>
> --
> 2.44.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

