Return-Path: <linux-kselftest+bounces-24745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C702A157F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 20:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B617A49BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169251AAA05;
	Fri, 17 Jan 2025 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="P9TMlIEk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BAC1A08DF
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737141038; cv=none; b=QcI8uBPbzovwJbNpYzy2kiI2ECL8/xPKI2RPeEHzZRBysdx+624nj/JeQfodb99IQ8yuTB4AHX+AdvleMb8HBGauUiWuOKEJN/5kNYznSoYb3hyGz5P57N4xOSjma8CjlyO4qT+y/zl4MKzGu8SZL6fjd8FSj2FcYFVg3Pjrw0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737141038; c=relaxed/simple;
	bh=gCQfKg0lkLVMORegKUgP9hELkSv1GYC5b5YruPAN2uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/zuCJcysjNwZd1XKJDqunnFjX1Ouy4PZOIsPi9bUKN3gA2owuv8lu+N9KyvsYgWyeEB0WbYIfcMHvkKDRxgv6FS67dBR6s3xAbomK8ZKT71hCQyZHqXvV8t7WjvDN4/pHwbrsK1gHJ2EWXuAy+LKD4xJMhYvBl4AEei9gFl1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=P9TMlIEk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2163b0c09afso49893885ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2025 11:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737141034; x=1737745834; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=684EKr0SGhUio1SIgzlKBAWtDnxxSNa6bhJ5P1eZdns=;
        b=P9TMlIEkwped7dN/swJOyAW8oDoTAf3k6bs6Rl+MlzYXx8iihnsDSdCL3iHUhJ4cVA
         OUbppngUjU8GGbRUyas449rVR0HQc+E3g0haZdLLpwiG6LpIILu7APY10cZ6i+lNws9k
         ABxpNCF3EGU5H3c4PzL4p0cYh+Rk+RPtW98YA3mmO3P9n90xtS6SyqS4ka765W+1S4bm
         D6lFTVTPK1+aHnJuFvIOC0BUuToWBct7bxezHXdObNhxxuW4EDXRXxnFa961qm9bs0rv
         PlGUkC8MvsEjLEs3lTiYtVCpK8fqKSdV2cmKyrFqgEyN7saFCswCyH7EiwLQ6WQ+nDxl
         4jgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737141034; x=1737745834;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=684EKr0SGhUio1SIgzlKBAWtDnxxSNa6bhJ5P1eZdns=;
        b=w+sxdjt+yLCVgEiHVbSKff3KLF6SaEgeAdMS8Ub5mixwbzK2qi6SKTkAvT0GzuhJUR
         7e4tgm77RyzsqULd6VUooI7MLZ8FAbAvNCygrjW2Lrb2KQafvG3RrPkMeSWeQBprd+y1
         kVnAe9l+Orevjz32Ic1yG8/sE11VJqghfMT4MnkkA6IDY3vgK4xq3VOBZtgZiUieVUtX
         Z6HeGwDkD3toWaLNjIo6qIRUngZ7vlPUIK6I9JoDeOBw3SeggfSfO/ox1HFdH3tnIybI
         yF4CM4k7riXqdC5q4iaJkJCmx+sb8PbcOlh+SWcWtoSrXdqkspCpGykTLSLzkwJxsc6V
         x/Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXtJoXKOlzUsEph4XLOGBNhDLRl5P2Q44CLoi+/RIWECYtEWS6EyWmPrGuss3CBSRmSCrH58LjzyJd1OFAvTqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAHNF2EF3Etcx0oS3M9tbTdZFYb0Ox2jy/U8GAWgg1IlfbYy+8
	YL58oLlIlol6qrScKuy6OZ32SQDv7hzj33X/wosO1beNtd5aIk4V+eCdBBvFRd8=
X-Gm-Gg: ASbGncvXWG1LPuLmvOzoDR4D27PCxuzE8Yc8k0gWVs0ZhngJknz1hMI9Uvu28eCK9LC
	2Cdy9yAMGkLYVLdJ3zkj90/LWzCDFD+6mDmz/zNBHsTHLtlSmGmXKZDtTECbbLJiCOG8AW06tu6
	jB3rk/vg4HFlZE8m+EP+WlNiI5eq13hADvFx06TQd8MQth1ip6UVtTLW6njhmSgyGEU0xtABgSU
	mgsOh2mdXbbdCMEgBKyLjbIjiHRHWPo7EKVwm7hZsKsJa1m9sqt
X-Google-Smtp-Source: AGHT+IGsACICx7JMdEWk9qCqqQIm7K1lBo6FYA0XbVmB0NbXALlZ/AHrDJ962xz49A5qW/XaxM8X1A==
X-Received: by 2002:a17:903:41c3:b0:216:4883:fb43 with SMTP id d9443c01a7336-21c35594385mr60556265ad.32.1737141034238;
        Fri, 17 Jan 2025 11:10:34 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:d0ea:9b9e:5556:aa82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ce9ee18sm19645235ad.52.2025.01.17.11.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 11:10:33 -0800 (PST)
Date: Fri, 17 Jan 2025 11:10:31 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH 6/6] selftests/nolibc: add configurations for riscv32
Message-ID: <Z4qrJyj6BtD3bYF3@ghost>
References: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
 <20241221-nolibc-rv32-v1-6-d9ef6dab7c63@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241221-nolibc-rv32-v1-6-d9ef6dab7c63@weissschuh.net>

On Sat, Dec 21, 2024 at 03:44:33PM +0100, Thomas Weiﬂschuh wrote:
> nolibc already supports riscv32. Wire it up in the testsuite.

Good addition!

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/Makefile     | 5 +++++
>  tools/testing/selftests/nolibc/run-tests.sh | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 78f47e85b389ac229ac13f3e7c8299fb3ec92197..7d14a7c0cb62608f328b251495264517d333db2e 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -52,6 +52,7 @@ ARCH_ppc64       = powerpc
>  ARCH_ppc64le     = powerpc
>  ARCH_mips32le    = mips
>  ARCH_mips32be    = mips
> +ARCH_riscv32     = riscv
>  ARCH_riscv64     = riscv
>  ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
>  
> @@ -67,6 +68,7 @@ IMAGE_ppc        = vmlinux
>  IMAGE_ppc64      = vmlinux
>  IMAGE_ppc64le    = arch/powerpc/boot/zImage
>  IMAGE_riscv      = arch/riscv/boot/Image
> +IMAGE_riscv32    = arch/riscv/boot/Image
>  IMAGE_riscv64    = arch/riscv/boot/Image
>  IMAGE_s390       = arch/s390/boot/bzImage
>  IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
> @@ -85,6 +87,7 @@ DEFCONFIG_ppc        = pmac32_defconfig
>  DEFCONFIG_ppc64      = powernv_be_defconfig
>  DEFCONFIG_ppc64le    = powernv_defconfig
>  DEFCONFIG_riscv      = defconfig
> +DEFCONFIG_riscv32    = rv32_defconfig
>  DEFCONFIG_riscv64    = defconfig
>  DEFCONFIG_s390       = defconfig
>  DEFCONFIG_loongarch  = defconfig
> @@ -108,6 +111,7 @@ QEMU_ARCH_ppc        = ppc
>  QEMU_ARCH_ppc64      = ppc64
>  QEMU_ARCH_ppc64le    = ppc64
>  QEMU_ARCH_riscv      = riscv64
> +QEMU_ARCH_riscv32    = riscv32
>  QEMU_ARCH_riscv64    = riscv64
>  QEMU_ARCH_s390       = s390x
>  QEMU_ARCH_loongarch  = loongarch64
> @@ -135,6 +139,7 @@ QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIB
>  QEMU_ARGS_ppc64      = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> +QEMU_ARGS_riscv32    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_s390       = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
> index caa1ae40fe9a2faf8931c299aacd19716227e2b8..67fefc847d77165f817c3befa578cfa27e6f93d8 100755
> --- a/tools/testing/selftests/nolibc/run-tests.sh
> +++ b/tools/testing/selftests/nolibc/run-tests.sh
> @@ -17,7 +17,7 @@ perform_download=0
>  test_mode=system
>  werror=1
>  llvm=
> -archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv64 s390 loongarch"
> +archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv32 riscv64 s390 loongarch"
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

