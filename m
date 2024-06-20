Return-Path: <linux-kselftest+bounces-12312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC43E91011D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 12:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA071C20E16
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A393E1A8C05;
	Thu, 20 Jun 2024 10:07:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AEC2BAE2;
	Thu, 20 Jun 2024 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878037; cv=none; b=lR3r/iACNCOjN/SXzbG/Ms3SYkobFlLosACb1J4tgR4hAjKC8vv6PY4NA17blonBay9qTIBK4TZuMxe/z6wcSoGBYTaUvQgNnbxVsqxWkXSy0yv45+5NEMaK3RV5dj/yAg+1qSi9MYbmhaOJ9UtYuh3IOzHqbH1HPr/n3pc8Jtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878037; c=relaxed/simple;
	bh=gtlJye50+OfffKjggbOEmtKNH45g/zjK6ZfJA8b8AdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CouKu1g2ujm8uzj3dxLEo4k+efqZoIn0K0mGx2+BH4Ng7NktVsy3arcBu9tIoQVo3iJ6x5c4Jet+xofKsLUJ8Q77iRwkGzx6IdBqARnvvGe2gqb3jHTj3TsClZHFbZaag6KnDnNlJA7coGXa5ZdA2VT/7Iruk9LYeXPVMyKzdiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so7082151fa.2;
        Thu, 20 Jun 2024 03:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878031; x=1719482831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ir1hVcg7ykDi/DMYCtyM630+t+MR02LhBXB13vEhoEE=;
        b=HWadjFrxdhidJf581/KHMFU37LIsrX/0ubkpYymrRmBLj4wvzBfCyuIDqGI1wgy2at
         lu2s7oSKpDIKTJqNq8o3gG8UPs7PM71+pmuwq0jfoA/Vgkk3Kt7e0zWNAXmQLIxtbFi1
         3H2FduzYdwH6eBDR74xWTKptMj4swB/C6F1upRRsQ/ApHdbj99mm5Oy2MaAxNaI/DBZH
         SSBb5cqMd5ocSR0mRozDOXTxACdRnXXB7+ZBWhpXGXEa3HZudfulFoJ8MVNV0TcZR/pD
         MUI3aON2EyjPi8/1GDP/BL6ngWojhlZ6Wm1BKzdGdNR7aKH8PBvdgQbtotdmTQE4X3Be
         zdJA==
X-Forwarded-Encrypted: i=1; AJvYcCXBwQTfodVpvWU6iyiDoUuuOs4DUjzm3WdganSnOWuCffmy6nbG746MFLoCFgrohnDsC+9FS7wc6WdXWbSWQcve7et7Xo91xJpsKCxUQ+vo5MvfiQqLHRIm3UeWZG3+XTCF78QcgAIkacCLGLcbenwmkOFQOOspILe8xm0twQIGhNN+IuQ2TEdynnidcYYnfgH3orSqwJ4JhOUxLKxUpHNKr+3xkg==
X-Gm-Message-State: AOJu0YzHuMg6bjZSMyCboPguWpo1q8YJywLVBDZWaOPGMbImsjayt59F
	64S7Exb4E4njmx/6aChQsOtyd9i+dZlxnlj9ajqxU4hYyuNVbQRvpXhyUQHp
X-Google-Smtp-Source: AGHT+IHyWFHFPL26B3ZfZfKkuSgAC6BXeGhWLtLKr8pp33zaKyC/TKmg3uHEqLkwMS/Udx+d/1ifcg==
X-Received: by 2002:a2e:9046:0:b0:2ec:4211:e9dc with SMTP id 38308e7fff4ca-2ec4211ea8emr18468281fa.0.1718878030548;
        Thu, 20 Jun 2024 03:07:10 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec45542b7asm1646711fa.29.2024.06.20.03.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 03:07:09 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so7112321fa.3;
        Thu, 20 Jun 2024 03:07:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW78aCKfgTlp1XJ8AAfi3OCmf7iWDyNIzaVVwSPDqGymV6qvtsfZan1oiVMAz+/QWOQx0sp7mWbqcUiaNRw5QZ3DgyiUZ/BmoJRgfNjmkWH2cGiQKIICPA7MtnY3kzVzaT2EW+HT81SRjqVFg4KQC5952bLNVq3N/cZnppt11HL/bGl++FAXmfbPkI6Q2LIYzxDjk4pgcQ5H7bYi9qJYuYWkzOqfg==
X-Received: by 2002:a05:651c:90:b0:2eb:f8d1:87d9 with SMTP id
 38308e7fff4ca-2ec3cecca82mr30693691fa.31.1718878028507; Thu, 20 Jun 2024
 03:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com> <20240619-xtheadvector-v3-3-bff39eb9668e@rivosinc.com>
In-Reply-To: <20240619-xtheadvector-v3-3-bff39eb9668e@rivosinc.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 20 Jun 2024 18:06:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v64ZuLhnZn4G_Zbqqosh46Fh57WtXCcCFkwMA2phtLzq1g@mail.gmail.com>
Message-ID: <CAGb2v64ZuLhnZn4G_Zbqqosh46Fh57WtXCcCFkwMA2phtLzq1g@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Jessica Clarke <jrtc27@jrtc27.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 7:57=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> The D1/D1s SoCs support xtheadvector so it can be included in the
> devicetree. Also include vlenb for the cpu.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

If the RISC-V maintainers want to take the whole series.

> ---
>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/b=
oot/dts/allwinner/sun20i-d1s.dtsi
> index 64c3c2e6cbe0..6367112e614a 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> @@ -27,7 +27,8 @@ cpu0: cpu@0 {
>                         riscv,isa =3D "rv64imafdc";
>                         riscv,isa-base =3D "rv64i";
>                         riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c", "zicntr", "zicsr",
> -                                              "zifencei", "zihpm";
> +                                              "zifencei", "zihpm", "xthe=
advector";
> +                       thead,vlenb =3D <128>;
>                         #cooling-cells =3D <2>;
>
>                         cpu0_intc: interrupt-controller {
>
> --
> 2.34.1
>

