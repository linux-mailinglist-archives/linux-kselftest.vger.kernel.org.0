Return-Path: <linux-kselftest+bounces-47612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B90CCC3DAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 16:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D850730FD311
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B824B2D59FA;
	Tue, 16 Dec 2025 14:58:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEC62F25F2;
	Tue, 16 Dec 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897100; cv=none; b=SuSlY0lr3y6rM+e0CP68bgWrl5mzRPM0jKz2/VVKrVqAd5xhaz1EDVVBvZylLnTJz21ftdwny8KRvg/rmXdNZP2Fozkc7RbValdBuNZ2rRjXZgQLxnmrQClxgdlgwvdtlJ3yCFZ4y++75Xsipcrt/CLPdehZz8EOc0Nz8ZPDGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897100; c=relaxed/simple;
	bh=goNTGcIj0ow7rA/qsR2Yr1kWZwiemohsoKMIQNigQ9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=im7VfJjbdaaryjXXVgvkSgdv7HOIkIiKkNG0u4vg7uM2dT6vhGyG/UafP8gLcgZfUAbEKP/IZF1thvmK2l8410VUx2daE7Mi+DaMsIn6p/ysnVvimsnfUa8y7k0eF4e53UV/jOX582h62p6qmGociv+wrT14oliBWoKFwX8Y1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E9FDFEC;
	Tue, 16 Dec 2025 06:58:11 -0800 (PST)
Received: from [10.57.91.77] (unknown [10.57.91.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63C633F73B;
	Tue, 16 Dec 2025 06:58:16 -0800 (PST)
Message-ID: <9d4c6f30-1262-461c-9fb8-25f7c8f4ad0e@arm.com>
Date: Tue, 16 Dec 2025 14:58:14 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/mm: fix exit code in pagemap_ioctl
Content-Language: en-GB
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Usama Anjum <Usama.Anjum@arm.com>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
 <20251216142633.2401447-5-kevin.brodsky@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251216142633.2401447-5-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/12/2025 14:26, Kevin Brodsky wrote:
> pagemap_ioctl always reports success, whether the tests succeeded or
> not. Call ksft_finished() to report the right status.
> 
> While at it also fix the exit code in unexpected situations:
> 
> - Report SKIP if userfaultfd isn't available (in line with other
>   tests)
> 
> - Report FAIL if we failed to open /proc/self/pagemap (returning
>   -EINVAL from main() is meaningless)
> 
> Cc: Usama Anjum <Usama.Anjum@arm.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  tools/testing/selftests/mm/pagemap_ioctl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
> index 67a7a3705604..aeedb96dfffb 100644
> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
> @@ -1553,7 +1553,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
>  	ksft_print_header();
>  
>  	if (init_uffd())
> -		ksft_exit_pass();
> +		ksft_exit_skip("Failed to initialize userfaultfd\n");
>  
>  	ksft_set_plan(117);
>  
> @@ -1562,7 +1562,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
>  
>  	pagemap_fd = open(PAGEMAP, O_RDONLY);
>  	if (pagemap_fd < 0)
> -		return -EINVAL;
> +		ksft_exit_fail_msg("Failed to open " PAGEMAP "\n");
>  
>  	/* 1. Sanity testing */
>  	sanity_tests_sd();
> @@ -1734,5 +1734,5 @@ int main(int __attribute__((unused)) argc, char *argv[])
>  	zeropfn_tests();
>  
>  	close(pagemap_fd);
> -	ksft_exit_pass();
> +	ksft_finished();
>  }


