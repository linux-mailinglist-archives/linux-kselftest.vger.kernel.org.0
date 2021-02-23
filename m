Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCD9323251
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Feb 2021 21:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhBWUpM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Feb 2021 15:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbhBWUpE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Feb 2021 15:45:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87428C061574;
        Tue, 23 Feb 2021 12:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=l5UvSZQBGxOmQXzZ6VSoS/UKjlC4X1+BkU4mQVd80w4=; b=0g6OjLI3dVsGvfbNA+i0UInTwN
        fW8P+kjwabvUYxrfx/CxyP8w/uAyI7/ag4no66N7J1V50IUlaWc1rfgpQsyQIF+xdXL7hA/qs9l6d
        QHqSSKPNo+Hk5xA7thfD2uFPsIqXmVR32bOacovC/CEaoaZXjuY8XhW2CpeCPQAXuc/6aUr8EOxiO
        bO+lzAUlkTbQAjIerrLU6Jtw5hakG3v3jOxjRRQ+iJXX6RQ84YNl3JsC5U2glaASOQcbLh8/Upyju
        jWnOQDaks9FZgYBeccj3tf434NgeQCSF8jNkOnb1Zh06ALBfIQFWBlcON5GtFvsFKHXuTnMSzDa46
        IIwivqaQ==;
Received: from [2601:1c0:6280:3f0::d05b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lEeXb-0004DS-UY; Tue, 23 Feb 2021 20:44:20 +0000
Subject: Re: [PATCH v3 3/8] securtiy/brute: Detect a brute force attack
To:     John Wood <john.wood@gmx.com>, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>, Shuah Khan <shuah@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20210221154919.68050-1-john.wood@gmx.com>
 <20210221154919.68050-4-john.wood@gmx.com>
 <f4fd9e44-539e-279e-a3a6-8af39f863f73@infradead.org>
 <20210223182054.GB3068@ubuntu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a0134e04-213f-2440-6d0b-adb018e49083@infradead.org>
Date:   Tue, 23 Feb 2021 12:44:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210223182054.GB3068@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/23/21 10:20 AM, John Wood wrote:
> Hi,
> 
> On Sun, Feb 21, 2021 at 06:47:16PM -0800, Randy Dunlap wrote:
>> Hi--
>>
>> scripts/kernel-doc does not like these items to be marked
>> as being in kernel-doc notation. scripts/kernel-doc does not
>> recognize them as one of: struct, union, enum, typedef, so it
>> defaults to trying to interpret these as functions, and then
>> says:
>>
>> (I copied these blocks to my test megatest.c source file.)
>>
>>
>> ../src/megatest.c:1214: warning: cannot understand function prototype: 'const u64 BRUTE_EMA_WEIGHT_NUMERATOR = 7; '
>> ../src/megatest.c:1219: warning: cannot understand function prototype: 'const u64 BRUTE_EMA_WEIGHT_DENOMINATOR = 10; '
>> ../src/megatest.c:1228: warning: cannot understand function prototype: 'const unsigned char BRUTE_MAX_FAULTS = 200; '
>> ../src/megatest.c:1239: warning: cannot understand function prototype: 'const unsigned char BRUTE_MIN_FAULTS = 5; '
>> ../src/megatest.c:1249: warning: cannot understand function prototype: 'const u64 BRUTE_CRASH_PERIOD_THRESHOLD = 30000; '
>>
>>
>> On 2/21/21 7:49 AM, John Wood wrote:
>>>
>>> +/**
>>> + * brute_stats_ptr_lock - Lock to protect the brute_stats structure pointer.
>>> + */
>>> +static DEFINE_RWLOCK(brute_stats_ptr_lock);
>>
>>> +/**
>>> + * BRUTE_EMA_WEIGHT_NUMERATOR - Weight's numerator of EMA.
>>> + */
>>> +static const u64 BRUTE_EMA_WEIGHT_NUMERATOR = 7;
>>
>>> +/**
>>> + * BRUTE_EMA_WEIGHT_DENOMINATOR - Weight's denominator of EMA.
>>> + */
>>> +static const u64 BRUTE_EMA_WEIGHT_DENOMINATOR = 10;
>>
>>> +/**
>>> + * BRUTE_MAX_FAULTS - Maximum number of faults.
>>> + *
>>> + * If a brute force attack is running slowly for a long time, the application
>>> + * crash period's EMA is not suitable for the detection. This type of attack
>>> + * must be detected using a maximum number of faults.
>>> + */
>>> +static const unsigned char BRUTE_MAX_FAULTS = 200;
>>
>>> +/**
>>> + * BRUTE_MIN_FAULTS - Minimum number of faults.
>>> + *
>>> + * The application crash period's EMA cannot be used until a minimum number of
>>> + * data has been applied to it. This constraint allows getting a trend when this
>>> + * moving average is used. Moreover, it avoids the scenario where an application
>>> + * fails quickly from execve system call due to reasons unrelated to a real
>>> + * attack.
>>> + */
>>> +static const unsigned char BRUTE_MIN_FAULTS = 5;
>>
>>> +/**
>>> + * BRUTE_CRASH_PERIOD_THRESHOLD - Application crash period threshold.
>>> + *
>>> + * The units are expressed in milliseconds.
>>> + *
>>> + * A fast brute force attack is detected when the application crash period falls
>>> + * below this threshold.
>>> + */
>>> +static const u64 BRUTE_CRASH_PERIOD_THRESHOLD = 30000;
>>
>> Basically we don't support scalars in kernel-doc notation...
> 
> So, to keep it commented it would be better to use a normal comment block?
> 
> /*
>  * Documentation here
>  */
> 
> What do you think?

Yes, please, just a normal /* comment block.

thanks.
-- 
~Randy

