Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347C472A299
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 20:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjFISw0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 14:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFISwZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 14:52:25 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E323A97
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 11:52:24 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77ad566f7fbso18103639f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 11:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686336744; x=1688928744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAAvnQrwpO2uhBKRf2o3+v9wcqIBSyrOwUbsNA3kLcs=;
        b=cQ7cheuwuYxv3REKjdW8+HVI7nbwtLVhJaIdU55weF55CNRC115M4lcSna2mChpYoc
         Bn4BtcJZA1bRmnXcdvBfgI7lk1Uq5g2yRqK61G4RM9gbJnEHKcum0DRr/NoP96dySpvb
         n5cfpJ9xFLdtBi6dzy9cnrDznD3TtttAogVbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686336744; x=1688928744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAAvnQrwpO2uhBKRf2o3+v9wcqIBSyrOwUbsNA3kLcs=;
        b=A+ci4xR1e+L2Msq8tLim0NZvN0Q27vFahOo6BceEs/m6x5+XAa6aNpCTtoLpMaHbTr
         PSo0JBBAK+60Na21ZGddAuh2nN9obRE3Ye/q7V1X6Por/T7QLh9WllB22GDbHR+9pzA0
         hGhqVpczFCVjIRkBUkhTw/d1daONtqcPY5wWg+OXzsFVEw6Xxww56NRimNzaxURQF7zW
         sDiGeV5RcjrbMrryu6Ezq+xDvwVCLNqt5fSeKESLfalaCc0sACZtfTuueK50F87XW1ox
         6WQEIQbFcACTG6nD74C4EanmX55RN4Tkrj1eGhk2wpMx/X9QY6s1lGzFwb3OsQG5oMRn
         YDvg==
X-Gm-Message-State: AC+VfDx7mbMNM9H0xYDSisvUSYX1AfEa2n6ruuS/ZWTSF0QHNRqnkZst
        9NpSHJ/V1J1psxFubTtayrEcBA==
X-Google-Smtp-Source: ACHHUZ5YOtqqo6EDyYz9rHevK1XM92CNunTAygg+uI8VMp8yQvYpPXFa1pd0Sg19H5cLk2+cScUa3w==
X-Received: by 2002:a6b:b245:0:b0:77a:b7b7:acfc with SMTP id b66-20020a6bb245000000b0077ab7b7acfcmr1743173iof.1.1686336743928;
        Fri, 09 Jun 2023 11:52:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h10-20020a0566380f8a00b0040f91082a4fsm1102435jal.75.2023.06.09.11.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 11:52:23 -0700 (PDT)
Message-ID: <703a435a-d448-360d-9344-8b8614a5cb5a@linuxfoundation.org>
Date:   Fri, 9 Jun 2023 12:52:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] selftests/cpufreq: Don't enable generic lock debugging
 options
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230605-kselftest-cpufreq-options-v1-1-d4621e0c7cbe@kernel.org>
 <20230607034540.ldjugl3g6ryyyi5q@vireshk-i7>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230607034540.ldjugl3g6ryyyi5q@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/6/23 21:45, Viresh Kumar wrote:
> On 06-06-23, 15:11, Mark Brown wrote:
>> Currently the the config fragment for cpufreq enables a lot of generic
>> lock debugging.  While these options are useful when testing cpufreq
>> they aren't actually required to run the tests and are therefore out of
>> scope for the cpufreq fragement, they are more of a thing that it's good
>> to enable while doing testing than an actual requirement for cpufreq
>> testing specifically.  Having these debugging options enabled,
>> especially the mutex and spinlock instrumentation, mean that any build
>> that includes the cpufreq fragment is both very much larger than a
>> standard defconfig (eg, I'm seeing 35% on x86_64) and also slower at
>> runtime.
>>
>> This is causing real problems for CI systems.  In order to avoid
>> building large numbers of kernels they try to group kselftest fragments
>> together, frequently just grouping all the kselftest fragments into a
>> single block.  The increased size is an issue for memory constrained
>> systems and is also problematic for systems with fixed storage
>> allocations for kernel images (eg, typical u-boot systems) where it
>> frequently causes the kernel to overflow the storage space allocated for
>> kernels.  The reduced performance isn't too bad with real hardware but
>> can be disruptive on emulated platforms.
>>
>> In order to avoid these issues remove these generic instrumentation
>> options from the cpufreq fragment, bringing the cpufreq fragment into
>> line with other fragments which generally set requirements for testing
>> rather than nice to haves.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>   
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> ---
>>   tools/testing/selftests/cpufreq/config | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/cpufreq/config b/tools/testing/selftests/cpufreq/config
>> index 75e900793e8a..ce5068f5a6a2 100644
>> --- a/tools/testing/selftests/cpufreq/config
>> +++ b/tools/testing/selftests/cpufreq/config
>> @@ -5,11 +5,3 @@ CONFIG_CPU_FREQ_GOV_USERSPACE=y
>>   CONFIG_CPU_FREQ_GOV_ONDEMAND=y
>>   CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
>>   CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
>> -CONFIG_DEBUG_RT_MUTEXES=y
>> -CONFIG_DEBUG_PLIST=y
>> -CONFIG_DEBUG_SPINLOCK=y
>> -CONFIG_DEBUG_MUTEXES=y
>> -CONFIG_DEBUG_LOCK_ALLOC=y
>> -CONFIG_PROVE_LOCKING=y
>> -CONFIG_LOCKDEP=y
>> -CONFIG_DEBUG_ATOMIC_SLEEP=y
> 
> FWIW, I enabled these earlier as cpufreq core had a history of races
> that are normally not caught without these enabled. But I think we
> have come a long way from that and these can be removed now.
> 

Thank you both. Applied to linux-kselftest next for Linux 6.5-rc1
This gives us time to ensure the above mentioned races are no
longer an issue.

thanks,
-- Shuah
