Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 376AFB4531
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2019 03:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391015AbfIQBTi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 21:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbfIQBTi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 21:19:38 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BDF420665;
        Tue, 17 Sep 2019 01:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568683177;
        bh=KRgkAyk8458l3DgVsWVloeG6qEEHG36sjtqN0HPTo+Y=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=hsle6yJHAeuWqyx/qTyMsQrltMjE1csbSaSpRBhS8jmxP2HaMgvot/CDgcnujAyNS
         TchCXgVeealApAXcy55Dg06Sxtz1j1HJcvHaZiNSjuiiRYnZoAk94MfHF2O6PZvkbT
         w4krIs5Bx+5XFp46lVrD+l7EOw5pmzN4G6rfpuaM=
Subject: Re: [PATCH v2] selftests: watchdog: Validate optional file argument
To:     "George G. Davis" <george_davis@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <1568659751-1845-1-git-send-email-george_davis@mentor.com>
From:   shuah <shuah@kernel.org>
Message-ID: <fa008fd8-f867-b80e-84ed-148e1630c09e@kernel.org>
Date:   Mon, 16 Sep 2019 19:19:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568659751-1845-1-git-send-email-george_davis@mentor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/16/19 12:49 PM, George G. Davis wrote:
> As reported by Eugeniu Rosca, a side of affect of commit c3f2490d6e92
> ("selftests: watchdog: Add optional file argument") is that arbitrary files
> may be opened for watchdog testing, e.g.
> 

You don't need to say this here since you are already have a
Reported-by tag. You are missing the Fixes tag.
> ./watchdog-test  -f /dev/zero
> Watchdog Ticking Away!
> 
> To prevent watchdog-test from operating on non-watchdog device files,
> validate that a file is indeed a watchdog device via an
> ioctl(WDIOC_GETSUPPORT) call.
> 
> While we're at it, since the watchdog_info is available as a result of the
> ioctl(WDIOC_GETSUPPORT) call, add a command line option to optionally show
> the watchdog_info.
> 

Let's try this again. I want two patches. The first one with Fixes tag.
The first patch might be candidate for going into stables.

The -i (info) should be a separate patch. This won't go into stables.

Please write a clear commit log. The following will help:

https://chris.beams.io/posts/git-commit/

> Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Signed-off-by: George G. Davis <george_davis@mentor.com>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> ---
> v1: Applied/tested on commit ce54eab71e210f ("kunit: fix failure to build without printk") of
>      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next
> v2: Squashed [1] and [2], and update commit description as discussed in [3].
>      [1] https://patchwork.kernel.org/patch/11136283/
>      [2] https://patchwork.kernel.org/patch/11136285/
>      [3] https://patchwork.kernel.org/patch/11136285/#22883573
> ---
>   tools/testing/selftests/watchdog/watchdog-test.c | 27 +++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index afff120c7be6..f45e510500c0 100644
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
> @@ -97,6 +99,7 @@ int main(int argc, char *argv[])
>   	int c;
>   	int oneshot = 0;
>   	char *file = "/dev/watchdog";
> +	struct watchdog_info info;
>   
>   	setbuf(stdout, NULL);
>   
> @@ -118,6 +121,16 @@ int main(int argc, char *argv[])
>   		exit(-1);
>   	}
>   
> +	/*
> +	 * Validate that `file` is a watchdog device
> +	 */
> +	ret = ioctl(fd, WDIOC_GETSUPPORT, &info);
> +	if (ret) {
> +		printf("WDIOC_GETSUPPORT error '%s'\n", strerror(errno));
> +		close(fd);
> +		exit(ret);
> +	}
> +
>   	optind = 0;
>   
>   	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
> @@ -205,6 +218,18 @@ int main(int argc, char *argv[])
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

thanks,
-- Shuah
