Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939C2752B0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGMTdx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 15:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjGMTdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 15:33:52 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9E22D69
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 12:33:50 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-785d3a53ed6so13470139f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 12:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689276829; x=1689881629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rsorryzax5Y3bPybZVINyEhtRW0LniXcZ10eoX/oXNs=;
        b=Wlpj5dG+wbmOlRt78R8ZsYTt2KGnZ4b+1ZOW35Cnu+YaI36KwgaNBwZq/4kFw1dhdQ
         c+Xj5t1BxQ/tOspHvzpnxbPQD6zDQhf9B6CXvLY7+Vns7yx4OPsE3xI6soIw5ndMa20s
         5DywhV7tv+AgZA6ox08cHS7T72Qn+231KUHbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689276829; x=1689881629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rsorryzax5Y3bPybZVINyEhtRW0LniXcZ10eoX/oXNs=;
        b=QwlxfKFGW7MGnxUAah4A8Hp6InLDWdVvigf8OlMLVwY4PbMDg9UbcC8fHTvfHGhOcY
         TxUYpPZCxxUlVPlO5JEBOz87ytd92xRG9eV8upVE1KunrP7jcdVmUmSM+4y/Xox+mhxE
         nDYLldxEWVK8ag6iNoYIzV8o6JXhrzQ/qhEEMD9lX/jo7GbHIpR82m1B8+MzFG+0j5uQ
         5z+gzxrY+3D4/tx/iHT80d2qm+4iCZgTJP0MucNpEJDpDufQF3ovM/+AnoxLjoTs2c0X
         9RvrlEtm2vsla4gmtYYGgdG1VDDb+UzAWM4wBB8nXR01MZgl/FxnSsshc2Yxpvs4GuSq
         /vtA==
X-Gm-Message-State: ABy/qLYcRWa2RA35mqlKk5CHosjMjWIC/84dkfFVfCp1GtOM+n59PPG8
        IMykFkgNd08v1vss+LlAjeXfsA==
X-Google-Smtp-Source: APBJJlF5ir59Htegev7n15uRcZGB7HP4joLeV0hONmJbPeJboQCeMjzwvL0ILaGM0qlVRJvOCi9GkQ==
X-Received: by 2002:a05:6602:2762:b0:780:d65c:d78f with SMTP id l2-20020a056602276200b00780d65cd78fmr2869824ioe.2.1689276829390;
        Thu, 13 Jul 2023 12:33:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h8-20020a02c4c8000000b0042b761d2594sm2103883jaj.125.2023.07.13.12.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 12:33:49 -0700 (PDT)
Message-ID: <f17f5330-9b8f-81a2-508f-8cc25c355590@linuxfoundation.org>
Date:   Thu, 13 Jul 2023 13:33:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] tools: timers: fix freq average calculation
Content-Language: en-US
To:     John Stultz <jstultz@google.com>, Minjie Du <duminjie@vivo.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "open list:TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER" 
        <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, opensource.kernel@vivo.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230706032257.1662-1-duminjie@vivo.com>
 <CANDhNCoJ2ZjGCY3yZ3K4XZF8-bNTExOUWNkqWtJ2FZW=bYFwzw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANDhNCoJ2ZjGCY3yZ3K4XZF8-bNTExOUWNkqWtJ2FZW=bYFwzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/5/23 21:46, John Stultz wrote:
> On Wed, Jul 5, 2023 at 8:23 PM Minjie Du <duminjie@vivo.com> wrote:
>>
>> Delete a duplicate assignment from this function implementation.
>> The note means ppm is average of the two actual freq samples.
>> But ppm have a duplicate assignment.
>>
>> Signed-off-by: Minjie Du <duminjie@vivo.com>
>> ---
>>   tools/testing/selftests/timers/raw_skew.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
>> index 5beceeed0..6eba203f9 100644
>> --- a/tools/testing/selftests/timers/raw_skew.c
>> +++ b/tools/testing/selftests/timers/raw_skew.c
>> @@ -129,8 +129,7 @@ int main(int argc, char **argv)
>>          printf("%lld.%i(est)", eppm/1000, abs((int)(eppm%1000)));
>>
>>          /* Avg the two actual freq samples adjtimex gave us */
>> -       ppm = (tx1.freq + tx2.freq) * 1000 / 2;
>> -       ppm = (long long)tx1.freq * 1000;
>> +       ppm = (long long)(tx1.freq + tx2.freq) * 1000 / 2;
> 
> Huh. So yeah, I looked back in my own history and this has been there
> forever. I'm guessing I was intending to average the two samples and
> then due to reasons I can't remember decided to just use the first in
> the short-term for some debugging (with the second assignment) and
> committed both.
> 
> I think it should be safe, because if the freq values are not the same
> the test will return SKIP, so it's unlikely changing this would cause
> new test failures.
> 
> Acked-by: John Stultz <jstultz@google.com>
> 
> Thanks for noticing this and sending this out!
> -john

Applied to linux-kselftest fixes branch for next rc2 or rc3

thanks,
-- Shuah
