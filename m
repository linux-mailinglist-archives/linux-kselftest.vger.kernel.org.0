Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E4052D3DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 May 2022 15:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiESNYp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 May 2022 09:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiESNYp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 May 2022 09:24:45 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87E8CC159
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 06:24:43 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2f83983782fso56576467b3.6
        for <linux-kselftest@vger.kernel.org>; Thu, 19 May 2022 06:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XDtMkOgpFih4yHdm1CIJJjIlVnYhPbgQN+7Cn05E0kc=;
        b=CHyT/ElZiWt/DL9EarEAaB3niGBxtzIma7d8pW97F6Zqbo1c/5kngZXQPVxegbK08q
         zjlDs203oXI7INDIqv1PAFrkcVSpCJY9W8RdFw2mmYNWLnQzh9sR5kaZY5CWpYCEoLAb
         W06SJdSVkrBvR7JX6UhQQU/9pPDVgUi59rpYtgxtoKRmQGVID4sEJRqy4+CNINorW12r
         Oz3OH74xNmEJiANaddCXK6NU/Z/jPejQ8pkTk9RysSU+BWiDmLEXwT7QUSQoTfTlroR4
         Np4i6XEW2aZXKQw2qdGsxnv3IWqM9mB0N1M3yUCgYHYttpMu6YEeZA9OK+zyCvf957EY
         2FLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XDtMkOgpFih4yHdm1CIJJjIlVnYhPbgQN+7Cn05E0kc=;
        b=iEdh32mPfhBJTW9JZss1wuSgeRm+lZ4ZT+2WjU2jCOZkWKK8xf7JroO/8ocQteCyCN
         eCoq4OPMcwHBacjyhVnv9mGXDMePDnTWJ7gmBtHJ2nTbpryLXG6EsVxDdhtEzhQvUOEg
         Epr0PNMqzUI7Zwc8R6mgwx3IImUgAIDo2Tqxx3U2hU2VZSpBjK8dCZWJsjrY9gwS7MoO
         8mpLQigwI7cvSs97WEc66Fp6/kXkIfmacIq0GSEmXiFyMoGeu2O6j9i3QrcTW8Vgoe9X
         UoFa90+o5p0UqtKmGcdPUFXi4jhb95OqoGWHwLHX/UF9ZjRIXs5OtNXVeNBNhS7m0vPr
         MYYQ==
X-Gm-Message-State: AOAM531CzodQzJ/I5vEkbb/iHXDKZqfuYBicQPNHdrO2P0OiU6xWjqDF
        1x7oS7qsr23FGKCYvrTA7Ke+vHsPCPleP+4YWJeHYQ==
X-Google-Smtp-Source: ABdhPJxDdX6HrPZUsvJWehE9aj7j6dfVIf2Hl/Kqy7id9secQkgBjh7x9AoMX/NmntFjUqQ8AtWOVXJ1WMpgQgwWZwA=
X-Received: by 2002:a0d:e2d1:0:b0:2fe:e470:62b0 with SMTP id
 l200-20020a0de2d1000000b002fee47062b0mr4802912ywe.333.1652966682756; Thu, 19
 May 2022 06:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220518073232.526443-1-davidgow@google.com> <20220518073232.526443-2-davidgow@google.com>
 <YoS6rthXi9VRXpkg@elver.google.com> <CABVgOSmyApbC7en25ZBr7hLJye0mOnUY5ETR-VVEWmbaXq3bdQ@mail.gmail.com>
In-Reply-To: <CABVgOSmyApbC7en25ZBr7hLJye0mOnUY5ETR-VVEWmbaXq3bdQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 19 May 2022 15:24:06 +0200
Message-ID: <CANpmjNOdSy6DuO6CYZ4UxhGxqhjzx4tn0sJMbRqo2xRFv9kX6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcsan: test: Add a .kunitconfig to run KCSAN tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 19 May 2022 at 15:08, David Gow <davidgow@google.com> wrote:
>
> On Wed, May 18, 2022 at 5:21 PM Marco Elver <elver@google.com> wrote:
> >
> > On Wed, May 18, 2022 at 03:32PM +0800, David Gow wrote:
> > > Add a .kunitconfig file, which provides a default, working config for
> > > running the KCSAN tests. Note that it needs to run on an SMP machine, so
> > > to run under kunit_tool, the x86_64-smp qemu-based setup should be used:
> > > ./tools/testing/kunit/kunit.py run --arch=x86_64-smp --kunitconfig=kernel/kcsan
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> >
> > Thanks for adding this.
> >
> > > ---
> > >  kernel/kcsan/.kunitconfig | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >  create mode 100644 kernel/kcsan/.kunitconfig
> > >
> > > diff --git a/kernel/kcsan/.kunitconfig b/kernel/kcsan/.kunitconfig
> > > new file mode 100644
> > > index 000000000000..a8a815b1eb73
> > > --- /dev/null
> > > +++ b/kernel/kcsan/.kunitconfig
> > > @@ -0,0 +1,20 @@
> > > +# Note that the KCSAN tests need to run on an SMP setup.
> > > +# Under kunit_tool, this can be done by using the x86_64-smp
> > > +# qemu-based architecture:
> > > +# ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan --arch=x86_64-smp
> > > +
> > > +CONFIG_KUNIT=y
> > > +
> > > +CONFIG_DEBUG_KERNEL=y
> > > +
> > > +CONFIG_KCSAN=y
> > > +CONFIG_KCSAN_KUNIT_TEST=y
> > > +
> > > +# Needed for test_barrier_nothreads
> > > +CONFIG_KCSAN_STRICT=y
> > > +CONFIG_KCSAN_WEAK_MEMORY=y
> >
> > Note, KCSAN_STRICT implies KCSAN_WEAK_MEMORY.
> >
> > Also, a bunch of the test cases' outcomes depend on KCSAN's
> > "strictness". I think to cover the various combinations would be too
> > complex, but we can just settle on testing KCSAN_STRICT=y.
>
> It's definitely possible to either have multiple .kunitconfigs, each
> of which could have slightly different setups, e.g.:
> - kernel/kcsan/.kunitconfig (defualt)
> - kernel/kcsan/strict.kunitconfig (passed explicitly when desired)
>
> Equally, if we got rid of KCSAN_STRICT in the .kunitconfig, you could
> override it with --kconfig_add, e.g.
> -  ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan
> --arch=x86_64-smp
> - ./tools/testing/kunit/kunit.py run --kunitconfig=kernel/kcsan
> --arch=x86_64-smp --kconfig_add CONFIG_KSCAN_STRICT=y
>
> > The end result is the same, but you could drop the
> > CONFIG_KCSAN_WEAK_MEMORY=y line, and let the latest KCSAN_STRICT
> > defaults decide (I don't expect them to change any time soon).
> >
> > If you want it to be more explicit, it's also fine leaving the
> > CONFIG_KCSAN_WEAK_MEMORY=y line in.
>
> Do you have a preference here? Or to get rid of both and default to
> the non-strict version mentioned above?

I'd keep it simple for now, and remove both lines i.e. make non-strict
the default. It's easy to just run with --kconfig_add
CONFIG_KCSAN_STRICT=y, along with other variations. I know that
rcutoruture uses KCSAN_STRICT=y by default, so it's already getting
coverage there. ;-)

Thanks,
-- Marco
