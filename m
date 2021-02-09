Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9DA3144C4
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 01:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhBIARt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 19:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhBIARr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 19:17:47 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162F8C061786
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Feb 2021 16:17:07 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id q5so14527393ilc.10
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Feb 2021 16:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WYt3vh15rxaz4Z6udzDByI0WGuYoSAhQixnxcFlgIKo=;
        b=KRJbpx5wsXCiAOeSBIUafyHiEhI+OU5Q0hApcMD8qmwew7Xew/FCG0LL9QQTvD3yFW
         JswZptbg8bsCWVsbuVYYkFxK655g+4NmAHgjCwohM+AUqGepCSK9RYe7vNWC+jMyhQV+
         GQsGS4ljpmpp7rFZTX9cvNw+wa5x4dG1HVIuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WYt3vh15rxaz4Z6udzDByI0WGuYoSAhQixnxcFlgIKo=;
        b=FOPfWNdVZnmwb3HibJQSFsOpPqbsPUALaEpiaXGu8OJeJu0x0W6yIFin+J/h9E6jSi
         +Hoy7pnEd7vffGe1kZIGkHy8oqoO2pVlRePzv1hZAKkPXiTtsgH/+hx6kbtmkt9EqBjv
         0SsfFJX4HjXcsGKbakB2vX10juzKf0SA4hAcB0NcHDlJ3xkH/XkzDgoY95nzodlEcvth
         9KgE5kKLUptZCGI8I9stRMpZKD43tyjYbe4gSNf4c3XGNx40HYG9FAL7rjdHOgonbPmX
         g/dS/INGdudubtcD/ISjG1nKHDs6+8WoMvF+xgMGpOzyes3Tk1iglbmn1KBsRvs6cfEU
         Ch9w==
X-Gm-Message-State: AOAM533sj98oLhCp4vPnIPzj0Hc60d95QPs1k4W3hvQZuK8ggh3wCJzQ
        e/rkyLJm7wdVDD1ijOgTaK/WYA==
X-Google-Smtp-Source: ABdhPJzvrWMAZpq+VYzYOOgynNPK2oW27r5sSIk8AWOqt3f81pqnNMPB5F831E9eDpfGTi0qo8tiXQ==
X-Received: by 2002:a05:6e02:180d:: with SMTP id a13mr17815207ilv.156.1612829826565;
        Mon, 08 Feb 2021 16:17:06 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h12sm9701392ilj.52.2021.02.08.16.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 16:17:05 -0800 (PST)
Subject: Re: [PATCH] Correct leftover directories from make kselftest
To:     Erik Hollensbe <erik@hollensbe.org>,
        linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210128033743.77040-1-erik@hollensbe.org>
 <20210128033743.77040-2-erik@hollensbe.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <aadb7d9c-6042-0b4e-9d2a-764432ccf0ef@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 17:17:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210128033743.77040-2-erik@hollensbe.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/27/21 8:37 PM, Erik Hollensbe wrote:
> Here are some directories that are created/filled as a part of the make
> kselftest process, but not ignored.
> 
> Signed-off-by: Erik Hollensbe <erik@hollensbe.org>
> ---
>   tools/testing/selftests/gpio/.gitignore   | 1 +
>   tools/testing/selftests/timens/.gitignore | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/gpio/.gitignore b/tools/testing/selftests/gpio/.gitignore
> index 4c69408f3e84..640b5cb4ed4e 100644
> --- a/tools/testing/selftests/gpio/.gitignore
> +++ b/tools/testing/selftests/gpio/.gitignore
> @@ -1,2 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   gpio-mockup-chardev
> +tools-gpio
> diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
> index 2e43851b47c1..95e97d7bc336 100644
> --- a/tools/testing/selftests/timens/.gitignore
> +++ b/tools/testing/selftests/timens/.gitignore
> @@ -7,3 +7,4 @@ procfs
>   timens
>   timer
>   timerfd
> +futex
> 

Thank you for the patch.

Can you split these into two patches? make separate patches for gpio
and timens.

Gives you more practice. :)

thanks,
-- Shuah
