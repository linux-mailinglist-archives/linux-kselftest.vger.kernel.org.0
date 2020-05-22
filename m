Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC3F1DF1D7
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 May 2020 00:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbgEVWaM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 18:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731029AbgEVWaM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 18:30:12 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1E282100A;
        Fri, 22 May 2020 22:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590186611;
        bh=eXM3PcUa8Z6NYOXnYGqP85DPJkxxQ0kZ1AmFc6ApY+U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=squkeIozChxV0J8tB12vRoXPp0siq+uCkLE+1A5HZ3ttOPgaKrkhPa9c6ldtUqyH4
         AFPtN6w/gbBblWVEymuAnIDadQI+PEF1ZKiB/MxZTat5cK/jAu+vx6suAjdRXNWbnq
         qBWGT0YXTY++uFXq7SJIlhmnz94M8ob9CZzUCkU8=
Subject: Re: [PATCH v7 0/5] KUnit-KASAN Integration
To:     Alan Maguire <alan.maguire@oracle.com>,
        David Gow <davidgow@google.com>, brendanhiggins@google.com
Cc:     trishalfonso@google.com, aryabinin@virtuozzo.com,
        dvyukov@google.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20200424061342.212535-1-davidgow@google.com>
 <alpine.LRH.2.21.2005031101130.20090@localhost>
From:   shuah <shuah@kernel.org>
Message-ID: <26d96fb9-392b-3b20-b689-7bc2c6819e7b@kernel.org>
Date:   Fri, 22 May 2020 16:30:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2005031101130.20090@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/3/20 4:09 AM, Alan Maguire wrote:
> On Thu, 23 Apr 2020, David Gow wrote:
> 
>> This patchset contains everything needed to integrate KASAN and KUnit.
>>
>> KUnit will be able to:
>> (1) Fail tests when an unexpected KASAN error occurs
>> (2) Pass tests when an expected KASAN error occurs
>>
>> Convert KASAN tests to KUnit with the exception of copy_user_test
>> because KUnit is unable to test those.
>>
>> Add documentation on how to run the KASAN tests with KUnit and what to
>> expect when running these tests.
>>
>> This patchset depends on:
>> - "[PATCH v3 kunit-next 0/2] kunit: extend kunit resources API" [1]
>> - "[PATCH v3 0/3] Fix some incompatibilites between KASAN and
>>    FORTIFY_SOURCE" [2]
>>
>> Changes from v6:
>>   - Rebased on top of kselftest/kunit
>>   - Rebased on top of Daniel Axtens' fix for FORTIFY_SOURCE
>>     incompatibilites [2]
>>   - Removed a redundant report_enabled() check.
>>   - Fixed some places with out of date Kconfig names in the
>>     documentation.
>>
> 
> Sorry for the delay in getting to this; I retested the
> series with the above patchsets pre-applied; all looks
> good now, thanks!  Looks like Daniel's patchset has a v4
> so I'm not sure if that will have implications for applying
> your changes on top of it (haven't tested it yet myself).
> 
> For the series feel free to add
> 
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> 
> I'll try and take some time to review v7 shortly, but I wanted
> to confirm the issues I saw went away first in case you're
> blocked.  The only remaining issue I see is that we'd need the
> named resource patchset to land first; it would be good
> to ensure the API it provides is solid so you won't need to
> respin.
> 
> Thanks!
> 
> Alan
>   
>> Changes from v5:
>>   - Split out the panic_on_warn changes to a separate patch.
>>   - Fix documentation to fewer to the new Kconfig names.
>>   - Fix some changes which were in the wrong patch.
>>   - Rebase on top of kselftest/kunit (currently identical to 5.7-rc1)
>>
>

Hi Brendan,

Is this series ready to go inot Linux 5.8-rc1? Let me know.
Probably needs rebase on top of kselftest/kunit. I applied
patches from David and Vitor

thanks,
-- Shuah


