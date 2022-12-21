Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC5165342F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Dec 2022 17:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiLUQjz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Dec 2022 11:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbiLUQjt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Dec 2022 11:39:49 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CB62409D
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Dec 2022 08:39:44 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id o8so8178830ilo.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Dec 2022 08:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJv9sSk3LH0ctRq+GSx0QRE7n076T4kZpSaDbwm0BYw=;
        b=K6tqFqUEa9ql+ItqkIqrkxHJgtW16wZoP23cY2GcwftVuJkTOV5zY1tmZHLw7lGjOD
         sbs2NCPXH+qr65VMhOG8lWmAup3SsuINZ9xxjS1PRCNXbnw9ufVy//5y9VbtGclTNjg9
         PuLj83qRVoEXzkKW4CpvF7Zll+Cc9+5q4YkUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJv9sSk3LH0ctRq+GSx0QRE7n076T4kZpSaDbwm0BYw=;
        b=Cw2+5rt1kKks8HdIhJ4kOX5Y5VCJNO4L6AQBEyVwQ8fxh1wRwUQXXVFydVoQi0859B
         7hwBQuOp9gqTOnT0272c8q9AriOIjrVAkxROwz3bt1uBRkuIRD9sWvMRMvze/czbzFkt
         VGZTMtbRC4DxcVwaF4lH2Z36XY3k9gOvhQXXR5tBazH/32oDZmAPBRCE+u1cLNf+TrCn
         jS+M+RAAS5FqB0dRvljfrwdXCp/psJg36AJf/xD9ZQBCLblg3eAQz2lmxY5c1G+qKgu7
         3h/97VXC7GudYxc8zXE7wO/4R+AgJGosHzVcDWrAHLq651+75rDgbwaxvAZUsUaSeGO3
         bxiA==
X-Gm-Message-State: AFqh2kqu2OVAKCcBooGDPV/ZsZ/eldDYnobcyb7luAcOf/oeijVx94J9
        nPJ35X811+WjXqKAvgK7q/S1ew==
X-Google-Smtp-Source: AMrXdXvAt0fwEKLr5wHexrBEQy7szS5MT9hxvf/v2h/OwBgxdKwuvS+tCk1TPQHC6JSbr7mm8c1kjA==
X-Received: by 2002:a05:6e02:dc9:b0:302:d868:8ded with SMTP id l9-20020a056e020dc900b00302d8688dedmr373706ilj.0.1671640784191;
        Wed, 21 Dec 2022 08:39:44 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f23-20020a02b797000000b0037cb59b5c28sm5592360jam.52.2022.12.21.08.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 08:39:43 -0800 (PST)
Message-ID: <4d8454c5-35d9-13f7-9571-4d38006061e2@linuxfoundation.org>
Date:   Wed, 21 Dec 2022 09:39:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dma-mapping: benchmark: Fix compile error in user-space
 tool
To:     Gerd Bayer <gbayer@linux.ibm.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221205135022.49708-1-gbayer@linux.ibm.com>
 <fd189113-deae-d6b7-bb9a-a5a94f7b0815@hisilicon.com>
 <3193d6833feccc5c2fbdef9b1f71f292eddb8f27.camel@linux.ibm.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3193d6833feccc5c2fbdef9b1f71f292eddb8f27.camel@linux.ibm.com>
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

On 12/16/22 07:35, Gerd Bayer wrote:
> On Tue, 2022-12-06 at 11:13 +0800, chenxiang (M) wrote:
>>
>> 在 2022/12/5 21:50, Gerd Bayer 写道:
>>> Since [1] the user-space program dma_map_benchmark shares the
>>> header file
>>> linux/map_benchmark.h with the kernel driver in
>>> kernel/dma/map_benchmark.c.
>>> With latest kernel version this does not compile any more.
>>>
>>> While https://kernelnewbies.org/KernelHeaders suggests otherwise,
>>> allow it
>>> to use of kernel headers through the uapi/ include direcotry. I
>>> assume we can
>>> do so safely, since the controlling user-space program is
>>> distributed with
>>> the kernel.
>>>
>>> With this change dma_map_benchmark compiles with just the obvious
>>> warning
>>> about uapi usage on ARCH=x86 and s390 and runs on ARCH=s390.
>>>
>>> [1] commit 8ddde07a3d28 ("dma-mapping: benchmark: extract a common
>>> header file for map_benchmark definition")
>>>
>>> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>>
>> It also solves the compile error on arm64 platform.
>> Acked-by:  Xiang Chen <chenxiang66@hisilicon.com>
> 
> Hi Xiang Chen, hi Shuah,
> 
> so is there any chance to have this compile fix integrated into linux-
> next still, or is this too late now?
Plan to apply this after the merge window closes

thanks,
-- Shuah

