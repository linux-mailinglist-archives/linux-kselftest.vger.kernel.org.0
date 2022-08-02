Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0122F5881C8
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 20:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiHBSPv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 14:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbiHBSPo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 14:15:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561F12FFFF
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Aug 2022 11:15:43 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id uj29so14234449ejc.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Aug 2022 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6BbJfTjdzqSyIyJ/BwNHDar8lvGvNh9tJJcETlMgsi8=;
        b=AAm3jF6Yv/WSrJVDzBAi32ZllaD6WcLJcAjOtSKJnri4173VklMNnvUGnSpWaK8DbH
         b0cFJX9FlGlpz0WmeNBTElE1kknA3giOGd3CuRBPwIYTa9DbVr9/SsakzgOpBwQ/A/Co
         /vqesB4IHMRKbZcq+VGsjIUB7i0oyDkJYQ8j6U+XiB6GiKf0O3Avb/HmbPDH/Mi9fmq1
         /T8pMTA6xmFLBVSHCZPCpr6dXdsjiE6JTJhEVtDdiCVZ9gDl/Fo9Thp76i2nJg+zEeoQ
         ALTdb322dXjVYojGkBb1TNx9zg+gwLP6yD+hnJEITarXNppZCv/iNe1rISks8mTSUWQh
         BrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6BbJfTjdzqSyIyJ/BwNHDar8lvGvNh9tJJcETlMgsi8=;
        b=fcRrd3kVvFeQ9Eg5MFHznH5Po+70UyDrEGWveSgWz/IsbT4CruLUWltCnr6GyEWqys
         RIIiITSnd/Qit+pzqZMYzXW4A6bFspki8HWlC4I84am7acypshHp0ZdcYGvTQarqtpYc
         LLP1WM9O6ONHD4ZqdY8YRYe7F0lwALv27IIkHz7lxX7jqUQ+0bC5KyyLUOJKo6V4m/Fw
         uYeCATqG41VuNXljEiX50RYFXIAMe13rHJm/aPO9fsnu8JHMF/57SuRqsPsYiPVC1lOM
         LPkhDuPcw1FXB628ul0cWidF1xCNjpsp7aNRpGnlVgaxZNiCP/7X6ZeTYNUi3Sc7t9br
         xFSw==
X-Gm-Message-State: ACgBeo2klTVwqhFDat1SuOI7B01jEV2ESJyXTDWHmdNoazABLh3V+HZu
        woxnHfDA7pCDiE7lGwBLGLRPj45C+MuGAFzrJzZKnQ==
X-Google-Smtp-Source: AA6agR4WJiek/NyhjdRitZ/3tHtbSX+J19XLEFJDKQDWrFtTzwoDqLPeKK0bnUYbbWTa4hKd9a2ds+rDH2YAVxAWUeA=
X-Received: by 2002:a17:907:2719:b0:730:a688:f1e4 with SMTP id
 w25-20020a170907271900b00730a688f1e4mr1756493ejk.425.1659464141758; Tue, 02
 Aug 2022 11:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220802161206.228707-1-mairacanal@riseup.net>
 <20220802161206.228707-3-mairacanal@riseup.net> <5c9038fd-a247-d0d3-841c-ba1e606bc309@riseup.net>
In-Reply-To: <5c9038fd-a247-d0d3-841c-ba1e606bc309@riseup.net>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 2 Aug 2022 11:15:30 -0700
Message-ID: <CAGS_qxodPndQZ_ypy-QP=ViNUvwZk1z1u8EAv9k5XzDEC4WSGQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: add KUnit array assertions to the example_all_expect_macros_test
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>
Cc:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        melissa.srw@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        jose.exposito89@gmail.com, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, davidgow@google.com,
        davem@davemloft.net, Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, airlied@linux.ie, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 2, 2022 at 9:19 AM Andr=C3=A9 Almeida <andrealmeid@riseup.net> =
wrote:
> =C3=80s 13:12 de 02/08/22, Ma=C3=ADra Canal escreveu:
> > Increament the example_all_expect_macros_test with the
> > KUNIT_EXPECT_ARREQ and KUNIT_EXPECT_ARRNEQ macros by creating a test
> > with array assertions.
> >
> > Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> > ---
> >  lib/kunit/kunit-example-test.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-t=
est.c
> > index f8fe582c9e36..fc81a45d9cbc 100644
> > --- a/lib/kunit/kunit-example-test.c
> > +++ b/lib/kunit/kunit-example-test.c
> > @@ -86,6 +86,9 @@ static void example_mark_skipped_test(struct kunit *t=
est)
> >   */
> >  static void example_all_expect_macros_test(struct kunit *test)
> >  {
> > +     const u32 array[] =3D { 0x0F, 0xFF };
> > +     const u32 expected[] =3D { 0x1F, 0xFF };

Given the distance between the definition and their use, perhaps we
can give them clearer names.
E.g. array + diff_array, or array1 + array2, etc.

I think something to indicate they're arrays and that they're different.
The current name `expected` is a bit unclear.

> > +
> >       /* Boolean assertions */
> >       KUNIT_EXPECT_TRUE(test, true);
> >       KUNIT_EXPECT_FALSE(test, false);
> > @@ -109,6 +112,10 @@ static void example_all_expect_macros_test(struct =
kunit *test)
> >       KUNIT_EXPECT_STREQ(test, "hi", "hi");
> >       KUNIT_EXPECT_STRNEQ(test, "hi", "bye");
> >
> > +     /* Array assertions */
> > +     KUNIT_EXPECT_ARREQ(test, expected, expected, 2);
> > +     KUNIT_EXPECT_ARRNEQ(test, array, expected, 2);
>
> ARRAY_SIZE() is usually better than constants is this case.

Note: that's actually incorrect!

Ah right, this was the other blocker I had in mind.
I wasn't sure how we'd handle the size parameter.

Users might think ARRAY_SIZE() is fine and copy-paste it.
But the size parameter is in units of bytes, not array elements!
If the element types are not 1 byte, it'll silently not compare the full ar=
ray.

We'd want people to use
KUNIT_EXPECT_ARREQ(test, expected, expected, sizeof(expected));

But this doesn't work for `u32 *array`, since it'll silently just
compare 1 byte if people get them mixed up.

I don't know how we make a maximally fool-proof version of this macro :\
