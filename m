Return-Path: <linux-kselftest+bounces-36093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E14AED961
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 12:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A731743AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70D0251782;
	Mon, 30 Jun 2025 10:08:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5420D2512E6;
	Mon, 30 Jun 2025 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278100; cv=none; b=nmQtr8FBIt7CvchNXlRJuduqD9koPDvgEmrQugpFyTApUodcbGHKg7YwCYvIBbTvoFNQlddKo9wT6zyCctMmnld82S7iBwlTK3qfGfhxlLMnwKoJIQzKEInrq+WzSRcDPnup7ub4WzDed97LF9BvrVqacXGVLBrhItBI2mcIGyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278100; c=relaxed/simple;
	bh=Kx1sq/TMs8Va/BAWm9D+o8ft7JdS1Igx+utqfJ184I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYO2WBJXhnKs8OxxQrCythcp6T6VbSJ/nCSnhEJinV5KV+1lqIa9LwkHWe76cp2EH/9SlIPWBXFvXEKRRnizSEeTLRVSlo/qdQ+ei00Vux4E8hycy4P3IXbJdXfaz9dkvjFVCFYEsomJkSBDWDNAgkN+27Qx4jfkOq0xPxN9Y04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB3251D34;
	Mon, 30 Jun 2025 03:08:02 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 974EE3F58B;
	Mon, 30 Jun 2025 03:08:16 -0700 (PDT)
Message-ID: <1d825680-4275-42cb-9e3c-dc49f828f7a8@arm.com>
Date: Mon, 30 Jun 2025 11:08:15 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] kselftest/arm64: Add lsfe to the hwcaps test
To: Mark Brown <broonie@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20250627-arm64-lsfe-v1-0-68351c4bf741@kernel.org>
 <20250627-arm64-lsfe-v1-3-68351c4bf741@kernel.org>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20250627-arm64-lsfe-v1-3-68351c4bf741@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mark,

On 6/27/25 18:20, Mark Brown wrote:
> This feature has no traps associated with it so the SIGILL is not reliable.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/abi/hwcap.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
> index 35f521e5f41c..9dfca2eb7c41 100644
> --- a/tools/testing/selftests/arm64/abi/hwcap.c
> +++ b/tools/testing/selftests/arm64/abi/hwcap.c
> @@ -17,6 +17,8 @@
>   #include <asm/sigcontext.h>
>   #include <asm/unistd.h>
>   
> +#include <linux/auxvec.h>
> +
>   #include "../../kselftest.h"
>   
>   #define TESTS_PER_HWCAP 3
> @@ -165,6 +167,18 @@ static void lse128_sigill(void)
>   		     : "cc", "memory");
>   }
>   
> +static void lsfe_sigill(void)
> +{
> +	float __attribute__ ((aligned (16))) mem = 0;
> +	register float *memp asm ("x0") = &mem;
> +
> +	/* LDFADD H0, H0, [X0] */
> +	asm volatile(".inst 0x7c600000"
Same effect, but isn't this the release variant, LDFADDL?
> +		     : "+r" (memp)
> +		     :
> +		     : "cc", "memory");
> +}
> +
>   static void lut_sigill(void)
>   {
>   	/* LUTI2 V0.16B, { V0.16B }, V[0] */
> @@ -758,6 +772,13 @@ static const struct hwcap_data {
>   		.cpuinfo = "lse128",
>   		.sigill_fn = lse128_sigill,
>   	},
> +	{
> +		.name = "LSFE",
> +		.at_hwcap = AT_HWCAP3,
> +		.hwcap_bit = HWCAP3_LSFE,
> +		.cpuinfo = "lsfe",
> +		.sigill_fn = lsfe_sigill,
> +	},
>   	{
>   		.name = "LUT",
>   		.at_hwcap = AT_HWCAP2,
> 

Thanks,

Ben


