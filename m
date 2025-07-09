Return-Path: <linux-kselftest+bounces-36850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F271AAFF0D7
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAB15A50FB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 18:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7A7239085;
	Wed,  9 Jul 2025 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXcnq4wQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DEB8F40;
	Wed,  9 Jul 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085486; cv=none; b=nEi0olMesCdrh8/KC0badJLcQBwI8La5XveinE/ukV+wia11LlQbcDNx7I/NNG/VQBU7F0L8BUm3rVgcwmtyjmz1Wt7L0jmnxO7X+18fN+/auuSL6ZIbb5jO0vpqkiK3Be5ZUPdo6ytWgLLvolIFK69ytN3GLoc7NQXtUyNRyfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085486; c=relaxed/simple;
	bh=wP02tXWJ6ShdmPK/mGbrE5WU/2Vnk4y3ic7CZTFpdmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZk4RvoXVGuxMOPMO6Pdj9IJXo6joswtSSZ62gdrUGGZa3KitDlY6GAJHF7cXqYf+zKVYLMuFkC3sRIDXCvXInAbK/vhxsnVNWnKXBY27gamBkkK+nWtq6P3aU8rkfkHi9C62O7B5wTRGmFz69E/8mOFcxDTP7E+wOXCRZ8xPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXcnq4wQ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-70f94fe1e40so14920997b3.1;
        Wed, 09 Jul 2025 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752085483; x=1752690283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfEz4rqEWja1PaN5ITE9k1Eh6xuG8m+k9OQNQf1a+lk=;
        b=mXcnq4wQfHUD0hjrsAliPaEm1kkP7S0AZcZwOQ9LNJu19V+uHqfVKDIJOPTyAvnnvl
         wvLOM/crr2jnB6dAlDWlCcaLHbfGZYUym7I3gYLyLnk/lQVH2U+A7MQH6v/v/AIzo1Pk
         epz4ZBEBN6ZuO2A8QUCpjSgmy5vv08TZNiJX6A3zbXociaOFOCnhRr1P4GDRGXEvwGJ/
         6fEWPvXSch/mFb85oEfYaB2gST6kqNevOf6TvR4WuQAStPSMGEhaepUAOdQ4h1+BrM2+
         NM37kkEqRTN5SNsgX4qegYK5E72LLOp4yEtEUc8LSqdIdM+xc4WCU5rPxZ46tkJXgHOc
         xbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752085483; x=1752690283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfEz4rqEWja1PaN5ITE9k1Eh6xuG8m+k9OQNQf1a+lk=;
        b=siFSpNM+X76eTtrD6U3P2pN3XarqNXSp6bUKeuda9kWQRJ7F6zFXmH9lxjjO82FRbi
         pIulxXgfWGJ4hXVEYotEs0G3jEpy4KDb2kNsK/eFhkpkZIuVNmeXH1O8/+OotyG1OrZH
         TihE//MBXAfE6G2UdNNPAj1gbYREPyofrN+i0L1QRUR9K8XZqsAQWsbJgrnURns0lddy
         yvGtYaQkckp+FJBbh4vSvtpEc5o3oH3GG0Km0Sm6b5lC9PMZUushlSSASvV7F6ersA1c
         nEMb6FBbJXggtmdnfXYTN+r2plA0oZCn9JRiriQP7AQt6H82Vhy6YB785SD+6lKCI/qE
         pqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW01yBTjsf6jtFNvZo9TrTcAD6VWmkj1xe3zYfWNT4SCz1wtElct0BEYvZlm/xe2M1Ur5jyR9PHZV6CWa3O3MMR@vger.kernel.org, AJvYcCXdS5gau0JibvT46t1YP2xIw5j+YJVX/Yang52gLwmCVKOPhY+V7h3wufV5ow/V2ZwiHyE29Ei3tElRPrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRyVxkkGE+3SCaECI2kpo+WGRUrAXo0lB+zhwTCdPaQQWXzNfG
	j4vSLpB3NSTlf57/PSxficEUHuzxJM104ckIluzDZSQTbDtH3bagRv/bE1CumA==
X-Gm-Gg: ASbGnctO4XgqLaeDb5PgTh/7Dkwnlef5+Z2fPn8eDRNxsmqpsRG6EIXV2aCRVYqWLZs
	0ezn/ZRWTJQ7ILYfnPBD0CspzDRyl9OjDr/X1hhpXIXI6FCgn85NHGlHMwZKj0jPYCczmKVqTdd
	9C4hNil9vxkgmNqXlRUg56WCc+K2/UJAyEPOvJeHyAO92nBFfboNj4qNGeYJVdWlXCvNzLwIe8k
	wppgSc6Gs2WABD5PKFWOrvE5xx3rvylKuFJnf/Y4UyO83ikzzkur+bBY1gYCNR0pn3XQAG5Bi47
	Bx0zhm2UL6/rRYIlU2VqB7Rzmvk3T77/W6AF8ouUBl4M//2HwKNqvi78egiVAw==
X-Google-Smtp-Source: AGHT+IEYYOadzxnywoxaX789M206GrbkLKEdNYBCA/EUDWpZPshYBYvXk8xq4EiH1MPzZCeeRpRMXw==
X-Received: by 2002:a05:690c:6b81:b0:716:675c:d97d with SMTP id 00721157ae682-717c15d9221mr8472797b3.15.1752085482612;
        Wed, 09 Jul 2025 11:24:42 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-716659a01f2sm26831257b3.34.2025.07.09.11.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 11:24:42 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Suresh K C <suresh.k.chandrappa@gmail.com>
Cc: nphamcs@gmail.com,
	hannes@cmpxchg.org,
	joshua.hahnjy@gmail.com,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests: cachestat: add tests for mmap Refactor and enhance mmap test for cachestat validation
Date: Wed,  9 Jul 2025 11:24:40 -0700
Message-ID: <20250709182441.2909688-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250709174657.6916-1-suresh.k.chandrappa@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  9 Jul 2025 23:16:57 +0530 Suresh K C <suresh.k.chandrappa@gmail.com> wrote:

> From: Suresh K C <suresh.k.chandrappa@gmail.com>
> 
> This patch merges the previous two patches into a single,
> cohesive test case that verifies cachestat behavior with memory-mapped files using mmap().
> It also refactors the test logic to reduce redundancy, improve error reporting, and clarify failure messages for both shmem and mmap file types.

Hi Suresh,
LGTM, thank you for the iterations!

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
 
> Changes since v2:
> 
> - Merged the two patches into one as suggested
> - Improved error messages for better clarity
> 
> Tested on x86_64 with default kernel config.
> 
> Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>
> ---
>  .../selftests/cachestat/test_cachestat.c      | 66 +++++++++++++++----
>  1 file changed, 55 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
> index 632ab44737ec..18188d7c639e 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -33,6 +33,11 @@ void print_cachestat(struct cachestat *cs)
>  	cs->nr_evicted, cs->nr_recently_evicted);
>  }
>  
> +enum file_type {
> +	FILE_MMAP,
> +	FILE_SHMEM
> +};
> +
>  bool write_exactly(int fd, size_t filesize)
>  {
>  	int random_fd = open("/dev/urandom", O_RDONLY);
> @@ -201,8 +206,19 @@ static int test_cachestat(const char *filename, bool write_random, bool create,
>  out:
>  	return ret;
>  }
> +const char* file_type_str(enum file_type type) {
> +	switch (type) {
> +		case FILE_SHMEM:
> +			return "shmem";
> +		case FILE_MMAP:
> +			return "mmap";
> +		default:
> +			return "unknown";
> +	}
> +}
>  
> -bool test_cachestat_shmem(void)
> +
> +bool run_cachestat_test(enum file_type type)
>  {
>  	size_t PS = sysconf(_SC_PAGESIZE);
>  	size_t filesize = PS * 512 * 2; /* 2 2MB huge pages */
> @@ -212,27 +228,49 @@ bool test_cachestat_shmem(void)
>  	char *filename = "tmpshmcstat";
>  	struct cachestat cs;
>  	bool ret = true;
> +	int fd;
>  	unsigned long num_pages = compute_len / PS;
> -	int fd = shm_open(filename, O_CREAT | O_RDWR, 0600);
> +	if (type == FILE_SHMEM)
> +		fd = shm_open(filename, O_CREAT | O_RDWR, 0600);
> +	else
> +		fd = open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
>  
>  	if (fd < 0) {
> -		ksft_print_msg("Unable to create shmem file.\n");
> +		ksft_print_msg("Unable to create %s file.\n",file_type_str(type));
>  		ret = false;
>  		goto out;
>  	}
>  
>  	if (ftruncate(fd, filesize)) {
> -		ksft_print_msg("Unable to truncate shmem file.\n");
> +		ksft_print_msg("Unable to truncate %s file.\n",file_type_str(type));
>  		ret = false;
>  		goto close_fd;
>  	}
> -
> -	if (!write_exactly(fd, filesize)) {
> -		ksft_print_msg("Unable to write to shmem file.\n");
> -		ret = false;
> -		goto close_fd;
> +	switch (type){
> +		case FILE_SHMEM:
> +			if (!write_exactly(fd, filesize)) {
> +				ksft_print_msg("Unable to write to file.\n");
> +				ret = false;
> +				goto close_fd;
> +			}
> +			break;
> +		case FILE_MMAP:
> +			char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +			if (map == MAP_FAILED) {
> +				ksft_print_msg("mmap failed.\n");
> +				ret = false;
> +				goto close_fd;
> +			}
> +			for (int i = 0; i < filesize; i++) {
> +				map[i] = 'A';
> +			}
> +			break;
> +		default:
> +			ksft_print_msg("Unsupported file type.\n");
> +			ret = false;
> +			goto close_fd;
> +			break;
>  	}
> -
>  	syscall_ret = syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
>  
>  	if (syscall_ret) {
> @@ -308,12 +346,18 @@ int main(void)
>  		break;
>  	}
>  
> -	if (test_cachestat_shmem())
> +	if (run_cachestat_test(FILE_SHMEM))
>  		ksft_test_result_pass("cachestat works with a shmem file\n");
>  	else {
>  		ksft_test_result_fail("cachestat fails with a shmem file\n");
>  		ret = 1;
>  	}
>  
> +	if (run_cachestat_test(FILE_MMAP))
> +		ksft_test_result_pass("cachestat works with a mmap file\n");
> +	else {
> +		ksft_test_result_fail("cachestat fails with a mmap file\n");
> +		ret = 1;
> +	}
>  	return ret;
>  }
> -- 
> 2.43.0

Sent using hkml (https://github.com/sjp38/hackermail)

