Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F43457A17
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Nov 2021 01:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhKTAVo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 19:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhKTAVo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 19:21:44 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06220C06173E
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 16:18:42 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id f9so14815917ioo.11
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 16:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j4HsihesuWRn6Y6XmUNEckNuiN/kPKd9OIJTos8r0uI=;
        b=NLLJA18B1Pvq1l2kHr0pA08D8bG8XKABcsHGET5ib4U6TRJCY5vco16fd8kKFa8yqn
         IK56lQ7vlrPKQ9u9b73rdjR5fsi9/MFH8Y4jNqp20kwbBdsqIScp85ZhZquotuqu66Gf
         DSQ5xfEzleUC2VUdZxZ1C08685XDALpR7tvB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j4HsihesuWRn6Y6XmUNEckNuiN/kPKd9OIJTos8r0uI=;
        b=Phx0+oHriIylZuBMPuMJ97yQCNnBKCotzNfW6GOSgtSyCFCpgygGhcFgWPEFRusTqA
         4EKMQyryzF0mu+ZdtLrIx19Qy1wx8VbKB1v3T+dRa7xXwTS9fdPn3yMvWfuU2xnO/YXd
         KG6cU6H/YJUNatPwF65gEBGiJjy3tRbdef7/WE66/2xq423QsqYe0hP/+gB84Ql9udM8
         jdkJJdMa7itTShf3ogx11HtP5GIiSXa9ZsnvSOtWPsC1d9ixX+T5lWb0Q4R6i8oTEhNH
         6tTWKVfYl5y/uJUSQhEtECqEzCJybGcfk0w/zDel/bWb2x7xG3svFw51ngsUMiqaoqjR
         +CBA==
X-Gm-Message-State: AOAM533eNFmMyBw7y5tZUlilc7gafnhR8skfmQj+1QP1zZ+9g6LkEtQF
        LIg4g93O+rsNhz6UWZjoHAm3XQ==
X-Google-Smtp-Source: ABdhPJzVuqx0rS8ssjTqrGq2F/gxOgBgc4ZNkzigizQCHP4xSFn+Gc83wKA0lrn5Ij4qOhx4lnYpZg==
X-Received: by 2002:a05:6602:486:: with SMTP id y6mr8499566iov.104.1637367521461;
        Fri, 19 Nov 2021 16:18:41 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id ay13sm757870iob.37.2021.11.19.16.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 16:18:41 -0800 (PST)
Subject: Re: [PATCH 1/2] selftests: timens: use 'llabs()' over 'abs()'
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, nathan@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20211105163137.3324344-1-anders.roxell@linaro.org>
 <CAKwvOdnge-hBmoFH-CHZmbh7DTq8bQiyhbfEOWkBt447=e6QGA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4de8c09f-df5e-8d7e-a19e-98424e939b81@linuxfoundation.org>
Date:   Fri, 19 Nov 2021 17:18:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnge-hBmoFH-CHZmbh7DTq8bQiyhbfEOWkBt447=e6QGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/5/21 2:26 PM, Nick Desaulniers wrote:
> On Fri, Nov 5, 2021 at 9:31 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>>
>> When building selftests/timens with clang, the compiler warn about the
>> function abs() see below:
>>
>> timerfd.c:64:7: error: absolute value function 'abs' given an argument of type 'long long' but has parameter of type 'int' which may cause truncation of value [-Werror,-Wabsolute-value]
>>                  if (abs(elapsed - 3600) > 60) {
>>                      ^
>> timerfd.c:64:7: note: use function 'llabs' instead
>>                  if (abs(elapsed - 3600) > 60) {
>>                      ^~~
>>                      llabs
>>
>> The note indicates what to do, Rework to use the function 'llabs()'.
>>
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> 
> Thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
>> ---
>>   tools/testing/selftests/timens/timer.c   | 2 +-
>>   tools/testing/selftests/timens/timerfd.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
>> index 5e7f0051bd7b..5b939f59dfa4 100644
>> --- a/tools/testing/selftests/timens/timer.c
>> +++ b/tools/testing/selftests/timens/timer.c
>> @@ -56,7 +56,7 @@ int run_test(int clockid, struct timespec now)
>>                          return pr_perror("timerfd_gettime");
>>
>>                  elapsed = new_value.it_value.tv_sec;
>> -               if (abs(elapsed - 3600) > 60) {
>> +               if (llabs(elapsed - 3600) > 60) {
>>                          ksft_test_result_fail("clockid: %d elapsed: %lld\n",
>>                                                clockid, elapsed);
>>                          return 1;
>> diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
>> index 9edd43d6b2c1..a4196bbd6e33 100644
>> --- a/tools/testing/selftests/timens/timerfd.c
>> +++ b/tools/testing/selftests/timens/timerfd.c
>> @@ -61,7 +61,7 @@ int run_test(int clockid, struct timespec now)
>>                          return pr_perror("timerfd_gettime(%d)", clockid);
>>
>>                  elapsed = new_value.it_value.tv_sec;
>> -               if (abs(elapsed - 3600) > 60) {
>> +               if (llabs(elapsed - 3600) > 60) {
>>                          ksft_test_result_fail("clockid: %d elapsed: %lld\n",
>>                                                clockid, elapsed);
>>                          return 1;
>> --
>> 2.33.0
>>
> 
> 

Same comment on llabs() define in stdlib.h made earlier in the context
of timer test changes.

thanks,
-- Shuah


