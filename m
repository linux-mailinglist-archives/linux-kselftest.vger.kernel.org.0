Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287BB2637CF
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Sep 2020 22:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIIUtM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Sep 2020 16:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbgIIUtE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Sep 2020 16:49:04 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73249C061573
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Sep 2020 13:49:03 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t13so3645534ile.9
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Sep 2020 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hx4c3GIuv16DFuUNrX0P7a0FqrG5ZXLPK5uInGDH+uc=;
        b=X/4Oxj0XETaW4Z8kWLEu5GO2V4ksuf2+PcPOE6hTPkpE8PyFPydMHVYLr7DmtvOEmW
         2nq7+hyh2blxtxDhNTbsTIhWrzluse1y57Vkn61re6s3qNtaHvJYcVi+tEup++kynjWm
         j58xZUaj5pWl+nwBUhFCVyPyD56//TfLgByKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hx4c3GIuv16DFuUNrX0P7a0FqrG5ZXLPK5uInGDH+uc=;
        b=MqSsGXpjohkYQapAKOkhI3oYD5Aias+WxmEoQCqGK7UFqyB38qsQI44aNccMhwptSE
         dR3YZ+vZPOx6R+tOegRTuZ9E7ArYv+P8Np4ByzUJMMrXNbo3LgCqdruaVpyzxwJLCpIm
         z6r/wNrypJzwwGbqBHCSXyw33AUExHVQzqk3cv4FrMP+z/tA/94f8YrrLLuROjM9CHSI
         UELWYd5OfEJtpthhGMnCjUYL+fkKX1TNw22hChhFN/zno2NsUyo9ghSEFrwjB/LWA3pP
         mUveQwh3KmsCbZthnhahDPAoZwbwaxWWqyrU8ZSuZlPixiqASG2pjgTIooPzLdJWPL4q
         +RTQ==
X-Gm-Message-State: AOAM532EAG9fqHeiiIDkhNnX8cXdpVjDrbB9xcCKV84ntKPL9APt6Fv+
        9nu2pswW/pEUpwajBlXve9/jyw==
X-Google-Smtp-Source: ABdhPJxWwJJ8zHQ9V/VMrokA1q2M1spiFJgBXeZrNoZOF2JS5XckGcnfEsLGNalCYLSSbV8GoIi7wA==
X-Received: by 2002:a92:9ec3:: with SMTP id s64mr5261269ilk.294.1599684542673;
        Wed, 09 Sep 2020 13:49:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h184sm1746394ioa.34.2020.09.09.13.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 13:49:02 -0700 (PDT)
Subject: Re: [PATCH] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202006261358.3E8AA623A9@keescook>
 <202009091247.C10CDA60C@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7271a7e7-c4fb-c656-f6d2-6ff4a29a9e06@linuxfoundation.org>
Date:   Wed, 9 Sep 2020 14:49:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202009091247.C10CDA60C@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/9/20 1:49 PM, Kees Cook wrote:
> 
> On Fri, Jun 26, 2020 at 01:59:43PM -0700, Kees Cook wrote:
>> Instead of full GNU diff (which smaller boot environments may not have),
>> use "comm" which is more available.
>>
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>> Link: https://lore.kernel.org/lkml/CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com
>> Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running tests")
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Shuah, this really needs to land to fix lkdtm tests on busybox. Can
> you add this to -next? (Or is it better to direct this to Greg for the
> lkdtm tree?)
> 

Kees, Thanks for the ping. I can queue this up in -next

Greg, would you like me to take this through selftest tree?

In case you want to take this through lkdtm tree:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


