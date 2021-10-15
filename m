Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4612A42F802
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Oct 2021 18:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241237AbhJOQXX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Oct 2021 12:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241242AbhJOQXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Oct 2021 12:23:23 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6A7C061762
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Oct 2021 09:21:16 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id g2so7749187ild.1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Oct 2021 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JD9eIQfx7k1D8AJiGxSA/qZszLEf/lWq41JF0CGsHnc=;
        b=XBh1AYl6Z1r4p3gWQhOZBe5NmXRrZGPEePuvl1tkLItP8ogdeT1JIHMv6J4ypbgcB5
         SpKBPFTbKmlpu8KZRAJXN0/eBAdrR92Q14CbuM9gYgnsPa701hcPCUilhIh6AmhDrMdf
         m7aJrxLjtnmsm7JDM1+ZMXRnWdKcQPHkEn+OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JD9eIQfx7k1D8AJiGxSA/qZszLEf/lWq41JF0CGsHnc=;
        b=ZJm5x3IPZkYIulOvQin8uPOi7hqy99qGH8Y92yyh4eChKxjZvJacUVJG4G4tTZsxIR
         z7pai/DElSQNifeNEHWH8JqLwUvcOBBWUjm7C8pTdxDU8WPi/Tiy49ufT2+vLURUyBFf
         YH0MI2HOxGabMdAWmIsHRf3HqG1MJuhlB8OPyTMALT3MZc8B0g3zDIbm+lp6Rhw6H2a7
         eWLyXR3B4890slBVK5yrlnMvdBewexTOZuhZ8w04JVHtb34D0vAOdSZNf1LowzKeISYr
         PMvzPExJlgmg7hja11wEo3Ep4C+ssPxVpFzvYkRLmqsAleF/53lW/409bq7Yz3WdK3Nu
         yadA==
X-Gm-Message-State: AOAM532WvZUFVYH2TU5ndSsQm5wr1QIh+FIe7DG8lif/BTqsgLZ7d4oe
        rbtzxiggOGUVqCMzeNH/84H3eQ==
X-Google-Smtp-Source: ABdhPJwX1ojNcYex5/wXmXGz7SNMba+HK97Dowg2RYga2Ky0fGP18JVri/P5mvjGcE+ZRSkjBJGZig==
X-Received: by 2002:a92:c262:: with SMTP id h2mr4633246ild.204.1634314876039;
        Fri, 15 Oct 2021 09:21:16 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v17sm2968857ilh.67.2021.10.15.09.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 09:21:15 -0700 (PDT)
Subject: Re: selftests/vm madv_populate.c test
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <b703a326-66f7-bf35-58ee-f60e504ea5ef@linuxfoundation.org>
 <0a20f6b6-5985-8b3e-a577-7495dcf7d2b8@redhat.com>
 <3a06d58e-7301-6fbc-a305-d9f7c7220843@linuxfoundation.org>
 <b99b5960-b1ec-b968-1d9c-d125a23c59fe@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1be8c9d5-da76-9c92-01a4-b11a08edd88e@linuxfoundation.org>
Date:   Fri, 15 Oct 2021 10:21:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b99b5960-b1ec-b968-1d9c-d125a23c59fe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/15/21 9:47 AM, David Hildenbrand wrote:
> On 15.10.21 17:45, Shuah Khan wrote:
>> On 9/18/21 1:41 AM, David Hildenbrand wrote:
>>> On 18.09.21 00:45, Shuah Khan wrote:
>>>> Hi David,
>>>>
>>>> I am running into the following warning when try to build this test:
>>>>
>>>> madv_populate.c:334:2: warning: #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition" [-Wcpp]
>>>>      334 | #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>>          |  ^~~~~~~
>>>>
>>>>
>>>> I see that the following handling is in place. However there is no
>>>> other information to explain why the check is necessary.
>>>>
>>>> #if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
>>>>
>>>> #else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
>>>>
>>>> #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>>
>>>> I do see these defined in:
>>>>
>>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_READ       22
>>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_WRITE      23
>>>>
>>>> Is this the case of missing include from madv_populate.c?
>>>
>>> Hi Shuan,
>>>
>>> note that we're including "#include <sys/mman.h>", which in my
>>> understanding maps to the version installed on your system instead
>>> of the one in our build environment.ing.
>>>
>>> So as soon as you have a proper kernel + the proper headers installed
>>> and try to build, it would pick up MADV_POPULATE_READ and
>>> MADV_POPULATE_WRITE from the updated headers. That makes sense: you
>>> annot run any MADV_POPULATE_READ/MADV_POPULATE_WRITE tests on a kernel
>>> that doesn't support it.
>>>
>>> See vm/userfaultfd.c where we do something similar.
>>>
>>
>> Kselftest is for testing the kernel with kernel headers. That is the
>> reason why there is the dependency on header install.
>>
>>>
>>> As soon as we have a proper environment, it seems to work just fine:
>>>
>>> Linux vm-0 5.15.0-0.rc1.20210915git3ca706c189db.13.fc36.x86_64 #1 SMP Thu Sep 16 11:32:54 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>> [root@vm-0 linux]# cat /etc/redhat-release
>>> Fedora release 36 (Rawhide)
>>
>> This is a distro release. We don't want to have dependency on headers
>> from the distro to run selftests. Hope this makes sense.
>>
>> I still see this on my test system running Linux 5.15-rc5.
> 
> Did you also install Linux headers? I assume no, correct?
> 

I don't install it on my test system. Kselftest build does header install
in the source tree to compile tests with the headers so that the changes
to tests and new tests can be compiled with the kernel changes that might
include kernel header changes.

when I run "make kselftest-all TARGETS=vm", I see the following: (this
is on linux-next-20211012,

tools/testing/selftests/vm/madv_populate
madv_populate.c:334:2: warning: #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition" [-Wcpp]
   334 | #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
       |  ^~~~~~~

thanks,
-- Shuah
