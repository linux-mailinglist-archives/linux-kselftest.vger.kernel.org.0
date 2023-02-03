Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A44689F2C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 17:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjBCQ02 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 11:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjBCQ00 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 11:26:26 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FDFA6BB9
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Feb 2023 08:26:15 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id x6so2263589ilv.7
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Feb 2023 08:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLJfdGZP1BFzdtMPyFR2lu2ZIWict9PZQQBPFbTL6LU=;
        b=gieRIzWJu047CZWPf6ziAjgqnA8W3Rf7kAuK2Ib0VqbZ/IbmwstCIKxv8mBZm8t9W+
         tXpjDiSU9n5JitzEz1eK8TB8xE5wUrrHsAO5jI7Ia+ttLEqE4Emir3yzVRHYrDsylkDf
         H7SLn2QA0EO9it4ehzCjBfJeufcYrqlLfaUek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLJfdGZP1BFzdtMPyFR2lu2ZIWict9PZQQBPFbTL6LU=;
        b=yhhS7pWVwM/S/AQylB3VOcYk9xC/OZg/+3uArV062JuujOfXKy7B3X2OJ63fbHLHmc
         yZvxOJhVE8UtyArPC3KFTC1GLkCpRyzKteqM8yXnbf00zZYzsOI1Qmfg1etTaoh5dOhC
         azY+hD9t3yHTwKYiKTa1qYxt1w2Tu2uwdg+dyojgkguBkuVm4LEe74kSXzGShMBtjl6c
         eScW4eCp0IN5AAfWeTMEK1Oaf0qaCR6Run9vX+oVodcHcPNpvmxBOIPIbT2IPNBt3dny
         S3OvGLOOyyZ52u71FMWwYOtf3gMhWNSQMxhi82xOz+hd9Vau3BmM14COJAGKBzlHAlwH
         yu4A==
X-Gm-Message-State: AO0yUKWUCTqjEy/m638WZEmVrXRcaRNkD9PJKjHVi84IE7YdMN4g4rlx
        SoM+qe5BWiw01QDsrEcuHjn+UA==
X-Google-Smtp-Source: AK7set/YR2hq7+Nc4g36sqYWklBKYz+K4Tgwg2cUX8s4j6YjRQY/P2l2EnUNN+w81E57FiOpNbT7Ag==
X-Received: by 2002:a05:6e02:110f:b0:30e:f89b:6652 with SMTP id u15-20020a056e02110f00b0030ef89b6652mr5160955ilk.0.1675441575088;
        Fri, 03 Feb 2023 08:26:15 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i18-20020a056e020ed200b0030ef2eedef5sm882064ilk.69.2023.02.03.08.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 08:26:14 -0800 (PST)
Message-ID: <5f808c28-ef25-9923-86e1-b4555900c987@linuxfoundation.org>
Date:   Fri, 3 Feb 2023 09:26:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] selftests: amd-pstate: Don't delete source files via
 Makefile
Content-Language: en-US
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Doug Smythies <dsmythies@telus.net>,
        'Huang Rui' <ray.huang@amd.com>, sedat.dilek@gmail.com,
        li.meng@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <001201d92c93$98c8a040$ca59e0c0$@telus.net>
 <000601d92db7$39e9d0b0$adbd7210$@telus.net>
 <b18805b0-06ba-2b28-73e5-a1d54425a704@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <b18805b0-06ba-2b28-73e5-a1d54425a704@collabora.com>
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

On 2/3/23 08:15, Guillaume Tucker wrote:
> On 21/01/2023 17:41, Doug Smythies wrote:
>> Revert the portion of a recent Makefile change that incorrectly
>> deletes source files when doing "make clean".
>>
>> Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
>> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
>> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
>> Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
>> Acked-by: Huang Rui <ray.huang@amd.com>
>> Signed-off-by: Doug Smythies <dsmythies@telus.net>
>> ---
>> v2: fix address list.
>> ---
>>   tools/testing/selftests/amd-pstate/Makefile | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
>> index 5f195ee756d6..5fd1424db37d 100644
>> --- a/tools/testing/selftests/amd-pstate/Makefile
>> +++ b/tools/testing/selftests/amd-pstate/Makefile
>> @@ -7,11 +7,6 @@ all:
>>   uname_M := $(shell uname -m 2>/dev/null || echo not)
>>   ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>>
>> -ifeq (x86,$(ARCH))
>> -TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
>> -TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
>> -endif
>> -
> 
> 
> The two lines above should also be removed as they're only used
> in the condition to include the Python files.
> 
> I've also hit this issue and independently came up with an
> alternative solution, let me know if you want me to submit it as
> a patch on top of the previous fix; see below.
> 
> The Python scripts appear to be used in gitsource.sh and
> tbench.sh so I guess they are needed for these kselftests
> although I haven't tried to run them or do anything with them.
> This is just to fix make clean.
> 
> 

Please send me the patch.

thanks,
-- Shuah
