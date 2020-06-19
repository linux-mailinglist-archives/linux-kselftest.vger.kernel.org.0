Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336492011F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 17:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393867AbgFSPrL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 11:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404290AbgFSP0O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 11:26:14 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1D8C06174E
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 08:26:13 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i4so8591047iov.11
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7bbqKL5wCur00YbM/P403tQCUvrv7O7GPTjyjOfZP3M=;
        b=a5rw+SuJdniF8RKB6Otd2K6eahNkDBJ9VTxPEP0DKdttF+f0c0b18PDls9fNzgQ3aW
         UwIU/+YKfz0IYqCsJwSszna/Wlu4rfkq6R0OB7AhpahzxJ/NbHy5tuVtbdypxSnSbFhE
         nRvNuKACiABpy/evYMn7Z3cD+pPw2yYIWlKuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7bbqKL5wCur00YbM/P403tQCUvrv7O7GPTjyjOfZP3M=;
        b=ZkJ8jyYnWbm56xJbjRBd5OKTpY6oxC9ZjCjcHOpc02FfRUxqUPOvJcP0fc4YZWri2R
         YMkqsFBAxCNz2Y6ztPNEsQXUbnSH5SMesUvHSGpX2Dln9KQ0YhnmZxgf2c43KJJScUDW
         odcQk4fsEg67sRQKJJzPpkYhgp6zcPxXTsLMl7Fxuy0ORhX9p1FKOJvIStjHcNSDQc1I
         nNfXKCSfiOnxXJFzSjzA41uNaZoHT45gaMuXkacnIpyQnXMVKBesXKLQwGX9Ico0UHtp
         e1LXeVncSVx8KeOZRYypWzgpr6CaB2yTm3uIhe5eb1YEq0a2oNWw7S/K8mZS6W/h+iZz
         qkQA==
X-Gm-Message-State: AOAM530eob14iYId7/wwnYD3jCle6mYE3NuFNtN/v73TpYfJpjbEHscK
        TGvgkmdjbq/Zyl4bbnEC8ZFQOg==
X-Google-Smtp-Source: ABdhPJydeDBPRvmTQU4moYrg0CwkvLT5oEAoZxzMBBZM/suYprvYjQ4q60WRHVJdPvxVgMVwxXK4Lg==
X-Received: by 2002:a02:cce1:: with SMTP id l1mr4088483jaq.89.1592580372392;
        Fri, 19 Jun 2020 08:26:12 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g21sm3688936ioc.14.2020.06.19.08.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 08:26:11 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] selftests/ftrace: Convert required interface
 checks into requires list
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <159115200085.70027.6141550347953439240.stgit@devnote2>
 <159115203782.70027.2241223276591824366.stgit@devnote2>
 <1cf646af-ef25-a7df-9df3-1e6aa8e6a9c8@linuxfoundation.org>
 <20200610145535.747d2765d60e6e3923441768@kernel.org>
 <5a658ffa-348a-436d-fb74-e01f56541d6b@linuxfoundation.org>
 <20200610093206.5b9fb1b7@oasis.local.home>
 <f8cc0d67-3f35-134a-a6c4-ad4a98a215a3@linuxfoundation.org>
 <41b50b37-c9cb-9e7c-3ea7-d0824a41c03c@linuxfoundation.org>
 <20200617235822.76b94496733a3d7c5bb647b6@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <df1b214f-99d9-621c-0fb4-9b6a1d33eab8@linuxfoundation.org>
Date:   Fri, 19 Jun 2020 09:26:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617235822.76b94496733a3d7c5bb647b6@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/17/20 8:58 AM, Masami Hiramatsu wrote:
> Hi Shuah,
> 
> On Tue, 16 Jun 2020 10:48:12 -0600
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 6/11/20 6:03 AM, Shuah Khan wrote:
>>> On 6/10/20 7:32 AM, Steven Rostedt wrote:
>>>> On Wed, 10 Jun 2020 06:04:33 -0600
>>>> Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>>>> Steve, what would you think?
>>>>>
>>>>> No worries. As far as kselftest tree is concrned, I can apply these
>>>>> after rc1 comes out with Tom's patch.
>>>>>
>>>>> Or I can give Ack and Steve can take these through tracing tree.
>>>>
>>>> All my patches have already made it to Linus's tree. Perhaps
>>>> cherry-pick the commit needed from Linus's tree (it shouldn't break
>>>> anything when Linus pulls it). Just let Linus know what you did, and
>>>> everything should be fine.
>>>>
>>>
>>> Good to know. I will get these in.
>>>
>>
>> I applied all 7 patches to linux-kselftest next for my second update.
>> I saw a couple of merge problems with 4/7 patch even when I applied
>> it on top of with Tom's patch.
> 
> Oh, I might miss something.
> 
>>
>> I resolved them and amended the commit message to indicate the merge.
>> It is straight forward. Please check for sanity.
> 
> Yes, I confirmed that the merge looks good, and also test ran out
> without any error. :)
> 

Thanks for confirming. Pull request going out today.

thanks,
-- Shuah
