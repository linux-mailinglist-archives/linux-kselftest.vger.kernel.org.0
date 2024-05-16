Return-Path: <linux-kselftest+bounces-10290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 788C28C76D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 14:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CCD1F21915
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 12:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA81414600D;
	Thu, 16 May 2024 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OUaZWwnG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77056145FF9
	for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863711; cv=none; b=pPpuuc3L4rPKtNTgz59G6fwwnK6a1ftwIOkj8ub8GbO8Lt6hpwUk8Z6cvDkAjg8FmRgvlVuBIc0dnXiChmqoTvHuioZ2DmUPC9LgnCr//JhhbNyL4/oh6ah1y/kIKK9/YlhgnRcF/QCJgH7/buPpDto6St8CBCoupNhpBDr3zjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863711; c=relaxed/simple;
	bh=llODjkQVmJ0JRKqb9IK76GX35Rinj4g9QpPEqkPd/NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKUEh7d0Jj3cHlKbKkLUdHyBPN+0cAOGnBJLKvAEdGmv82v0HcFuje3a7c9z/xazJhcI0IwPwrf0DSq3OviOAH5B5k8056bOPxSNr89pdXnJqGJnmsb6VMjIsiTOuwtXCl3GOV67h/JKjDzFGf+MR5zlTl2yL0IrSU5FUHpdH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OUaZWwnG; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61bed738438so81805147b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 May 2024 05:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715863708; x=1716468508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0YMZmj/yuBSBh3+Prm3doCFTI5UB0khyraQ6llJYcQ=;
        b=OUaZWwnGukTrPBrYgpPgMd1Mow6UWQwtew+9Lw2/5dDHJlcLL9tb0QMmazNf28brgS
         YcEwna7b+dSvrX4FCaoPzyvRdP6Ow9wEyzh+d/vmvH6HZw4HncO8AKe2hcW9xpTihkxj
         umR2M6/Tzjtk7/vlz3OhzWmtmP45Exk4ZOB65CQEA326cOq2m/AOkvcZY921ePkLIIYp
         Y9o9lunFpYX16TPdWSxktA4sbnyuovQGJC0QrD3J0qHGip46+W9ph4x5GTZG20Y9MrM2
         AUu+pXccdFxqTf+evpQIZ8KUMtSjJAxNBMvUkPq8GwaCwh/j7mMRzkQfBWIjjzqrIZWJ
         nkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715863708; x=1716468508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0YMZmj/yuBSBh3+Prm3doCFTI5UB0khyraQ6llJYcQ=;
        b=leiiwxHGc85f77aDXsRzBwLbTJ97zqug5qrKQRhVHsa7k8c+C3OrmBYnvZEWlOAp83
         tfUN8JsbWc64xgEj7lRjMEF68Q2aKtIDT7txoD1NBnrPbJ8b7v0Rb5rk06+VqCoJ/+7O
         7x9X3yNaBASTD5aLTW4algvsEYxg91JjW9lfvHGIaYQU9VXncU7MiBnSAyLfYkJZ7wb0
         ZtnIyXQtSvd4YkhHmhvzHt2zV4ueYvMlPsnWoOXEyf4GYiDVjr1vXWk7OX6iFfratKkC
         UTutQPfyE9FLtK/gK7924ZYZQ7TopM2TQEPJNCkXtCpuje4CwY5p5gVNbVI0pGyc385H
         21WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFZUTGdD1wFiXd1gEYmD3rq+Tod8tduOBvIa7eBdJ2sYBD3qJDh2V4JaxIxw6jA2stDj3uKgEhpijdIQV+DR3GBiCONv0lVbHUm9CK1Uff
X-Gm-Message-State: AOJu0YxpWbcBxixOeEJGnrGyCtzsv4hkWci+t+j/Kf3cuvw2c4YXwAYD
	PB7HWevhV2k/DRWMCYxYlZ6ExLyVcbMpkn91fRlnhs64KfsevXJhw32Zx2A7PjzI+EuEQgTogHB
	wNsgLHW+5UQNMVy8giKgzqQ1zPcKMY4UkWipAGg==
X-Google-Smtp-Source: AGHT+IFmiatJ0VGsQTQP54hpUSwoqwi/xnPZ1Pzr4sv0QEqyqVyV9N5SU92rESBXEGjCyeby+CMydFjJBhLe6iYVziE=
X-Received: by 2002:a81:c70d:0:b0:61b:1bf5:67a9 with SMTP id
 00721157ae682-622affc9c33mr175662497b3.22.1715863708404; Thu, 16 May 2024
 05:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-dev-charlie-support_thead_vector_6_9-v6-0-cb7624e65d82@rivosinc.com>
 <20240503-dev-charlie-support_thead_vector_6_9-v6-1-cb7624e65d82@rivosinc.com>
In-Reply-To: <20240503-dev-charlie-support_thead_vector_6_9-v6-1-cb7624e65d82@rivosinc.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 16 May 2024 20:48:17 +0800
Message-ID: <CABgGipU6rybwUo3ZW_RhH5VgWcFqV0x6RTrKAaMXS6=tfe2t5Q@mail.gmail.com>
Subject: Re: [PATCH v6 01/17] dt-bindings: riscv: Add xtheadvector ISA
 extension description
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
> The xtheadvector ISA extension is described on the T-Head extension spec
> Github page [1] at commit 95358cb2cca9.
>
> Link: https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cc=
a9489361c61d335e03d3134b14133f/xtheadvector.adoc [1]
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>

> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 468c646247aa..99d2a9e8c52d 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -477,6 +477,10 @@ properties:
>              latency, as ratified in commit 56ed795 ("Update
>              riscv-crypto-spec-vector.adoc") of riscv-crypto.
>
> +        # vendor extensions, each extension sorted alphanumerically unde=
r the
> +        # vendor they belong to. Vendors are sorted alphanumerically as =
well.
> +
> +        # Andes
>          - const: xandespmu
>            description:
>              The Andes Technology performance monitor extension for count=
er overflow
> @@ -484,5 +488,11 @@ properties:
>              Registers in the AX45MP datasheet.
>              https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-=
5.0.0-Datasheet.pdf
>
> +        # T-HEAD
> +        - const: xtheadvector
> +          description:
> +            The T-HEAD specific 0.7.1 vector implementation as written i=
n
> +            https://github.com/T-head-Semi/thead-extension-spec/blob/953=
58cb2cca9489361c61d335e03d3134b14133f/xtheadvector.adoc.
> +
>  additionalProperties: true
>  ...
>
> --
> 2.44.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

