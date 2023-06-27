Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356317403C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 21:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjF0TEI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 15:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjF0TEF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 15:04:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96D11BD5;
        Tue, 27 Jun 2023 12:04:02 -0700 (PDT)
Received: from [192.168.10.54] (unknown [182.179.162.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D55856607155;
        Tue, 27 Jun 2023 20:03:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687892641;
        bh=2pkER0ZvYT5GddTzJ80ZqUr+7MVPSyIBtKVbKbTiFgw=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=eCtQhi2sazyGTHceRRSU9/qx1KZzby4PEdvhwrf/9NeSXVAVpLNJ+54zehqWX91M4
         sgryi6syvyWZlpiV2zO10F66IJaXrTpBibAAp5WjN6suQI2oOrO8hZqscqbRaYDGoD
         EzfYtA8p/jEnZbi2ru7BoJfUzvoiQjXuHhk8IprwcfkfddzIAZD470zpSjfbyxeqWJ
         oVMjLz5RgfbnLtodD9s7IzMRfUNCcI2quiGyxqnqKf10qFpAKMYdRVUMhP0uNoltkZ
         J7pxhU2BMsjIwk8piEiQoS6AWGC2T47y798akn5+kTjRneNh+y4W6Ievg0SS235dzl
         RKR2TQPdn/Vzw==
Message-ID: <5a5ccd98-7e4c-2108-aa4a-cd7c3ecd95dc@collabora.com>
Date:   Wed, 28 Jun 2023 00:03:56 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests: prctl: Add new prctl test for PR_SET_NAME
Content-Language: en-US
To:     Osama Muhammad <osmtendev@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230607153600.15816-1-osmtendev@gmail.com>
 <b7a3219e-4e0a-7a08-439a-a8a6e35271ca@linuxfoundation.org>
 <CAK6rUAMODPLQeUawXMW_RNiJFdukOqdhS5GA5XRAq4U9bnQdNg@mail.gmail.com>
 <3c03e28b-8006-a4ac-30bc-6aaf83ccb5d5@linuxfoundation.org>
 <CAK6rUAObT-kQVGddhvxxtaKPcuaDddM6ipEDXuECCFtpR-GV6w@mail.gmail.com>
 <CAK6rUAMuYTUhqcGmDrmeEWnigy3X4OxNb4zmHc0TmcVJ79MyHg@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAK6rUAMuYTUhqcGmDrmeEWnigy3X4OxNb4zmHc0TmcVJ79MyHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Thank you for the patch. This patch cleanly applies on next-20230627.

Unrelated to this patch:
I'm not sure if this patch was written against linux next. Always try to
send patches against latest next tag from following repo:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

On 6/26/23 11:36 PM, Osama Muhammad wrote:
> Hi Shuah,
> 
> Any feedback on this patch?.
> 
> Thanks,
> Osama
> 
> 
> On Sat, 17 Jun 2023 at 18:01, Osama Muhammad <osmtendev@gmail.com> wrote:
>>
>> Hi,
>>
>> Yes, I did install the latest kernel headers and TASK_COMM_LEN is not
>> accessible in userspace.
>>
>> I looked into the test which uses TASK_COMM_LEN but the test defines
>> it in its own header file.
>>
>> Example:  https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/bpf/progs/pyperf.h#L13
>>
>> TASK_COMM_LEN is defined in include/linux/sched.h, but this header
>> file is not exposed to userspace.
>>
>> TASK_COMM_LEN is not defined in /include/uapi/linux/sched.h which is
>> exposed to userspace kernel headers.
>> Please find the link to the header file exposed to user space :-
>> -https://elixir.bootlin.com/linux/v5.15.116/source/include/uapi/linux/sched.h
>>
>> As for arm64/abi/tpidr2.c It includes linux/sched.h which will be
>> /include/uapi/linux/sched.h because the user space program is
>> including it.
>> So it also cannot use TASK_COMM_LEN directly.
>>
>> Regards,
>> Osama
>>
>> On Tue, 13 Jun 2023 at 02:56, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>
>>> On 6/10/23 07:01, Osama Muhammad wrote:
>>>> Hi all,
>>>>
>>>> I looked into it and tried to use TASK_COMM_LEN in the test. Even
>>>> though I included "linux/sched.h '', I was not able to compile the
>>>> test because it couldn't find it in the header file.
>>>> I dived deep into the issue and turns out header file mapped in
>>>> /usr/include/linux/sched.h is actually mapped to
>>>> /include/uapi/linux/sched.h[1] in linux source,
>>>> where TASK_COMM_LEN is not even defined. Instead TASK_COMM_LEN is
>>>> defined in /include/linux/sched.h which is not mapped to any header
>>>> files in
>>>> userspace(/(/usr/include/linux).
>>>> I also tried to find the TASK_COM_LEN in /usr/include/linux/ but I
>>>> couldn't find it. Following are the search results.
>>>> grep -rnw '/usr/include/linux/' -e 'TASK_COMM_LEN"
>>>> RESULTS OF COMMAND :- /usr/include/linux/taskstats.h:38:#define
>>>> TS_COMM_LEN 32 /* should be >= TASK_COMM_LEN
>>>> Based on this information, I have two questions:
>>>> 1. Would this require a fix to move 'TASK_COMM_LEN' macro from
>>>> /include/linux/sched.h to UAPI headers /include/uapi/linux/sched.h.
>>>> 2. Is there any other way to access TASK_COMM_LEN in the selftest that
>>>> I'm not aware of?
>>>>
>>>> [1]:-https://elixir.bootlin.com/linux/v5.15.116/source/include/uapi/linux/sched.h
>>>>
>>>
>>> The best source is Linux mainline.
>>>
>>> Take a look at test files that include linux/sched.h
>>>
>>> arm64/abi/tpidr2.c is one of them.
>>>
>>> Did you install headers before compiling the test?
>>>   make headers_install
>>>
>>> thanks,
>>> -- Shuah
>>>
>>>

-- 
BR,
Muhammad Usama Anjum
