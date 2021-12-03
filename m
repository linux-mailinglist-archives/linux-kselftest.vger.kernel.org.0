Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82A1467D44
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 19:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353255AbhLCS3j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 13:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353156AbhLCS3j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 13:29:39 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFB3C061751
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 10:26:15 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id z8so3579709ilu.7
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Dec 2021 10:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=azf4/wVj2YJvJGUudEUC74MuUs2tvIqRTehotgQgLos=;
        b=etpD2ROqKqqgjYt9Q/uCdZNOHghaRT7w645Adxn/LYb6EglQRsaBln07VgptPnFZrM
         8MSJ3Gr2A0fRfZnQaFnqZyHfibGWwWf0Soe7mkpI6pgdL4PT/EMtH3ISNA/82BDx/zUd
         zEekUFQ/9TRTx0z64t/AlkTXPFBdTV4Ouqr74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=azf4/wVj2YJvJGUudEUC74MuUs2tvIqRTehotgQgLos=;
        b=VrSaFpgB9Nk9s8+xW/r5spKanDdNoCR9OrySOgcPItchjZpci2+sA9LOgWA2ZImaK+
         ABGT+eH4HeXCRyALKDXQaTRlhLAJc83PkGXMsNCq58zK4neN+AG8yLE8ZMByy4JWRNiq
         n8GvNCj8KWKL+5TP/7Y1hMUoyAPwJgkFWX703IImsc3PBAve5brjz6wBunBv2deDmGSU
         cx6BfqmWRhrvJV2K5U3OzrcsreWeI23AY7ps9UNp+f0VGLX8jPdE9JpSjvQhs9G2OiFE
         0DO2j0JqGfTobO9cBeTwUzTxiJildYestlfc7JecZGKJXgCiBD+KizV46NQrQ3wj0/pY
         KEPg==
X-Gm-Message-State: AOAM53240xe8RbUNUt9YrowRYqkIj6sb+QvUht48VGHrkxXwbkJ3Cbxj
        AxQPjvfHZRQNpdYW+MSp6iSqpA==
X-Google-Smtp-Source: ABdhPJwF/2Juo33NOH6nUb7cPzy8sdxNMpRF4p0w7bbnHZmeBe7kCDABrT64yp5p/PkXTi+Gmzr++g==
X-Received: by 2002:a92:d246:: with SMTP id v6mr22501374ilg.148.1638555974667;
        Fri, 03 Dec 2021 10:26:14 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w1sm1888065ilq.1.2021.12.03.10.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 10:26:14 -0800 (PST)
Subject: Re: [PATCH] mnt: remove unneeded conversion to bool
To:     davidcomponentone@gmail.com, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <3a7435c9e7e7aa8f24d22fd576ce912eb0540272.1637737086.git.yang.guang5@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <07f4ba23-cf4c-6817-f7a4-5428f35d966c@linuxfoundation.org>
Date:   Fri, 3 Dec 2021 11:26:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3a7435c9e7e7aa8f24d22fd576ce912eb0540272.1637737086.git.yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/24/21 5:56 PM, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> The coccinelle report
> ./tools/testing/selftests/mount/unprivileged-remount-test.c:285:54-59:
> WARNING: conversion to bool not needed here
> ./tools/testing/selftests/mount/unprivileged-remount-test.c:207:54-59:
> WARNING: conversion to bool not needed here
> Relational and logical operators evaluate to bool,
> explicit conversion is overly verbose and unneeded.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> ---
>   tools/testing/selftests/mount/unprivileged-remount-test.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
> index 584dc6bc3b06..d2917054fe3a 100644
> --- a/tools/testing/selftests/mount/unprivileged-remount-test.c
> +++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
> @@ -204,7 +204,7 @@ bool test_unpriv_remount(const char *fstype, const char *mount_options,
>   		if (!WIFEXITED(status)) {
>   			die("child did not terminate cleanly\n");
>   		}
> -		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
> +		return WEXITSTATUS(status) == EXIT_SUCCESS;
>   	}
>   
>   	create_and_enter_userns();
> @@ -282,7 +282,7 @@ static bool test_priv_mount_unpriv_remount(void)
>   		if (!WIFEXITED(status)) {
>   			die("child did not terminate cleanly\n");
>   		}
> -		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
> +		return WEXITSTATUS(status) == EXIT_SUCCESS;
>   	}
>   
>   	orig_mnt_flags = read_mnt_flags(orig_path);
> 

This change doesn't look right. WEXITSTATUS(status) return could be
> 1 or 0 or negative.

thanks,
-- Shuah
