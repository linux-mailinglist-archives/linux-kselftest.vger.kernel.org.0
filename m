Return-Path: <linux-kselftest+bounces-22882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505379E5E4F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 19:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A291884F63
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 18:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2450B22B8BE;
	Thu,  5 Dec 2024 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X5P1CY3b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD6822B8AC
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Dec 2024 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733423650; cv=none; b=S3RuHSIXfQW5eNckqOL+AZfp1xOPiQhscyEckJSzttsXTr9g/dW9JlP7Ejt/O4Ebi1LdgD/jbNKYYEtGfz8qb7KLfWHhbdXfWRrFkPIZBHZbxUp39BoE8qDWYVdq9D9uzByMdGk1mzywcRtSfS/ZLaXcuBv54gpqZMAk6zS0Qog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733423650; c=relaxed/simple;
	bh=IXzlaBQe97F+Bdqoprf1gPs0loxIOHg7JHiYsAd3NJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6Oq8reSou7d4SCs56m+qyFXKAmuQlIsSWuP+p4C/9P+nRXJO2dJzVsV3dEPOQo+dIs93F9ulg+YXCt24iKNUo6Nc0xIZt3DuZRr9wJURrgFcnDnAHm5+Gdl1qV/Bbj+Vq3pJjFAQv+tkM8MO47Dpfx0GBhpTBHqxnEQeqdmwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X5P1CY3b; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a7d94b545aso8515475ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Dec 2024 10:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733423647; x=1734028447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Upb4esJS2+wFNflFJ+JPeOwO7afQtmckq5cgoKrMeS0=;
        b=X5P1CY3bpl1uFiRsWfwh8kuuPZviVenYRkutH8I/BYSgJUDbcu+fF55Eg2IDL5Os23
         MyeB1zEnP4MjQ179+EIUtVyq8anpV7A+C5YzftPKA/SPFAazcV/NfJpWHVJPKtL2uZDe
         LBc8j9E8FvpS6ivLPDLuPd2Sb4EYPPAhMSRGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733423647; x=1734028447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Upb4esJS2+wFNflFJ+JPeOwO7afQtmckq5cgoKrMeS0=;
        b=VPYRVqn4clPvDe0PzmsumNeR4Rtl5oSAEP2nslbBpvBiewhvMFVat4u27LFHLKZ56s
         wo2P5Ce/j4UqO77Mckdcv++PtZKX2tCG7QI6hEVo213ZqGspyvo8Nnumrxbf9imsYvtY
         uwXtYCYMZ4cnTi63ZvPd0pdS8v65CuMgjB+eEi80J33PdsfRfqHiDMQMfYIIdkOiNCvs
         5Ohm/4fPkGKv3RPTsuWni6nqF6Ai2FR7h6rpmdGW5/lDpr0zRRzqvO418lMrMXahEWAn
         1zKjleJqZ+OelPgWriUfDqpjylFVgwr0OnN1TgIomqrWMMdUgMYzudEY39KDgFP1QeDE
         V7ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWizolM33reRaGJkvc4IeJlW4rW0oE/VlFA5IE+dKV4aUUK/NaJpwjYaEVBOuTj2p916brbU7ijh33yXguJUrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTtvfTQii3sfitFQeT632Wdfi491k1pLIfQw0tojAGB+5DRmZv
	cybllszRDaRbs7WNVplrJB3GsW7sPWBRFa1ePbpPLyusdjWgkLJccGV3iwaz1dk=
X-Gm-Gg: ASbGnctkdcdyUjcOflJCfNAhX7CcLL7y6I4qHYtdxDEuIOCiXMUgx8pxEc607VCoeAr
	G3Ndo1iiOMzak67QNAxTnapuNHKEOh7gnriOliZDMw6a+BGIcNIPwcJQtte5cZJvbWVaUuydvfO
	uG0Pq7p4zWHIGhl21TXyTdrDPweVBy8J9GYZk7VKuEtd78ChuGY5KMO0/KiHsKtSlZcUGjbqfbG
	kV6SuhkgZaGusJ7KvsnOwlzJbzqF3m5l4Lr9SWcpMYS80tMqV8Z+jU9qGMkRw==
X-Google-Smtp-Source: AGHT+IE9MooVUrylwIO6y6P22Aei7p0W543XeP4nE5gzZToL776nPy7yFYppd3ejiO6GuYddX4TWvg==
X-Received: by 2002:a05:6e02:1c89:b0:3a7:8c3f:edce with SMTP id e9e14a558f8ab-3a811d73260mr6187045ab.3.1733423646569;
        Thu, 05 Dec 2024 10:34:06 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e28611e13fsm414453173.59.2024.12.05.10.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 10:34:06 -0800 (PST)
Message-ID: <d336a4bf-795a-4d57-832c-6cf8a011c312@linuxfoundation.org>
Date: Thu, 5 Dec 2024 11:34:05 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests/watchdog: convert the test output to
 KTAP format
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241119150127.152830-1-laura.nao@collabora.com>
 <20241119150127.152830-3-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241119150127.152830-3-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/24 08:01, Laura Nao wrote:
> Conform the test output to the KTAP format standard. The number of tests
> executed is determined by the script arguments, and options such as
> -c, -f, -h, -i, and -p do not impact the total test count.

Didn't I review this patche before and say I don't see value
in converting the output to ktap.

This conevts all messages including usage to ktap which isn';t
necessary. It also introduces skips for oneshot cases which is
miesleading - if user asks for oneshot, there is not value in
marking the test skipped.

I am not going to take this patch.

> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   .../selftests/watchdog/watchdog-test.c        | 158 ++++++++++--------
>   1 file changed, 92 insertions(+), 66 deletions(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index 58c25015d5e7..4781736070e3 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -22,12 +22,15 @@
>   #include <sys/ioctl.h>
>   #include <linux/types.h>
>   #include <linux/watchdog.h>
> +#include "../kselftest.h"
>   
>   #define DEFAULT_PING_RATE	1
>   
>   int fd;
> +int keep_alive_res;
>   const char v = 'V';
>   static const char sopts[] = "bdehp:c:st:Tn:NLf:i";
> +static const char topts[] = "bdeLn:Nst:T";
>   static const struct option lopts[] = {
>   	{"bootstatus",          no_argument, NULL, 'b'},
>   	{"disable",             no_argument, NULL, 'd'},
> @@ -51,7 +54,7 @@ static const struct option lopts[] = {
>    * the PC Watchdog card to reset its internal timer so it doesn't trigger
>    * a computer reset.
>    */
> -static void keep_alive(void)
> +static int keep_alive(void)
>   {
>   	int dummy;
>   	int ret;
> @@ -59,6 +62,8 @@ static void keep_alive(void)
>   	ret = ioctl(fd, WDIOC_KEEPALIVE, &dummy);
>   	if (!ret)
>   		printf(".");
> +
> +	return ret;
>   }
>   
>   /*
> @@ -72,35 +77,36 @@ static void term(int sig)
>   
>   	close(fd);
>   	if (ret < 0)
> -		printf("\nStopping watchdog ticks failed (%d)...\n", errno);
> +		ksft_print_msg("\nStopping watchdog ticks failed (%d)...\n", errno);
>   	else
> -		printf("\nStopping watchdog ticks...\n");
> -	exit(0);
> +		ksft_print_msg("\nStopping watchdog ticks...\n");
> +	ksft_test_result(!keep_alive_res, "WDIOC_KEEPALIVE\n");
> +	ksft_finished();
>   }
>   
>   static void usage(char *progname)
>   {
> -	printf("Usage: %s [options]\n", progname);
> -	printf(" -f, --file\t\tOpen watchdog device file\n");
> -	printf("\t\t\tDefault is /dev/watchdog\n");
> -	printf(" -i, --info\t\tShow watchdog_info\n");
> -	printf(" -s, --status\t\tGet status & supported features\n");
> -	printf(" -b, --bootstatus\tGet last boot status (Watchdog/POR)\n");
> -	printf(" -d, --disable\t\tTurn off the watchdog timer\n");
> -	printf(" -e, --enable\t\tTurn on the watchdog timer\n");
> -	printf(" -h, --help\t\tPrint the help message\n");
> -	printf(" -p, --pingrate=P\tSet ping rate to P seconds (default %d)\n",
> +	ksft_print_msg("Usage: %s [options]\n", progname);
> +	ksft_print_msg(" -f, --file\t\tOpen watchdog device file\n");
> +	ksft_print_msg("\t\t\tDefault is /dev/watchdog\n");
> +	ksft_print_msg(" -i, --info\t\tShow watchdog_info\n");
> +	ksft_print_msg(" -s, --status\t\tGet status & supported features\n");
> +	ksft_print_msg(" -b, --bootstatus\tGet last boot status (Watchdog/POR)\n");
> +	ksft_print_msg(" -d, --disable\t\tTurn off the watchdog timer\n");
> +	ksft_print_msg(" -e, --enable\t\tTurn on the watchdog timer\n");
> +	ksft_print_msg(" -h, --help\t\tPrint the help message\n");
> +	ksft_print_msg(" -p, --pingrate=P\tSet ping rate to P seconds (default %d)\n",
>   	       DEFAULT_PING_RATE);
> -	printf(" -c, --pingcount=C\tLimit the number of pings to C (default infinite)\n");
> -	printf(" -t, --timeout=T\tSet timeout to T seconds\n");
> -	printf(" -T, --gettimeout\tGet the timeout\n");
> -	printf(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
> -	printf(" -N, --getpretimeout\tGet the pretimeout\n");
> -	printf(" -L, --gettimeleft\tGet the time left until timer expires\n");
> -	printf("\n");
> -	printf("Parameters are parsed left-to-right in real-time.\n");
> -	printf("Example: %s -d -t 10 -p 5 -e\n", progname);
> -	printf("Example: %s -t 12 -T -n 7 -N\n", progname);
> +	ksft_print_msg(" -c, --pingcount=C\tSet number of pings to C (default infinite)\n");
> +	ksft_print_msg(" -t, --timeout=T\tSet timeout to T seconds\n");
> +	ksft_print_msg(" -T, --gettimeout\tGet the timeout\n");
> +	ksft_print_msg(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
> +	ksft_print_msg(" -N, --getpretimeout\tGet the pretimeout\n");
> +	ksft_print_msg(" -L, --gettimeleft\tGet the time left until timer expires\n");
> +	ksft_print_msg("\n");
> +	ksft_print_msg("Parameters are parsed left-to-right in real-time.\n");
> +	ksft_print_msg("Example: %s -d -t 10 -p 5 -e\n", progname);
> +	ksft_print_msg("Example: %s -t 12 -T -n 7 -N\n", progname);
>   }
>   

No - we don't need ksft_ outout for usage.

>   struct wdiof_status {
> @@ -126,13 +132,13 @@ static void print_status(int flags)
>   	int wdiof = 0;
>   
>   	if (flags == WDIOS_UNKNOWN) {
> -		printf("Unknown status error from WDIOC_GETSTATUS\n");
> +		ksft_print_msg("Unknown status error from WDIOC_GETSTATUS\n");
>   		return;
>   	}
>   
>   	for (wdiof = 0; wdiof < WDIOF_NUM_STATUS; wdiof++) {
>   		if (flags & wdiof_status[wdiof].flag)
> -			printf("Support/Status: %s\n",
> +			ksft_print_msg("Support/Status: %s\n",
>   				wdiof_status[wdiof].status_str);
>   	}
>   }
> @@ -154,18 +160,18 @@ static void print_boot_status(int flags)
>   	int wdiof = 0;
>   
>   	if (flags == WDIOF_UNKNOWN) {
> -		printf("Unknown flag error from WDIOC_GETBOOTSTATUS\n");
> +		ksft_print_msg("Unknown flag error from WDIOC_GETBOOTSTATUS\n");
>   		return;
>   	}
>   
>   	if (flags == 0) {
> -		printf("Last boot is caused by: Power-On-Reset\n");
> +		ksft_print_msg("Last boot is caused by: Power-On-Reset\n");
>   		return;
>   	}
>   
>   	for (wdiof = 0; wdiof < WDIOF_NUM_BOOTSTATUS; wdiof++) {
>   		if (flags & wdiof_bootstatus[wdiof].flag)
> -			printf("Last boot is caused by: %s\n",
> +			ksft_print_msg("Last boot is caused by: %s\n",
>   				wdiof_bootstatus[wdiof].status_str);
>   	}
>   }
> @@ -181,25 +187,28 @@ int main(int argc, char *argv[])
>   	char *file = "/dev/watchdog";
>   	struct watchdog_info info;
>   	int temperature;
> +	/* run WDIOC_KEEPALIVE test by default */
> +	int test_num = 1;
>   
>   	setbuf(stdout, NULL);
>   
>   	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
>   		if (c == 'f')
>   			file = optarg;
> +
> +		if (strchr(topts, c))
> +			test_num++;
>   	}
>   
>   	fd = open(file, O_WRONLY);
>   
>   	if (fd == -1) {
>   		if (errno == ENOENT)
> -			printf("Watchdog device (%s) not found.\n", file);
> +			ksft_exit_skip("Watchdog device (%s) not found.\n", file);
>   		else if (errno == EACCES)
> -			printf("Run watchdog as root.\n");
> +			ksft_exit_skip("Run watchdog as root.\n");
>   		else
> -			printf("Watchdog device open failed %s\n",
> -				strerror(errno));
> -		exit(-1);
> +			ksft_exit_skip("Watchdog device open failed %s\n", strerror(errno));
>   	}
>   
>   	/*
> @@ -207,13 +216,15 @@ int main(int argc, char *argv[])
>   	 */
>   	ret = ioctl(fd, WDIOC_GETSUPPORT, &info);
>   	if (ret) {
> -		printf("WDIOC_GETSUPPORT error '%s'\n", strerror(errno));
>   		close(fd);
> -		exit(ret);
> +		ksft_exit_skip("WDIOC_GETSUPPORT error '%s'\n", strerror(errno));
>   	}
>   
>   	optind = 0;
>   
> +	ksft_print_header();
> +	ksft_set_plan(test_num);
> +
>   	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
>   		switch (c) {
>   		case 'b':
> @@ -223,39 +234,42 @@ int main(int argc, char *argv[])
>   			if (!ret)
>   				print_boot_status(flags);
>   			else
> -				printf("WDIOC_GETBOOTSTATUS error '%s'\n", strerror(errno));
> +				ksft_perror("WDIOC_GETBOOTSTATUS error");
> +			ksft_test_result(!ret, "WDIOC_GETBOOTSTATUS\n");
>   			break;
>   		case 'd':
>   			flags = WDIOS_DISABLECARD;
>   			ret = ioctl(fd, WDIOC_SETOPTIONS, &flags);
>   			if (!ret)
> -				printf("Watchdog card disabled.\n");
> +				ksft_print_msg("Watchdog card disabled.\n");
>   			else {
> -				printf("WDIOS_DISABLECARD error '%s'\n", strerror(errno));
> +				ksft_perror("WDIOS_DISABLECARD error");
>   				oneshot = 1;
>   			}
> +			ksft_test_result(!ret, "WDIOC_SETOPTIONS_WDIOS_DISABLECARD\n");
>   			break;
>   		case 'e':
>   			flags = WDIOS_ENABLECARD;
>   			ret = ioctl(fd, WDIOC_SETOPTIONS, &flags);
>   			if (!ret)
> -				printf("Watchdog card enabled.\n");
> +				ksft_print_msg("Watchdog card enabled.\n");
>   			else {
> -				printf("WDIOS_ENABLECARD error '%s'\n", strerror(errno));
> +				ksft_perror("WDIOS_ENABLECARD error");
>   				oneshot = 1;
>   			}
> +			ksft_test_result(!ret, "WDIOC_SETOPTIONS_WDIOS_ENABLECARD\n");
>   			break;
>   		case 'p':
>   			ping_rate = strtoul(optarg, NULL, 0);
>   			if (!ping_rate)
>   				ping_rate = DEFAULT_PING_RATE;
> -			printf("Watchdog ping rate set to %u seconds.\n", ping_rate);
> +			ksft_print_msg("Watchdog ping rate set to %u seconds.\n", ping_rate);
>   			break;
>   		case 'c':
>   			ping_count = strtoul(optarg, NULL, 0);
>   			if (!ping_count)
>   				oneshot = 1;
> -			printf("Number of pings set to %u.\n", ping_count);
> +			ksft_print_msg("Number of pings set to %u.\n", ping_count);
>   			break;
>   		case 's':
>   			flags = 0;
> @@ -264,57 +278,62 @@ int main(int argc, char *argv[])
>   			if (!ret)
>   				print_status(flags);
>   			else
> -				printf("WDIOC_GETSTATUS error '%s'\n", strerror(errno));
> +				ksft_perror("WDIOC_GETSTATUS error");
> +			ksft_test_result(!ret, "WDIOC_GETSTATUS\n");
>   			ret = ioctl(fd, WDIOC_GETTEMP, &temperature);
>   			if (ret)
> -				printf("WDIOC_GETTEMP: '%s'\n", strerror(errno));
> +				ksft_perror("WDIOC_GETTEMP");
>   			else
> -				printf("Temperature %d\n", temperature);
> -
> +				ksft_print_msg("Temperature %d\n", temperature);
>   			break;
>   		case 't':
>   			flags = strtoul(optarg, NULL, 0);
>   			ret = ioctl(fd, WDIOC_SETTIMEOUT, &flags);
>   			if (!ret)
> -				printf("Watchdog timeout set to %u seconds.\n", flags);
> +				ksft_print_msg("Watchdog timeout set to %u seconds.\n", flags);
>   			else {
> -				printf("WDIOC_SETTIMEOUT error '%s'\n", strerror(errno));
> +				ksft_perror("WDIOC_SETTIMEOUT error");
>   				oneshot = 1;
>   			}
> +			ksft_test_result(!ret, "WDIOC_SETTIMEOUT\n");
>   			break;
>   		case 'T':
>   			oneshot = 1;
>   			ret = ioctl(fd, WDIOC_GETTIMEOUT, &flags);
>   			if (!ret)
> -				printf("WDIOC_GETTIMEOUT returns %u seconds.\n", flags);
> +				ksft_print_msg("WDIOC_GETTIMEOUT returns %u seconds.\n", flags);
>   			else
> -				printf("WDIOC_GETTIMEOUT error '%s'\n", strerror(errno));
> +				ksft_perror("WDIOC_GETTIMEOUT error");
> +			ksft_test_result(!ret, "WDIOC_GETTIMEOUT\n");
>   			break;
>   		case 'n':
>   			flags = strtoul(optarg, NULL, 0);
>   			ret = ioctl(fd, WDIOC_SETPRETIMEOUT, &flags);
>   			if (!ret)
> -				printf("Watchdog pretimeout set to %u seconds.\n", flags);
> +				ksft_print_msg("Watchdog pretimeout set to %u seconds.\n", flags);
>   			else {
> -				printf("WDIOC_SETPRETIMEOUT error '%s'\n", strerror(errno));
> +				ksft_perror("WDIOC_SETPRETIMEOUT error");
>   				oneshot = 1;
>   			}
> +			ksft_test_result(!ret, "WDIOC_SETPRETIMEOUT\n");
>   			break;
>   		case 'N':
>   			oneshot = 1;
>   			ret = ioctl(fd, WDIOC_GETPRETIMEOUT, &flags);
>   			if (!ret)
> -				printf("WDIOC_GETPRETIMEOUT returns %u seconds.\n", flags);
> +				ksft_print_msg("WDIOC_GETPRETIMEOUT returns %u seconds.\n", flags);
>   			else
> -				printf("WDIOC_GETPRETIMEOUT error '%s'\n", strerror(errno));
> +				ksft_perror("WDIOC_GETPRETIMEOUT error");
> +			ksft_test_result(!ret, "WDIOC_GETPRETIMEOUT\n");
>   			break;
>   		case 'L':
>   			oneshot = 1;
>   			ret = ioctl(fd, WDIOC_GETTIMELEFT, &flags);
>   			if (!ret)
> -				printf("WDIOC_GETTIMELEFT returns %u seconds.\n", flags);
> +				ksft_print_msg("WDIOC_GETTIMELEFT returns %u seconds.\n", flags);
>   			else
> -				printf("WDIOC_GETTIMELEFT error '%s'\n", strerror(errno));
> +				ksft_perror("WDIOC_GETTIMELEFT error");
> +			ksft_test_result(!ret, "WDIOC_GETTIMELEFT\n");
>   			break;
>   		case 'f':
>   			/* Handled above */
> @@ -325,32 +344,39 @@ int main(int argc, char *argv[])
>   			 * validation. So we just show it here.
>   			 */
>   			oneshot = 1;
> -			printf("watchdog_info:\n");
> -			printf(" identity:\t\t%s\n", info.identity);
> -			printf(" firmware_version:\t%u\n",
> -			       info.firmware_version);
> +			ksft_print_msg("watchdog_info:\n");
> +			ksft_print_msg(" identity:\t\t%s\n", info.identity);
> +			ksft_print_msg(" firmware_version:\t%u\n", info.firmware_version);
>   			print_status(info.options);
>   			break;
>   
>   		default:
>   			usage(argv[0]);
> +			ksft_test_result_skip("WDIOC_KEEPALIVE\n");
>   			goto end;
>   		}
>   	}
>   
> -	if (oneshot)
> +	if (oneshot) {
> +		ksft_test_result_skip("WDIOC_KEEPALIVE\n");

Why skip here - user asked for oneshot. This doesn't look right.
>   		goto end;
> +	}
>   
> -	printf("Watchdog Ticking Away!\n");
> +	ksft_print_msg("Watchdog Ticking Away!\n");
> +	ksft_print_msg("");
>   
>   	signal(SIGINT, term);
>   
>   	while (ping_count != 0) {
> -		keep_alive();
> +		if (keep_alive())
> +			keep_alive_res = -1;
> +
>   		sleep(ping_rate);
>   		if (ping_count > 0)
>   			ping_count--;
>   	}
> +	printf("\n");
> +	ksft_test_result(!keep_alive_res, "WDIOC_KEEPALIVE\n");
>   end:
>   	/*
>   	 * Send specific magic character 'V' just in case Magic Close is
> @@ -358,7 +384,7 @@ int main(int argc, char *argv[])
>   	 */
>   	ret = write(fd, &v, 1);
>   	if (ret < 0)
> -		printf("Stopping watchdog ticks failed (%d)...\n", errno);
> +		ksft_print_msg("Stopping watchdog ticks failed (%d)...\n", errno);
>   	close(fd);
> -	return 0;
> +	ksft_finished();
>   }

thanks,
-- Shuah

