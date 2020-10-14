Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5B228DD21
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Oct 2020 11:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgJNJWd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Oct 2020 05:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729968AbgJNJVv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Oct 2020 05:21:51 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3BAC0F26CF
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 19:12:24 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q1so3429614ilt.6
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 19:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O0EZovHPBRBu6d4nMiG34aB96fSPYJLap8VHOicm/qs=;
        b=DbWW5TtsBc6Dyb8YsskACaBaCbQEtISHSCVxTRgFAHlHJjmD1dU40N2/h5pZJ6i9bJ
         +F2NBNfzuZOj7AsXvJYavEYGwGPq4uL8mop/7Jirc9xAaKdAITSdhsoI+JolGBgvo7jC
         FaHWhFiSslkjQ7vjKYWsBMu2t4YFei5779oSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O0EZovHPBRBu6d4nMiG34aB96fSPYJLap8VHOicm/qs=;
        b=d4eL5H+vBIpYuF6IBRp6vidIBryX0nBoJDc1sGqlAIrM/FekaGKlX3jprwdp+MFUHZ
         AqroBGCSeI9nZxR8CIntBn5yy4vkH2ABC+Qa5j6zSoIKeYADdB3GlGvYPxNlXZH2sDp7
         hzNf7acz1gUavcORSPJKb79u5pdlqphqW6BRTpq5vAG7YVn+CSoXy0CG4y/pXPWXNqWF
         eplBKUkmG9QeC5kSZdk/vQ7+kdZHGKDTYxPJR///Qml4ppmc1lOWRqdrbfqrkupW6O6z
         6fnj/GzqLEGgx6Zu6U3koHbNX+i4rgAk4KP4ejLwgjPDMaThNA1cNLMfU74NJI508gE2
         3VBg==
X-Gm-Message-State: AOAM530WUeDG8Qw+WYMmFEPHXg44+Doom+q4HKGCtgn36kSangxj/Eo7
        GYehFhL7LozkySL7fNDV9Gql6A==
X-Google-Smtp-Source: ABdhPJzg8Uk3iABEzJ4woM5C8q7wCnJ5fWvm66m83Hyk77SwQ9t1b/UHHFa4UxnY/E8z7l/WVw75Zg==
X-Received: by 2002:a92:bb0d:: with SMTP id w13mr2338778ili.168.1602641542819;
        Tue, 13 Oct 2020 19:12:22 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 15sm1611292ilz.66.2020.10.13.19.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 19:12:22 -0700 (PDT)
Subject: Re: [PATCH v3 00/11] Introduce Simple atomic counters
To:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, shuah@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, minyard@acm.org, arnd@arndb.de,
        mchehab@kernel.org, rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
 <20201009193746.GA1073957@hirez.programming.kicks-ass.net>
 <202010091255.246395A6@keescook>
 <20201010110920.GQ2628@hirez.programming.kicks-ass.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6e1dd408-653e-817e-b659-23649259a929@linuxfoundation.org>
Date:   Tue, 13 Oct 2020 20:12:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201010110920.GQ2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/10/20 5:09 AM, Peter Zijlstra wrote:
> On Fri, Oct 09, 2020 at 01:45:43PM -0700, Kees Cook wrote:
>> On Fri, Oct 09, 2020 at 09:37:46PM +0200, Peter Zijlstra wrote:
>>> On Fri, Oct 09, 2020 at 09:55:55AM -0600, Shuah Khan wrote:
>>>> Simple atomic counters api provides interfaces for simple atomic counters
>>>> that just count, and don't guard resource lifetimes. The interfaces are
>>>> built on top of atomic_t api, providing a smaller subset of atomic_t
>>>> interfaces necessary to support simple counters.
>>>
>>> To what actual purpose?!? AFACIT its pointless wrappery, it gets us
>>> nothing.
>>
>> It's not pointless. There is value is separating types for behavioral
>> constraint to avoid flaws. atomic_t provides a native operation. We gained
>> refcount_t for the "must not wrap" type, and this gets us the other side
>> of that behavioral type, which is "wrapping is expected". Separating the
>> atomic_t uses allows for a clearer path to being able to reason about
>> code flow, whether it be a human or a static analyzer.
> 
> refcount_t got us actual rutime exceptions that atomic_t doesn't. This
> propsal gets us nothing.
> 
> atomic_t is very much expected to wrap.
> 
>> The counter wrappers add nothing to the image size, and only serve to
>> confine the API to one that cannot be used for lifetime management.
> 
> It doesn't add anything period. It doesn't get us new behaviour, it
> splits a 'can wrap' use-case from a 'can wrap' type. That's sodding
> pointless.
> 

They don't add any new behavior, As Kees mentioned they do give us a
way to clearly differentiate atomic usages that can wrap.

Let's discuss the problem at hand before dismissing it as pointless.

> Worse, it mixes 2 unrelated cases into one type, which just makes a
> mockery of things (all the inc_return users are not statistics, some
> might even mis-behave if they wrap).
> 

You are right that all inc_return usages aren't statistics. There are
3 distinct usages:

1. Stats
2. Cases where wrapping is fine
3. Cases where wrapping could be a problem. In which case, this API
    shouldn't be used.

There is no need to keep inc_return in this API as such. I included it
so it can be used for above cases 1 and 2, so the users don't have to
call inc() followed by read(). It can be left out of the API.

The atomic_t usages in the kernel fall into the following categories:

1. Stats (tolerance for accuracy determines whether they need to be
    atomic or not). RFC version included non-atomic API for cases
    when lossiness is acceptable. All these cases use/need just init
    and inc. There are two variations in this case:

    a. No checks for wrapping. Use signed value.
    b. No checks for wrapping, but return unsigned.

2. Reference counters that release resource and rapping could result
    in use-after-free type problems. There are two variations in this
    case:

    a. Increments and decrements aren't bounded.
    b. Increments and decrements are bounded.

    Currently tools that flag unsafe atomic_t usages that are candidates
    for refcount_t conversions don't make a distinction between the two.

    The second case, since increments and decrements are bounded, it is
    safe to continue to use it. At the moment there is no good way to
    tell them apart other than looking at each of these cases.

3. Reference counters that manage/control states. Wrapping is a problem
    in this case, as it could lead to undefined behavior. These cases
    don't use test and free, use inc/dec. At the moment there is no good
    way to tell them apart other than looking at each of these cases.
    This is addressed by REFCOUNT_SATURATED case.

This API addresses 1a. Stats. No checks for wrapping. Use signed value
at the moment with plan to add support for unsigned for cases where
unsigned is being used.

It is possible to cover 2b in this API, so it becomes easier to make a
clear distinction the two cases and we can focus on only the atomic_t
cases that need to converted to refcount_t. This is easy to do by
allowing max. threshold for the variable and checking against that
and not letting it go above it.

There are several atomic_t usages that use just:

-- init or set and inc
-- init or set and inc/dec (including the ones that manage state)
-- Increments and decrements are bounded

Creating a sub-set of atomic_t api would help us with differentiate
these cases and make it easy for us identify and fix cases where
refcount_t should be used.

Would you be open to considering a subset if it addresses 2b and
unsigned returns for stats?

thanks,
-- Shuah












