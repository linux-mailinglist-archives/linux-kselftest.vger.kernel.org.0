Return-Path: <linux-kselftest+bounces-7112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC77897816
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 20:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4BF1F21707
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1A315381F;
	Wed,  3 Apr 2024 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="WS1lcdtt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3F7153566
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168528; cv=none; b=ZDAJ110XwUjL69a7zETux85fOQTEu8LA7JmxHEkavMZDX/6bJFHRA7hJEk1t/NtkZQEt80rd5jwk51FqnTptZsm8B1hgW3f6oN/Hb6TLThixx7UJrOUgVMSnKAuVi6J+VjSdMSbgug+0wqhUUrjso0QzWH3RbJ6Ye+k/4/Tj5aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168528; c=relaxed/simple;
	bh=mPQ6aDx/DzkRZiI7UzFAti6c8odqszdQXKvBp/uj47A=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=Cdmef2cr9k+i+Pz6PpRoCqfdM9kle4mZTD0YNGUowN7Lk4Tfms+3hmzlT89Obuin5EFpSnqnSdeTk8TgNPupXxj+Tp6fdSObaMNcPMigJ7RN0SprvL3/vZk5h4BCnzV7RCsnS9GTz8+tdFjZfrJaEAV1ziyAtDIc+lAn1k/Jldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=WS1lcdtt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e29328289eso949625ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1712168526; x=1712773326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+6ScChiC8zS3o9tbiOgcc1DiBxz6xvmMgS5MbEqCVk=;
        b=WS1lcdttwByvBL81FDxCR9c9ohzcIBrEwgU8WykpdmMwgb72x4x1Vq5CwVOtTW6qEL
         /U4s/ibFdFNF+gwkTlu+OXDesuZwLTPsVYF+24swBnSk5MMBbTtWAZ+q+cf3tdExrjbZ
         Xh/oaV/2YgirVkzL/ngg1aBit6RKOFJ4KoOSZX4puydzTZtUKZ9CTiB/6PF+tgqsmgiF
         pMvSysELXIGSPttBEbRvph76C3mGHB8D57OZ43vUyPiy21tE/Ae+30tvmSNjFtN4cJbY
         siv6Cnf+vLkrBVeQOECUd0FJLZUqla/oU10n1LpCE1z814xlNsddY0i/c6Cdn909/jAi
         fBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168526; x=1712773326;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+6ScChiC8zS3o9tbiOgcc1DiBxz6xvmMgS5MbEqCVk=;
        b=BK8fyvGn08GFHiT08E+anzeiPhHbmpM3hMAsiTmNHMD4Gap3O6tT77JW8vJ5Xo7dg/
         NbYKDsiHUnT3JOBuMnQA0H80x022HDYq1HRwcArjyZTjHczFTxiWeItL9LP4drE7i3kh
         sZ4jiEl+qYT1gd3WvJ2cQoJw8ADhad7mAtGBkreqf8VKtK/Uf00P5GQIEAjxF0EpewNu
         nhymP6D1dNSRPonDmlVsPL67WWc5b8+1zKIxV1GJw/b3tM1lqs0vDFDWFFgo4gy7R7lx
         Ekemg9SKuzmK0TLPackZcsBrpnJwSCz9YxiLD+oCReJttxHBpfRMxrfpSmG0eO5lam5u
         BXiA==
X-Forwarded-Encrypted: i=1; AJvYcCVffwUdPR9mtRSvPac34h5SGXuSkIwNbN388vHouiVVDYInJ2pHD9Aji2KeZcZYkSNnxK17zq6KMGIkGhgusmlfOFinp16md6DQTGVC3VNb
X-Gm-Message-State: AOJu0YzIcG9meHVSZWJt7pGKnjIMyhVd5rsej+2Zny8jxdP9LVLAD4DF
	nZ6PVi96G8cjqRd5cYg9p8fxmy2ZQM4n2VZel3G/FsagqQOA+tLkglBAptrYdiY=
X-Google-Smtp-Source: AGHT+IFlUXGV4chig6oJvZqV4vGOgLfE+s5gAYd5D5SfvJ7gnZEYS1RqOGC2YxcHgRm7Hvepr5Q2zg==
X-Received: by 2002:a17:902:c14b:b0:1e0:a7c5:b5a5 with SMTP id 11-20020a170902c14b00b001e0a7c5b5a5mr67760plj.37.1712168525743;
        Wed, 03 Apr 2024 11:22:05 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d48200b001dd652ef8d6sm13572476plg.152.2024.04.03.11.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:22:04 -0700 (PDT)
Date: Wed, 03 Apr 2024 11:22:04 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Apr 2024 11:21:38 PDT (-0700)
Subject:     Re: [PATCH v1 2/2] RISC-V: drop SOC_VIRT for ARCH_VIRT
In-Reply-To: <20240305-stress-earflap-d7ddb8655a4d@spud>
CC: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
  Conor Dooley <conor.dooley@microchip.com>, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  linux-kernel@vger.kernel.org, brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
  Jason@zx2c4.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
  wireguard@lists.zx2c4.com, netdev@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor@kernel.org>
Message-ID: <mhng-170f61cd-c3b7-413b-8279-9d50d55dbebe@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 05 Mar 2024 10:37:06 PST (-0800), Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> The ARCH_ and SOC_ versions of this symbol have persisted for quite a
> while now in parallel. Generated .config files from previous LTS kernels
> should have both. Finally remove SOC_VIRT and update all config files
> using it.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I had a 1.5 year old ack from Jason that I dropped due to the passage of
> time.
>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: Brendan Higgins <brendan.higgins@linux.dev>
> CC: David Gow <davidgow@google.com>
> CC: Rae Moar <rmoar@google.com>
> CC: "Jason A. Donenfeld" <Jason@zx2c4.com>
> CC: Shuah Khan <shuah@kernel.org>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-kselftest@vger.kernel.org
> CC: kunit-dev@googlegroups.com
> CC: wireguard@lists.zx2c4.com
> CC: netdev@vger.kernel.org
> ---
>  arch/riscv/Kconfig.socs                                    | 3 ---
>  arch/riscv/configs/defconfig                               | 2 +-
>  arch/riscv/configs/nommu_virt_defconfig                    | 2 +-
>  tools/testing/kunit/qemu_configs/riscv.py                  | 2 +-
>  tools/testing/selftests/wireguard/qemu/arch/riscv32.config | 2 +-
>  tools/testing/selftests/wireguard/qemu/arch/riscv64.config | 2 +-
>  6 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index e85ffb63c48d..dcbfb659839c 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -52,9 +52,6 @@ config ARCH_THEAD
>  	  This enables support for the RISC-V based T-HEAD SoCs.
>
>  config ARCH_VIRT
> -	def_bool SOC_VIRT
> -
> -config SOC_VIRT
>  	bool "QEMU Virt Machine"
>  	select CLINT_TIMER if RISCV_M_MODE
>  	select POWER_RESET
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index ab3bab313d56..8d46a9137b1e 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -32,7 +32,7 @@ CONFIG_ARCH_SOPHGO=y
>  CONFIG_SOC_STARFIVE=y
>  CONFIG_ARCH_SUNXI=y
>  CONFIG_ARCH_THEAD=y
> -CONFIG_SOC_VIRT=y
> +CONFIG_ARCH_VIRT=y
>  CONFIG_SMP=y
>  CONFIG_HOTPLUG_CPU=y
>  CONFIG_PM=y
> diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
> index b794e2f8144e..de8143d1f738 100644
> --- a/arch/riscv/configs/nommu_virt_defconfig
> +++ b/arch/riscv/configs/nommu_virt_defconfig
> @@ -24,7 +24,7 @@ CONFIG_EXPERT=y
>  CONFIG_SLUB=y
>  CONFIG_SLUB_TINY=y
>  # CONFIG_MMU is not set
> -CONFIG_SOC_VIRT=y
> +CONFIG_ARCH_VIRT=y
>  CONFIG_NONPORTABLE=y
>  CONFIG_SMP=y
>  CONFIG_CMDLINE="root=/dev/vda rw earlycon=uart8250,mmio,0x10000000,115200n8 console=ttyS0"
> diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
> index 12a1d525978a..c87758030ff7 100644
> --- a/tools/testing/kunit/qemu_configs/riscv.py
> +++ b/tools/testing/kunit/qemu_configs/riscv.py
> @@ -13,7 +13,7 @@ if not os.path.isfile(OPENSBI_PATH):
>
>  QEMU_ARCH = QemuArchParams(linux_arch='riscv',
>  			   kconfig='''
> -CONFIG_SOC_VIRT=y
> +CONFIG_ARCH_VIRT=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
> diff --git a/tools/testing/selftests/wireguard/qemu/arch/riscv32.config b/tools/testing/selftests/wireguard/qemu/arch/riscv32.config
> index 2fc36efb166d..2500eaa9b469 100644
> --- a/tools/testing/selftests/wireguard/qemu/arch/riscv32.config
> +++ b/tools/testing/selftests/wireguard/qemu/arch/riscv32.config
> @@ -2,7 +2,7 @@ CONFIG_NONPORTABLE=y
>  CONFIG_ARCH_RV32I=y
>  CONFIG_MMU=y
>  CONFIG_FPU=y
> -CONFIG_SOC_VIRT=y
> +CONFIG_ARCH_VIRT=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
> diff --git a/tools/testing/selftests/wireguard/qemu/arch/riscv64.config b/tools/testing/selftests/wireguard/qemu/arch/riscv64.config
> index dc266f3b1915..29a67ac67766 100644
> --- a/tools/testing/selftests/wireguard/qemu/arch/riscv64.config
> +++ b/tools/testing/selftests/wireguard/qemu/arch/riscv64.config
> @@ -1,7 +1,7 @@
>  CONFIG_ARCH_RV64I=y
>  CONFIG_MMU=y
>  CONFIG_FPU=y
> -CONFIG_SOC_VIRT=y
> +CONFIG_ARCH_VIRT=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

