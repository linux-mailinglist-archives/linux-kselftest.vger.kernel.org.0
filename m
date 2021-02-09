Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361E0314480
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 01:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhBIAGk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 19:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhBIAGf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 19:06:35 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F458C06178A
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Feb 2021 16:05:54 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id y5so14532620ilg.4
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Feb 2021 16:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D+JW4r8pTJlLgsQxsftKbDGzE9cRSTF0BCzWfgQnJsY=;
        b=Sw/GSfb+67E3XTVBowZnNz8mfUQOg+op6Of9TkfDbcNN3dniq3usP+22A5adCO+9IU
         sfjAAe+XIrue1LfeWdDpAnS3y4ejnOIQNK02cOv4FMMLZ6g9JErka+dGrmcVQCqS0LC3
         mIqjupApGG6SRBj6mMKyRwENh+rgfosax00xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D+JW4r8pTJlLgsQxsftKbDGzE9cRSTF0BCzWfgQnJsY=;
        b=fW06AlHVUgG+N9L6fu/EHhsUx6p1Zd329SRJ6vwIMkAVj5yx4XRYVCGLKhVQgohSYb
         GGKXDfZrugDmU56GkNwLEZnlQKipkgB4X7EMlJR/xeUzSDImrmZK8MvGWglOvlcheziq
         eMB7HTOm6EMB+nGk2d+5EIGjKlKWbA0RniloIiQ683hO7mcX5BfBaUV4ahYX9rOg1l8S
         6AThi/Zh4tRMZq3e9vAGGIS11uvZSd5xSyQpebrqmjTV1Xy7eN4bmtXvfe3FYYWjf+zZ
         SDFjlhqE8zYrgrXVkrHakMyF3YMi96/w2duZDnAI5CbIediaTnUeIRrQC42BbdOQu1Tm
         TSmA==
X-Gm-Message-State: AOAM530F5vUmGexRg4zSDOTO5HFxhqrjoD605HxCPFDp0vs3zXjwqqig
        sC6dAp+s2WRQvY11/B0WyIUpFQ==
X-Google-Smtp-Source: ABdhPJz8srdN1yJB3EilIXwJ8vTEW9ame8knk491Ai8fNhZX+DUsEDNr01tKzX3e8mrocPrYyVPWJw==
X-Received: by 2002:a05:6e02:1c0f:: with SMTP id l15mr17563877ilh.21.1612829153582;
        Mon, 08 Feb 2021 16:05:53 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u17sm9769398ioc.23.2021.02.08.16.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 16:05:53 -0800 (PST)
Subject: Re: [PATCH] selftests: breakpoints: Use correct error messages in
 breakpoint_test_arm64.c
To:     Tiezhu Yang <yangtiezhu@loongson.cn>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1612506839-27225-1-git-send-email-yangtiezhu@loongson.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <db7c4310-503b-f84f-99a6-0d8d58da99b6@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 17:05:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1612506839-27225-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/4/21 11:33 PM, Tiezhu Yang wrote:
> When call ptrace(PTRACE_CONT, ...) failed, use correct error messages.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   tools/testing/selftests/breakpoints/breakpoint_test_arm64.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> index ad41ea6..e704181 100644
> --- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> +++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> @@ -145,7 +145,7 @@ static bool run_test(int wr_size, int wp_size, int wr, int wp)
>   
>   	if (ptrace(PTRACE_CONT, pid, NULL, NULL) < 0) {
>   		ksft_print_msg(
> -			"ptrace(PTRACE_SINGLESTEP) failed: %s\n",
> +			"ptrace(PTRACE_CONT) failed: %s\n",
>   			strerror(errno));
>   		return false;
>   	}
> @@ -159,7 +159,7 @@ static bool run_test(int wr_size, int wp_size, int wr, int wp)
>   	}
>   	alarm(0);
>   	if (WIFEXITED(status)) {
> -		ksft_print_msg("child did not single-step\n");
> +		ksft_print_msg("child exited prematurely\n");
>   		return false;
>   	}
>   	if (!WIFSTOPPED(status)) {
> 

Thank you. Applied to linux-kselftest next for 5.12-rc1

thanks,
-- Shuah
