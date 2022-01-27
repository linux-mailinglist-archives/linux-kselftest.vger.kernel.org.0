Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AF249EC78
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 21:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245688AbiA0U1s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 15:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiA0U1s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 15:27:48 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218B6C061714
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 12:27:48 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id p12so5254404edq.9
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jan 2022 12:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQiZE2VyuneBgtPlVUPa+7lot3dvumZ8OUhp+P+Pisk=;
        b=c3udS0AewguSXGj0fpjk/0blod+wQRlJFsXf8KlOJNO73FK2ggGMw6HehwoubLxviD
         KmHNG1z6x6X05zwfDb2yI3KjCjysS8VKyfnse6vOHBEdLZ70Eo4X0KyRoOHoAWLMnCFU
         svXVr9brYTWXEkKvKWbZMrM1ifulBAZizQ6lK2K3zSc6olMdefCW7YjLjRKDhEhoBBHP
         SEf29+nV7lVTbcx17b536uXUDv50tudZB10t517JDl+zTKf3SiGF6884j4ChWVz58GdX
         QkICQKlojYWlC7eNEwnVH+5fGPwumyCqEk2vqQ33AOoWtj7sRDjF9uQgdg+QXw6w/Ds2
         WO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQiZE2VyuneBgtPlVUPa+7lot3dvumZ8OUhp+P+Pisk=;
        b=GQ8lMjyTu94UlSkGsdGXf1bcwKoQFTHb5YTjJlEOkvRdgBI/XJz3alUXt6Kav7AWbo
         NK1shbfaBEuJKBGxwILn8MagdmrNeX+293XjnEulsmbl/i4bRtw50xjcUuTvFxN1PDuw
         VokpN8VaSeCN4VIpi6H1ZhBGDkVd0EDgCMfCWiWHr/K76Y2FSJuGLvFfUYuUImsPC0Rt
         SQ4qq1KRUUySDpDiTCaSfKWYJWBedvXwa/N/lrVjItvtRoekhN++d0o9ErxedN91plnO
         2Iv2eNgfnjRrC+Lci8ZqGwcOG6EBdG67MnyWSUPBT79dyIfRM7JJ2xo7q3zwisjCt4Jz
         BaXw==
X-Gm-Message-State: AOAM5330do/0tq5kMims1NyCPUxKS8P50RHbOhxlpJFdvUF5yAHIocDi
        UkYT0UJo7PjPr9tsY+z0AfG5nzvvXY/qzHNn8cgsIeIOo2M=
X-Google-Smtp-Source: ABdhPJzTfpGcj/rkTsEu64/xIaiWOn1k3wDrfH0T/ccffkuYCK2S1zUU8DcZdwfKA+HbhLwYClft3oxpezf3u1kBp6I=
X-Received: by 2002:a50:eb46:: with SMTP id z6mr5076147edp.229.1643315266494;
 Thu, 27 Jan 2022 12:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20220125210011.3817742-1-dlatypov@google.com> <20220125210011.3817742-4-dlatypov@google.com>
 <CABVgOSm4EWFK5-KWto1HF3AEY9c77s5MufufXRDek3PAcWCccA@mail.gmail.com> <CAGS_qxpDGLR6=NKgxps+PXi-kyZDuyV67j6AybqTmOYOi5XqXw@mail.gmail.com>
In-Reply-To: <CAGS_qxpDGLR6=NKgxps+PXi-kyZDuyV67j6AybqTmOYOi5XqXw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 27 Jan 2022 12:27:35 -0800
Message-ID: <CAGS_qxqwRT9hqej_2KFWyFZ+A2DuD214BKHKD4KVd70B7X_Nkw@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: factor out str constants from binary assertion structs
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 27, 2022 at 12:21 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Wed, Jan 26, 2022 at 7:39 PM David Gow <davidgow@google.com> wrote:
> >
> > On Wed, Jan 26, 2022 at 5:00 AM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > If the compiler doesn't optimize them away, each kunit assertion (use of
> > > KUNIT_EXPECT_EQ, etc.) can use 88 bytes of stack space in the worst and
> > > most common case. This has led to compiler warnings and a suggestion
> > > from Linus to move data from the structs into static const's where
> > > possible [1].
> > >
> > > This builds upon [2] which did so for the base struct kunit_assert type.
> > > That only reduced sizeof(struct kunit_binary_assert) from 88 to 64.
> > >
> > > Given these are by far the most commonly used asserts, this patch
> > > factors out the textual representations of the operands and comparator
> > > into another static const, saving 16 more bytes.
> > >
> > > In detail, KUNIT_EXPECT_EQ(test, 2 + 2, 5) yields the following struct
> > >   (struct kunit_binary_assert) {
> > >     .assert = <struct kunit_assert>,
> > >     .operation = "==",
> > >     .left_text = "2 + 2",
> > >     .left_value = 4,
> > >     .right_text = "5",
> > >     .right_value = 5,
> > >   }
> > > After this change
> > >   static const struct kunit_binary_assert_text __text = {
> > >     .operation = "==",
> > >     .left_text = "2 + 2",
> > >     .right_text = "5",
> > >   };
> > >   (struct kunit_binary_assert) {
> > >     .assert = <struct kunit_assert>,
> > >     .text = &__text,
> > >     .left_value = 4,
> > >     .right_value = 5,
> > >   }
> > >
> > > This also DRYs the code a bit more since these str fields were repeated
> > > for the string and pointer versions of kunit_binary_assert.
> > >
> > > Note: we could name the kunit_binary_assert_text fields left/right
> > > instead of left_text/right_text. But that would require changing the
> > > macros a bit since they have args called "left" and "right" which would
> > > be substituted in `.left = #left` as `.2 + 2 = \"2 + 2\"`.
> > >
> > > [1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
> > > [2] https://lore.kernel.org/linux-kselftest/20220113165931.451305-6-dlatypov@google.com/
> > >
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > ---
> >
> > This definitely _feels_ like it's adding a bit more complexity than
> > would be ideal by splitting this out into a separate function, but I
> > do agree that it's worth it.
>
> I'll note that this was *more* of a simplification until I deduped the
> binary macros.
> Since we only have one macro now passing in the left/right/op strings
> now, it doesn't look like as much of an improvement anymore.
>
> So now the main other benefits are DRYing the assert structs.
> And I lean towards feeling that + stack size decrease = good enough
> reason to go ahead with the refactor.
>
> Re complexity, here's what KUNIT_EXPECT_EQ(test, 1 + 1, 2) turns into
>
> do {
>   typeof(1 + 1) __left = (1 + 1);
>   typeof(2) __right = (2);
>   static const struct kunit_binary_assert_text __text = {
>     .operation = "==",
>     .left_text = "1 + 1",
>     .right_text = "2",
>   };
>   do {
>     if (__builtin_expect(!!(!(__left == __right)), 0)) {
>       static const struct kunit_loc loc = {
>         .file = "lib/kunit/kunit-example-test.c",
>         .line = 29
>       };
>       struct kunit_binary_assert __assertion = {
>         .assert = { .format = kunit_binary_assert_format },
>         .text = &__text,
>         .left_value = __left,
>         .right_value = __right
>       };
>       kunit_do_failed_assertion(test, &loc, KUNIT_EXPECTATION,
>               &__assertion.assert,
>               ((void *)0));
>     }
>   } while (0);
> } while (0);
>
> Actually, looking at this, I realize we should probably
> 1) move the __text decl into the if statement

Nevermind, was a brainfart.
We can't move that into the if, since that happens inside the
KUNIT_ASSERTION macro and so we need to initialize __text outside of
it.

It's a bit unfortunately we need to pay the cost of initializing
__text even when we might not use it, but that's honestly a fairly
minimal cost and performance isn't KUnit's focus anyways.

> 2) probably should rename loc to __loc, oops.
>
> I'll send out a v2 that does #1.
> Maybe I'll include another patch that does #2 at the end of this
> series since the source patch already got picked up into Shuah's tree.
>
> >
> > I think left_text / right_text are good enough names, too: I wouldn't
> > bother trying to make them .left/.right.
> >
> >
> > Reviewed-by: David Gow <davidgow@google.com>
