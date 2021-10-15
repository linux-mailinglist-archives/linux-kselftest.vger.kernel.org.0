Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7879942F721
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Oct 2021 17:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbhJOPrJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Oct 2021 11:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbhJOPrJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Oct 2021 11:47:09 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C634AC061762
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Oct 2021 08:45:02 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id i189so8258219ioa.1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Oct 2021 08:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tsavfGnFECXuxpubCpirg1R3vZvOUaYaxqi9oyOqKwo=;
        b=ChuHOHn0/F6tN80qDqx9dphmlweCzg+OUkJILwXpV4FyCUsmzM00TVEQEtEJS0/OfH
         75MS+LsCPDS7lS0bjpnJTrsuKJne4+iEN9CAiHQ2SZMpSZrKBHaQ5J/5Bj6vzm1DSr4x
         bK0R94yakoD0MlswRcVe6G7eycVzh7nKTfjwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tsavfGnFECXuxpubCpirg1R3vZvOUaYaxqi9oyOqKwo=;
        b=X2RzeFGtgoEi3pTfG5FOtqSOGPw47CDtI+pRaJWLryoC+q2vHWvN7ZiwAgWEH5jDPD
         lX7SLm9oCDxKdsBytBHW0e0CGMtUd4XiZw2PAEHouE3rOeXrtx4cxPCc66q4X74vMp0U
         a3GmAywMleABdl6vVaTDJ0p538+jxRxr+XBnmA0HiNW+ghpI4T6fdAYVFPrrq32YxVK3
         vYxMCl2G6aQ2C1ccReFtx6UfkPTY6n1cviUOVh+6652OnC/hQZ9CRnkBt8N0L0FvD14h
         /T1jQFq02oSA4tST+UTekMNsHt65EiaATAhrExdSh5CHquWOM2+UjC1Roh2jLgGLA8LK
         Ll4A==
X-Gm-Message-State: AOAM531UXkzFunX8oYdOFsDG8mjPWleP4WaDOAc2l6M9AyEUrrsU9479
        bRBfZTkCFS7FVG7AhA/WOZEO2KmjleQ=
X-Google-Smtp-Source: ABdhPJzdiLVhltf+etzX2lpHjoHWVtxfWghpmqDVlhoBkxCySer4V5YZdZfhfpCYJ8FCX6cCCia1cg==
X-Received: by 2002:a05:6602:15cc:: with SMTP id f12mr4251184iow.33.1634312702114;
        Fri, 15 Oct 2021 08:45:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q17sm2595902iot.16.2021.10.15.08.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 08:45:01 -0700 (PDT)
Subject: Re: selftests/vm madv_populate.c test
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <b703a326-66f7-bf35-58ee-f60e504ea5ef@linuxfoundation.org>
 <0a20f6b6-5985-8b3e-a577-7495dcf7d2b8@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3a06d58e-7301-6fbc-a305-d9f7c7220843@linuxfoundation.org>
Date:   Fri, 15 Oct 2021 09:45:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <0a20f6b6-5985-8b3e-a577-7495dcf7d2b8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/18/21 1:41 AM, David Hildenbrand wrote:
> On 18.09.21 00:45, Shuah Khan wrote:
>> Hi David,
>>
>> I am running into the following warning when try to build this test:
>>
>> madv_populate.c:334:2: warning: #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition" [-Wcpp]
>>     334 | #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>         |  ^~~~~~~
>>
>>
>> I see that the following handling is in place. However there is no
>> other information to explain why the check is necessary.
>>
>> #if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
>>
>> #else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
>>
>> #warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
>>
>> I do see these defined in:
>>
>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_READ       22
>> include/uapi/asm-generic/mman-common.h:#define MADV_POPULATE_WRITE      23
>>
>> Is this the case of missing include from madv_populate.c?
> 
> Hi Shuan,
> 
> note that we're including "#include <sys/mman.h>", which in my
> understanding maps to the version installed on your system instead
> of the one in our build environment.ing.
> 
> So as soon as you have a proper kernel + the proper headers installed
> and try to build, it would pick up MADV_POPULATE_READ and
> MADV_POPULATE_WRITE from the updated headers. That makes sense: you
> annot run any MADV_POPULATE_READ/MADV_POPULATE_WRITE tests on a kernel
> that doesn't support it.
> 
> See vm/userfaultfd.c where we do something similar.
> 

Kselftest is for testing the kernel with kernel headers. That is the
reason why there is the dependency on header install.

> 
> As soon as we have a proper environment, it seems to work just fine:
> 
> Linux vm-0 5.15.0-0.rc1.20210915git3ca706c189db.13.fc36.x86_64 #1 SMP Thu Sep 16 11:32:54 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> [root@vm-0 linux]# cat /etc/redhat-release
> Fedora release 36 (Rawhide)

This is a distro release. We don't want to have dependency on headers
from the distro to run selftests. Hope this makes sense.

I still see this on my test system running Linux 5.15-rc5.

Can we make this work with kernel headers?

thanks,
-- Shuah
