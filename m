Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8F24C525E
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Feb 2022 01:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbiBZADS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 19:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239914AbiBZADR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 19:03:17 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A14158D83
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 16:02:44 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id z7so5581798ilb.6
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 16:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4TpFdWGGu68hiozG5aqHPRXt94qhCk+o6JG516+kdbE=;
        b=DzGxjc6L9fhiwmV2m0lZXtTqNZOD0d6unMPEKi/4vECMwSDnZGJKgitxTQY+EiEGfy
         XquzQiMm6zyfeB2uD/xjaAvx/63eP9LCMpLBaaYVhBv327i4srbO4RFScHr69DptsG+L
         emmu5kQvsQAaBRhnQy43NaHkWsS8brDZvR1RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4TpFdWGGu68hiozG5aqHPRXt94qhCk+o6JG516+kdbE=;
        b=KKwRsWd0llRZ2z9pdJyWt240V66GmS7RIfqMp3zRytyXaYwtVIckt6NmcVPFhShqZJ
         3ID7i7sm/x4df6yiE1z0JThZ1fXYbePYgIITFmyx+c9H8HJcZgcYsMlnb/mtAV6GVZ8w
         rXkFAUAtzu0F41l/sfzwNk1ZTvmbJJKP2b5MShKhjIwgxobJ3KtavVpZEXsGIIsj7JEh
         guirL2UBey0kYuru3wFFtEs8P1vi0Fsi9YXA4GEQyPEvLspGqn6qUq3VRHhZx2Gf+Mqm
         XOBqAPwfpvIQeycTrRX2Qb55CHbdfgA8D/CmKyGahbpVuzNHzr2dLDmM6rcL40Sy6FC9
         Vthg==
X-Gm-Message-State: AOAM530ioe0LLYKgqRhTuKESyH2jsiKzx1JHR0LpKkuJtXVh4SXK8ywW
        HugeAcbCjdu029qHOFUWdG6K8Q==
X-Google-Smtp-Source: ABdhPJyeiNDbp52Qr+n41Pw/M9uNVzxmLnxPbY1ljMyWkWITko2VTAG5m4gcWRKj5yoMXnCSK8iSpA==
X-Received: by 2002:a92:cf43:0:b0:2c2:841e:b03b with SMTP id c3-20020a92cf43000000b002c2841eb03bmr8009336ilr.68.1645833763950;
        Fri, 25 Feb 2022 16:02:43 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id h6-20020a056e021b8600b002bf45d43938sm2400916ili.86.2022.02.25.16.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 16:02:43 -0800 (PST)
Subject: Re: [PATCH] selftests/rtc: continuously read RTC in a loop for 30s
To:     =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rtc@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220219072713.5280-1-mat.jonczyk@o2.pl>
 <6d8f500d-0ee0-3e27-dfdf-e8c0a34880e5@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fb6da998-3970-90f9-f79e-386987bfd431@linuxfoundation.org>
Date:   Fri, 25 Feb 2022 17:02:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6d8f500d-0ee0-3e27-dfdf-e8c0a34880e5@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/25/22 1:56 PM, Shuah Khan wrote:
> On 2/19/22 12:27 AM, Mateusz Jończyk wrote:
>> Some problems with reading the RTC time may happen rarely, for example
>> while the RTC is updating. So read the RTC many times to catch these
>> problems. For example, a previous attempt for my
>> commit ea6fa4961aab ("rtc: mc146818-lib: fix RTC presence check")
>> was incorrect and would have triggered this selftest.
>>
>> To avoid the risk of damaging the hardware, wait 11ms before consecutive
>> reads.
>>
>> In rtc_time_to_timestamp I copied values manually instead of casting -
>> just to be on the safe side. The 11ms wait period was chosen so that it is
>> not a divisor of 1000ms.
>>
>> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> ---
>>
>> Also, before
>> commit cdedc45c579f ("rtc: cmos: avoid UIP when reading alarm time")
>> reading the RTC alarm time during RTC update produced incorrect results
>> on many Intel platforms. Preparing a similar selftest for this case
>> would be more difficult, though, because the RTC alarm time is cached by
>> the kernel. Direct access would have to be exposed somehow, for example
>> in debugfs. I may prepare a patch for it in the future.
>> ---
> 
> Looks good to me. We end up tweaking the timeout=210 in settings every
> now and then. Not sure how we can avoid adjusting it as we find problems.
> 
> I will apply this in for Linux 5.18-rc1
> 

Applied to linux-kselftest next for Linux 5.18-rc1

thanks,
-- Shuah
