Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D97A232D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbjIOQC4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 12:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbjIOQCk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 12:02:40 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F4D171C
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Sep 2023 09:02:34 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34fb886989dso875475ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Sep 2023 09:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694793753; x=1695398553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SU4Y10plz8qUMuJm0JLA4PaC91yhdIoxwR3qIThUido=;
        b=Yvv7/6MI7z9HGU0cFzurVpJ+Tv4FgKXLXavF4rYgddSa8/B4zHg9WW3xrmSWULByKr
         DsC85Fn0QBTDguxT0wsQGxWRdDeOcYNhJbhkwhQgbUeDs5dOGl/8ldRa+laFNThvjUgo
         VEZIl0s6hBqQ/r/mF0rMS+CeLdX+PXkliAkhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694793753; x=1695398553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SU4Y10plz8qUMuJm0JLA4PaC91yhdIoxwR3qIThUido=;
        b=amFQSIVL25onbUfEAqPy1CQ/LTSN3lJELyBuyflsMEfzPoX6vSw0jygn8PD14CJcpm
         WpLg6U48XQAdKda4Mlw1CS8/7HcHZyp13Y3c0oUoape2uVu7KxENfyZt7RUS2Noxc2wt
         N57P7Fc1q2eh1h9OPIRK7IJvT86RYT7hqHG2JxEORKWyOL7lQVaXXt7m8kyPUqfKrkQR
         0Gna6mzF/taERBsLQwS16DsO7J7D8vkA9jFz/8/qT4RWjKKZaXvZIsJAsrCmLquN/97S
         DsG21K14zcwWNBeBd23RfzJB3e98B3vrlKOpwVSuXGXVDpmAHKPqOrmBdOBkDjHcbcCy
         IP7g==
X-Gm-Message-State: AOJu0YyExpwOWWyrzRyiSZFluItUiaS4bn2+Nj/YSbi9z0flSinOWT7I
        b77p+DiMSJT57s41RW9KUK4Wew==
X-Google-Smtp-Source: AGHT+IEcGE95ViEzDR2M6vtuBCNoKV4OqOm1d1DBvPmU6xM+F9rbsThXXPI2gZ8MUHQSaxd9Ch8J+w==
X-Received: by 2002:a92:c646:0:b0:349:983c:4940 with SMTP id 6-20020a92c646000000b00349983c4940mr2586196ill.1.1694793753310;
        Fri, 15 Sep 2023 09:02:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id dp10-20020a0566381c8a00b0042b6f103e62sm1098108jab.133.2023.09.15.09.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 09:02:32 -0700 (PDT)
Message-ID: <8fc6a2d8-948a-af0c-1189-c12593766433@linuxfoundation.org>
Date:   Fri, 15 Sep 2023 10:02:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] selftests/user_events: Fix failures when user_events
 is not installed
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Mark Brown <broonie@kernel.org>, shuah@kernel.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, naresh.kamboju@linaro.org,
        anders.roxell@linaro.org, arnd@arndb.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230908201916.562-1-beaub@linux.microsoft.com>
 <29fce076-746c-4650-8358-b4e0fa215cf7@sirena.org.uk>
 <20230908212712.211a4964@gandalf.local.home>
 <20230912171234.GA3704-beaub@linux.microsoft.com>
 <20230912134644.3b7959b9@gandalf.local.home>
 <b2d8d216-7d02-707e-937a-b42863f9e76d@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <b2d8d216-7d02-707e-937a-b42863f9e76d@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/15/23 09:54, Shuah Khan wrote:
> On 9/12/23 11:46, Steven Rostedt wrote:
>> On Tue, 12 Sep 2023 10:12:34 -0700
>> Beau Belgrave <beaub@linux.microsoft.com> wrote:
>>
>>
>>>> I guess I was wrong and some people do care ;-)
>>>>
>>>> -- Steve
>>>
>>> It looks like this change got applied [1] to the fixes branch of
>>> linux-kselftest. I can either send a V3 with this addressed or build a
>>> patch based upon the fixes branch on top of this one to address it.
>>>
>>> Which way do you all prefer?
> 
> Please send me patch on top of this one on linux-kselftest fixes.
> 

One more thing. I am sending pull request now with this patch to address
the test failures.

Please send the unmount fix as soon as possible to include it in the next
rc.

thanks,
-- Shuah
