Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068AE653447
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Dec 2022 17:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLUQov (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Dec 2022 11:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiLUQot (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Dec 2022 11:44:49 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC80248C4
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Dec 2022 08:44:48 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id p6so8256336iod.13
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Dec 2022 08:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cmw8eXLntCULsyu3Z4jUmMz+7oaxZIPRcoI0xwxZcI0=;
        b=ULaMJxfMJHP+e0ResDGTjcot+9ACqiBWzcBbo7Wk+3NV8TKC4hS/iM4NBzTlJDViOJ
         4oHGh7Ie5B/jAuNydOCj/yNWHOEZDDrCuXODAB9iHcZ9t3A+DCJLSND4Qg27C9jbC8xf
         /oN27n8cJy0T1d5HmqS0pAXEZh54stlBxX6vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cmw8eXLntCULsyu3Z4jUmMz+7oaxZIPRcoI0xwxZcI0=;
        b=jq8Gv7YeGSOOXAPOoCsI0UUtpaCZlFa+Hn7ndiLeTBysrr390SzJQgOOqy6KCD6h/c
         cDccPvTUb4rjIwLm9RMoBgaVted7mUohwb9dQumkHIURKpm2KlLrA/+VtgUxAjXVxcQv
         zDJIBAJ6wea1kuYpieh6bjjxSe2GnY8wiP8ZBYxhvslUocK05dVafroiUrHnImuS52bk
         ApHKJE1hApKRSH/YHxDx+BGXpRodVAAOqoPEnJ7QmKSiAeHub/vqsRSoyIBy4KZ1cA9u
         PqizfcGGk6RHZKFMEDaL34pD1ugE3QxnoeMZPDWogceS2+uOz0NEnb+FI53EXHSNsPlb
         EPEw==
X-Gm-Message-State: AFqh2koduY4WOh17k+cJDCF3WIHQmXx9GOifV4Oa3EVi8Kt8+m81zE29
        eucr6DcGToMCkDfkLdufIzYBzA==
X-Google-Smtp-Source: AMrXdXslzEfD10arj67onobgRm+nyF7tr6gURXtW/cnts8rC6EvRTZwFLHwyesMdVC8XypAdh4tYvQ==
X-Received: by 2002:a6b:d107:0:b0:6e2:d939:4f30 with SMTP id l7-20020a6bd107000000b006e2d9394f30mr324050iob.0.1671641087245;
        Wed, 21 Dec 2022 08:44:47 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a20-20020a056638059400b0038a06a14b37sm5772938jar.103.2022.12.21.08.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 08:44:46 -0800 (PST)
Message-ID: <cdfc618a-5091-8989-7ca2-5d8d467b4adb@linuxfoundation.org>
Date:   Wed, 21 Dec 2022 09:44:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dma-mapping: benchmark: Fix compile error in user-space
 tool
Content-Language: en-US
To:     Gerd Bayer <gbayer@linux.ibm.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
References: <20221205135022.49708-1-gbayer@linux.ibm.com>
 <fd189113-deae-d6b7-bb9a-a5a94f7b0815@hisilicon.com>
 <3193d6833feccc5c2fbdef9b1f71f292eddb8f27.camel@linux.ibm.com>
 <4d8454c5-35d9-13f7-9571-4d38006061e2@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4d8454c5-35d9-13f7-9571-4d38006061e2@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/21/22 09:39, Shuah Khan wrote:
> On 12/16/22 07:35, Gerd Bayer wrote:
>> On Tue, 2022-12-06 at 11:13 +0800, chenxiang (M) wrote:
>>>
>>> 在 2022/12/5 21:50, Gerd Bayer 写道:
>>>> Since [1] the user-space program dma_map_benchmark shares the
>>>> header file
>>>> linux/map_benchmark.h with the kernel driver in
>>>> kernel/dma/map_benchmark.c.
>>>> With latest kernel version this does not compile any more.
>>>>
>>>> While https://kernelnewbies.org/KernelHeaders suggests otherwise,
>>>> allow it
>>>> to use of kernel headers through the uapi/ include direcotry. I
>>>> assume we can
>>>> do so safely, since the controlling user-space program is
>>>> distributed with
>>>> the kernel.
>>>>
>>>> With this change dma_map_benchmark compiles with just the obvious
>>>> warning
>>>> about uapi usage on ARCH=x86 and s390 and runs on ARCH=s390.
>>>>
>>>> [1] commit 8ddde07a3d28 ("dma-mapping: benchmark: extract a common
>>>> header file for map_benchmark definition")
>>>>
>>>> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>>>
>>> It also solves the compile error on arm64 platform.
>>> Acked-by:  Xiang Chen <chenxiang66@hisilicon.com>
>>
>> Hi Xiang Chen, hi Shuah,
>>
>> so is there any chance to have this compile fix integrated into linux-
>> next still, or is this too late now?
> Plan to apply this after the merge window closes
> 

The reason for the delay is this patch doesn't have the right commit
header. This should have been "selftests:dma -----"

It makes it easier for maintainers to parse and pay attention to the
patches if they indicate the area they fall under. Something to
keep in mind for your future patches.

Please resend the patch with the Acks you received and a correct
commit header.

thanks,
-- Shuah
