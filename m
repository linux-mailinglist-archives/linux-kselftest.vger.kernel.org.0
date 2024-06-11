Return-Path: <linux-kselftest+bounces-11688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855EB9040A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 17:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B168285EA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E2D3B28F;
	Tue, 11 Jun 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="s/ry5662"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D73839C
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121558; cv=none; b=qI+nqdYgD72YnhMX4S+wkFIfNS3zSh0HvfuWs5RKDfPeUo1GamzcB3Gdr4pR0roFHVwm6o9J/WWd7r0FqHXRfBqgn8l3podNqbUpNsVHQXbgMSDSK/PsJGWaybxJ/FyMzXMNyMirWbPYIsfvnsI6RYko8t0tqY1yEoNzfn/mcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121558; c=relaxed/simple;
	bh=HsSfwE4c9FKwzt2D18mve0ctqok3simx/c6Sk4d9mD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bbkgalp3h3vMPozlUxRlkeegYnQtDsh9NoCcWEypTRq2Bn37m8tPtCCKIobCecG40W4d6C/zhtaVI+liufGI+vrHLBYMNmg5jmDtl613FgUiOZiuNs9+oTdLqrwdIPD1wGIuyDGN9WZFAlfwbgnjMLrkcGDk5nY/+sa+A1RlloM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=s/ry5662; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c75464e77so1663163a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718121554; x=1718726354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KeeLnew4Dr2lt2iWiQJB+NWU2kaX728eR1Y/pdt+oA=;
        b=s/ry5662Ge+hWbpEAGorm7hqKMZpZcv4wxPprCcclHLcbNXybxPYxyzYt6SpTbK8lk
         xzj/neGZvGQCCVqomCcHuBX2n2t5Sw/wma4lwmXtiUrCxkHh9ijuHpJwxy/nnyM08uvu
         nhKM77yPVFu9B91OourqJO+UmrDMiajArZkBNTRan+yrSGUAAc4P2UoYeXT+3cn7uLzM
         KrmG64DemnXC017Qhj749vZw5+c3BcaQlR9Lfxct3b1kgWEig7quSDiYXDVBcBPqxK6J
         u94g/GyF0iKyegEROSXhGtbmOi72nRF2tfisVYDw9nFdq7FhW5gS/5i8SlGd0zf3euvD
         WiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718121554; x=1718726354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KeeLnew4Dr2lt2iWiQJB+NWU2kaX728eR1Y/pdt+oA=;
        b=F8gX39QnXnoixq/79eqX8mX68YJo1tVyfgRjR6UfA3fvZNeEUs5JdOeGIq78SnIaPQ
         7pNsS7r1uEXSngZ69qNk5z7KkQODpAAzBMVVAeEenk644VHdCYP63VVevU1SN3M4WbMa
         H+BcecteLYtDDjTFeuJedBBWxDxT2jhvqLJBebM3GJASXU3NihCW5ZUsJzxLlA6EW2Ou
         /v92K/Fa7uvw/E0cxmhyv5LlnrpyFnkQ81FVaKHtl7gjjg1zE4Ofkd6y9+XT9FANTKcL
         TEZGKfFJ+C/0bvRVUVKML/TQsmgpcP/78C+e1E3JYQ9HL9C8NOG53eL7WPTnq5g7RHft
         Fo0w==
X-Forwarded-Encrypted: i=1; AJvYcCWKBF044G2UU2g8kdhRSOZ35DhGgWRcq5TAuiceOTs6De2WQXqbi8SOmzD13b0RkRFXSQcqiEzuGLJ11rdayVKMqyazb/zwGUDAyjvLbgMH
X-Gm-Message-State: AOJu0YwcHqQQtUcdC0M6jUOKL1Y/QiqkV0IllC4c2OqbHAzHwODl2f65
	iWNgT8EU6REYa1XS6K2gFZ6gVWtcVOpZOu8q+C+Xj0tG4eTEqRBlDjUNbFeEGuhnzDRkZVlF4Vh
	hb9DJWPg1lkX850bm0wDrvuvJg2JpwoNZhNQyYA==
X-Google-Smtp-Source: AGHT+IFtN4cYhXjGsiGLi9dtTvtTxex9wzVTtZ32q9gZra1QREy0esNjyQa0xfTpDsvoF9kv8aqdxu0J/DY1HdrDZBE=
X-Received: by 2002:a17:906:2811:b0:a6e:f7bc:dcab with SMTP id
 a640c23a62f3a-a6ef7bcdd76mr607353666b.65.1718121553604; Tue, 11 Jun 2024
 08:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610-xtheadvector-v2-0-97a48613ad64@rivosinc.com> <20240610-xtheadvector-v2-11-97a48613ad64@rivosinc.com>
In-Reply-To: <20240610-xtheadvector-v2-11-97a48613ad64@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Tue, 11 Jun 2024 08:58:37 -0700
Message-ID: <CALs-Hsu2jFAfr7H9UfLd9VHEZvpfF7Q6Chxko3XbBZBCU94eSw@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] riscv: hwprobe: Document thead vendor extensions
 and xtheadvector extension
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 3:57=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Document support for thead vendor extensions using the key
> RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 and xtheadvector extension using
> the key RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Evan Green <evan@rivosinc.com>
> ---
>  Documentation/arch/riscv/hwprobe.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/ri=
scv/hwprobe.rst
> index 204cd4433af5..9c0ef8c57228 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -214,3 +214,13 @@ The following keys are defined:
>
>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
>    represents the size of the Zicboz block in bytes.
> +
> +* :c:macro:`RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0`: A bitmask containing =
the

Our recent snafoo with CPUPERF_0 popped into my memory
when reading this. Does this work properly with the WHICH_CPUS flag?
Specifically, we need hwprobe_key_is_bitmask() to return true for this
key since it's a bitmask.

