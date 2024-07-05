Return-Path: <linux-kselftest+bounces-13230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 163C2928377
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 10:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A801C236AF
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 08:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AACE145348;
	Fri,  5 Jul 2024 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HoldbA2P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E9514533A;
	Fri,  5 Jul 2024 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167200; cv=none; b=sGbv9ptEKG2Ww+jKdweWLuhCfZ9oA5oK+dQCzucDEJGcvetJMBFlEy9rwL4F97UXin05pZp2ecx0lsULD+bZeFk3Xdo1nY1UAeKYDIBqzsMmJoSF8dfcjs5XUqbnbg3JFpFct+L3B77xQ40C+Aw5BWazHahw1ce/h/dkRcDxd6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167200; c=relaxed/simple;
	bh=AgHhyMmoeUtAdP6SOZU4iVITltEbZQrn++sF+5ZO118=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UqMlsyBbeqwLSsEiJJKfiqyL+7YVMmNSAu6T+9bfHkfylJ2ZUEl0zgBAo4CSPZ9A3ttZSkgi328z8XFU7ArKpQT80M/Hjf7Fue8p/H4TrAyAAmsCv4Cu4Tpcn3XO53TMRn8jhONgpddkstjikVFDAGVC4g3Gi4PPCDyzIw20BT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HoldbA2P; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720167197;
	bh=AgHhyMmoeUtAdP6SOZU4iVITltEbZQrn++sF+5ZO118=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HoldbA2PudjyKSW+lmdADb7c71gZmV2dnVkpuATZTY5f9OsRhA9ZaDyGRMo56yHtD
	 HLmFX2TjcqRri2gD0tVolXWVevWBlh0TbZibKdJ1XC6P/B276vvIRjjia/IqNEharA
	 7U+iTkFNEesgGNNMh31TiZoOQbHfI5ml4ji7pwmI6hCsR0GRVgNqZoKeiP7pwm0i6w
	 N3GR5oZTYMbd3GmdoGm5fJnuGKLGTxhb4e8v3eTkHimFdX1OxE/fgbq3yh3BPEjkgY
	 AM0gM8Fb5LGrpNQaG8puXUdBsFxymchJStwIMyl5AbkkZa+IYmtIzM7w91m/OdSptJ
	 kn9e382/4Glfw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E063E378219E;
	Fri,  5 Jul 2024 08:13:10 +0000 (UTC)
Message-ID: <03195dcd-e689-421d-bcf5-4134c1f18990@collabora.com>
Date: Fri, 5 Jul 2024 13:13:08 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, Thomas Gleixner
 <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v4 2/3] selftests/mm: remove partially duplicated "all:"
 target in Makefile
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
References: <20240704023324.83564-1-jhubbard@nvidia.com>
 <20240704023324.83564-3-jhubbard@nvidia.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240704023324.83564-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/24 7:33 AM, John Hubbard wrote:
> There were a couple of errors here:
> 
> 1. TEST_GEN_PROGS was incorrectly prepending $(OUTPUT) to each program
> to be built. However, lib.mk already does that because it assumes "bare"
> program names are passed in, so this ended up creating
> $(OUTPUT)/$(OUTPUT)/file.c, which of course won't work as intended.
> 
> 2. lib.mk was included before TEST_GEN_PROGS was set, which led to
> lib.mk's "all:" target not seeing anything to rebuild.
> 
> So nothing worked, which caused the author to force things by creating
> an "all:" target locally--while still including ../lib.mk.
> 
> Fix all of this by including ../lib.mk at the right place, and removing
> the $(OUTPUT) prefix to the programs to be built, and removing the
> duplicate "all:" target.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/vDSO/Makefile | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index d53a4d8008f9..209ede5de208 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -1,16 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0
> -include ../lib.mk
> -
>  uname_M := $(shell uname -m 2>/dev/null || echo not)
>  ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>  
> -TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_test_abi
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_test_clock_getres
> +TEST_GEN_PROGS := vdso_test_gettimeofday
> +TEST_GEN_PROGS += vdso_test_getcpu
> +TEST_GEN_PROGS += vdso_test_abi
> +TEST_GEN_PROGS += vdso_test_clock_getres
>  ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
> +TEST_GEN_PROGS += vdso_standalone_test_x86
>  endif
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
> +TEST_GEN_PROGS += vdso_test_correctness
>  
>  CFLAGS := -std=gnu99
>  CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
> @@ -19,7 +18,7 @@ ifeq ($(CONFIG_X86_32),y)
>  LDLIBS += -lgcc_s
>  endif
>  
> -all: $(TEST_GEN_PROGS)
> +include ../lib.mk
>  $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
>  $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
>  $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c

-- 
BR,
Muhammad Usama Anjum

