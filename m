Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F2E6B7BF4
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 16:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjCMPaq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Mar 2023 11:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCMPap (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Mar 2023 11:30:45 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBDE5CC26;
        Mon, 13 Mar 2023 08:30:44 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-177b78067ffso2951575fac.7;
        Mon, 13 Mar 2023 08:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678721443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0b3TgdJ99fVHE7Fi3WYmDiYFJwk0+grVkre963bfbbA=;
        b=TLjhRn9e0FF/cUyXqMyPGtTdJCz4IM3iq5yrjZGeOltpRLs+yJKQkEJy9Ma2FonAvu
         uibvAujnKZT0u79hixIX2oFeCy0f9tVW1kPWD5U0FtZDK3qAk4U+dAWbPmBCzBU4Ol3s
         DOrcdvKlhAYMRFVx/OK6YWH7mfk7W81J4IcgQbuAPSQBe0tPTxXK2OdK6J2tNGTbxbXR
         HWMMkWPOAoG8RNgQTjMrq5dn+oKgHzGOo/Ky8ASqMk5kQEknCNg04K4pvyqARzVdkbKU
         7L0yhzJldp1+mqnmhlHFTFXWB88dSPDNMxszYe7dQnBMnxnvvO9HnMODGfVccqSL3Yu+
         SmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678721443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0b3TgdJ99fVHE7Fi3WYmDiYFJwk0+grVkre963bfbbA=;
        b=gLdYu2Q4P3x3wbf83qv/YDSSY1lAk/HITVRPH+L9fqtipe23O9XKhKmPrEHwa/Oi24
         9yANb3TrJnLpLD3Pc0Rls4Nzdj3AOl0QlX1tpkjjlc2s3k6w+gv0ikgn+bWPLQ+Zl9n0
         TlKCBzdxgovFGekRFJZODm/SMec5UFDtqbHRKuNV0fao2KawUmRyG/N9fPfRsXhpiHjm
         gmz/drPGHOQ0fcMpEvf3nQIGRbujdqyPqqGXu6hj3T3KM+5xNfVWmLFtsG5wNqgHaHMp
         OaVnUdG6rwvORUOZcHOEN8zWAx7iqq7/xydS1MwONihgCBwsIeJV9LC4JcOt0wkNL3Nq
         ZuXA==
X-Gm-Message-State: AO0yUKUkGh2gKFM1LiBf5YJK2FYwvIzU0xOvY24BWlyJCARkLxznuiff
        3TtIM0ijUANd6fLEqZgr1xs=
X-Google-Smtp-Source: AK7set+6TyCLAMTfeShf5HNW6nlU+nm0GqRZLIhFOXlUEPx7J4wa/cjRQ9htKmprms8TICxiBi9pzw==
X-Received: by 2002:a05:6870:9591:b0:177:8219:ad62 with SMTP id k17-20020a056870959100b001778219ad62mr6346081oao.50.1678721443239;
        Mon, 13 Mar 2023 08:30:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:6822:a477:b6d1:664a? ([2600:1700:2442:6db0:6822:a477:b6d1:664a])
        by smtp.gmail.com with ESMTPSA id n185-20020acaefc2000000b00383e305597dsm3235820oih.23.2023.03.13.08.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 08:30:42 -0700 (PDT)
Message-ID: <8ab5b110-2f46-fb39-894e-64d59669c02a@gmail.com>
Date:   Mon, 13 Mar 2023 10:30:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Content-Language: en-US
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
 <2ce31cd1-7a0e-18ac-8a5b-ed09d6539241@gmail.com>
 <CABVgOS=6mLLYDr3ZOmv6iBQKPdFxTGDFP+uy9xgTHvdc03=vPw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CABVgOS=6mLLYDr3ZOmv6iBQKPdFxTGDFP+uy9xgTHvdc03=vPw@mail.gmail.com>
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

On 3/10/23 01:48, David Gow wrote:
> On Sat, 4 Mar 2023 at 23:50, Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 3/1/23 19:38, Stephen Boyd wrote:
>>> This patch series adds unit tests for the clk fixed rate basic type and
>>> the clk registration functions that use struct clk_parent_data. To get
>>> there, we add support for loading a DTB into the UML kernel that's
>>> running the unit tests along with probing platform drivers to bind to
>>> device nodes specified in DT.
>>>
>>> With this series, we're able to exercise some of the code in the common
>>> clk framework that uses devicetree lookups to find parents and the fixed
>>> rate clk code that scans devicetree directly and creates clks. Please
>>> review.
>>
>> I would _really_ like to _not_ have devicetree tests in two locations:
>> DT unittests and kunit tests.
>>
> 

This:

> I agree we don't want to split things up needlessly, but I think there
> is a meaningful distinction between:
> - Testing the DT infrastructure itself (with DT unittests)
> - Testing a driver which may have some interaction with DT (via KUnit)

> 
> So, rather than going for a "devicetree" KUnit suite (unless we wanted
> to port OF_UNITTEST to KUnit, which as you point out, would involve a
> fair bit of reworking), I think the goal is for there to be lots of
> driver test suites, each of which may verify that their specific
> properties can be loaded from the devicetree correctly.
> 
> This is also why I prefer the overlay method, if we can get it to
> work: it makes it clearer that the organisational hierarchy for these
> tests is [driver]->[devicetree], not [devicetree]->[drvier].
> 
>> For my testing, I already build and boot four times on real hardware:
>>
>>   1) no DT unittests
>>   2) CONFIG_OF_UNITTEST
>>   3) CONFIG_OF_UNITTEST
>>      CONFIG_OF_DYNAMIC
>>   4) CONFIG_OF_UNITTEST
>>      CONFIG_OF_DYNAMIC
>>      CONFIG_OF_OVERLAY
>>
>> I really should also be testing the four configurations on UML, but at
>> the moment I am not.
>>
>> I also check for new compile warnings at various warn levels for all
>> four configurations.
>>
>> If I recall correctly, the kunit framework encourages more (many more?)
>> kunit config options to select which test(s) are build for a test run.
>> Someone please correct this paragraph if I am mis-stating.
> 
> We do tend to suggest that there is a separate kconfig option for each
> area being tested (usually one per test suite, but if there are
> several closely related suites, sticking them under a single config
> option isn't a problem.)
> 
> That being said:
> - It's possible (and encouraged) to just test once with all of those
> tests enabled, rather than needing to test every possible combination
> of configs enabled/disabled.
> - (Indeed, this is what we do with .kunitconfig files a lot: they're
> collections of related configs, so you can quickly run, e.g., all DRM
> tests)
> - Because a KUnit test being run is an independent action from it
> being built-in, it's possible to build the tests once and then just
> run different subsets anyway, or possibly run them after boot if
> they're compiled as modules.
> - This of course, depends on two test configs not conflicting with
> each other: obviously if there were some tests which relied on
> OF_OVERLAY=n, and others which require OF_OVERLAY=y, you'd need two
> builds.
> 

And this:

> The bigger point is that, if the KUnit tests are focused on individual
> drivers, rather than the devicetree infrastructure itself, then these
> probably aren't as critical to run on every devicetree change (the DT
> unittests should hopefully catch anything which affects devicetree as
> a whole), but only on tests which affect a specific driver (as they're
> really intended to make sure the drivers are accessing / interacting
> with the DT properly, not that the DT infrastructure functions).

Those two paragraphs are correct, and my original assumption was wrong.

These tests appear to mostly be clock related and only minimally and
indirectly test devicetree functionality.  In more generic terms,
they are driver tests, not devicetree tests.

Thus I withdraw my concern of making the devicetree test environment
more complicated.

> 
> And obviously if this KUnit/devicetree support ends up depending on
> overlays, that means there's no need to test them with overlays
> disabled. :-)
> 
>>
>> Adding devicetree tests to kunit adds additional build and boot cycles
>> and additional test output streams to verify.
>>
>> Are there any issues with DT unittests that preclude adding clk tests
>> into the DT unittests?
>>
> 
> I think at least part of it is that there are already some clk KUnit
> tests, so it's easier to have all of the clk tests behave similarly
> (for the same reasons, alas, as using DT unittests makes it easier to
> keep all of the DT tests in the same place).
> 

> Of course, as DT unittests move to KTAP, and possibly in the future
> are able to make use of more KUnit infrastructure, this should get
> simpler for everyone.

I hope to move DT unitests to create KTAP V2 compatible data as a
first step.

I highly doubt that DT unittests fit the kunit model, but that would
be a question that could be considered after DT unittests move to the
KTAP V2 data format.

> 
> 
> Does that seem sensible?

Yes, thanks for the extra explanations.

> 
> -- David

