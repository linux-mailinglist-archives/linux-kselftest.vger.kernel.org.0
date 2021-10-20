Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44BD435671
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 01:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhJTXYm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 19:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhJTXYl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 19:24:41 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D89C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 16:22:26 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id j3so6106072ilr.6
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 16:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WutBa9WFAX4tc3k0wjtFSo8EbR3mrDBc6qpprgC2Kuc=;
        b=AZw2K34xtdcLXaJk8DEaQMf+B/MWbDi+mIQUKb3VFWgcx6UysmY4isNNa20tv8qsXV
         btg8vt2RWb5kn6wOVyn9DFxhH6bca3vsTXZHCXPKZCzKOLAGpLTWkS32KKC6LljyoV4Q
         LjMH2v2qsml/7Gi7wVpx8+0CF6nRKMTn19Qdj++hM2Z2QhpMibJsAz8FmZ3smG0HkGu8
         HeqDr3BnWB9TTIIatgDIUzuwRGN+9exoBtrS1kvF1n8OR4pk4a3+meHOnjKAFr5snDON
         Ij75zrRcAsgDd0cK4grmX++Xb7TrN4iKqQxR2CD0kdrkLZIPKoMcUSjmEgRKW6ztfUQO
         eBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WutBa9WFAX4tc3k0wjtFSo8EbR3mrDBc6qpprgC2Kuc=;
        b=IM9nFJ9XP3AiotpXCrwVpMeIKm6lQo5/UwFl1pnZZuh5v8EO8xSrIsTazDvXfH9Wqx
         U1BnSpsuN12gchXMxOkTfTX967vZ69R3t0P6jDFOUT3SAeVRZTTp0VsOCNBB4FNyqge9
         ZZYbCumutPJONlu3S/+Dh5V7wHqg99KZlQ6yIb7C/co5ZxSLjBHvAwOHT4SEkT54Qt4u
         9c5vl8cWic4/7seG+1K0a1u9s8jGHtQD0JX6EVrWSkIM4zzGdf4xuL4qUBdwTYQQaxQY
         jO/GcrDlbVcYNa3+ROKXQejSq2FR8fxwdrYgu+heU8RTW7srhfLk/iE3//Giu493c0+J
         c8bw==
X-Gm-Message-State: AOAM530EOtbD1geAeodsuw6Jc4MUlvHsp9rJDAHIq9qJqdvAu7EdI6RZ
        u0hJhkiCgcvA8cUh5iCNey0Uwbpxy+nNYNOzIBi6CQ==
X-Google-Smtp-Source: ABdhPJzn+r9oS73a+on5j+d33ZoWl209dzm3wLULt9aGSr5cGiUaC0EAJYCgTqQAG+dalFw/lOd6JrqVqZF3NlZ88e8=
X-Received: by 2002:a05:6e02:164d:: with SMTP id v13mr1301693ilu.10.1634772145515;
 Wed, 20 Oct 2021 16:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211008210752.1109785-1-dlatypov@google.com> <CAGS_qxp0iF+7FLbgVyBHXONN8kKjcAr7B+q=kgF1c71pbgybPQ@mail.gmail.com>
 <CAGS_qxq21Zce-y_DSP2t4Ws98OFLYmbSmrn0O3G5jZ-=DJv0Kg@mail.gmail.com>
In-Reply-To: <CAGS_qxq21Zce-y_DSP2t4Ws98OFLYmbSmrn0O3G5jZ-=DJv0Kg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 20 Oct 2021 16:22:13 -0700
Message-ID: <CAGS_qxrk4JmLp230ArK9f=vCkO45jBxEhk2-NRZGizw5-ArPaQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: continue past invalid utf-8 output
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 13, 2021 at 9:51 AM Daniel Latypov <dlatypov@google.com> wrote:
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

I've sent out a v2 with this:
https://lore.kernel.org/linux-kselftest/20211020232121.1748376-1-dlatypov@google.com

>
> >
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
