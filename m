Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616916AB60B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 06:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCFFca (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 00:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCFFc3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 00:32:29 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0785319F1A;
        Sun,  5 Mar 2023 21:32:28 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id jo29so5940277qvb.0;
        Sun, 05 Mar 2023 21:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678080747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MiPKMsiLMYcbxYp4rynCMsLu6OEagFUTtrUpOTm5FG4=;
        b=fFeQ+3l0U1qzYT1ysduN2sP0GdfNjC+8AF0rG6ywGf9vi6SrINzCLoPFKmgBsRRkYK
         gOLbqqCx7O2dWpJJL+GA27+EcmZ5ooeWJUGzHkk+3XL0hjGw6mxdUIGB6NbiKXeWxz4B
         wilnFH3qr/uU8kNpWYJG1BIL5c/UWzMAZX95L2u4fAji7ifhqlysAwg5bFQ9AWnWRXAB
         turO4Xhctv2S+cLzKLTrKZXxAQRcHPeosedXwn0aw8Sbhdunndq3E62VAllOlVKn+V6K
         +UimW74g+P8uXesrSOMIUKy++dFWpcc//YvdriqaMThusqA5kcjAvOVMN4CmPnNNBarE
         W40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678080747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiPKMsiLMYcbxYp4rynCMsLu6OEagFUTtrUpOTm5FG4=;
        b=MDG+YXcW9OhySRUZS8KyEynK2gyRl0lYyOmGj1S0xJAQfljkDO2wSYttlrgbMTESJQ
         L+OSQqb4XACvLGIZR5eXytw5V1iW82H60ChhHi7Ohu6z74iRDP8fI95YZ8KlMbk2vw8p
         pbQXYHYbPexTf7es1wPBD/1Qyb/m1xr5dIF7LNGdNzVpWX9O1xhGavkg8yScsvAMim5W
         d6qLaU9Sj/qKWTTnkl94JCJiyhx0yyKEv9Ru2o0hWn9wbF4fEqxEiIR+4F+6w5MUfOgm
         MjTo+NfOH9i+GC90Dv3LmVPmdPfR/HedYkZgnAaSqzDP2l7Eg8u8t9ZNjhIdGHDyQsa/
         wRvA==
X-Gm-Message-State: AO0yUKUabQw7D8v2oPJXS6IQUawINNRKdZWbafWk37RkUNzq82YyaJ7y
        HFG7dqT5kNkk+j4jRZ+ldmEemjXS01M=
X-Google-Smtp-Source: AK7set8x6C04G7U2rQVgc1T5sV7S1ZXKsemoJPLSenK3Bh4gKMTRpKktDP6kENr18uH4v3IYHuBG3w==
X-Received: by 2002:ad4:5de8:0:b0:571:d69:da8c with SMTP id jn8-20020ad45de8000000b005710d69da8cmr15359208qvb.19.1678080747037;
        Sun, 05 Mar 2023 21:32:27 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:64c7:9450:aac2:7f08? ([2600:1700:2442:6db0:64c7:9450:aac2:7f08])
        by smtp.gmail.com with ESMTPSA id x184-20020a3763c1000000b00738e8e81dc9sm6021908qkb.75.2023.03.05.21.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 21:32:26 -0800 (PST)
Message-ID: <3d64ed75-c9f7-391a-e125-7a7bf6a28bf6@gmail.com>
Date:   Sun, 5 Mar 2023 23:32:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, David Gow <davidgow@google.com>,
        Rob Herring <robh+dt@kernel.org>,
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
 <a2fdbd70-ca44-0d13-5b6f-4177761ecc18@gmail.com>
 <CAMuHMdUMrG9yuXDhDRd+mAUGo5_A6ONjAXXZkJTPXQsO_0C41A@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAMuHMdUMrG9yuXDhDRd+mAUGo5_A6ONjAXXZkJTPXQsO_0C41A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/5/23 03:26, Geert Uytterhoeven wrote:
> Hi Frank,
> 
> On Sun, Mar 5, 2023 at 4:33 AM Frank Rowand <frowand.list@gmail.com> wrote:
>> On 3/2/23 13:47, Geert Uytterhoeven wrote:
>>> On Thu, Mar 2, 2023 at 8:28 PM Stephen Boyd <sboyd@kernel.org> wrote:
>>>> Quoting Rob Herring (2023-03-02 09:32:09)
>>>>> On Thu, Mar 2, 2023 at 2:14 AM David Gow <davidgow@google.com> wrote:
>>>>>> On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
>>>>>>> This patch series adds unit tests for the clk fixed rate basic type and
>>>>>>> the clk registration functions that use struct clk_parent_data. To get
>>>>>>> there, we add support for loading a DTB into the UML kernel that's
>>>>>>> running the unit tests along with probing platform drivers to bind to
>>>>>>> device nodes specified in DT.
>>>>>>>
>>>>>>> With this series, we're able to exercise some of the code in the common
>>>>>>> clk framework that uses devicetree lookups to find parents and the fixed
>>>>>>> rate clk code that scans devicetree directly and creates clks. Please
>>>>>>> review.
>>>>>>>
>>>>>>
>>>>>> Thanks Stephen -- this is really neat!
>>>>>>
>>>>>> This works well here, and I love all of the tests for the
>>>>>> KUnit/device-tree integration as well.
>>>>>>
>>>>>> I'm still looking through the details of it (alas, I've mostly lived
>>>>>> in x86-land, so my device-tree knowledge is, uh, spotty to say the
>>>>>> least), but apart from possibly renaming some things or similarly
>>>>>> minor tweaks, I've not got any real suggestions thus far.
>>>>>>
>>>>>> I do wonder whether we'll want, on the KUnit side, to have some way of
>>>>>> supporting KUnit device trees on non-UML architecctures (e.g., if we
>>>>>> need to test something architecture-specific, or on a big-endian
>>>>>> platform, etc), but I think that's a question for the future, rather
>>>>>> than something that affects this series.
>>>>>
>>>>> I'll say that's a requirement. We should be able to structure the
>>>>> tests to not interfere with the running system's DT. The DT unittest
>>>>> does that.
>>>>
>>>> That could be another choice in the unit test choice menu.
>>>> CONFIG_OF_KUNIT_NOT_UML that injects some built-in DTB overlay on an
>>>> architecture that wants to run tests.
>>>
>>> As long as you use compatible values that don't exist elsewhere,
>>> and don't overwrite anything, you can load your kunit test overlays
>>> on any running system that has DT support.
>>>
>>>>> As a side topic, Is anyone looking at getting UML to work on arm64?
>>>>> It's surprising how much x86 stuff there is which is I guess one
>>>>> reason it hasn't happened.
>>>>
>>>> I've no idea but it would be nice indeed.
>>>
>>> I believe that's non-trivial. At least for arm32 (I didn't have any arm64
>>> systems last time I asked the experts).
>>>
>>>>>> Similarly, I wonder if there's something we could do with device tree
>>>>>> overlays, in order to make it possible for tests to swap nodes in and
>>>>>> out for testing.
>>>>>
>>>>> Yes, that's how the DT unittest works. But it is pretty much one big
>>>>> overlay (ignoring the overlay tests). It could probably be more
>>>>> modular where it is apply overlay, test, remove overlay, repeat.
>>>>
>>>> I didn't want to rely on the overlay code to inject DT nodes. Having
>>>> tests written for the fake KUnit machine is simple. It closely matches
>>>> how clk code probes the DTB and how nodes are created and populated on
>>>> the platform bus as devices. CLK_OF_DECLARE() would need the overlay to
>>>> be applied early too, which doesn't happen otherwise as far as I know.
>>>
>>> Don't all generic clock drivers also create a platform driver?
>>> At least drivers/clk/clk-fixed-factor.c does.
>>>
>>>> But perhaps this design is too much of an end-to-end test and not a unit
>>>> test? In the spirit of unit testing we shouldn't care about how the node
>>>> is added to the live devicetree, just that there is a devicetree at all.
>>>>
>>>> Supporting overlays to more easily test combinations sounds like a good
>>>> idea. Probably some kunit_*() prefixed functions could be used to
>>>> apply a test managed overlay and automatically remove it when the test
>>>> is over would work. The clk registration tests could use this API to
>>>> inject an overlay and then manually call the of_platform_populate()
>>>> function to create the platform device(s). The overlay could be built in
>>>> drivers/clk/ too and then probably some macroish function can find the
>>>> blob and apply it.
>>>
>>> No need to manually call of_platform_populate() to create the
>>> platform devices. That is taken care of automatically when applying
>>> an overlay.
>>>
>>>> Is there some way to delete the platform devices that we populate from
>>>> the overlay? I'd like the tests to be hermetic.
>>
>>> Removing the overlay will delete the platform devices.
>>
>> I _think_ that is incorrect.  Do you have a pointer to the overlay code that
>> deletes the device?  (If I remember correctly, the overlay remove code does not
>> even check whether the device exists and whether a driver is bound to it -- but
>> this is on my todo list to look into.)
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/of/platform.c#L769

Thanks!  That is precisely what I failed to remember.

-Frank

> 
>>> All of that works if you have your own code to apply a DT overlay.
>>> The recent fw_devlinks patches did cause some regressions, cfr.
>>> https://lore.kernel.org/all/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

