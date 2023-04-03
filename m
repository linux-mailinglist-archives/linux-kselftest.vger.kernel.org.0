Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEAF6D5160
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 21:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDCTbV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 15:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjDCTbU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 15:31:20 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4775E7E
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 12:31:19 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id n125so36108589ybg.7
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Apr 2023 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680550279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4Sb4aNB4Tm57pBv/LH7p9W/GH8iszsqK1rV9TrOUZc=;
        b=nYYDFFKAXmmdC1bVg5DC83TMEBHx4jZsXCuTbeSRd8ZjWy7iLQuvcjEfL7ofTaEL8/
         YjElsr+7BynO6vwxnqa6LDCIkwnoID+0edRZfbXJ6xQ9PikFF/p9v9zH4SMjPHdSZhHR
         PteRSNhbrK1xsTF/haX4qChzd9AKqn283LYh2DbsCVlOSt4ToBEgeRUmxAeuiepQd0ON
         AUvIS8eAhyWe8MfEi9yDqJQgx/5HZPhgk7PRr/wBgGHTRAxgVcm+aRcIKIEv2uRmFXHx
         dZTrQrRkPbB/gusO/u2KCC3MIytz+zDdRjvmVaq4WjXlQurWo+RcHLvuOVDEvPGTZjq+
         UYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680550279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4Sb4aNB4Tm57pBv/LH7p9W/GH8iszsqK1rV9TrOUZc=;
        b=hnnC9rBNf6/wzymTC2nwEpmhnI8+8oUJin9bZaflVLC33epjRrUzqQhD3zVxBaYGdt
         qCrykAxPjVGt7EzDRS4R9wkDHIlr7zmZw9HGQTXV1Yu3XvY03QU7quB7BYcycIfhsWw0
         TW5QeTCZHD84wxWRy7W+MAF/PzIQ5kivYDJrkOEn5JyWqzmPPxxH+ifMOEwWcJPwNfY4
         MsUh0x69/xU8qcOObWUvEHP17WSYUx10cX5ATgUuE2LCcYfD3HunVquf69smUdhIL9lf
         8Uvdtp48pN+toZNvt0Fvd80I8q9Tqv3zHTufKOHoCTvpfbDQVzO8lpYuXB1xLEtHQgI7
         xdzw==
X-Gm-Message-State: AAQBX9ebHQ+BYfDlMHhvduZNTutmOCua2gdSJae9yB7hcT8MGqtSM712
        sZyocPK9XH+AZriURBhr+6L311PlRwrL4of0ubx8XA==
X-Google-Smtp-Source: AKy350aq+ygmaZETXBk4Ok7WJ46vMroire3QtHu2bsnyoLx8f3qCdFh0YLqHpPyuKsAO/SZQv2WCV0d7HGlCm9DrY6Q=
X-Received: by 2002:a25:3141:0:b0:b73:caa7:f06f with SMTP id
 x62-20020a253141000000b00b73caa7f06fmr224227ybx.5.1680550279039; Mon, 03 Apr
 2023 12:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230330220506.1399796-1-rmoar@google.com> <CAGS_qxqNwVcymkG6-8Kv72oZc9aDqjFjBBmjr+f+mOVKT1bGvA@mail.gmail.com>
In-Reply-To: <CAGS_qxqNwVcymkG6-8Kv72oZc9aDqjFjBBmjr+f+mOVKT1bGvA@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Mon, 3 Apr 2023 15:31:04 -0400
Message-ID: <CA+GJov5YigvgTf7ThaN9g8nOkoFKzJTiOLYO86cD5yVa2BEieg@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: add tests for using current KUnit test field
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 30, 2023 at 6:21=E2=80=AFPM 'Daniel Latypov' via KUnit Developm=
ent
<kunit-dev@googlegroups.com> wrote:
>
> I've got a few minor comments below, but this otherwise looks good.
> I like the idea of testing knuit_fail_current_test().
>
>
> On Thu, Mar 30, 2023 at 3:05=E2=80=AFPM Rae Moar <rmoar@google.com> wrote=
:
> >
> > +static void kunit_current_kunit_test_field(struct kunit *test)
> > +{
> > +       struct kunit *current_test;
> > +
> > +       /* Check to ensure the result of current->kunit_test
> > +        * is equivalent to current test.
> > +        */
> > +       current_test =3D current->kunit_test;
> > +       KUNIT_EXPECT_PTR_EQ(test, test, current_test);
>
> Perhaps we can combine this and the next test case down to
> static void kunit_current_test(struct kunit *test) {
>   /* There are two different ways of getting the current test */
>   KUNIT_EXPECT_PTR_EQ(test, test, current->kunit_test);
>   KUNIT_EXPECT_PTR_EQ(test, test, kunit_get_current_test());
> }
> ?

Hi Daniel!

Yes, I would be happy to combine these for v2. I might want to alter
that proposed comment slightly. "Two different ways" seems a bit
unclear to me. Maybe: Check results of both current->kunit_test and
kunit_get_current_test() are equivalent to current test. What do you
think? I might send out a v2 with a proposed comment.

>
> > +}
> > +
> > +static void kunit_current_get_current_test(struct kunit *test)
> > +{
> > +       struct kunit *current_test1, *current_test2;
> > +
> > +       /* Check to ensure the result of kunit_get_current_test()
> > +        * is equivalent to current test.
> > +        */
> > +       current_test1 =3D kunit_get_current_test();
> > +       KUNIT_EXPECT_PTR_EQ(test, test, current_test1);
> > +
> > +       /* Check to ensure the result of kunit_get_current_test()
> > +        * is equivalent to current->kunit_test.
> > +        */
> > +       current_test2 =3D current->kunit_test;
> > +       KUNIT_EXPECT_PTR_EQ(test, current_test1, current_test2);
>
> > +}
> > +
> > +static void kunit_current_fail_current_test(struct kunit *test)
> > +{
> > +       struct kunit fake;
> > +
> > +       /* Initialize fake test and set as current->kunit_test. */
>
> Nit: I think the code is self-explanatory enough that we can drop this co=
mment.
>

I agree the "initialize fake test" comment is self-explanatory. But if
we keep the comment regarding resetting the current test, I think we
should mark when we set the test as a fake with a comment as well.

> > +       kunit_init_test(&fake, "fake test", NULL);
> > +       KUNIT_EXPECT_EQ(test, fake.status, KUNIT_SUCCESS);
> > +       current->kunit_test =3D &fake;
> > +
> > +       /* Fail current test and expect status of fake test to be faile=
d. */
>
> Nit: I think this comment could also be dropped or maybe shortened to
>   kunit_fail_current_test("This should make `fake` fail");
>

This first option seems good to me.

> or
>   /* Now kunit_fail_current_test() should modify `fake`, not `test` */
>   kunit_fail_current_test("This should make `fake` fail");
>
> > +       kunit_fail_current_test("This test is supposed to fail.");
> > +       KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_FAI=
LURE);
> > +
>
> Hmm, should we try calling
>   kunit_cleanup(&fake);
> ?
>
> Right now this does resource cleanups, but we might have other state
> to cleanup for our `fake` test object in the future.
>

I would be fine to add this here if it is wanted.

Thanks Daniel for the comments!

Rae

> Daniel
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/CAGS_qxqNwVcymkG6-8Kv72oZc9aDqjFjBBmjr%2Bf%2BmOVKT1bGvA%40mail.=
gmail.com.
