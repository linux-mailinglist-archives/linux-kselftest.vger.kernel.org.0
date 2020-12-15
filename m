Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C892DB4AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Dec 2020 20:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgLOTx3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Dec 2020 14:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgLOTx2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Dec 2020 14:53:28 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F6CC0617A7
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 11:52:48 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id r9so21713269ioo.7
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 11:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YfQsmfSayLw6R8VzNs6qO72MJ4kq6ZC9UvyADxPXlEw=;
        b=MMEaV+dA7AusmEfJAHKgL5le68VNqcPr2F6wGpaYcelxqSeYWg9HsmcOdAQ8wATR3F
         rSLkW9yVw1SQiF3A/ayl/4OAwfPZHwB0iLSJQPvAdNrTJVkHKpRzEDm0M1YzSDpQsKtF
         7ixBG+KWK+tERgiMKe9nygNLK8uwcpFTCzDnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YfQsmfSayLw6R8VzNs6qO72MJ4kq6ZC9UvyADxPXlEw=;
        b=ESPUTkeh4ShItZQbtlUk9KPIpouSx5d7vP+sJfhoJMURp/hm0FG4YWPnH907x2MAwA
         yrR8TYYmJGtpbJbyteNN0yEJxesUrXbTWmBmDkX3YLJOZO5V0ZPPrAbawqAbyHachj1x
         th6c7qXh8VIXlUhvl1NXPtcl8iYs2fdkd4qIG6H2zQ+mc076N4IelkJzATZXLIiaUahg
         /PMyE8CUHFN3yUI7VprbcuVv4/nZ5B/s1HfiaQtqZQp/NBSLScse4dvfudvqMaDIczMF
         4rdIR30ZbhtRIVmnIXLXBWjvd68/wCxo1HvEd3ddtBq/p20epft8YQCqfIVW+iWPgIzO
         BSqA==
X-Gm-Message-State: AOAM533hwBB9TIxixYX1gHHy40TKFoz0CuXOX0GBpLLgqPDXN6ifHKzj
        GQroJ0kcNTYNO2rWg57voXoGng==
X-Google-Smtp-Source: ABdhPJwvNpZZ7hhLeNjk5odYSJEoN52laDWgLTfGfVHlXVrPvfPT/THfdCPlkMIi7tQhD+zQFm3EZA==
X-Received: by 2002:a6b:6f07:: with SMTP id k7mr4435645ioc.48.1608061967694;
        Tue, 15 Dec 2020 11:52:47 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z10sm11216140ioi.47.2020.12.15.11.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 11:52:46 -0800 (PST)
Subject: Re: related to fixing depreciated api
To:     Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <e479c654b6ca08057bf18a4e1c1d1ed3cdf8fdc8.camel@rajagiritech.edu.in>
 <291555f8-ed17-5ed6-8ca4-42c8d5e13be9@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <86388240-57df-977f-d0ac-47c2ed7df7a5@linuxfoundation.org>
Date:   Tue, 15 Dec 2020 12:52:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <291555f8-ed17-5ed6-8ca4-42c8d5e13be9@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/15/20 9:12 AM, Shuah Khan wrote:
> On 12/14/20 9:42 AM, Jeffrin Jose T wrote:
>> hello,
>>
>> i have worked on to  fix  depreciated api issue from
>> tools/testing/selftests/intel_pstate/aerf.c
>>
>> i met with the following error related...
>>
>> --------------x------------------x----------------->
>> $pwd
>> /home/jeffrin/UP/linux-kselftest/tools/testing/selftests/intel_pstate
>> $make
>> gcc  -Wall -D_GNU_SOURCE    aperf.c /home/jeffrin/UP/linux-
>> kselftest/tools/testing/selftests/kselftest_harness.h
>> /home/jeffrin/UP/linux-kselftest/tools/testing/selftests/kselftest.h -
>> lm -o /home/jeffrin/UP/linux-
>> kselftest/tools/testing/selftests/intel_pstate/aperf
>> aperf.c: In function ‘main’:
>> aperf.c:58:2: warning: ‘ftime’ is deprecated [-Wdeprecated-
>> declarations]
>>     58 |  ftime(&before);
>>        |  ^~~~~
>> In file included from aperf.c:9:
>> /usr/include/x86_64-linux-gnu/sys/timeb.h:39:12: note: declared here
>>     39 | extern int ftime (struct timeb *__timebuf)
>>        |            ^~~~~
>> aperf.c:67:2: warning: ‘ftime’ is deprecated [-Wdeprecated-
>> declarations]
>>     67 |  ftime(&after);
>>        |  ^~~~~
>> In file included from aperf.c:9:
>> /usr/include/x86_64-linux-gnu/sys/timeb.h:39:12: note: declared here
>>     39 | extern int ftime (struct timeb *__timebuf)
>>        |            ^~~~~
>> $
>> ----------------x---------------x---------------------->
>>
>>
>> from ftime manual  i found that it is depreciated...
>>
>> This  function is deprecated, and will be removed in a future version
>> of the GNU C library.  Use clock_gettime(2) instead.
>>
>>
>> now clock_gettime  gives  new data structure.
>>
>>   struct timespec {
>>                 time_t   tv_sec;        /* seconds */
>>                 long     tv_nsec;       /* nanoseconds */
>>             };
>>
>>
>> i worked on with the new data structure and some errors that came
>> along.
>> typical final output looks good but  values of runtime and typical
>> frequency
>> does not look normal during "sudo bash run.sh".
>>
>> output of "git diff" and  a  portion of output of   "sudo bash run.sh".
>> is attached.
>>
> 
> Please send a proper patch to fix intel_pstate to use clock_gettime.
> 

The fix for this is already in next - no need to send patch.

thanks,
-- Shuah

