Return-Path: <linux-kselftest+bounces-3935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC9F8457E2
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 13:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF7D1F26305
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 12:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A46286627;
	Thu,  1 Feb 2024 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uCrbeZSF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E02F86626;
	Thu,  1 Feb 2024 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790753; cv=none; b=Cr6/VhZCN99LTEjfeHwfElwV8QXMMG/iVfanTM8Ys6vr0Uhfg73gk4kFsdkfJwTVAF56asyZ5IGptKhy4tKhNVGukcsW9hU3VqGGKhjMAvzf9+3Jph8/ebT0RkY5PMXixLmNp6k6QZMQrZwatUryeeMM7nQtRzeWBP83JF8x85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790753; c=relaxed/simple;
	bh=qhZOIwqkNCYpK2Pp3te5HY4KlfQz8tkJ4SWf+XkvlIM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QtnB6z1dvJgcI5bphHbbH1MJMTGKXNkcpUk5jYd8qr2G0Pxi/mJIvWwViGJt+9jLU8UdLLi+4BMVab4Qe6F/0+MbIMYAphqjNpEKOdNINF/GWEhiJVifLqxIGAL/H+Z5BVihBFF3UUurkFYxnN/3OWJ3MgribuYG/Fzukpjwj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uCrbeZSF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706790749;
	bh=qhZOIwqkNCYpK2Pp3te5HY4KlfQz8tkJ4SWf+XkvlIM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=uCrbeZSFwgWfSog96oC2NDyv2UBshUZiQloq+462UDy+Y5RhZ83+Z4zLj1BaeN+ko
	 Cy9GOMa/7VgV8bwMbTH1hNfRy2ePm8viLk/h4IxcoO90TvQ2OqznHW4tf+oMVqc7Tz
	 KnjRKgOrnWWFOAuUl+O2jfRrIm/4n+O7OQMdS4H/Rq5UZhywlhK1aUcyr65HIK2ysu
	 a9uMcYTSiJfB3SPiJypIxjlArGnevqRYCKGsiJQH1dF7r4ebHaF3+fTG7vE53GiU+B
	 MInpTqco6OcASUesYM8V7Ei1J1MIGlsLM4sGyjaIINPDvVg2Cq8JmfPEheroUCUhD8
	 DsuAQU4qN5XTA==
Received: from [100.66.47.90] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3D366378047F;
	Thu,  1 Feb 2024 12:32:28 +0000 (UTC)
Message-ID: <b1994cfa-8ddc-407a-9f72-84ce3d4ba787@collabora.com>
Date: Thu, 1 Feb 2024 17:32:44 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: on-fault-limit: run test without root
 privileges otherwise skip
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20240201071307.592317-1-usama.anjum@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240201071307.592317-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Please disregard this patch. I'll send another patch to fix another thing.

On 2/1/24 12:13 PM, Muhammad Usama Anjum wrote:
> The mmap() respects rlimit only for normal users. This test should be
> run as normal user, without root privileges.
> 
> Fixes: b6221771d468 ("selftests/mm: run_vmtests: remove sudo and conform to tap")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/mm/on-fault-limit.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/on-fault-limit.c b/tools/testing/selftests/mm/on-fault-limit.c
> index 0ea98ffab3589..431c1277d83a1 100644
> --- a/tools/testing/selftests/mm/on-fault-limit.c
> +++ b/tools/testing/selftests/mm/on-fault-limit.c
> @@ -21,7 +21,7 @@ static void test_limit(void)
>  	map = mmap(NULL, 2 * lims.rlim_max, PROT_READ | PROT_WRITE,
>  		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
>  
> -	ksft_test_result(map == MAP_FAILED, "Failed mmap\n");
> +	ksft_test_result(map == MAP_FAILED, "The map failed respecting mlock limits\n");
>  
>  	if (map != MAP_FAILED)
>  		munmap(map, 2 * lims.rlim_max);
> @@ -33,8 +33,8 @@ int main(int argc, char **argv)
>  	ksft_print_header();
>  	ksft_set_plan(1);
>  
> -	if (getuid())
> -		ksft_test_result_skip("Require root privileges to run\n");
> +	if (!getuid())
> +		ksft_test_result_skip("The test must be run from a normal user\n");
>  	else
>  		test_limit();
>  

-- 
BR,
Muhammad Usama Anjum

