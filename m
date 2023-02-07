Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C541068E32F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 22:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBGVyZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 16:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBGVyY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 16:54:24 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A133BD81
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Feb 2023 13:54:11 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id j12so3162508ila.1
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Feb 2023 13:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hubqKtMuYwUvUIi4swYjWUkw4EbQmDjYbC8mfiwm2w=;
        b=A1Msn2PKzn7+ypZXcJEEO+KbfACpwv+YUpC0RQgNRx0kwSGAW9ARdUBZRDNV7zF3oH
         azuv26Gsgrga1pR6AimoOrdpDF9RwA7ZyXwyARW3FCOBegQFyCTMR+XUIWJRZ6aNks8l
         MYfk4vAYR3Qof/DO/2CErbfvcAGaR4dE5liyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hubqKtMuYwUvUIi4swYjWUkw4EbQmDjYbC8mfiwm2w=;
        b=GSkn6Sx+QOf/BxYhQj4if4xb3uDA2xhJFy76cZpnbsEP3HopCXkAcmpVU8z0pg/sMw
         F5AJVQtAPKb6bspYRi3dVVMkvM67sdRI+dltbnBllOMnDA283vMGJxjUku00HUeRLYfj
         0d75bOUJG537UpF20j6FynwX0KNfhHMwow8ufxLVv/nAEEQHG6KLYbyBY56N7c5UqyE4
         uMBs/5kHmvcunydFNOk5FKNLpRCTjPqfE7mxxyZ/Ul3uNRgDL3Io5fvISPeR3x1xiUvG
         Sgw0FO1tPXpPAcq3/gon3jvhYmXAqfzepxKJqQ30/ejRq9kq7aZHlBVQS5vb+MUiOUur
         TDYA==
X-Gm-Message-State: AO0yUKX0EiGLBk6lhdMVbByopzsl1XE3JRpI0vaazahZ+ZE8jfJP6zTd
        mQry1ew7T8mzGVTBPnTRZHMzSw==
X-Google-Smtp-Source: AK7set/eL/42HZlwEKUPckXmYxlgeRZ4Hwxiiwjnfo5/shFUQKriZV27m5QUZM3kAA2AfnAKtDWXKg==
X-Received: by 2002:a92:d484:0:b0:313:cd79:adc2 with SMTP id p4-20020a92d484000000b00313cd79adc2mr3810400ilg.2.1675806851274;
        Tue, 07 Feb 2023 13:54:11 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r12-20020a056638130c00b003a432de0547sm4861530jad.163.2023.02.07.13.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 13:54:10 -0800 (PST)
Message-ID: <96536043-2afe-c10d-b4ee-9625203c6242@linuxfoundation.org>
Date:   Tue, 7 Feb 2023 14:54:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] selftests: use printf instead of echo -ne
Content-Language: en-US
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Shuah Khan <shuah@kernel.org>,
        Gautam <gautammenghani201@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernelci@lists.linux.dev,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230204135652.336495-1-guillaume.tucker@collabora.com>
 <97df8ef0-5eef-91cd-2d6d-eeff764c5e35@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <97df8ef0-5eef-91cd-2d6d-eeff764c5e35@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/7/23 01:36, Guillaume Tucker wrote:
> On 04/02/2023 14:56, Guillaume Tucker wrote:
>> On some systems, the default echo command doesn't handle the -e option
>> and the output looks like this (arm64 build):
>>
>> -ne Emit Tests for alsa
>>
>> -ne Emit Tests for amd-pstate
>>
>> -ne Emit Tests for arm64
>>
>> This is for example the case with the KernelCI Docker images
>> e.g. kernelci/gcc-10:x86-kselftest-kernelci.  To avoid this issue, use
>> printf which handles escape characters as a standard feature and is
>> more widespread among modern shells.
>>
>> The output is now formatted as expected (x86 build this time):
>>
>> Emit Tests for alsa
>> Emit Tests for amd-pstate
>> Skipping non-existent dir: arm64
>>
>> Reported-by: "kernelci.org bot" <bot@kernelci.org>
>> Suggested-by: David Laight <David.Laight@ACULAB.COM>
>> Fixes: 3297a4df805d ("kselftests: Enable the echo command to print newlines in Makefile")
>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>> ---
>>
>> Notes:
>>      v2: use printf insead of $(which echo)
> 
> Oh I see you've already applied the v1 on kselftest/next branch:
> 
>    79c16b1120fe selftests: find echo binary to use -ne options
> 
> Do you want me to send this printf fix rebased on top?
> 

Yes please. Thank you.

thanks,
--- Shuah

