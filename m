Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3C777D18D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 20:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbjHOSNo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 14:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbjHOSN0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 14:13:26 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA371999
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 11:13:25 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-77dcff76e35so63236239f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692123205; x=1692728005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a+eUdHCB3DoY8jEut+5Ikkg8CLuEIFPgqSnNE/p3cew=;
        b=IWOyzlAZpJyCk13fr+u9oepZqcGJVwrXnasZqYSnZcYHaItrhiKlzhb9vE9n8fDSaL
         TuXNHrFJea2Ft0NVVLry/M1CCBZT1MXQBHbRJ/Ow8kbcFUFx++h7iV2BNUkKoGd6f0i5
         8qyegxjCUe1SrUN4RtdE2UuBLZpQaxMmMiGKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692123205; x=1692728005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+eUdHCB3DoY8jEut+5Ikkg8CLuEIFPgqSnNE/p3cew=;
        b=Ess1qGEawlfUALx+tUOP4a9crhsFRyaukmZ9cs6kzw4J4I5ZiX/CCi4YYDBo2GCiUg
         uqxMEOWZZHQ3MywUGvsUofa1P41cYtGy/7+lrAR88/QgMjeQgP0atilJfK0N62HszyW8
         HdyXNhILD/Q2Jex8aOXMsjUCsvShUrNzHZti+ct2CD2u0+3YxMHaCR9csLN5b3Go+R1n
         ae0oXibSYqROeLHO8zZ9yVkq0yM1pokZIiSz+4yXfcNk0rUbhXNleXegfEdohMDqkPSw
         3XqtcxaK5mQR0ctR4MWeTsN9WuVYpxZoL4B9ZZmP/9zNMsnakmO2PpeC0WAkme1XNxK7
         k9UA==
X-Gm-Message-State: AOJu0Yx/vA7ODjk9z2j0dXuvWgCvfdwE1307CFmxRYEBgEqmwIeN1MEg
        HSr0g9po2Hs6gDA28xx6cf6Kug==
X-Google-Smtp-Source: AGHT+IG31pSd31tKfsUgoajC2J61nWgN5tSeTm+8UNBl5DgEJvUS8ie3vLNdZXxOUV+95pbcQK3pag==
X-Received: by 2002:a6b:1404:0:b0:790:958e:a667 with SMTP id 4-20020a6b1404000000b00790958ea667mr16846682iou.2.1692123205230;
        Tue, 15 Aug 2023 11:13:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id fu11-20020a056638668b00b0042b6a760c31sm3876747jab.28.2023.08.15.11.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 11:13:24 -0700 (PDT)
Message-ID: <9950607c-cafe-c011-7d5f-76a8a971beb0@linuxfoundation.org>
Date:   Tue, 15 Aug 2023 12:13:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [GIT PULL] nolibc changes for 6.6-rc1
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20230806172245.GA26239@1wt.eu>
 <3efa3710-4e8b-d187-a24d-ff85858e37fe@linuxfoundation.org>
 <20230815143540.GA15075@1wt.eu>
 <29590d7b-40fd-0426-75c6-36667e344f6c@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <29590d7b-40fd-0426-75c6-36667e344f6c@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/23 08:39, Shuah Khan wrote:
> On 8/15/23 08:35, Willy Tarreau wrote:
>> On Tue, Aug 15, 2023 at 08:25:51AM -0600, Shuah Khan wrote:
>>>> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
>>>>
>>>>     Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>     https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ 20230806-for-6.6-1
>>>>
>>>> for you to fetch changes up to d98c1e27e46e47a3ae67e1d048f153598ba82611:
>>>>
>>>>     tools/nolibc: stackprotector.h: make __stack_chk_init static (2023-08-06 18:44:47 +0200)
>>>>
>>>
>>> Hi Willy,
>>>
>>> I am sorry for the delay on this. I was traveling last week
>>> and getting back to digging myself out of emails.
>>
>> No problem, thanks for getting back :-)
>>
>>> I am having trouble pulling this request though:
>>>
>>> git request-pull https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ 20230806-for-6.6-1
>>>
>>> gives me the following error
>>>
>>> fatal: Not a valid revision: git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/
>>>
>>> I don't see a tag at https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
>>
>> Ah sorry for the misunderstanding, that's the branch name, I'll set a
>> tag then.
>>
> 
> No worries. Could you also share the test you run? I will pull
> you request and run tests.
> 

Please send either another pull request or send the tag details.

Also please join IRC channel #kselftest on OFTC. It will be easier
to chat. Unless I am traveling you can find me there Nick: shuah

thanks,
-- Shuah



