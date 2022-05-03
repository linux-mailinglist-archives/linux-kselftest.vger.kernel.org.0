Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEB1518C91
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 May 2022 20:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241638AbiECSwV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 14:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241636AbiECSwS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 14:52:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44C32F034
        for <linux-kselftest@vger.kernel.org>; Tue,  3 May 2022 11:48:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n10so17720992ejk.5
        for <linux-kselftest@vger.kernel.org>; Tue, 03 May 2022 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B6iYV5uPdXrRA/+rFiUJ0dX1+T8qkpqbtKApdzTC9jU=;
        b=fN4aZ5Pkz4/NffcBeusp6ZmX6xWXXm6KVaRLrLOhrVik3VekQpp5XYbUkUXDZmfcOb
         LpA1MJ5Nr0R9JmutYt0RNhaFmNIisNhoW22tepfDY8yYh2so5MF4Z6gt7hKsMCu9dTco
         Pmf2nJuaek4ZgeVVDgTitiwbL+s5efgc2qVZdxGifFlANxcwUZ06BgMX7pRPyJFqvnxi
         i9RYMHR4QIZOSegomOzd2xPQ4vpEsWRjqLyoLYF6rfI58pGIFSZzXTnwRXbCvuMjgrAV
         ISgU55gNYOKkyHV2XFMITxM3FQ5AHDGaToRNYItvQzy+1XQJSFQLdcxQJD/O/IvYZ/3O
         +5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6iYV5uPdXrRA/+rFiUJ0dX1+T8qkpqbtKApdzTC9jU=;
        b=0BJ+msjhsqGJ8LEiIzkemiT5JcRwpW7l0jR7HB6YAgS7hDs6U4N561SPqdvLwzLFiv
         z/yV42U7MeqfW0iB4FFJXLKJ/pWj7rUSZnzOcPAbqF8NyNl4HoCqXmJJC6F4VQmdkuWN
         xxfSa+rI5ZXQkS/B3Ep0bVZMszTktUKsnpjCV80wqbiSRNWSxZiLubhFJ5uSddO9ujMQ
         GgyLhn4+N7jIzsbp1Uf9Xj+sAWDtz3eMBFOiBfYY6FYETN9SZ43lKeNUoiMUYLOkHq1Y
         MK3XPNXlospTodyXU9hdgFUhXU/FVyv88VFI6JG7sg6UHJ19lU92abcPUy5SFU/g/3le
         3RCQ==
X-Gm-Message-State: AOAM532FQIV2dfZ6BiGfHziJgIhCeQpBTw1X7zxOfni4IcjqxdKeX/Vo
        AzkDSoyicAvYhHaaatv8q3TnIeHZBHKDvlL/FZCDWQ==
X-Google-Smtp-Source: ABdhPJxTs3UtrVmHXECRu6bpJzFvoIrg+BgnljB4OAgBhf3PrID6OZTOQO/sPQIwP5bxJaaMLCVJBrJlPFbkq+RHFnQ=
X-Received: by 2002:a17:907:72ce:b0:6f4:5a57:320c with SMTP id
 du14-20020a17090772ce00b006f45a57320cmr9404297ejc.75.1651603723165; Tue, 03
 May 2022 11:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220430045639.839186-1-davidgow@google.com> <CAGS_qxrVnDnUD=0f8vX5C2SWG2mxxXdAWU9A+P7h-K2Y1nm88A@mail.gmail.com>
 <CABVgOS=W8ub72D2LWwDsbfNBO6mFpceZWm+r+8Ct53pUcFJ_4g@mail.gmail.com>
In-Reply-To: <CABVgOS=W8ub72D2LWwDsbfNBO6mFpceZWm+r+8Ct53pUcFJ_4g@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 3 May 2022 13:48:31 -0500
Message-ID: <CAGS_qxpOFQ-ZpV2Jw1VEfggxKDqA57zRTY2LWZiK=iNMMo5QLA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Add list of all valid test configs on UML
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, May 3, 2022 at 1:37 AM David Gow <davidgow@google.com> wrote:
>
> On Tue, May 3, 2022 at 6:37 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Fri, Apr 29, 2022 at 11:56 PM David Gow <davidgow@google.com> wrote:
> > >
> > > It's often desirable (particularly in test automation) to run as many
> > > tests as possible. This config enables all the tests which work as
> > > builtins under UML at present, increasing the total tests run from 156
> > > to 342 (not counting 36 'skipped' tests).
> >
> > Just to clear up potential confusion for others, I'll note that these
> > aren't counting test cases.
> > This is from kunit.py's output, so it counts each parameter from
> > parameterized tests as "subtests."
> >
> > Copying my command from
> > https://kunit-review.googlesource.com/c/linux/+/5249, one can use this
> > to count the # of test cases.
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=...
> > --raw_output=kunit --kernel_args=kunit.action=list | egrep
> > '^[a-z0-9_-]+\.[a-z0-9_-]+'
> >
> > I see this enabling a total of 260 test _cases_ (including skipped).
> >
> > The default (basically just CONFIG_KUNIT_ALL_TESTS=y) gives 192
> > (including skipped).
> >
>
> Yup, that's definitely the case. I guess I still was thinking in KTAP
> terms, where all subtests are effectively tests.
>
> That being said, I do think the total (sub)test (including parameters,
> etc) number is the one that's more visible: not only does kunit_tool
> print it, but it's also what we've been using as our go to "number of
> tests" generally.

Yes, I agree it's the number to use here.
If there's a v2 of this patch, we could also reword the commit message
a bit to make it more explicit.
If not, this seems fine as-is. The only issue I saw was a minor typo.

Re goto for "number of tests."
Reminder, we've also been using this to count "# tests" :P
$ git grep 'KUNIT_CASE' | grep -Ev
'^Documentation/|get_metrics.sh|include/kunit/test.h' | wc -l
This avoids us having to figure out how to build all the tests,
sidesteps the problem that subtests can be dynamically generated via
parameterized testing, etc.

>
> > >
> > > They can be run with:
> > > ./tools/testing/kunit/kunit.py run
> > > --kunitconfig=./tools/testing/kunit/configs/all_tests_uml.config
> > >
> > > This acts as an in-between point between the KUNIT_ALL_TESTS config
> > > (which enables only tests whose dependencies are already enabled), and
> > > the kunit_tool --alltests option, which tries to use allyesconfig,
> > > taking a very long time to build and breaking very often.
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> >
> > Tested-by: Daniel Latypov <dlatypov@google.com>
> >
> > Looks good to me, some small comments below.
> >
> > > ---
> > >  .../kunit/configs/all_tests_uml.config        | 37 +++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > >  create mode 100644 tools/testing/kunit/configs/all_tests_uml.config
> > >
> > > diff --git a/tools/testing/kunit/configs/all_tests_uml.config b/tools/testing/kunit/configs/all_tests_uml.config
> > > new file mode 100644
> > > index 000000000000..bdee36bef4a3
> > > --- /dev/null
> > > +++ b/tools/testing/kunit/configs/all_tests_uml.config
> > > @@ -0,0 +1,37 @@
> > > +# This config enables as many tests as possible under UML.
> > > +# It is intended for use in continuous integration systems and similar for
> > > +# automated testing of as much as possible.
> > > +# The config is manually maintained, though it uses KUNIT_ALL_TESTS=y to enable
> > > +# any tests whose dependencies are already satisfied. Please feel free to add
> > > +# more options if they any new tests.
> >
> > missing: "enable"?
> > "if they enable any new tests"
> >
> Whoops, I was switching from "there are any" to "if they enable any"
> and clearly got distracted halfway through. :-)
>
> > Hmm, should we state a preference for how heavy (time or
> > resource-wise) tests should be?
> > Because the comment says it's meant for automation, but I can imagine
> > humans wanting to run it.
> > (I'm completely fine with us not stating one, just throwing the idea
> > out there for discussion)
>
> I think we're probably okay with being a little bit lenient on test
> times. The time_test_cases.time64_to_tm_test_date_range and similar
> tests take quite a long time in some situations already (older hw,
> running under some emulators), but is generally pretty close to
> instant under most UML setups. Particularly given that not building
> with allyesconfig already saves us many, many minutes of time.

Agreed on all points.
I personally think it's reasonable to leave things as-is.

We don't have any problematic tests that work on UML yet.
