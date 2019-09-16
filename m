Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAEBB3B45
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 15:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfIPN0n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 09:26:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbfIPN0n (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 09:26:43 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F8E1214D9;
        Mon, 16 Sep 2019 13:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568640402;
        bh=PSoteR+A5iVobJBEbU2oCtmwDpUDfIPpl+dEg7efaNk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F2qB8mhHC9oveVa98WTPDsXSywvnScm7yBOOwHD1tTVXsB9XSelvAqr3TELVJjPlq
         IFYumRIEXRshZlThYThpjNnFU2P5uUEi340nxSmBeh0hOznTCtdwmygdYbocXAsiNC
         7ThAeIR3psg6GbJrx0ZvZKqasO9bW+IQZAD8tunU=
Subject: Re: [PATCH 2/2] selftests: watchdog: Add command line option to show
 watchdog_info
To:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>, shuah <shuah@kernel.org>
References: <20190907085833.21167-1-erosca@de.adit-jv.com>
 <20190907085833.21167-2-erosca@de.adit-jv.com>
From:   shuah <shuah@kernel.org>
Message-ID: <2b08fa83-185b-4eb7-1217-37ed31d810b5@kernel.org>
Date:   Mon, 16 Sep 2019 07:26:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190907085833.21167-2-erosca@de.adit-jv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/7/19 2:58 AM, Eugeniu Rosca wrote:
> From: "George G. Davis" <george_davis@mentor.com>
> 
> A side of affect of commit "selftests: watchdog: Add optional file
> argument" is that arbitrary files may be opened for watchdog testing, e.g.
> /dev/null. To prevent watchdog-test from operating on non-watchdog device
> files, commit "selftests: watchdog: Validate optional file argument" was
> added to validate that a file is indeed a watchdog device via an
> ioctl(WDIOC_GETSUPPORT) call. Since the watchdog_info is available as a
> result of the ioctl(WDIOC_GETSUPPORT) call, add a command line option to
> show the watchdog_info.
> 
> Suggested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Signed-off-by: George G. Davis <george_davis@mentor.com>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> ---
> v1: Applied/tested on commit ce54eab71e210f ("kunit: fix failure to build without printk") of
>      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next
> 
>   tools/testing/selftests/watchdog/watchdog-test.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index 6ed822dc2222..f45e510500c0 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -19,7 +19,7 @@
>   
>   int fd;
>   const char v = 'V';
> -static const char sopts[] = "bdehp:t:Tn:NLf:";
> +static const char sopts[] = "bdehp:t:Tn:NLf:i";
>   static const struct option lopts[] = {
>   	{"bootstatus",          no_argument, NULL, 'b'},
>   	{"disable",             no_argument, NULL, 'd'},
> @@ -32,6 +32,7 @@ static const struct option lopts[] = {
>   	{"getpretimeout",       no_argument, NULL, 'N'},
>   	{"gettimeleft",		no_argument, NULL, 'L'},
>   	{"file",          required_argument, NULL, 'f'},
> +	{"info",		no_argument, NULL, 'i'},
>   	{NULL,                  no_argument, NULL, 0x0}
>   };
>   
> @@ -72,6 +73,7 @@ static void usage(char *progname)
>   	printf("Usage: %s [options]\n", progname);
>   	printf(" -f, --file\t\tOpen watchdog device file\n");
>   	printf("\t\t\tDefault is /dev/watchdog\n");
> +	printf(" -i, --info\t\tShow watchdog_info\n");
>   	printf(" -b, --bootstatus\tGet last boot status (Watchdog/POR)\n");
>   	printf(" -d, --disable\t\tTurn off the watchdog timer\n");
>   	printf(" -e, --enable\t\tTurn on the watchdog timer\n");
> @@ -216,6 +218,18 @@ int main(int argc, char *argv[])
>   		case 'f':
>   			/* Handled above */
>   			break;
> +		case 'i':
> +			/*
> +			 * watchdog_info was obtained as part of file open
> +			 * validation. So we just show it here.
> +			 */
> +			oneshot = 1;
> +			printf("watchdog_info:\n");
> +			printf(" identity:\t\t%s\n", info.identity);
> +			printf(" firmware_version:\t%u\n",
> +			       info.firmware_version);
> +			printf(" options:\t\t%08x\n", info.options);
> +			break;
>   
>   		default:
>   			usage(argv[0]);
> 

I would like to see these combined. Please don't add another argument.
Combine patch and 1&2.

thanks,
-- Shuah
