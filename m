Return-Path: <linux-kselftest+bounces-2529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E35528203D9
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 08:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBD9280DC1
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 07:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436FB17FD;
	Sat, 30 Dec 2023 07:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X32tBU+R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90F23AF;
	Sat, 30 Dec 2023 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703919877;
	bh=regxFrkzSDh5tQmV2aWZG9LxLgfUKQzyJQP28ZnTBLw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=X32tBU+RYg2E4kUPD0bN1ogiP6NkmeL0heVSakadSIsCmfRMIYw4/bd4ZR6wqecpf
	 1W3vbvYqubVLnec52Uvh5/gsx7cQn9AO5n3GqlSnpBTAx4gTEf/qkezbV/NrAI4R+V
	 7KDOlSNSHrt/J2HZhYNQdn2SrrPBtieYXoKJSR0t4PCyaqHEdqep0tZiXYxC449kam
	 tImMzQNNY7vg5UJ/OpOndri1jenbnLUd4IcTz9h51wuyberh6NecFzjWECaT5ZUUUK
	 K/xFOSX66KOwmo0YdVWnzy7Or0Xs6NGm2JNZYNBkAO5Rjk2NsLcIqPtlRqJU6gMP4R
	 c5k3QvMpsaLiA==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 82410378045F;
	Sat, 30 Dec 2023 07:04:35 +0000 (UTC)
Message-ID: <aa5d50f0-7696-4c96-b493-3c637183c516@collabora.com>
Date: Sat, 30 Dec 2023 12:04:35 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests/vDSO: Fix runtime errors on LoongArch
Content-Language: en-US
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231213012300.5640-1-yangtiezhu@loongson.cn>
 <20231213012300.5640-3-yangtiezhu@loongson.cn>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231213012300.5640-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/23 6:23 AM, Tiezhu Yang wrote:
> It could not find __vdso_getcpu and __vdso_gettimeofday when test
> getcpu and gettimeofday on LoongArch.
> 
>   # make headers && cd tools/testing/selftests/vDSO && make
>   # ./vdso_test_getcpu
>   Could not find __vdso_getcpu
>   # ./vdso_test_gettimeofday
>   Could not find __vdso_gettimeofday
> 
> One simple way is to add LoongArch case to define version and name,
> just like commit d942f231afc0 ("selftests/vDSO: Add riscv getcpu &
> gettimeofday test"), but it is not the best way.
> 
> Since each architecture has already defined names and versions in
> vdso_config.h, it is proper to include vdso_config.h to get version
> and name for all archs.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Tested on x86, works fine.
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  .../testing/selftests/vDSO/vdso_test_getcpu.c | 16 +++++-------
>  .../selftests/vDSO/vdso_test_gettimeofday.c   | 26 +++++--------------
>  2 files changed, 13 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
> index 1df5d057d79f..b758f68c6c9c 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_getcpu.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
> @@ -13,13 +13,7 @@
>  
>  #include "../kselftest.h"
>  #include "parse_vdso.h"
> -
> -#if defined(__riscv)
> -const char *version = "LINUX_4.15";
> -#else
> -const char *version = "LINUX_2.6";
> -#endif
> -const char *name = "__vdso_getcpu";
> +#include "vdso_config.h"
>  
>  struct getcpu_cache;
>  typedef long (*getcpu_t)(unsigned int *, unsigned int *,
> @@ -27,6 +21,8 @@ typedef long (*getcpu_t)(unsigned int *, unsigned int *,
>  
>  int main(int argc, char **argv)
>  {
> +	const char *version = versions[VDSO_VERSION];
> +	const char **name = (const char **)&names[VDSO_NAMES];
>  	unsigned long sysinfo_ehdr;
>  	unsigned int cpu, node;
>  	getcpu_t get_cpu;
> @@ -40,9 +36,9 @@ int main(int argc, char **argv)
>  
>  	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
>  
> -	get_cpu = (getcpu_t)vdso_sym(version, name);
> +	get_cpu = (getcpu_t)vdso_sym(version, name[4]);
>  	if (!get_cpu) {
> -		printf("Could not find %s\n", name);
> +		printf("Could not find %s\n", name[4]);
>  		return KSFT_SKIP;
>  	}
>  
> @@ -50,7 +46,7 @@ int main(int argc, char **argv)
>  	if (ret == 0) {
>  		printf("Running on CPU %u node %u\n", cpu, node);
>  	} else {
> -		printf("%s failed\n", name);
> +		printf("%s failed\n", name[4]);
>  		return KSFT_FAIL;
>  	}
>  
> diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
> index e411f287a426..ee4f1ca56a71 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
> @@ -18,25 +18,13 @@
>  
>  #include "../kselftest.h"
>  #include "parse_vdso.h"
> -
> -/*
> - * ARM64's vDSO exports its gettimeofday() implementation with a different
> - * name and version from other architectures, so we need to handle it as
> - * a special case.
> - */
> -#if defined(__aarch64__)
> -const char *version = "LINUX_2.6.39";
> -const char *name = "__kernel_gettimeofday";
> -#elif defined(__riscv)
> -const char *version = "LINUX_4.15";
> -const char *name = "__vdso_gettimeofday";
> -#else
> -const char *version = "LINUX_2.6";
> -const char *name = "__vdso_gettimeofday";
> -#endif
> +#include "vdso_config.h"
>  
>  int main(int argc, char **argv)
>  {
> +	const char *version = versions[VDSO_VERSION];
> +	const char **name = (const char **)&names[VDSO_NAMES];
> +
>  	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
>  	if (!sysinfo_ehdr) {
>  		printf("AT_SYSINFO_EHDR is not present!\n");
> @@ -47,10 +35,10 @@ int main(int argc, char **argv)
>  
>  	/* Find gettimeofday. */
>  	typedef long (*gtod_t)(struct timeval *tv, struct timezone *tz);
> -	gtod_t gtod = (gtod_t)vdso_sym(version, name);
> +	gtod_t gtod = (gtod_t)vdso_sym(version, name[0]);
>  
>  	if (!gtod) {
> -		printf("Could not find %s\n", name);
> +		printf("Could not find %s\n", name[0]);
>  		return KSFT_SKIP;
>  	}
>  
> @@ -61,7 +49,7 @@ int main(int argc, char **argv)
>  		printf("The time is %lld.%06lld\n",
>  		       (long long)tv.tv_sec, (long long)tv.tv_usec);
>  	} else {
> -		printf("%s failed\n", name);
> +		printf("%s failed\n", name[0]);
>  		return KSFT_FAIL;
>  	}
>  

-- 
BR,
Muhammad Usama Anjum

