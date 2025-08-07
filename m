Return-Path: <linux-kselftest+bounces-38436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA228B1D1CD
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 07:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC7D7AA848
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 05:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDB11B85FD;
	Thu,  7 Aug 2025 05:02:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA963208;
	Thu,  7 Aug 2025 05:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754542970; cv=none; b=SMEyf1V1VWSTGjH19KVBONcG0MW5jxvoCgA8WhzcMn7OjUd4LOBmKzDjkBE3KXQycqeCQ9u0bm0Sg8hYDwfvauXRCjOgIK7+4/EFfA0Oa7AL1Pt71e70Ufa7SAmsL7aho3JmG0IzVqHK0WmWYniZ+D/Of68ymRUq0/9PeKuLKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754542970; c=relaxed/simple;
	bh=H8xmGVv+DmEacmenHBDsjsn27vKuOj94kSVob5JKx+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XThpCj3hF7EDwYxACAcK/azSC/b/35RgzwJQt000H4fOb6L7I57yo5HjM+vvUoiS89DsDMmuDphQlKiL/9PNcMkBEql9F4Z/hCRDg6BatCDLjR9K/1DC9fNO2qZkAOhknQRXLGioRjaWc82w8bBN/zymDKq9iRxyMCFLwAucfSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC082236D;
	Wed,  6 Aug 2025 22:02:39 -0700 (PDT)
Received: from [10.163.95.35] (unknown [10.163.95.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0945A3F673;
	Wed,  6 Aug 2025 22:02:44 -0700 (PDT)
Message-ID: <005af416-66fa-4222-964d-e20bd2eccb7f@arm.com>
Date: Thu, 7 Aug 2025 10:32:41 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: arm64: Fix -Waddress warning in tpidr2 test
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>
References: <20250806203928.168365-1-reddybalavignesh9979@gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250806203928.168365-1-reddybalavignesh9979@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/25 2:09 AM, Bala-Vignesh-Reddy wrote:
> Resolve compiler warning about always true condition in ksft_test_result
> in tpidr2, passing actual function.
> 
> This silences -Waddress warning while maintaining test functionality.

Might be better to just add the compiler warning in the commit message.
Also does it need a Fixes: tag for the relevant commit as well ?

6d80cb73131d ("kselftest/arm64: Convert tpidr2 test to use kselftest.h")

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
>  		ksft_print_msg("SME support not present\n");Otherwise LGTM.

