Return-Path: <linux-kselftest+bounces-25783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA459A2822E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 03:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5195C1633F6
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 02:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7FA2116EB;
	Wed,  5 Feb 2025 02:52:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A6C25A65E;
	Wed,  5 Feb 2025 02:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738723933; cv=none; b=bvDB3JErcwnv1Ze8FgW8tzj8YteQyZvXbP/SIZ2wV8BdXfqPVeDfti66sCUzxgdkvDXnrJH/2dbShvsomcjqEB3MDKvFt+uOt7XBMRfvsombOUpMcQYBR8SyJvslG/OYNX7yr966OGmPv6hjtHAn2jkYeVSI134slSol7dTOL2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738723933; c=relaxed/simple;
	bh=UqBRS20e47Py0ck1XVhetdet5Oi0enyRvKQOePUH7gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rr2c+E/H+BO2s2i+KNpxUQe7NdkbW+n9phqYlg4E0a0Pk/KiRa00m4r6tXGHn1QoebG+guhae52phfcHzlNx7Gt0OFmMDTapjr+PpQ0C51pCA7kFp+3+quF3CiYsDx4RulqYh4ziel08XHcsqGA//kXHWvqqK/NyvukzMd4MHBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B963011FB;
	Tue,  4 Feb 2025 18:52:33 -0800 (PST)
Received: from [10.162.16.89] (unknown [10.162.16.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F6A73F5A1;
	Tue,  4 Feb 2025 18:52:07 -0800 (PST)
Message-ID: <2e160343-8420-4f55-86b1-128676cf75d3@arm.com>
Date: Wed, 5 Feb 2025 08:22:04 +0530
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
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250204-kselftest-mm-fix-dups-v1-1-6afe417ef4bb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/25 04:23, Mark Brown wrote:
> The thuge-gen test_mmap() and test_shmget() tests are repeatedly run for a
> variety of sizes but always report the result of their test with the same
> name, meaning that automated sysetms running the tests are unable to

s/sysetms/system		^^^^^^

> distinguish between the various tests. Add the supplied sizes to the logged
> test names to distinguish between runs.

This makes sense given that the size parameter is available right away.

> 
> Fixes: b38bd9b2c448 ("selftests/mm: thuge-gen: conform to TAP format output")

Just wondering how this fixes anything ? This seems like an improvement to
the current behaviour.

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/mm/thuge-gen.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> index e4370b79b62ffb133056eb843cdd1eaeba6503df..cd5174d735be405220d99ae796a3768f53df6ea4 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -127,7 +127,7 @@ void test_mmap(unsigned long size, unsigned flags)
>  
>  	show(size);
>  	ksft_test_result(size == getpagesize() || (before - after) == NUM_PAGES,
> -			 "%s mmap\n", __func__);
> +			 "%s mmap %lu\n", __func__, size);
>  
>  	if (munmap(map, size * NUM_PAGES))
>  		ksft_exit_fail_msg("%s: unmap %s\n", __func__, strerror(errno));
> @@ -165,7 +165,7 @@ void test_shmget(unsigned long size, unsigned flags)
>  
>  	show(size);
>  	ksft_test_result(size == getpagesize() || (before - after) == NUM_PAGES,
> -			 "%s: mmap\n", __func__);
> +			 "%s: mmap %lu\n", __func__, size);
>  	if (shmdt(map))
>  		ksft_exit_fail_msg("%s: shmdt: %s\n", __func__, strerror(errno));
>  }
> 

Otherwise LGTM.

