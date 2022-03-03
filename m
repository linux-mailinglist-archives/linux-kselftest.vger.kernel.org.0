Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA304CC7FF
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 22:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiCCV2a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 16:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiCCV2a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 16:28:30 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A85E20F65
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Mar 2022 13:27:43 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id c23so7415530ioi.4
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Mar 2022 13:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ih0JJt97BBLYj6Fn0f3k3bViw991U3vBLG4c2N4VIno=;
        b=Pf7u6B9wHbx5Ozd3EXU+1heavGLb89mO4+WtHg+MxHJM7uaFi7TVvEc7m8OxmUOd7X
         PDHum2XOROhKVlbmwnJ6p4R4fO325YxCEo8Zwn+nSpeNthHHTQvx8pdExlbnGzEYv+6X
         /R3lrU9fRntHH+wdRb5Tlgp/HD6eIbsc2wHJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ih0JJt97BBLYj6Fn0f3k3bViw991U3vBLG4c2N4VIno=;
        b=gqEKRMR0wjbCo/dqBv1I/LwJ60XFdGUb5dyC4Z0/FJAJzpTtXviJ0QWybSKzOVtotM
         Y7mCB5WYCvbfhhphxyk9jEajHKwh24naVLy6IpTma78m0DcBsiz079JsXpVV+Ubqbpx4
         7iGc81rvAGWn7oENErPsqGEmKsWjlEeP/Rw/pxb1cHjbx5W6igOs23CNom+Lwh8vsm8X
         IhNKqCh/gXlRALMVybFSRZrB9eL2qqdseke6FHYdiCArCBEH8j0188osWfeFFLmSSgzU
         T8fd4zuapCdFHMqAG8XyUgbJKerFMTCPEhK717YBBAwVsT9S6HyfmLAI6NqahO9O1wnb
         0V+Q==
X-Gm-Message-State: AOAM532tPzlf7AflYFugwgGOQdeHS8lidJLJ+SuBwNxnfIuV3tiyiVwq
        NlXUrzdvFW0T9I2e+ws5hxV2Dw==
X-Google-Smtp-Source: ABdhPJxLJkLqkINiqGbVbJ4zT+0L5Qkaxvre0HSWGZ/ryhqV8qgdVfxgM0lguf4zYT5cA+cNSVWMVg==
X-Received: by 2002:a05:6602:1541:b0:645:7001:8ad1 with SMTP id h1-20020a056602154100b0064570018ad1mr2991689iow.192.1646342862987;
        Thu, 03 Mar 2022 13:27:42 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id l1-20020a056e021aa100b002c56271ac39sm3120534ilv.56.2022.03.03.13.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 13:27:42 -0800 (PST)
Subject: Re: [PATCH 2/2] kselftest/vm: fix tests build with old libc
To:     Chengming Zhou <zhouchengming@bytedance.com>,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220227055330.43087-1-zhouchengming@bytedance.com>
 <20220227055330.43087-2-zhouchengming@bytedance.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ed6cc632-8209-0afe-fdff-ee179610d73d@linuxfoundation.org>
Date:   Thu, 3 Mar 2022 14:27:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220227055330.43087-2-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/26/22 10:53 PM, Chengming Zhou wrote:
> The error message when I build vm tests on debian10 (GLIBC 2.28):
> 
> userfaultfd.c: In function ‘userfaultfd_pagemap_test’:
> userfaultfd.c:1393:37: error: ‘MADV_PAGEOUT’ undeclared (first use
> in this function); did you mean ‘MADV_RANDOM’?
>    if (madvise(area_dst, test_pgsize, MADV_PAGEOUT))
>                                       ^~~~~~~~~~~~
>                                       MADV_RANDOM
> 
> This patch includes these newer definitions from UAPI linux/mman.h,
> is useful to fix tests build on systems without these definitions in
> glibc sys/mman.h.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>   tools/testing/selftests/vm/userfaultfd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 2f49c9af1b58..3fc1d2ee2948 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -46,6 +46,7 @@
>   #include <signal.h>
>   #include <poll.h>
>   #include <string.h>
> +#include <linux/mman.h>
>   #include <sys/mman.h>
>   #include <sys/syscall.h>
>   #include <sys/ioctl.h>
> 

Looks good to me.

Andrew,

If you want to take this through your tree or I can apply it.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
