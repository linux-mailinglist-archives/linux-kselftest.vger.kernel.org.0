Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3A5352F07
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 20:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhDBSRV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 14:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBSRU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 14:17:20 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B956C0613E6
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 11:17:19 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id j26so943573iog.13
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MppYn/UXCzXUeFQ9QuY+HhvUiGYS5v7hTH678naDMjo=;
        b=Gccb48jTfp0xOqHNAxpElEa0vpUNrXs6dKypa8AfB5aImP8C9GxX4OhDLH53wZLNpK
         YTCFqTUTtynvQmK9Du7XZ6P6dA8l/1Cy71QgHbWfVTZ+SiSxuf8M4ICEgoaAz2edp+P7
         F9s0d8St5QYC6l1n2i2Z3nksfO3kB+kJx01Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MppYn/UXCzXUeFQ9QuY+HhvUiGYS5v7hTH678naDMjo=;
        b=Sjvr38VN2QjOM287VmrYZCoPH7RhFfUQncZoWTsF2Au4nDOeNKp1v8tE0gsgHoNRBI
         imd2WmHCvzwTzbY0nlcGzB7Eyg0pKb0HPMDRbC457QkIFrjWWwa5a889lCWUdFuL6L+e
         f5roDzXYsAGU/cI4v3Lvxas+M0WQi4loV7XuuiiuSHywfrfDJZtlqjGGubFs2MVyIYhG
         f0/wr9Crp/xK5qY44iDkfgRO9qnpmTlH6d8Wt8byxUDJvOBrVUtx3MbClRYycb1HlsYy
         zY/UHHZe7kWczFOQQlHmTPuorw6ZguJDNA97ZMPDtkDtwgJEA96Ib+O991CocBLqYvsE
         GLjg==
X-Gm-Message-State: AOAM532gD86e2zT25lMiW8kY2wtqscdrr2D2Q/JeJM1zQQMQsCjr/iNB
        zmLTeJ5tPtrFkwPqdCV0Llnlyg==
X-Google-Smtp-Source: ABdhPJxLL6rMb265VjtQLIAW8AiSzjaC4AqhYR5VsWhlA9YdsXu9H9vmhyFdBTn1HHm8qHg2Av2POg==
X-Received: by 2002:a05:6638:3884:: with SMTP id b4mr13915229jav.18.1617387438725;
        Fri, 02 Apr 2021 11:17:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s15sm2583607ilv.13.2021.04.02.11.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 11:17:18 -0700 (PDT)
Subject: Re: [PATCH v6 00/21] Miscellaneous fixes for resctrl selftests
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
 <YF451jic7QNyUCVD@otcwcpicx3.sc.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b10f5509-5111-e3e4-c247-dde542c36358@linuxfoundation.org>
Date:   Fri, 2 Apr 2021 12:17:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YF451jic7QNyUCVD@otcwcpicx3.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/26/21 1:45 PM, Fenghua Yu wrote:
> Hi, Shuah,
> 
> On Wed, Mar 17, 2021 at 02:22:34AM +0000, Fenghua Yu wrote:
>> This patch set has several miscellaneous fixes to resctrl selftest tool
>> that are easily visible to user. V1 had fixes to CAT test and CMT test
>> but they were dropped in V2 because having them here made the patchset
>> humongous. So, changes to CAT test and CMT test will be posted in another
>> patchset.
>>
>> Change Log:
>> v6:
>> - Add Tested-by: Babu Moger <babu.moger@amd.com>.
>> - Replace "cat" by CAT_STR etc (Babu).
>> - Capitalize the first letter of printed message (Babu).
> 
> Any comment on this series? Will you push it into linux-kselftest.git?
> 
Yes. Will apply for 5.13-rc1

thanks,
-- Shuah
