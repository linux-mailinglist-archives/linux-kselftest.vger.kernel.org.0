Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BE22996D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 20:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793105AbgJZT3r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 15:29:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45150 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1793103AbgJZT3q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 15:29:46 -0400
Received: by mail-io1-f66.google.com with SMTP id n6so11381738ioc.12
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Oct 2020 12:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UMV5byUKBjbBGS6Lt1DrWfPHlC3+k9ZgGBZmo2bLocc=;
        b=Q2TAQigSsVBfc+3CtfsNyg/xBg6mB+wEu2UwOsnqhHvLtie0fi2k3LgUhq7gVqvQWa
         1Eg0/mCkWS1xcmH5+MRIvOQx1MPUNHfsEqLjWKBULAjhKy2JjILOm99EqchS5v1emELF
         o/9BMEgQEMRcPoFEofpxQb6etWgTp9KT1HNtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UMV5byUKBjbBGS6Lt1DrWfPHlC3+k9ZgGBZmo2bLocc=;
        b=eBs0wRwXsqE65S0+qZQjkrhcEZEtkcUzx5l6JA4gkv7IXr2HLpQ9w7Tzeby4T2dEaN
         tneeaFjrvGqPjfW3aMKH4P1xP3lHv/V7YkmgNUlkXf0p3UYdel8Ronk4u1ncjdjUJrhS
         f4rs5Qjzmb/w2XeRvg+89VPj5zLgLGwehwDD1bIjfZc1QX7i4QGKHMG+eccWF9v/zCKL
         dMEXMRsvwxZST+F+4aLAHHJcPSp/EcxG1NTFQ8lBX2n/Upse4Z5uhLu/1e7HcZpIiHHw
         H0bUNAN4Bhk3zY2mFktDrd+ZcVmjGrQ+NV05eMNJyGyd5GY3QYUP8GmT4G9kR4DyAfG2
         h97A==
X-Gm-Message-State: AOAM532L5Xa8QI0Z2qLgDkdtgbs+Gjwbs5NdyLGFZL3DN46F2ns9qChp
        FJDWV9Nu4puDzlOi/5mYSP1oog==
X-Google-Smtp-Source: ABdhPJz50kxjhnGkA7tBJjMYJGZglHA4rKONQTN2uG2aHF17DqnA88/SVwblrea06Ncp3KP5nlY4MQ==
X-Received: by 2002:a02:7348:: with SMTP id a8mr12316682jae.76.1603740584118;
        Mon, 26 Oct 2020 12:29:44 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f85sm7066759ill.39.2020.10.26.12.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 12:29:43 -0700 (PDT)
Subject: Re: [PATCH v3 5/6] kunit: test: fix remaining kernel-doc warnings
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1603282193.git.mchehab+huawei@kernel.org>
 <1c36d295423c5c20c21a7edede0eb29e338dd62a.1603282193.git.mchehab+huawei@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7d7b8947-38db-2b96-21ca-78428b01365b@linuxfoundation.org>
Date:   Mon, 26 Oct 2020 13:29:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1c36d295423c5c20c21a7edede0eb29e338dd62a.1603282193.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/21/20 6:17 AM, Mauro Carvalho Chehab wrote:
> test.h still produce three warnings:
> 
> 	include/kunit/test.h:282: warning: Function parameter or member '__suites' not described in 'kunit_test_suites_for_module'
> 	include/kunit/test.h:282: warning: Excess function parameter 'suites_list' description in 'kunit_test_suites_for_module'
> 	include/kunit/test.h:314: warning: Excess function parameter 'suites' description in 'kunit_test_suites'
> 
> They're all due to errors at kernel-doc markups. Update them.
> 
> It should be noticed that this patch moved a kernel-doc
> markup that were located at the wrong place, and using a wrong
> name. Kernel-doc only supports kaving the markup just before the
> function/macro declaration. Placing it elsewhere will make it do
> wrong assumptions.
> 
> Fixes: aac35468ca20 ("kunit: test: create a single centralized executor for all tests")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   include/kunit/test.h | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index a423fffefea0..14224baca3be 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h

Applied to linux-kselftest kunit-fixes branch

after auto-fixing the checkpatch warn

WARNING: please, no space before tabs
#108: FILE: include/kunit/test.h:258:
+ * ^I^I^I &struct kunit_suite with KUnit.$

total: 0 errors, 1 warnings, 45 lines checked

thanks,
-- Shuah


