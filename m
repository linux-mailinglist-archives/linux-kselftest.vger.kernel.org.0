Return-Path: <linux-kselftest+bounces-19130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E01991F88
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 18:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0E92824AD
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F9618991A;
	Sun,  6 Oct 2024 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMNSDbke"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E93813792B;
	Sun,  6 Oct 2024 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728230673; cv=none; b=TVZGKXbn7ctyTuUMALkRFqzp+UIOjpdNO+KeYIDhxPx2lJMCR1fxVCyqk6A8pgEORRbZAgBHMOw/khR0zCGSkuczxQ86ZguBvo00in1Z+QazSR2O5ivQxYgVHTyhwSxfOKSneuZxp3xV1HtQPYUaFMMgPFYy9BnXVReZH7KsXmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728230673; c=relaxed/simple;
	bh=34Fedq5x8l/T9bE90W84WAGeoMX0EdQtZtaZfYn9+js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ny6zkm/VV3Gukq3vvmnZ6oJ5bOGRFKcHl5ySWqBo8hWQKRodwEiZsWPgILx2ukUYFKuCZkhhy5xAnkgY6JdtmnZyXg66X/kxeNffFfrhB7r3DY6xWbQgkw02vb57Juim6MHplWe/KSEd0q88FJWBmGSRvexST3P7syaK7/C0VBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMNSDbke; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e28ad6b7f1fso711140276.1;
        Sun, 06 Oct 2024 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728230671; x=1728835471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uch5zWkAziPgJRQdKvEezF5yVQHunIRJ5aY+mbi1jxQ=;
        b=HMNSDbkehz2EdKzm1+9jrQgZ4qWuVoTXvsP7sG7IWFM2EIj86sZs7+zoGGayOyDqfp
         5zfP2dNVi26ZOaBb943JPSh/xDBOUr0lezlUAaTWHmPU/fYeph/Tnjze33DEqyIQjtqF
         K6mFjwPinl3iyngOnbkm6kMgkOzVNAG/MGssZ1ovp1JNHFinE/iRcF4svb+yKoNWuLT+
         blg+W88beWa5tJZsiHTVlyCoRxlbpWJMRfHSPvpnAsl9lkLiKXY7OCTa5sRiX3inTtDz
         PJo0bl0LAnJpFoZ42Bem6T/jlIAF4UxbsZFa+F+42o7z8bIllv9yYLS4a4UhPOEwwz4b
         MCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728230671; x=1728835471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uch5zWkAziPgJRQdKvEezF5yVQHunIRJ5aY+mbi1jxQ=;
        b=I3KP5EzYI5dF3w/a7thdk9v4m/ZgXJqrDZRVB5EvORYWGdF1H67+gcNTbTH475U3Fj
         BhdjQ6BSL4AsEk1DXz9ebzvdDMEZH9xMyaWNK/wRxPAIyhdPOSR9qFHfpOY49jAxhgCE
         RKyPJ3URLx5nYeEla1aDKXE+Y35I1U/Up7yUTmNyI7IZWQUOVbqKxGgYKeMdLXuepHoG
         UhdCWvaAc+UDMnb3r2rIoTlCRQB6+PtkWS3m+Kb5g2g9FM0aVw6/bYhX3/1VJ/EFNzQZ
         zLIDEL+B309yvdQCdn1E86IKE4l/2MneYALeWrarohSu5d4eDz/NLEBRQk16C+D1bmEW
         i1pw==
X-Forwarded-Encrypted: i=1; AJvYcCViIRKwcHJ3s5GkG85TUx4wykDrABenr0CLGOkSd0FkpqZ73om/QdR2SPXAwTxf/+10ZwhhCYvQRcFI@vger.kernel.org, AJvYcCXefFM087Gmoa11+fbumjBqdFCI5df0smPB1UAtEmErk0PifVWnqDq/71u2jGA8uMVJk1lPmqYQlz4dEw2SvEQc@vger.kernel.org, AJvYcCXoeFjM4VbqGD1IT+8DCf9erOorDYrYq+CaJ2BQqEKqPRGJ0uVmxbnDxtqvrsKtIetx984PNnCHyFyEfZh0@vger.kernel.org, AJvYcCXqZZGUoRwC21WNfYz8PspVR18J++iwwGgpfcyO4HAzAmhaG6mQa7cxGFt8PNFZ8kLUpd2naStL8bjA@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQDuhDHUyhsRnwla3KzzOfKE5AIVY05K+dB0wnA4Ko/OZnWoo
	tuQyigzMUC+UDC6uyIJsKpWWnbVn772GiawpE58xdeetg8TpOu2oFaK8f41l++tehycKnVFhYxN
	Cig3bp2gDzxw3WKiSoMa0ZMF1wCU=
X-Google-Smtp-Source: AGHT+IHghEmYGvQOkKyyuJZaMY/eRKpityYTGhDKnMiJovkVuEa93BGTo1Fa/3AOIwWu8CpUXNrp8IgagfvkZZpUw1g=
X-Received: by 2002:a05:6902:1142:b0:e26:1041:4986 with SMTP id
 3f1490d57ef6-e28937e2eadmr7591066276.26.1728230669839; Sun, 06 Oct 2024
 09:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com> <20240911-xtheadvector-v10-6-8d3930091246@rivosinc.com>
In-Reply-To: <20240911-xtheadvector-v10-6-8d3930091246@rivosinc.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Mon, 7 Oct 2024 00:04:18 +0800
Message-ID: <CAFTtA3M3NhooM5u7woDO3juAgQK=EpF-aSf69VJm30aj7iNfZA@mail.gmail.com>
Subject: Re: [PATCH v10 06/14] RISC-V: define the elements of the VCSR vector CSR
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
	linux-kselftest@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Charlie Jenkins <charlie@rivosinc.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=8812=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:57=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Heiko Stuebner <heiko@sntech.de>
>
> The VCSR CSR contains two elements VXRM[2:1] and VXSAT[0].
>
> Define constants for those to access the elements in a readable way.
>
> Acked-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Andy Chiu <andybnac@gmail.com>

> ---
>  arch/riscv/include/asm/csr.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 25966995da04..3eeb07d73065 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -300,6 +300,10 @@
>  #define CSR_STIMECMP           0x14D
>  #define CSR_STIMECMPH          0x15D
>
> +#define VCSR_VXRM_MASK                 3
> +#define VCSR_VXRM_SHIFT                        1
> +#define VCSR_VXSAT_MASK                        1
> +
>  /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
>  #define CSR_SISELECT           0x150
>  #define CSR_SIREG              0x151
>
> --
> 2.45.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

