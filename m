Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8259DDBA5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 01:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441850AbfJQX7Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 19:59:16 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:35497 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbfJQX7Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 19:59:16 -0400
Received: by mail-io1-f50.google.com with SMTP id t18so1171532iog.2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2019 16:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n68VTQNC8v2GWdF9aNbeWEV+391ytDDLOJo8jsaK55U=;
        b=FDy6dalQYyXQ2LxUmG9wbtw5osTMTbxQVG4j6cbs0NcYZD4ytzNVA6UvceEd/KKEuR
         UiJPPsLJUyC0jRZSsqH3Mj2iulBbUHUEQ5wIurjcXNSrVFdKQs9rfcd4Zo5gESnHRkMf
         33AZKeTMhtJ96tWSqM8K1qfbNFgddCElbU8As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n68VTQNC8v2GWdF9aNbeWEV+391ytDDLOJo8jsaK55U=;
        b=Ed3PbqEI1niKEg7BLgDxAinnRZ7U9yrhsPfL0KNALRCtq3/0bxJIhFo1BK8FyFRehF
         LXa32E2bFCXO+SD0Hc1pzKQaYj3+swCx8mhEPQE94nc9rKiQMtOrN1MvTZCy6l/WDEhJ
         duwUcnr5CbvdCUgYoVtMpvHzBNQDKTPTgDh5IH6grOcYigUmb8G9rjSlSbq5TEi1+gpZ
         lJJyy07y9oAJVYugJ/7Tssz8mDHwJpdp9Tw4cHlLh2Ng9wU3xAcx/nXpjsd8ZzZG7rBE
         rQh/Qz3LQSE7BjFa2c5v01A86RrwWZRVq0WpsSE8cHE1mwov8VJSj6jyypbJCxScYUbx
         xkAQ==
X-Gm-Message-State: APjAAAVmTe7egYN/swz3fZun7dsktTvrtY94PTYuPScLb14J+MshRhwz
        oik01dWakwhDq5IvQiWC/GeOQw==
X-Google-Smtp-Source: APXvYqxm71bjPQGA+C6RQHjg0XSjGVpYzYAXapOAeU21xKiI0W9WjEeGbAgcnfGQfdcD10NLVm0EDA==
X-Received: by 2002:a6b:e008:: with SMTP id z8mr5685029iog.273.1571356754189;
        Thu, 17 Oct 2019 16:59:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i13sm211459iom.54.2019.10.17.16.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 16:59:13 -0700 (PDT)
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     Tim.Bird@sony.com, yzaikin@google.com
Cc:     tytso@mit.edu, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, kunit-dev@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20191010023931.230475-1-yzaikin@google.com>
 <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu>
 <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu>
 <957434b6-32cc-487f-f48e-f9c4416b3f60@linuxfoundation.org>
 <CAAXuY3r7Eu+o-td8MRvexGYmONPgd8FvHr+7mF84Q4ni1G3URg@mail.gmail.com>
 <40073fc9-1de1-9253-e2f9-9cf9ee4308d4@linuxfoundation.org>
 <CAAXuY3r7QKSuwVYDQhF8-zC75ZRVHr+4pzpGXeNbPaEdbM3h4Q@mail.gmail.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977D00C3@USCULXMSG01.am.sony.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <00f59a2f-6dd5-f972-47b4-28e5c996c2a5@linuxfoundation.org>
Date:   Thu, 17 Oct 2019 17:59:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977D00C3@USCULXMSG01.am.sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/17/19 5:54 PM, Tim.Bird@sony.com wrote:
> 
> 
>> -----Original Message-----
>> From: Iurii Zaikin
>>
>>> You can do all of this and allow users to supply another set of data.
>>> It doesn't gave to be one or the other.
>>>
>> What is the use case for running a unit test on a different data set than
>> what it comes with?
> 
> I just gave some ideas in another message (our emails crossed),
> but one use case is to allow someone besides the test author
> to inject additional data points, and to do so without having to re-compile
> the code.
> 

Right. Test author might not think about all the possible ways to
test.

> They might do this for multiple reasons:
>   - to experiment with additional data points
>   - to try to diagnose a problem they are seeing
>   - to fill gaps they see in existing data points
> 

Thanks for explaining the scenarios.

> Whether this makes sense depends on a lot of factors.  I suspect
> the timestamp test code is not a good candidate for this, as the code
> is simple enough that adding a new test case is pretty trivial.  For some
> other types of tests, adding the data via an external file could be easier
> than changing the code of the test.

I agree. Even if author thinks of all the different ways (I am convinced
of that), still taking test data at run-time makes the unit test just
more effective.

thanks,
-- Shuah
