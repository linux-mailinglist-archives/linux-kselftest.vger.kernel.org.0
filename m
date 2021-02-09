Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC7B3144B3
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 01:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhBIAOB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 19:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhBIANz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 19:13:55 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD8DC061788
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Feb 2021 16:13:15 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u20so16967060iot.9
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Feb 2021 16:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fe+y9pZY3NRHqBpGSHuyrgHsj4ZHTbVB5p2fxahRQWk=;
        b=Q6DaEqx4A+iBVy7YRMlaUyyXnb+L45lTvR1BvL+b4ESejICeM/vwlwo4HuII997S0M
         X6BYdHwWYISSV4mLTarvF0jBVCg1JcuUb45eQPTsZ5rX5lhiOF4gJSZlntZfIfAkDJFx
         s+veA3H9159YWwlkCqjs1s2DW5yvFMcdL1+0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fe+y9pZY3NRHqBpGSHuyrgHsj4ZHTbVB5p2fxahRQWk=;
        b=Zra+us2nwmcPTr+loBp9qnltDTIXYL2LUHFjbWmXM/0f8X6jopD5xoeF1NcKQodsiF
         8lLYOItCu3lOFrK/GxW/bMrnoBAt/ImC15MJyN0MqgMEApALa3yHvRmSwCZKsCq6bmjL
         BX8KhC2RNtvewhMIod9M7yrn/BohZ0wDHcSi7nfSsM1LBf5oPz+wb26xkt5JwuKT46B0
         je1z3p0s9WJF4qR9o725GjPehCPOmPYkTEAr6X5CMQTVL4sPX69spQjuWrBfb7mEFu2f
         VzH2+mgtFOP4xkbYYqufqHaEizezvf9ajsp25iCB3Py2Xwk4dhAoUgc+Uix2uBC4gRUN
         MYFw==
X-Gm-Message-State: AOAM5324xclDws40M0PYPWXLRGZ0FDY6FA59nZ/kSxNtARnufoJ1JXLX
        /KU/vYfU/o3i8vC76iaWwRodQQ==
X-Google-Smtp-Source: ABdhPJwUrZMKcMXsTpO7CvtbHQefSTAqW5Gye4EmU10Oo/d/85AWx/zdCuVC1ggD7yLwc9AcF9FFog==
X-Received: by 2002:a5d:9717:: with SMTP id h23mr17219731iol.4.1612829594800;
        Mon, 08 Feb 2021 16:13:14 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l7sm9655945ilq.26.2021.02.08.16.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 16:13:14 -0800 (PST)
Subject: Re: [PATCH] selftests/seccomp: Accept any valid fd in
 user_notification_addfd
To:     Seth Forshee <seth.forshee@canonical.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210128161721.99150-1-seth.forshee@canonical.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ff36fb27-5b6c-cecb-7661-fab83fdbf66a@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 17:13:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210128161721.99150-1-seth.forshee@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/28/21 9:17 AM, Seth Forshee wrote:
> This test expects fds to have specific values, which works fine
> when the test is run standalone. However, the kselftest runner
> consumes a couple of extra fds for redirection when running
> tests, so the test fails when run via kselftest.
> 
> Change the test to pass on any valid fd number.
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> ---
>   tools/testing/selftests/seccomp/seccomp_bpf.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 26c72f2b61b1..9338df6f4ca8 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -4019,18 +4019,14 @@ TEST(user_notification_addfd)
>   
>   	/* Verify we can set an arbitrary remote fd */
>   	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
> -	/*
> -	 * The child has fds 0(stdin), 1(stdout), 2(stderr), 3(memfd),
> -	 * 4(listener), so the newly allocated fd should be 5.
> -	 */
> -	EXPECT_EQ(fd, 5);
> +	EXPECT_GE(fd, 0);
>   	EXPECT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
>   
>   	/* Verify we can set an arbitrary remote fd with large size */
>   	memset(&big, 0x0, sizeof(big));
>   	big.addfd = addfd;
>   	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD_BIG, &big);
> -	EXPECT_EQ(fd, 6);
> +	EXPECT_GE(fd, 0);
>   
>   	/* Verify we can set a specific remote fd */
>   	addfd.newfd = 42;
> 

Here is my Ack if Kees wants to take it through seccomp.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

