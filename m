Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3736C6588
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 11:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjCWKq2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 06:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjCWKqM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 06:46:12 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7D912047;
        Thu, 23 Mar 2023 03:43:46 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id t14so21888643ljd.5;
        Thu, 23 Mar 2023 03:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679568224;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVkvbssOApWk1Mg8YWF2gO2sXRG9eKmEnBzQZ0sEbEs=;
        b=LSx+fSmSFu0xOqUzgmqBX5akSGRbx3sTmlQ7o/ff0sO5LQFNBJzCHodyUXhcsJUVEs
         aJUsGgYgt3i+JLshum/WokARce3iKWQuMOLB2D4BQAPNyfwx1SqluAE5RiC/4KFNn2bV
         1PBvXyWeUFGdYbuOhpRKdXdBLGMckkbQm3f1Qnm833a0E7kQBUwIO60GBvCrETxmh2lk
         ZymvOnQUt0A1dJHPHtBqCfb6w5jBvw+65grCAecqk6R0oUKbrzR0hHf+tSkHkhF/GaFi
         u1A39W5KRhaceGkx85jZ9/3B6GVXxilIic/5fjEYJGGqDwBUhz5Zi07bJBTnXO0XEjWu
         Ka4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679568224;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVkvbssOApWk1Mg8YWF2gO2sXRG9eKmEnBzQZ0sEbEs=;
        b=PEm9zZsdKdULjqoEbKp8N0DRV3yoaMUIZoY4Gz7Rp5DfwLjA9I7RGi/UKRt2T6xB24
         VFoKv9U9PcvDInP+QehzCITuhVLTA2KrGvAa2xmtvVgAzvJToRr8SVtSGybr3LFzUPcT
         O3GjsDXiBgvoFitCGhfODL3E5aZc4zYgLHXcTjic1yQIwUC1KwLnUzys2DDYcfb46HHL
         2KONdBF8rHwjv6VSQQPQpC6TUIzYIcz/Whx8xqgMEdrIq+AbHWJjn69o/KU1xOD+69zp
         cGGVcVgnivbqySicRtLOf4euvCUp984esPBJ1xM8P6bTu9PGd6aCyY1fQov2fx+jRZwm
         fnmg==
X-Gm-Message-State: AO0yUKWELKyJUGCZtRCx/uVWdU6O8Ppo4EMOiMfLhXMXCoWxmGEMFbjy
        r1MIbYlZg2iQ1cFOAtUcAvY=
X-Google-Smtp-Source: AK7set/NShKiLbJhp8swuS56t5O1tRm9yOZ9M6BwW+IetbR/dWGogsrTHM0X2on6LbT0yM0nq57v6w==
X-Received: by 2002:a2e:9b17:0:b0:29e:e7ad:c8e1 with SMTP id u23-20020a2e9b17000000b0029ee7adc8e1mr3592888lji.28.1679568224327;
        Thu, 23 Mar 2023 03:43:44 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id y11-20020a2e9d4b000000b00295a5aa9d05sm2920059ljj.120.2023.03.23.03.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 03:43:43 -0700 (PDT)
Message-ID: <ec3a8aad-b36b-d814-9616-ae5d65ab4879@gmail.com>
Date:   Thu, 23 Mar 2023 12:43:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <cover.1679474247.git.mazziesaccount@gmail.com>
 <bad670ee135391eb902bd34b8bcbe777afabc7fd.1679474247.git.mazziesaccount@gmail.com>
 <ZBrvhfX/NNrJefgt@kroah.com> <25f9758f-0010-0181-742a-b18a344110cf@gmail.com>
 <ZBtPhoelZo4U5jwC@kroah.com>
 <12ea1d68-2a3c-0aa7-976c-7bd3eef35239@fi.rohmeurope.com>
 <ZBwUp/fRIjQZtjF7@kroah.com> <3c09bda1-330d-6d49-ade5-aab567b3a0c4@gmail.com>
 <ZBwpNcd/A15/Azjr@kroah.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
In-Reply-To: <ZBwpNcd/A15/Azjr@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a low priority babbling - feel free to skip if busy.

On 3/23/23 12:25, Greg Kroah-Hartman wrote:
> On Thu, Mar 23, 2023 at 11:20:33AM +0200, Matti Vaittinen wrote:
>> On 3/23/23 10:58, Greg Kroah-Hartman wrote:
>>> On Thu, Mar 23, 2023 at 07:17:40AM +0000, Vaittinen, Matti wrote:
>>>> On 3/22/23 20:57, Greg Kroah-Hartman wrote:
>>>>> On Wed, Mar 22, 2023 at 03:48:00PM +0200, Matti Vaittinen wrote:
>>>>>> Hi Greg,
>>>>>>
>>>>>> Thanks for looking at this.
>>>>>>
>>>>>> On 3/22/23 14:07, Greg Kroah-Hartman wrote:
>>>>>>> On Wed, Mar 22, 2023 at 11:05:55AM +0200, Matti Vaittinen wrote:
>>
>>>> I am very conservative what comes to adding unit tests due to the huge
>>>> inertia they add to any further development. I usually only add tests to
>>>> APIs which I know won't require changing (I don't know such in-kernel
>>>> APIs)
>>>
>>> So anything that is changing doesn't get a test?
>>
>> No. I think you misread me. I didn't say I don't like adding tests to code
>> which changes. I said, I don't like adding tests to APIs which change.
> 
> Then you should not be writing any in-kernel tests as all of our APIs
> change all the time.
> 
>>   If you only test
>>> things that don't change then no tests fail, and so, why have the test
>>> at all?
>>
>> Because implementation cascading into functions below an API may change even
>> if the API stays unchanged.
> 
> Then it needs to be fixed.
> 
>>> On the contrary, tests should be used to verify things that are changing
>>> all the time, to ensure that we don't break things.
>>
>> This is only true when your test code stays valid. Problem with excessive
>> amount of tests is that more we have callers for an API, harder changing
>> that API becomes. I've seen a point where people stop fixing "unimportant"
>> things just because the amount of work fixing all impacted UT-cases would
>> take. I know that many things went wrong before that project ended up to the
>> point - but what I picked up with me is that carelessly added UTs do really
>> hinder further development.
> 
> Again, in-kernel apis change at any moment.

I agree. This is why I initially wrote:

 >>>> APIs which I know won't require changing (I don't know such in-kernel
 >>>> APIs)

> Don't get stuck into thinking that you can only
> write tests for stuff that is "stable" as nothing in the kernel is
> "stable" and can change at any point in time.

I don't. But I don't either think that UTs come with no cost. Thus I do 
only write tests when I see a _real need_ for one. If the APIs would be 
guaranteed not to change, then I would understand writing the tests for 
each and every "thing" without much of thinking if "the thing" is worth 
the test.

>  You fix up all the
> in-kernel users of the api, and the tests, and all is good.  That's how
> kernel development works.

Sure. This is how it works and how I think it should work. But I also 
have seen how this 'UT work overhead' has made people to decide not to 
touch things. Not in kernel but in other project. This is a real thing 
which can happen - many engineers like me are lazy bastards :)

>>   That's why we need
>>> them, not to just validate that old code still is going ok.
>>>
>>> The driver core is changing, and so, I would love to see tests for it to
>>> ensure that I don't break anything over time.  That should NOT slow down
>>> development but rather, speed it up as it ensures that things still work
>>> properly.
>>
>> I agree that there are cases where UTs are very handy and can add confidence
>> that things work as intended. Still, my strong opinion is that people should
>> consider what parts of code are really worth testing - and how to do the
>> tests so that the amount of maintenance required by the tests stays low.
>> It's definitely _not fun_ to do refactoring for minor improvement when 400+
>> unit-test cases break. It's a point when many developers start seeing fixing
>> this minor culprit much less important... And when people stop fixing minor
>> things ... major things start to be just around the corner.
> 
> If people stop fixing minor things then the kernel development process
> is dead.  Based on all the changes that go into it right now, we are far
> from having that problem.

And I am so happy for that. Kernel/drivers are still fun to work with. 
My personal preference is to keep it that way :)

> So write valid tests, if we get to the point where we have too much of a
> problem fixing up the tests than the real users of apis, then we can
> revisit it.  But for now, that's not an issue.

The beginning of your sentence hits the point. Write valid tests. I just 
encourage people to occasionally ask if the test they write is really a 
valid one. :)

> And again, remember, and api can, and will, change at any moment in
> time, you can never know what will be "stable" as we do not have such a
> thing.

We agree on this.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

