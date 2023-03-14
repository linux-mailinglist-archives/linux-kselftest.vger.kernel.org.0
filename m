Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0E36B899B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 05:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjCNE2l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 00:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCNE2j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 00:28:39 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0211285F;
        Mon, 13 Mar 2023 21:28:37 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id o3so9629029qvr.1;
        Mon, 13 Mar 2023 21:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678768116;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y750kud8mHtJic9GXfaEeGkhfjSIqfKCGoLOtAydFgI=;
        b=jhKsGFUZuOjlPI/ybjOHKr286JRg/tr9p/GCLssUKypycNpqFBf2O1BMckaPQmUFQ1
         SXz2/t5C/uYRI9rmCUJbbT6bEF95iQ6HMMOpiaGiAFZrNKKz3J+He3fJzCZ6T4PqsDz5
         4m+6XviiyUXvipnzxuzLou73qsvCxkI4swtSYQsbWoB90x7YBEEVnqCQbeHOwwWTOGOu
         nRa8mcVfeBqjZ/S+phnlQcuJjFFfnFKifYvq2SnUUb3YGaWx7/AYTJNv0zeaHmb1ULBS
         UTiROfwsrTc5NxP/59sAjFHH68VQ0lSi6OVbDVTbonYPKGc0GHGit/yKyYvjiXmfjHSt
         vdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678768116;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y750kud8mHtJic9GXfaEeGkhfjSIqfKCGoLOtAydFgI=;
        b=sGFh+ufeUf7nPFZFp2sZzIrcIMlOfl7SXcHK891ctfRZYvxgQDvTXcDB1lFevGjm8N
         yKjaY43t/iTOdkbX6/4RFIB8g+H1cWW9n11Z5DdaaPJJcSLifBAzat8xLuDe7ynmV38Q
         U6Ts4ZKYtdc3biOuS7GF4g6UJx0e3PW4qVJX/yPeuIhiPYXWaxZ6/sJ19TNGE8FQfi7u
         eV4LET4QsUWAbvrJyRODVWGlAfqV6Sk3Mx7qe7v6CSIGoNZzI0qjmWHXB06QoSI+QLdm
         cHS27yLqJJRDmniLKuPLdB71C3EeFy4PKhQpMIsdNP2iirkpp1KRmEhYeY9ETzUeZWJj
         iwHg==
X-Gm-Message-State: AO0yUKWMy/GqpC9PVDoKfTMZluELnDmhR0Hkgzmdf0dt9AUmSGxcGIJr
        bJDrTh2hEuvgf/I+iIPxA/8=
X-Google-Smtp-Source: AK7set+xkuA4DXyGLm8pCAYjUaEcNydWGbEn4eLnuh/IMmnxDNH9bYBSvQ1VgXD/rEWWwYRYDv7rIw==
X-Received: by 2002:ad4:5caa:0:b0:5aa:17d5:bbfe with SMTP id q10-20020ad45caa000000b005aa17d5bbfemr6330378qvh.10.1678768116555;
        Mon, 13 Mar 2023 21:28:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:4071:d635:4b20:d09e? ([2600:1700:2442:6db0:4071:d635:4b20:d09e])
        by smtp.gmail.com with ESMTPSA id s124-20020ae9de82000000b007429ee9482dsm979941qkf.134.2023.03.13.21.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 21:28:36 -0700 (PDT)
Message-ID: <e1889f7f-2804-718b-6651-f333aed48e99@gmail.com>
Date:   Mon, 13 Mar 2023 23:28:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/8] of: Enable DTB loading on UML for KUnit tests
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
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
 <40299ee6-c518-5505-0dc5-874deef03d19@gmail.com>
In-Reply-To: <40299ee6-c518-5505-0dc5-874deef03d19@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/13/23 11:02, Frank Rowand wrote:
> On 3/11/23 00:42, David Gow wrote:
>> On Sat, 11 Mar 2023 at 07:34, Stephen Boyd <sboyd@kernel.org> wrote:
>>>
>>> Quoting David Gow (2023-03-10 00:09:48)
>>>> On Fri, 10 Mar 2023 at 07:19, Stephen Boyd <sboyd@kernel.org> wrote:
>>>>>
>>>>>
>>>>> Hmm. I think you're suggesting that the unit test data be loaded
>>>>> whenever CONFIG_OF=y and CONFIG_KUNIT=y. Then tests can check for
>>>>> CONFIG_OF and skip if it isn't enabled?
>>>>>
>>>>
>>>> More of the opposite: that we should have some way of supporting tests
>>>> which might want to use a DTB other than the built-in one. Mostly for
>>>> non-UML situations where an actual devicetree is needed to even boot
>>>> far enough to get test output (so we wouldn't be able to override it
>>>> with a compiled-in test one).
>>>
>>> Ok, got it.
>>>
>>>>
>>>> I think moving to overlays probably will render this idea obsolete:
>>>> but the thought was to give test code a way to check for the required
>>>> devicetree nodes at runtime, and skip the test if they weren't found.
>>>> That way, the failure mode for trying to boot this on something which
>>>> required another device tree for, e.g., serial, would be "these tests
>>>> are skipped because the wrong device tree is loaded", not "I get no
>>>> output because serial isn't working".
>>>>
>>>> Again, though, it's only really needed for non-UML, and just loading
>>>> overlays as needed should be much more sensible anyway.
>>>
>>> I still have one niggle here. Loading overlays requires
>>> CONFIG_OF_OVERLAY, and the overlay loading API returns -ENOTSUPP when
>>> CONFIG_OF_OVERLAY=n. For now I'm checking for the config being enabled
>>> in each test, but I'm thinking it may be better to simply call
>>> kunit_skip() from the overlay loading function if the config is
>>> disabled. This way tests can simply call the overlay loading function
>>> and we'll halt the test immediately if the config isn't enabled.
>>>
>>
>> That sounds sensible, though there is a potential pitfall. If
>> kunit_skip() is called directly from overlay code, might introduce a
>> dependency on kunit.ko from the DT overlay, which we might not want.
>> The solution there is either to have a kunit wrapper function (so the
>> call is already in kunit.ko), or to have a hook to skip the current
>> test (which probably makes sense to do anyway, but I think the wrapper
>> is the better option).
>>
>>
>>>>
>>>>>>
>>>>>> That being said, I do think that there's probably some sense in
>>>>>> supporting the compiled-in DTB as well (it's definitely simpler than
>>>>>> patching kunit.py to always pass the extra command-line option in, for
>>>>>> example).
>>>>>> But maybe it'd be nice to have the command-line option override the
>>>>>> built-in one if present.
>>>>>
>>>>> Got it. I need to test loading another DTB on the commandline still, but
>>>>> I think this won't be a problem. We'll load the unittest-data DTB even
>>>>> with KUnit on UML, so assuming that works on UML right now it should be
>>>>> unchanged by this series once I resend.
>>>>
>>>> Again, moving to overlays should render this mostly obsolete, no? Or
>>>> am I misunderstanding how the overlay stuff will work?
>>>
>>> Right, overlays make it largely a moot issue. The way the OF unit tests
>>> work today is by grafting a DTB onto the live tree. I'm reusing that
>>> logic to graft a container node target for kunit tests to add their
>>> overlays too. It will be clearer once I post v2.
>>>
>>>>
>>>> One possible future advantage of being able to test with custom DTs at
>>>> boot time would be for fuzzing (provide random DT properties, see what
>>>> happens in the test). We've got some vague plans to support a way of
>>>> passing custom data to tests to support this kind of case (though, if
>>>> we're using overlays, maybe the test could just patch those if we
>>>> wanted to do that).
>>>
>>> Ah ok. I can see someone making a fuzzer that modifies devicetree
>>> properties randomly, e.g. using different strings for clock-names.
>>>
>>> This reminds me of another issue I ran into. I wanted to test adding the
>>> same platform device to the platform bus twice to confirm that the
>>> second device can't be added. That prints a warning, which makes
>>> kunit.py think that the test has failed because it printed a warning. Is
>>> there some way to avoid that? I want something like
>>>
>>>         KUNIT_EXPECT_WARNING(test, <call some function>)
>>>
>>> so I can test error cases.
> 
> DT unittests already have a similar concept.  A test can report that a
> kernel warning (or any other specific text) either (1) must occur for the
> test to pass or (2) must _not_ occur for the test to pass.  The check
> for the kernel warning is done by the test output parsing program
> scripts/dtc/of_unittest_expect.
> 
> The reporting by a test of an expected error in drivers/of/unittest.c
> is done by EXPECT_BEGIN() and EXPECT_END().  These have been in
> unittest for a long time.
> 
> The reporting by a test of a not expected to occur error is done
> by EXPECT_NOT_BEGIN() and EXPECT_NOT_END().  These are added to
> unittest in linux 6.3-rc1.
> 
> I discussed this concept in one of the early TAP / KTAP discussion

The link to the early KTAP discussion on this concept is:

   https://lore.kernel.org/all/d38bf9f9-8a39-87a6-8ce7-d37e4a641675@gmail.com/T/#u


> threads and expect to start a discussion thread on this specific
> topic in the KTAP Specification V2 context.  I expect the discussion
> to result in a different implementation than what DT unittests are
> using (bike shedding likely to ensue) but whatever is agreed to
> should be easy for DT to switch to.

The link to the KTAP Specification Version 2 process and progress is:

   https://elinux.org/Test_Results_Format_Notes#KTAP_version_2

-Frank

> 
>>
>> Hmm... I'd've thought that shouldn't be a problem: kunit.py should
>> ignore most messages during a test, unless it can't find a valid
>> result line. What does the raw KTAP output look like? (You can get it
>> from kunit.py by passing the --raw_output option).
>>
>> That being said, a KUNIT_EXPECT_LOG_MESSAGE() or similar is something
>> we've wanted for a while. I think that the KASAN folks have been
>> working on something similar using console tracepoints:
>> https://lore.kernel.org/all/ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com/
>>
>> Cheers,
>> -- David
> 

