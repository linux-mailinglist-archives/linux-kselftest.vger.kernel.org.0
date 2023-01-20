Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2266759A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 17:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjATQP2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 11:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjATQP1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 11:15:27 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277567CCF6
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 08:15:21 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id h10so753840ilq.6
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 08:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8q+osopjEj5UV3uSdXLaRXg7Go12BXAi8Q5kyHgZLzM=;
        b=AvojiM0Z1FRoMv0sAipWHK+54Fg8PZXAKfISB4C9WyAKPAvjwXHfeH+LSUTxtlOAWQ
         myoIXkt4/lNWpHyWJtNLLXTL+LwhS3Sih0egnSdWC1hH5S9xpZBDDilfQgaLEE2XagKG
         WbO/aEilF+o2KsrDwkAsa8F87oT69of4q4WEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8q+osopjEj5UV3uSdXLaRXg7Go12BXAi8Q5kyHgZLzM=;
        b=AwDARYfSGOFBetgRcxlwCFDr/M3KdPMpyZMNAODg7xA5FMuC9Vdr5kkmSwmDSkVmWP
         gLte9y6t20ubAMQ5Z9eZj+oYFDpX3nyah5OucYCCgS08Efb2W1Qx4jubUtBuuIMkMx4F
         PxiGwM6acNXjrUksTBwOwK8jSsEE+okdFHbk9VA0j5sFOEbZQGwMrqo85rXDwEBhs4Vk
         fVaOd8VksF2C6mUUZTjlkYQjKTWjhn1mBdBcwP6I3fvEBgYznMLp4EZuQBVYrfpAb4jq
         Ve5iwQVCI2BXUY4qO8W1MMQ/Maobcv6bS/SOZxW4HV+xp1uuQa5Y7QziylzIJpeokahY
         S7aA==
X-Gm-Message-State: AFqh2krCTnsBRgn0C9PLEU8k/d0zg1eJ6HdQg649VSBoFS5tEyDopT6p
        Dv0uYASCxsdgiqxyrCkSSn13iw==
X-Google-Smtp-Source: AMrXdXukx36xY+oeMJ8jlQhSlgQ7DFkkSJM08imR7xKNmkF/kWguHew/k1ksNW9KAW0MdVAa6UXkAg==
X-Received: by 2002:a92:d3c2:0:b0:30f:4feb:50c7 with SMTP id c2-20020a92d3c2000000b0030f4feb50c7mr434920ilh.3.1674231320300;
        Fri, 20 Jan 2023 08:15:20 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p16-20020a92d290000000b00302632f0d20sm475827ilp.67.2023.01.20.08.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 08:15:19 -0800 (PST)
Message-ID: <0a1ae8e9-ab0e-038a-084f-240f73489010@linuxfoundation.org>
Date:   Fri, 20 Jan 2023 09:15:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests: amd-pstate: Don't delete source files via
 Makefile
To:     sedat.dilek@gmail.com, Huang Rui <ray.huang@amd.com>
Cc:     Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <001201d92c93$98c8a040$ca59e0c0$@telus.net>
 <Y8pcIjGsikDeGqoU@amd.com>
 <CA+icZUWP_uYr5B6d_xms5gpCRmNCx46KwukmZyuuTdEPawKUyA@mail.gmail.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CA+icZUWP_uYr5B6d_xms5gpCRmNCx46KwukmZyuuTdEPawKUyA@mail.gmail.com>
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

On 1/20/23 09:11, Sedat Dilek wrote:
> On Fri, Jan 20, 2023 at 10:17 AM Huang Rui <ray.huang@amd.com> wrote:
>>
>> On Fri, Jan 20, 2023 at 01:54:01PM +0800, Doug Smythies wrote:
>>> Revert the portion of a recent Makefile change that incorrectly
>>> deletes source files when doing "make clean".

Ooo. That is bad.

>>>
>>> Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
>>> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
>>> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
>>> Signed-off-by: Doug Smythies <dsmythies@telus.net>
>>
>> (+ Shuah and linux-kselftest mailing list)
>>
>> Thanks for fix!
>>
>> Acked-by: Huang Rui <ray.huang@amd.com>
>>
> 
> [ I already replied - but with these important CCs ]
> 
> Hi Doug,
> 
> Thanks for the patch!
> 
> Small nit, I saw this with:

What did you see and should that be fixed as well.

> 
> $ make -C tools/ clean
> 
> Otherwise:
> 
> Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
> 

Send me the revised patch with all the right CCs and I will pull
this right away.

thanks,
-- Shuah

