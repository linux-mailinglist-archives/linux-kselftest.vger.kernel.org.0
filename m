Return-Path: <linux-kselftest+bounces-11677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9312B903B83
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 14:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CB61F23EEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 12:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E221717CA10;
	Tue, 11 Jun 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeJj4q5+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECB017CA0B;
	Tue, 11 Jun 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107608; cv=none; b=t11j3Xp/MslrMosrEnAr+Z5Rw+ApaxK7f3NmjOIyHtJ3Gi1A9nOVG5zAfpUZlLCxP07MFS0ZkBcDGe0YduLUiPOvig+LdklU2jMCs49fT7LtONQabMIYYzIW8fJOV1D2veBLBLb1iQqYBRW4eTyjP9X2dGgHjdlVGsT8UXXxd4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107608; c=relaxed/simple;
	bh=izbQACBXKg7/xAfr+T6NfWco5xbmu+bfnAsIHYpOdVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRH+V9CO0MF6s1QgUf9BzcOyx0gUv/7i4gtViyYRB1pJ3kDdpaHSbG/i1d+yeWE7O54UT98HnMkmVnzJMIQVzA4JiPU6pitqfSiasT2gq5/XTLT7V9NLa0/zx3LNHTXjt53LtOYj09/g59qQaKGE7HHITb0BZ7HpeuDdheuc+Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeJj4q5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACB9C2BD10;
	Tue, 11 Jun 2024 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718107608;
	bh=izbQACBXKg7/xAfr+T6NfWco5xbmu+bfnAsIHYpOdVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DeJj4q5++zj+R3KhmhuzK4d1y38/q9RlXNvB80U8sWohX93yRvAYBbRWeNJI+hEkm
	 k+6zKhoYuXFyb07P2kL/gMmg/FK9/y7H81SPPXOQI54Ebtv+gaujOBYPQ2BRaVYtr9
	 4lnDhr8IOcynWAd4LHkUKBtKY+YHivapA0KcI4qKSTAzc4SDzmPp4RqbTJTVrp/i06
	 yeFezpNqoJVDv03VNIjOBZEqJZ7lwd6ZgUNgF0gsfzovWKsFQcHGsAyw1jhVsfafjZ
	 Lbe7woGXDn9ZOOtxQ1qkBeigUZLfV/hyl1O4hYcRLn41/8zOCV4apxu/JPqpRIYjBJ
	 hgZeTXX2xJnaA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so1420336a12.3;
        Tue, 11 Jun 2024 05:06:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbSviWFWJfPK0DRPTFHzrDVYAa3DrAB+bk4EHedGoObZXKD5al0wKx3VdNcoOsDV8TiJYo0+vNS/vq16CxTfUmQ8Aq+fgLttN9a9jPrZg1YLEL69jT3e1uHJqIua+Qvj7o8u8GlbMKETX0h+jiOy4GFoP+l1oeshbiVH5ZvqyV7MMP/nGwg05F4+wKwTc8e517Su8NUQiRLJAHm03R9akMPEDcrw==
X-Gm-Message-State: AOJu0Yyarp9ksieeZnbCbAf8duz7DQZehWSw1BG4/KCYm81xFAJ28x5t
	LAISqQwnKksuLLvctj4XvVfxpjWde9lbBxVQbiokmPBOhy4b+lwjPaAGtRxza8BQ2Vzy29ap6DO
	XWWvu83SAU9GcwL+6oI/QejE27CE=
X-Google-Smtp-Source: AGHT+IFFPTTll7ACEEwwlIU5pUww8R0bMpeHE5EPA9sRicSO1H8r8Hj10JvtLT4RCL9oaDh0AQArdk5Tw1koxKQr8oM=
X-Received: by 2002:a17:906:b810:b0:a6f:1f66:8335 with SMTP id
 a640c23a62f3a-a6f1f66841fmr408155266b.4.1718107606517; Tue, 11 Jun 2024
 05:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com> <20240609-xtheadvector-v1-1-3fe591d7f109@rivosinc.com>
In-Reply-To: <20240609-xtheadvector-v1-1-3fe591d7f109@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 11 Jun 2024 20:06:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTVu4ZQt+gK7pVYEDVG23Sic=jswkVvX4To=VAD0TMzxw@mail.gmail.com>
Message-ID: <CAJF2gTTVu4ZQt+gK7pVYEDVG23Sic=jswkVvX4To=VAD0TMzxw@mail.gmail.com>
Subject: Re: [PATCH 01/13] dt-bindings: riscv: Add xtheadvector ISA extension description
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Evan Green <evan@rivosinc.com>, 
	Andy Chiu <andy.chiu@sifive.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 12:45=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
>
> The xtheadvector ISA extension is described on the T-Head extension spec
> Github page [1] at commit 95358cb2cca9.
>
> Link: https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cc=
a9489361c61d335e03d3134b14133f/xtheadvector.adoc [1]
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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
URL changed
https://github.com/XUANTIE-RV/thead-extension-spec/blob/95358cb2cca9489361c=
61d335e03d3134b14133f/xtheadvector.adoc

Others, LGTM.

> +
>  additionalProperties: true
>  ...
>
> --
> 2.44.0
>


--=20
Best Regards
 Guo Ren

