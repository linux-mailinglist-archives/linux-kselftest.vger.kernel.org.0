Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CCD6B7CF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 17:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCMQCW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Mar 2023 12:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMQCV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Mar 2023 12:02:21 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECE573039;
        Mon, 13 Mar 2023 09:02:20 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id bp19so9777701oib.4;
        Mon, 13 Mar 2023 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678723340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/6PvWUDuv53qnbJtOkZQhGybbLEXAVya4Qm9G8Vtvo=;
        b=GdGBH+Ouq7KE3mt/AVtpyLvF4XSzkJ3AtuVurjc/HPmPyokqzoPZnz29r2tk97xJbU
         B9s6333fcIxEWsr9wG5UkFROvGQQYansTHyx9nJ+quJ6UMvafVGX4CYwStizbj3gzR5P
         5K2nM6HXyZfH+nWVZ35xtZk+zXOsIzpeGX6JUHnc8AIbCqffnyfk1Qcv2wDLRPqITmA+
         OA0EEW9uZI/PIbNPilOuef5DdvKEp4uPRosjt3ggH0W7t7/TcP5GXKZAyh3BFFFW75cV
         6fRM59w3nJngnEhL2gPZBYHRz82Rjhs1nCoYmsnPRluVhbO4MxElv4UX+WepKB0BQhFL
         2ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678723340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/6PvWUDuv53qnbJtOkZQhGybbLEXAVya4Qm9G8Vtvo=;
        b=OlV5fQRdSA+5bfpmuIr5IgNcGxJpKcRZBC+p1zDBA2FUF4fay5CKrfoP545hp8NrM4
         q3sldqDm5e/dDTyGt08eB1kSL47AvDIOPYoXG9e6csg2YSZCUkTc4GTQ0NojiEWKg7tX
         x4XVXVwqAKL+u8yPyXl89tqm3cNh56i5IEHY5I0CsifnrnDoZRonOlSuvvCtILHEyP//
         5dXsQ9l0CwGfF0PJ0/3lvXdYST4T9qj7ZjwKMbbClB64URcMD25MUAyiisVyXjlNy0J3
         7pFtAsnjmgfD+ZoEYm1pSZBAV0yv2YpJlIJoMqOWdaCCpzvQTHXTh0SxR7HKxX2bReTa
         MUvA==
X-Gm-Message-State: AO0yUKV0FlYZMOpZehQtOHowz13/lse/mBPWj4VMMsu9Unam0eSVHZkl
        63l1SaP+Kyvaqnc9Ft6eIBk=
X-Google-Smtp-Source: AK7set+N0wOTI76y8UHvscc0qXf14XK3qcBgvXnMlVBphtxrzHOYdVI/03vvei4uaZzfqxoU1YbJow==
X-Received: by 2002:aca:1006:0:b0:384:38f1:e7fb with SMTP id 6-20020aca1006000000b0038438f1e7fbmr16570676oiq.53.1678723339751;
        Mon, 13 Mar 2023 09:02:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:6822:a477:b6d1:664a? ([2600:1700:2442:6db0:6822:a477:b6d1:664a])
        by smtp.gmail.com with ESMTPSA id x203-20020acae0d4000000b00383eaea5e88sm3266425oig.38.2023.03.13.09.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 09:02:19 -0700 (PDT)
Message-ID: <40299ee6-c518-5505-0dc5-874deef03d19@gmail.com>
Date:   Mon, 13 Mar 2023 11:02:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/8] of: Enable DTB loading on UML for KUnit tests
Content-Language: en-US
To:     David Gow <davidgow@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Rob Herring <robh+dt@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20230302013822.1808711-1-sboyd@kernel.org>
 <20230302013822.1808711-3-sboyd@kernel.org>
 <CABVgOSkomwwgKZ9N0_0YMDL--QaZiTV7ONgSRABU2Ph1Z0CG-g@mail.gmail.com>
 <a97c9bb3a5addfb34af8ccabaa513026.sboyd@kernel.org>
 <CABVgOSkJ4mw_DtFzn5EwcsuYixWY_j13YotxEYqWhO+ZCL1KPg@mail.gmail.com>
 <d64a086ddcb7c5ca5abecab0ca654259.sboyd@kernel.org>
 <CABVgOSk9gqRe_5yQZweBA2Qg2aGx8rUJtOHywGeT4x7TEyBH0A@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CABVgOSk9gqRe_5yQZweBA2Qg2aGx8rUJtOHywGeT4x7TEyBH0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/11/23 00:42, David Gow wrote:
> On Sat, 11 Mar 2023 at 07:34, Stephen Boyd <sboyd@kernel.org> wrote:
>>
>> Quoting David Gow (2023-03-10 00:09:48)
>>> On Fri, 10 Mar 2023 at 07:19, Stephen Boyd <sboyd@kernel.org> wrote:
>>>>
>>>>
>>>> Hmm. I think you're suggesting that the unit test data be loaded
>>>> whenever CONFIG_OF=y and CONFIG_KUNIT=y. Then tests can check for
>>>> CONFIG_OF and skip if it isn't enabled?
>>>>
>>>
>>> More of the opposite: that we should have some way of supporting tests
>>> which might want to use a DTB other than the built-in one. Mostly for
>>> non-UML situations where an actual devicetree is needed to even boot
>>> far enough to get test output (so we wouldn't be able to override it
>>> with a compiled-in test one).
>>
>> Ok, got it.
>>
>>>
>>> I think moving to overlays probably will render this idea obsolete:
>>> but the thought was to give test code a way to check for the required
>>> devicetree nodes at runtime, and skip the test if they weren't found.
>>> That way, the failure mode for trying to boot this on something which
>>> required another device tree for, e.g., serial, would be "these tests
>>> are skipped because the wrong device tree is loaded", not "I get no
>>> output because serial isn't working".
>>>
>>> Again, though, it's only really needed for non-UML, and just loading
>>> overlays as needed should be much more sensible anyway.
>>
>> I still have one niggle here. Loading overlays requires
>> CONFIG_OF_OVERLAY, and the overlay loading API returns -ENOTSUPP when
>> CONFIG_OF_OVERLAY=n. For now I'm checking for the config being enabled
>> in each test, but I'm thinking it may be better to simply call
>> kunit_skip() from the overlay loading function if the config is
>> disabled. This way tests can simply call the overlay loading function
>> and we'll halt the test immediately if the config isn't enabled.
>>
> 
> That sounds sensible, though there is a potential pitfall. If
> kunit_skip() is called directly from overlay code, might introduce a
> dependency on kunit.ko from the DT overlay, which we might not want.
> The solution there is either to have a kunit wrapper function (so the
> call is already in kunit.ko), or to have a hook to skip the current
> test (which probably makes sense to do anyway, but I think the wrapper
> is the better option).
> 
> 
>>>
>>>>>
>>>>> That being said, I do think that there's probably some sense in
>>>>> supporting the compiled-in DTB as well (it's definitely simpler than
>>>>> patching kunit.py to always pass the extra command-line option in, for
>>>>> example).
>>>>> But maybe it'd be nice to have the command-line option override the
>>>>> built-in one if present.
>>>>
>>>> Got it. I need to test loading another DTB on the commandline still, but
>>>> I think this won't be a problem. We'll load the unittest-data DTB even
>>>> with KUnit on UML, so assuming that works on UML right now it should be
>>>> unchanged by this series once I resend.
>>>
>>> Again, moving to overlays should render this mostly obsolete, no? Or
>>> am I misunderstanding how the overlay stuff will work?
>>
>> Right, overlays make it largely a moot issue. The way the OF unit tests
>> work today is by grafting a DTB onto the live tree. I'm reusing that
>> logic to graft a container node target for kunit tests to add their
>> overlays too. It will be clearer once I post v2.
>>
>>>
>>> One possible future advantage of being able to test with custom DTs at
>>> boot time would be for fuzzing (provide random DT properties, see what
>>> happens in the test). We've got some vague plans to support a way of
>>> passing custom data to tests to support this kind of case (though, if
>>> we're using overlays, maybe the test could just patch those if we
>>> wanted to do that).
>>
>> Ah ok. I can see someone making a fuzzer that modifies devicetree
>> properties randomly, e.g. using different strings for clock-names.
>>
>> This reminds me of another issue I ran into. I wanted to test adding the
>> same platform device to the platform bus twice to confirm that the
>> second device can't be added. That prints a warning, which makes
>> kunit.py think that the test has failed because it printed a warning. Is
>> there some way to avoid that? I want something like
>>
>>         KUNIT_EXPECT_WARNING(test, <call some function>)
>>
>> so I can test error cases.

DT unittests already have a similar concept.  A test can report that a
kernel warning (or any other specific text) either (1) must occur for the
test to pass or (2) must _not_ occur for the test to pass.  The check
for the kernel warning is done by the test output parsing program
scripts/dtc/of_unittest_expect.

The reporting by a test of an expected error in drivers/of/unittest.c
is done by EXPECT_BEGIN() and EXPECT_END().  These have been in
unittest for a long time.

The reporting by a test of a not expected to occur error is done
by EXPECT_NOT_BEGIN() and EXPECT_NOT_END().  These are added to
unittest in linux 6.3-rc1.

I discussed this concept in one of the early TAP / KTAP discussion
threads and expect to start a discussion thread on this specific
topic in the KTAP Specification V2 context.  I expect the discussion
to result in a different implementation than what DT unittests are
using (bike shedding likely to ensue) but whatever is agreed to
should be easy for DT to switch to.

> 
> Hmm... I'd've thought that shouldn't be a problem: kunit.py should
> ignore most messages during a test, unless it can't find a valid
> result line. What does the raw KTAP output look like? (You can get it
> from kunit.py by passing the --raw_output option).
> 
> That being said, a KUNIT_EXPECT_LOG_MESSAGE() or similar is something
> we've wanted for a while. I think that the KASAN folks have been
> working on something similar using console tracepoints:
> https://lore.kernel.org/all/ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com/
> 
> Cheers,
> -- David

