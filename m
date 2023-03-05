Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5576AAE08
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Mar 2023 04:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjCEDdD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Mar 2023 22:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjCEDdD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Mar 2023 22:33:03 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0D614E90;
        Sat,  4 Mar 2023 19:33:01 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-176261d7f45so7716238fac.11;
        Sat, 04 Mar 2023 19:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677987180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bolxzuks2JcSU3HwyBsAdbA4mZ0mTabc+KtDVeTfiCU=;
        b=diZowVieJrXW3f9z0gQ5C/xwfNog5urV/PlR4bjOvdhBcWaZmNGMxjLm7QT695jZDf
         Wlyv1+1wqFtQ6+Ny2J9ah3hskUhSdj0PzsyPtymcP/tpqTMtZJRERGinZ78vRC2YtEPx
         Z66LRwaQfVt/8tAjtqTIzIbqsxKdB63+/9qJoJmgg6vk/pnLCuNXxsIsELd6vf2h6f1p
         d2kR0HH3yQ9CucrxKNjyDjdcxaIU5bVv5ECaihxFGOMfqPiR5rMDfFsxlA4kCd3O25q7
         PoM+8UxbppBDsrHm23jAiHwqf5jwRY2/9UAI1eUzBeRJ/MX09e0J463SEvLEXjQ4sYJb
         xIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677987180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bolxzuks2JcSU3HwyBsAdbA4mZ0mTabc+KtDVeTfiCU=;
        b=Tv81KmFilLYUIyQMBVrbLBN6kjngXcgdx9PMZJjccYbTUuPku6a8RsFKRNqGiqYhqA
         P7PsNGipfiSCfn8s0Sgi4H/xcMa5MN6uaV37UBTLpLUteGlcak62Yi89L5nhAKzr089n
         AMXOOQy3pM0rF6IzOQzQ/XIWykKF2ldKClHmmsKy9RlGK7BF6fTsXytPcGBG5lYYkxP0
         Sn1Ziq+a2gHFLyvAM+TKxpeTLHu4X8krgpDtlHVVW+yTx69zUOmh3SMDisfNtNxzSC1n
         MKYMMCUGz85TFBR0CHsxSzSOa36ZWeYXqpsj+vNz0kOJGAF1yiT3BRPFaipkJhDjyQPV
         DfnA==
X-Gm-Message-State: AO0yUKVwFkIO79x6rtn45vAxjajYS9KQIVnpkMNNaLztv/FEzHb+lUEV
        fDWjlXhxMe8yd/gKr4ia7WA=
X-Google-Smtp-Source: AK7set+bmqniPd5A8UuYoxpUYf2XWbLjw0+erhzxRCKZLD8QvB3a8go9x8K98NXKg/52znQ7oBsQuQ==
X-Received: by 2002:a05:6870:1116:b0:176:21a9:bf95 with SMTP id 22-20020a056870111600b0017621a9bf95mr3242193oaf.46.1677987179902;
        Sat, 04 Mar 2023 19:32:59 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:b008:9c28:aa1a:1293? ([2600:1700:2442:6db0:b008:9c28:aa1a:1293])
        by smtp.gmail.com with ESMTPSA id v2-20020a05687105c200b0017299192eb1sm2610374oan.25.2023.03.04.19.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 19:32:59 -0800 (PST)
Message-ID: <a2fdbd70-ca44-0d13-5b6f-4177761ecc18@gmail.com>
Date:   Sat, 4 Mar 2023 21:32:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     David Gow <davidgow@google.com>, Rob Herring <robh+dt@kernel.org>,
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
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20230302013822.1808711-1-sboyd@kernel.org>
 <CABVgOSnpMNCtEEsJV28OzUoxdDuiT4a2T0avP0AYf9xFW1jxrw@mail.gmail.com>
 <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com>
 <3759b28cca7ab751296d4dd83f2dcc51.sboyd@kernel.org>
 <CAMuHMdXDx6ChRj4xvWbQgcdJd0CGFi-RXySXr=M8QhBkA7YiGw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAMuHMdXDx6ChRj4xvWbQgcdJd0CGFi-RXySXr=M8QhBkA7YiGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/2/23 13:47, Geert Uytterhoeven wrote:
> Hi Stephen,
> 
> On Thu, Mar 2, 2023 at 8:28 PM Stephen Boyd <sboyd@kernel.org> wrote:
>> Quoting Rob Herring (2023-03-02 09:32:09)
>>> On Thu, Mar 2, 2023 at 2:14 AM David Gow <davidgow@google.com> wrote:
>>>> On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
>>>>> This patch series adds unit tests for the clk fixed rate basic type and
>>>>> the clk registration functions that use struct clk_parent_data. To get
>>>>> there, we add support for loading a DTB into the UML kernel that's
>>>>> running the unit tests along with probing platform drivers to bind to
>>>>> device nodes specified in DT.
>>>>>
>>>>> With this series, we're able to exercise some of the code in the common
>>>>> clk framework that uses devicetree lookups to find parents and the fixed
>>>>> rate clk code that scans devicetree directly and creates clks. Please
>>>>> review.
>>>>>
>>>>
>>>> Thanks Stephen -- this is really neat!
>>>>
>>>> This works well here, and I love all of the tests for the
>>>> KUnit/device-tree integration as well.
>>>>
>>>> I'm still looking through the details of it (alas, I've mostly lived
>>>> in x86-land, so my device-tree knowledge is, uh, spotty to say the
>>>> least), but apart from possibly renaming some things or similarly
>>>> minor tweaks, I've not got any real suggestions thus far.
>>>>
>>>> I do wonder whether we'll want, on the KUnit side, to have some way of
>>>> supporting KUnit device trees on non-UML architecctures (e.g., if we
>>>> need to test something architecture-specific, or on a big-endian
>>>> platform, etc), but I think that's a question for the future, rather
>>>> than something that affects this series.
>>>
>>> I'll say that's a requirement. We should be able to structure the
>>> tests to not interfere with the running system's DT. The DT unittest
>>> does that.
>>
>> That could be another choice in the unit test choice menu.
>> CONFIG_OF_KUNIT_NOT_UML that injects some built-in DTB overlay on an
>> architecture that wants to run tests.
> 
> As long as you use compatible values that don't exist elsewhere,
> and don't overwrite anything, you can load your kunit test overlays
> on any running system that has DT support.
> 
>>> As a side topic, Is anyone looking at getting UML to work on arm64?
>>> It's surprising how much x86 stuff there is which is I guess one
>>> reason it hasn't happened.
>>
>> I've no idea but it would be nice indeed.
> 
> I believe that's non-trivial. At least for arm32 (I didn't have any arm64
> systems last time I asked the experts).
> 
>>>> Similarly, I wonder if there's something we could do with device tree
>>>> overlays, in order to make it possible for tests to swap nodes in and
>>>> out for testing.
>>>
>>> Yes, that's how the DT unittest works. But it is pretty much one big
>>> overlay (ignoring the overlay tests). It could probably be more
>>> modular where it is apply overlay, test, remove overlay, repeat.
>>
>> I didn't want to rely on the overlay code to inject DT nodes. Having
>> tests written for the fake KUnit machine is simple. It closely matches
>> how clk code probes the DTB and how nodes are created and populated on
>> the platform bus as devices. CLK_OF_DECLARE() would need the overlay to
>> be applied early too, which doesn't happen otherwise as far as I know.
> 
> Don't all generic clock drivers also create a platform driver?
> At least drivers/clk/clk-fixed-factor.c does.
> 
>> But perhaps this design is too much of an end-to-end test and not a unit
>> test? In the spirit of unit testing we shouldn't care about how the node
>> is added to the live devicetree, just that there is a devicetree at all.
>>
>> Supporting overlays to more easily test combinations sounds like a good
>> idea. Probably some kunit_*() prefixed functions could be used to
>> apply a test managed overlay and automatically remove it when the test
>> is over would work. The clk registration tests could use this API to
>> inject an overlay and then manually call the of_platform_populate()
>> function to create the platform device(s). The overlay could be built in
>> drivers/clk/ too and then probably some macroish function can find the
>> blob and apply it.
> 
> No need to manually call of_platform_populate() to create the
> platform devices. That is taken care of automatically when applying
> an overlay.
> 
>> Is there some way to delete the platform devices that we populate from
>> the overlay? I'd like the tests to be hermetic.
> 

> Removing the overlay will delete the platform devices.

I _think_ that is incorrect.  Do you have a pointer to the overlay code that
deletes the device?  (If I remember correctly, the overlay remove code does not
even check whether the device exists and whether a driver is bound to it -- but
this is on my todo list to look into.)

-Frank

> 
> All of that works if you have your own code to apply a DT overlay.
> The recent fw_devlinks patches did cause some regressions, cfr.
> https://lore.kernel.org/all/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com
> 
> P.S. Shameless plug: for loading overlays from userspace, there are
>      my overlay branches, cfr. https://elinux.org/R-Car/DT-Overlays
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

