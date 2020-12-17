Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3135F2DD85C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 19:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbgLQSaf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 13:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbgLQSae (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 13:30:34 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583DEC0617B0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:29:54 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id r9so28474842ioo.7
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wtAaLc0Rs8lv5fpi3aTVIyZvijT8nFf8KPH6bgFjPWw=;
        b=UZo8WQlNVPkpgY0yLShRQLZ2O0HZJlIuhWldgN5ZXLqvdpH7LbNYo2MCLt0aTzZHOV
         rxdtiA6DQpvHIeg458SOcrINQW8f4pQDQBBN3Qhrt18uUiL8pyFqp3Wc+e90UbDw7+Az
         /5+fb30Enw7WSu+4syj4ZHBJzt2RTAD8StNLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wtAaLc0Rs8lv5fpi3aTVIyZvijT8nFf8KPH6bgFjPWw=;
        b=GkUAV71RzLEd/shttotK1SpoS8nE+1L5SBZjrJjAO2gHfeNKJcHtbotUljOeZEt1GO
         pyFvsKgZMOhgpyVv8B83TJVmwrTkCCRoSoZ7USAH3GvJIh7Zipf66jW9uNAIUQEbGd+3
         /HyyNf7383IfwOEoGhMnCK3DyxPqNfjgysD6842E6KfdY7tieRocaBEwB3UyLVXIHvlu
         BAztR2h83nqu6MQWBpoPfYcwWCBqDPqb/RVceSO6dVu6w8ElIcjCdV1lUaH5k38uPDXn
         w7p12k6fdfK9sB2VrB5ruG6aQVmDj4kLKxw9ncUesfGqQtatd6HdgPhrUnpyafcBH7Wl
         lQcQ==
X-Gm-Message-State: AOAM533+D6KxFTqxM314PbH6lSGtDjKUmvHPFCCQV6fB9hq26Rl73Wdi
        HMtzEaYX7BC6CO+LBBMn+hhXng==
X-Google-Smtp-Source: ABdhPJwH+GWNT5NwQG0SjigXW+AtkkUpC7FXi1H5sIXtEXpE86NKiILIxmILomV8+Hejqrz4a+4ttw==
X-Received: by 2002:a02:5148:: with SMTP id s69mr197146jaa.8.1608229793805;
        Thu, 17 Dec 2020 10:29:53 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e25sm14644210iom.40.2020.12.17.10.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 10:29:53 -0800 (PST)
Subject: Re: [PATCH] selftests/vDSO: fix -Wformat warning in
 vdso_test_correctness
To:     Tobias Klauser <tklauser@distanz.ch>, Shuah Khan <shuah@kernel.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201217163235.22788-1-tklauser@distanz.ch>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c3bb8366-f1ab-31bc-fd6c-7e7cbfeb72a1@linuxfoundation.org>
Date:   Thu, 17 Dec 2020 11:29:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201217163235.22788-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/17/20 9:32 AM, Tobias Klauser wrote:
> Fix the following -Wformat warnings in vdso_test_correctness.c:
> 
> vdso_test_correctness.c: In function ‘test_one_clock_gettime64’:
> vdso_test_correctness.c:352:21: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 3 has type ‘long long int’ [-Wformat=]
>    352 |  printf("\t%llu.%09ld %llu.%09ld %llu.%09ld\n",
>        |                 ~~~~^
>        |                     |
>        |                     long int
>        |                 %09lld
>    353 |         (unsigned long long)start.tv_sec, start.tv_nsec,
>        |                                           ~~~~~~~~~~~~~
>        |                                                |
>        |                                                long long int
> vdso_test_correctness.c:352:32: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 5 has type ‘long long int’ [-Wformat=]
>    352 |  printf("\t%llu.%09ld %llu.%09ld %llu.%09ld\n",
>        |                            ~~~~^
>        |                                |
>        |                                long int
>        |                            %09lld
>    353 |         (unsigned long long)start.tv_sec, start.tv_nsec,
>    354 |         (unsigned long long)vdso.tv_sec, vdso.tv_nsec,
>        |                                          ~~~~~~~~~~~~
>        |                                              |
>        |                                              long long int
> vdso_test_correctness.c:352:43: warning: format ‘%ld’ expects argument of type ‘long int’, but argument 7 has type ‘long long int’ [-Wformat=]
> 
> The tv_sec member of __kernel_timespec is long long, both in
> uapi/linux/time_types.h and locally in vdso_test_correctness.c.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>   tools/testing/selftests/vDSO/vdso_test_correctness.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
> index 5029ef9b228c..c4aea794725a 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
> @@ -349,7 +349,7 @@ static void test_one_clock_gettime64(int clock, const char *name)
>   		return;
>   	}
>   
> -	printf("\t%llu.%09ld %llu.%09ld %llu.%09ld\n",
> +	printf("\t%llu.%09lld %llu.%09lld %llu.%09lld\n",
>   	Thanks for the patch.

Thanks for the patch.

Applied to linux-kselftest next

thanks,
-- Shuah

