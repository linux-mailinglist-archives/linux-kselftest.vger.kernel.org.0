Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5BC42F73D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Oct 2021 17:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbhJOPtR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Oct 2021 11:49:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234829AbhJOPtQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Oct 2021 11:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634312830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+Q0m93eDQUsQs996BqvSBuleHVWdL0Hp5smaHrBxAk=;
        b=Ugj5e9KvEojWtKPDAmFwc4swoMNHCr25hAQbZSMRW2TfSJRyRGVTo1Y6xF9+bnBY0Eo8Nu
        nOKL5STS0v9RUFMDzO8QWFbA4ChkuWDMx98dwrb39V9Irki15K/fLsZmPHC/moDbUTr4vo
        UAtsPXt6CMtBTP1/pRDLXYsh41R5Yj0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-Se7FkW_cNIi956Sn6KPS6A-1; Fri, 15 Oct 2021 11:47:07 -0400
X-MC-Unique: Se7FkW_cNIi956Sn6KPS6A-1
Received: by mail-wm1-f69.google.com with SMTP id 204-20020a1c01d5000000b003101167101bso778176wmb.3
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Oct 2021 08:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=/+Q0m93eDQUsQs996BqvSBuleHVWdL0Hp5smaHrBxAk=;
        b=yQ2Jud6rTc7565sANCz0ehwGh2qGibKFNMe6t21la//Leh3QJ+XMMErj89FaR/Q5R9
         hy6MEbO8y1t9Qx70dRJ7NWoFLGdisT6ZZfmvpwlZ8I419r0jDpJY31VSXPDKe9hxwzd6
         mJp9AzfxF16SY4vXM3li70+aaXF3/zK4JryZvNFhiBx3ZRZUSN+ThPYjQ96u280YG+dm
         RZ62On53dp/Sn5Tpix1ZtOps4Fop/MpcNmfv+Imu44kdXfeEpxI8yLBAf1ndXf2zHrKO
         BPJT1FBf3LMCtR2ivpi2TKdIUtnZjIYJedT2tKUYsxh+KWEsA8fov2rwooAzGID+sTPa
         9brw==
X-Gm-Message-State: AOAM532361ydUMkXmg18UuHLTbnBeLw8b/hEeKtwgiAKDhSqkPmt1mri
        4m24unkcXm4ZCMWBzLAA2wGfzmT96zBKI32QIt1I6bo7Tjnnt+zzL2D3qTc8zwryET0i2TmRQbM
        vN7HfoZRydW6/OFNQuz9mTef1bkoy
X-Received: by 2002:a05:600c:4ecb:: with SMTP id g11mr12990759wmq.67.1634312824942;
        Fri, 15 Oct 2021 08:47:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZ8cZ4RHjQrgJ/5N2T4Zi0Zesg0WM8aufR8Y+rPU6qtgwPr28uz+3Y80ilegTf+T+SZ91+/Q==
X-Received: by 2002:a05:600c:4ecb:: with SMTP id g11mr12990737wmq.67.1634312824703;
        Fri, 15 Oct 2021 08:47:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6a01.dip0.t-ipconnect.de. [91.12.106.1])
        by smtp.gmail.com with ESMTPSA id w1sm10807575wmc.19.2021.10.15.08.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 08:47:04 -0700 (PDT)
Message-ID: <b99b5960-b1ec-b968-1d9c-d125a23c59fe@redhat.com>
Date:   Fri, 15 Oct 2021 17:47:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: selftests/vm madv_populate.c test
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b703a326-66f7-bf35-58ee-f60e504ea5ef@linuxfoundation.org>
 <0a20f6b6-5985-8b3e-a577-7495dcf7d2b8@redhat.com>
 <3a06d58e-7301-6fbc-a305-d9f7c7220843@linuxfoundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3a06d58e-7301-6fbc-a305-d9f7c7220843@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 15.10.21 17:45, Shuah Khan wrote:
> On 9/18/21 1:41 AM, David Hildenbrand wrote:
>> On 18.09.21 00:45, Shuah Khan wrote:
>>> Hi David,
>>>
>>> I am running into the following warning when try to build this test:
>>>
>>> madv_populate.c:334:2: warning: #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition" [-Wcpp]
>>>     334 | #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>         |  ^~~~~~~
>>>
>>>
>>> I see that the following handling is in place. However there is no
>>> other information to explain why the check is necessary.
>>>
>>> #if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
>>>
>>> #else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
>>>
>>> #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>>
>>> I do see these defined in:
>>>
>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_READ       22
>>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_WRITE      23
>>>
>>> Is this the case of missing include from madv_populate.c?
>>
>> Hi Shuan,
>>
>> note that we're including "#include <sys/mman.h>", which in my
>> understanding maps to the version installed on your system instead
>> of the one in our build environment.ing.
>>
>> So as soon as you have a proper kernel + the proper headers installed
>> and try to build, it would pick up MADV_POPULATE_READ and
>> MADV_POPULATE_WRITE from the updated headers. That makes sense: you
>> annot run any MADV_POPULATE_READ/MADV_POPULATE_WRITE tests on a kernel
>> that doesn't support it.
>>
>> See vm/userfaultfd.c where we do something similar.
>>
> 
> Kselftest is for testing the kernel with kernel headers. That is the
> reason why there is the dependency on header install.
> 
>>
>> As soon as we have a proper environment, it seems to work just fine:
>>
>> Linux vm-0 5.15.0-0.rc1.20210915git3ca706c189db.13.fc36.x86_64 #1 SMP Thu Sep 16 11:32:54 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>> [root@vm-0 linux]# cat /etc/redhat-release
>> Fedora release 36 (Rawhide)
> 
> This is a distro release. We don't want to have dependency on headers
> from the distro to run selftests. Hope this makes sense.
> 
> I still see this on my test system running Linux 5.15-rc5.

Did you also install Linux headers? I assume no, correct?

-- 
Thanks,

David / dhildenb

