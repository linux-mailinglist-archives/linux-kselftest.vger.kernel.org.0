Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68A42C6C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 18:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhJMQyP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 12:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhJMQyL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 12:54:11 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEA2C061749
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Oct 2021 09:52:08 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id j8so379421ila.11
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Oct 2021 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOJ5c26GcDkFy/5jnHqq9oUC7WBrX7rXHxf39J9YV6g=;
        b=TeYhoeERypD/RHvk+nJDlPeSqLwCWWcKYh1HJWg5YxueD+6xegPODVw6KGvYWcPLKi
         ANCuWFQi9mSUKkFbdNgp1OQYXnwALsjnH94TaKDBG/ctbWkr4Lu21U27zQTwbzrVbXJm
         REyU4ovmRfJGdLkeRVyCaLw3elowmYBrfi3Ith1dAPYvH46jx+1nS4wHb/3nNURu1EOp
         ZAhsxUlYk7qyDAMEQbUfZ2xUBcHi+vn55O8om+40cubhUQ3KuNlUYyhtrDeChPhrOLBy
         XMt9Xo5Em8ATNNlfSj1pmTKkZ0GcOM/Nm0Zbr9bS1ubkFIDaSjkMA2DG+3j/ICoGfyYp
         8CbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOJ5c26GcDkFy/5jnHqq9oUC7WBrX7rXHxf39J9YV6g=;
        b=BknHRafHWkkJ4aevF/s2yHwjh5HBIVpQrAAezRiu0XRhPjGAIhRjP7TRDt1EbBemsS
         cYn5/FiWXMtqJo3LMIOSD1UPjQ+e2ZqHpQzsuc/lzLi9MrGPV2Ityyx7TlrKj6HXFzuB
         /1G/MHI2Pem1sENUL8AU5i1Kto9Z4SHp+WigwJrSMjaze+G8VLY9b/wBzeHdRUfoyLVc
         ymllWP5vc7qEOjOrEk/54XbrXPiE9V1dH7JJrhjTP8KcCd/KNFwfN4c1nMdJtq4FlhPp
         wTTB7sTd8Vy2LAWRnAM7OE1nr2oOlTryUgx4eZ8a19rCYlMHE9DptN75vSNAN06zTN4j
         +XFQ==
X-Gm-Message-State: AOAM532vkaypdo4GGyH+xIw4jvISJ6ndEcfxKQmMtoGUm6FsEZoEx/q7
        pTfWX4AcOFKiY2H/8NEvUENioQYuKSEBMKT9Jo4toA==
X-Google-Smtp-Source: ABdhPJwsB3j511GxijFC797iF4RdxNaJm0W+0+Mi0Ez3GM+MbFguw2RjxWbPfg05oJR1XG62aMDekRConSfnojZpECg=
X-Received: by 2002:a05:6e02:1846:: with SMTP id b6mr111937ilv.63.1634143927586;
 Wed, 13 Oct 2021 09:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211008210752.1109785-1-dlatypov@google.com> <CAGS_qxp0iF+7FLbgVyBHXONN8kKjcAr7B+q=kgF1c71pbgybPQ@mail.gmail.com>
In-Reply-To: <CAGS_qxp0iF+7FLbgVyBHXONN8kKjcAr7B+q=kgF1c71pbgybPQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 13 Oct 2021 09:51:56 -0700
Message-ID: <CAGS_qxq21Zce-y_DSP2t4Ws98OFLYmbSmrn0O3G5jZ-=DJv0Kg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: continue past invalid utf-8 output
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 8, 2021 at 4:51 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Fri, Oct 8, 2021 at 2:08 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > kunit.py currently crashes and fails to parse kernel output if it's not
> > fully valid utf-8.
> >
> > This can come from memory corruption or or just inadvertently printing
> > out binary data as strings.
> >
> > E.g. adding this line into a kunit test
> >   pr_info("\x80")
> > will cause this exception
> >   UnicodeDecodeError: 'utf-8' codec can't decode byte 0x80 in position 1961: invalid start byte
> >
> > We can tell Python how to handle errors, see
> > https://docs.python.org/3/library/codecs.html#error-handlers
> >
> > Unfortunately, it doesn't seem like there's a way to specify this in
> > just one location, so we need to repeat ourselves quite a bit.
> >
> > Specify `errors='backslashreplace'` so we instead:
> > * print out the offending byte as '\x80'
> > * try and continue parsing the output.
> >   * as long as the TAP lines themselves are valid, we're fine.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
> >  tools/testing/kunit/kunit.py        | 3 ++-
> >  tools/testing/kunit/kunit_kernel.py | 4 ++--
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > index 9c9ed4071e9e..28ae096d4b53 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -457,9 +457,10 @@ def main(argv, linux=None):
> >                         sys.exit(1)
> >         elif cli_args.subcommand == 'parse':
> >                 if cli_args.file == None:
> > +                       sys.stdin.reconfigure(errors='backslashreplace')
>
> Ugh, pytype doesn't like this even though it's valid.
> I can squash the error with
>   sys.stdin.reconfigure(errors='backslashreplace')  # pytype:
> disable=attribute-error
>
> I had wanted us to avoid having anything specific to pytype in the code.
> But mypy (the more common typechecker iirc) hasn't been smart enough
> to typecheck our code since the QEMU support landed.
>
> If we don't add this directive, both typecheckers will report at least
> one spurious warning.
> Should I go ahead and add it, Brendan/David?

Friendly ping.
Should we go ahead and add "# pytype: disable=attribute-error" here?

>
> >                         kunit_output = sys.stdin
> >                 else:
> > -                       with open(cli_args.file, 'r') as f:
> > +                       with open(cli_args.file, 'r', errors='backslashreplace') as f:
> >                                 kunit_output = f.read().splitlines()
> >                 request = KunitParseRequest(cli_args.raw_output,
> >                                             None,
> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > index faa6320e900e..f08c6c36a947 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -135,7 +135,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
> >                                            stdin=subprocess.PIPE,
> >                                            stdout=subprocess.PIPE,
> >                                            stderr=subprocess.STDOUT,
> > -                                          text=True, shell=True)
> > +                                          text=True, shell=True, errors='backslashreplace')
> >
> >  class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
> >         """An abstraction over command line operations performed on a source tree."""
> > @@ -172,7 +172,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
> >                                            stdin=subprocess.PIPE,
> >                                            stdout=subprocess.PIPE,
> >                                            stderr=subprocess.STDOUT,
> > -                                          text=True)
> > +                                          text=True, errors='backslashreplace')
> >
> >  def get_kconfig_path(build_dir) -> str:
> >         return get_file_path(build_dir, KCONFIG_PATH)
> >
> > base-commit: a032094fc1ed17070df01de4a7883da7bb8d5741
> > --
> > 2.33.0.882.g93a45727a2-goog
> >
