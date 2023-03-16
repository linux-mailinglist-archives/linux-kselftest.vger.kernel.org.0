Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2F36BC2F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 01:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjCPApT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 20:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCPApS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 20:45:18 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ECBAFB9D;
        Wed, 15 Mar 2023 17:45:14 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h19so185314qtn.1;
        Wed, 15 Mar 2023 17:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678927513;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEtmAFbiYGn4gzl91UasYN0iW6U3CYntm4xrWCgFnZs=;
        b=newxf42ynqnD/6EHue7azXh0ygnj3gSaXETUlswqyKxs6ltsq/ef9jrpmuAc2v7oFY
         XkH4Px0oRnUgjUmYrsNpRmP4++6T648SR7QtugfRdXHvL5REb4bONNPBr2ZY0dWjQfK0
         gzLv++XC/fq1TYKZcTg1D99/Gl9wBOIEPmWMX57zn8dTJhEV+WOoi9THpt2F1xQgnDps
         M9iGaDfVB0FooREzW3FJjcInF1rxY0ZzF9vDQ1n4VOVFEp7UfIq0CLf0b90S2Eib7G7D
         bsCsFHvmDszc8Hb53x3iCFW/fl+yPuajPX/FlAoxBk2DkAkRDbPuC1G/XU3aZN2gNu5X
         fxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678927513;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEtmAFbiYGn4gzl91UasYN0iW6U3CYntm4xrWCgFnZs=;
        b=Sut74Idbm3+mTfq5frwNM2iXIlqlaByAg9z9KCJ6XWUz9Iy+Q6aGxSGi4gtWCdRMEr
         zv47AbSe+CUrzhzLWwn0jhXaDqoag5+vEeF8v4Rn2prJub+GLcJF98WNrXKonyHOUe4J
         2OPOr/69afzOzLlLzkc69DmHQP3leqw6sa4/OmfCnteUuQM/Z7M9RKjarfZ0QkEiJEXQ
         vJ7vSKKrEOv4me14BImjY15/Mgf8tt8QdrqTz5PUJL0Jxu+lVja4FqgoOt3i0T0pwL8S
         4VhHyWIWRXbDmpaBxhp4NEWyes/6BVo46u0iIxHf9p+0x78s7cMkeqpNU/GWbJwWi8FF
         TFaQ==
X-Gm-Message-State: AO0yUKVVGxjOc2VPHs/ayp3vs1D9gvIhIn4Py6sppDTuo90QKhuQuq/5
        yu0Ih229T8euojaUcjj8Gus=
X-Google-Smtp-Source: AK7set+GreWyujOPw9UAjKyKrD4OfwI5ZzGhSuwfPlWr6HNHc3luYXEjbMMIiDYHrC+08OcVe2gb7g==
X-Received: by 2002:ac8:7dd5:0:b0:3d2:90b1:d161 with SMTP id c21-20020ac87dd5000000b003d290b1d161mr3311559qte.48.1678927513120;
        Wed, 15 Mar 2023 17:45:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:1157:1a08:54ae:71f7? ([2600:1700:2442:6db0:1157:1a08:54ae:71f7])
        by smtp.gmail.com with ESMTPSA id q22-20020a37f716000000b007461e8efacbsm899756qkj.69.2023.03.15.17.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 17:45:12 -0700 (PDT)
Message-ID: <b05b5e50-413f-0aa8-1842-aef6f846c38d@gmail.com>
Date:   Wed, 15 Mar 2023 19:45:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/8] of: Enable DTB loading on UML for KUnit tests
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
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
 <e1889f7f-2804-718b-6651-f333aed48e99@gmail.com>
 <CABVgOS=B51mzjVLy35aMp5PSAB=qhzMQVNzvxDVMezYwsOv1zw@mail.gmail.com>
 <b217e613-575e-9e33-3469-6de5e0fb813a@gmail.com>
In-Reply-To: <b217e613-575e-9e33-3469-6de5e0fb813a@gmail.com>
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

On 3/15/23 16:35, Frank Rowand wrote:
> On 3/15/23 02:04, David Gow wrote:
>> On Tue, 14 Mar 2023 at 12:28, Frank Rowand <frowand.list@gmail.com> wrote:
>>>
>>> On 3/13/23 11:02, Frank Rowand wrote:
>>>> On 3/11/23 00:42, David Gow wrote:
>>>>> On Sat, 11 Mar 2023 at 07:34, Stephen Boyd <sboyd@kernel.org> wrote:
>>>>>>
>>>>>> Quoting David Gow (2023-03-10 00:09:48)
>>>>>>> On Fri, 10 Mar 2023 at 07:19, Stephen Boyd <sboyd@kernel.org> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> Hmm. I think you're suggesting that the unit test data be loaded
>>>>>>>> whenever CONFIG_OF=y and CONFIG_KUNIT=y. Then tests can check for
>>>>>>>> CONFIG_OF and skip if it isn't enabled?
>>>>>>>>
>>>>>>>
>>>>>>> More of the opposite: that we should have some way of supporting tests
>>>>>>> which might want to use a DTB other than the built-in one. Mostly for
>>>>>>> non-UML situations where an actual devicetree is needed to even boot
>>>>>>> far enough to get test output (so we wouldn't be able to override it
>>>>>>> with a compiled-in test one).
>>>>>>
>>>>>> Ok, got it.
>>>>>>
>>>>>>>
>>>>>>> I think moving to overlays probably will render this idea obsolete:
>>>>>>> but the thought was to give test code a way to check for the required
>>>>>>> devicetree nodes at runtime, and skip the test if they weren't found.
>>>>>>> That way, the failure mode for trying to boot this on something which
>>>>>>> required another device tree for, e.g., serial, would be "these tests
>>>>>>> are skipped because the wrong device tree is loaded", not "I get no
>>>>>>> output because serial isn't working".
>>>>>>>
>>>>>>> Again, though, it's only really needed for non-UML, and just loading
>>>>>>> overlays as needed should be much more sensible anyway.
>>>>>>
>>>>>> I still have one niggle here. Loading overlays requires
>>>>>> CONFIG_OF_OVERLAY, and the overlay loading API returns -ENOTSUPP when
>>>>>> CONFIG_OF_OVERLAY=n. For now I'm checking for the config being enabled
>>>>>> in each test, but I'm thinking it may be better to simply call
>>>>>> kunit_skip() from the overlay loading function if the config is
>>>>>> disabled. This way tests can simply call the overlay loading function
>>>>>> and we'll halt the test immediately if the config isn't enabled.
>>>>>>
>>>>>
>>>>> That sounds sensible, though there is a potential pitfall. If
>>>>> kunit_skip() is called directly from overlay code, might introduce a
>>>>> dependency on kunit.ko from the DT overlay, which we might not want.
>>>>> The solution there is either to have a kunit wrapper function (so the
>>>>> call is already in kunit.ko), or to have a hook to skip the current
>>>>> test (which probably makes sense to do anyway, but I think the wrapper
>>>>> is the better option).
>>>>>
>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>> That being said, I do think that there's probably some sense in
>>>>>>>>> supporting the compiled-in DTB as well (it's definitely simpler than
>>>>>>>>> patching kunit.py to always pass the extra command-line option in, for
>>>>>>>>> example).
>>>>>>>>> But maybe it'd be nice to have the command-line option override the
>>>>>>>>> built-in one if present.
>>>>>>>>
>>>>>>>> Got it. I need to test loading another DTB on the commandline still, but
>>>>>>>> I think this won't be a problem. We'll load the unittest-data DTB even
>>>>>>>> with KUnit on UML, so assuming that works on UML right now it should be
>>>>>>>> unchanged by this series once I resend.
>>>>>>>
>>>>>>> Again, moving to overlays should render this mostly obsolete, no? Or
>>>>>>> am I misunderstanding how the overlay stuff will work?
>>>>>>
>>>>>> Right, overlays make it largely a moot issue. The way the OF unit tests
>>>>>> work today is by grafting a DTB onto the live tree. I'm reusing that
>>>>>> logic to graft a container node target for kunit tests to add their
>>>>>> overlays too. It will be clearer once I post v2.
>>>>>>
>>>>>>>
>>>>>>> One possible future advantage of being able to test with custom DTs at
>>>>>>> boot time would be for fuzzing (provide random DT properties, see what
>>>>>>> happens in the test). We've got some vague plans to support a way of
>>>>>>> passing custom data to tests to support this kind of case (though, if
>>>>>>> we're using overlays, maybe the test could just patch those if we
>>>>>>> wanted to do that).
>>>>>>
>>>>>> Ah ok. I can see someone making a fuzzer that modifies devicetree
>>>>>> properties randomly, e.g. using different strings for clock-names.
>>>>>>
>>>>>> This reminds me of another issue I ran into. I wanted to test adding the
>>>>>> same platform device to the platform bus twice to confirm that the
>>>>>> second device can't be added. That prints a warning, which makes
>>>>>> kunit.py think that the test has failed because it printed a warning. Is
>>>>>> there some way to avoid that? I want something like
>>>>>>
>>>>>>         KUNIT_EXPECT_WARNING(test, <call some function>)
>>>>>>
>>>>>> so I can test error cases.
>>>>
>>>> DT unittests already have a similar concept.  A test can report that a
>>>> kernel warning (or any other specific text) either (1) must occur for the
>>>> test to pass or (2) must _not_ occur for the test to pass.  The check
>>>> for the kernel warning is done by the test output parsing program
>>>> scripts/dtc/of_unittest_expect.
>>>>
>>>> The reporting by a test of an expected error in drivers/of/unittest.c
>>>> is done by EXPECT_BEGIN() and EXPECT_END().  These have been in
>>>> unittest for a long time.
>>>>
>>>> The reporting by a test of a not expected to occur error is done
>>>> by EXPECT_NOT_BEGIN() and EXPECT_NOT_END().  These are added to
>>>> unittest in linux 6.3-rc1.
>>>>
>>>> I discussed this concept in one of the early TAP / KTAP discussion
>>>
>>> The link to the early KTAP discussion on this concept is:
>>>
>>>    https://lore.kernel.org/all/d38bf9f9-8a39-87a6-8ce7-d37e4a641675@gmail.com/T/#u
>>>
>>>
>>
>> Thanks -- I'd totally forgotten about that!
>>
> 
>> I still personally would prefer a way of checking this from within the
>> kernel, as if we're just printing out "EXPECT: " lines, then it's not
>> possible to know if a test passes just from the raw results (and
>> things like statistics can't be updated without a separate tool like
>> kunit.py parsing the KTAP.
> 
> Yes, I totally agree with that.  If there is a reasonable way to
> implement.  But in the DT unittest world, I have not found a
> reasonable way.  Adding hooks is suggested below, but for DT
> unittest _I_ (opinion) do not find that reasonable.  I voice no
> vote for kunit - that decision is up to the kunit crowd.
> 
>>
>> Indeed, my personal preference is that this log-based way of doing
>> expectations is probably best kept as a last resort. i.e.,
>> 1. Try to add a hook to the code which prints the message, which can
>> then fail the test (or set a flag for the test to check later). This
>> probably needs some better KUnit-side helpers to be truly ergonomic,
>> but at least avoids too strict a dependency on the exact formatting of
>> the log messages.
> 
> I'm not a fan of hooks.  I see them as a maintenance burden, dependent
> upon the source version of the object being tested, yet another
> thing that can go wrong, and adds complexity to creating a test
> environment and running the test.  Again, this just a personal
> opinion, and I'm not voting for or against this for kunit.
> 
>> 2. If that doesn't work, use console tracepoints or similar to
>> implement an EXPECT_BEGIN() / EXPECT_END() or similar API entirely
>> within the kernel.
> 
> Isn't this just another hook?  So same opinion.
> 
>> 3. Only if we can't come up with a working way of doing the former
>> options, resort to adding "EXPECT:" lines and having a parser pick up
>> on this.

Adding one more thought here so I don't forget it before the topic picks
up again in the KTAP version 2 world...

The test parser could generate an artificial subtest test case status line
or normal test case status line to report the result of the EXPECT.  This
also is ugly because it is creating a new requirement on the parser vs the
expectations in the KTAP plan line (the plan line could include the EXPECT
in the number of tests count, but then the raw KTAP test output would be
missing the artificial EXPECT test result).  No need to hash out details
here, just a thought...

-Frank

> 
> Again, don't let my opinion affect the voting between 1, 2, 3, or other
> for kunit.
> 
>>
>> One of the downsides of doing "EXPECT" lines in KTAP is that it'll
>> suddenly be much more dependent on the exact layout of the tests, as
>> we'd need to be able to override a test result if an expectation fails
>> (at least, to maintain the KUnit structure). And overriding a result
>> which is already in the output seems really, really ugly.
> 
> I don't understand "dependent on the exact layout of the tests".
> If you are saying that the test result parser has to figure out
> which test result to override, that has not been an issue in
> the cases that I use EXPECTs in DT unittest.  The EXPECT begin and
> EXPECT end have always immediately surrounded a single test, so
> when the parser processes the EXPECT end, only the most recent
> test result could be overridden.  This has worked because the
> kernel warning and error messages have been from kernel action
> that happens synchronously with the test.  If the test prods the
> kernel in a way that results in the kernel performing an
> asynchronous activity (eg in another thread), then it becomes
> more complex to structure the EXPECT end -- I would imagine that the
> test would have to block on the asynchronous activity just before
> reporting the normal KTAP status result for the test (and the
> EXPECT end would normally be just after reporting the KTAP
> status result for the test).
> 
> I agree with overriding being ugly.  For the DT unittest results
> parser, the EXPECT summary results are reported separately from
> the individual test summary results.  The parser also flags the
> EXPECT failure in line with the normal individual test result
> lines.
> 
> I see both parsing results as valid, and as a policy choice for
> each test parser.
> 
>>
>> There's a patch to the KASAN tests to move from doing option 1 to
>> option 2 above (in order to better support RCU, which didn't work with
>> the hook):
>> https://lore.kernel.org/all/ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com/
>>
>>
>>>> threads and expect to start a discussion thread on this specific
>>>> topic in the KTAP Specification V2 context.  I expect the discussion
>>>> to result in a different implementation than what DT unittests are
>>>> using (bike shedding likely to ensue) but whatever is agreed to
>>>> should be easy for DT to switch to.
>>>
>>> The link to the KTAP Specification Version 2 process and progress is:
>>>
>>>    https://elinux.org/Test_Results_Format_Notes#KTAP_version_2
>>>
>>
>> Thanks! We've got a few more KTAP ideas to air, so will hopefully send
>> those out soon!
> 
> Glad to hear, I'm hoping that process starts progressing a bit.
> 
> -Frank
> 
>>
>> Cheers,
>> -- David
>>
>>>>
>>>>>
>>>>> Hmm... I'd've thought that shouldn't be a problem: kunit.py should
>>>>> ignore most messages during a test, unless it can't find a valid
>>>>> result line. What does the raw KTAP output look like? (You can get it
>>>>> from kunit.py by passing the --raw_output option).
>>>>>
>>>>> That being said, a KUNIT_EXPECT_LOG_MESSAGE() or similar is something
>>>>> we've wanted for a while. I think that the KASAN folks have been
>>>>> working on something similar using console tracepoints:
>>>>> https://lore.kernel.org/all/ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com/
>>>>>
>>>>> Cheers,
>>>>> -- David
>>>>
>>>
> 

