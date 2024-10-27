Return-Path: <linux-kselftest+bounces-20764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B4F9B1B8A
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Oct 2024 02:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A12D1F21BF7
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Oct 2024 00:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AC44C83;
	Sun, 27 Oct 2024 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T/G6a9Tf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447991362
	for <linux-kselftest@vger.kernel.org>; Sun, 27 Oct 2024 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729988973; cv=none; b=SNQqtXD5Y7DzIyv3HXOQizQRbqUTf5O45H+RFRuttFFQGX166aENjyYHWyHG34En1YTs6XSkcEvACzvHXbVXmmZ0a7kPsNnBw9fi6iARxivttGsyWKzDfGeeZb4d9iXy0HCIkIGF12PIN+yQsmouGKryerS+hDxsLfmpcmuQXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729988973; c=relaxed/simple;
	bh=a2J+nNa1zs1AD4dHS1jmu/TnHxzKKXVyBrmGSj2ksE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qj75ZXQyCyLpG38oghnetzeYwu6461cS0YUY4UlYcPc9eP3IM7IPy/Zv8zTHOlkJGpqJUU4SmXMn6MF823TxgLEhRVmA0qTAZoNvIuUcgNFHMZy0ffNYiLiMYdM2KW8scc7qrWeKuvIEyCfe7ZaujZXf5LGsEiFH+h+SU+PahMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T/G6a9Tf; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b15d330ce1so260583385a.1
        for <linux-kselftest@vger.kernel.org>; Sat, 26 Oct 2024 17:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729988969; x=1730593769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nf7dY4XiUOsGpMj412qO4GMRiVERCsox/7G1qGLca9E=;
        b=T/G6a9TfgBZQ2MWxCj0AfhI5mJSSlFdNAGLSIzMUBaEgCV6osnoBDA2w4YwY+RV1SP
         UzmFq1QiowsgMMaKM0BnRkbv9Id73ILvZMf41LYYoOqfDp7z9FBxRtByyihyDLsa/sb9
         MZ7sB+jfc5icR4R7tXYsOZNC2yn9OOwzanWQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729988969; x=1730593769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nf7dY4XiUOsGpMj412qO4GMRiVERCsox/7G1qGLca9E=;
        b=gdxPm4pudekMa+BB0taJtkZc4RUlm5EFgK9aGrilQVRLtWZ7hEiI5DqKhAkCaNeBLH
         w2T7z5hhPaB3zRikAiCWXpVIjQVQR//9kNToeADP6AfGZbH0znL0/9/NQlG7fGfAqVGM
         bLrr0bDgTQtA7szw68M0LrBFjop1y6yefjFSlntId0KkthpeS62bbLZ89l8YEVlWv7xH
         7Fe94fvNjbROIgdUsHdDV+wrT6ckOHxTDv00FHsd1X+8AQkTL1G0pDU46P7stjq1YldP
         LoXy1lO4N0pjDicZyoEbljlAqbp3hzKQzYaGniDXqBheJmjz/d+7NPlkkfQl14y4ROaI
         yQFA==
X-Forwarded-Encrypted: i=1; AJvYcCWewTXp12rEufzJN4mzStsevJM+yXwl/m7sHJuTvMWxvupd3TWtMITXIbALAcqQBCit2L7dkLtcg81F1bsQq3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNoluEJkMEJckpywuRTLE8CfnZh4aq6xr+kUEnT00DxHHtUlxm
	k7uLE1MEl9SYY5ue7v2wALZN/ZeBv+mn0Yul7vO0uf7OWxB+Pdnxij9MZG9IYNQ=
X-Google-Smtp-Source: AGHT+IHN/knW5u9MOAU0WJWsokuS3LbChU0sTtWcinNJDCj2TQmt1WG+fI5gZJ3AS944joo6ITllZQ==
X-Received: by 2002:a05:620a:4511:b0:7b1:43d7:12a8 with SMTP id af79cd13be357-7b193ed1cd7mr789756085a.8.1729988969139;
        Sat, 26 Oct 2024 17:29:29 -0700 (PDT)
Received: from [172.19.248.149] ([205.220.129.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d334ae4sm192268485a.77.2024.10.26.17.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 17:29:28 -0700 (PDT)
Message-ID: <c2cae7a7-1a0d-48ef-9b8f-8d2436532ea7@linuxfoundation.org>
Date: Sat, 26 Oct 2024 18:28:56 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 1/3] selftests/watchdog: add count parameter for
 watchdog-test
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241025013933.6516-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241025013933.6516-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/24 19:39, Li Zhijian wrote:
> Currently, watchdog-test keep running until it gets a SIGINT. However,
> when watchdog-test is executed from the kselftests framework, where it
> launches test via timeout which will send SIGTERM in time up. This could
> lead to
> 1. watchdog haven't stop, a watchdog reset is triggered to reboot the OS
>     in silent.
> 2. kselftests gets an timeout exit code, and judge watchdog-test as
>    'not ok'
> 
This test isn't really supposed to be run from kselftest framework.
This is the reason why it isn't included in the default run.

> This patch is prepare to fix above 2 issues

This series needs a separate cover letter explaining how this problem is
being fixed.

> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Hey,
> Cover letter is here.
> 
> It's notice that a OS reboot was triggerred after ran the watchdog-test
> in kselftests framwork 'make run_tests', that's because watchdog-test
> didn't stop feeding the watchdog after enable it.
> 
> In addition, current watchdog-test didn't adapt to the kselftests
> framework which launchs the test with /usr/bin/timeout and no timeout
> is expected.
> ---
>   tools/testing/selftests/watchdog/watchdog-test.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index bc71cbca0dde..2f8fd2670897 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -27,7 +27,7 @@
>   
>   int fd;
>   const char v = 'V';
> -static const char sopts[] = "bdehp:st:Tn:NLf:i";
> +static const char sopts[] = "bdehp:st:Tn:NLf:c:i";
>   static const struct option lopts[] = {
>   	{"bootstatus",          no_argument, NULL, 'b'},
>   	{"disable",             no_argument, NULL, 'd'},
> @@ -42,6 +42,7 @@ static const struct option lopts[] = {
>   	{"gettimeleft",		no_argument, NULL, 'L'},
>   	{"file",          required_argument, NULL, 'f'},
>   	{"info",		no_argument, NULL, 'i'},
> +	{"count",         required_argument, NULL, 'c'},
>   	{NULL,                  no_argument, NULL, 0x0}
>   };
>   
> @@ -95,6 +96,7 @@ static void usage(char *progname)
>   	printf(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
>   	printf(" -N, --getpretimeout\tGet the pretimeout\n");
>   	printf(" -L, --gettimeleft\tGet the time left until timer expires\n");
> +	printf(" -c, --count\tStop after feeding the watchdog count times\n");
>   	printf("\n");
>   	printf("Parameters are parsed left-to-right in real-time.\n");
>   	printf("Example: %s -d -t 10 -p 5 -e\n", progname);
> @@ -174,7 +176,7 @@ int main(int argc, char *argv[])
>   	unsigned int ping_rate = DEFAULT_PING_RATE;
>   	int ret;
>   	int c;
> -	int oneshot = 0;
> +	int oneshot = 0, stop = 1, count = 0;
>   	char *file = "/dev/watchdog";
>   	struct watchdog_info info;
>   	int temperature;
> @@ -307,6 +309,9 @@ int main(int argc, char *argv[])
>   			else
>   				printf("WDIOC_GETTIMELEFT error '%s'\n", strerror(errno));
>   			break;
> +		case 'c':
> +			stop = 0;
> +			count = strtoul(optarg, NULL, 0);
>   		case 'f':
>   			/* Handled above */
>   			break;
> @@ -336,8 +341,8 @@ int main(int argc, char *argv[])
>   
>   	signal(SIGINT, term);
>   
> -	while (1) {
> -		keep_alive();
> +	while (stop || count--) {
> +		exit_code = keep_alive();
>   		sleep(ping_rate);
>   	}
>   end:


