Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BBF6AAADE
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Mar 2023 16:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCDPkN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Mar 2023 10:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCDPkI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Mar 2023 10:40:08 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847511E9E3;
        Sat,  4 Mar 2023 07:39:57 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id w23so6118174qtn.6;
        Sat, 04 Mar 2023 07:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677944393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvZM6A5QV3zdayH/S1bT6N5QCQ+HtUclZlnIwxMfu5Y=;
        b=Mu2Vrycmndn9hFrEsiCZNBjMKRHKo/+7PLhI3wnP7CKBoP6Cqtft+9thavbxmzCu1a
         iwvpl0E7qQrWUDNucm9v9/s85RmiMWifmCGhj48ceiIBpiorNx1OG5/dTY8y+olS8AsX
         86rwRTRJqgJ0XCgb0vwOsJwkCTlZFIdaLKpGe2kdZ/X7B9g69Sgzxd5J6ndnw78FCNq+
         kHo8MkPKzAsiwT302ar+t3cgbEzEvXoiN2dkNXLse5LWi4TkVWDtyxpvNfeddVnCi4Vk
         gngrnU1Y3jEV2r55+UyIG419NrTG2aKHRsKm8JWUoaVC04XjxuB5hvyeo5i7nMweG2ct
         REeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677944393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvZM6A5QV3zdayH/S1bT6N5QCQ+HtUclZlnIwxMfu5Y=;
        b=vqW6G9m3TXKS3XbNZsHIP532JVY/1NGfhDwD7kDPkbX4jS43fjwzxtH81kWiVaTjhO
         ATyfQyNRjH0+FpalUTEL+KeiNpJvK+dXEt1Ge0WzRrpxRXzS3BwJ0vcvoxuQbsd5B5wL
         lL7e0h0P0seLfVGjC2H1RYYudGYIkP8QPxE4i24U03LNbA0mT7iWH2PzRPQQbbDZ7e7I
         zt1mmdFwkRBsWjb9RfS/bvgCWmQsHtgddUWRGvYmQTmFdjxqecVLe/U0fUgroNf0YE70
         nR5mWMXMu8vDhNPeKrAW0v1/y6wf/iy8l1r9QwlWHDcbVi1JxqNaD93g+AXNgA3Zcdul
         l8Jw==
X-Gm-Message-State: AO0yUKUTH5+pecH787+Q6/fwVuJsX6870k3lAvLNg2Q2sC3G5/hXnKkn
        CyNwN6vlM3kYuwShbaKV99M=
X-Google-Smtp-Source: AK7set9yMsLrDslyIt4a/Hxzl/SiRN/pJYt8yXquPSQN+FZJEEWKVn8w/SLEjaP35h1OHtksDNGT3Q==
X-Received: by 2002:ac8:5f0d:0:b0:3b6:2bb3:fb53 with SMTP id x13-20020ac85f0d000000b003b62bb3fb53mr8661153qta.16.1677944393218;
        Sat, 04 Mar 2023 07:39:53 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:99e6:eec3:1daa:f163? ([2600:1700:2442:6db0:99e6:eec3:1daa:f163])
        by smtp.gmail.com with ESMTPSA id r136-20020a37a88e000000b0073b99d515e2sm3950827qke.44.2023.03.04.07.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 07:39:52 -0800 (PST)
Message-ID: <c81211fa-2836-fe21-637f-a5cca7237d43@gmail.com>
Date:   Sat, 4 Mar 2023 09:39:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J.Wysocki" <rafael@kernel.org>,
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
 <ecb5ede44d5bcc0430dad99e53d4477d.sboyd@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <ecb5ede44d5bcc0430dad99e53d4477d.sboyd@kernel.org>
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

On 3/2/23 17:57, Stephen Boyd wrote:
> Quoting Rob Herring (2023-03-02 12:18:34)
>> On Thu, Mar 2, 2023 at 1:44 PM Stephen Boyd <sboyd@kernel.org> wrote:
>>>
>>> Quoting Rob Herring (2023-03-02 09:13:59)
>>>>
>>>> Good to see bindings for this. I've been meaning to do something about
>>>> the DT unittest ones being undocumented, but I hadn't really decided
>>>> whether it was worth writing schemas for them. The compatibles at
>>>> least show up with 'make dt_compatible_check'. Perhaps we want to just
>>>> define some vendor (not 'linux') that's an exception rather than
>>>> requiring schemas (actually, that already works for 'foo').
>>>
>>> Sure. Maybe "kunit" should be the vendor prefix? Or "dtbunit"?
>>
>> We'd want to use the same thing on the DT unittests or anything else
>> potentially. How about just 'test'?
> 
> Sounds good.
> 
>>
>>>> It's
>>>> likely that we want test DTs that fail normal checks and schemas get
>>>> in the way of that as we don't have a way to turn off checks.
>>>
>>> Having the schemas is nice to make sure tests that are expecting some
>>> binding are actually getting that. But supporting broken bindings is
>>> also important to test any error paths in functions that parse
>>> properties. Maybe we keep the schema and have it enforce that incorrect
>>> properties are being set?
>>
>> I wasn't suggesting throwing them out. More why I hadn't written any I guess.
>>
>>> Do we really need to test incorrect bindings? Doesn't the
>>> dt_bindings_check catch these problems so we don't have to write DTB
>>> verifiers in the kernel?
>>
>> Fair enough. Using my frequently stated position against me. :)
>>
>> I do have a secret plan to implement (debug) type checks into the
>> of_property_* APIs by extracting the type information from schemas
>> into C.
>>
> 
> Ok. I suspect we may want to test error paths though so I don't know

Yes, exactly.

> what to do here. For now I'll just leave the bindings in place and
> change the prefix to "test".
> 
>>
>>>> We already have GPIO tests in the DT unittests, so why is clocks
>>>> different? Or should the GPIO tests be moved out (yes, please!)?
>>>
>>> Ah I didn't notice the GPIO tests in there. There are i2c tests too,
>>> right? All I can say is clks are using kunit, that's the difference ;-)
>>
>> Yeah, they should perhaps all move to the subsystems.
> 
> Got it.
> 
>>
>>>> What happens when/if the DT unittest is converted to kunit? I think
>>>> that would look confusing from the naming. My initial thought is
>>>> 'kunit' should be dropped from the naming of a lot of this. Note that
>>>> the original kunit submission converted the DT unittests. I would
>>>> still like to see that happen. Frank disagreed over what's a unit test
>>>> or not, then agreed, then didn't... I don't really care. If there's a
>>>> framework to use, then we should use it IMO.
>>>
>>> Honestly I don't want to get involved in migrating the existing DT
>>> unittest code to kunit. I'm aware that it was attempted years ago when
>>> kunit was introduced. Maybe if the overlay route works well enough I can
>>> completely sidestep introducing any code in drivers/of/ besides some
>>> kunit wrappers for this. I'll cross my fingers!
>>
>> Yeah, I wasn't expecting you to. I just want to make sure this meshes
>> with any future conversion to kunit.
> 
> Phew!
> 
>>
>> There's also some plans to always populate the DT root node if not
>> present. That may help here. Or not. There's been a few versions
>> posted with Frank's in the last week or 2.
>>
> 
> Ok. I think I have some time to try this overlay approach so let me see
> what is needed.

Please avoid overlays.  See my other replies in this thread for why.

