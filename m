Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CF4263860
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Sep 2020 23:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgIIVS7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Sep 2020 17:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbgIIVS4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Sep 2020 17:18:56 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB89DC061755
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Sep 2020 14:18:55 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r25so4845918ioj.0
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Sep 2020 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YGsQQlz6o7re87zliFW6CFb7fsznxyHEdlHXDCAkS/M=;
        b=B+XJN/PQh4hCB2hzKIrjAtQmclW/e7KA6p9/oKkiG/oLJsvkyb8oBzvacTjPcogtHp
         406Ao3BGmnAl+5Xsx9Zmj/FYJarVhT6eZHDwV9b0bkcOxqe55Sy2o7OlR0KiVSpVl6hD
         V2iKJ2arseDOs3bReM4RhkNmFFOD+jI9Ui5lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YGsQQlz6o7re87zliFW6CFb7fsznxyHEdlHXDCAkS/M=;
        b=kgtj3EccW5tCiFNzf4G5r2EKQ79thA4vYhgQBs+QWRqAb5kMMzf+UNgf6WnNBKcYQU
         osM6F2l/oLm36GYFnjXCwIVp23qYEpFc6l55hDp+iKy2NiYS/01NZrrMyuBlJtD/poHe
         knrAiRsxBAk4/7kB2ExDlDJUFc/6X3kBcOW6344Bi5FmeSlfvH/TqhlN7RF3CBnZGzQ8
         IUhX4EDrvcUaSLtBfOW4PLcDutrJ9010TwtnppXUwSyyhpIU3PDd2R7Q/DW+0TnHszxc
         dibTbmh9MuxA/zCa4yge9IomYJNjQUwoYK0PhRLrYjU5QxxcL7iqY6Oh+wOYBGhO8oeU
         hCwA==
X-Gm-Message-State: AOAM532b4ufCrdYUFKPKsS/jiQUZkfZypF6yB/byn02IB+tsVPLCgz+7
        FAdaX/cG8ta+NNxBm1L98K+dvQ==
X-Google-Smtp-Source: ABdhPJwEGOpQQ/oFPj/OTMIB4P9DK001RefgaqrQ3mSdAFXYoJFPmqBPCYTG7w22csuPnaHZy8gfiA==
X-Received: by 2002:a6b:6e0b:: with SMTP id d11mr4919660ioh.155.1599686335302;
        Wed, 09 Sep 2020 14:18:55 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r2sm1990810ilq.18.2020.09.09.14.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 14:18:54 -0700 (PDT)
Subject: Re: [PATCH] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <202006261358.3E8AA623A9@keescook>
 <202009091247.C10CDA60C@keescook>
 <7271a7e7-c4fb-c656-f6d2-6ff4a29a9e06@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e3c86b0d-ca8c-51a1-4678-f3d37a8f8a3f@linuxfoundation.org>
Date:   Wed, 9 Sep 2020 15:18:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7271a7e7-c4fb-c656-f6d2-6ff4a29a9e06@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/9/20 2:49 PM, Shuah Khan wrote:
> On 9/9/20 1:49 PM, Kees Cook wrote:
>>
>> On Fri, Jun 26, 2020 at 01:59:43PM -0700, Kees Cook wrote:
>>> Instead of full GNU diff (which smaller boot environments may not have),
>>> use "comm" which is more available.
>>>
>>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>>> Link: 
>>> https://lore.kernel.org/lkml/CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com 
>>>
>>> Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running 
>>> tests")
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Shuah, this really needs to land to fix lkdtm tests on busybox. Can
>> you add this to -next? (Or is it better to direct this to Greg for the
>> lkdtm tree?)
>>
> 
> Kees, Thanks for the ping. I can queue this up in -next
> 
> Greg, would you like me to take this through selftest tree?
> 
> In case you want to take this through lkdtm tree:
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 

Kees,

Just saw your reply. Will wait for v2.

thanks,
-- Shuah

