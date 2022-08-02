Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDAF588221
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 21:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiHBTAr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 15:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiHBTAm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 15:00:42 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4201B86F;
        Tue,  2 Aug 2022 12:00:40 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4Ly47q66Skz9st8;
        Tue,  2 Aug 2022 19:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659466840; bh=9AZD5MOtizRmS14SHAAMXYCLFtA2G/ghxYdJyTwagIs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oYDUF2WZ5q0a9vadga+60PpvW3OTED/ORzX+ncB7sVwGW3121JnpI52tRVS8PHcnt
         bV9bYRaE2u1kK6HGADSTBogBJDwwXVcDe8BWd8cHH0jc2SVBqDEY6r2MK6OsUqodLW
         q/BUSfabGQKl+56N4nFUAtlKdUhs6OMQ283fdyk8=
X-Riseup-User-ID: 6122C8D5C36CB6982A481A9B1FEEAFF2292E57F392BEB836C4FD120D74BA3C82
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Ly47j4SMbz5vfs;
        Tue,  2 Aug 2022 19:00:33 +0000 (UTC)
Message-ID: <5931f10d-09ac-84f3-f5d1-65039478ae97@riseup.net>
Date:   Tue, 2 Aug 2022 16:00:31 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] kunit: add KUnit array assertions to the
 example_all_expect_macros_test
Content-Language: en-US
To:     Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@riseup.net>
Cc:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        melissa.srw@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        jose.exposito89@gmail.com, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, davidgow@google.com,
        davem@davemloft.net, Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, airlied@linux.ie, kuba@kernel.org
References: <20220802161206.228707-1-mairacanal@riseup.net>
 <20220802161206.228707-3-mairacanal@riseup.net>
 <5c9038fd-a247-d0d3-841c-ba1e606bc309@riseup.net>
 <CAGS_qxodPndQZ_ypy-QP=ViNUvwZk1z1u8EAv9k5XzDEC4WSGQ@mail.gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <CAGS_qxodPndQZ_ypy-QP=ViNUvwZk1z1u8EAv9k5XzDEC4WSGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/2/22 15:15, 'Daniel Latypov' via KUnit Development wrote:
> On Tue, Aug 2, 2022 at 9:19 AM André Almeida <andrealmeid@riseup.net> wrote:
>> Às 13:12 de 02/08/22, Maíra Canal escreveu:
>>> Increament the example_all_expect_macros_test with the
>>> KUNIT_EXPECT_ARREQ and KUNIT_EXPECT_ARRNEQ macros by creating a test
>>> with array assertions.
>>>
>>> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
>>> ---
>>>  lib/kunit/kunit-example-test.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
>>> index f8fe582c9e36..fc81a45d9cbc 100644
>>> --- a/lib/kunit/kunit-example-test.c
>>> +++ b/lib/kunit/kunit-example-test.c
>>> @@ -86,6 +86,9 @@ static void example_mark_skipped_test(struct kunit *test)
>>>   */
>>>  static void example_all_expect_macros_test(struct kunit *test)
>>>  {
>>> +     const u32 array[] = { 0x0F, 0xFF };
>>> +     const u32 expected[] = { 0x1F, 0xFF };
> 
> Given the distance between the definition and their use, perhaps we
> can give them clearer names.
> E.g. array + diff_array, or array1 + array2, etc.
> 
> I think something to indicate they're arrays and that they're different.
> The current name `expected` is a bit unclear.

Thank you for the note, I'll address it at v2.

> 
>>> +
>>>       /* Boolean assertions */
>>>       KUNIT_EXPECT_TRUE(test, true);
>>>       KUNIT_EXPECT_FALSE(test, false);
>>> @@ -109,6 +112,10 @@ static void example_all_expect_macros_test(struct kunit *test)
>>>       KUNIT_EXPECT_STREQ(test, "hi", "hi");
>>>       KUNIT_EXPECT_STRNEQ(test, "hi", "bye");
>>>
>>> +     /* Array assertions */
>>> +     KUNIT_EXPECT_ARREQ(test, expected, expected, 2);
>>> +     KUNIT_EXPECT_ARRNEQ(test, array, expected, 2);
>>
>> ARRAY_SIZE() is usually better than constants is this case.
> 
> Note: that's actually incorrect!
> 

Yep, that's my bad!

> Ah right, this was the other blocker I had in mind.
> I wasn't sure how we'd handle the size parameter.
> 
> Users might think ARRAY_SIZE() is fine and copy-paste it.
> But the size parameter is in units of bytes, not array elements!
> If the element types are not 1 byte, it'll silently not compare the full array.
> 
> We'd want people to use
> KUNIT_EXPECT_ARREQ(test, expected, expected, sizeof(expected));
> 
> But this doesn't work for `u32 *array`, since it'll silently just
> compare 1 byte if people get them mixed up.
> 
> I don't know how we make a maximally fool-proof version of this macro :\

This is a hard one also. I believe that use KUNIT_EXPECT_ARREQ(test,
expected, expected, sizeof(expected)); is more compliant to the
memcpy/memset/memcmp signature. Moreover, this problem also occur for
the KUNIT_EXPECT_EQ(test, memcmp(expected, expected, sizeof(expected)), 0);

I believe that the number of array elements will make it easier for
users to avoid mistakes.

I'll change it internally for size_bytes = (size) * sizeof((left)[0]) on v2.

Best Regards,
- Maíra Canal

> 
