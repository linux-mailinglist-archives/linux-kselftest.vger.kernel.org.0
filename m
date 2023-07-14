Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4225775430D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 21:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbjGNTLO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 15:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjGNTLN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 15:11:13 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C1835A5
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 12:11:12 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id ca18e2360f4ac-785d3a53ed6so28677339f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 12:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689361871; x=1689966671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yialeae0FRLuDudxSzZrlpT7q/KFyoBq2qabN1GxdSg=;
        b=QK/rNnW4rKlVH3RzTVnjvHBZWPvtsk7qv20KXHpwLSVyIZGRkss4cmSPx+B2V3iSmn
         9sQAq13gWpJjMmxqQ8oMNIq/UNzOHjgL7Qa9/AG7V0XVV6ljowq3yUMT29AtzHar1CLK
         0cQYNqadBx3NR0mP8qq8xcfi55Beg+i0ndd7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689361871; x=1689966671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yialeae0FRLuDudxSzZrlpT7q/KFyoBq2qabN1GxdSg=;
        b=YAWlVXgaG7Tl6QBDS5lxP7AgQf+KpNvCkPRqDuh0mX4Q2Ye6Uwn3JA0K71E6YIEobJ
         n4iejviqzEjNqdSzjDtYal9u/yEVF82cN/5Lq5gwBhL2CclygvlE307Ms/x5uBfXXEgt
         YoHfYkuxLa/3XeKvZ7Tcq9z7T/NijeQ3UKzdtBnc3j9k4ZOrQxPqQg9Ek5yq88Gimizp
         m80BsvvFAxDp+qkvo1kG0uGeMNX8irkmJcjF+sp7W9ZWnSZRz5Eh2r5N3yhJa+UkPRlZ
         DXwogRbLdS+4VtEa56DVGDpPY6m+ke3Kagw+5OJDru8KDQwn33JtcHglpcTaMuRMQxsB
         SVrQ==
X-Gm-Message-State: ABy/qLZJzE/B1e6ULZWYT89quGLL8V+Z/HGuxbMtX6yLdXUE/VaCwun+
        Juzou77Qa5OJ05b+7F29kM+152xDWdF4t3VLqE1/++6J
X-Google-Smtp-Source: APBJJlEGvhkV/7gcZlvu7+7GdcAFWsR1iUKZmtKDA3M+FCTMNBsij+zysGny0FEHrl0Q4Ss3OriJfQ==
X-Received: by 2002:a6b:8d17:0:b0:783:743c:fd01 with SMTP id p23-20020a6b8d17000000b00783743cfd01mr5294597iod.0.1689361871232;
        Fri, 14 Jul 2023 12:11:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d6-20020a02a486000000b0042b0ce92dddsm2674379jam.161.2023.07.14.12.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 12:11:10 -0700 (PDT)
Message-ID: <d03af9cc-c72e-d23f-73ad-ca0e079c3187@linuxfoundation.org>
Date:   Fri, 14 Jul 2023 13:11:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Ghiti <alex@ghiti.fr>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
 <8d944238-1a9a-e93e-fdab-54e74fa12e11@linuxfoundation.org>
 <785e1c1c-84d8-e87d-f22f-9a53d27f30f6@nvidia.com>
 <620a5b91-9715-ee28-423c-851506b10832@linuxfoundation.org>
 <421bebb3-19e9-47a7-8b2b-f69f125df22f@sirena.org.uk>
 <f479b731-7782-0417-2d4c-31a7c3c9491c@nvidia.com>
 <20230714112653.0b42d3c9818b038d219b5e41@linux-foundation.org>
 <68ccfd77-ce2f-857a-37a7-e9b3edcd495d@linuxfoundation.org>
 <5e5bf5c0-bcda-ec2a-ba4c-5f35dcfbc373@nvidia.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5e5bf5c0-bcda-ec2a-ba4c-5f35dcfbc373@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/14/23 12:36, John Hubbard wrote:
> On 7/14/23 11:32, Shuah Khan wrote:
>> On 7/14/23 12:26, Andrew Morton wrote:
>>> On Fri, 14 Jul 2023 11:19:11 -0700 John Hubbard <jhubbard@nvidia.com> wrote:
>>>
>>>> On 7/14/23 11:09, Mark Brown wrote:
>>>>> On Fri, Jul 14, 2023 at 11:48:51AM -0600, Shuah Khan wrote:
>>>>>> On 7/13/23 14:16, John Hubbard wrote:
>>>>>
>>>>>>> Actually, I was hoping that my two fixes [1], [2] could be used, instead
>>>>>>> of reverting the feature.
>>>>>
>>>>>> Mark! Are you good with taking these two - do these fix the
>>>>>> problems you are seeing?
>>>>>
>>>>> I reviewed the one that's relevant to me already, the arm64 one, I'd not
>>>>> seen or tested the RISC-V one but that looks fine too.  I'm pretty sure
>>>>
>>>> That riscv patch already has a Tested-by from Alexandre Ghiti:
>>>>
>>>> https://lore.kernel.org/f903634d-851f-af64-8d9a-6b13d813587c@ghiti.fr
>>>>
>>>>
>>>>> Andrew queued it already though ICBW.  Either way it'd be good to get
>>>>> this into -rc2, this is seriously disrupting arm64 CI and I'm guessing
>>>>> the RISC-V CI too.
>>>>
>>>
>>> I just dropped
>>> selftests-arm64-fix-build-failure-during-the-emit_tests-step.patch and
>>> selftests-fix-arm64-test-installation.patch, as Shuah is merging them.
>>>
>>> This is all rather confusing.  Perhaps a full resend of everything will
>>> help.  I'll assume that Shuah will be handling them.
>>
>> Yes. Andrew - I am applying both as we speak. I found the right versions
>> with Tested-by tags.
> 
> Thanks, Shuah.
> 
> Just to be clear, when you say you're applying "both", I'm hoping you mean
> both of these:
> 
> 
> [1] https://lore.kernel.org/all/20230711005629.2547838-1-jhubbard@nvidia.com/
> [2] https://lore.kernel.org/all/20230712193514.740033-1-jhubbard@nvidia.com/
> 

Right. The ones you have links to:

Please check the latest fixes to see if we are all squared away:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=fixes

thanks,
-- Shuah
