Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB683F60B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 16:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbhHXOlx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 10:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbhHXOlx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 10:41:53 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E43C061764
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 07:41:09 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a21so26647603ioq.6
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ESf4F3FzREnNXnHRptficZqDb9QX9TZxnF/j1oA0PVc=;
        b=BRhUuPYTbFMaTDz08ZYIBu0n7s2FTa5SkwhZTi8btNkZUHdeLS8WBpbAiS9AmLfd8F
         gtJ3GVTkRhdr0B18AyUP8Ej1ZwWg1bb4+ipjlyeW2ewWWrvTOpzkmRLLWPW3awzTIIca
         n9JIRZqfMfxp341z39mr98XC4QeKsrO3+f1pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ESf4F3FzREnNXnHRptficZqDb9QX9TZxnF/j1oA0PVc=;
        b=IXV6jjMuSfVSnJmxwR+NRhmblktfQ4xnniIrVdhX5z/wgjTF2qzc66F60jhfB2WRsX
         EwLPhGFxBlfT5UzNSj53hH7uFZQaMe3Ff1u6uryZH43xrH38Je/5I99htKriwP82XVP9
         Ygfvw769PYMoAh9kxPitLGeLEwA+B2ajXVLxP46TBvLGph0gm221vZ13WEtfEiqYlQLV
         VDlo650y3UUu0t8nTpcvQhhAIoHKZnlYBUN0OmOsJWNLM86uOvXwIhwGBegBdm0OwzbB
         ypNrt1doR0I4wHJD46sMHSvemfclo0nh4oj4ethrA/0L82nvolVynkBSvTBOx9FZb4pf
         wEjA==
X-Gm-Message-State: AOAM531L3TAkjZut8PG5cHYiUdtQPBM8M1qP/7eLTRDgC6gAdgx3O5Or
        K1NoHfcoVntwHSeU6l0Zq/mJeA==
X-Google-Smtp-Source: ABdhPJw8Y2SS+wEpAjY3wsltZG4IacYAkBzd7VPVJ8MdJMZpPGoTs/8iQEa8N7g0Pco/+HlqcrsMrw==
X-Received: by 2002:a5d:8744:: with SMTP id k4mr32135949iol.9.1629816068411;
        Tue, 24 Aug 2021 07:41:08 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h10sm9875020ilj.71.2021.08.24.07.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 07:41:08 -0700 (PDT)
Subject: Re: [PATCH linux-next] tools:mount: Remove unnecessary conversion to
 bool
To:     CGEL <cgel.zte@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210820033241.13136-1-jing.yangyang@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <02237efa-5159-f95d-43c9-389a95803a50@linuxfoundation.org>
Date:   Tue, 24 Aug 2021 08:41:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210820033241.13136-1-jing.yangyang@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/19/21 9:32 PM, CGEL wrote:
> From: jing yangyang <jing.yangyang@zte.com.cn>
> 
> Suppress following warning from coccinelle:
> 
> ./tools/testing/selftests/mount/unprivileged-remount-test.c:285:54-59: WARNING conversion to bool not needed here
> ./tools/testing/selftests/mount/unprivileged-remount-test.c:207:54-59: WARNING conversion to bool not needed here
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
> ---
>   tools/testing/selftests/mount/unprivileged-remount-test.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
> index 584dc6b..bc802f6 100644
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

We can't accept this patch. The from and Signed-off-by don't match.

thanks,
-- Shuah
