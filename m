Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEBA6C6322
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 10:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjCWJUj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 05:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjCWJUi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 05:20:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0173C10;
        Thu, 23 Mar 2023 02:20:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id s8so26545716lfr.8;
        Thu, 23 Mar 2023 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679563235;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9HIeaE6YfreA7aFslVWmFTHAzUEzJTO0gNYWp3d2YA=;
        b=TO5alSmo69AjSE9DKZP3tSaKo7PRxjYPwRHpPVTcAtnfANEWJNxUoW7l0yTVePyqun
         +f8lh2WkvYbY8gTIomK20r+TibXI7BIlDOZZ34mokv2W/gbLwxmyFp/UCgOTWqqQLwuZ
         HFjfL32aF9kXg2/yLYmfg5F3kftV1Vt0IAAedwYV8hPNREzZA0ey21fJT7TWG8ZxJ7T6
         fri9eKvIOUovyzx9yFP3VpcSXUZJxFIXn18kYrPL4Ths1+QQ4AbuAvXQ+UckSacRrptS
         tJS75t1c959qI3o7Xl7+stwDn1AJ/JANJri36WH0srVA5eGdRx618VMdFAgjTft3MHs+
         KkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679563235;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9HIeaE6YfreA7aFslVWmFTHAzUEzJTO0gNYWp3d2YA=;
        b=vC50tCY0zJQ72PYcfc1tFFDnQXwqlz9Sm8lCKAMQSshYJqBchGD5w/DwTFJSa9yvtn
         SqY9u4BgDFM84yR9kLHy5XO54iyypBfdSrY9qaQn5Xzz5dl54gDjhJXuD7L+wtCt+LNz
         u5wwvJaQaKFjmniTrI6Aj6+E04v4tEzDBTJL08qBycAGYgXCT/xStlbou9UVht56h7DX
         XxfAuZ7FIPrHJu82/I0H6ttQTkxgjH9JwCiEFqpFem9nems61Sv3i4DQUgRpYZXI2aC1
         +WfUgxWPxholmrWq/ZnopCe+ZFcTj4syqfyed9FKw6Ax4Mzs+r1Nc4vmxPTlTqeMDUWo
         npvw==
X-Gm-Message-State: AAQBX9dDX6XpYVGQHh6jyRHGZM0hJYMU70/gPsp/tIoCVtL22QpGVqwr
        83c9iffVaJVsMRiH9OGJcZTdrCH6BDs=
X-Google-Smtp-Source: AKy350bePlJ4Diz4wfTBgsfrngsnQ7KDKc8lQ70DmTlV6RWdUCm23wjZJvNaZXUBpp+/8hzng8/b7g==
X-Received: by 2002:ac2:51dd:0:b0:4e8:3d24:de6f with SMTP id u29-20020ac251dd000000b004e83d24de6fmr3139121lfm.14.1679563234716;
        Thu, 23 Mar 2023 02:20:34 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004cc82b7080bsm2872706lfl.200.2023.03.23.02.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 02:20:34 -0700 (PDT)
Message-ID: <3c09bda1-330d-6d49-ade5-aab567b3a0c4@gmail.com>
Date:   Thu, 23 Mar 2023 11:20:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
 <ZBwUp/fRIjQZtjF7@kroah.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
In-Reply-To: <ZBwUp/fRIjQZtjF7@kroah.com>
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

On 3/23/23 10:58, Greg Kroah-Hartman wrote:
> On Thu, Mar 23, 2023 at 07:17:40AM +0000, Vaittinen, Matti wrote:
>> On 3/22/23 20:57, Greg Kroah-Hartman wrote:
>>> On Wed, Mar 22, 2023 at 03:48:00PM +0200, Matti Vaittinen wrote:
>>>> Hi Greg,
>>>>
>>>> Thanks for looking at this.
>>>>
>>>> On 3/22/23 14:07, Greg Kroah-Hartman wrote:
>>>>> On Wed, Mar 22, 2023 at 11:05:55AM +0200, Matti Vaittinen wrote:

>> I am very conservative what comes to adding unit tests due to the huge
>> inertia they add to any further development. I usually only add tests to
>> APIs which I know won't require changing (I don't know such in-kernel
>> APIs)
> 
> So anything that is changing doesn't get a test? 

No. I think you misread me. I didn't say I don't like adding tests to 
code which changes. I said, I don't like adding tests to APIs which change.

  If you only test
> things that don't change then no tests fail, and so, why have the test
> at all?

Because implementation cascading into functions below an API may change 
even if the API stays unchanged.

> On the contrary, tests should be used to verify things that are changing
> all the time, to ensure that we don't break things.

This is only true when your test code stays valid. Problem with 
excessive amount of tests is that more we have callers for an API, 
harder changing that API becomes. I've seen a point where people stop 
fixing "unimportant" things just because the amount of work fixing all 
impacted UT-cases would take. I know that many things went wrong before 
that project ended up to the point - but what I picked up with me is 
that carelessly added UTs do really hinder further development.

  That's why we need
> them, not to just validate that old code still is going ok.
> 
> The driver core is changing, and so, I would love to see tests for it to
> ensure that I don't break anything over time.  That should NOT slow down
> development but rather, speed it up as it ensures that things still work
> properly.

I agree that there are cases where UTs are very handy and can add 
confidence that things work as intended. Still, my strong opinion is 
that people should consider what parts of code are really worth testing 
- and how to do the tests so that the amount of maintenance required by 
the tests stays low. It's definitely _not fun_ to do refactoring for 
minor improvement when 400+ unit-test cases break. It's a point when 
many developers start seeing fixing this minor culprit much less 
important... And when people stop fixing minor things ... major things 
start to be just around the corner.

> 
>> - or to functions which I think are error-prone. So, I am probably
>> one of the last persons adding UTs to code I don't know :)
> 
> That's fine, you don't have to add test code for stuff you don't know.
> 
> But again, do NOT abuse a platform device for this, that's not ok, and
> the in-kernel code that does do this should be fixed up.

As suggested by David in another mail - I'll go with the 
root_device_[un]register(). I'll drop this patch entirely. Thanks for 
help, this was once again very educating :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

