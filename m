Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983D527D773
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 22:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgI2UAr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Sep 2020 16:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgI2UAq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Sep 2020 16:00:46 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DABCC0613D1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Sep 2020 13:00:46 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id v20so6888344oiv.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Sep 2020 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AmCsi2BDdE0wC8EuTHmuUbDB6XL/3OtoUvlKfVp4OPQ=;
        b=JaM/LYlOqwadQ1GLoLRVv3Oj+9kSXFmsUfgwy1SU33RAhEzLUM/wZq0TfyxQVpePnP
         vpmwQYk+Bm0P5EKjiUf0Jqdxudmx3PqfQXArmHqgth4hxoAtdasEj0YvUB7ENFAI3u5f
         +bLmy9nILEhL2MBiJPYpYGRBg5QDgOdfkE1bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AmCsi2BDdE0wC8EuTHmuUbDB6XL/3OtoUvlKfVp4OPQ=;
        b=EkfLUfUvm73eWRmAZoOLffZgLF64Euywj8JRyoJmh2Ros9KeB+PaRqiT3MhylLB7Kn
         0Hqeq89ZAuhElBFDLH5cBb3Oprp417/OLQoz5DhlxLiLpFhkSA+xuU2vSksa3TR9AIAG
         16gW/gVjSNVyinvy+e2YOtr1iABaqelXAXTBtM/bIN00pwoeLJ5uL0FfRb3xqFg75rS4
         Nt6o0i1f569fl1dTWNLYdaSiboThHlNIRijW6m6bk7uFLmLEwZ1rV3jXG8p4SKmgdXHj
         go3cOgPcOMm/6F/EQs95nHmfIxTNVFn08yBA/dEykxFNMEcVELF0UofmBZNlW1ftj897
         pLXQ==
X-Gm-Message-State: AOAM530oUY6Ufvva7mxOoDN/JbuqPoe+MWozv2sgeJB8U38DMdCFpj5f
        eF7tuOgiAyPJVVgTuHX2qh35cg==
X-Google-Smtp-Source: ABdhPJyKOoPZmEuXMRYFPdazhGdDQVw44SgQKBs3AgX2hDMLBj6VIr7dd1knTEulo8aEXP6lB2hiUg==
X-Received: by 2002:aca:ab06:: with SMTP id u6mr3475700oie.84.1601409645845;
        Tue, 29 Sep 2020 13:00:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 126sm3124089oof.28.2020.09.29.13.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 13:00:45 -0700 (PDT)
Subject: Re: [PATCH 2/8] selftests/vm: use a common gup_test.h
To:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <64bb5ba7-77f7-2f09-44f0-29ee9329b183@linuxfoundation.org>
Date:   Tue, 29 Sep 2020 14:00:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929195356.GZ9916@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/29/20 1:53 PM, Jason Gunthorpe wrote:
> On Tue, Sep 29, 2020 at 12:48:43PM -0700, John Hubbard wrote:
>> On 9/29/20 12:08 PM, Jason Gunthorpe wrote:
>>> On Tue, Sep 29, 2020 at 11:59:55AM -0700, John Hubbard wrote:
>>>> On 9/29/20 10:55 AM, Jason Gunthorpe wrote:
>>>>> On Tue, Sep 29, 2020 at 10:44:31AM -0700, John Hubbard wrote:
>>>>>> On 9/29/20 9:35 AM, Jason Gunthorpe wrote:
>>>>>>> On Mon, Sep 28, 2020 at 01:10:24PM -0700, John Hubbard wrote:
>>>>>>>> On 9/28/20 5:57 AM, Jason Gunthorpe wrote:
>>>>>>>>> On Sun, Sep 27, 2020 at 11:21:53PM -0700, John Hubbard wrote:
>>>> ...
>>>>>> I don't see any "gcc -m" type of dependency generation pass happening
>>>>>> in this relatively simple Make system.
>>>>>
>>>>> It happens with -MD, all the deps are stored in files like mm/.init-mm.o.cmd
>>>>> and sucked into the build.
>>>>
>>>> You are thinking of kbuild. This is not kbuild. There are no such artifacts
>>>> being generated.
>>>
>>> Oh. Really? That's horrible.
>>>
>>
>> Well, yes, it's not a perfect build system down here in selftests/. Are you saying
>> that it is worth upgrading? I'm open to suggestions and ideas for improvements,
>> and at the moment, I have the miniature build system here mostly loaded into my
>> head. So for a brief shining moment I can probably understand it well enough to
>> work on it. :)
> 
> I only remarked because I didn't know it wasn't using kbuild. I
> thought it would have used the existing HOSTCC stuff, not sure why it
> is special.
> 
> The only investment that seems worthwhile would be to switch it to use
> the normal kbuild stuff??
> 

I explored switching to kbuild at the kernel summit last year during
my kselftest where are we talk.

There was push back from several developers. We can definitely explore
it as long as we can still support being able to build and run
individual subsystem tests and doesn't break workflow for developers.

If you are up for it, propose a patch and we can discuss it.

thanks,
-- Shuah

