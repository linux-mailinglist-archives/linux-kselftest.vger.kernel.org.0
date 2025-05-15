Return-Path: <linux-kselftest+bounces-33072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458F3AB82A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 11:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF1A3A8395
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 09:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AD5287518;
	Thu, 15 May 2025 09:31:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374AF22577C;
	Thu, 15 May 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301466; cv=none; b=GaH5gVZQ2SkJlOqPsoc7Uu9nIIyofvg0etnZJ2zLnzVWrqspOVXgW5pNtffTjt6YJHHzlig9nvqXy4yjVco+uEM9XvmJI5wgZjowx/IItrNRTIuXaQVpl6KHD/t4RuRojcUrSu98sNUIxUbNt/8wLgYSu4umATNyM9Ua5FT7v4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301466; c=relaxed/simple;
	bh=d+cZQYwPK/tIIoqHegXHA7pn26lNn03fDXH8CD1X0/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNY5Z8xWpcDpAnLpLqvHHGr4GWw73cpY1jw6nRyCCD3F65Z5DGk9r8QZt3FxIqEKE297Uw37ItUv4bvCJKoRa9z7v32e2GDaC6Cutb9/nN5n8ci55FrO8Ume9l3+9sS+BQXDHFTGWmnv5XfSKGDI/VABnaOqE8xYr3etmptyUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04A4614BF;
	Thu, 15 May 2025 02:30:52 -0700 (PDT)
Received: from [10.162.40.26] (K4MQJ0H1H2.blr.arm.com [10.162.40.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B50B73F5A1;
	Thu, 15 May 2025 02:31:01 -0700 (PDT)
Message-ID: <f1481870-56b1-48b0-b484-22eeb3b5ccf2@arm.com>
Date: Thu, 15 May 2025 15:00:58 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Deduplicate test logging in
 test_mlock_lock()
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250515-selftest-mm-mlock2-dup-v1-1-963d5d7d243a@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250515-selftest-mm-mlock2-dup-v1-1-963d5d7d243a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/05/25 2:57 pm, Mark Brown wrote:
> The mlock2-tests test_mlock_lock() test reports two test results with
> an identical string, one reporitng if it successfully locked a block of
> memory and another reporting if the lock is still present after doing an
> unlock (following a similar pattern to other tests in the same program).
> This confuses test automation since the test string is used to deduplicate
> tests, change the post unlock test to report "Unlocked" instead like the
> other tests to fix this.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/mm/mlock2-tests.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
> index 7f0d50fa361d..3e90ff37e336 100644
> --- a/tools/testing/selftests/mm/mlock2-tests.c
> +++ b/tools/testing/selftests/mm/mlock2-tests.c
> @@ -196,7 +196,7 @@ static void test_mlock_lock(void)
>   		ksft_exit_fail_msg("munlock(): %s\n", strerror(errno));
>   	}
>   
> -	ksft_test_result(!unlock_lock_check(map), "%s: Locked\n", __func__);
> +	ksft_test_result(!unlock_lock_check(map), "%s: Unlocked\n", __func__);
>   	munmap(map, 2 * page_size);
>   }
>   

Acked-by: Dev Jain <dev.jain@arm.com>

> 
> ---
> base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
> change-id: 20250514-selftest-mm-mlock2-dup-277d586bb29d
> 
> Best regards,


