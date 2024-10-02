Return-Path: <linux-kselftest+bounces-18907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69C98DE96
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 17:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7D29B24516
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492491D0B98;
	Wed,  2 Oct 2024 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWRmLFKp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A641D042F;
	Wed,  2 Oct 2024 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881651; cv=none; b=DEpbU2Of1UMWdIbqdSdm+Xg22QdExRzCMbkANAxJJ6Jg69lxwrPKqMxoTJEVgclxTmJg3J9cCQ6Q9sM6sb3GmWvzm7eVC5RxNh+dRgU5w8zBwxvPSYAERGU18ZlTCtJUemp97456cAALEeqBr4gVpKlnswEtaQvA+rVuV18G4Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881651; c=relaxed/simple;
	bh=jtfaJpM6CIsQrfnb+cLDUgI28lgBAwSL+kJtu3n5UDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjJVjo0SFt279iyEsWXoEwxuESDZENyY7O7YOBmRTJh4sPF2mjkzLUQwWmNedOVyMdXdhptPZ0EV7+pS8xzCkPvTz30Qcaupts1ESIhqW1WYpLlQ9vZSgHrlByzkl8Dx9YcWa/LUV20r753zykDhJRbQhBeKFSFSsPt5IhUWJhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWRmLFKp; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6d6891012d5so56803687b3.2;
        Wed, 02 Oct 2024 08:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727881648; x=1728486448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0i3BbfvxahvYvWq4i93XsiQMPyiTP9IxQ8M027AZbg4=;
        b=NWRmLFKpAXksQ0bP64ya1VGXtSfEGtmBo4kyehMJvTCQAYxyo1/4gW9ZzzUeWpJ2lB
         pVRZsqU7U/8nFpNttUVeWYEpKmQjOWdx6thEiSo487b37mRgJsQ0DzA8a9AQT/IXK2c+
         9qCzznb9xGfXKGyQVhTI5LWVZ5xnWJjhMGDTTI3Is+en2u5T2LrD3nzakZcaNl2p4stq
         3nHigIJp5FEBrlO8PBqEaDx/bkqOlY5xs8V8xhxNPkcwe09DchiX3EF5VpwkVPB1VXV4
         zO/OxU1cOhgPnFqKrq9iwPUxlhLIdC1xb1ZxjMGqEGnp326eAQ8GJfn5jieUw2yvb2Tv
         T2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881648; x=1728486448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0i3BbfvxahvYvWq4i93XsiQMPyiTP9IxQ8M027AZbg4=;
        b=cs2ViLxpFBnZDN/xzlNRR1PxDif9XsXULLdahSFRvcNsSwh84wWiIo13inRqzWzXEO
         sY5tpOojAzyn9JyY72XbiiwLf9fcNgtI+WZsBU5imm3RidEO4dLOqbemR1zQbk1h8rPa
         2pUlDHRy9TVAaHtcJShCKEOBr9OpFdU32xfKEBpudgidIZAFvVMDL78mxI56UCv6Yd+q
         c9PTtjrM6VTA9Gav06+PzknPKCnTZgkSeaFmrW3tBMg2hfsQFAg4p7wH7KYLSFM7VlvU
         dehoQcGOgcWw46cJ6IfsBOYTA3uNeUqJY4UGnaUKpSP30HqZU9SZIzMLZQt6d4WYXC3L
         Bgiw==
X-Forwarded-Encrypted: i=1; AJvYcCV0fTtHUQSHz26wMQrtLWAbZxo0CcllU+EQI4DCUiyIFpPFKuPB9kgdpmTJbCdVUXBB4jlhS5JMF/QB@vger.kernel.org, AJvYcCVdl28Ka4zKln1eY5IImLmF70XbFuXW8fH3dX5AUET+J6E1PwsxxXndoSQGCQVT5lOqdLy0ptMN6EqTWzq3k8Dt@vger.kernel.org, AJvYcCWl+NP2Ep+RQuzROe6cLFtiFvD2stiHvmlE7x1b2VIBjQGXVEb+TVl8MFeW1JxG+DGlkEUgCAUAPXGnufK8@vger.kernel.org, AJvYcCX8G+dF9oLra+3W9DIQ/X3AvGNx8zNDa8m3KGvVfbAtBFbdBZT9GOwFvwDB7f2x/mVWnGEinuFOajo9@vger.kernel.org
X-Gm-Message-State: AOJu0YwH15q5uIz2FBtiE4jCzDkiRSlCBLNPG+fG35dmoLsLMmzZz8JT
	swfF1gi7rq3VdTIQuBNzbnh6EYK1vgzYkIZFAFVMWJqhznF8AWdDE1EFA/DKTAbgIi8Pq6bS+ie
	kUto0i39xJuGGCou6n0hsv4Vb5yM=
X-Google-Smtp-Source: AGHT+IH+TSllG/SCeTg8S09DQGLvV3T6Fg+wFdmO1qdI5EdM4tgcUUTykKxpYGsG9/W9hoY9YTFqiimHmtkpgobguAo=
X-Received: by 2002:a05:690c:4183:b0:6dd:ba22:d946 with SMTP id
 00721157ae682-6e2a2b8307bmr22986657b3.13.1727881648440; Wed, 02 Oct 2024
 08:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com> <20240911-xtheadvector-v10-1-8d3930091246@rivosinc.com>
In-Reply-To: <20240911-xtheadvector-v10-1-8d3930091246@rivosinc.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 2 Oct 2024 23:07:17 +0800
Message-ID: <CAFTtA3NwY7-KbtqWTRoDLv7AGRUo2efQrCa8=hfpPo1DB1RHyQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/14] dt-bindings: riscv: Add xtheadvector ISA
 extension description
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
	linux-kselftest@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Charlie Jenkins <charlie@rivosinc.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=8812=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:57=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> The xtheadvector ISA extension is described on the T-Head extension spec
> Github page [1] at commit 95358cb2cca9.
>
> Link: https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cc=
a9489361c61d335e03d3134b14133f/xtheadvector.adoc [1]
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Andy Chiu <andybnac@gmail.com>

> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index a06dbc6b4928..1a3d01aedde6 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -556,6 +556,10 @@ properties:
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
> @@ -563,6 +567,12 @@ properties:
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
>      allOf:
>        # Zcb depends on Zca
>        - if:
>
> --
> 2.45.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

