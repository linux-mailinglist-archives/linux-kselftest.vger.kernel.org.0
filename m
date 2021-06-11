Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AE53A480D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 19:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhFKRrO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 13:47:14 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:43974 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhFKRrO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 13:47:14 -0400
Received: by mail-il1-f171.google.com with SMTP id x18so5910270ila.10
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jun 2021 10:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5ijyroFp+98lSqnS5hYLTzKlmPzT6WfBJO8AA2eOMqw=;
        b=DUOyuwOium8uOtGloLPa2VcJroQ4qNKS6RSmUljVcBADDdOJDaQA4UsAUkuLri5So7
         OObRNDN3g3u7/a5IrNcLvhURtokaoaJG6OyXq9Vka12e4VW9wXuzkZT73oN6uf0KDbNd
         58+lIcXKh8u1DT0StKzB+SvGKJ55Fr/Y004JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ijyroFp+98lSqnS5hYLTzKlmPzT6WfBJO8AA2eOMqw=;
        b=XgW23bisTEySokhx8ZjeEY5gy5L/5Owy4JQhZgr5GtAfYe5qk52Dgg8aPFLN4Xqr2R
         t3Ks4tUVHrla/PcMzJWNiLwJSVElin12RvvZrLxmJI4wd4uSA/gqhqx3FTy1pSaqhpD/
         23JXkGB27fWTDFl3XkZSGUeQN5M9BjQIIFEnX+3uWEUouEfP1JRwK9/a8dIaSDzOdGv6
         6FD01x46geG6SwuaBsoXzx/QJRU0iSE34NGwDbxCL8EVCVF65FF5BoYqSeGIeC/b7zhY
         YGr0pDVzou1qy1a9pHgCD1x24UvnjBIH+NOFCxB1wbFe6O26KCKYG4sDlsBIa46z65uh
         i3mw==
X-Gm-Message-State: AOAM531eI0CBfklZNkSf72ZojyOEfEqqWYbIWlGjucGSTiMM1IK8f8DI
        Tz9Fr76NRq8x9Cl4o6Y7D1BPMA==
X-Google-Smtp-Source: ABdhPJy7kad9tNY57/QiYORDCPdWEE9wmXOvWaoeTqcWMf6TkTJr/JkDeInO1JjwlrOgs3aRymSzYw==
X-Received: by 2002:a92:c90d:: with SMTP id t13mr4163128ilp.172.1623433443190;
        Fri, 11 Jun 2021 10:44:03 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i139sm3524563ioa.20.2021.06.11.10.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 10:44:02 -0700 (PDT)
Subject: Re: [PATCH] kunit: Fix result propagation for parameterised tests
To:     Marco Elver <elver@google.com>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210611035725.1248874-1-davidgow@google.com>
 <CANpmjNOvLz=71PXSi+LGvKZ+9b_rfY1+wp8HfeyZa8u2QZURcg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8a7e6806-97f5-6f13-5e97-328cf0d3a95d@linuxfoundation.org>
Date:   Fri, 11 Jun 2021 11:44:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CANpmjNOvLz=71PXSi+LGvKZ+9b_rfY1+wp8HfeyZa8u2QZURcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/11/21 2:29 AM, Marco Elver wrote:
> On Fri, 11 Jun 2021 at 05:57, David Gow <davidgow@google.com> wrote:
>>
>> When one parameter of a parameterised test failed, its failure would be
>> propagated to the overall test, but not to the suite result (unless it
>> was the last parameter).
>>
>> This is because test_case->success was being reset to the test->success
>> result after each parameter was used, so a failing test's result would
>> be overwritten by a non-failing result. The overall test result was
>> handled in a third variable, test_result, but this was disacarded after
>> the status line was printed.
>>
>> Instead, just propagate the result after each parameter run.
>>
>> Signed-off-by: David Gow <davidgow@google.com>
>> Fixes: fadb08e7c750 ("kunit: Support for Parameterized Testing")
> 
> Reviewed-by: Marco Elver <elver@google.com>
> 
> Would Cc: stable be appropriate?
> 
> Thanks,
> -- Marco
> 
>> ---
>>
>> This is fixing quite a serious bug where some test suites would appear
>> to succeed even if some of their component tests failed. It'd be nice to
>> get this into kunit-fixes ASAP.
>>

Will apply this with cc stable.

>> (This will require a rework of some of the skip tests work, for which
>> I'll send out a new version soon.)
>>

Thanks for the heads up. I will wait for new version.

thanks,
-- Shuah
