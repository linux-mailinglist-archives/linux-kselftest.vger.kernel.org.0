Return-Path: <linux-kselftest+bounces-3392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F401838846
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 08:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203831F21943
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565B752F82;
	Tue, 23 Jan 2024 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SPfiKPLY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD31853E2E;
	Tue, 23 Jan 2024 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996331; cv=none; b=n4E1GrgbZKgXYePcsiEc4qnauty8/Efr+uGeJrsL7omMh++Q0d0jfcK9bTIFYIQXL+uJF5a8d18V3XEzpn3Vvm3sttOq7+5mNzrYvvbc9ugbif7WPOH7BVvXYGxEBhVZiSdN8Iqb06dnP1YkODyJhAj1G4KBSG/eIcAuDCxyXmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996331; c=relaxed/simple;
	bh=K6k2QYxpHaMZ2H7zY/M+E12/FkVtZ9PqhUpBbAY4yvo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PmgwfHUIeQ+wlz8ichsNwpp/DiL4v9L1AcdQjF727QV7jODkK0IrpOc3ypPG4qurTkLwtWGvMl/yAghEWdztkJWl66E7mAzMCKvma12w4ibshf+VH47QkRPkG594AyvJ2xAonjMPAnLvXG35mZfsM4+WgUWpCGuwr9FtY1wK/k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SPfiKPLY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705996327;
	bh=K6k2QYxpHaMZ2H7zY/M+E12/FkVtZ9PqhUpBbAY4yvo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=SPfiKPLY5BytPAwfWFsIu6RvNfW9rLkcEqNoDbKMXsCTrz1xvBcpDNRrya6jfH+Ho
	 m1lY6Xf0msHKHHHNmB8DcEk7e6pAnWjdti3y0epaeU2Q48Ww/HArLmm4G7iQqZwSFo
	 tYRVhzjvokTH/g1PsYSa7/+SzvlYcO069Yk9F1cgV/b4RYvxjY00oniw8WbJBU2Ilu
	 hxxR3VjqVlkSi0EIZt2mtZrz/6Dv6hA08xobu4BgfKA+iDURWwnmUGXUMuPJTy+r97
	 kXulpIUNR3tlHZ70027ywlg6kyDui6XrvC6sL7FrHKOXj4nigqyH362YKVNkq7Ioie
	 b9IPvROSQGvIw==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A1A293782066;
	Tue, 23 Jan 2024 07:52:05 +0000 (UTC)
Message-ID: <965acceb-9aa1-473f-a873-40eaaebe5d0c@collabora.com>
Date: Tue, 23 Jan 2024 12:52:20 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v3 1/7] selftests/mm: hugepage-shm: conform test to TAP
 format output
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
References: <20240115073247.1280266-1-usama.anjum@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240115073247.1280266-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

There hasn't been any comment on these. I guess, they can be picked up now?

Thanks,

On 1/15/24 12:32 PM, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> The "." was being printed inside for loop to indicate the writes
> progress. This was extraneous and hence removed in the patch.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/mm/hugepage-shm.c | 47 +++++++++++------------
>  1 file changed, 22 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/hugepage-shm.c b/tools/testing/selftests/mm/hugepage-shm.c
> index 478bb1e989e9..f949dbbc3454 100644
> --- a/tools/testing/selftests/mm/hugepage-shm.c
> +++ b/tools/testing/selftests/mm/hugepage-shm.c
> @@ -34,11 +34,10 @@
>  #include <sys/ipc.h>
>  #include <sys/shm.h>
>  #include <sys/mman.h>
> +#include "../kselftest.h"
>  
>  #define LENGTH (256UL*1024*1024)
>  
> -#define dprintf(x)  printf(x)
> -
>  /* Only ia64 requires this */
>  #ifdef __ia64__
>  #define ADDR (void *)(0x8000000000000000UL)
> @@ -54,44 +53,42 @@ int main(void)
>  	unsigned long i;
>  	char *shmaddr;
>  
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
>  	shmid = shmget(2, LENGTH, SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W);
> -	if (shmid < 0) {
> -		perror("shmget");
> -		exit(1);
> -	}
> -	printf("shmid: 0x%x\n", shmid);
> +	if (shmid < 0)
> +		ksft_exit_fail_msg("shmget: %s\n", strerror(errno));
> +
> +	ksft_print_msg("shmid: 0x%x\n", shmid);
>  
>  	shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
>  	if (shmaddr == (char *)-1) {
> -		perror("Shared memory attach failure");
>  		shmctl(shmid, IPC_RMID, NULL);
> -		exit(2);
> +		ksft_exit_fail_msg("Shared memory attach failure: %s\n", strerror(errno));
>  	}
> -	printf("shmaddr: %p\n", shmaddr);
>  
> -	dprintf("Starting the writes:\n");
> -	for (i = 0; i < LENGTH; i++) {
> +	ksft_print_msg("shmaddr: %p\n", shmaddr);
> +
> +	ksft_print_msg("Starting the writes:");
> +	for (i = 0; i < LENGTH; i++)
>  		shmaddr[i] = (char)(i);
> -		if (!(i % (1024 * 1024)))
> -			dprintf(".");
> -	}
> -	dprintf("\n");
> +	ksft_print_msg("Done.\n");
>  
> -	dprintf("Starting the Check...");
> +	ksft_print_msg("Starting the Check...");
>  	for (i = 0; i < LENGTH; i++)
> -		if (shmaddr[i] != (char)i) {
> -			printf("\nIndex %lu mismatched\n", i);
> -			exit(3);
> -		}
> -	dprintf("Done.\n");
> +		if (shmaddr[i] != (char)i)
> +			ksft_exit_fail_msg("\nIndex %lu mismatched\n", i);
> +	ksft_print_msg("Done.\n");
>  
>  	if (shmdt((const void *)shmaddr) != 0) {
> -		perror("Detach failure");
>  		shmctl(shmid, IPC_RMID, NULL);
> -		exit(4);
> +		ksft_exit_fail_msg("Detach failure: %s\n", strerror(errno));
>  	}
>  
>  	shmctl(shmid, IPC_RMID, NULL);
>  
> -	return 0;
> +	ksft_test_result_pass("Completed test\n");
> +
> +	ksft_finished();
>  }

-- 
BR,
Muhammad Usama Anjum

