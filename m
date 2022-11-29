Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851BE63CB02
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 23:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbiK2WYg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 17:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiK2WYe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 17:24:34 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF84B6D948
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 14:24:33 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r81so11171401iod.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 14:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYum/pWgYnwiga7VoANumBjcItMjRLsiKG9O6XYzRSk=;
        b=NdQA9M0eePxOZ4OZiEWZlA1clLBTof+xEYQ9v8Z6HVCwhIgqgsL5FEU0kQYxzrSb1w
         l33pyn6YWXW0AXjjwsE1EjKt+zhBviYuXmxZ2ITX9Psrryw+RAn6EMTbv9cigvTeyBP1
         JomqS6JgoNfBAyk7orZRll0Y0Cgk0bZcQGy1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DYum/pWgYnwiga7VoANumBjcItMjRLsiKG9O6XYzRSk=;
        b=jTGEYs2pzVC8xwDDgipsJv3sWOHj5fv7Mt0Xgk9wyrk0ZWJMSuTDbdiqW3qmxQdvc5
         xZpt/DyR0oZaBbOxEAhWj0BlpQPXHn754JPbysS/QG5L7cFDb2C58Etw2f1Hdkn6AGJF
         5enDMf5oSBsyHdyyXurQKL5JffWbzCVmgMc/Zck52tuIZ3D3C35njLuRCbD1lyC+a6TT
         Vlf/HDBmKrf5uNNs5YKHlkitfiLCYS6sOoed0RUlA2Hcodo27wFlFZOafBuVtTl3gvAy
         PMp9MbQVPGSptqSpcIGvaE1kOR0Pk2LOmxyt9j9vRKFli5eT5ob6pRN3qCaia6DrOZnA
         5qYA==
X-Gm-Message-State: ANoB5pmX+6OUyTXWsqAm7s8ZPhusqwfQoCLK6BbqllfgX30MPuQSy818
        +UnX4lWf8D7sdc30M1Xhttrkdg==
X-Google-Smtp-Source: AA0mqf7JYr7+b9amwN4jdAtOSlybUhZtlpMT9+NWeq3566dKH6rAbeeOnI65E0oQfy0AUQStTAvafQ==
X-Received: by 2002:a02:856a:0:b0:389:ce3b:6bc0 with SMTP id g97-20020a02856a000000b00389ce3b6bc0mr8856777jai.61.1669760673110;
        Tue, 29 Nov 2022 14:24:33 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t17-20020a92dc11000000b00302f4f69f62sm4682437iln.12.2022.11.29.14.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 14:24:32 -0800 (PST)
Message-ID: <d48804d5-2ad5-fbfb-ce17-83fbc450d3d6@linuxfoundation.org>
Date:   Tue, 29 Nov 2022 15:24:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/6] selftests: Use "grep -E" instead of "egrep"
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1669165413-12035-1-git-send-email-yangtiezhu@loongson.cn>
 <bf9b26b5-2793-204f-ba9c-4d9cd55b08ad@loongson.cn>
 <dc7cb519-584c-55f1-4baa-44cd4e0bbfe9@linuxfoundation.org>
 <20221129221344.GF4001@paulmck-ThinkPad-P17-Gen-1>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221129221344.GF4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/29/22 15:13, Paul E. McKenney wrote:
> On Tue, Nov 29, 2022 at 02:39:25PM -0700, Shuah Khan wrote:
>> On 11/22/22 19:27, Tiezhu Yang wrote:
>>> It seems that patch #2~#6 has no conflicts with the other related
>>> git tree, but patch #1 is conflicted with paulmck/linux-rcu.git dev.
>>>
>>> What should I do?
>>>
>>> Shuah, could you please apply patch #2~#6 to your linux-kselftest.git next branch and ignore patch #1?
>>>
>>> And then let me send a seperate patch #1 rebased on paulmck/linux-rcu.git dev branch to rcu@vger.kernel.org.
>>>
>>
>> That won't work because linux-kselftest next won't have the linux-rcu content.
>> I already picked patches 1,2,6
>>
>> Patches 3 (powerpc) and 5 (net) go through powerpc and net trees. Please resend
>> just those cc'ing the right people. get_maintainers.pl will give you the info.
>>
>> As for patch 1 - perhaps the conflict could be resolved in next.
>>
>> Paul, would you like me to drop rcutorture patch from linux-kselftest next?
> 
> I would be happy to carry the rcutorture patch, especially if doing so
> makes life easier.  ;-)
> 
> But please do send me some sort of pointer to the patch.  Otherwise,
> I guarantee you that I will queue the wrong one.
> 

I have it queued up in linux-kselftest next for Linux 6.2-rc1 - if it is easier
we can just resolve the merge in next.

thanks,
-- Shuah

