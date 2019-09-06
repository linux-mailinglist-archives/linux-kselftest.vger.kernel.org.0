Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0830AABD50
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2019 18:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391061AbfIFQIc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Sep 2019 12:08:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35604 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfIFQIc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Sep 2019 12:08:32 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so13195788ion.2
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2019 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8J350dN8/M6cK0y+Ad2uk2NCojbGNvCKnyVt3HjFMFM=;
        b=Bp7xECazcgvuielhCk9NpeivTZ88aSRr3td1uSX/4ZYRvMsgz52UXNH+r8AzBGw5ri
         gbsWvYOirWDOPlapvKitQGzxuwlJ2CNGfftUmjUY1Mr963hhQhW1qRyfz/CCR3iapS9i
         G067oubFpJll5RIqNkLSbccj0Ri2JIfgu6Ik0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8J350dN8/M6cK0y+Ad2uk2NCojbGNvCKnyVt3HjFMFM=;
        b=RWKFoBVhBQ4TfuQk9ww5uUsQktU26zVYke9CoFMrkrfsRRzeAq7/KGHW8qrwCuv7oI
         LPcyLjzmb74e78puwOCcR3EMhuO/9a6wdjiUoqPqsmcaPXKR3qtHe+zfF3Z/hwL+A6O/
         0Sy4xR9v4emwD0c7WFXYfL12FhIi4f3nbBU+/0Y+ika78gekG4Pw3weTqm81pM1nm340
         yknrmJf6uZHBwFPTUgFLhh2nSpvI9s3Xbm1FFpokAtSbeb76pmrqu4pXmtCQdJzFKv9V
         c0tJ0p9gLv2MyPSZgzXCdrJT4iyPu9uLilFqXnVfbroOqozNP+GjnSHbpLRTaBE2SkA8
         I3uA==
X-Gm-Message-State: APjAAAV+M8Gg294Hp3PY2+wKZ3J3L/FNjvyt3CVdqOE/vlJ6Q7qeirKx
        QuGDslxv8r82FgWpVeKd+2HIaA==
X-Google-Smtp-Source: APXvYqz0XnW7wcQLDNwsPZK+Sg5pamQWd1BBeXHmIYvXm+MFCbLgq97VuRuVQ+IHTATRY3wQ3JO+DQ==
X-Received: by 2002:a6b:761a:: with SMTP id g26mr11382863iom.71.1567786111002;
        Fri, 06 Sep 2019 09:08:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l186sm11163832ioa.54.2019.09.06.09.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 09:08:30 -0700 (PDT)
Subject: Re: [PATCH] kunit: add PRINTK dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20190906152800.1662489-1-arnd@arndb.de>
 <5dfe1bfc-0236-25cf-756b-ce05f7110136@linuxfoundation.org>
 <CAK8P3a3ynubySZ3A5M7D__B6R+caMjys=v+GVjqA78rppOJQQQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <67f4fe26-7d6a-68f2-dc45-af358be590df@linuxfoundation.org>
Date:   Fri, 6 Sep 2019 10:08:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3ynubySZ3A5M7D__B6R+caMjys=v+GVjqA78rppOJQQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/6/19 10:02 AM, Arnd Bergmann wrote:
> On Fri, Sep 6, 2019 at 5:39 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>>>    config KUNIT
>>>        bool "Enable support for unit tests (KUnit)"
>>> +     depends on PRINTK
>>>        help
>>>          Enables support for kernel unit tests (KUnit), a lightweight unit
>>>          testing and mocking framework for the Linux kernel. These tests are
>>>
>>
>> Hi Arnd,
>>
>> This is found and fixed already. I am just about to apply Berndan's
>> patch that fixes this dependency. All of this vprintk_emit() stuff
>> is redone.
> 
> Ok, perfect. Unfortunately I only started testing the coming
> linux-next release after Stephen went on his break, so
> I'm missing some updates.
> 

No worries. I am pushing it now - should be there in 5-10 mins.

Please use linuxk-kselftest next.

Let me know if you see any issues. Thanks for testing it.

thanks,
-- Shuah

