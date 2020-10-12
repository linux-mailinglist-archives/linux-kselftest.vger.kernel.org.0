Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D912D28C21B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Oct 2020 22:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgJLUNt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 16:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgJLUNs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 16:13:48 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CF0C0613D0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 13:13:47 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so15486850pgl.2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=What6Hz0p8cdFiLLn4KkGa4XjXh5+B4QX1PtDhjuO1s=;
        b=WkrH4obWFxQ9Jme98Nx4G8Qm+USqzeI0rZaVC58/8wvz4mHdb9x/mBWoaRB3psy0F/
         yy/l4qCEJ4J5yQTjv4YtoV5UUm6SaF4dHQ3haRVZAtcgyRwGMqICSsHZmXKYjCrMX5b4
         UyB9SDQ2bKQlPk3p44Ubvimkwh/gN7h+N1shViMLVbLo2CE1lvxg+/cvQT0z7CG9Q1ly
         UyryXU2okiRMVOn2rAPcG4RMpwVSMOyY2LSQLnGcul1e8sPhggL5IrpvMx7cmX4qJrBY
         YPXemOBc5qD7Zw7Waywdk4VHgMw06qCgtyloi0LD3NnhrkNZjegZrdCSX1sie5j1ytfK
         21YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=What6Hz0p8cdFiLLn4KkGa4XjXh5+B4QX1PtDhjuO1s=;
        b=nrCEupp4HE5LUTCvEIKQE9PaYKw1sewkKPMPJzmp60yGuP0o9Kg+TLqlrXQoXzAMfv
         9TSiY74ZLvEcUdxzCG9vdvV8QEZMd2N8K/q02rI80Ddeg56NrKQ3+U9Pv2JwUGokP6Lo
         QKJT2CZvTfej2Pq0+dLIy1lDsZ7Vaz0j7cyT2pse79wjgnRgpLPnPEOHLufpDBZCGad5
         PYvj2VsJN03cTXCWIevsLroub8JwTASOJN6lbhBZLx99ehk2119y9Q66WIhrStk4eET4
         nythYjcXGLlU0D7skymBgmW0lc8kAaVMqgxvnveq4uqlQjNh8QIDHPtBeHCFksdeurxJ
         w6Aw==
X-Gm-Message-State: AOAM530+g/eNf+todzn40+bOBFH1WueMsK4fykFEJCezzE+1kgIdQvqu
        9XHKZiYnmwAXpHfSQqKLeYIcj0UQTrObwvBs1sbtvetBL/Y=
X-Google-Smtp-Source: ABdhPJwGlrLaRQ2qDYSFDyQ8dA6034ccc3/7h3R9fZSB7oyhs43jhtvFGUb6CoHG0WRqx5wR5vcdDidT3godySgbDaY=
X-Received: by 2002:a17:90a:5806:: with SMTP id h6mr19239931pji.217.1602533626239;
 Mon, 12 Oct 2020 13:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200817043028.76502-1-98.arpi@gmail.com> <f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmusvillemoes.dk>
 <20200821113710.GA26290@alley> <4e26f696-3b50-d781-00fd-7fc6fdc2c3eb@rasmusvillemoes.dk>
In-Reply-To: <4e26f696-3b50-d781-00fd-7fc6fdc2c3eb@rasmusvillemoes.dk>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 12 Oct 2020 13:13:35 -0700
Message-ID: <CAFd5g45VABAd-Z3A39ORJ-VJM0oz=YQDjE=4C_jjw1LCzh67iw@mail.gmail.com>
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

On Fri, Aug 21, 2020 at 5:19 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:

Sorry about the late reply. I saw activity on this before and thought
it was under control. I only saw the unresolved state now looking
through patchwork.

> On 21/08/2020 13.37, Petr Mladek wrote:
> > On Mon 2020-08-17 09:06:32, Rasmus Villemoes wrote:
> >> On 17/08/2020 06.30, Arpitha Raghunandan wrote:
> >>> Converts test lib/test_printf.c to KUnit.
> >>> More information about KUnit can be found at
> >>> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
> >>> KUnit provides a common framework for unit tests in the kernel.
> >>
> >> So I can continue to build a kernel with some appropriate CONFIG set t=
o
> >> y, boot it under virt-me, run dmesg and see if I broke printf? That's
> >> what I do now, and I don't want to have to start using some enterprisy
> >> framework.
> >
> > I had the same concern. I have tried it.
>
> Thanks for doing that and reporting the results.
>
> >     #> modprobe printf_kunit
> >
> > produced the following in dmesg:
> >
> > [   60.931175] printf_kunit: module verification failed: signature and/=
or required key missing - tainting kernel
> > [   60.942209] TAP version 14
> > [   60.945197]     # Subtest: printf-kunit-test
> > [   60.945200]     1..1
> > [   60.951092]     ok 1 - selftest
> > [   60.953414] ok 1 - printf-kunit-test
> >
> > I could live with the above. Then I tried to break a test by the follow=
ing change:
> >
> >
> > diff --git a/lib/printf_kunit.c b/lib/printf_kunit.c
> > index 68ac5f9b8d28..1689dadd70a3 100644
> > --- a/lib/printf_kunit.c
> > +++ b/lib/printf_kunit.c
> > @@ -395,7 +395,7 @@ ip4(struct kunit *kunittest)
> >         sa.sin_port =3D cpu_to_be16(12345);
> >         sa.sin_addr.s_addr =3D cpu_to_be32(0x7f000001);
> >
> > -       test(kunittest, "127.000.000.001|127.0.0.1", "%pi4|%pI4", &sa.s=
in_addr, &sa.sin_addr);
> > +       test(kunittest, "127-000.000.001|127.0.0.1", "%pi4|%pI4", &sa.s=
in_addr, &sa.sin_addr);
> >         test(kunittest, "127.000.000.001|127.0.0.1", "%piS|%pIS", &sa, =
&sa);
> >         sa.sin_addr.s_addr =3D cpu_to_be32(0x01020304);
> >         test(kunittest, "001.002.003.004:12345|1.2.3.4:12345", "%piSp|%=
pISp", &sa, &sa);
> >
> >
> > It produced::
> >
> > [   56.786858] TAP version 14
> > [   56.787493]     # Subtest: printf-kunit-test
> > [   56.787494]     1..1
> > [   56.788612]     # selftest: EXPECTATION FAILED at lib/printf_kunit.c=
:76
> >                    Expected memcmp(test_buffer, expect, written) =3D=3D=
 0, but
> >                        memcmp(test_buffer, expect, written) =3D=3D 1
> >                        0 =3D=3D 0
> >                vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote '127.000.000=
.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > [   56.795433]     # selftest: EXPECTATION FAILED at lib/printf_kunit.c=
:76
> >                    Expected memcmp(test_buffer, expect, written) =3D=3D=
 0, but
> >                        memcmp(test_buffer, expect, written) =3D=3D 1
> >                        0 =3D=3D 0
> >                vsnprintf(buf, 20, "%pi4|%pI4", ...) wrote '127.000.000.=
001|127', expected '127-000.000.001|127'
> > [   56.800909]     # selftest: EXPECTATION FAILED at lib/printf_kunit.c=
:108
> >                    Expected memcmp(p, expect, elen+1) =3D=3D 0, but
> >                        memcmp(p, expect, elen+1) =3D=3D 1
> >                        0 =3D=3D 0
> >                kvasprintf(..., "%pi4|%pI4", ...) returned '127.000.000.=
001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > [   56.806497]     not ok 1 - selftest
> > [   56.806497] not ok 1 - printf-kunit-test
> >
> > while the original code would have written the following error messages=
:
> >
> > [   95.859225] test_printf: loaded.
> > [   95.860031] test_printf: vsnprintf(buf, 256, "%pi4|%pI4", ...) wrote=
 '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > [   95.862630] test_printf: vsnprintf(buf, 6, "%pi4|%pI4", ...) wrote '=
127.0', expected '127-0'
> > [   95.864118] test_printf: kvasprintf(..., "%pi4|%pI4", ...) returned =
'127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> > [   95.866589] test_printf: failed 3 out of 388 tests
> >
> >
> > Even the error output is acceptable for me.
>
> Urgh. Yeah, perhaps, but the original is much more readable; it really
> doesn't matter that a memcmp() fails to compare equal to 0, that's
> merely how we figured out that the output was wrong.

We can go back to the original error reporting format, just as long as
you don't mind the "ok" lines interspersed throughout (this is part of
an attempt to standardize around the KTAP reporting format[1].

> I am just curious why
> > the 2nd failure is different:
> >
> >    + original code: vsnprintf(buf, 6, "%pi4|%pI4", ...) wrote '127.0', =
expected '127-0'
> >    + kunit code: vsnprintf(buf, 20, "%pi4|%pI4", ...) wrote '127.000.00=
0.001|127', expected '127-000.000.001|127'
>
> That's by design. If you read the code, there's a comment that says we
> do every test case four times: With a buffer that is large enough to do
> the whole output, with a 0 size buffer (that's essential to allowing
> kasprintf to know how much to allocate),  with kvasprintf - but also
> with a buffer size that's guaranteed to ensure the output gets truncated
> somewhere. And that size is chosen randomly - I guess one could test
> every single buffer size between 0 and elen+1, but that's overkill.
>
> Now I should probably have made the tests deterministic in the sense of
> getting a random seed for a PRNG, printing that seed and allowing a
> module parameter to set the seed in order to repeat the exact same
> tests. But so far I haven't really seen any bugs caught by test_printf
> which would have been easier to fix with that.
>
> The reason I added that "chop it off somewhere randomly" was, IIRC, due
> to some %p extensions that behaved rather weirdly depending on whether
> there was enough room left or not, but I fixed those bugs before
> creating test_printf (and they were in turn the reason for creating
> test_printf). See for example 41416f2330, where %pE at the beginning of
> the format string would work ok, but if anything preceded it and the
> buffer was too small we'd crash.
>
> >
> > I am also a bit scared by the following note at
> > https://www.kernel.org/doc/html/latest/dev-tools/kunit/start.html#runni=
ng-tests-without-the-kunit-wrapper
> >
> >    "KUnit is not designed for use in a production system, and it=E2=80=
=99s
> >    possible that tests may reduce the stability or security of the
> >    system."
> >
> > What does it mean thay it might reduce stability or security?
> > Is it because the tests might cause problems?
> > Or because the kunit framework modifies functionality of the running
> > system all the time?

Oh yeah, that's just because we are afraid that tests might cause
problems. KUnit by itself does nothing to affect the stability or
security of the system.
