Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818062A8565
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Nov 2020 18:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgKER4i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 12:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKER4i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 12:56:38 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84532C0613CF
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Nov 2020 09:56:36 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id j12so2717124iow.0
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Nov 2020 09:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gVh7YY/0K/z+uWMXSo/b8D+4KW0g/YiOggYRfYqJqyw=;
        b=L8aS5cL9KWxAE8Q+w1ft94QnSLHq8Aana7wRQ9xzjXKwjO1KFV22l0KYqvT6br1vzi
         Wqb4wPtnz8KntyzIxb0yq3bG/Ul66Zj0NhAgOGc9w2/Qj+Zs+qw9bQ+xC44f+wAPAetM
         EMETu/nK7Is2Yfo5s77zOuGvMqcZ2SH24MLzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gVh7YY/0K/z+uWMXSo/b8D+4KW0g/YiOggYRfYqJqyw=;
        b=pi/85ja+VzhGvRthClubFq/SSwIUDlcO4CAbHF8HeqAB18Lrtjqf/15H2xUwTXTuGH
         VdTtyT+AxFIdJljRhC6Jx6s3eIbtwU0h7G3MJZWZXfVMMqOBtZtwRcvUem9W+JkvVw4h
         aCbbWFpLsBIkoc1OesDMTQT1wJvfQ5yoGilSAeMYnjrXNFrvKOvzBFsCcsLodOZpZAHl
         beeuCdAjRIHPaQfb2m7zXReg1b+CbKye3UEh8pcQGp3UK88rFVKbU/dbNk5u4xTIDs/A
         2/Emfa5clEEhnyY/+h2sW07ft/U1A0X02bKj0kv7Po/RLdKm8wcjDidhgmu6NEc597gX
         0QTw==
X-Gm-Message-State: AOAM531dNRr3h8K6pw1sMtCMUe4PB5cAbg2+/PIEVUV87pDmED0iTFTX
        1kSEVpzH/sN7iyDffM9gz323iA==
X-Google-Smtp-Source: ABdhPJyCGLlqG1LHcdqWoWAE1u8lklFPjlXGXgu4QnKnnWV5X6pH6E+UDLEUJe0utYlv996jTb5sCA==
X-Received: by 2002:a02:c547:: with SMTP id g7mr2895479jaj.88.1604598995928;
        Thu, 05 Nov 2020 09:56:35 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r3sm1369183iog.55.2020.11.05.09.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 09:56:35 -0800 (PST)
Subject: Re: [PATCH v2 3/3] kunit: Introduce get_file_path() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     SeongJae Park <sjpark@amazon.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        SeongJae Park <sjpark@amazon.de>, skhan@linuxfoundation.org
References: <20201026165927.19020-3-andriy.shevchenko@linux.intel.com>
 <20201028092915.8053-1-sjpark@amazon.com>
 <20201103112512.GZ4077@smile.fi.intel.com>
 <CAFd5g44dLoUwfNPsMqavU_KrJ5+xoLgKT0Ec2_-pxVYxjMHiWA@mail.gmail.com>
 <20201105172855.GB4077@smile.fi.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f3c2de52-5955-6392-6b10-edb4dc4cf231@linuxfoundation.org>
Date:   Thu, 5 Nov 2020 10:56:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201105172855.GB4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/5/20 10:28 AM, Andy Shevchenko wrote:
> On Thu, Nov 05, 2020 at 08:35:16AM -0800, Brendan Higgins wrote:
>> On Tue, Nov 3, 2020 at 3:24 AM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>> On Wed, Oct 28, 2020 at 10:29:15AM +0100, SeongJae Park wrote:
>>>> On Mon, 26 Oct 2020 18:59:27 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>>>
>>>>> Helper allows to derive file names depending on --build_dir argument.
>>>>>
>>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>>>>> Tested-by: Brendan Higgins <brendanhiggins@google.com>
>>>>
>>>> Reviewed-by: SeongJae Park <sjpark@amazon.de>
>>>
>>> Thanks!
>>>
>>> Brendan, Shuah, can we get this series applied, please?
>>
>> I'm not actually sure that this qualifies as a fix. I certainly don't
>> mind if this goes in 5.10, in fact, I would prefer it.
>>
>> In any case, I added it to Shuah's queue. I will leave it up to Shuah
>> whether it goes in as a fix in 5.10, or needs to wait for the next
>> merge window.
> 
> I'm fine with either. My solely concern is that I would like to get this moved
> forward somehow.
> 

Once the kunit pull request for rc3 clears, I will look at these and
make a call. This patch series finalized during the merge window,
hence you are going to see some delays. If it doesn't make the cut
for fixes, it will go into 5.11

thanks,
-- Shuah
