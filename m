Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C144C5033
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 21:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbiBYU5B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 15:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiBYU5A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 15:57:00 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD2B22311A
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 12:56:27 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id i1so5266525ila.7
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 12:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=huyLr7FvhwAScRTcVGfKhBUO1dK4/Q5kyJ0SythEREo=;
        b=Yn6P22agzPqkbTpVeCOjmOTHGBpr4GWVE7B6LdLQfZPalJ9NYVkBo77BnpBbh8qgLs
         pvBq2xSJR4QIEL0i44p3ajnQ4wXkbh1I2Tld1/Ekoomt2bl+8NrNFf3fnDuAsTVzzwvU
         wxTTwbSajWrGqWEaCzQ9hzb66qsOgpkJMftig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=huyLr7FvhwAScRTcVGfKhBUO1dK4/Q5kyJ0SythEREo=;
        b=5XNmI4Vyo0QbrEinQNrcZhq8JmK/WznImWROZcToEneaqrieSMiKvM4GkyXGohYhul
         JT/SUcMfMI2jSOLUrSRD+o5aj3cV+jz3k4aZb/fkcpRHdpOXL/dZpmRgDhYZ6IuEj4MF
         KeI9XWHW1tUa/B46GdwJKwUlk2fE7Iy5efySjy05ocuSgf0dN52BnIgOCtmJmJINh0os
         gpOgMEIbRJUsd7fivPf/JY4gHM68ntaPgK4QpaTLWfIonfkciilkZVHPmaOLy+84RAUC
         YGPj+KMrUNcGBFEShIBU2vLyh7Ih+itdpEZHfWLSeot0ACRx16Zl285VvLjzEuvXSdNu
         92Xg==
X-Gm-Message-State: AOAM533Mz09yBqPaMXu+li82L44Vb0ezBPNRTC0x+Lf9tQoNSH/mL/Gn
        Fsq0oVQDAstCBBZ5iOve928mnA==
X-Google-Smtp-Source: ABdhPJxpNEhm+RTqizALnxiIdAcJGJtBlXOx64h/ljXjBUUU14Gsb7J+iCVqM4iObG4GDcXzNU/moQ==
X-Received: by 2002:a05:6e02:184c:b0:2bf:f389:1f99 with SMTP id b12-20020a056e02184c00b002bff3891f99mr8202909ilv.22.1645822586901;
        Fri, 25 Feb 2022 12:56:26 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id 14-20020a92180e000000b002c1bfa2a5e6sm2143693ily.65.2022.02.25.12.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 12:56:26 -0800 (PST)
Subject: Re: [PATCH] selftests/rtc: continuously read RTC in a loop for 30s
To:     =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rtc@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220219072713.5280-1-mat.jonczyk@o2.pl>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6d8f500d-0ee0-3e27-dfdf-e8c0a34880e5@linuxfoundation.org>
Date:   Fri, 25 Feb 2022 13:56:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220219072713.5280-1-mat.jonczyk@o2.pl>
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

On 2/19/22 12:27 AM, Mateusz Jończyk wrote:
> Some problems with reading the RTC time may happen rarely, for example
> while the RTC is updating. So read the RTC many times to catch these
> problems. For example, a previous attempt for my
> commit ea6fa4961aab ("rtc: mc146818-lib: fix RTC presence check")
> was incorrect and would have triggered this selftest.
> 
> To avoid the risk of damaging the hardware, wait 11ms before consecutive
> reads.
> 
> In rtc_time_to_timestamp I copied values manually instead of casting -
> just to be on the safe side. The 11ms wait period was chosen so that it is
> not a divisor of 1000ms.
> 
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Shuah Khan <shuah@kernel.org>
> ---
> 
> Also, before
> commit cdedc45c579f ("rtc: cmos: avoid UIP when reading alarm time")
> reading the RTC alarm time during RTC update produced incorrect results
> on many Intel platforms. Preparing a similar selftest for this case
> would be more difficult, though, because the RTC alarm time is cached by
> the kernel. Direct access would have to be exposed somehow, for example
> in debugfs. I may prepare a patch for it in the future.
> ---

Looks good to me. We end up tweaking the timeout=210 in settings every
now and then. Not sure how we can avoid adjusting it as we find problems.

I will apply this in for Linux 5.18-rc1

thanks,
-- Shuah

