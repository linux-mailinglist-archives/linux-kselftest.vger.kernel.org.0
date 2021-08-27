Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD343F9D2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Aug 2021 19:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhH0RBh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Aug 2021 13:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhH0RBh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Aug 2021 13:01:37 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D52DC061757
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Aug 2021 10:00:48 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id g9so9334561ioq.11
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Aug 2021 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qY4u/QSD5mvN8lZY5uxrxfQLztvCoO84v1j/fKkjLkI=;
        b=LPqgm/9TH4nNGDCyZZ+4DPZiv/R/j2OSqWJ0xY8S5J4VYdZGOGN/5ViAHEr76dVQNK
         g2OZnECtAoKXXulNItoW6GV6ysXWtHE3keN7i7Wz2DtBmDUEk6GslNB4PwnnthtjnF/7
         d/fj0vixpa6PnDLxTO5HPh+6IltjOtwtnxyqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qY4u/QSD5mvN8lZY5uxrxfQLztvCoO84v1j/fKkjLkI=;
        b=JsM6ZBobBtWSCdrR0XCnq5xHFIK73N1h2fYtEPoPIPmsEVhaY8fH4Ut7BxRLsmKP6K
         vG339wII9ZwRZIRVP/WOUl4dJHdlzn3oNWI3OSsegMevUTV3VAFAcmj1C+7uW6NdZ7E/
         MI8atR4hyYNQOT1gL4+925YJ2kyWJQmwErrfZTFSeDITTVh48oYWkG6VR3Ji35+oPAo3
         3CDjfFeOSsAaiF6vADqFBwu3dMMfd2yXbGayPrlMO4RMtzUeHMgonJbPUgQlmokfDrl2
         qRcEpmZk/JP+voYpTf5tyhQc7JhutP1x7GMZgO6q9eMFH0Kbmuuy7YetNgtWuc8dFWrP
         i0uQ==
X-Gm-Message-State: AOAM530YxU5VLXP1n2eA/oH2Ozi8utqbdhCF77+7vjrZu3qKTpmpa2aA
        MyzwpESwYctqOhr/zs9noPuAiA==
X-Google-Smtp-Source: ABdhPJwfB545VC1ov4ZmZTc67mKTH9BKIPoYlMHkgxx/oHH0ac0FXfe2j6fO1jqjoFTV3kaUhkVhjg==
X-Received: by 2002:a5d:83c4:: with SMTP id u4mr8436013ior.21.1630083647725;
        Fri, 27 Aug 2021 10:00:47 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o5sm3448725iow.48.2021.08.27.10.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 10:00:45 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] selftests/sync: Remove the deprecated config SYNC
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc:     "philip.li@intel.com" <philip.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210826015847.7416-1-lizhijian@cn.fujitsu.com>
 <20210826015847.7416-2-lizhijian@cn.fujitsu.com>
 <239339d5-5626-ea04-97db-7dc070a48636@linuxfoundation.org>
 <69835666-1710-5103-fb06-2636a3a3c5bb@fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2c141f7e-bec8-49ad-2d2b-d238a372b0e6@linuxfoundation.org>
Date:   Fri, 27 Aug 2021 11:00:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <69835666-1710-5103-fb06-2636a3a3c5bb@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/26/21 7:35 PM, lizhijian@fujitsu.com wrote:
> 
> 
> On 27/08/2021 05:10, Shuah Khan wrote:
>> On 8/25/21 7:58 PM, Li Zhijian wrote:
>>> SYNC was removed since aff9da10e21 ("staging/android: make sync_timeline internal to sw_sync")
>>> LKP/0Day will check if all configs listing under selftests are able to be enabled properly.
>>>
>>
>> Can you please state what you arr fxing and also keep the sentences
>> 75 chars or less.
>>
>> Where is LKP warning?
> https://01.org/lkp
> LKP(aka. 0Day) often reports issue related to the *recent* kernel commits/WIP patches publicly.
> As the LKP keeping improvement, it will cover more aspects in the kernel so that more issues will be detected.
> 
> So in this case, which is related to too old kernel, it just reported it internally.
> 
> 
>> Include the warning and explain why this
>> change is necessary.
> - it's not reasonable to keep the deprecated configs, right ?
> 
> - In my understanding, configs under kselftests are recommended by corresponding tests.
> So if some configs are missing, it will impact the testing results
> 
> Do you mean the commit log should include above 2 reasons ?
> 

Correct. I am asking the commit log to include these details.

thanks,
-- Shuah
