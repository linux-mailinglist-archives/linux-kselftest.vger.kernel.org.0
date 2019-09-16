Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1C1B3B41
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 15:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbfIPNZX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 09:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbfIPNZX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 09:25:23 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E38B214D9;
        Mon, 16 Sep 2019 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568640322;
        bh=JQdrtnmyKg2DjT5CLoYa3+kCDakSs39kT0Pa7rv8YAY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Kya6U2nziL0KBsVYCrRT5pIoqQUuitGr+giC8DkexN5FVcktxHmIUHsBfD87wjzVd
         V2quVZpQCriHWKgDsWXDkhDWrP6KdbLIN3THYSWQGaRqZUWTT2TY8MgOrio6hYQuud
         ryFgUz0UybroQX8ILL0ckZ28d7JZbtp8AVv1wEyc=
Subject: Re: [PATCH 1/2] selftests: watchdog: Validate optional file argument
To:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>, shuah <shuah@kernel.org>
References: <20190907085833.21167-1-erosca@de.adit-jv.com>
From:   shuah <shuah@kernel.org>
Message-ID: <ed9db2a8-194f-3d42-7339-b66970f68552@kernel.org>
Date:   Mon, 16 Sep 2019 07:25:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190907085833.21167-1-erosca@de.adit-jv.com>
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
> As reported by Eugeniu Rosca, the newly added optional file
> argument does not validate if the file is indeed a watchdog, e.g.:
> 
> ./watchdog-test  -f /dev/zero
> Watchdog Ticking Away!
> 
> Fix it by confirming that the WDIOC_GETSUPPORT ioctl succeeds.
> 
> Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Signed-off-by: George G. Davis <george_davis@mentor.com>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> ---
> v1: Applied/tested on commit ce54eab71e210f ("kunit: fix failure to build without printk") of
>      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next
> 
>   tools/testing/selftests/watchdog/watchdog-test.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index afff120c7be6..6ed822dc2222 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -97,6 +97,7 @@ int main(int argc, char *argv[])
>   	int c;
>   	int oneshot = 0;
>   	char *file = "/dev/watchdog";
> +	struct watchdog_info info;
>   
>   	setbuf(stdout, NULL);
>   
> @@ -118,6 +119,16 @@ int main(int argc, char *argv[])
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
> 

Thanks for catching this. I will pull this in for second update for
5.4-rc1.

thanks,
-- Shuah
