Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D506759D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 17:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjATQXd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 11:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjATQXc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 11:23:32 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3461E79292
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 08:23:31 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id s26so2656881ioa.11
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 08:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5/M15g97VVJwCbB5BwAXiGNLk4lW89kGAHYDk+TVQE=;
        b=UTpdjWfyaEsCIg8Ujt4NDYtGeVs+7A7k19g7SBIkw2xxcXoH2NVilKmA6lS+ADK9v6
         Z53NrMqAhBcz3SHu2GH5glLJAqoPqOyY/fbRuqRGPPWWv/FOMbloeTJklIGucyV2km/A
         HBsiEpAILufF+dv7QD/XW9dZfczsTfTTp+fsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5/M15g97VVJwCbB5BwAXiGNLk4lW89kGAHYDk+TVQE=;
        b=3hZT1AVqfjnrIjAE4IltNLAgvxP3Zv21ZRodzOfZoRnJN3J7ybO0Pl7D/AA8OkIYbU
         Fa1N9/q2FnVAHu4cxDlaCABNv/QXLTbLVbIyGYJhLlVLlIBLmUoZUHf5Sd9g/Lmk2IrR
         TvtC1lSwAKAquyHRS01yJOgnKBv+o5wQfZvk6wnPyEiU1LNqTHjMFQEmUkZn36JLc8Hx
         LpJjvjDtrfzyl90Q07sevD4WJClTqqsd6BdbHHQ/7aVQRskwr0Qol6UkUEma6lj773U+
         YtJKSpbxJNhy777KVLuWgmM4WswMkzXYcM0I8nXkWbnv1mSrxh4BPuKIzfuQZCPVxCoc
         Yo6w==
X-Gm-Message-State: AFqh2krL8m9xHJ6iMWjFwhRENB8laYa++xShk4juTdMwOJ1Ka7SGBOng
        7foOe1rRjvROTeFzzZ7QI3x6FA==
X-Google-Smtp-Source: AMrXdXu/73Z9sIPI2IFceSUD+Kl39L36DV2BACeO+7ZpUpOH2bHC1tlXyurSHaR7e089zE2iur2BmQ==
X-Received: by 2002:a5d:9482:0:b0:6cc:8b29:9a73 with SMTP id v2-20020a5d9482000000b006cc8b299a73mr1927116ioj.1.1674231810523;
        Fri, 20 Jan 2023 08:23:30 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z25-20020a056638215900b003a3dd1c7be7sm5343562jaj.128.2023.01.20.08.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 08:23:29 -0800 (PST)
Message-ID: <c9eeaa5a-9efd-f6a8-b223-1211d4528e19@linuxfoundation.org>
Date:   Fri, 20 Jan 2023 09:23:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests: amd-pstate: Don't delete source files via
 Makefile
Content-Language: en-US
To:     sedat.dilek@gmail.com
Cc:     Huang Rui <ray.huang@amd.com>, Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <001201d92c93$98c8a040$ca59e0c0$@telus.net>
 <Y8pcIjGsikDeGqoU@amd.com>
 <CA+icZUWP_uYr5B6d_xms5gpCRmNCx46KwukmZyuuTdEPawKUyA@mail.gmail.com>
 <0a1ae8e9-ab0e-038a-084f-240f73489010@linuxfoundation.org>
 <CA+icZUVgt422h2nOfhjyahMF2yX_Eon613Ep7=gJ5XRWDAMkmw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CA+icZUVgt422h2nOfhjyahMF2yX_Eon613Ep7=gJ5XRWDAMkmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/20/23 09:20, Sedat Dilek wrote:
> On Fri, Jan 20, 2023 at 5:15 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 1/20/23 09:11, Sedat Dilek wrote:
>>> On Fri, Jan 20, 2023 at 10:17 AM Huang Rui <ray.huang@amd.com> wrote:
>>>>
>>>> On Fri, Jan 20, 2023 at 01:54:01PM +0800, Doug Smythies wrote:
>>>>> Revert the portion of a recent Makefile change that incorrectly
>>>>> deletes source files when doing "make clean".
>>
>> Ooo. That is bad.
>>
>>>>>
>>>>> Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
>>>>> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
>>>>> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
>>>>> Signed-off-by: Doug Smythies <dsmythies@telus.net>
>>>>
>>>> (+ Shuah and linux-kselftest mailing list)
>>>>
>>>> Thanks for fix!
>>>>
>>>> Acked-by: Huang Rui <ray.huang@amd.com>
>>>>
>>>
>>> [ I already replied - but with these important CCs ]
>>>
>>> Hi Doug,
>>>
>>> Thanks for the patch!
>>>
>>> Small nit, I saw this with:
>>
>> What did you see and should that be fixed as well.
>>
>>>
>>> $ make -C tools/ clean
>>>
>>> Otherwise:
>>>
>>> Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
>>>
>>
>> Send me the revised patch with all the right CCs and I will pull
>> this right away.
>>
> 
> Hi Shuah,
> 
> that was my original posting...
> 
> Subject: [6.2-rc4] tools: {amd,intel}_pstate_tracer: make -C tools/ clean
> https://lore.kernel.org/all/CA+icZUUOckm1kwOEZhSw8zsaL5z7r8uczwiKeKGEVioZ=GeFNg@mail.gmail.com/
> 
> ...and should contain all CCs I got with scripts/get_maintainer.pl.
> 
> Is that OK?
> 

Yes - the current list looks complete to me.

thanks,
-- Shuah

