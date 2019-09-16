Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D00EB3EF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfIPQ25 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 12:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729041AbfIPQ25 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 12:28:57 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68D852184D;
        Mon, 16 Sep 2019 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568651336;
        bh=qaxG10o/mGSdB6gZBOwkHnO16O1InQHAiGeEVEnCMts=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EfRFkKp8yuNwomtvZws4mD4InYmyt/0wiDi/1ckG8Gzr8fm9ayv78k/cOml213Ja5
         vd7qVsMbMEXgf8TpG532NIlK/K8MvUJBHrlzel4Rs859pGRvHkKGAbynM9FPF3N7MV
         Ur/JG6f7wlbCOP1bP0RHRm4c+tzukiw0iC4EjonY=
Subject: Re: [PATCH 1/6] selftests/clone3: convert test modes into an enum
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>, shuah <shuah@kernel.org>
References: <cover.1568116761.git.esyr@redhat.com>
 <96cf2b235f525321a562e9727b3fa0b05675efe8.1568116761.git.esyr@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <65383c0a-90d5-ed79-284d-1c084933d860@kernel.org>
Date:   Mon, 16 Sep 2019 10:28:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <96cf2b235f525321a562e9727b3fa0b05675efe8.1568116761.git.esyr@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/10/19 6:03 AM, Eugene Syromiatnikov wrote:
> * tools/testing/selftests/clone3/clone3.c (CLONE3_ARGS_NO_TEST,
> CLONE3_ARGS_ALL_0, CLONE3_ARGS_ALL_1): Change into an enum.
> (call_clone3): Change test_mode parameter type to enum test_mode;
> use switch statement for actions that dependent on test_mode selection.
> (test_clone3): Change test_mode parameter type to enum test_mode.
> 

You don't need the file name in the commit log. Please describe what
you are fixing/doing in the commit. Describing the actual code changes
doesn't help.

Including why these changes are needed as opposed the actual changes
will be helpful. I think I know why, I would like you to tell me why.

> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
>   tools/testing/selftests/clone3/clone3.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> index a0f1989..7b65ee5 100644
> --- a/tools/testing/selftests/clone3/clone3.c
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -24,16 +24,18 @@
>   /* V1 includes set_tid */
>   #define CLONE3_ARGS_SIZE_V1 72
>   
> -#define CLONE3_ARGS_NO_TEST 0
> -#define CLONE3_ARGS_ALL_0 1
> -#define CLONE3_ARGS_ALL_1 2
> +enum test_mode {
> +	CLONE3_ARGS_NO_TEST,
> +	CLONE3_ARGS_ALL_0,
> +	CLONE3_ARGS_ALL_1,
> +};
>   
>   static pid_t raw_clone(struct clone_args *args, size_t size)
>   {
>   	return syscall(__NR_clone3, args, size);
>   }
>   
> -static int call_clone3(int flags, size_t size, int test_mode)
> +static int call_clone3(int flags, size_t size, enum test_mode test_mode)
>   {
>   	struct clone_args args = {0};
>   	pid_t ppid = -1;
> @@ -46,7 +48,8 @@ static int call_clone3(int flags, size_t size, int test_mode)
>   	if (size == 0)
>   		size = sizeof(struct clone_args);
>   
> -	if (test_mode == CLONE3_ARGS_ALL_0) {
> +	switch (test_mode) {
> +	case CLONE3_ARGS_ALL_0:
>   		args.flags = 0;
>   		args.pidfd = 0;
>   		args.child_tid = 0;
> @@ -56,7 +59,9 @@ static int call_clone3(int flags, size_t size, int test_mode)
>   		args. stack_size = 0;
>   		args.tls = 0;
>   		args.set_tid = 0;
> -	} else if (test_mode == CLONE3_ARGS_ALL_1) {
> +		break;
> +
> +	case CLONE3_ARGS_ALL_1:
>   		args.flags = 1;
>   		args.pidfd = 1;
>   		args.child_tid = 1;
> @@ -66,6 +71,7 @@ static int call_clone3(int flags, size_t size, int test_mode)
>   		args. stack_size = 1;
>   		args.tls = 1;
>   		args.set_tid = 1;
> +		break;
>   	}
>   
>   	pid = raw_clone(&args, size);
> @@ -91,7 +97,8 @@ static int call_clone3(int flags, size_t size, int test_mode)
>   	return 0;
>   }
>   
> -static int test_clone3(int flags, size_t size, int expected, int test_mode)
> +static int test_clone3(int flags, size_t size, int expected,
> +		       enum test_mode test_mode)
>   {
>   	int ret;
>   
> 

thanks,
-- Shuah
