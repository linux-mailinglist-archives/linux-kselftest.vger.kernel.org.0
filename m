Return-Path: <linux-kselftest+bounces-19131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBAD991F92
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 18:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE3E282029
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 16:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860C8189B85;
	Sun,  6 Oct 2024 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R584vS9y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADD3187554;
	Sun,  6 Oct 2024 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728231114; cv=none; b=IWl3AF+NUJKoUtgDZM0QLfAWao4nblKQsyQO11tFxTb+K9TcjToG4o1vHRTQYyvv6Mzb9tXc2YV97Cye2mqP+1A8DJsD01HLmNgFoZQJKCnfZheq6qQ3N7Dn5IGDKclLxvgQEK+UxaQj93j3/HKWewfRpFtLAhVgs76hy835bMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728231114; c=relaxed/simple;
	bh=tDJ5s5zYFjkOd0VeumbJCL2tSq/9mRwCV6dnYOXYKzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRkZdaoli+hNwYOIHB39fyRUua6nFRW5ZaJhmp0dkTcqnFw67BDZnF4/goo/jM+lELZxIjdtDZKZDJpLf+TDH5GQBKLwhc55WtWNriEs4dH6Aj604p8Bn2VK16FrDRyA2q06pL5W4bBEWU0S4VdgZLcP2EbejDQY8Gr2A22u6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R584vS9y; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e28ad6b7f1fso713444276.1;
        Sun, 06 Oct 2024 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728231111; x=1728835911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAYqCIiSv61sSYgvtWT29++OHzmZnVI7JlxP4WixgGE=;
        b=R584vS9yiMsA2yooXYgto+mQ05K6NsPXv59ALMRi4AIDvt5yQ4eshKg04yTpOK3ofg
         m9RLM/0+YBV/oI20f/lCgA7xM09DKtFbCwfPQUHFt+619vOfzoRStEuBrsyRIhufFnL9
         mKzmrLcp2lX/LVZuuM2L6mGkm7TakhM1e50HlJrGygIw+QX7V+I921K095B0kIwxyUQ9
         z0j6V2B4Cu5zsr+dxDlz+4EXc4bjSyRbzf3UmENjKY+HVLHoHDoUa1z2Cpwz6Htx50M/
         qyXn8JnSST71ecBKOebv3hFWPssZ29qgmhcGmkIUprQl2yWoWsSeNcLFaIZ9Anjm7xc2
         LKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728231111; x=1728835911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAYqCIiSv61sSYgvtWT29++OHzmZnVI7JlxP4WixgGE=;
        b=WRBpRcrZj2YFUUvEo/xprdRa7HVv2acSljPzsRp9KCV8u6w8OUUp/XMomKlqeB2nn6
         hsO4v9jt5MSXcUjnv5918v4HYV08BQIMOuzKNGmRrLdCmKvGzkwACtHvsS8cu0Dkoob4
         wUKqtBTNgAT0DRO5Uz97l9exWfJCr39tFs+jnxoU9eVHivDbH610eQgLy6q5BcZ6saS5
         dv9mZQLR1e+Zp8LopF1eSKNYaEzUsUAjDQaw9XAN3qQtoEOqycZJ18kbjWmNH+zYsati
         4xXloBfLOpXPv7VqWPa8+VasfCoDKB68/SjN1Oec/HNjo6igq0JYbloZUxsni3YuDBlR
         v/9g==
X-Forwarded-Encrypted: i=1; AJvYcCUOnIC3x2QJDraxPfV9UpawZJWwg63Ltfyc/tAOTkSIZzrlf+uMzcvsBZP7K5znw/abxuvo1m+CT37assCOTdP+@vger.kernel.org, AJvYcCVtvxdcni7Xt/PN7ZY6UvD1gF/TIeDvKgr4DKMk0VmtQsVn1G07It50pYmYK5D8KAES5Kk2jpusZ+JRZwjC@vger.kernel.org, AJvYcCWhL7eMA+i02m9KPxVYXWL7jnIqPgRejOISBfEUXxGdsqtcWPh261CIwnH4dkq3eIaGHez/nSO7SQu1@vger.kernel.org, AJvYcCXuxsiYp2Qvib1J5P7jePwMqNgRNmta/PQEESSU78/6ulf8Bybhk8SfIqubMulP+NqHqKoICEWiFqRK@vger.kernel.org
X-Gm-Message-State: AOJu0YyFLrOhHrlUHGqPupe31kl/3LCWbTQwgxuc4kyDv8Ol3L2evYKv
	OZGpgrdwlSEdRG6soATkn2Jfgv2iIV3nOiAG+C92fSTiXG3CI0QHw/5NEGq+p3goAL7QtrjIGCk
	ryDvntaTlClDHhwUEVeHyW0ff5uY=
X-Google-Smtp-Source: AGHT+IFqMHlb0b8SgKw7RwjBG7Z/IYs0/8p3F6LoeYW5kR2rfijp2j/qGjYCoWovPSzlMmk0//HTDX0lUYq3PNC/rQA=
X-Received: by 2002:a05:6902:2b8f:b0:e20:16b9:ad68 with SMTP id
 3f1490d57ef6-e2893951b87mr6248949276.45.1728231110621; Sun, 06 Oct 2024
 09:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com> <20240911-xtheadvector-v10-7-8d3930091246@rivosinc.com>
In-Reply-To: <20240911-xtheadvector-v10-7-8d3930091246@rivosinc.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Mon, 7 Oct 2024 00:11:39 +0800
Message-ID: <CAFTtA3O-sD-cJsHL2LgwryXwEnuEKvnP6QrTn7GMFYZmP=A3iA@mail.gmail.com>
Subject: Re: [PATCH v10 07/14] riscv: csr: Add CSR encodings for CSR_VXRM/CSR_VXSAT
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
	Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
	Andrew Jones <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Charlie,

Charlie Jenkins <charlie@rivosinc.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=8812=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:57=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> The VXRM vector csr for xtheadvector has an encoding of 0xa and VXSAT
> has an encoding of 0x9.
>
> Co-developed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/csr.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 3eeb07d73065..c0a60c4ed911 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -300,9 +300,14 @@
>  #define CSR_STIMECMP           0x14D
>  #define CSR_STIMECMPH          0x15D
>
> -#define VCSR_VXRM_MASK                 3
> -#define VCSR_VXRM_SHIFT                        1
> -#define VCSR_VXSAT_MASK                        1
> +/* xtheadvector symbolic CSR names */
> +#define CSR_VXSAT              0x9
> +#define CSR_VXRM               0xa
> +
> +/* xtheadvector CSR masks */
> +#define CSR_VXRM_MASK          3
> +#define CSR_VXRM_SHIFT         1
> +#define CSR_VXSAT_MASK         1

nit: use VCSR_VX* instead of CSR_VX*, if you need to send the next
revision. I believe these masks are for CSR_VCSR but not CSR_VX*. If
you think CSR_VX* is a better naming then the previous patch should
introduce it as CSR_VX* but not VCSR_VX*.

>
>  /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
>  #define CSR_SISELECT           0x150
>
> --
> 2.45.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Thanks,
Andy

