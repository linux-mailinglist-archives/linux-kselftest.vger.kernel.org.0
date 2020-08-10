Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A142411E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Aug 2020 22:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHJUsg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Aug 2020 16:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgHJUsg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Aug 2020 16:48:36 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D6FC061756
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 13:48:35 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id h3so10161719oie.11
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HCy6i5v2uQPcGgYPgbWpEYC90RU3lqb1roEUwPBfbUA=;
        b=fZW+MG/wCF4Bnlk4iWk+xw22uu4WXXDFRJQpuKQjSUmw9DPTF+y+coS9v4tFOfi6aI
         wHx8Nkrz9Hv1pV2ZxvuM6CGEH5kb52yV2Mcga8tbMKujSsXmve3xLmfiWmd3KWAuZ8x1
         IdkYIU/eB/zhAIDEnXzrQIbvMqfjK7dGCfgUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HCy6i5v2uQPcGgYPgbWpEYC90RU3lqb1roEUwPBfbUA=;
        b=I/PnKzq9Ev078atKLjKmv27N5YyEn+QGgDNbnEENgOAXQUB88utK1gjJwfOSBKYSBU
         fs4bkwkQqQQj7sskIWYGqpkNb9zc3FpJFB/UvNGgJuH+YPbbmnSpA91PuETul60lO4ut
         crLLc4Wp8rOjo1UIyjIyLVYPXyk/4lJb4dHDb84ZZux8Vc87fqVcsvsA0GJ3hqsbMLW0
         CjgCRGk6uDLCSLYaCaSCyNbWwN9uSZ+3tFGK4wFJwskyfbOotFDt3V/iuEWYZUjt++d2
         4qcc3pM2sPMfhHAf0bd5phkUUzWzKF3NQDdNwUKn6ktbperU4Mkrb58/F2HViYJbcAKx
         hXaA==
X-Gm-Message-State: AOAM531XwX1KJpoF/Wy5OWVWH+xieHgJV+35tiWDR0Boy9aeNn8fneLf
        IskEdLH6w//ZTkL8xvKhN/LraQ==
X-Google-Smtp-Source: ABdhPJy2B9YVgRyfunUoFHeDPYYOPWC97qorZyFNJmxDPPI3Bm5etCnyi2XAKhl+VMe2WO9nucQ5SQ==
X-Received: by 2002:aca:e144:: with SMTP id y65mr848801oig.101.1597092515295;
        Mon, 10 Aug 2020 13:48:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m8sm2190593oim.23.2020.08.10.13.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 13:48:34 -0700 (PDT)
Subject: Re: [PATCHv3] selftests/timers: Turn off timeout setting
To:     John Stultz <john.stultz@linaro.org>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, joe.lawrence@redhat.com,
        lkml <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200318024215.5270-1-po-hsu.lin@canonical.com>
 <CALAqxLVyjj23S2Wm2XFAvCJph58_rVb4iteq3TFC14jYR_88Gw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0c635a95-0762-9026-edba-bcbf4835f42f@linuxfoundation.org>
Date:   Mon, 10 Aug 2020 14:48:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLVyjj23S2Wm2XFAvCJph58_rVb4iteq3TFC14jYR_88Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/4/20 3:38 PM, John Stultz wrote:
> On Tue, Mar 17, 2020 at 7:42 PM Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
>>
>> The following 4 tests in timers can take longer than the default 45
>> seconds that added in commit 852c8cbf34d3 ("selftests/kselftest/runner.sh:
>> Add 45 second timeout per test") to run:
>>    * nsleep-lat - 2m7.350s
>>    * set-timer-lat - 2m0.66s
>>    * inconsistency-check - 1m45.074s
>>    * raw_skew - 2m0.013s
>>
>> Thus they will be marked as failed with the current 45s setting:
>>    not ok 3 selftests: timers: nsleep-lat # TIMEOUT
>>    not ok 4 selftests: timers: set-timer-lat # TIMEOUT
>>    not ok 6 selftests: timers: inconsistency-check # TIMEOUT
>>    not ok 7 selftests: timers: raw_skew # TIMEOUT
>>
>> Disable the timeout setting for timers can make these tests finish
>> properly:
>>    ok 3 selftests: timers: nsleep-lat
>>    ok 4 selftests: timers: set-timer-lat
>>    ok 6 selftests: timers: inconsistency-check
>>    ok 7 selftests: timers: raw_skew
>>
>> https://bugs.launchpad.net/bugs/1864626
>> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
>> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>> ---
>>   tools/testing/selftests/timers/Makefile | 1 +
>>   tools/testing/selftests/timers/settings | 1 +
>>   2 files changed, 2 insertions(+)
>>   create mode 100644 tools/testing/selftests/timers/settings
>>
>> diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
>> index 7656c7c..0e73a16 100644
>> --- a/tools/testing/selftests/timers/Makefile
>> +++ b/tools/testing/selftests/timers/Makefile
>> @@ -13,6 +13,7 @@ DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
>>
>>   TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS)
>>
>> +TEST_FILES := settings
>>
>>   include ../lib.mk
>>
>> diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
>> new file mode 100644
>> index 0000000..e7b9417
>> --- /dev/null
>> +++ b/tools/testing/selftests/timers/settings
>> @@ -0,0 +1 @@
>> +timeout=0
>> --
> 
> Apologies for missing this before.  I've not tested with this, but it
> sounds sane to me. A number of the timekeeping tests do take a while
> to run.
> 
> Acked-by: John Stultz <john.stultz@linaro.org>
> 

Thanks. I will get this in for 5.9-rc2 fixes update.

thanks,
-- Shuah

