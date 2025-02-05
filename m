Return-Path: <linux-kselftest+bounces-25796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45013A2839E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 06:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5D218868EE
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 05:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35A721D583;
	Wed,  5 Feb 2025 05:24:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099A420F09D;
	Wed,  5 Feb 2025 05:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738733055; cv=none; b=JoDDAPhbAeIYkv0DSmDJfxodO9FNsON01S6z02wjTM0BZmRfpnKt/SM4L0aVLTeCL2eMkK+4ZPYQJH4W5dESQOjriigwdVejVryH09sxVI7v14gw2orGX9yQHtIUHhRcSIN/hBhN/5RKjK9lbrvyqRzCUFhzVdLYqoFbQ8BWlUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738733055; c=relaxed/simple;
	bh=+Lk5B53trfdD2kQOnydrTPR6mmkbLrC29ruqyJk4Buc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYknH0stIK1ShiRLcRS18ZFnGlR1+3Ojh15m25WN05Il8OvKlxch5ZfUWBKrSxGdT2Kmh/u9eZCCQvt1m0wjqhy9erau+tzqzolbrm/iRO3dzTT1pFkMriPrikqYNC+OMOZSE7hA0ghObdyeJ1NnSp85O0Z6JpnyTkC/wbzSIfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E680311FB;
	Tue,  4 Feb 2025 21:24:36 -0800 (PST)
Received: from [10.162.41.15] (K4MQJ0H1H2.blr.arm.com [10.162.41.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8E853F63F;
	Tue,  4 Feb 2025 21:24:10 -0800 (PST)
Message-ID: <ee3ca3d6-ed8e-4138-a0ec-5a19a23f937e@arm.com>
Date: Wed, 5 Feb 2025 10:54:07 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Fix thuge-gen test name uniqueness
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250204-kselftest-mm-fix-dups-v1-1-6afe417ef4bb@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250204-kselftest-mm-fix-dups-v1-1-6afe417ef4bb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/02/25 4:23 am, Mark Brown wrote:
> The thuge-gen test_mmap() and test_shmget() tests are repeatedly run for a
> variety of sizes but always report the result of their test with the same
> name, meaning that automated sysetms running the tests are unable to
> distinguish between the various tests. Add the supplied sizes to the logged
> test names to distinguish between runs.
> 
> Fixes: b38bd9b2c448 ("selftests/mm: thuge-gen: conform to TAP format output")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/mm/thuge-gen.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> index e4370b79b62ffb133056eb843cdd1eaeba6503df..cd5174d735be405220d99ae796a3768f53df6ea4 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -127,7 +127,7 @@ void test_mmap(unsigned long size, unsigned flags)
>   
>   	show(size);
>   	ksft_test_result(size == getpagesize() || (before - after) == NUM_PAGES,
> -			 "%s mmap\n", __func__);
> +			 "%s mmap %lu\n", __func__, size);
>   
>   	if (munmap(map, size * NUM_PAGES))
>   		ksft_exit_fail_msg("%s: unmap %s\n", __func__, strerror(errno));
> @@ -165,7 +165,7 @@ void test_shmget(unsigned long size, unsigned flags)
>   
>   	show(size);
>   	ksft_test_result(size == getpagesize() || (before - after) == NUM_PAGES,
> -			 "%s: mmap\n", __func__);
> +			 "%s: mmap %lu\n", __func__, size);
>   	if (shmdt(map))
>   		ksft_exit_fail_msg("%s: shmdt: %s\n", __func__, strerror(errno));
>   }


Suggest converting size to MB before printing. This will print the size 
in bytes which is confusing. Otherwise:

Reviewed-by: Dev Jain <dev.jain@arm.com>



