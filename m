Return-Path: <linux-kselftest+bounces-11345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20A88FFF4E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 11:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25060B22C96
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 09:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B3515B567;
	Fri,  7 Jun 2024 09:24:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FBB15B139;
	Fri,  7 Jun 2024 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717752254; cv=none; b=GTq34TCIkxwKT/qzE8UBNW1to5J6nOC7piFqrCb2YleOELVyPbth43lTFMlXR19M3H4QHooY10m1FwGUK0kGXV9505BB05xLXE5kPtbttYZty9VMqMvknkvxkj+1xm4dEy6YrHlllH931VqeWwupt7NjY9ckG4C5+mSdm3LtVi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717752254; c=relaxed/simple;
	bh=lrsNpKHlXm+fqyomkyTMZ4TzIB2arKsSoxi2W72FzVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GboVbkh0qURxH4j4pOaDUVidP5MzFW44K41uYvh4VL/15e4aWCnKZiTYPhhCY4x/RXx2ehUIyiX//JugQ7xscxomfkWitekcvDw5d3oRVO7B5jNe7fj5k2H7lqnpzd2ZtTfwZ5ROzRLkTGDnnth852NYhbSALP6Sx+0CCKLwWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EB3D2F4;
	Fri,  7 Jun 2024 02:24:35 -0700 (PDT)
Received: from [10.57.70.246] (unknown [10.57.70.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B5B43F762;
	Fri,  7 Jun 2024 02:24:09 -0700 (PDT)
Message-ID: <4f0732ed-1355-436f-be66-c7486e3cf1e7@arm.com>
Date: Fri, 7 Jun 2024 10:24:08 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: mm: Make map_fixed_noreplace test names stable
Content-Language: en-GB
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240605-kselftest-mm-fixed-noreplace-v1-1-a235db8b9be9@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240605-kselftest-mm-fixed-noreplace-v1-1-a235db8b9be9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/06/2024 23:36, Mark Brown wrote:
> KTAP parsers interpret the output of ksft_test_result_*() as being the
> name of the test.  The map_fixed_noreplace test uses a dynamically
> allocated base address for the mmap()s that it tests and currently
> includes this in the test names that it logs so the test names that are
> logged are not stable between runs.  It also uses multiples of PAGE_SIZE
> which mean that runs for kernels with different PAGE_SIZE configurations
> can't be directly compared.  Both these factors cause issues for CI
> systems when interpreting and displaying results.
> 
> Fix this by replacing the current test names with fixed strings
> describing the intent of the mappings that are logged, the existing
> messages with the actual addresses and sizes are retained as diagnostic
> prints to aid in debugging.
> 
> Fixes: 4838cf70e539 ("selftests/mm: map_fixed_noreplace: conform test to TAP format output")
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  tools/testing/selftests/mm/map_fixed_noreplace.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/map_fixed_noreplace.c b/tools/testing/selftests/mm/map_fixed_noreplace.c
> index b74813fdc951..d53de2486080 100644
> --- a/tools/testing/selftests/mm/map_fixed_noreplace.c
> +++ b/tools/testing/selftests/mm/map_fixed_noreplace.c
> @@ -67,7 +67,8 @@ int main(void)
>  		dump_maps();
>  		ksft_exit_fail_msg("Error: munmap failed!?\n");
>  	}
> -	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_test_result_pass("mmap() 5*PAGE_SIZE at base\n");
>  
>  	addr = base_addr + page_size;
>  	size = 3 * page_size;
> @@ -76,7 +77,8 @@ int main(void)
>  		dump_maps();
>  		ksft_exit_fail_msg("Error: first mmap() failed unexpectedly\n");
>  	}
> -	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_test_result_pass("mmap() 3*PAGE_SIZE at base+PAGE_SIZE\n");
>  
>  	/*
>  	 * Exact same mapping again:
> @@ -93,7 +95,8 @@ int main(void)
>  		dump_maps();
>  		ksft_exit_fail_msg("Error:1: mmap() succeeded when it shouldn't have\n");
>  	}
> -	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_test_result_pass("mmap() 5*PAGE_SIZE at base\n");
>  
>  	/*
>  	 * Second mapping contained within first:
> @@ -111,7 +114,8 @@ int main(void)
>  		dump_maps();
>  		ksft_exit_fail_msg("Error:2: mmap() succeeded when it shouldn't have\n");
>  	}
> -	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_test_result_pass("mmap() 2*PAGE_SIZE at base+PAGE_SIZE\n");
>  
>  	/*
>  	 * Overlap end of existing mapping:
> @@ -128,7 +132,8 @@ int main(void)
>  		dump_maps();
>  		ksft_exit_fail_msg("Error:3: mmap() succeeded when it shouldn't have\n");
>  	}
> -	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_test_result_pass("mmap() 2*PAGE_SIZE  at base+(3*PAGE_SIZE)\n");
>  
>  	/*
>  	 * Overlap start of existing mapping:
> @@ -145,7 +150,8 @@ int main(void)
>  		dump_maps();
>  		ksft_exit_fail_msg("Error:4: mmap() succeeded when it shouldn't have\n");
>  	}
> -	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_test_result_pass("mmap() 2*PAGE_SIZE bytes at base\n");
>  
>  	/*
>  	 * Adjacent to start of existing mapping:
> @@ -162,7 +168,8 @@ int main(void)
>  		dump_maps();
>  		ksft_exit_fail_msg("Error:5: mmap() failed when it shouldn't have\n");
>  	}
> -	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_test_result_pass("mmap() PAGE_SIZE at base\n");
>  
>  	/*
>  	 * Adjacent to end of existing mapping:
> @@ -179,7 +186,8 @@ int main(void)
>  		dump_maps();
>  		ksft_exit_fail_msg("Error:6: mmap() failed when it shouldn't have\n");
>  	}
> -	ksft_test_result_pass("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
> +	ksft_test_result_pass("mmap() PAGE_SIZE at base+(4*PAGE_SIZE)\n");
>  
>  	addr = base_addr;
>  	size = 5 * page_size;
> 
> ---
> base-commit: c3f38fa61af77b49866b006939479069cd451173
> change-id: 20240605-kselftest-mm-fixed-noreplace-44e7e55c861a
> 
> Best regards,


