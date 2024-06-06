Return-Path: <linux-kselftest+bounces-11288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C548FE46F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 12:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880541F243C9
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 10:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DF8194AE0;
	Thu,  6 Jun 2024 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LZ8Nor8T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9A2561D;
	Thu,  6 Jun 2024 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670375; cv=none; b=d8rtOofgwRueMnCcbQ+HsJ2WADymQdWucjK+Wymw/VRO/0KLqS3TfmaJbxcYIsm2yQHDcN13lCpQR0vDouXVhYfM0Ow7u1bj+SrrOAtHBBBPFKleS1wQRQ7nYoPoPBf9h/MePJgQOXIsuB1jFN3mSyXa/oACZQdg5kXEC4nuOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670375; c=relaxed/simple;
	bh=D0uunvsoqzLWPDiha1RwJom/MhZWK4E2NrSHDqVy/Ck=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Oj/yq37woPKMVJe3dWapseI9/CdOXHtUWnA3fYar0mm0Q0Gz0quDzd2zVyINYkY3OsO0rEEaoc87/7UUah3CES/e2pcZhy96GNq33Aeo5EgzEA/+2cp5njcBxArur/FDFLN/Uznq4IOBk2Xnj1t9nlTL1waSLKTtiFz8e12/AIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LZ8Nor8T; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717670371;
	bh=D0uunvsoqzLWPDiha1RwJom/MhZWK4E2NrSHDqVy/Ck=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LZ8Nor8TvPK+ZdBUExhw0FqgdlmpE2nc5iWn4+ZbaJKbQf5ejCTkOR0lqbPQrdrfz
	 zVbRSMty8z/GVB0lioNFVDSwJQE6AeO1zMcU4F7VXUEOXXh9QwvYadV/1UlApEl6vQ
	 vw19Lx7Kbi61E48WXpgqsBJkXETyjZHbFfwv0IHtMtfGTUz0YPZOY4BuCBABM2BGFn
	 coisQyjDD4KkLEcpqTWBxAU1+BB+KEe6rnzyIKIdYpCROrAjWx3Q5mVZMJSfiAoNkg
	 XQZ0nKf9B8Gztk9OnxXD7JDMYJKTmkzoy30HxEq36xCOvW+fcNVL8z22BE08KNddcI
	 7Qg3iqFjkUMAQ==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 82C303780627;
	Thu,  6 Jun 2024 10:39:28 +0000 (UTC)
Message-ID: <4f7e6f1b-bce1-41ec-b26f-f4fb53c3b276@collabora.com>
Date: Thu, 6 Jun 2024 15:38:55 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: mm: Make map_fixed_noreplace test names stable
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20240605-kselftest-mm-fixed-noreplace-v1-1-a235db8b9be9@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240605-kselftest-mm-fixed-noreplace-v1-1-a235db8b9be9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/24 3:36 AM, Mark Brown wrote:
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
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

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

-- 
BR,
Muhammad Usama Anjum

