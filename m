Return-Path: <linux-kselftest+bounces-38932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705D2B25B20
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 07:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D3168620F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 05:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DC52222AA;
	Thu, 14 Aug 2025 05:47:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CE11D54D8;
	Thu, 14 Aug 2025 05:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150478; cv=none; b=TL2K6KWhSTUmilhbvtDOtEcvAhYZXaqE1a5MxaQBlUJKm+yJAd2gH1dNbCV8jD+tPDKBKCly4KgtGFGOsB6EisevDRoyzB3P0EEaJy8kpjV2TkGR5RwU8oEi2CmDL9pcxSiUO1mKIcPO5wMyZ0Ns0qxIDG8rxqFWAvVtjsF0HQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150478; c=relaxed/simple;
	bh=CIwJt1PNtAV8xPD6qVRCNjDGgC1Za4HbPp7bSJ1b06w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0w1g20k+yZmzfvrT46/0LwzKvD+KfZaFitjIupNgyrHSwI7co4vNGXNEXCjWk5vRoQjmqh/Oir6D5arsI0X7Q3OxmAUPIBjUFm0MvopctM9niNqzII4kpgZjZ4Uurl3aKE6C0/cHCdZh2GZmMtT4D9BYgaCKGPYI2aDuZZEiAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 874851691;
	Wed, 13 Aug 2025 22:47:47 -0700 (PDT)
Received: from [10.163.65.190] (unknown [10.163.65.190])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D2E23F63F;
	Wed, 13 Aug 2025 22:47:52 -0700 (PDT)
Message-ID: <7f01a3c7-818d-43cf-bdba-03409f85ccc5@arm.com>
Date: Thu, 14 Aug 2025 11:17:48 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: arm64: Fix -Waddress warning in tpidr2 test
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 shuah@kernel.org, broonie@kernel.org, yeoreum.yun@arm.com
References: <005af416-66fa-4222-964d-e20bd2eccb7f@arm.com>
 <20250807114247.5915-1-reddybalavignesh9979@gmail.com>
 <20250807114247.5915-2-reddybalavignesh9979@gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250807114247.5915-2-reddybalavignesh9979@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/25 5:12 PM, Bala-Vignesh-Reddy wrote:
> Resolve compiler warning about always true condition in ksft_test_result
> in tpidr2, passing actual function.
> 
> This silences -Waddress warning while maintaining test functionality.
> 
> Fixes compiler warning (similar for other functions):
> warning: the address of 'write_read' will always evaluate as
> 'true' [-Waddress]
> 
> Fixes: 6d80cb73131d ("kselftest/arm64: Convert tpidr2 test to use kselftest.h")
> 
> Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
> ---
>  tools/testing/selftests/arm64/abi/tpidr2.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/abi/tpidr2.c b/tools/testing/selftests/arm64/abi/tpidr2.c
> index f58a9f89b952..4c89ab0f1010 100644
> --- a/tools/testing/selftests/arm64/abi/tpidr2.c
> +++ b/tools/testing/selftests/arm64/abi/tpidr2.c
> @@ -227,10 +227,10 @@ int main(int argc, char **argv)
>  	ret = open("/proc/sys/abi/sme_default_vector_length", O_RDONLY, 0);
>  	if (ret >= 0) {
>  		ksft_test_result(default_value(), "default_value\n");
> -		ksft_test_result(write_read, "write_read\n");
> -		ksft_test_result(write_sleep_read, "write_sleep_read\n");
> -		ksft_test_result(write_fork_read, "write_fork_read\n");
> -		ksft_test_result(write_clone_read, "write_clone_read\n");
> +		ksft_test_result(write_read(), "write_read\n");
> +		ksft_test_result(write_sleep_read(), "write_sleep_read\n");
> +		ksft_test_result(write_fork_read(), "write_fork_read\n");
> +		ksft_test_result(write_clone_read(), "write_clone_read\n");
>  
>  	} else {
>  		ksft_print_msg("SME support not present\n");

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

