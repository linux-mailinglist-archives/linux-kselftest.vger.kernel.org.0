Return-Path: <linux-kselftest+bounces-37395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3B4B06BC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 04:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A607AEA20
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 02:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547B727380C;
	Wed, 16 Jul 2025 02:35:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03D6270ED5;
	Wed, 16 Jul 2025 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752633303; cv=none; b=YjE5EVwaHcg8MnMSvhZ0FqS99lEQ8huQc0udGaZiincmIqRlZvtnlzYCVGMJIxH9mK8IAdt3ICq6clbhrfcCDXrgGSu7X/riSghkrvMfGlDZyd2gUTQRP2rVpNK2Rjw2VBaPWUvcV2YuBNhoyzf6lRlGMhZSo4TeeIKu8kL/mTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752633303; c=relaxed/simple;
	bh=U/jXgEJANHl+zH/16DD1tQHLD0W2HLcOVGMOVbNqiTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwxMeal3O240mBZXGSDQsIfe/tgK5liUtMwtnBRx5nYEcGW+BLGxek404ii1t9Q+I2FVBcRrRfvUxhxnxjQqzxB8tQBhSCO+s3k8/mHIzH+Zxyrmw7FNaVBQTiKMKoIBEUxyQy4QGBjHU1MvH8S4eeAK3nLePP5HI3HRemmR8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61E3112FC;
	Tue, 15 Jul 2025 19:34:51 -0700 (PDT)
Received: from [10.164.146.16] (J09HK2D2RT.blr.arm.com [10.164.146.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8080D3F6A8;
	Tue, 15 Jul 2025 19:34:57 -0700 (PDT)
Message-ID: <a717d6ee-3b24-47de-a1fc-90a4ad0a020d@arm.com>
Date: Wed, 16 Jul 2025 08:04:54 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest/arm4: Provide local defines for AT_HWCAP3
To: Mark Brown <broonie@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250715-arm64-selftest-bodge-hwcap3-v1-1-541b54bc43bb@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250715-arm64-selftest-bodge-hwcap3-v1-1-541b54bc43bb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/07/25 2:41 AM, Mark Brown wrote:
> Some build environments for the selftests are not picking up the newly
> added AT_HWCAP3 when using the libc headers, even with headers_install
> (which we require already for the arm64 selftests).  As a quick fix add
> local definitions of the constant to tools use it, while auxvec.h is
> installed with some toolchains it needs some persuasion to get picked up.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/abi/hwcap.c       | 4 ++++
>  tools/testing/selftests/arm64/mte/check_prctl.c | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
> index 35f521e5f41c..aa902408facd 100644
> --- a/tools/testing/selftests/arm64/abi/hwcap.c
> +++ b/tools/testing/selftests/arm64/abi/hwcap.c
> @@ -21,6 +21,10 @@
>  
>  #define TESTS_PER_HWCAP 3
>  
> +#ifndef AT_HWCAP3
> +#define AT_HWCAP3 29

Just wondering - would it be better to add a comment that this is a
temporary construct till libc headers pick up AT_HWCAP3 definitions.


> +#endif
> +
>  /*
>   * Function expected to generate exception when the feature is not
>   * supported and return when it is supported. If the specific exception
> diff --git a/tools/testing/selftests/arm64/mte/check_prctl.c b/tools/testing/selftests/arm64/mte/check_prctl.c
> index 4c89e9538ca0..c36c4c49ff95 100644
> --- a/tools/testing/selftests/arm64/mte/check_prctl.c
> +++ b/tools/testing/selftests/arm64/mte/check_prctl.c
> @@ -12,6 +12,10 @@
>  
>  #include "kselftest.h"
>  
> +#ifndef AT_HWCAP3
> +#define AT_HWCAP3 29
> +#endif
> +
>  static int set_tagged_addr_ctrl(int val)
>  {
>  	int ret;
> 
> ---
> base-commit: 86731a2a651e58953fc949573895f2fa6d456841
> change-id: 20250710-arm64-selftest-bodge-hwcap3-b6ab30ab69cd
> 
> Best regards,
> --  
> Mark Brown <broonie@kernel.org>
> 
> 


