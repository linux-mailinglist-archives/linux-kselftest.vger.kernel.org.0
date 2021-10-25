Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E62043A5DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 23:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhJYVbn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 17:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhJYVbn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 17:31:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874D6C061745
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 14:29:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v1-20020a17090a088100b001a21156830bso470539pjc.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2CDSyP0BPE42EK8zWKX+zWHNEpFqbF5USxlRD9PCWs=;
        b=aE8sHvgAznCPxZiRrxaiqLdB4a8mvafjpp55X8LuRzIeS89UeiMfZIVT9vuStJEfza
         aWqg1qG0hpFTbkQW0GPVbcjftvGzc5Olc/kH43YzK64y2+WHLo6KRtneJ5PjlwRzDwCG
         aSzm1HRNLjVA6FcODu5GlEStHGjw9xFzJOJnGqv062z2K/zrSaymrbtx0kCRbPsQzcqy
         Y1+m2yljBCtnkfUYgiK6octTr4hZf2kb92X1DBjBPkeab0HqrQwfgEL0Y5AXi5jM1lMM
         TReApvgwMomYHiggIkctX9idMMuSMy8YZyc/aW71hphRfPqid21d0eJTqGnYbrAzTpcj
         XlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2CDSyP0BPE42EK8zWKX+zWHNEpFqbF5USxlRD9PCWs=;
        b=IE0VCcxHVObbn09k7SN4bjzuz4QgcyvpxAvL1t03zB/gL2OPm63xeDn8wH8rXTQnUg
         SHn5vu5SNxbcuqsqGHgub7rgK5mxzk4ZLMOPNXnra++bblJSV7qeUse5NlWoVEkcJjiJ
         mk+cJ/s88QtlIpN5BkIdzctsurr2Ii0l7xY3dSmuheLSIzHaavPzCR0kc4NQ3u0xQkSj
         XH10h5ofGCh0OLHK9Q6QUO/Vg/ewZadaYd0s9zEnMehkCUgX1pQytjrTyA5jA779IPMU
         fzUXsopobaHoF8k0QQtAuSHE4H60VtI6wV2T2dfHm59JnJp4B8fUhrhytfD8hvUkzi5b
         c7Gg==
X-Gm-Message-State: AOAM533KYMMphJY6HGTW14WngPw+IK7th5DX5WNiuqjjv6V/QagRtnJM
        0JrQI4bZnjkh5vx0lVQ9gEUJZNgdsRH41sjVO5HmGXZQ
X-Google-Smtp-Source: ABdhPJxY/JwuuwlfHnGSLCt8/PlKay+KkChBd7lWfE2Ogp57a9gyRVWVGU1478vUoVq22ufqE4lfLL4AAkLGfMbt8dc=
X-Received: by 2002:a17:90a:d311:: with SMTP id p17mr9053244pju.95.1635197359711;
 Mon, 25 Oct 2021 14:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211008210752.1109785-1-dlatypov@google.com> <CAGS_qxp0iF+7FLbgVyBHXONN8kKjcAr7B+q=kgF1c71pbgybPQ@mail.gmail.com>
 <CAGS_qxq21Zce-y_DSP2t4Ws98OFLYmbSmrn0O3G5jZ-=DJv0Kg@mail.gmail.com>
In-Reply-To: <CAGS_qxq21Zce-y_DSP2t4Ws98OFLYmbSmrn0O3G5jZ-=DJv0Kg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 25 Oct 2021 14:29:08 -0700
Message-ID: <CAFd5g454HgQduWLP_xUhVJW+UCgY+vCREG0PnD_ufFQmAG1Usw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: continue past invalid utf-8 output
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 13, 2021 at 9:52 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Fri, Oct 8, 2021 at 4:51 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Fri, Oct 8, 2021 at 2:08 PM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > kunit.py currently crashes and fails to parse kernel output if it's not
> > > fully valid utf-8.
> > >
> > > This can come from memory corruption or or just inadvertently printing
> > > out binary data as strings.
> > >
> > > E.g. adding this line into a kunit test
> > >   pr_info("\x80")
> > > will cause this exception
> > >   UnicodeDecodeError: 'utf-8' codec can't decode byte 0x80 in position 1961: invalid start byte
> > >
> > > We can tell Python how to handle errors, see
> > > https://docs.python.org/3/library/codecs.html#error-handlers
> > >
> > > Unfortunately, it doesn't seem like there's a way to specify this in
> > > just one location, so we need to repeat ourselves quite a bit.
> > >
> > > Specify `errors='backslashreplace'` so we instead:
> > > * print out the offending byte as '\x80'
> > > * try and continue parsing the output.
> > >   * as long as the TAP lines themselves are valid, we're fine.
> > >
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > ---
> > >  tools/testing/kunit/kunit.py        | 3 ++-
> > >  tools/testing/kunit/kunit_kernel.py | 4 ++--
> > >  2 files changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > > index 9c9ed4071e9e..28ae096d4b53 100755
> > > --- a/tools/testing/kunit/kunit.py
> > > +++ b/tools/testing/kunit/kunit.py
> > > @@ -457,9 +457,10 @@ def main(argv, linux=None):
> > >                         sys.exit(1)
> > >         elif cli_args.subcommand == 'parse':
> > >                 if cli_args.file == None:
> > > +                       sys.stdin.reconfigure(errors='backslashreplace')
> >
> > Ugh, pytype doesn't like this even though it's valid.
> > I can squash the error with
> >   sys.stdin.reconfigure(errors='backslashreplace')  # pytype:
> > disable=attribute-error
> >
> > I had wanted us to avoid having anything specific to pytype in the code.
> > But mypy (the more common typechecker iirc) hasn't been smart enough
> > to typecheck our code since the QEMU support landed.
> >
> > If we don't add this directive, both typecheckers will report at least
> > one spurious warning.
> > Should I go ahead and add it, Brendan/David?
>
> Friendly ping.
> Should we go ahead and add "# pytype: disable=attribute-error" here?

Sorry, missed this.

Yeah, I am fine with disabling the type checkers if they fail to
understand valid code.

> > >                         kunit_output = sys.stdin
> > >                 else:
> > > -                       with open(cli_args.file, 'r') as f:
> > > +                       with open(cli_args.file, 'r', errors='backslashreplace') as f:
> > >                                 kunit_output = f.read().splitlines()
> > >                 request = KunitParseRequest(cli_args.raw_output,
> > >                                             None,
> > > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > > index faa6320e900e..f08c6c36a947 100644
> > > --- a/tools/testing/kunit/kunit_kernel.py
> > > +++ b/tools/testing/kunit/kunit_kernel.py
> > > @@ -135,7 +135,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> > >                                            stdin=subprocess.PIPE,
> > >                                            stdout=subprocess.PIPE,
> > >                                            stderr=subprocess.STDOUT,
> > > -                                          text=True, shell=True)
> > > +                                          text=True, shell=True, errors='backslashreplace')
> > >
> > >  class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
> > >         """An abstraction over command line operations performed on a source tree."""
> > > @@ -172,7 +172,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
> > >                                            stdin=subprocess.PIPE,
> > >                                            stdout=subprocess.PIPE,
> > >                                            stderr=subprocess.STDOUT,
> > > -                                          text=True)
> > > +                                          text=True, errors='backslashreplace')
> > >
> > >  def get_kconfig_path(build_dir) -> str:
> > >         return get_file_path(build_dir, KCONFIG_PATH)
> > >
> > > base-commit: a032094fc1ed17070df01de4a7883da7bb8d5741
> > > --
> > > 2.33.0.882.g93a45727a2-goog
> > >
