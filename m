Return-Path: <linux-kselftest+bounces-39328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 404C4B2CC21
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 20:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7441C23935
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 18:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902842FC87B;
	Tue, 19 Aug 2025 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="XAi/cmsJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D87B248868
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628448; cv=none; b=YH6MLRpD5a8AKVZtzIGvEMaF1CSK9I7sjaNt6ZpP4eor8GlrXvwDrITD7oiuORNiU8BLvVA7VvD7MrPL4PKq2cz3i+DJJDykrfnXQzVLVfO7MEfCNhggmVuQvU1zm4/F+cu1HwAS2YiAyld61cGyn0ecROlnnKcvzEiC7TpFuGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628448; c=relaxed/simple;
	bh=paEg3ldhezYVlcpk7Gei68Dh31x+1EJdDOc614XBmKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cc+rPO3Iw30RdMDM6n22K1xlDxYwAGfAc1dgilDq5yj5xEcmgH126J9j12l6B2qyOJBTwvxZ29w8DWVOq5ceROvblhPf5dFAE1CISqKvh3TQSU/t3kNvs+OhRwZBNYNN171PFx/s6zw7GR/M6T7Ttqk+wGitlFwu9rtysCXrEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=XAi/cmsJ; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e66937e452so12460255ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 11:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755628446; x=1756233246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RIAFx2sAZr1aaxi1LZMuk62XnAozlnUi2qc60mZCUPc=;
        b=XAi/cmsJzxo4oFcOIuXk+tZIhGAA0IbbTMM3wdzJR/pb2guTWmF7pyoeUgkDwNWeHR
         SPKjDs3VBek7XLd2h3hezVLR1brTADLp21HqgYLMVS+7G6YMIhRtfk0z72m1guKIBzXq
         qdpqEEGAHbujA9Fnl1FKO7/OJ/lszMqKoBu2dOnVR2a7rFN8CZTA71aGglcrLx8bLrWO
         0BhWkUeDqdAE/pti9OfIzg9pnhhK3kQOIeiGiJK+Dan3rPMW5CSTqqWVthGLCvyIHx0R
         17uIMJfjXxEu2gmW9b4vW0X33Va1HQhyYKXCr8GHPE8zYnb6dBCxXhxfh9Qkxao2rHYM
         2t/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628446; x=1756233246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIAFx2sAZr1aaxi1LZMuk62XnAozlnUi2qc60mZCUPc=;
        b=KeUfJT+Fp+8g8Anj4SwHoyZCG+2IsEhltKG4JHuIzd7KKujqzMtO6f9uwWnUSfRzpY
         GSEg1OMzJeAt1+u0T0LW1KHOoB6+vhE34G9CfcHW4MGagsj2U/oHfriNvO4qBoOB/UfL
         hSv1IqNnziCE5GF2QNNV5Cjgnig8p7a2/FZsoUuL1NYhepW4mccz2RvG8DbgW68eGvdV
         G2JHwh8mlgL8pEC1ecH7SXoiNGT8tJpaMLy07xGd23lbVXYeZcDOihpOQzhXqXVfXWyI
         RQIRzWzL3dSzkGIytbOSydW7NDQ+m/3AtS6+88Fwk0j1yoZ6/ADB/FUD/Ex5QCYx/Ud6
         qoaA==
X-Forwarded-Encrypted: i=1; AJvYcCVfUSxWYXk4cXda/lWu3PqCWdAXkHNZo1ylPOwDUYJRw3fA2YDDIPwRmjEe2DYUOhWmhdGoa5guzlAHpvHcwKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4ymDd9axl+QQiLXxMTUcjb9NCiix72Xw8bRbdwX7cwOI5ThJ
	/FUXF5R2yrIJtQtWRGOJCDPrWTMGLQ4s2OXXcikyc/7z5MqAjPyrK4DnWLJWqXrovB0=
X-Gm-Gg: ASbGncvwxG4s4ZEYq9sjGYceMx5IcL5NiVSHk4vVGa9YHal5EACcRqlqpKN9VCKzE4e
	A1eGWstHzUg+kaCBcn+krWh/2CkAEPgLFDBo2ySuwQwASmQnOplpDkL7XvpF4A5TbCmWPHveZOv
	w1Tke+p52o+xo+/hSsuppShjIooMuvLujk32EEseSwVReRgz4O1v5ZfIVPKOGMMBEDLi9AyqPss
	Q3cBL/LmeN7XSHztYq8kj1MuZc9XEICgXc++kJ8sAKNOHaeJ8FlK9uY+hFgMyMPsH/T9vN80ULR
	dUe6uCPHP/P3iQEhsUz54LoOruvZxV1cWKIs2lMhEnAx6znRrXkUa9dTZqkuAAecuqc6+5uL584
	jAu/lKMmAOBjMiqC2u5AZv0zH
X-Google-Smtp-Source: AGHT+IGjSJksXWyqg1XL0sVPSDYoY1K2vCLq/4dy3SroIh5LK0eS+1A0FfIsKIXyrpSD/vuDEKpP6Q==
X-Received: by 2002:a05:6e02:219d:b0:3e2:9ab4:3ebf with SMTP id e9e14a558f8ab-3e67ca22bfdmr2488955ab.19.1755628446014;
        Tue, 19 Aug 2025 11:34:06 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e6727848bcsm16495005ab.7.2025.08.19.11.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:34:05 -0700 (PDT)
Date: Tue, 19 Aug 2025 13:34:04 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: shuah@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] selftests: riscv: Add README for RISC-V KSelfTest
Message-ID: <20250819-28695c586656c926fdfd0468@orel>
References: <20250815180724.14459-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815180724.14459-1-reddybalavignesh9979@gmail.com>

On Fri, Aug 15, 2025 at 11:37:24PM +0530, Bala-Vignesh-Reddy wrote:
> Add a README file for RISC-V specific kernel selftests under
> tools/testing/selftests/riscv/. This mirrors the existing README
> for arm64, providing clear guidance on how the tests are architecture
> specific and skipped on non-riscv systems. It also includes
> standard make commands for building, running and installing the
> tests, along with a reference to general kselftest documentation.
> 
> Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
> ---
>  tools/testing/selftests/riscv/README | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 tools/testing/selftests/riscv/README
> 
> diff --git a/tools/testing/selftests/riscv/README b/tools/testing/selftests/riscv/README
> new file mode 100644
> index 000000000000..443da395da68
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/README
> @@ -0,0 +1,24 @@
> +KSelfTest RISC-V
> +================
> +
> +- These tests are riscv specific and so not built or run but just skipped
> +  completely when env-variable ARCH is found to be different than 'riscv'.
> +
> +- Holding true the above, RISC-V KSFT tests can be run within the
> +  KSelfTest framework using standard Linux top-level-makefile targets:
> +
> +      $ make TARGETS=riscv kselftest-clean
> +      $ make TARGETS=riscv kselftest
> +
> +      or
> +
> +      $ make -C tools/testing/selftests TARGETS=riscv \
> +		INSTALL_PATH=<your-installation-path> install
> +
> +      or, alternatively, only specific riscv/ subtargets can be picked:
> +
> +      $ make -C tools/testing/selftests TARGETS=riscv RISCV_SUBTARGETS="mm vector" \
> +		INSTALL_PATH=<your-installation-path> install
> +
> +   Further details on building and running KSFT can be found in:
> +     Documentation/dev-tools/kselftest.rst
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

