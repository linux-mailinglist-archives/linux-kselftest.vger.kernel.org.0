Return-Path: <linux-kselftest+bounces-18912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C0098E03C
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 18:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D27B24D06
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 16:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415CD1D1754;
	Wed,  2 Oct 2024 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYd+k1PM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D4F1D0E19;
	Wed,  2 Oct 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885152; cv=none; b=anuy0Dd/dZgsvkpQ+NgEq79Z4y657tfS+GxK2UC7COg4KA3FuhDzijSHGNBxUW1otgsz0Da5ooogbSDeAGxc5j3wxnpcKLERprQW5hAVit9XRgIhDzsz8S87C88NZnTZwWoFr5ZHDC+uHocxaIbs52m0L6l7W8JYIEzo5r3pCTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885152; c=relaxed/simple;
	bh=ANC8Qb5v5SRqtuiLPKYG+H+JN4dcEV1+gCnN8O8CSzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=br+VCjXfC0RfrB98mPE0rRXKezvM6rYfakfH31uw+aaikBw06nEEKGEAUCCrWDwXNmm17Q1J8ekfoQsIsuEhvV9YAWBSkV8HhDVoIvyAeRQH9rwmrqwehzhNwe2Cwg+Jz2XGwPC9nxwLDzyyDhCyWjZICPUT2VLDsYTDFUXMxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYd+k1PM; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e026a2238d8so6518385276.0;
        Wed, 02 Oct 2024 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727885149; x=1728489949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5N4+gqSeb1KPAY46BU6QRBcQA4A0mtfnF/DfhNnvaYg=;
        b=lYd+k1PM4b/13J0yKmWMpajFuR7pXlkFiTCNq92vPjS2dQX0+wdKMdwNTw4dDVypth
         YfjZPAS11Rmyqhjw1JSDO2zPGu2el/KvLyF7nTBA+C/3VIV/t884hBnWTfE+LoVKD1pY
         3yaFNoD8SVrKOC/QKgpoAb+DvjAl4vMka2C7NmazvclCW7ouE/dfdqyHc8oISX3F2ti5
         N+whIeNLMBRgQEEKJY6DKRPaFDdwwhYCmpQ2Jr5hkodwxTBD7qZUhmCNe5DcyfQVsvvx
         uc7eNI9m4AB7DbKkmDSsGQF9NJIqTDBknTXr7satS10wKo14bBDLRwkeY8dBr7GmBjTo
         0SWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727885149; x=1728489949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5N4+gqSeb1KPAY46BU6QRBcQA4A0mtfnF/DfhNnvaYg=;
        b=kkFCroGLLq7RlLADkQoxJDCL8QhWNtiWJA6/WPwafy+bVJt0ob49Z1d9IT2fi7ekO0
         HorvvaGkQ/8dvEcD0hTNQGmpbW+oNB7UP6tuuM/klFdiMIBJf9xWUsDAwlt6TFpuSMnH
         RKrP9DZ27MNfwnX3eSWBpX7+9Xb2bI9Ko/98MlwptmUJ18J89puqb4j+8XzVjFljN0bR
         0cc3V2aL8vQqDFsh1ta5YaFlOeMAmIL3snqzFj8DBiMdnrh9w90A54Suzamlfh/LJQ/K
         +flc0WkEZDzfyCVHq/D9Sg6d0YPHH8qhYvcrEg22A3Hb//S8o3kagSEH2c9cB4XHc3V0
         Ljyw==
X-Forwarded-Encrypted: i=1; AJvYcCUXSqa6EmUf+KADdvGyej7t10ix14U2MLcVtpDs+UPrzXCeRpiChMPSgvunWMyR6xV/Y8jshyLuyj/RreK+@vger.kernel.org, AJvYcCUfJsTuV6ow86c/igjXVgNnxyKw3Zl+lUhUCjmR5Y1eNaZ/jKjWL2zMvYqA6gIDsma/a92kFQa4ZUP4@vger.kernel.org, AJvYcCVWkjhAaaPU7Li2WBdF7MGyNewfL5g8xckOxt9w43Pw1vVyL1nbcWobrjBPCcpweVqUM4Gz2K6mDmYV@vger.kernel.org, AJvYcCXIp8TfskynNFBr5sI0s10G3t9RcH8GN+6jenerN2g6nA+Ki25Z4DVpgBsNQd+Whu0laQb002441kxVm8gr/SAi@vger.kernel.org
X-Gm-Message-State: AOJu0YxUQsdUAB/1T/XoH9utdop9uXQjeGY9P3GgVwF94/hfOHfrglJt
	JcwIopUgeJ9rooPffXx2KqfdydFwHdcLRMOMSh5zPQ2leMiSl+0m0rq0nL3zh85WHmIhnSsvqpX
	fDnYh/dBAE7C2h90tqfzRkNlES8E=
X-Google-Smtp-Source: AGHT+IFUlmzbLTsFGYihjtzA3b4/xF4lQlYRCLWv50QanOiiRb9UJNd04Ll1C8wrxpzQb0JBZR9YOz+0MxaVbPy8aQQ=
X-Received: by 2002:a05:690c:6d09:b0:627:778f:b0a8 with SMTP id
 00721157ae682-6e2a2e37b2bmr40441297b3.42.1727885149175; Wed, 02 Oct 2024
 09:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-xtheadvector-v10-0-8d3930091246@rivosinc.com> <20240911-xtheadvector-v10-2-8d3930091246@rivosinc.com>
In-Reply-To: <20240911-xtheadvector-v10-2-8d3930091246@rivosinc.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Thu, 3 Oct 2024 00:05:37 +0800
Message-ID: <CAFTtA3NwGFioVAeipkA6aCUfRY12jKFJiR7MaCpCYNjdsT7TMQ@mail.gmail.com>
Subject: Re: [PATCH v10 02/14] dt-bindings: cpus: add a thead vlen register
 length property
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
> Add a property analogous to the vlenb CSR so that software can detect
> the vector length of each CPU prior to it being brought online.
> Currently software has to assume that the vector length read from the
> boot CPU applies to all possible CPUs. On T-Head CPUs implementing
> pre-ratification vector, reading the th.vlenb CSR may produce an illegal
> instruction trap, so this property is required on such systems.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Andy Chiu <andybnac@gmail.com>

> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 19 +++++++++++++++++=
++
>  1 file changed, 19 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index 8edc8261241a..c0cf6cf56749 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -26,6 +26,18 @@ description: |
>  allOf:
>    - $ref: /schemas/cpu.yaml#
>    - $ref: extensions.yaml
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - thead,c906
> +                - thead,c910
> +                - thead,c920
> +    then:
> +      properties:
> +        thead,vlenb: false
>
>  properties:
>    compatible:
> @@ -95,6 +107,13 @@ properties:
>      description:
>        The blocksize in bytes for the Zicboz cache operations.
>
> +  thead,vlenb:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      VLEN/8, the vector register length in bytes. This property is requ=
ired on
> +      thead systems where the vector register length is not identical on=
 all harts, or
> +      the vlenb CSR is not available.
> +
>    # RISC-V has multiple properties for cache op block sizes as the sizes
>    # differ between individual CBO extensions
>    cache-op-block-size: false
>
> --
> 2.45.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

