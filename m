Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C6B6F5098
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 May 2023 09:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjECHGl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 May 2023 03:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjECHGk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 May 2023 03:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9903B35B0
        for <linux-kselftest@vger.kernel.org>; Wed,  3 May 2023 00:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683097551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7rMfnngKbDMIXDY+jqrxZcVKh/6Dg/PieczSvFQViZc=;
        b=dPuuL+SC/rNBXFKH/J0qrHF504mUhafKpdgfCvZT4ACUkMYu7mLxAM2PveyY1W48Ux8FvF
        JPArAi42jEIOW2NZsJnn5+x4BCd/Nafs7y5E+ww44tLbrmcvxfu592110H31DJGqUl7ziN
        1bf7jfTBHqpMGuUW30sAkW5wUbhPdLw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-3mD0x0mKOo-mh1C8vFR9Nw-1; Wed, 03 May 2023 03:05:49 -0400
X-MC-Unique: 3mD0x0mKOo-mh1C8vFR9Nw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f173bd0d1bso29567455e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 May 2023 00:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683097549; x=1685689549;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rMfnngKbDMIXDY+jqrxZcVKh/6Dg/PieczSvFQViZc=;
        b=WAGUDoA5InEiv82fyJPrjPR262hLTqDoP93w5VbcR7yPgygyHf4hUEYfyk0DDdsnp7
         DEOmJc/1AtVILrgIVpmpa9hgeUzyXUib5GfiQI0DeQaX+njjrdakLOMeqfaNzGSPSoY1
         ymKO50t+ZYGW0rhqUEYLynGHSJhMpVuxsIs1SZxmlgFa8GB/dZ48aU7rmaM5ClHyuwz+
         8F0wT3VEScpLEWOLjzRZDivqJM4bd0Li+zitAZQ4NwsajwCo6HkLVpNpm2ZZNLyLgmcs
         nFARuPgYxRrIBwhAK00jz+6b/9mIu4kH/BeQxMrqYCKabcp3fsZ4TULOMGWHDcKQNpGr
         wA7g==
X-Gm-Message-State: AC+VfDzHo3/zMIOqO1YRRgY9hOLqtbZcbgsWUFo+wXPea2f04PgPg+b2
        kzvVsT3RYcVtgAbCrZO3ty4h+U2C8pCVV765krBoIKq723TaoA5UAl1TY4y0bv6wY2nNRE2+bpN
        HGciw9tjZc/z0C3YawM3ae6op9e33
X-Received: by 2002:a7b:c3c8:0:b0:3f1:745a:784 with SMTP id t8-20020a7bc3c8000000b003f1745a0784mr14058990wmj.23.1683097548668;
        Wed, 03 May 2023 00:05:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6EMZ0mCaWsxksHpAT35JNayZMXJp5qK8ljmGIxbIK6Kk82EZfo4YCQgIQhqMSmoIKtuva5Jg==
X-Received: by 2002:a7b:c3c8:0:b0:3f1:745a:784 with SMTP id t8-20020a7bc3c8000000b003f1745a0784mr14058969wmj.23.1683097548261;
        Wed, 03 May 2023 00:05:48 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t15-20020a1c770f000000b003ee63fe5203sm908356wmi.36.2023.05.03.00.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 00:05:47 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: tests - miscellaneous fixes
In-Reply-To: <CAMuHMdW_K9R7L9M_=M+HyWKivK6S2_Bhb5jvwdGv_oqZ06-NxA@mail.gmail.com>
References: <cover.1683022164.git.geert+renesas@glider.be>
 <CAMuHMdVmfj8L24QbMGn54jW96rYkvX1gizmvgvEB7T3Jwevd+g@mail.gmail.com>
 <878re6y9s8.fsf@minerva.mail-host-address-is-not-set>
 <ZFFCzHwJqyeXB52w@google.com>
 <CAMuHMdW_K9R7L9M_=M+HyWKivK6S2_Bhb5jvwdGv_oqZ06-NxA@mail.gmail.com>
Date:   Wed, 03 May 2023 09:05:46 +0200
Message-ID: <875y99yjw5.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Dmitry,
>
> On Tue, May 2, 2023 at 7:05=E2=80=AFPM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Tue, May 02, 2023 at 06:31:51PM +0200, Javier Martinez Canillas wrote:
>> > Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> > > On Tue, May 2, 2023 at 12:17=E2=80=AFPM Geert Uytterhoeven
>> > > <geert+renesas@glider.be> wrote:
>> > >> This patch series fixes a crash in the new input selftest, and make=
s the
>> > >> test available when the KUnit framework is modular.
>> > >>
>> > >> Unfortunately test 3 still fails for me (tested on Koelsch (R-Car M=
2-W)
>> > >> and ARAnyM):
>> > >>
>> > >>         KTAP version 1
>> > >>         # Subtest: input_core
>> > >>         1..3
>> > >>     input: Test input device as /devices/virtual/input/input1
>> > >>         ok 1 input_test_polling
>> > >>     input: Test input device as /devices/virtual/input/input2
>> > >>         ok 2 input_test_timestamp
>> > >>     input: Test input device as /devices/virtual/input/input3
>> > >>         # input_test_match_device_id: ASSERTION FAILED at # drivers=
/input/tests/input_test.c:99
>> > >>         Expected input_match_device_id(input_dev, &id) to be true, =
but is false
>> > >>         not ok 3 input_test_match_device_id
>> > >>     # input_core: pass:2 fail:1 skip:0 total:3
>> > >>     # Totals: pass:2 fail:1 skip:0 total:3
>> > >>     not ok 1 input_core
>> > >
>> > > Adding more debug code shows that it's the test on evbit [1] in
>> > > input_match_device_id() that fails.
>> > > Looking at your input_test_match_device_id(), I think you expect
>> > > the checks for the various bitmaps to be gated by
>> > > "if (id->flags & INPUT_DEVICE_ID_MATCH_EVBIT)", like is done for the
>> > > other checks?
>> > >
>> > > [1] https://elixir.bootlin.com/linux/latest/source/drivers/input/inp=
ut.c#L1021
>> > >
>> >
>> > That's correct. In input_test_init(), the input dev is marked as capab=
le
>> > of emitting EV_KEY BTN_LEFT and BTN_RIGHT. The goal of that test was to
>> > check this.
>> >
>> > That is, check if matches by the input dev capabilities in which case =
the
>> > __set_bit(EV_KEY, ...) would make the match true and __set_bit(EV_ABS,=
 ..)
>> > would make the condition false.
>> >
>> > But maybe I misunderstood how the input_set_capability() and __set_bit=
()
>> > functions work ?
>> >
>> > I'll take a look to this tomorrow, thanks a lot for your report!
>>
>> Unfortunately (?) INPUT_DEVICE_ID_MATCH_*BIT have never had any effect,
>> the kernel always used bitmaps when matching (with the assumption that
>> if one does not care about given bitmap they can simply pass empty one),
>> so I think what we need to change is:
>>
>> diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/inpu=
t_test.c
>> index 8b8ac3412a70..0540225f0288 100644
>> --- a/drivers/input/tests/input_test.c
>> +++ b/drivers/input/tests/input_test.c
>> @@ -87,7 +87,7 @@ static void input_test_timestamp(struct kunit *test)
>>  static void input_test_match_device_id(struct kunit *test)
>>  {
>>         struct input_dev *input_dev =3D test->priv;
>> -       struct input_device_id id;
>> +       struct input_device_id id =3D { 0 };
>>
>>         /*
>>          * Must match when the input device bus, vendor, product, version
>>
>> to avoid having garbage in the match data.
>
> Thanks, that did the trick! 3/3 tests pass.
>

Oh, silly me. Are you going to post that as a proper patch ?

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

