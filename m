Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A977B3F60A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 16:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbhHXOk4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 10:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbhHXOky (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 10:40:54 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B813C061757
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 07:40:10 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a21so26643124ioq.6
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8Sjiy26CpBt8YuiYVMsbC/6C1ttKggpAZsGtO/Y7dTM=;
        b=QdITDJKKzLnLEgGNUpyc8qIVl5RC2CVLRJIilNbOCedIliv6pM1+t96GwfSynFYr9M
         feq+v4sYMYnzR1xgC5dRG4FKSvqf63D/h223SnkArKADKP673agJTp5XkgLS4TfvS2yx
         9UCamWHzbkE3xmP1SLZQxzFAOREDqmo+r8Vsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Sjiy26CpBt8YuiYVMsbC/6C1ttKggpAZsGtO/Y7dTM=;
        b=Je2lMghpTG1nCAswfWFVRoFhJW1+HcUk9YEkvmJbNOskV4d1KjpHZmcFD7ZcUBK8bg
         IfvrVydRa47YJNQGEONPrzM1ezsPmYU8gKeyBI/ZeuDkSjnkRy3+PPkgiuazP0SjEsj1
         /ZkjfexTCwnxgkL0A4IJi2fRw8Foa2wPascfI1r9tldO0p4Ve4nT5rUju4rpc5WElnQ4
         y5YZUKSz3PAYbQlOHNEkAF/n8tvlDM8LP7NHc29HlwLvRPMEqqtJyTIx53Slx//Tdv83
         UtRWHgUkiaKpmdEIRAARiVXCLxDqIxcypCmpZVLmoR8dkZqiPKhgcHwxoUIL//ofqYcn
         LCDA==
X-Gm-Message-State: AOAM533tuPX+sZCUu3pw3ln/2qOitSrGizRD5Ftn/TjfMOjZUzpNUavk
        4xWlWgZepbpWzTJmbFiX3L5Dgw==
X-Google-Smtp-Source: ABdhPJz68nWSK976dC6m/+R0f4pjTuRpyBmdTA2yrkPRnt92orEEEQWgyreotN9WAPQKNKD43IUvKQ==
X-Received: by 2002:a02:7a14:: with SMTP id a20mr34734496jac.27.1629816010094;
        Tue, 24 Aug 2021 07:40:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z26sm10264558iol.6.2021.08.24.07.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 07:40:09 -0700 (PDT)
Subject: Re: [PATCH linux-next] kselftest: remove duplicate include in
 cs_prctl_test.c
To:     cgel.zte@gmail.com, chris.hyser@oracle.com
Cc:     shuah@kernel.org, yong.yiran@zte.com.cn,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210805061919.627607-1-yong.yiran@zte.com.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2f864600-76ca-6d05-64d4-990fd915c509@linuxfoundation.org>
Date:   Tue, 24 Aug 2021 08:40:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210805061919.627607-1-yong.yiran@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/5/21 12:19 AM, cgel.zte@gmail.com wrote:
> From: yong yiran <yong.yiran@zte.com.cn>
> 
> 'sys/types.h' included in 'cs_prctl_test.c' is duplicated.
> Remove all but the first include of sys/types.h from cs_prctl_test.c.
> 
> 'sys/wait.h' include in 'cs_prctl_test.c' is duplicated.
> Remove all but the first include of sys/wait.h from cs_prctl_test.c.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
> ---
>   tools/testing/selftests/sched/cs_prctl_test.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
> index 63fe6521c56d..7db9cf822dc7 100644
> --- a/tools/testing/selftests/sched/cs_prctl_test.c
> +++ b/tools/testing/selftests/sched/cs_prctl_test.c
> @@ -25,8 +25,6 @@
>   #include <sys/types.h>
>   #include <sched.h>
>   #include <sys/prctl.h>
> -#include <sys/types.h>
> -#include <sys/wait.h>
>   #include <unistd.h>
>   #include <time.h>
>   #include <stdio.h>
> 

We can't accept this patch. The from and Signed-off-by don't match.

thanks,
-- Shuah
