Return-Path: <linux-kselftest+bounces-6311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E5A87B730
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 06:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A041F223F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 05:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA138BE5;
	Thu, 14 Mar 2024 05:00:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B336127;
	Thu, 14 Mar 2024 05:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710392453; cv=none; b=G9oDa/OL4MglzLPC/AVZH+7S/+y1H3CgbfAdNnj3aqo8mJcOOyXNSOwOowlPZk3RqPoW19xpGWIzVyWWncKi4AHnp+saLF0XOxw9hrduDnOknyKogB7MarCYN7iOqXZc1uZOhr2dGe3U7iBUH67r0IDQ4cNKOYtwGSOkH4MXvl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710392453; c=relaxed/simple;
	bh=y6QaxWFqGnE5GaMe6rGX0u/jHox4nnL4G0s/sorQqV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMYbx9xq+UivdqNHUFLkUCgVT3cmczhneUeljO1DhPkcOaFlJlfoq5dmazH7eYIXEtaD1XgI/mz0/5RX8eufHcFPCpmHTYfkPHr/hlYBnM+DKiQSaltd5UPJc+hJRQa7vj9Pzq+uJELi4Um5tIb/do5Dl84w/8pzOUAJYhpEXv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FE671007;
	Wed, 13 Mar 2024 22:01:25 -0700 (PDT)
Received: from [10.162.40.27] (e116581.arm.com [10.162.40.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E78E03F73F;
	Wed, 13 Mar 2024 22:00:46 -0700 (PDT)
Message-ID: <12b0aa90-3b4f-4fb0-b4df-c677f496cb09@arm.com>
Date: Thu, 14 Mar 2024 10:30:44 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] selftests/mm: virtual_address_range: conform to
 TAP format output
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anshuman.Khandual@arm.com
References: <20240202113119.2047740-1-usama.anjum@collabora.com>
 <20240202113119.2047740-13-usama.anjum@collabora.com>
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240202113119.2047740-13-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/2/24 17:01, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   .../selftests/mm/virtual_address_range.c      | 44 +++++++++----------
>   1 file changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index bae0ceaf95b13..7bcf8d48256a6 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -12,6 +12,7 @@
>   #include <errno.h>
>   #include <sys/mman.h>
>   #include <sys/time.h>
> +#include "../kselftest.h"
>   
>   /*
>    * Maximum address range mapped with a single mmap()
> @@ -68,23 +69,15 @@ static char *hind_addr(void)
>   	return (char *) (1UL << bits);
>   }
>   
> -static int validate_addr(char *ptr, int high_addr)
> +static void validate_addr(char *ptr, int high_addr)
>   {
>   	unsigned long addr = (unsigned long) ptr;
>   
> -	if (high_addr) {
> -		if (addr < HIGH_ADDR_MARK) {
> -			printf("Bad address %lx\n", addr);
> -			return 1;
> -		}
> -		return 0;
> -	}
> +	if (high_addr && addr < HIGH_ADDR_MARK)
> +		ksft_exit_fail_msg("Bad address %lx\n", addr);
>   
> -	if (addr > HIGH_ADDR_MARK) {
> -		printf("Bad address %lx\n", addr);
> -		return 1;
> -	}
> -	return 0;
> +	if (addr > HIGH_ADDR_MARK)
> +		ksft_exit_fail_msg("Bad address %lx\n", addr);
>   }
>   
>   static int validate_lower_address_hint(void)
> @@ -107,23 +100,29 @@ int main(int argc, char *argv[])
>   	char *hint;
>   	unsigned long i, lchunks, hchunks;
>   
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
>   	for (i = 0; i < NR_CHUNKS_LOW; i++) {
>   		ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
>   					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>   
>   		if (ptr[i] == MAP_FAILED) {
> -			if (validate_lower_address_hint())
> -				return 1;
> +			if (validate_lower_address_hint()) {
> +				ksft_test_result_skip("Memory constraint not fulfilled\n");
> +				ksft_finished();
> +			}

Hi,

When validate_lower_address_hint() returns 1, it implies that despite 
filling the lower

range, mmap succeeded. IMHO, ksft_exit_fail_msg() should be used 
instead, with a

more descriptive message indicating that the memory was unexpectedly 
allocated.


Regards

Dev

>   			break;
>   		}
>   
> -		if (validate_addr(ptr[i], 0))
> -			return 1;
> +		validate_addr(ptr[i], 0);
>   	}
>   	lchunks = i;
>   	hptr = (char **) calloc(NR_CHUNKS_HIGH, sizeof(char *));
> -	if (hptr == NULL)
> -		return 1;
> +	if (hptr == NULL) {
> +		ksft_test_result_skip("Memory constraint not fulfilled\n");
> +		ksft_finished();
> +	}
>   
>   	for (i = 0; i < NR_CHUNKS_HIGH; i++) {
>   		hint = hind_addr();
> @@ -133,8 +132,7 @@ int main(int argc, char *argv[])
>   		if (hptr[i] == MAP_FAILED)
>   			break;
>   
> -		if (validate_addr(hptr[i], 1))
> -			return 1;
> +		validate_addr(hptr[i], 1);
>   	}
>   	hchunks = i;
>   
> @@ -145,5 +143,7 @@ int main(int argc, char *argv[])
>   		munmap(hptr[i], MAP_CHUNK_SIZE);
>   
>   	free(hptr);
> -	return 0;
> +
> +	ksft_test_result_pass("Test\n");
> +	ksft_finished();
>   }

