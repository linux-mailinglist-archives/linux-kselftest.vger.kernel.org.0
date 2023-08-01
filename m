Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B2876B1A3
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 12:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjHAKVo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 06:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjHAKVW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 06:21:22 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ED05276;
        Tue,  1 Aug 2023 03:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690885059; bh=mKkcfY5zqpLKFBoScbc+V2BRmzXnuf03ZpIGPeD6uB8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=gkpHN0vgZPP+Bm7wa32u0lXIRovoBU79/16NvzMf77oQ/cOvUDBVEdYDHlfj/2bkX
         Juql0hjSf1j3hqbpTnhu1sfJHloPN2BDmmnGRErWgzXMwfjaX8WY+peLolVN6poUGm
         VnEvuEwbkEXIujjDmLYcCMMXzF9tun1kN8rucCDU=
Date:   Tue, 1 Aug 2023 12:17:33 +0200 (GMT+02:00)
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        tanyuan@tinylab.org, w@1wt.eu
Message-ID: <9c47fc05-ba20-4d90-9d11-840f77c35aaa@t-8ch.de>
In-Reply-To: <20230801101508.75571-1-falcon@tinylab.org>
References: <6d67a8ed-8cb6-4ab7-8db0-68269981f8df@t-8ch.de> <20230801101508.75571-1-falcon@tinylab.org>
Subject: Re: [PATCH v2 07/10] selftests/nolibc: avoid unused arguments
 warnings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <9c47fc05-ba20-4d90-9d11-840f77c35aaa@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Aug 1, 2023 12:15:27 Zhangjin Wu <falcon@tinylab.org>:

> Hi, Thomas
>
>> On 2023-08-01 10:07:28+0200, Willy Tarreau wrote:
>>> On Tue, Aug 01, 2023 at 07:30:14AM +0200, Thomas Wei=C3=9Fschuh wrote:
>>>> This warnings will be enabled later so avoid triggering it.
>>>>
>>>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>>>> ---
>>>> tools/testing/selftests/nolibc/nolibc-test.c | 3 ++-
>>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/test=
ing/selftests/nolibc/nolibc-test.c
>>>> index 53a3773c7790..cb17cccd0bc7 100644
>>>> --- a/tools/testing/selftests/nolibc/nolibc-test.c
>>>> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
>>>> @@ -1089,7 +1089,8 @@ static int smash_stack(void)
>>>> =C2=A0=C2=A0=C2=A0 return 1;
>>>> }
>>>>
>>>> -static int run_protection(int min, int max)
>>>> +static int run_protection(int __attribute__((unused)) min,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int __attribute__((unused)) max)
>>>
>>> This one is used to silence -Wunused-parameter I guess.
>>
>> Yep.
>>
>>> It's one of
>>> the rare warnings that I find totally useless in field, because it's
>>> simply against the principle of using function pointers with different
>>> functions having the same interface but different implementations. As
>>> your code evolves you end up with unused on absolutely *all* of the
>>> arguments of *all* such functions, which makes them a real pain to add
>>> and tends to encourage poor practices such as excessive code reuse just
>>> by laziness or boredom. BTW it's one of those that are already disabled
>>> in the kernel and we could very well do the same here.
>>
>> It's indeed unfortunate.
>>
>> As long as we don't have too many of them I would prefer to keep the
>> explicit annotations. While they are ugly we then can still reap the
>> positive aspects of the warning.
>>
>> This is where -std=3Dc89 bites us. With extensions (or C2X) we could als=
o
>> just leave off the argument name to mark it as unused:
>> =C2=A0=C2=A0=C2=A0 run_protection(int, int)
>
> what about further simply ignore the arguments like we did for main(void)=
?

That doesn't work because it is stored as a function pointer in the testcas=
es array.
And these members all take the two parameters.
