Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358FC290D7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 23:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbgJPV45 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Oct 2020 17:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbgJPV44 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Oct 2020 17:56:56 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CBDC061755
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Oct 2020 14:56:55 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b8so5695636ioh.11
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Oct 2020 14:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jzoItDulSDSlUxDGRw3G8TEwpiIBVU/vuUm7RuAsW+4=;
        b=PYK3qHi0SlM4Ap5vtAD939+wmy/uc4NSYcNP6oAvg48Ng1dESdGw/FCNMGWrYwjM3E
         mPKznaL5D82PF8qF4kbmvDw+x0h/IdSxdhi1DPBMKFr8nijFAdwJDxTwvzpolrbvgX4k
         qmyYTqKA/kZk19UQGbDyLnBuVH5VapEnAriXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jzoItDulSDSlUxDGRw3G8TEwpiIBVU/vuUm7RuAsW+4=;
        b=aQG282kNL4rk33efaFICg8k50ItvJWvZii32NDeKR3iYL9wC9by65wP2YDUILECcT7
         GAjAxiLXhKpqQOS8XQDvVmsF54Rx5OWSHw3QweaA/C2NxbRJo8WgIE3olGy6uqdFxfu0
         J0eTXVt1CrXtQVGGVFlXUK/dV3q3UIgpwrIzctVo/GvBU+OWs4PqFVrmEvKx3eZq9ChJ
         gjUIwOh8AhUmBIMbfPIVcS9v5EHbv0TTJ8xEZccJP6surmmGHDtQCtTYiMqtG4qAcE/v
         u8TgLV7J0M5LWhleWT3rq3Rj7KOY6A5HLQzpmjLoYVCxEfrF9yEohzdZrgrxP4n6bl3m
         +XyA==
X-Gm-Message-State: AOAM532yRltNqp1P4BBXLFP34Elxz9TQqvizrGiC4NvSKyAaAO8Vo5N7
        RdQhZHmdpS91+rgfdgPfEYxctg==
X-Google-Smtp-Source: ABdhPJw+AlOetLRaoHdMMYZCU1cMviaNyYmSoxw13tfB/W1yAkmwJK6fIb63qn4IMWo3+S+lpkcr6w==
X-Received: by 2002:a6b:4014:: with SMTP id k20mr4002080ioa.177.1602885415021;
        Fri, 16 Oct 2020 14:56:55 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d14sm3005594ilo.72.2020.10.16.14.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 14:56:54 -0700 (PDT)
Subject: Re: [PATCH v3 00/11] Introduce Simple atomic counters
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, corbet@lwn.net,
        gregkh@linuxfoundation.org, shuah@kernel.org, rafael@kernel.org,
        johannes@sipsolutions.net, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        christian@brauner.io, hridya@google.com, surenb@google.com,
        minyard@acm.org, arnd@arndb.de, mchehab@kernel.org,
        rric@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@driverdev.osuosl.org,
        openipmi-developer@lists.sourceforge.net,
        linux-edac@vger.kernel.org, Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
 <20201009193746.GA1073957@hirez.programming.kicks-ass.net>
 <202010091255.246395A6@keescook>
 <20201010110920.GQ2628@hirez.programming.kicks-ass.net>
 <6e1dd408-653e-817e-b659-23649259a929@linuxfoundation.org>
 <20201014091720.GC2628@hirez.programming.kicks-ass.net>
 <202010141611.70B7A38@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d09124e5-6eae-8515-5071-ac4d0dd669fe@linuxfoundation.org>
Date:   Fri, 16 Oct 2020 15:56:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202010141611.70B7A38@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/14/20 5:31 PM, Kees Cook wrote:
> On Wed, Oct 14, 2020 at 11:17:20AM +0200, Peter Zijlstra wrote:
>> On Tue, Oct 13, 2020 at 08:12:20PM -0600, Shuah Khan wrote:
>>
>>> They don't add any new behavior, As Kees mentioned they do give us a
>>> way to clearly differentiate atomic usages that can wrap.
>>
>> No it doesn't! atomic_t can wrap, this thing can wrap, no distinction.
>>
>> All it does is fragment the API and sow confusion. FOR NO BENEFIT.
> 
> I really don't see it this way. It's a distinct subset of the atomic_t
> API. The trouble that has existed here has been with an atomic_t being
> originally used NOT for lifetime management, that mutates into something
> like that because of the available API, but doing so without realizing
> it. atomic_t gets used for all kinds of algorithms, and the "counter"
> type is way too easily accidentally transformed into a "lifetime
> tracker" and we get bugs.
> 
> If we have a distinct type for wrapping-counters that limits the API,
> then it is much harder for folks to shoot themselves in the foot. I don't
> see why this is so bad: we end up with safer usage, more easily auditable
> code behavior ("how was this atomic_t instance _intended_ to be used?"),
> and no change in binary size.
> 
>>> There is no need to keep inc_return in this API as such. I included it
>>> so it can be used for above cases 1 and 2, so the users don't have to
>>> call inc() followed by read(). It can be left out of the API.
> 
> I go back and forth on this, but after looking at these instances,
> it makes sense to have inc_return(), for where counters are actually
> "serial numbers". An argument could be made[1], however, that such uses
> should not end up in the position of _reusing_ earlier identifiers, which
> means it's actually can't wrap. (And some cases just need u64 to make this
> happen[2] -- and in that specific case, don't even need to be atomic_t).
> 
> [1] https://lore.kernel.org/lkml/202010071334.8298F3FA7@keescook/
> [2] https://git.kernel.org/linus/d1e7fd6462ca9fc76650fbe6ca800e35b24267da
> 
>> Wrong! The atomic usage in mutex doesn't fall in any of those
>> categories.
> 
> But the atomic usage in mutex is *IN* mutex -- it's a separate data
> type, etc. We don't build mutexes manually, so why build counters
> manually?
> 
>> The only thing you're all saying that makes sense is that unintentional
>> wrapping can have bad consequences, the rest is pure confusion.
>>
>> Focus on the non-wrapping cases, _everything_ else is not going
>> anywhere.
> 
> I view this as a way to do so: this subset of wrapping cases is being
> identified and removed from the pool of all the atomic_t cases so that
> they will have been classified, and we can continue to narrow down all
> the atomic_t uses to find any potentially mis-used non-wrapping cases.
> 
> The other option is adding some kind of attribute to the declarations
> (which gets us the annotation) but doesn't provide a limit to the API.
> (e.g. no counter should ever call dec_return).
> 

Not sure about that. We have more than dec_return to deal with. More on
this below.

>> So audit the kernel, find the cases that should not wrap, categorize and
>> create APIs for them that trap the wrapping. But don't go around
>> confusing things that don't need confusion.
> 
> That's what's happening here. But as it turns out, it's easier to do
> this by employing both the process of elimination (mark the counters)
> and direct identification (mark the refcount_t). Then the pool of
> "unannotated" atomic_t instances continues to shrink.
> 

Right auditing is what is happening now.

Let me summarize the discussion:

atomic_t api provides a wide range of atomic operations as a base
api to implement atomic counters, bitops, spinlock interfaces.
The usages also evolved into being used for resource lifetimes and
state management. Then came refcount_t api to address resource lifetime
problems related to atomic_t wrapping.

There is a large overlap between the atomic_t api used for resource
lifetimes and just counters. Not all counters used for resource
lifetimes can be converted to refcount_t.

A few quick "git grep" numbers on atomic_t interfaces usage:

Common for all:

atomic_set() - 3418
atomic_read() - 5833
atomic_inc() - 3376
atomic_dec() - 2498
atomic_inc_return() - 612

Counters don't need these:

atomic_dec_return() - 295
atomic_add_return() - 209
atomic_sub_return() - 144
atomic_add() - 744
atomic_sub() - 371
atomic_dec_and_test() - 552

You can see from these numbers, the volume of common usages that make
it difficult to separate out counters vs. non-counter usages.

The problem we are now running into is, it is becoming difficult
weed out candidates for refcount_t conversion in this noise.

Isolating a smaller subset of arithmetic atomic ops to address this
specific counters use-case will help reduce noise. This way we can
go through this work once and convert all counters to use this narrow
scoped api and what is left is non-counter usages.

The current situation is more confusing and adding a narrowly focused
api for counters reduces it and makes it easier.

thanks,
-- Shuah
