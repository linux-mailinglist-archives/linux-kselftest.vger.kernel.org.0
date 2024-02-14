Return-Path: <linux-kselftest+bounces-4666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9CB854FE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 18:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7402290673
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0906783A1A;
	Wed, 14 Feb 2024 17:19:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9549B8662D;
	Wed, 14 Feb 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931172; cv=none; b=M8QYFruQKWEofvJoVcQabUrcPEAFS1n7c3Rx2bk4i3AFbx007RbCoKkJi6IZxw0a7iEtiXI6kN682OkxNzbe0/QAeinSBfCOFv3NVYlr5xrFMpbxkpnPY6daYBMPqXN13f/moGFjTiO/zYS+IK5XnHL9aaBNpFLd6jdP2n6Havk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931172; c=relaxed/simple;
	bh=1Ufz1L53OWf7h8/HiX4mayVIa34dEKUVMvnJozBg2w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqkiHXc1AFjzuJrYE5d7LpqxBUlQwl8Xc6i6SvKYGNlk+mEbA6hMcPqVdRMPROeLH9yzafxBP2IYF1cocgYrX8IXRSnBAWgcawMBAjwVwSeHeVsyH36MTnTzQNQt07YBGBAitilrluMKH+G0UHIg/GKN4qA0LUBvbUlgAXeX5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B77B31FB;
	Wed, 14 Feb 2024 09:20:09 -0800 (PST)
Received: from [10.57.64.120] (unknown [10.57.64.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83F643F766;
	Wed, 14 Feb 2024 09:19:27 -0800 (PST)
Message-ID: <0c3182ae-885c-4156-980b-e35d825fe72e@arm.com>
Date: Wed, 14 Feb 2024 17:19:25 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] selftests/mm: thp_settings: conform to TAP
 format output
Content-Language: en-GB
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aishwarya TCV <Aishwarya.TCV@arm.com>
References: <20240202113119.2047740-1-usama.anjum@collabora.com>
 <20240202113119.2047740-10-usama.anjum@collabora.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240202113119.2047740-10-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2024 11:31, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/mm/khugepaged.c   |   3 +-
>  tools/testing/selftests/mm/thp_settings.c | 123 ++++++++--------------
>  tools/testing/selftests/mm/thp_settings.h |   4 +-
>  3 files changed, 47 insertions(+), 83 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> index d51fdaee7dc6a..3f202da0867c5 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -152,8 +152,7 @@ static void get_finfo(const char *dir)
>  		     major(path_stat.st_dev), minor(path_stat.st_dev)) >= sizeof(path))
>  		ksft_exit_fail_msg("%s: Pathname is too long\n", __func__);
>  
> -	if (read_file(path, buf, sizeof(buf)) < 0)
> -		ksft_exit_fail_msg("read_file(read_num): %s\n", strerror(errno));
> +	read_file(path, buf, sizeof(buf));
>  
>  	if (strstr(buf, "DEVTYPE=disk")) {
>  		/* Found it */
> diff --git a/tools/testing/selftests/mm/thp_settings.c b/tools/testing/selftests/mm/thp_settings.c
> index a4163438108ec..273a95d025285 100644
> --- a/tools/testing/selftests/mm/thp_settings.c
> +++ b/tools/testing/selftests/mm/thp_settings.c
> @@ -5,7 +5,9 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include <errno.h>
>  
> +#include "../kselftest.h"
>  #include "thp_settings.h"
>  
>  #define THP_SYSFS "/sys/kernel/mm/transparent_hugepage/"
> @@ -42,58 +44,45 @@ static const char * const shmem_enabled_strings[] = {
>  	NULL
>  };
>  
> -int read_file(const char *path, char *buf, size_t buflen)
> +void read_file(const char *path, char *buf, size_t buflen)
>  {
>  	int fd;
>  	ssize_t numread;
>  
>  	fd = open(path, O_RDONLY);
>  	if (fd == -1)
> -		return 0;
> +		ksft_exit_fail_msg("%s open failed: %s\n", path, strerror(errno));

Hi,

This change has broken back compat. It's no longer possible to run cow and
khugepaged tests against older kernels.

This function, as well as others in this file are intended to return 0 to
indicate the file could not be accessed (e.g. doesn't exist or don't have
permission, etc). Then higher level code can decide how to handle that. For
example, thp_supported_orders() determines which THP orders are supported by the
system based on the existence of certain files in sysfs. Then cow decides which
test variants to run based on the supported orders. With your change, it all
goes bang on the first probe and the whole test suite gets failed without
running any tests.

I've no problem with improving the TAP output from tests, but this must only be
done at the test level, where it makes sense to do so. You can just call
ksft_exit_fail_msg() from deep within a utility function.

Please can we remove this from mm-unstable.

Thanks,
Ryan


>  
>  	numread = read(fd, buf, buflen - 1);
>  	if (numread < 1) {
>  		close(fd);
> -		return 0;
> +		ksft_exit_fail_msg("No data read\n");
>  	}
>  
>  	buf[numread] = '\0';
>  	close(fd);
> -
> -	return (unsigned int) numread;
>  }
>  
> -int write_file(const char *path, const char *buf, size_t buflen)
> +void write_file(const char *path, const char *buf, size_t buflen)
>  {
>  	int fd;
>  	ssize_t numwritten;
>  
>  	fd = open(path, O_WRONLY);
> -	if (fd == -1) {
> -		printf("open(%s)\n", path);
> -		exit(EXIT_FAILURE);
> -		return 0;
> -	}
> +	if (fd == -1)
> +		ksft_exit_fail_msg("%s open failed\n", path);
>  
>  	numwritten = write(fd, buf, buflen - 1);
>  	close(fd);
> -	if (numwritten < 1) {
> -		printf("write(%s)\n", buf);
> -		exit(EXIT_FAILURE);
> -		return 0;
> -	}
> -
> -	return (unsigned int) numwritten;
> +	if (numwritten < 1)
> +		ksft_exit_fail_msg("write failed (%s)\n", buf);
>  }
>  
>  const unsigned long read_num(const char *path)
>  {
>  	char buf[21];
>  
> -	if (read_file(path, buf, sizeof(buf)) < 0) {
> -		perror("read_file()");
> -		exit(EXIT_FAILURE);
> -	}
> +	read_file(path, buf, sizeof(buf));
>  
>  	return strtoul(buf, NULL, 10);
>  }
> @@ -103,10 +92,7 @@ void write_num(const char *path, unsigned long num)
>  	char buf[21];
>  
>  	sprintf(buf, "%ld", num);
> -	if (!write_file(path, buf, strlen(buf) + 1)) {
> -		perror(path);
> -		exit(EXIT_FAILURE);
> -	}
> +	write_file(path, buf, strlen(buf) + 1);
>  }
>  
>  int thp_read_string(const char *name, const char * const strings[])
> @@ -117,30 +103,22 @@ int thp_read_string(const char *name, const char * const strings[])
>  	int ret;
>  
>  	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
> -	if (ret >= PATH_MAX) {
> -		printf("%s: Pathname is too long\n", __func__);
> -		exit(EXIT_FAILURE);
> -	}
> +	if (ret >= PATH_MAX)
> +		ksft_exit_fail_msg("%s: Pathname is too long\n", __func__);
>  
> -	if (!read_file(path, buf, sizeof(buf))) {
> -		perror(path);
> -		exit(EXIT_FAILURE);
> -	}
> +	read_file(path, buf, sizeof(buf));
>  
>  	c = strchr(buf, '[');
> -	if (!c) {
> -		printf("%s: Parse failure\n", __func__);
> -		exit(EXIT_FAILURE);
> -	}
> +	if (!c)
> +		ksft_exit_fail_msg("%s: Parse failure\n", __func__);
>  
>  	c++;
>  	memmove(buf, c, sizeof(buf) - (c - buf));
>  
>  	c = strchr(buf, ']');
> -	if (!c) {
> -		printf("%s: Parse failure\n", __func__);
> -		exit(EXIT_FAILURE);
> -	}
> +	if (!c)
> +		ksft_exit_fail_msg("%s: Parse failure\n", __func__);
> +
>  	*c = '\0';
>  
>  	ret = 0;
> @@ -150,8 +128,8 @@ int thp_read_string(const char *name, const char * const strings[])
>  		ret++;
>  	}
>  
> -	printf("Failed to parse %s\n", name);
> -	exit(EXIT_FAILURE);
> +	ksft_exit_fail_msg("Failed to parse %s\n", name);
> +	return -1;
>  }
>  
>  void thp_write_string(const char *name, const char *val)
> @@ -160,15 +138,10 @@ void thp_write_string(const char *name, const char *val)
>  	int ret;
>  
>  	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
> -	if (ret >= PATH_MAX) {
> -		printf("%s: Pathname is too long\n", __func__);
> -		exit(EXIT_FAILURE);
> -	}
> +	if (ret >= PATH_MAX)
> +		ksft_exit_fail_msg("%s: Pathname is too long\n", __func__);
>  
> -	if (!write_file(path, val, strlen(val) + 1)) {
> -		perror(path);
> -		exit(EXIT_FAILURE);
> -	}
> +	write_file(path, val, strlen(val) + 1);
>  }
>  
>  const unsigned long thp_read_num(const char *name)
> @@ -177,10 +150,9 @@ const unsigned long thp_read_num(const char *name)
>  	int ret;
>  
>  	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
> -	if (ret >= PATH_MAX) {
> -		printf("%s: Pathname is too long\n", __func__);
> -		exit(EXIT_FAILURE);
> -	}
> +	if (ret >= PATH_MAX)
> +		ksft_exit_fail_msg("%s: Pathname is too long\n", __func__);
> +
>  	return read_num(path);
>  }
>  
> @@ -190,10 +162,9 @@ void thp_write_num(const char *name, unsigned long num)
>  	int ret;
>  
>  	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
> -	if (ret >= PATH_MAX) {
> -		printf("%s: Pathname is too long\n", __func__);
> -		exit(EXIT_FAILURE);
> -	}
> +	if (ret >= PATH_MAX)
> +		ksft_exit_fail_msg("%s: Pathname is too long\n", __func__);
> +
>  	write_num(path, num);
>  }
>  
> @@ -275,29 +246,26 @@ void thp_write_settings(struct thp_settings *settings)
>  
>  struct thp_settings *thp_current_settings(void)
>  {
> -	if (!settings_index) {
> -		printf("Fail: No settings set");
> -		exit(EXIT_FAILURE);
> -	}
> +	if (!settings_index)
> +		ksft_exit_fail_msg("Fail: No settings set\n");
> +
>  	return settings_stack + settings_index - 1;
>  }
>  
>  void thp_push_settings(struct thp_settings *settings)
>  {
> -	if (settings_index >= MAX_SETTINGS_DEPTH) {
> -		printf("Fail: Settings stack exceeded");
> -		exit(EXIT_FAILURE);
> -	}
> +	if (settings_index >= MAX_SETTINGS_DEPTH)
> +		ksft_exit_fail_msg("Fail: Settings stack exceeded\n");
> +
>  	settings_stack[settings_index++] = *settings;
>  	thp_write_settings(thp_current_settings());
>  }
>  
>  void thp_pop_settings(void)
>  {
> -	if (settings_index <= 0) {
> -		printf("Fail: Settings stack empty");
> -		exit(EXIT_FAILURE);
> -	}
> +	if (settings_index <= 0)
> +		ksft_exit_fail_msg("Fail: Settings stack empty\n");
> +
>  	--settings_index;
>  	thp_write_settings(thp_current_settings());
>  }
> @@ -335,14 +303,11 @@ unsigned long thp_supported_orders(void)
>  	for (i = 0; i < NR_ORDERS; i++) {
>  		ret = snprintf(path, PATH_MAX, THP_SYSFS "hugepages-%ukB/enabled",
>  			(getpagesize() >> 10) << i);
> -		if (ret >= PATH_MAX) {
> -			printf("%s: Pathname is too long\n", __func__);
> -			exit(EXIT_FAILURE);
> -		}
> +		if (ret >= PATH_MAX)
> +			ksft_exit_fail_msg("%s: Pathname is too long\n", __func__);
>  
> -		ret = read_file(path, buf, sizeof(buf));
> -		if (ret)
> -			orders |= 1UL << i;
> +		read_file(path, buf, sizeof(buf));
> +		orders |= 1UL << i;
>  	}
>  
>  	return orders;
> diff --git a/tools/testing/selftests/mm/thp_settings.h b/tools/testing/selftests/mm/thp_settings.h
> index 71cbff05f4c7f..04a6a7bbd08f8 100644
> --- a/tools/testing/selftests/mm/thp_settings.h
> +++ b/tools/testing/selftests/mm/thp_settings.h
> @@ -56,8 +56,8 @@ struct thp_settings {
>  	struct hugepages_settings hugepages[NR_ORDERS];
>  };
>  
> -int read_file(const char *path, char *buf, size_t buflen);
> -int write_file(const char *path, const char *buf, size_t buflen);
> +void read_file(const char *path, char *buf, size_t buflen);
> +void write_file(const char *path, const char *buf, size_t buflen);
>  const unsigned long read_num(const char *path);
>  void write_num(const char *path, unsigned long num);
>  


