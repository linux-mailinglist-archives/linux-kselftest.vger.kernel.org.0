Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEFB3FF54A
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 23:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346400AbhIBVGb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346156AbhIBVGa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 17:06:30 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F489C061575
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Sep 2021 14:05:32 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h29so3238957ila.2
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Sep 2021 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UKQA6105U/KVkWHwxi6wOBNzf8KnL2jJdYFFqD/Cpts=;
        b=AL45Z9yfhzYsQXhwsWSSSzmSFoHTh1zXmGbd5aRZ7bMHRzX3/6EzZJOX+caYIleCK4
         yar37y95+8ts5wed/FTUHeCjZNtm9B/u5DEsYplmUreErb3Ii608+msxCKVLGx5fFIHm
         G4G2TdtEn1JmzXhnKwOYbw0CPuunD5ad2bh/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UKQA6105U/KVkWHwxi6wOBNzf8KnL2jJdYFFqD/Cpts=;
        b=j0MWDb0r1IUeqYPzE5A80ATW+0WAyCVq51wSfJU3T+ARw/3tsquqm1wjRvz1PRu4rM
         6+u7d8vZAMBMThxPD2YN7MRijamZD9Y22QRRcbIPnF3ZT3fCn2DnkyEMzfKZZr2ldFg0
         LfcDRY8N6BnWTCOUtZVLkToMVCfToelAfHSszaVZR1phDlo+wxSHU02/yAQTsRL5NBek
         yjxsFO+RntKPtJaOiKUr9PunnmK5DTH0ZeCOOrDq8OIbF6E0XztSUfiREU28edR2ZT96
         qQrPCEDcJzK11orfpPkx067fDNSIn1U5Ulg/+1HV7jUIxWlmYRvP8q5KfrfMTHr9pYev
         zHZA==
X-Gm-Message-State: AOAM531Z4cB5zGLuXyxxHcLO2zu+O2t/HduYUvN6aPatOaxT+rkHeaia
        PSbDEfLE/HMipTDJNic4WbuQ5w==
X-Google-Smtp-Source: ABdhPJw5GAc9DTRWylSMfJnI1zbZ0iQjuwMt7FZFYe2a3rMq6xrlZ5peC24FrbeFUtjMrOgHri01iA==
X-Received: by 2002:a92:c109:: with SMTP id p9mr98850ile.115.1630616731535;
        Thu, 02 Sep 2021 14:05:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d14sm1719037iod.18.2021.09.02.14.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 14:05:31 -0700 (PDT)
Subject: Re: [V3][PATCH] selftests/x86: Fix error: variably modified
 'altstack_data' at file scope
To:     Jun Miao <jun.miao@windriver.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210824024358.4183342-1-jun.miao@windriver.com>
 <09fb52ee-3041-991a-0277-ff01eef2643f@windriver.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c21053a0-c3bb-4cda-4f16-24427dd5b0ff@linuxfoundation.org>
Date:   Thu, 2 Sep 2021 15:05:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <09fb52ee-3041-991a-0277-ff01eef2643f@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/2/21 2:45 AM, Jun Miao wrote:
> Hi all,
> 
> What about this patch?
> 
> Thanks
> Jun
> 
> 
> On 8/24/21 10:43 AM, Jun Miao wrote:
>> Based on glibc 2.33 -> 2.34, there is one new feature:
>>

Please don't top post.

It is applied to linux-kselftest next for Linux 5.15-rc1

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next

thanks,
-- Shuah
