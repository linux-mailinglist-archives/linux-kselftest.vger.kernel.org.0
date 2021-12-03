Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1265B467D19
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 19:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382508AbhLCSUs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 13:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382518AbhLCSUs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 13:20:48 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A10C061751
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 10:17:24 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id w4so3521721ilv.12
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Dec 2021 10:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W5D+ta9Hn3WAj5iUV+l2uQIzbTjo9ym9Cgbp5HxGrh4=;
        b=RAKbXIU58y70wPosWP0uZwTXTpL2I4QSVzbrOrUFEAXC37fAc4uiF6tjc9hy6qQfZ9
         wqmfgTpxXkrh/mvqb6NNymo9EnnqexcKaBLHGFEBUjymKZym6i7USN7JKQWNSvVyjAET
         GQ5ef2IzBot97Di2d9hiP5KxRhZMjfvTSU1V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W5D+ta9Hn3WAj5iUV+l2uQIzbTjo9ym9Cgbp5HxGrh4=;
        b=ojRWtZVk/itClPzCGFo7/LUBhGGy/hQFY2bmlqC3SSE2o55feFKK/kSogn9c5SJ0Up
         S9ip1uii+X50E0SdYG7qAv1oupOvlMtmMxmVQbp5+8w7cLsYXTbCFWEOsFx6hKY4HxW4
         0rrf1OVZRz7fjplBNJXTxGy5NQoFpgMQvH7kVhF+McO/sLFsxe1sA23JB2hyhNY2I9LI
         btxV+bWr+TsCbKErulSZ+ftyPHFyJiX4nRokEiicRhwBpw4yXgWBnxsixoFUXqgoHfVY
         mIcl2T6nofcrlJfE8eTKh2xlcHcRXJlhhav84WX0HdHlWY4gMbkZT3LTi7R9ZK5A5RS9
         3x+g==
X-Gm-Message-State: AOAM5319wCd9N8pw1At7TIF6Owcs8ncEjvgQNimuNQSmjXGGpfQWZ2kD
        bFg8DFe+QcRuYZC5wIIPw9ZNNA==
X-Google-Smtp-Source: ABdhPJxvOGtGf8DW3JhW0mm5HHAGCu28E4wEqXAAGjpIFYc1JUubVi1BfMryski+UlkIYftCB1gGBQ==
X-Received: by 2002:a05:6e02:1583:: with SMTP id m3mr20950276ilu.294.1638555443431;
        Fri, 03 Dec 2021 10:17:23 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x2sm1973829iom.46.2021.12.03.10.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 10:17:23 -0800 (PST)
Subject: Re: [PATCH selftests] selftests: harness: avoid false negatives if
 test has no ASSERTs
To:     Jakub Kicinski <kuba@kernel.org>, keescook@chromium.org,
        shuah@kernel.org
Cc:     mic@digikod.net, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211124223916.1986279-1-kuba@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <537e3cd2-3e5b-52c8-fd73-493ca71ccc2b@linuxfoundation.org>
Date:   Fri, 3 Dec 2021 11:17:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211124223916.1986279-1-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/24/21 3:39 PM, Jakub Kicinski wrote:
> Test can fail either immediately when ASSERT() failed or at the
> end if one or more EXPECT() was not met. The exact return code
> is decided based on the number of successful ASSERT()s.
> 
> If test has no ASSERT()s, however, the return code will be 0,
> as if the test did not fail. Start counting ASSERT()s from 1.
> 
> Fixes: 369130b63178 ("selftests: Enhance kselftest_harness.h to print which assert failed")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   tools/testing/selftests/kselftest_harness.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index ae0f0f33b2a6..79a182cfa43a 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -969,7 +969,7 @@ void __run_test(struct __fixture_metadata *f,
>   	t->passed = 1;
>   	t->skip = 0;
>   	t->trigger = 0;
> -	t->step = 0;
> +	t->step = 1;
>   	t->no_print = 0;
>   	memset(t->results->reason, 0, sizeof(t->results->reason));
>   
> 

Thank you for the fix. Will apply for the next pull request.

thanks,
-- Shuah
