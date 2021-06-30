Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FD73B8A8D
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jul 2021 00:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhF3WlH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Jun 2021 18:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhF3WlH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Jun 2021 18:41:07 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C482C061756
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Jun 2021 15:38:37 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id k16so5088434ios.10
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Jun 2021 15:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J0KcyP9kWSbHZOqf7CgSrcSkkm0ZOyi4lXE41TUYIZw=;
        b=Zfgu8DrevHifNYP3W1Cre/OGpvVJDBEk4Tg2f2nxGhWfA/fj6xlUAlUfP0NeFMAY0g
         h6kwwky8Oq709nGOmP5LQ3UpR2ckCHphhiYpAzpWYi1yZMw3huIAD0MPG4cZ+l/nvxDm
         p9zDZ2RSY1ofgzcWCNl1Dp3TbyU6cWMpTr4qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J0KcyP9kWSbHZOqf7CgSrcSkkm0ZOyi4lXE41TUYIZw=;
        b=e+yyphVjE9yTbjvMxGo5D851vkJX65XWOhoXwVwNxmXIXkvVvx3zZdnj3QzT8h8KqH
         l37fawOWzPpAs9JE6MlSwy2zEnyxmS95KW4vsPO4qz72WPuF+2f7FsXEP7qQorsPkUYM
         33hS6DS/EUzgVYwULeR4AnB/Y6YFVEo15KFg9b8aaTA+I+Bq9KzGANKqBtmuNKVP9kXm
         DUayhNB6LdrJ1SCVmMK+lIBC5eVfp3u6z3fawilaT7zyt3l/YEwmhLXW3o0XW2yGGEWo
         KWZWnUPR9IRw57Wa77+p3/Y+CVIAJpKno8yFbj4d4N+2TwG5Jk6jknCILLqMPDRx5hIE
         fjsA==
X-Gm-Message-State: AOAM530V7E1lf2x+ulmhQKIzoQUj0NZVkpXGHJYO4qfo2LfPjN4NOa95
        /QrwIy0YWK+YwNpopMAJbBudxg==
X-Google-Smtp-Source: ABdhPJyslW27x7gNEJe8OJzWZ10kqum6Rl5lmZ0D743CPeAJk6yKqXTwGhuVr0yiAJw+JiDx9UK+kA==
X-Received: by 2002:a05:6638:190e:: with SMTP id p14mr10671785jal.70.1625092716906;
        Wed, 30 Jun 2021 15:38:36 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j25sm13240348iog.47.2021.06.30.15.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 15:38:36 -0700 (PDT)
Subject: Re: [PATCH] kselftest/kselftest_harness.h: do not redefine ARRAY_SIZE
To:     Peter Oskolkov <posk@google.com>, Peter Oskolkov <posk@posk.io>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20210625224902.1222942-1-posk@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a4664b42-19cf-cac7-fd3e-38d93bb894d4@linuxfoundation.org>
Date:   Wed, 30 Jun 2021 16:38:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625224902.1222942-1-posk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/25/21 4:49 PM, Peter Oskolkov wrote:
> Macro ARRAY_SIZE is defined in tools/include/linux/kernel.h, so
> if both headers are included there is a warning.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>
> ---
>   tools/testing/selftests/kselftest_harness.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index ae0f0f33b2a6..75164e23f036 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -671,7 +671,9 @@
>   #define EXPECT_STRNE(expected, seen) \
>   	__EXPECT_STR(expected, seen, !=, 0)
>   
> +#ifndef ARRAY_SIZE
>   #define ARRAY_SIZE(a)	(sizeof(a) / sizeof(a[0]))
> +#endif
>   
>   /* Support an optional handler after and ASSERT_* or EXPECT_*.  The approach is
>    * not thread-safe, but it should be fine in most sane test scenarios.
> 

Thank you for the patch. This will be queued for rc2 after the merge
window closes.

thanks,
-- Shuah
