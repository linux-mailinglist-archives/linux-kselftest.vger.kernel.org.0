Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75AB2AE16B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Nov 2020 22:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbgKJVPM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 16:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJVPL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 16:15:11 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF57C0613D1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 13:15:11 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id k1so13577813ilc.10
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 13:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FyJcX8tuTRBjO3rcOlF9C8SVDakfLW/Gn4/m5FionXk=;
        b=RTgnHvY3AtUNmbIjfjQegTYUEd4VOVnFM5I5WTM62TIquoK9bnS0C4eayOJ84siOLO
         xLl+RoP/JchNPZ7V3Ekhp7/9bo30wXrjeKL4+ICUom51YwpPOkwmVwuxi+zvTVvVw72n
         QbNcQyYIEsCnDud7gAUx+fcUpmxUTzxy56oJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FyJcX8tuTRBjO3rcOlF9C8SVDakfLW/Gn4/m5FionXk=;
        b=gn58hVnmcaSv3z+FH2QPic3kUEwufx1iyH14x175oTswNmE3aBZkbnKkw1b2XOKhYh
         D+K70f0yB4Pq03Pv1g7+MuJ51M1M3NmKaOFcw0BuY+cwuY4d6XFyPy/8g78olgSs5a/3
         iKZg7ZHi6ymbnwP/xQ9dxptDgI5D8wm8XqafiiAAFpgE1N1EAbQos8cCNA1NiidhnL9L
         YKuo5Myjr5CcTA3TRdT4YV8wPbNE1WCL/v8ZixMC5TUZO6ePiHhDrjYUWMUSBaEHotXg
         QEFn+TIz8lGuu5W9LLsJxjkqk1gcknKqrS2ecxKd4H7Y8D87+GLNvzjb6MBJUzAAf+jS
         BSZA==
X-Gm-Message-State: AOAM532kf9KZnmjYVG1NXkRs554ynp7sd++Fynb2VbV++OXc189u68/l
        cR9kGd+9FX7bnC7cAgyvXKzUfA==
X-Google-Smtp-Source: ABdhPJw/AYesDyS2vIplIH52GDtIOJ3GDfDYbRRH2SIUYVijIdmY/8N91fW4Cyc8gVpuqZGjOW16Wg==
X-Received: by 2002:a92:7914:: with SMTP id u20mr15863178ilc.203.1605042911037;
        Tue, 10 Nov 2020 13:15:11 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i3sm66652iom.8.2020.11.10.13.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 13:15:10 -0800 (PST)
Subject: Re: [PATCH v2 3/3] kunit: Introduce get_file_path() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     SeongJae Park <sjpark@amazon.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        SeongJae Park <sjpark@amazon.de>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201026165927.19020-3-andriy.shevchenko@linux.intel.com>
 <20201028092915.8053-1-sjpark@amazon.com>
 <20201103112512.GZ4077@smile.fi.intel.com>
 <CAFd5g44dLoUwfNPsMqavU_KrJ5+xoLgKT0Ec2_-pxVYxjMHiWA@mail.gmail.com>
 <20201105172855.GB4077@smile.fi.intel.com>
 <f3c2de52-5955-6392-6b10-edb4dc4cf231@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3d481d6b-c7aa-303b-841a-111aebd55a8e@linuxfoundation.org>
Date:   Tue, 10 Nov 2020 14:15:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <f3c2de52-5955-6392-6b10-edb4dc4cf231@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/5/20 10:56 AM, Shuah Khan wrote:
> On 11/5/20 10:28 AM, Andy Shevchenko wrote:
>> On Thu, Nov 05, 2020 at 08:35:16AM -0800, Brendan Higgins wrote:
>>> On Tue, Nov 3, 2020 at 3:24 AM Andy Shevchenko
>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>> On Wed, Oct 28, 2020 at 10:29:15AM +0100, SeongJae Park wrote:
>>>>> On Mon, 26 Oct 2020 18:59:27 +0200 Andy Shevchenko 
>>>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>>
>>>>>> Helper allows to derive file names depending on --build_dir argument.
>>>>>>
>>>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>>>>>> Tested-by: Brendan Higgins <brendanhiggins@google.com>
>>>>>
>>>>> Reviewed-by: SeongJae Park <sjpark@amazon.de>
>>>>
>>>> Thanks!
>>>>
>>>> Brendan, Shuah, can we get this series applied, please?
>>>
>>> I'm not actually sure that this qualifies as a fix. I certainly don't
>>> mind if this goes in 5.10, in fact, I would prefer it.
>>>

3/3 will go into 5.11.

>>> In any case, I added it to Shuah's queue. I will leave it up to Shuah
>>> whether it goes in as a fix in 5.10, or needs to wait for the next
>>> merge window.
>>
>> I'm fine with either. My solely concern is that I would like to get 
>> this moved
>> forward somehow.
>>
> 
> Once the kunit pull request for rc3 clears, I will look at these and
> make a call. This patch series finalized during the merge window,
> hence you are going to see some delays. If it doesn't make the cut
> for fixes, it will go into 5.11
> 

Applied 1/3 and 2/3 to

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/ 
kuni-fixes branch.

I will send them up in my next pull request, probably rc5.

thanks,
-- Shuah

