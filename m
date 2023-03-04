Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5906AAAC2
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Mar 2023 16:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCDPdw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Mar 2023 10:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDPdv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Mar 2023 10:33:51 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3938F1353E;
        Sat,  4 Mar 2023 07:33:50 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id m4so3774806qvq.3;
        Sat, 04 Mar 2023 07:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677944029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPOaMM4z/o/74PWOB79M+Z3qoHNCo5CnO+zcqkcRKQo=;
        b=FvXAAn2o1qSeFTpmCvjX35ic+nx2wrMTtgs5IZUCRmYfH/jWs3Utbv1hSN31qk0BqT
         +SVXT3xIva4p3q+b3tBWSHE6tttaDu/M9zkxFMZciSiaX/2OsJ+z0Mghg+IWrWQfB0MI
         FaT+EEsdfcuduxbAzdz9HPSxNDhzsRaxqvd9Nft6HmohCCZXGU5dJAYnqyzLPI9Ouv2J
         i8YlTqRA2zBX1YVidCx33Di1NiWLVNRluX0D5yjFepOjMGBOZBKRVDWoeXeHBU4jWNRr
         yCXZeQGyx7yZj2hDijcjUWbPQfcPpgX7NGtqNsEiBNhazvOfh45Fs6qSEFcXshfW/Nty
         2JjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677944029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPOaMM4z/o/74PWOB79M+Z3qoHNCo5CnO+zcqkcRKQo=;
        b=iyOZkD3vOlGSI+xM6os6k87JtqiSPrYPPwotzjjlgpD3pw5g1CR/cMMLP7Ko4kocdy
         C0rlfVlA0kItB464STouXmb5FLz8I9gYG8uKiSZQiMT/RsYuIujHejB5IPRXuppK5zRY
         7eXxm4AWvChEMA44uw1NyTXmlhq05l8con62f8XPlHA2jqWihgd4zgEeOuVR+ffezYeM
         cCHH9S4gWvsVMTFDYmseWmPyTIVCzoRfp1OHyJW7AUXOj6R+qITQQkuR9XYcbuCWGrJG
         Fae8ayRo+uIbkOkjrGKKUUmCq/FnEZ0e5v+MZ5yrbSXTZQ0bFDLPAESi+3frjkgcQwvo
         T/Ag==
X-Gm-Message-State: AO0yUKXjlOl3j47hgukXMp4q8fWqntGBxDW+CClDwYFJkjmOx/iM7Dab
        6QPpe4h3irTpRMUEFOZw/Hej/hPShEQ=
X-Google-Smtp-Source: AK7set/T7IN44aotHKkdLQvQ0WoRv5q5jtuBgNAw15hXHEf80xrX+2vcxqYGR9yqGE61Tg2YbRjKbw==
X-Received: by 2002:a05:6214:d05:b0:56f:154:2517 with SMTP id 5-20020a0562140d0500b0056f01542517mr9775900qvh.10.1677944029257;
        Sat, 04 Mar 2023 07:33:49 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:99e6:eec3:1daa:f163? ([2600:1700:2442:6db0:99e6:eec3:1daa:f163])
        by smtp.gmail.com with ESMTPSA id c134-20020ae9ed8c000000b0073d873df3fesm2859393qkg.30.2023.03.04.07.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 07:33:48 -0800 (PST)
Message-ID: <1f56d371-9344-5c45-0024-ede99c551148@gmail.com>
Date:   Sat, 4 Mar 2023 09:33:48 -0600
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
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqLVQVZhYTSZgrvA-V-xOUbiBdyDxqPOZk=89YS33EahBQ@mail.gmail.com>
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

On 3/2/23 11:13, Rob Herring wrote:
> On Wed, Mar 1, 2023 at 7:38 PM Stephen Boyd <sboyd@kernel.org> wrote:
>>
>> This patch series adds unit tests for the clk fixed rate basic type and
>> the clk registration functions that use struct clk_parent_data. To get
>> there, we add support for loading a DTB into the UML kernel that's
>> running the unit tests along with probing platform drivers to bind to
>> device nodes specified in DT.
>>
>> With this series, we're able to exercise some of the code in the common
>> clk framework that uses devicetree lookups to find parents and the fixed
>> rate clk code that scans devicetree directly and creates clks. Please
>> review.
>>
>> I Cced everyone to all the patches so they get the full context. I'm
>> hoping I can take the whole pile through the clk tree as they almost all
>> depend on each other. In the future I imagine it will be easy to add
>> more test nodes to the clk.dtsi file and not need to go across various
>> maintainer trees like this series does.
>>
>> Stephen Boyd (8):
>>   dt-bindings: Add linux,kunit binding
>>   of: Enable DTB loading on UML for KUnit tests
>>   kunit: Add test managed platform_device/driver APIs
>>   clk: Add test managed clk provider/consumer APIs
>>   dt-bindings: kunit: Add fixed rate clk consumer test
>>   clk: Add KUnit tests for clk fixed rate basic type
>>   dt-bindings: clk: Add KUnit clk_parent_data test
>>   clk: Add KUnit tests for clks registered with struct clk_parent_data
> 
> Good to see bindings for this. I've been meaning to do something about
> the DT unittest ones being undocumented, but I hadn't really decided
> whether it was worth writing schemas for them. The compatibles at
> least show up with 'make dt_compatible_check'. Perhaps we want to just
> define some vendor (not 'linux') that's an exception rather than
> requiring schemas (actually, that already works for 'foo'). It's
> likely that we want test DTs that fail normal checks and schemas get
> in the way of that as we don't have a way to turn off checks.
> 
> We already have GPIO tests in the DT unittests, so why is clocks
> different? Or should the GPIO tests be moved out (yes, please!)?
> 
> What happens when/if the DT unittest is converted to kunit? I think

My current plan is to update the DT unittest output to be compatible
with the kunit output, so test harnesses can use the same framework
to process test output, and detect and report results.

kunit moved to the KTAP format a while ago.  I am working (more slowly
than I would like) to get the next version of the KTAP specification
agreed to, which has some features that will be needed to move DT
unittests to the KTAP output format.

Whether it is possible to subsequently move DT unittests into the
kunit framework is a different question, which could be addressed
as a possible next step of DT unittest transformation (but see my
opinion below).

> that would look confusing from the naming. My initial thought is
> 'kunit' should be dropped from the naming of a lot of this. Note that
> the original kunit submission converted the DT unittests. I would
> still like to see that happen. Frank disagreed over what's a unit test
> or not, then agreed, then didn't... I don't really care. If there's a
> framework to use, then we should use it IMO.

I don't think I ever agreed that the kunit framework was suitable to
implement DT unittest.

At a conceptual level, kunit and DT unittest differ architecturally
(the following is not what kunit looks like - the procedural flow is
hidden away in macros and the source looks more like data declarations).

  kunit
  -----
  test_1_initialization();
  test_1();
     test_1_a();
     test_1_b();
     ...
     test_1_N();
  test_1_cleanup();

  ## Each of test_1_*() reports pass / fail / skip
  ## I'm not sure if this is just one pass / fail / skip, or
  ## if multiple are supported.
  ##
  ## Each of test_1_*() are independent and could be reordered.


  DT unittest
  -----------
  some_initialization_in_early_boot()
  of_unittest()
     a_lot_of_initialization();
     subsystem_or_area_1_test();
        test_area_initialization();
        test_1_a();
        ## test_1_a() may or may not impact the devicetree data
        ## in a manner that is pre-requisite for test_1_b()
        test_1_b();
        ...
        ## At any point in test_1_a() .. test_1_N() may goto
        ##   out_ERROR_xxx: if a test fails in a way that
        ##   impacts subsequent test dependencies
        ##
        ## Possible clean up between or after each test_1_*()
        ## Possible validation that the devicetreee data is correct
        ##   after test activity
        test_1_c();
        ...
        test_1_N();
     subsystem_or_area_2_test();
        ...
     ## At arbitrary points, full tree or sub-tree validation to
     ## confirm tree integrity after completing the previous tests
     ...

   ## Much of test_1_*() are dependent on previously executed
   ## test_1_*() and can _not_ be reordered.

-Frank



> 
>>
>>  .../clock/linux,clk-kunit-parent-data.yaml    |  47 ++
>>  .../kunit/linux,clk-kunit-fixed-rate.yaml     |  35 ++
>>  .../bindings/kunit/linux,kunit.yaml           |  24 +
>>  arch/um/kernel/dtb.c                          |  29 +-
>>  drivers/clk/.kunitconfig                      |   3 +
>>  drivers/clk/Kconfig                           |   7 +
>>  drivers/clk/Makefile                          |   6 +
>>  drivers/clk/clk-fixed-rate_test.c             | 296 ++++++++++++
>>  drivers/clk/clk-kunit.c                       | 204 ++++++++
>>  drivers/clk/clk-kunit.h                       |  28 ++
>>  drivers/clk/clk_test.c                        | 456 +++++++++++++++++-
>>  drivers/of/Kconfig                            |  26 +
>>  drivers/of/Makefile                           |   1 +
>>  drivers/of/kunit/.kunitconfig                 |   4 +
>>  drivers/of/kunit/Makefile                     |   4 +
>>  drivers/of/kunit/clk.dtsi                     |  30 ++
>>  drivers/of/kunit/kunit.dtsi                   |   9 +
>>  drivers/of/kunit/kunit.dtso                   |   4 +
>>  drivers/of/kunit/uml_dtb_test.c               |  55 +++
>>  include/kunit/platform_driver.h               |  15 +
>>  lib/kunit/Makefile                            |   6 +
>>  lib/kunit/platform_driver-test.c              | 107 ++++
>>  lib/kunit/platform_driver.c                   | 207 ++++++++
> 
> Humm, we have DT platform driver unittests too. What's the difference?
> 
> Anyways, that's all just my initial reaction from only halfway looking
> at this. :)
> 
> Rob

