Return-Path: <linux-kselftest+bounces-24746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5389A157FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 20:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990901636CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 19:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F182D1A7AD0;
	Fri, 17 Jan 2025 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qma4aHhk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573CC1A08DF
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737141210; cv=none; b=ryGx01UiGKEGWNzFLWRs2EuhhCyimP9RbdUevRqeugHY4xiX96/rwYDThXxkpm2HmbrAQLGu9h7egJ0tZyXSqyQh0em8uQWziTUHs+KiGyGcvFGV4Qfwe8oIEMGE+kzbzC/sw/bqpKbZqGndEn7mP6ZDBtcrS4l68z0OMw5jzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737141210; c=relaxed/simple;
	bh=0Hzeh9B+YaweU6u2NhaOt/XWMEt+n7uqxbTLR897Di8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sw+B7Cn6qmlU9R0GmvjY+eFYI5kmiIwCmnyKcLNDwNacNSYowqVtpSPI402QykyZcYc8++eS0mk5QMjGBdLI7zDGU4/wwicfNQEhsA9skfNhlT58AmqZ3xKfNbijprf2jjCiea8Usi7rPWsAzOYtWUxTZHkpWvHbCRa6OO+aJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qma4aHhk; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so4290676a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 11:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737141208; x=1737746008; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8UTpND2Rbn4HNA2BJ/vgMhdK6LbSWDbzp+NEMICmPTw=;
        b=qma4aHhk8Q76UoUBYZWsRQ/LqME03Zo+Pbgilx4QgICz9Msw5+5dGDAXTlRcu/c/6P
         eIPgIoGynfvUxuNr4hhVh0uHVwUBghRJjXe1TR53TixtRkSkf4darZVvlsVOmW8zbB9g
         U8Ky9H4z8QU0n3M6Fd2pPGNGoeLJQqfNz/oSVX67cFs8Zp9x/dOfa5fb752L9xeZNHyh
         tsZyGrSHnf8Deah8ZHzQBPDegERgr1D8GseyP7MfsvsLjRNne9MYHQCe130wtO3Ytmq0
         2bdHFQZtdwEso0PG8NFzVrQWrPYAnCNpyL0mDXGDN6W+YAk9r95dTCFWbpb5Mhte/O4/
         WiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737141208; x=1737746008;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8UTpND2Rbn4HNA2BJ/vgMhdK6LbSWDbzp+NEMICmPTw=;
        b=FP8BJvLDxQPrYTqcmNKrdIKzXiPfzFq5dDwI86IySen4y4cfivRKo+RY7Ny5wdcAH8
         CMlk0Xr4J7wSuUfOMcW8n6RG5X2ee78y47+94nBThujv4JdrkPGvQjwH6oiAdJx2t2gW
         hyBI0KzQ5CtP0g6X2WHtQQXdhlRAyrvSlLqSpth4Tw7FNEJ/rApaCO20xKDzu1CoMe2w
         fCkeEXdTwlWefTG3p8/ovdJjrIsHcfZdDvVhEvno1EwbSOI1cdrKgdJdKllgHeZU6yxE
         CgmjZ96hiwGSiRlIv2BD/uq1otQSiuAWDEE5UJvJ1HJoFuV4nsXAdaNrSC9GP0D4mL8u
         pelA==
X-Forwarded-Encrypted: i=1; AJvYcCXagF3fmwYACTVIQXcBl0nx32iULKADYgfjzU461bkMHy7X9VY79OlV9wMlY/VOZp5AeWyQHhl42t1qaYJ1d48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3nMUNowc8WEeOER22v29gerQ+I0QpQoUFoElaHyzr2TA6uAaU
	f8SwQSFmA76dCWcKpvquK1lgR03gKjLeAv4QpRQlIt6cHwH7kLruWN/ufcti48E=
X-Gm-Gg: ASbGncuys4HzrtPFwjokZi81xvQTDJVI/eagA44boRMU8TP8jBWNJjR8TE8EeKEmbbX
	jLvdcqsbsIL0EM9JuyHuzkpYWV7Ju/xt7ZNARsjGSdZyvAFbfQRAod2KA6tQtmn6GopPGvKiueJ
	s88SN+MrwRAFGd8s2iLUDOWQ8WJiiU+G5qmNzePEUVoOdGm64KcrvSgDMlRBOPpXY41fVFOlutq
	K9NSaGhU3OpkvSHk3BzEQuWMUqoMjWpyts0KNtfltwbqcKlkecd
X-Google-Smtp-Source: AGHT+IH7BbQoFrPmcbzptHUlbfYyMs/PsV9xf+OzCx7xvhWju21hjcZsAHHc9/vuu5cfPYcSDek9fA==
X-Received: by 2002:a17:90b:534b:b0:2ee:edae:75e with SMTP id 98e67ed59e1d1-2f782c92720mr5484902a91.13.1737141207119;
        Fri, 17 Jan 2025 11:13:27 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:d0ea:9b9e:5556:aa82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c335093sm5637495a91.48.2025.01.17.11.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 11:13:26 -0800 (PST)
Date: Fri, 17 Jan 2025 11:13:24 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH 5/6] selftests/nolibc: rename riscv to riscv64
Message-ID: <Z4qr1KMVbjGbYcFV@ghost>
References: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
 <20241221-nolibc-rv32-v1-5-d9ef6dab7c63@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241221-nolibc-rv32-v1-5-d9ef6dab7c63@weissschuh.net>

On Sat, Dec 21, 2024 at 03:44:32PM +0100, Thomas Weiﬂschuh wrote:
> riscv32 support is about the be added. To keep the naming clear and
> consistent with other architectures rename riscv to riscv64, as that is
> what it actually represents.

Seems like a reasonable change.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/Makefile     | 6 ++++++
>  tools/testing/selftests/nolibc/run-tests.sh | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index e92e0b88586111072a0e043cb15f3b59cf42c3a6..78f47e85b389ac229ac13f3e7c8299fb3ec92197 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -43,6 +43,7 @@ cc-option = $(call __cc-option, $(CC),$(CLANG_CROSS_FLAGS),$(1),$(2))
>  # configure default variants for target kernel supported architectures
>  XARCH_powerpc    = ppc
>  XARCH_mips       = mips32le
> +XARCH_riscv      = riscv64
>  XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
>  
>  # map from user input variants to their kernel supported architectures
> @@ -51,6 +52,7 @@ ARCH_ppc64       = powerpc
>  ARCH_ppc64le     = powerpc
>  ARCH_mips32le    = mips
>  ARCH_mips32be    = mips
> +ARCH_riscv64     = riscv
>  ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
>  
>  # kernel image names by architecture
> @@ -65,6 +67,7 @@ IMAGE_ppc        = vmlinux
>  IMAGE_ppc64      = vmlinux
>  IMAGE_ppc64le    = arch/powerpc/boot/zImage
>  IMAGE_riscv      = arch/riscv/boot/Image
> +IMAGE_riscv64    = arch/riscv/boot/Image
>  IMAGE_s390       = arch/s390/boot/bzImage
>  IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
>  IMAGE            = $(objtree)/$(IMAGE_$(XARCH))
> @@ -82,6 +85,7 @@ DEFCONFIG_ppc        = pmac32_defconfig
>  DEFCONFIG_ppc64      = powernv_be_defconfig
>  DEFCONFIG_ppc64le    = powernv_defconfig
>  DEFCONFIG_riscv      = defconfig
> +DEFCONFIG_riscv64    = defconfig
>  DEFCONFIG_s390       = defconfig
>  DEFCONFIG_loongarch  = defconfig
>  DEFCONFIG            = $(DEFCONFIG_$(XARCH))
> @@ -104,6 +108,7 @@ QEMU_ARCH_ppc        = ppc
>  QEMU_ARCH_ppc64      = ppc64
>  QEMU_ARCH_ppc64le    = ppc64
>  QEMU_ARCH_riscv      = riscv64
> +QEMU_ARCH_riscv64    = riscv64
>  QEMU_ARCH_s390       = s390x
>  QEMU_ARCH_loongarch  = loongarch64
>  QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
> @@ -130,6 +135,7 @@ QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIB
>  QEMU_ARGS_ppc64      = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> +QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_s390       = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS            = -m 1G $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
> diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
> index e7ecda4ae796fbf0d389f20144511e66ce4f0b30..caa1ae40fe9a2faf8931c299aacd19716227e2b8 100755
> --- a/tools/testing/selftests/nolibc/run-tests.sh
> +++ b/tools/testing/selftests/nolibc/run-tests.sh
> @@ -17,7 +17,7 @@ perform_download=0
>  test_mode=system
>  werror=1
>  llvm=
> -archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv s390 loongarch"
> +archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv64 s390 loongarch"
>  
>  TEMP=$(getopt -o 'j:d:c:b:a:m:pelh' -n "$0" -- "$@")
>  
> 
> -- 
> 2.47.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

