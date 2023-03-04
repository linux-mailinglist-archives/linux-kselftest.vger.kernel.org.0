Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B926AAACA
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Mar 2023 16:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCDPiD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Mar 2023 10:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCDPiC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Mar 2023 10:38:02 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5615BBBBC;
        Sat,  4 Mar 2023 07:38:01 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id nv15so3761693qvb.7;
        Sat, 04 Mar 2023 07:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677944280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VizVUnHy9GSB0o/qHsH2eVXk1dA97D3zuZ6sfMVEQ08=;
        b=OLpQQIM6IppE0q6bJwA0zghclJLru6TiCk4cxrUE2HeLwXI3Y0lfhBt2oKEVKaMkxN
         SAN4518ZjZW+r4m1zcFaF/+JKg4rZvLB67tyXztAVDehjjOwrNdBmr3HuS/og2W16WdB
         dRQJrFIszSvEbeBKC238aIZdfKyPOrnFgJekuzpGutvei5ZVJHoXMUZTHzOR8/ICrcIq
         wSufNYsWZieix1VpBeCDCDnOpKYbUD3o6HdfukNQcfQ/jI9kXncX2CKX/tNsSit6ZXcM
         CAVRrGuad67xir+vNzdcoDTYj923el2tw+B3CzUjxdtK1pRgpXGglxvygiLrxschU50x
         QKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677944280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VizVUnHy9GSB0o/qHsH2eVXk1dA97D3zuZ6sfMVEQ08=;
        b=mWygzLOvejT691AaOakV7hti094RrYqW2QtAlG4SGefNunGLOsjr2caw0WDaklirsx
         DbP9toF4jYxOiCGSU11gHAmfq+f4gnMHoIOvW7moRHGZwaccWvvdQfr9SfCSgokYiovs
         O9Vz9DdCkdmM4NducjD3fYPTUBiARoH0xrMFbD+SxwoSrQjxVnFVMfltrzdq5LVD9PXB
         wfRanx8QCe+XmuDOAYo6bSi+2iUI6kL2uaBxx3yMDGn4Uk0vLRwGTa+zKRDAiuycpeRe
         uHciDP2rw9r0J8VCK1EWm3SPF5ChuXmaBCxwmrRSpWVAa0bUYJr73MfTBPe8Rri9m+yo
         TZMg==
X-Gm-Message-State: AO0yUKX3ei9j8xC1hCY42yNWzSHbO2zTxTBTxFa3BiFHaIR5/CmyrcIE
        f/g6U0n4u6ZhOav8MiiUWjA=
X-Google-Smtp-Source: AK7set+qQgKSMP4NFWBDNjqXo0pT4avb0WAev4EM931qCyVUY6MUqDZMlOJe7V1UH/KLvAA2qNBD8w==
X-Received: by 2002:a05:6214:d6c:b0:570:bf45:d6f7 with SMTP id 12-20020a0562140d6c00b00570bf45d6f7mr10349131qvs.45.1677944280234;
        Sat, 04 Mar 2023 07:38:00 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:99e6:eec3:1daa:f163? ([2600:1700:2442:6db0:99e6:eec3:1daa:f163])
        by smtp.gmail.com with ESMTPSA id bn2-20020a05620a2ac200b0073bad2f9380sm3956127qkb.14.2023.03.04.07.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 07:37:59 -0800 (PST)
Message-ID: <0dcf26a8-7d33-37cf-8365-2428ecd6d7cf@gmail.com>
Date:   Sat, 4 Mar 2023 09:37:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
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
 <CAL_JsqLVQVZhYTSZgrvA-V-xOUbiBdyDxqPOZk=89YS33EahBQ@mail.gmail.com>
 <093867df6137ad9e964b7dd90fb58f1a.sboyd@kernel.org>
 <CAL_JsqLdPWRLu8TNqCG+dw9Pz2cS798QwGX=C5X18KKqAXwjSQ@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqLdPWRLu8TNqCG+dw9Pz2cS798QwGX=C5X18KKqAXwjSQ@mail.gmail.com>
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

On 3/2/23 14:18, Rob Herring wrote:
> On Thu, Mar 2, 2023 at 1:44 PM Stephen Boyd <sboyd@kernel.org> wrote:
>>
>> Quoting Rob Herring (2023-03-02 09:13:59)
>>> On Wed, Mar 1, 2023 at 7:38 PM Stephen Boyd <sboyd@kernel.org> wrote:
>>>>
>>>> This patch series adds unit tests for the clk fixed rate basic type and
>>>> the clk registration functions that use struct clk_parent_data. To get
>>>> there, we add support for loading a DTB into the UML kernel that's
>>>> running the unit tests along with probing platform drivers to bind to
>>>> device nodes specified in DT.
>>>>
>>>> With this series, we're able to exercise some of the code in the common
>>>> clk framework that uses devicetree lookups to find parents and the fixed
>>>> rate clk code that scans devicetree directly and creates clks. Please
>>>> review.
>>>>
>>>> I Cced everyone to all the patches so they get the full context. I'm
>>>> hoping I can take the whole pile through the clk tree as they almost all
>>>> depend on each other. In the future I imagine it will be easy to add
>>>> more test nodes to the clk.dtsi file and not need to go across various
>>>> maintainer trees like this series does.
>>>>
>>>> Stephen Boyd (8):
>>>>   dt-bindings: Add linux,kunit binding
>>>>   of: Enable DTB loading on UML for KUnit tests
>>>>   kunit: Add test managed platform_device/driver APIs
>>>>   clk: Add test managed clk provider/consumer APIs
>>>>   dt-bindings: kunit: Add fixed rate clk consumer test
>>>>   clk: Add KUnit tests for clk fixed rate basic type
>>>>   dt-bindings: clk: Add KUnit clk_parent_data test
>>>>   clk: Add KUnit tests for clks registered with struct clk_parent_data
>>>
>>> Good to see bindings for this. I've been meaning to do something about
>>> the DT unittest ones being undocumented, but I hadn't really decided
>>> whether it was worth writing schemas for them. The compatibles at
>>> least show up with 'make dt_compatible_check'. Perhaps we want to just
>>> define some vendor (not 'linux') that's an exception rather than
>>> requiring schemas (actually, that already works for 'foo').
>>
>> Sure. Maybe "kunit" should be the vendor prefix? Or "dtbunit"?
> 
> We'd want to use the same thing on the DT unittests or anything else
> potentially. How about just 'test'?
> 
>>> It's
>>> likely that we want test DTs that fail normal checks and schemas get
>>> in the way of that as we don't have a way to turn off checks.
>>
>> Having the schemas is nice to make sure tests that are expecting some
>> binding are actually getting that. But supporting broken bindings is
>> also important to test any error paths in functions that parse
>> properties. Maybe we keep the schema and have it enforce that incorrect
>> properties are being set?
> 
> I wasn't suggesting throwing them out. More why I hadn't written any I guess.
> 
>> Do we really need to test incorrect bindings? Doesn't the
>> dt_bindings_check catch these problems so we don't have to write DTB
>> verifiers in the kernel?
> 
> Fair enough. Using my frequently stated position against me. :)
> 
> I do have a secret plan to implement (debug) type checks into the
> of_property_* APIs by extracting the type information from schemas
> into C.
> 
> 
>>> We already have GPIO tests in the DT unittests, so why is clocks
>>> different? Or should the GPIO tests be moved out (yes, please!)?
>>
>> Ah I didn't notice the GPIO tests in there. There are i2c tests too,
>> right? All I can say is clks are using kunit, that's the difference ;-)
> 
> Yeah, they should perhaps all move to the subsystems.
> 
>>> What happens when/if the DT unittest is converted to kunit? I think
>>> that would look confusing from the naming. My initial thought is
>>> 'kunit' should be dropped from the naming of a lot of this. Note that
>>> the original kunit submission converted the DT unittests. I would
>>> still like to see that happen. Frank disagreed over what's a unit test
>>> or not, then agreed, then didn't... I don't really care. If there's a
>>> framework to use, then we should use it IMO.
>>
>> Honestly I don't want to get involved in migrating the existing DT
>> unittest code to kunit. I'm aware that it was attempted years ago when
>> kunit was introduced. Maybe if the overlay route works well enough I can
>> completely sidestep introducing any code in drivers/of/ besides some
>> kunit wrappers for this. I'll cross my fingers!
> 
> Yeah, I wasn't expecting you to. I just want to make sure this meshes
> with any future conversion to kunit.
> 
> There's also some plans to always populate the DT root node if not
> present. That may help here. Or not. There's been a few versions
> posted with Frank's in the last week or 2.

As noted in that thread, by code inspection (not actual testing) I
think that the patch series breaks DT unittest for UML.  It should be
a trivial change in the next patch version to fix.

> 
> Rob

