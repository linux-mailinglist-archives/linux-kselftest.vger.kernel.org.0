Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC69027B7E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 01:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgI1XTS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 19:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgI1XSm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 19:18:42 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5B7C0610E0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 16:01:58 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id y5so2664306otg.5
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 16:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G0T+RHalnOsx2x8ckC0/qbcC+AW5CzDJJe/ApeOC0+k=;
        b=Bm4inKBH6owPhXAt+WYO1qUH2sD6gp/JHO/rGqnxUTTZurVuB2oOlCFyuxF6Mrm1Fb
         Jl3P3mG83W6n3SQ1lAam+xSpWMDhH6aKSofFE4lx90AFeuypIUoqFdZzThdjUvc+zhBH
         v12MOvqlrd7l6N2Dd1M3mkf+WXumL1sotF7rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G0T+RHalnOsx2x8ckC0/qbcC+AW5CzDJJe/ApeOC0+k=;
        b=O1mPlhIHd6mj/BVNvpFYE6SONqxezKGLwVpvgLCkkahAmx9fS2qCgjh1WRphEv7/lZ
         YhI/BTGW+A4EPOCl1WPxiEusLd4VGTq+X+uoTRq4jzkqbhBZIR8f1LnysmTxMAZlYRal
         z7Tca5nvMJ9QRIxofl/i+EUUbJyTwoZDIniRkJvlNWKzQo36z+2ajjgJ7Blsl7BSdloY
         HMq6/C/q3HLocHXyTvcMTl6MebPorgnGMvL3VDWwuCqybLLEj1MptKdoPTG8VWuhYBv2
         OEkgC4vDNc7TgHd3vgzyNUNC4c7fkuD6iao23ZAr7/UbiEGPr9LO91ct/vxj9qheCwfg
         lIYQ==
X-Gm-Message-State: AOAM530MI++havgU2KQw3SU835KEwJTGGFh7eoMDx0fVFduQa9A7SvVB
        EvnusuhC6ymOpuOdw1xjZ1c5Og==
X-Google-Smtp-Source: ABdhPJwSkr7ZuRk8wTA1EBTCYkbbMO+PyhCPeIPgE2gfdGNAWiJW8KkTuzvV5dYyicY9sgk6dMhK3A==
X-Received: by 2002:a05:6830:1616:: with SMTP id g22mr823663otr.289.1601334117878;
        Mon, 28 Sep 2020 16:01:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a22sm559885oie.13.2020.09.28.16.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 16:01:57 -0700 (PDT)
Subject: Re: [PATCH 00/11] Introduce Simple atomic and non-atomic counters
To:     Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, shuah@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        arve@android.com, tkjos@android.com, maco@android.com,
        christian@brauner.io, hridya@google.com, surenb@google.com,
        minyard@acm.org, arnd@arndb.de, mchehab@kernel.org,
        rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
 <20200927233526.GA500818@google.com> <202009281331.444F36A7B@keescook>
 <20200928211709.GA2641213@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9c237ead-5b68-2e3f-2af6-a08c03b24fde@linuxfoundation.org>
Date:   Mon, 28 Sep 2020 17:01:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928211709.GA2641213@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/28/20 3:17 PM, Joel Fernandes wrote:
> On Mon, Sep 28, 2020 at 01:34:31PM -0700, Kees Cook wrote:
>> On Sun, Sep 27, 2020 at 07:35:26PM -0400, Joel Fernandes wrote:
>>> On Fri, Sep 25, 2020 at 05:47:14PM -0600, Shuah Khan wrote:
>>>> This patch series is a result of discussion at the refcount_t BOF
>>>> the Linux Plumbers Conference. In this discussion, we identified
>>>> a need for looking closely and investigating atomic_t usages in
>>>> the kernel when it is used strictly as a counter without it
>>>> controlling object lifetimes and state changes.
>>>>
>>>> There are a number of atomic_t usages in the kernel where atomic_t api
>>>> is used strictly for counting and not for managing object lifetime. In
>>>> some cases, atomic_t might not even be needed.
>>>>      
>>>> The purpose of these counters is twofold: 1. clearly differentiate
>>>> atomic_t counters from atomic_t usages that guard object lifetimes,
>>>> hence prone to overflow and underflow errors. It allows tools that scan
>>>> for underflow and overflow on atomic_t usages to detect overflow and
>>>> underflows to scan just the cases that are prone to errors. 2. provides
>>>> non-atomic counters for cases where atomic isn't necessary.
>>>
>>> Nice series :)
>>>

Thanks.

>>> It appears there is no user of counter_simple in this series other than the
>>> selftest. Would you be planning to add any conversions in the series itself,
>>> for illustration of use? Sorry if I missed a usage.
>>>
>>> Also how do we guard against atomicity of counter_simple RMW operations? Is
>>> the implication that it should be guarded using other synchronization to
>>> prevent lost-update problem?
>>>
>>> Some more comments:
>>>
>>> 1.  atomic RMW operations that have a return value are fully ordered. Would
>>>      you be adding support to counter_simple for such ordering as well, for
>>>      consistency?
>>
>> No -- there is no atomicity guarantee for counter_simple. I would prefer
>> counter_simple not exist at all, specifically for this reason.
> 
> Yeah I am ok with it not existing, especially also as there are no examples
> of its conversion/usage in the series.
> 

No. counter_simple is just for counting when there is no need for
atomicity with the premise that there might be some use-cases. You
are right that this patch series doesn't use these. My hunch is though
that atomic_t is overused and it isn't needed in all cases.

I will do some research to look for any places that can use
counter_simple before I spin v2. If I don't find any, I can drop them.

thanks,
-- Shuah

