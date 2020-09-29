Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B2527D7EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 22:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgI2UUR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Sep 2020 16:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2UUR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Sep 2020 16:20:17 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB01C061755
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Sep 2020 13:20:17 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x69so6923517oia.8
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Sep 2020 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wY55VXytWU5dCb+yWsv+Hifz95sQhPM0ZRLjoZrF/Ks=;
        b=BPLY8Xv4N6HnAC2bhuVuHqsZLkqCRc3/qbrl8KFAlCtq8Kx4wgRywyzRbbG4+67cnz
         7MPFNhrMkC2n4w3iaRpN03wj667JrqGXdCmrbRnqmqQbtDSx0PAMYXaCLv3Cb5UGGdQv
         eBY42MTMnDfHkjUH2avoe0cnVozJtma7NQnuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wY55VXytWU5dCb+yWsv+Hifz95sQhPM0ZRLjoZrF/Ks=;
        b=VfChdC1olBMqD0/K51spiWkqUp+RgJVMlELep9vzTtQG3vDa+BRzpxQtpnTraVqLl1
         +4LuuYMv8NLK41xOL2CfmzUxnOTe/h81WkbZLcXUkI3VZZNCMkQFKrO6/tFhgH6RWkXx
         YQYn3I2iqky1Nf1pp0BF2w9o1+J6qWbsugU/+GprN156wfKmGpewpve47s+nfQY8VOJp
         4VBMzzMiwWZVje297jDIJFipj3YPN8fo/L+3ItWimJK+fDKMKUops04y3gYsMuL9+gvT
         KGJGEUPSfEbG/WQj6eK51HVgt1b4c5h9GwzXaJK0kE/e/P+P6QrpM+GHqQu9vs3IwD0I
         3fXg==
X-Gm-Message-State: AOAM532eqejZ+m7k56Ckkx7IjzOzER+uKKrKbBZfW40We0IIpkTGGK5Y
        Yqh4/rjRrzfWRMKRCQT4UQParszwXT40bg==
X-Google-Smtp-Source: ABdhPJx2G75pZmtHUCD3k52jfMCL7SVqKa2890dy8PwYAsBGtG2hEWWaiVsDUDtlALJU/ySZWzcVKw==
X-Received: by 2002:aca:df84:: with SMTP id w126mr3834010oig.103.1601410816915;
        Tue, 29 Sep 2020 13:20:16 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 65sm1238278otj.75.2020.09.29.13.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 13:20:16 -0700 (PDT)
Subject: Re: [PATCH 2/8] selftests/vm: use a common gup_test.h
To:     John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-s390@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-3-jhubbard@nvidia.com>
 <20200928125739.GP9916@ziepe.ca>
 <6481e78f-c70d-133a-ff4a-325b5cd8fd5d@nvidia.com>
 <20200929163507.GV9916@ziepe.ca>
 <aab477bf-4353-5e6b-4cc9-9872c9376ed2@nvidia.com>
 <20200929175524.GX9916@ziepe.ca>
 <715c49ec-d2a8-45cb-8ace-c6b1b4b8f978@nvidia.com>
 <20200929190816.GY9916@ziepe.ca>
 <3022912c-f11b-f564-3a8a-f516ca259a37@nvidia.com>
 <20200929195356.GZ9916@ziepe.ca>
 <64bb5ba7-77f7-2f09-44f0-29ee9329b183@linuxfoundation.org>
 <554699c6-cc01-4c3c-3ed5-26d22ac3bac0@nvidia.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9372727e-1a79-913b-5391-e0c4a85bf5a7@linuxfoundation.org>
Date:   Tue, 29 Sep 2020 14:20:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <554699c6-cc01-4c3c-3ed5-26d22ac3bac0@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/29/20 2:11 PM, John Hubbard wrote:
> On 9/29/20 1:00 PM, Shuah Khan wrote:
>> On 9/29/20 1:53 PM, Jason Gunthorpe wrote:
>>> I only remarked because I didn't know it wasn't using kbuild. I
>>> thought it would have used the existing HOSTCC stuff, not sure why it
>>> is special.
>>>
>>> The only investment that seems worthwhile would be to switch it to use
>>> the normal kbuild stuff??
>>>
>>
>> I explored switching to kbuild at the kernel summit last year during
>> my kselftest where are we talk.
>>
>> There was push back from several developers. We can definitely explore
>> it as long as we can still support being able to build and run
>> individual subsystem tests and doesn't break workflow for developers.
>>
> 
> Do you have a link or two for that? Especially about the pushback, and
> conclusions reached, if any.
> 

Unfortunately no. A I recall it was workflow related issues and ease of
running individual subsystem tests and backwards compatibility with
stables.

Let's start a new discussion and see where we land.

thanks,
-- Shuah

