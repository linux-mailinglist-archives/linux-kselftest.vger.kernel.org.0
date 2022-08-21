Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D229059B434
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Aug 2022 16:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiHUODM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 10:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiHUOCQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 10:02:16 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9837A237FE;
        Sun, 21 Aug 2022 07:02:15 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4M9cck5gfZz9sCN;
        Sun, 21 Aug 2022 14:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1661090535; bh=gAM4PdmlKYJueNZRxYQai5rsrcd4RNBV226N43DwD9Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CVLUh0Ly9AZ8LR2aeZvecWY2WSJLcPIilOQEIKr4Eb31cdkpeDTHjzP1D/DxnqRIY
         Aw9pqGzIUjpli5kcZrnr6binnIvWJwX3RT9bZ+uc/+3wWJaHlxZnXqzSjjYkh0hkga
         sxdPrpozkwfakKYnyltDfZr+QtRfBkj1fpUvyRak=
X-Riseup-User-ID: E09EF545CEE7E54C355B6B896712ABD947769DA975F4710F7F3DD886C5666953
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4M9ccg0KR5z5vQt;
        Sun, 21 Aug 2022 14:02:10 +0000 (UTC)
Message-ID: <b791c1ce-dd81-f864-dfe2-962ad5ac5d41@riseup.net>
Date:   Sun, 21 Aug 2022 11:02:07 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/5] lib/cpumask_kunit: log mask contents
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <cover.1661007338.git.sander@svanheule.net>
 <98cb4e5323c2059506e93cb39c32ba471031e487.1661007339.git.sander@svanheule.net>
 <YwFWHj0p/Uc0njme@yury-laptop>
 <49f6eaa7e8586e4eba39d636ef034fc1626e3bc2.camel@svanheule.net>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <49f6eaa7e8586e4eba39d636ef034fc1626e3bc2.camel@svanheule.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/21/22 10:13, Sander Vanheule wrote:
> On Sat, 2022-08-20 at 14:46 -0700, Yury Norov wrote:
>> On Sat, Aug 20, 2022 at 05:03:12PM +0200, Sander Vanheule wrote:
>>> For extra context, log the contents of the masks under test.  This
>>> should help with finding out why a certain test fails.
>>>
>>> Link:
>>> https://lore.kernel.org/lkml/CABVgOSkPXBc-PWk1zBZRQ_Tt+Sz1ruFHBj3ixojymZF=Vi4tpQ@mail.gmail.com/
>>> Suggested-by: David Gow <davidgow@google.com>
>>> Signed-off-by: Sander Vanheule <sander@svanheule.net>
>>> Reviewed-by: David Gow <davidgow@google.com>
>>> ---
>>>  lib/cpumask_kunit.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/lib/cpumask_kunit.c b/lib/cpumask_kunit.c
>>> index 4d353614d853..0f8059a5e93b 100644
>>> --- a/lib/cpumask_kunit.c
>>> +++ b/lib/cpumask_kunit.c
>>> @@ -51,6 +51,10 @@
>>>  static cpumask_t mask_empty;
>>>  static cpumask_t mask_all;
>>>  
>>> +#define STR_MASK(m)                    #m
>>> +#define TEST_CPUMASK_PRINT(test, mask) \
>>> +       kunit_info(test, "%s = '%*pbl'\n", STR_MASK(mask), nr_cpumask_bits,
>>> cpumask_bits(mask))
>>> +
>>>  static void test_cpumask_weight(struct kunit *test)
>>>  {
>>>         KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
>>> @@ -103,6 +107,9 @@ static void test_cpumask_iterators_builtin(struct kunit
>>> *test)
>>>         /* Ensure the dynamic masks are stable while running the tests */
>>>         cpu_hotplug_disable();
>>>  
>>> +       TEST_CPUMASK_PRINT(test, cpu_online_mask);
>>> +       TEST_CPUMASK_PRINT(test, cpu_present_mask);
>>> +
>>>         EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, online);
>>>         EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, present);
>>>  
>>> @@ -114,6 +121,9 @@ static int test_cpumask_init(struct kunit *test)
>>>         cpumask_clear(&mask_empty);
>>>         cpumask_setall(&mask_all);
>>>  
>>> +       TEST_CPUMASK_PRINT(test, &mask_all);
>>> +       TEST_CPUMASK_PRINT(test, cpu_possible_mask);
>>> +
>>
>> It sort of breaks the rule of silence. Can you make this print conditional
>> on a test failure? If everything is OK, who wants to look into details? 
> 
> I will change the macros to the _MSG versions, and log the mask there.
> 
> I implemented this with kunit_info() as David proposed. AFAICT I can't call 
> kunit_info() only when the test fails, because the EXPECT_ macros don't return
> any result.

Maybe you can use KUNIT_EXPECT_EQ_MSG to print a more detailed error and
avoid printing the info when the test doesn't fail.

Best Regards,
- Maíra Canal

> 
> Best,
> Sander
> 
>>
>>>         return 0;
>>>  }
>>>  
>>> -- 
>>> 2.37.2
> 
