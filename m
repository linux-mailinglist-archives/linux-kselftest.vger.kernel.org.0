Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA92A13A322
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 09:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgANIm0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 03:42:26 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:45133 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANImZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 03:42:25 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N5G1V-1jpXMb0r8X-011DMH; Tue, 14 Jan 2020 09:42:24 +0100
Received: by mail-qv1-f47.google.com with SMTP id dp13so5288694qvb.7;
        Tue, 14 Jan 2020 00:42:23 -0800 (PST)
X-Gm-Message-State: APjAAAWlw9t3c2G9F62XI6aneaxBdeKfPLh9jknZL4cVsYbgtg2xEHKB
        rjAK/PwouSN3VMVUDWLqKSV+1wnQaJNUfzhvKcU=
X-Google-Smtp-Source: APXvYqzHlEAuow8J7sfEaKx0vXugFGGudqVBX74JnJkLjytKVNtvs5tT0fUcCXq4SrHOE5kJOWfUX/v75TtgCYRAp54=
X-Received: by 2002:a0c:e7c7:: with SMTP id c7mr15837659qvo.222.1578991342846;
 Tue, 14 Jan 2020 00:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20200110134337.1752000-1-arnd@arndb.de> <CAFd5g47+_oyqsS0o0kQ+CaLNtjqbvOmQc-n0Ch1jAT6P6RSFiw@mail.gmail.com>
In-Reply-To: <CAFd5g47+_oyqsS0o0kQ+CaLNtjqbvOmQc-n0Ch1jAT6P6RSFiw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Jan 2020 09:42:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2YJuUvZnK4DEYoCrj=DZwvXKnN1Y2bLkAKd7gp1us3eQ@mail.gmail.com>
Message-ID: <CAK8P3a2YJuUvZnK4DEYoCrj=DZwvXKnN1Y2bLkAKd7gp1us3eQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] kunit: move binary assertion out of line
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9547x2bVt3blggZ1UxBmuWeDc52ZrKwp9cZzwP3O+Z0QxT2vzbn
 p2YrZZllygUR5/yhEMbPoqz1Iv7dLM1SiMQPKZh/nXEk3gYzvEen2UqczXxNJKcOhbY8+cu
 PTNWMURzNUctheXmbrcQoJ0WzEMzpmNpkC+ERLgRCFSw0LBY9kj5qwWQs6Ps4MjYDTMljIH
 VCM7uy+67v6q/UhZQyyVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bHcbYbgWn2g=:McvsmWOR1P9y2FOt5ylA3t
 aPn2KuyOFoaeODWp/Xo3jzzX/04V92SO1itz1WaVpSajr+WVf1R8hc/qBGnfiM3Fexb0iipdH
 1CkwsZRSC5VZHH3j8mG2gx00UTGYnUKjAHWjiWwcAYyY5sPcpRGIegwrDxUotVH+zZh3Vh+qT
 0nGrqYzwdqQ0LeCqcNcg6Sz4zSajTffSt1SVSA+TAnPg3H4R80pLisDS6evjqOtS5kDXHfMtr
 FVLF/HRCL/3Xrf/qhj9tsxG9P5fuA/BIiBrTUZWyaRxpLGuZ64i6mhJv/BEHMlpB62EetxB9Z
 01iR0NHzZ/VXCE3SfJKJUQAOEpPeOEKw/g6pcxicG/ugf6bmzIJt65XtLCMIUehy7q+DUQx9l
 luRl9m7i5yebqtDpb4WXGPVj3psACHEvviJ6tKAcb7KhXL584dQ6Gv8gp2xQOqyp5Vnwq0eHn
 idc36T6fRKV+0JBot6DasVUxmkmw831Ri3/NY1lSwr/GWD0rV/E4WPue7bJt/LwgSNtQQOiEb
 aFD9iCP06P8J4BuwrNnXfAD75YAOd+nEi4xo999HeqS8i8xUuglGfw5i0x84oiOfMR/wweAYE
 12MzcBiBni5EBjGWVC12oyFumj7be9a3FRj3JXs7SHYQkqyijmbvAnlxVtHbg06emzKAUnkML
 b5EF2udYSCwYj23WYCkYizyh092x9o/WiOJ9RI6n1L+ev4jfmctTogTZ50Ff2FzQ6wFlU/jrs
 fUBdsNiNCwMtBhIRqt/zsJatUZahBJ2IQ+vOi7n2Twq8wxS8TidO2vPpieTr5AY8e234whtS+
 AuIyfLKkYQabVlHWQz5lvluV+ZVEIbLviOHf2itXIjFGeF7qp4EYw+bvJaEp/vdmP8Fycaf7n
 bf7s9rQ0wfGpLZITPuuw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 14, 2020 at 3:13 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Jan 10, 2020 at 5:43 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > In combination with the structleak gcc plugin, kunit can lead to excessive
> > stack usage when each assertion adds another structure to the stack from
> > of the calling function:
> >
> > base/test/property-entry-test.c:99:1: error: the frame size of 3032 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> >
> > As most assertions are binary, change those over to a direct function
> > call that does not have this problem.  This can probably be improved
> > further, I just went for a straightforward conversion, but a function
> > call with 12 fixed arguments plus varargs it not great either.
>
> Yeah, I am not exactly excited by maintaining such a set of functions.

Ok.

> I don't think anyone wants to go with the heap allocation route.
>
> Along the lines of the union/single copy idea[1]. What if we just put
> a union of all the assertion types in the kunit struct? One is already
> allocated for every test case and we only need one assertion object
> for each test case at a time, so I imagine that sould work.

Ah right, that should work fine, and may also lead to better object
code if the compiler can avoid repeated assignments of the same
values, e.g. ".file = __FILE__".

          Arnd
