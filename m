Return-Path: <linux-kselftest+bounces-12878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B80B91AF4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 20:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3ED1C22466
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 18:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E90F3A8D1;
	Thu, 27 Jun 2024 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="egTH2n1F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9577484
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Jun 2024 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719514113; cv=none; b=QKLyGq7MvFz+yqQ3aArX8c592AzZE0NlW1m/h3fQSWF2GFwLnJ7scc0WQbvg7vTJ0kjmoaOr+gfZJfk8OKuhYIhJBuBE6KrpoY7CHOH9JAMNsRHU6CBhSNi0jtclrNLcdlXgN7na+nZRbArNLjNXvidjpykiRc98pbTjOt0EluY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719514113; c=relaxed/simple;
	bh=Ps21LGDi7ixqkIHatAKXL0KCeKFRlwvVz2dx/nKAiQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/D3I6spoioJ8xPGT1eKMpGOekq1rIa05Grto04usddTkBZYoBMiqOsfE2tf5x9FtTrPizt+3ARw+i0MhwkF58fyOeDn95bukIsYcPNrDOAl4y6RX6x1LqE/DjmixJP+zcHB3xOwktii/b8Gi27YZwg7bJ68o8dDbYpqcXTBSVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=egTH2n1F; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7f3d2f12d26so7303339f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jun 2024 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719514110; x=1720118910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/k1qLy1qLFza2dxpYxxzrSbgR45GguPq4RoinXUVzS4=;
        b=egTH2n1FYRG1Uwq9rIK85CBUEom7ad5XjwqkTuqc7KxuU3phlDdzZGUbEYcEKczqVs
         3ZBOZNLPHo08+OCc8G9ZHZH/bXM10MQTOuiU/5Hs+mKxMg/jnu6Jjv07EidHY8/76qC+
         nI2Z9xMMWhpP/UgeAyt8rwff1tl+TaqSTb0g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719514110; x=1720118910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/k1qLy1qLFza2dxpYxxzrSbgR45GguPq4RoinXUVzS4=;
        b=kH2pusQdVIBOQf0C+a5xQuZObjU1QeSrk39JCLjWwLYST6BnMZqcm6DoImCSPjSrRp
         nbwdCfDoHvQrAZz3pBgGhAdBuZvK2rGID5KVQ8hSltJY501hN1fiLKXdq/C0ArNAWaoi
         yif50gJ0HrpWZgdP1Bvzj1JsaCrV7+n5MoN6n8ybTFomDKGz5HZFVSKz2VR8QJKIwwkh
         O1zo+njtAXRR6M6dNeirPTLTlo62V0YxHBKUJsghvcJEz6mM5I1Ovuz36FUwtUk1voFD
         U4wsq/tBY1SzrhKyZW232KbY/1ySnGJi0bFBW5t4kTDQ9C5t0nCXLrqnaCt2KiDSkbjx
         ZKhw==
X-Forwarded-Encrypted: i=1; AJvYcCXmIcv/Sfk1Ro9AKXFXL5l7qeSM8L+mqwBbW0d0GXpHBj4emCbAEuk9/d/uhridpst30mtAkU1OE/tE5Ac0E3RqYX7QF3JN8kAuHpJeuHjo
X-Gm-Message-State: AOJu0Yy6tGSNvzBsMD3EST/2XhZx6naVBHY4YD5WaobcLuCn5+WWZakI
	+OEQLcx4Gzp2e4hLi4UTcXlacIrRAjIk6wpyjcf9lOK/zEv6SWaMJDhM99XRjd8=
X-Google-Smtp-Source: AGHT+IEXG1NlFSUMjyKzcvcn1MBWxw1iTxL8TaTCUpow4wkmryMvMpGJvH2Mf5GCIPBykhEecXGduA==
X-Received: by 2002:a5d:984e:0:b0:7f3:9dd3:15bf with SMTP id ca18e2360f4ac-7f39dd317famr1358316739f.0.1719514109876;
        Thu, 27 Jun 2024 11:48:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742bc2d8sm62323173.144.2024.06.27.11.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 11:48:29 -0700 (PDT)
Message-ID: <818d06c2-c5d6-4559-a8c9-9bf9e21c30f6@linuxfoundation.org>
Date: Thu, 27 Jun 2024 12:48:28 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/watchdog: limit ping loop and allow
 configuring the number of pings
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240506111359.224579-1-laura.nao@collabora.com>
 <20240506111359.224579-2-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240506111359.224579-2-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/24 05:13, Laura Nao wrote:
> In order to run the watchdog selftest with the kselftest runner, the
> loop responsible for pinging the watchdog should be finite. This
> change limits the loop to 5 iterations by default and introduces a new
> '-c' option to adjust the number of pings as needed.

This patch makes the test run finite in all cases changing the bevavior
to run it forever?
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   tools/testing/selftests/watchdog/watchdog-test.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index bc71cbca0dde..786cc5a26206 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -24,16 +24,18 @@
>   #include <linux/watchdog.h>
>   
>   #define DEFAULT_PING_RATE	1
> +#define DEFAULT_PING_COUNT	5
>   
>   int fd;
>   const char v = 'V';
> -static const char sopts[] = "bdehp:st:Tn:NLf:i";
> +static const char sopts[] = "bdehp:c:st:Tn:NLf:i";
>   static const struct option lopts[] = {
>   	{"bootstatus",          no_argument, NULL, 'b'},
>   	{"disable",             no_argument, NULL, 'd'},
>   	{"enable",              no_argument, NULL, 'e'},
>   	{"help",                no_argument, NULL, 'h'},
>   	{"pingrate",      required_argument, NULL, 'p'},
> +	{"pingcount",     required_argument, NULL, 'c'},
>   	{"status",              no_argument, NULL, 's'},
>   	{"timeout",       required_argument, NULL, 't'},
>   	{"gettimeout",          no_argument, NULL, 'T'},
> @@ -90,6 +92,8 @@ static void usage(char *progname)
>   	printf(" -h, --help\t\tPrint the help message\n");
>   	printf(" -p, --pingrate=P\tSet ping rate to P seconds (default %d)\n",
>   	       DEFAULT_PING_RATE);
> +	printf(" -c, --pingcount=C\tSet number of pings to C (default %d)\n",
> +	       DEFAULT_PING_COUNT);
>   	printf(" -t, --timeout=T\tSet timeout to T seconds\n");
>   	printf(" -T, --gettimeout\tGet the timeout\n");
>   	printf(" -n, --pretimeout=T\tSet the pretimeout to T seconds\n");
> @@ -172,6 +176,7 @@ int main(int argc, char *argv[])
>   {
>   	int flags;
>   	unsigned int ping_rate = DEFAULT_PING_RATE;
> +	unsigned int ping_count = DEFAULT_PING_COUNT;
>   	int ret;
>   	int c;
>   	int oneshot = 0;
> @@ -248,6 +253,12 @@ int main(int argc, char *argv[])
>   				ping_rate = DEFAULT_PING_RATE;
>   			printf("Watchdog ping rate set to %u seconds.\n", ping_rate);
>   			break;
> +		case 'c':
> +			ping_count = strtoul(optarg, NULL, 0);
> +			if (!ping_count)
> +				ping_count = DEFAULT_PING_COUNT;
> +			printf("Number of pings set to %u.\n", ping_count);
> +			break;
>   		case 's':
>   			flags = 0;
>   			oneshot = 1;
> @@ -336,9 +347,10 @@ int main(int argc, char *argv[])
>   
>   	signal(SIGINT, term);
>   
> -	while (1) {
> +	while (ping_count > 0) {
>   		keep_alive();
>   		sleep(ping_rate);
> +		ping_count--;

So this test no longer runs forever?

thanks,
-- Shuah



