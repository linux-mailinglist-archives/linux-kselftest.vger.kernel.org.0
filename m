Return-Path: <linux-kselftest+bounces-3930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A3D8456E4
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 13:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34CC1F29F00
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 12:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6D315D5D9;
	Thu,  1 Feb 2024 12:04:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9790F15D5DB;
	Thu,  1 Feb 2024 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789069; cv=none; b=hwK51EDv1p/LElblwUKA2Hi6vo9TsNLMWSjEYR8U81rkLM9zSDC1WPlKgOE9rrqEmKLIPLTotWKTZGLVQiH6C1dck3xLF30YRQImsWB+uvr9unxaGLq9ga8FEYNul4bwmboJXHelOsRDXpVXOGogpTd/ABGqwYm/vj0wMfPBLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789069; c=relaxed/simple;
	bh=qo7pwrQdY7fIkZ8m5MR220PWKc/kV4xPGU2nyh1wI3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7cgFyVPJ+R344NPiqgBQEDIrkatbbL1sTTj87+oZV8AXNgTSEtj0I5zAn2lmpdYHZDwWaAyUH5H/qoxRFqLDhkwJoi3OobAMjqWpVsv9ydKaD85cqO4Kx+PRqDdEIz+Y9+En0NeCEjII+oZd4XbtBozwNSt2nqliEhndr3ocqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFBC6DA7;
	Thu,  1 Feb 2024 04:05:08 -0800 (PST)
Received: from [10.57.79.60] (unknown [10.57.79.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE8DB3F762;
	Thu,  1 Feb 2024 04:04:24 -0800 (PST)
Message-ID: <f833c7f9-f59a-49d5-9fce-dc531c11509e@arm.com>
Date: Thu, 1 Feb 2024 12:04:23 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] selftests/mm: run_vmtests: remove sudo and conform
 to tap
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240125154608.720072-1-usama.anjum@collabora.com>
 <20240125154608.720072-3-usama.anjum@collabora.com>
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240125154608.720072-3-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/01/2024 15:46, Muhammad Usama Anjum wrote:
> Remove sudo as some test running environments may not have sudo
> available. Instead skip the test if root privileges aren't available in
> the test.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Added this patch in v2
> 
> We are allocating 2*RLIMIT_MEMLOCK.rlim_max memory and mmap() isn't
> failing. This seems like true bug in the kernel. Even the root user
> shouldn't be able to allocate more memory than allowed MEMLOCKed memory.
> Any ideas?
> ---
>  tools/testing/selftests/mm/on-fault-limit.c | 36 ++++++++++-----------
>  tools/testing/selftests/mm/run_vmtests.sh   |  2 +-
>  2 files changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/on-fault-limit.c b/tools/testing/selftests/mm/on-fault-limit.c
> index b5888d613f34e..0ea98ffab3589 100644
> --- a/tools/testing/selftests/mm/on-fault-limit.c
> +++ b/tools/testing/selftests/mm/on-fault-limit.c
> @@ -5,40 +5,38 @@
>  #include <string.h>
>  #include <sys/time.h>
>  #include <sys/resource.h>
> +#include "../kselftest.h"
>  
> -static int test_limit(void)
> +static void test_limit(void)
>  {
> -	int ret = 1;
>  	struct rlimit lims;
>  	void *map;
>  
> -	if (getrlimit(RLIMIT_MEMLOCK, &lims)) {
> -		perror("getrlimit");
> -		return ret;
> -	}
> +	if (getrlimit(RLIMIT_MEMLOCK, &lims))
> +		ksft_exit_fail_msg("getrlimit: %s\n", strerror(errno));
>  
> -	if (mlockall(MCL_ONFAULT | MCL_FUTURE)) {
> -		perror("mlockall");
> -		return ret;
> -	}
> +	if (mlockall(MCL_ONFAULT | MCL_FUTURE))
> +		ksft_exit_fail_msg("mlockall: %s\n", strerror(errno));
>  
>  	map = mmap(NULL, 2 * lims.rlim_max, PROT_READ | PROT_WRITE,
>  		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
> +
> +	ksft_test_result(map == MAP_FAILED, "Failed mmap\n");
> +
>  	if (map != MAP_FAILED)
> -		printf("mmap should have failed, but didn't\n");
> -	else {
> -		ret = 0;
>  		munmap(map, 2 * lims.rlim_max);
> -	}
> -
>  	munlockall();
> -	return ret;
>  }
>  
>  int main(int argc, char **argv)
>  {
> -	int ret = 0;
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +	if (getuid())
> +		ksft_test_result_skip("Require root privileges to run\n");
> +	else
> +		test_limit();
>  
> -	ret += test_limit();
> -	return ret;
> +	ksft_finished();
>  }
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 246d53a5d7f28..e373d592dbf5c 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -291,7 +291,7 @@ echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
>  
>  CATEGORY="compaction" run_test ./compaction_test
>  
> -CATEGORY="mlock" run_test sudo -u nobody ./on-fault-limit
> +CATEGORY="mlock" run_test ./on-fault-limit

I think changing this is going to give unintended results. run_vmtests.sh must
already be running as root. "sudo -u nobody" is deprivieging the test to run as
nobody. The rlimit is not enforced for root so this test must run unprivileged
to work. See man page for getrlimit():

  Since Linux 2.6.9, no limits are placed on the amount of memory that a
  privileged process may lock, and this limit instead governs the amount of
  memory that an unprivileged process may lock

So I think the correct fix is actually to install sudo on your CI.

>  
>  CATEGORY="mmap" run_test ./map_populate
>  


