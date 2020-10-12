Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E0C28C344
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Oct 2020 22:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbgJLUtE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 16:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgJLUtE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 16:49:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B586C0613D0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 13:49:04 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d23so9331297pll.7
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gM5ubYzG27vt0QdpAC5kBFMLhscZEvN14dCPbrDfOfM=;
        b=Mcm5WR1/rQDht3VQR4YSx4CH89Q/TShAdVSst9OT9WGLFyecwLeG9ZQsJizhDKIzJG
         gmDEXDFimGC3KgVfdTT675Dm1PB8EIkRSt5zKrLNEK8JB69aNyAICuNyyjHoDYZoewVw
         x8os1FDsXxWYFhNc1conb8HlirSVg355+Lv41izx/a9lgYuctKBXrK0posDd1792Rr4q
         OB5w/lYd9FEVSK4uOW6smNTEhdOy3mFVmeFgRvvlOkTCS4jBWgU1gtD4GSy/UU0+u/VT
         hVvakyAV2lVJFPB6yDClobSS0BsFnBzOSy3Kj5NHPoG0FwKjpQj4/8PBxml5yNS74KMf
         6b+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gM5ubYzG27vt0QdpAC5kBFMLhscZEvN14dCPbrDfOfM=;
        b=WRjlf3mi5GbyU1U/UX9uL9AmUXEGQ48eXWczNkh4pmwkHUYHm05D1hAdsjC8hP+oCw
         4bhKie+TP+m+2FNuenkcOPNaku9d3XETmIm2gg8CeIy7CtNeQ4OFXO7xuqwO6NwCb0mu
         ycECqeWfTLMB7G8LIzADrRsy0zeFqSk6WkSboZP4NXnBKJqnRsfZwRlYaoP8EKe72Tqh
         FJRZ4KB5rrEC8r5K8Psa9a2ldffaQQaCLZjZBYE1rRW4VFyXA32u0cHicVBCD+8NMhsz
         debDcAaJur1HZza1m3VrVgzrQx/CSNwbravKcJDUyKF+plO7ui6+WRgOv9Zl7c6r6xjN
         uORw==
X-Gm-Message-State: AOAM5331zJBlu99oIZK4nEACViZKsprnEdQGrznrJu8UxTEJMQ6Kqjc7
        jfvxNgUan+qKqdD2YnQbwrsKhfzQZzzvL6EXt+RYtw==
X-Google-Smtp-Source: ABdhPJweSb6gr8p1s1xN6pfPGYBVIo6pPALc9y0IkXQdTLrfLkFOfo4vuL6WAOIf63JQtLx0DoUOm0n7IxJewr8nUi4=
X-Received: by 2002:a17:902:ba8c:b029:d2:aa93:c8b4 with SMTP id
 k12-20020a170902ba8cb02900d2aa93c8b4mr25677253pls.80.1602535743355; Mon, 12
 Oct 2020 13:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200817043028.76502-1-98.arpi@gmail.com> <f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmusvillemoes.dk>
 <20200821113710.GA26290@alley> <4e26f696-3b50-d781-00fd-7fc6fdc2c3eb@rasmusvillemoes.dk>
 <CAFd5g45VABAd-Z3A39ORJ-VJM0oz=YQDjE=4C_jjw1LCzh67iw@mail.gmail.com>
In-Reply-To: <CAFd5g45VABAd-Z3A39ORJ-VJM0oz=YQDjE=4C_jjw1LCzh67iw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 12 Oct 2020 13:48:52 -0700
Message-ID: <CAFd5g47wrVks-+rfPp=3qm+RYm9f+qvStw8TVwH_Eh8wh_Fzng@mail.gmail.com>
Subject: Re: [PATCH] lib: Convert test_printf.c to KUnit
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Petr Mladek <pmladek@suse.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 12, 2020 at 1:13 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Aug 21, 2020 at 5:19 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>
> Sorry about the late reply. I saw activity on this before and thought
> it was under control. I only saw the unresolved state now looking
> through patchwork.
>
> > On 21/08/2020 13.37, Petr Mladek wrote:
> > > On Mon 2020-08-17 09:06:32, Rasmus Villemoes wrote:
> > >> On 17/08/2020 06.30, Arpitha Raghunandan wrote:
> > >>> Converts test lib/test_printf.c to KUnit.
> > >>> More information about KUnit can be found at
> > >>> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
> > >>> KUnit provides a common framework for unit tests in the kernel.
> > >>
> > >> So I can continue to build a kernel with some appropriate CONFIG set=
 to
> > >> y, boot it under virt-me, run dmesg and see if I broke printf? That'=
s
> > >> what I do now, and I don't want to have to start using some enterpri=
sy
> > >> framework.
> > >
> > > I had the same concern. I have tried it.
> >
> > Thanks for doing that and reporting the results.
> >
> > >     #> modprobe printf_kunit
> > >
> > > produced the following in dmesg:
> > >
> > > [   60.931175] printf_kunit: module verification failed: signature an=
d/or required key missing - tainting kernel
> > > [   60.942209] TAP version 14
> > > [   60.945197]     # Subtest: printf-kunit-test
> > > [   60.945200]     1..1
> > > [   60.951092]     ok 1 - selftest
> > > [   60.953414] ok 1 - printf-kunit-test
> > >
> > > I could live with the above. Then I tried to break a test by the foll=
owing change:
> > >
> > >
> > > diff --git a/lib/printf_kunit.c b/lib/printf_kunit.c
> > > index 68ac5f9b8d28..1689dadd70a3 100644
> > > --- a/lib/printf_kunit.c
> > > +++ b/lib/printf_kunit.c
> > > @@ -395,7 +395,7 @@ ip4(struct kunit *kunittest)
> > >         sa.sin_port =3D cpu_to_be16(12345);
> > >         sa.sin_addr.s_addr =3D cpu_to_be32(0x7f000001);
> > >
> > > -       test(kunittest, "127.000.000.001|127.0.0.1", "%pi4|%pI4", &sa=
.sin_addr, &sa.sin_addr);
> > > +       test(kunittest, "127-000.000.001|127.0.0.1", "%pi4|%pI4", &sa=
.sin_addr, &sa.sin_addr);
> > >         test(kunittest, "127.000.000.001|127.0.0.1", "%piS|%pIS", &sa=
, &sa);
> > >         sa.sin_addr.s_addr =3D cpu_to_be32(0x01020304);
> > >         test(kunittest, "001.002.003.004:12345|1.2.3.4:12345", "%piSp=
|%pISp", &sa, &sa);
> > >
> > >
> > > It produced::
> > >
> > > [   56.786858] TAP version 14
> > > [   56.787493]     # Subtest: printf-kunit-test
> > > [   56.787494]     1..1
> > > [   56.788612]     # selftest: EXPECTATION FAILED at lib/printf_kunit=
.c:76
> > >                    Expected memcmp(test_buffer, expect, written) =3D=
=3D 0, but
> > >                        memcmp(test_buffer, expect, written) =3D=3D 1
> > >                        0 =3D=3D 0
> > >                vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.0=
00.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > > [   56.795433]     # selftest: EXPECTATION FAILED at lib/printf_kunit=
.c:76
> > >                    Expected memcmp(test_buffer, expect, written) =3D=
=3D 0, but
> > >                        memcmp(test_buffer, expect, written) =3D=3D 1
> > >                        0 =3D=3D 0
> > >                vsnprintf(buf, 20, "%pi4|%pI4", ...) wrote '127.000.00=
0.001|127', expected '127-000.000.001|127'
> > > [   56.800909]     # selftest: EXPECTATION FAILED at lib/printf_kunit=
.c:108
> > >                    Expected memcmp(p, expect, elen+1) =3D=3D 0, but
> > >                        memcmp(p, expect, elen+1) =3D=3D 1
> > >                        0 =3D=3D 0
> > >                kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.00=
0.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > > [   56.806497]     not ok 1 - selftest
> > > [   56.806497] not ok 1 - printf-kunit-test
> > >
> > > while the original code would have written the following error messag=
es:
> > >
> > > [   95.859225] test_printf: loaded.
> > > [   95.860031] test_printf: vsnprintf(buf, 256, "%pi4|%pI4", ...) wro=
te '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > > [   95.862630] test_printf: vsnprintf(buf, 6, "%pi4|%pI4", ...) wrote=
 '127.0', expected '127-0'
> > > [   95.864118] test_printf: kvasprintf(..., "%pi4|%pI4", ...) returne=
d '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > > [   95.866589] test_printf: failed 3 out of 388 tests
> > >
> > >
> > > Even the error output is acceptable for me.
> >
> > Urgh. Yeah, perhaps, but the original is much more readable; it really
> > doesn't matter that a memcmp() fails to compare equal to 0, that's
> > merely how we figured out that the output was wrong.
>
> We can go back to the original error reporting format, just as long as
> you don't mind the "ok" lines interspersed throughout (this is part of
> an attempt to standardize around the KTAP reporting format[1].
>
> > I am just curious why
> > > the 2nd failure is different:
> > >
> > >    + original code: vsnprintf(buf, 6, "%pi4|%pI4", ...) wrote '127.0'=
, expected '127-0'
> > >    + kunit code: vsnprintf(buf, 20, "%pi4|%pI4", ...) wrote '127.000.=
000.001|127', expected '127-000.000.001|127'
> >
> > That's by design. If you read the code, there's a comment that says we
> > do every test case four times: With a buffer that is large enough to do
> > the whole output, with a 0 size buffer (that's essential to allowing
> > kasprintf to know how much to allocate),  with kvasprintf - but also
> > with a buffer size that's guaranteed to ensure the output gets truncate=
d
> > somewhere. And that size is chosen randomly - I guess one could test
> > every single buffer size between 0 and elen+1, but that's overkill.
> >
> > Now I should probably have made the tests deterministic in the sense of
> > getting a random seed for a PRNG, printing that seed and allowing a
> > module parameter to set the seed in order to repeat the exact same
> > tests. But so far I haven't really seen any bugs caught by test_printf
> > which would have been easier to fix with that.
> >
> > The reason I added that "chop it off somewhere randomly" was, IIRC, due
> > to some %p extensions that behaved rather weirdly depending on whether
> > there was enough room left or not, but I fixed those bugs before
> > creating test_printf (and they were in turn the reason for creating
> > test_printf). See for example 41416f2330, where %pE at the beginning of
> > the format string would work ok, but if anything preceded it and the
> > buffer was too small we'd crash.
> >
> > >
> > > I am also a bit scared by the following note at
> > > https://www.kernel.org/doc/html/latest/dev-tools/kunit/start.html#run=
ning-tests-without-the-kunit-wrapper
> > >
> > >    "KUnit is not designed for use in a production system, and it=E2=
=80=99s
> > >    possible that tests may reduce the stability or security of the
> > >    system."
> > >
> > > What does it mean thay it might reduce stability or security?
> > > Is it because the tests might cause problems?
> > > Or because the kunit framework modifies functionality of the running
> > > system all the time?
>
> Oh yeah, that's just because we are afraid that tests might cause
> problems. KUnit by itself does nothing to affect the stability or
> security of the system.

And I forgot the link to KTAP[1]. I am really batting a thousand here.

[1] https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC81=
63FD830@CY4PR13MB1175.namprd13.prod.outlook.com/
