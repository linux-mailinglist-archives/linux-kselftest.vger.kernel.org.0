Return-Path: <linux-kselftest+bounces-6326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2F787BCDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 13:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF52C1C20FB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA50129CE3;
	Thu, 14 Mar 2024 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I1HG/6WP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290402581;
	Thu, 14 Mar 2024 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419578; cv=none; b=uWvDmN0q6VsrBXYGYR6CQbycqCXVAsameiYLOV9tAYwEfa+wSZz6WPMeH3jWZJ/kw9JyBd0Xw4m68lr+xBxaDbKby/iMAUwfF7uQN87iDfsqCQIpRnxysb5VG+qhxCAsFzODSxz1NuxfYiCnAMqJwCKiKAtoHhL8VB0Q/cf2eiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419578; c=relaxed/simple;
	bh=574oiJk4n6nucm8nS4oAXdmfVeBrOVyCvvWnaYG3mok=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KUfED8j/Ux9cLUqU1V6hME4PQXIsB7PSfMo98MzpZTm6Su0vtFRzIKuqVzyR/3hywlPF00JY93pWvNrWabLpm4ux0HUiGCLzv1+qePrYfLtK8YGFJedEZ5XtvKGz2pG3I357g1Jwql4/0tRdZcbgPytREQXMQGW58FA0I7c++r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I1HG/6WP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710419575;
	bh=574oiJk4n6nucm8nS4oAXdmfVeBrOVyCvvWnaYG3mok=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=I1HG/6WPvE/LZ73Mn7MPjH4TZNgGb/hv56lxJ1Z/1lgA2vPA1sh9TIFvjnN9QvJT2
	 6TZzMAP0EIyd7IwbzMVyH9ZtHJK8PQgiOWdC85SH/v6ZKI0sP82KgpxaV9iSDXMgl6
	 RwgZiI9cRVwaI15O43ChYvR50wrZJQJTOE9gh+OJU/3e/3oFPaw8d9IwDu4lGe/e1n
	 EwES6B/K0TuqhJCpf9WSqUk+c44skbXSLMq5urYtSpOcjFNzXz/OqG+FEKbb33nZ/L
	 SIoZLa9PflCruCMvY++ogCW22QA7kdRjWjzfoIpNw77JfB+oOm5FkiNREXIH8FG0q7
	 rJqcLHOMHfS3g==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F40CE37820EF;
	Thu, 14 Mar 2024 12:32:52 +0000 (UTC)
Message-ID: <403e7704-5d87-43c5-b48d-3faca2a9727a@collabora.com>
Date: Thu, 14 Mar 2024 17:33:13 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com
Subject: Re: [PATCH] selftests/mm: virtual_address_range: Switch to
 ksft_exit_fail_msg
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, shuah@kernel.org
References: <07e2e91b-7b0d-4810-a2a1-ed4654ecafb4@collabora.com>
 <20240314122250.68534-1-dev.jain@arm.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240314122250.68534-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for the patch. The patch should have been sent to a separate new thread.

On 3/14/24 5:22 PM, Dev Jain wrote:
> mmap() must not succeed in validate_lower_address_hint(), for if it does, it
> is a bug in mmap() itself. Reflect this behaviour with ksft_exit_fail_msg().
> While at it, do some formatting changes.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/virtual_address_range.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index 7bcf8d48256a..426ddfc345fb 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -85,7 +85,7 @@ static int validate_lower_address_hint(void)
>  	char *ptr;
>  
>  	ptr = mmap((void *) (1UL << 45), MAP_CHUNK_SIZE, PROT_READ |
> -			PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +		   PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>  
>  	if (ptr == MAP_FAILED)
>  		return 0;
> @@ -105,13 +105,11 @@ int main(int argc, char *argv[])
>  
>  	for (i = 0; i < NR_CHUNKS_LOW; i++) {
>  		ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
> -					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>  
>  		if (ptr[i] == MAP_FAILED) {
> -			if (validate_lower_address_hint()) {
> -				ksft_test_result_skip("Memory constraint not fulfilled\n");
> -				ksft_finished();
> -			}
> +			if (validate_lower_address_hint())
> +				ksft_exit_fail_msg("mmap unexpectedly succeeded with hint\n");
>  			break;
>  		}
>  
> @@ -127,7 +125,7 @@ int main(int argc, char *argv[])
>  	for (i = 0; i < NR_CHUNKS_HIGH; i++) {
>  		hint = hind_addr();
>  		hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
> -					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +			       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>  
>  		if (hptr[i] == MAP_FAILED)
>  			break;

-- 
BR,
Muhammad Usama Anjum

