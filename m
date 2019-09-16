Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA912B3F1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 18:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbfIPQk2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 12:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbfIPQk2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 12:40:28 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E5FD214D9;
        Mon, 16 Sep 2019 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568652027;
        bh=nAd7VWDdh6f8BChag+MS/I8GI49oB6sxV0473vFpljo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=avjDOL511fCSVE5gWNJexazlOhs/NWuc/7zVIta8BrPBFbm2E+9MDOQtAN0FPjZuJ
         6cBfHv1btdr6Zaqo3ZHfcDs7AyE6RH82ZJOEYlevb2TRG7HMPWX3ybPY5sGg840BFJ
         SWGxTzkhaAmxtUIr0fs8YsiA76Q31Ilvm2vPe7hg=
Subject: Re: [PATCH 3/6] selftests/clone3: use uint64_t for flags parameter
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>, shuah <shuah@kernel.org>
References: <cover.1568116761.git.esyr@redhat.com>
 <3f7bd9f0446360f90f12b9e9d3af1de2f5133a81.1568116761.git.esyr@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <1b15fe21-76d9-a858-08a8-02e19afc6b11@kernel.org>
Date:   Mon, 16 Sep 2019 10:40:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3f7bd9f0446360f90f12b9e9d3af1de2f5133a81.1568116761.git.esyr@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/10/19 6:03 AM, Eugene Syromiatnikov wrote:
> Flags parameter in both userspace and kernel clone args is 64-bit wide,
> there's little reason to have it signed and 32-bit in tests.
> 

So what are doing? You are stating the problem here, how are you
fixing it?

> * tools/testing/selftests/clone3/clone3.c: Include <inttypes.h> and
> <stdint.h>.
> (call_clone3): Change flags parameter type from int to uint64_t.
> (test_clone3): Change flags parameter type from int to uint64_t; change
> the format string that prints it accordingly.
> 

I am not going to say this again. Please don't include pseudo code in
the commit log.

> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
>   tools/testing/selftests/clone3/clone3.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> index 4f23a0c..1746a9b 100644
> --- a/tools/testing/selftests/clone3/clone3.c
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -4,8 +4,10 @@
>   
>   #define _GNU_SOURCE
>   #include <errno.h>
> +#include <inttypes.h>
>   #include <linux/types.h>
>   #include <linux/sched.h>
> +#include <stdint.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <sys/syscall.h>
> @@ -36,7 +38,7 @@ static pid_t raw_clone(struct clone_args *args, size_t size)
>   	return syscall(__NR_clone3, args, size);
>   }
>   
> -static int call_clone3(int flags, size_t size, enum test_mode test_mode)
> +static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
>   {
>   	struct clone_args args = {0};
>   	pid_t ppid = -1;
> @@ -102,12 +104,13 @@ static int call_clone3(int flags, size_t size, enum test_mode test_mode)
>   	return 0;
>   }
>   
> -static int test_clone3(int flags, size_t size, int expected,
> +static int test_clone3(uint64_t flags, size_t size, int expected,
>   		       enum test_mode test_mode)
>   {
>   	int ret;
>   
> -	ksft_print_msg("[%d] Trying clone3() with flags 0x%x (size %d)\n",
> +	ksft_print_msg("[%d] Trying clone3() with flags %#" PRIx64 " (size %d)"
> +			"\n",
>   			getpid(), flags, size);
>   	ret = call_clone3(flags, size, test_mode);
>   	ksft_print_msg("[%d] clone3() with flags says :%d expected %d\n",
> 

thanks,
-- Shuah
