Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBF4BB3F15
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 18:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbfIPQhR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 12:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbfIPQhR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 12:37:17 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB7D214D9;
        Mon, 16 Sep 2019 16:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568651836;
        bh=A4EC8rYENbB35cqZcR/Jp9eGTrxiDPiBK2ZwBJAd0RY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nLwejD44HX8XnRRvatCXwqkeSGcj194yx1ey+33mBRNN06oqL6nsQKBEU0X2O/atx
         O++fLg6U1iwj8GQX4TKp30wMsOewvjUXl56CK1RtBAnwUUsPWWfFcGKSy0TRrDJXlv
         E3Y9C9vI91BlxtXgO27qsR+fIwFGZDDb7GhstvIg=
Subject: Re: [PATCH 2/6] selftests/clone3: add a check for invalid exit_signal
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>, shuah <shuah@kernel.org>
References: <cover.1568116761.git.esyr@redhat.com>
 <f5c715164c87a226afca711559e7ed72a70426a4.1568116761.git.esyr@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <f93052b9-9520-c53a-27dd-b096d3336576@kernel.org>
Date:   Mon, 16 Sep 2019 10:37:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f5c715164c87a226afca711559e7ed72a70426a4.1568116761.git.esyr@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/10/19 6:03 AM, Eugene Syromiatnikov wrote:
> Check that the kernel fails calls with exit_signal with non-zero highest
> 32 bits.
> 

Describe what you are testing:

"Add a test case for clone3() non-zero highest 32 bits behavior. It
should fail with exit_signal value??"

Add checks for unsupported cases. Handle unsupported architectures
and configurations with skip

> * tools/testing/selftests/clone3/clone3.c (enum test_mode): Add
> CLONE3_ARGS_BIG_EXIT_SIGNAL.
> (call_clone3): Add args.exit_signal initialisation in case
> test_mode == CLONE3_ARGS_BIG_EXIT_SIGNAL.
> (main): Add test_clone3 clone check with
> test_mode == CLONE3_ARGS_BIG_EXIT_SIGNAL.

Please don't include pseudo code in the commit log.

> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
>   tools/testing/selftests/clone3/clone3.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> index 7b65ee5..4f23a0c 100644
> --- a/tools/testing/selftests/clone3/clone3.c
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -28,6 +28,7 @@ enum test_mode {
>   	CLONE3_ARGS_NO_TEST,
>   	CLONE3_ARGS_ALL_0,
>   	CLONE3_ARGS_ALL_1,
> +	CLONE3_ARGS_BIG_EXIT_SIGNAL,
>   };
>   
>   static pid_t raw_clone(struct clone_args *args, size_t size)
> @@ -72,6 +73,10 @@ static int call_clone3(int flags, size_t size, enum test_mode test_mode)
>   		args.tls = 1;
>   		args.set_tid = 1;
>   		break;
> +
> +	case CLONE3_ARGS_BIG_EXIT_SIGNAL:
> +		args.exit_signal = 0xbadc0ded00000000;

Please add a comment to indicate what this is. I am assuming
this bad sig val.

> +		break;
>   	}
>   
>   	pid = raw_clone(&args, size);
> @@ -146,6 +151,10 @@ int main(int argc, char *argv[])
>   	/* Do a clone3() with all members set to 1 */
>   	if (test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL, CLONE3_ARGS_ALL_1))
>   		goto on_error;
> +	/* Do a clone3() with exit_signal having highest 32 bits non-zero */
> +	if (test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL,
> +			CLONE3_ARGS_BIG_EXIT_SIGNAL))
> +		goto on_error;
>   	/*
>   	 * Do a clone3() with sizeof(struct clone_args) + 8
>   	 * and all members set to 0.
> 

thanks,
-- Shuah
