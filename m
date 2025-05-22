Return-Path: <linux-kselftest+bounces-33528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12468AC16C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 00:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DA91BC1498
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 22:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1D227057E;
	Thu, 22 May 2025 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h1DJD+Ke"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB44D253345
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952843; cv=none; b=V3GYiI6QcGsXKLx2Cda/5WzJ9z92cf97nGwZgQbeFBpyjfGus4glXNDpdUwJLqqh42m5fzfZwf1MOKCYHzIofLX5doDxnMoh9C7AhCa1eDwpWqfDrGf1U0AwfF8oqUefPxmWFhGN3AEVwcFTkmBeqCpMn9PYKPmTRDaw+eiadMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952843; c=relaxed/simple;
	bh=QFTadG1jpQZeiDaP4xWCgigxpGCwKBAjZ9zwjB31BHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SuCT/VU6RlwDDpQG2ORkZu/eM3odpO/Z5tOm+oqVd9bZAVQP/N08Yu/wb3rC8jq8Ds5+W1XAVXkTugUzZlP4eFoPUgfYRcB10nxprMKdEaH5WALSfG/cujix5k1z27H9B6BmYj2DAdqStz42POZaNG/BD7z+XGS4hGlOf3xj5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h1DJD+Ke; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3dc87649822so20785725ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747952839; x=1748557639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pddVvIgVnm1bU5MZ9dojtImlseE/twHPFPQ6xCrjkhc=;
        b=h1DJD+Kes7gjsUy6Hkl+AdTKeIp9qi+tVmkuAZHg4ThzGkLJG4Wtq3syiVaL44MDsl
         umNXuKDAA/bXlAbIZsbaqRZU98hEtsKuH20IJCRZ+lygfXCYtYh1QW19xlv7QQ3/XdK3
         OUrJDOlwChPQd0TCobAIV6pjbamqMloRLTcXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747952839; x=1748557639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pddVvIgVnm1bU5MZ9dojtImlseE/twHPFPQ6xCrjkhc=;
        b=Yk4uA6Z+JPkqZOL6FdEjCukCCebFVm+1401N5iQkGZimfiddeHKerZJesu+f07JSZt
         K7XiJQ8cWbOyItqY0bbvGbPWXr2UOfxb1E1DuwE7757sCWuQo6AViHp0K9g3j+LHPFVq
         n2lRBr2phUhbS2JKx9E+U0JaeCj4cfTLP6uvtSqkYCpeOptT48M8FVVUttITiG2qJkK3
         5H1Z0t6IJrIN1XXYibCKJYQ3yLXkWsKTvlqB80t0pRmXUnO68ZL6hTg8BwZiH9R5cHGp
         IiPkAWk5sptafJ09PB+gXp8axvhj9NqCrWTDPBicuqO/kO1H6JuCT2AqjmreNTa6Tv3l
         yaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPOWnd9RyFP3QSduZWq9WRyfK/MoG3P/vg3itL0bhqc6VxwpkyvG3disoPsoN4UOou8kuvhmPIKYh6ebtAxOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNGDWLicwUuLgzcNsXnJihqMWFinWXxSeLo/OdyqZYDbytZiz
	8yMoMRzVjsAwP/yTDw7UBBCDiwuMbWDLToqjbGJYA/8wcmwnbe52iyO4CD5V1pWC/uw=
X-Gm-Gg: ASbGnctpZei9yaWL4JjYap47ECiylPvRFXfpBLwftVsEMPS4fH8N83LjaaD1D3ZAMAn
	J3C+ngakQOUmLIU0A2+Qz6ZcqwnadILTcs/hunQD6u2sPMgo5GFe2KG8AfIzLYAdPMWnnkz3Mu0
	OANUjnTWxOj4zc8Vfsh+rlEiz5zjVM4bHpxgsDv/KY1jbw6IUrSJiEqbeNi8yLCS6ddOnOI/LKF
	ynGAasOiGQmeAJYsTD9q2xz8WHrQwlR/RSgHK+hk2d7zvSDrPmzM+9NIZGBhCS446qj3CATIEUU
	hNvOkp/FRJK3RnwtB1LuG+i7QrAA12DI/KgD60Fucoxel9AFcbhnV3iaCihA5b9SqUgyzhyj
X-Google-Smtp-Source: AGHT+IFNh1stVGXYlnyUmlfL2ISRvaH3JUS0VpLbOsNWNKO/jIsOkO/3nc0m3JrqctOvCon6zOC1JQ==
X-Received: by 2002:a05:6e02:1c03:b0:3dc:787f:2bc8 with SMTP id e9e14a558f8ab-3dc932859e5mr11604625ab.12.1747952838722;
        Thu, 22 May 2025 15:27:18 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc76c160acsm19876585ab.24.2025.05.22.15.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 15:27:18 -0700 (PDT)
Message-ID: <37cce2bb-e8ca-4455-8d0b-0885363cd7e2@linuxfoundation.org>
Date: Thu, 22 May 2025 16:27:17 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: cachestat: add mmap test and /proc/cpuinfo
 test case
To: Suresh K C <suresh.k.chandrappa@gmail.com>,
 linux-kselftest@vger.kernel.org
References: <20250516124146.94932-1-suresh.k.chandrappa@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250516124146.94932-1-suresh.k.chandrappa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/25 06:41, Suresh K C wrote:
> From: Suresh K C <suresh.k.chandrappa@gmail.com>
> 
> This patch adds a new test case to validate cachestat behavior with

Add a new test case

> memory-mapped files using mmap(). The test ensures that pages are
> properly cached when accessed via mmap and verifies the expected
> number of cached pages.
> 
> Additionally, a test case for /proc/cpuinfo has been added to observe
> how cachestat handles virtual files under /proc. This helps improve
> coverage of edge cases involving pseudo-filesystems
> 
> Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>

Refer to submitting patches documentation to learn how to write
change log and how to find out out recipients for the patch.

Run get_maintainers.pl to figure out recipients for the patch.

> ---
>   .../selftests/cachestat/test_cachestat.c      | 69 ++++++++++++++++++-
>   1 file changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
> index 632ab44737ec..81e7f6dd2279 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -22,7 +22,7 @@
>   
>   static const char * const dev_files[] = {
>   	"/dev/zero", "/dev/null", "/dev/urandom",
> -	"/proc/version", "/proc"
> +	"/proc/version","/proc/cpuinfo","/proc"
>   };
>   
>   void print_cachestat(struct cachestat *cs)
> @@ -202,6 +202,65 @@ static int test_cachestat(const char *filename, bool write_random, bool create,
>   	return ret;
>   }
>   
> +bool test_cachestat_mmap(void){
> +
> +	size_t PS = sysconf(_SC_PAGESIZE);
> +	size_t filesize = PS * 512 * 2;;
> +	int syscall_ret;
> +	size_t compute_len = PS * 512;
> +	struct cachestat_range cs_range = { PS, compute_len };
> +	char *filename = "tmpshmcstat";
> +	unsigned long num_pages = compute_len / PS;
> +	struct cachestat cs;
> +	bool ret = true;
> +	int fd = open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
> +	if (fd < 0) {
> +		ksft_print_msg("Unable to create mmap file.\n");
> +		ret = false;
> +		goto out;
> +	}
> +	if (ftruncate(fd, filesize)) {
> +		ksft_print_msg("Unable to truncate mmap file.\n");
> +		ret = false;
> +		goto close_fd;
> +	}
> +	if (!write_exactly(fd, filesize)) {
> +		ksft_print_msg("Unable to write to mmap file.\n");
> +		ret = false;
> +		goto close_fd;
> +	}
> +	char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +	if (map == MAP_FAILED) {
> +		ksft_print_msg("mmap failed.\n");
> +		ret = false;
> +		goto close_fd;
> +	}
> +
> +	for (int i = 0; i < filesize; i++) {
> +		map[i] = 'A';
> +	}
> +	map[filesize - 1] = 'X';
> +	
> +	syscall_ret = syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
> +	
> +	if (syscall_ret) {
> +		ksft_print_msg("Cachestat returned non-zero.\n");
> +		ret = false;
> +	} else {
> +		print_cachestat(&cs);
> +		if (cs.nr_cache + cs.nr_evicted != num_pages) {
> +			ksft_print_msg("Total number of cached and evicted pages is off.\n");
> +			ret = false;
> +		}
> +	}
> +
> +close_fd:
> +	close(fd);
> +	unlink(filename);
> +out:
> +	return ret;
> +}
> +
>   bool test_cachestat_shmem(void)
>   {
>   	size_t PS = sysconf(_SC_PAGESIZE);
> @@ -274,7 +333,7 @@ int main(void)
>   		ret = 1;
>   	}
>   
> -	for (int i = 0; i < 5; i++) {
> +	for (int i = 0; i < 6; i++) {
>   		const char *dev_filename = dev_files[i];
>   
>   		if (test_cachestat(dev_filename, false, false, false,
> @@ -315,5 +374,11 @@ int main(void)
>   		ret = 1;
>   	}
>   
> +	if (test_cachestat_mmap())
> +		ksft_test_result_pass("cachestat works with a mmap file\n");
> +	else {
> +		ksft_test_result_fail("cachestat fails with a mmap file\n");
> +		ret = 1;
> +	}
>   	return ret;
>   }

thanks,
-- Shuah

