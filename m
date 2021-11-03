Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA2C443C31
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 05:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhKCEZd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 00:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhKCEZc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 00:25:32 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290ACC061714
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Nov 2021 21:22:57 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id j28so1298625ila.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Nov 2021 21:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LfIitrTzG0kYGsQee7qOvaKUSlyn9qPrdsWicpb/74w=;
        b=LaxHe2hn2iX29Ok/7dcXW8VtvH55k9KXnNHK4Q9POaUvWc35gdF93D630mLLn4QPr9
         PqZmGFYCsY0KM4WTd0qBC24OQXr1uk8jYzgq3Yn1D9cEA1ClkqyxwvrF1QJQ0/29g0Za
         o9jblQAoPW2z0MQSCGV3qTP09aaD5IU+58XsIV4c514qagetBzvOx6rQ5V0e7fC89y+G
         +3QIX7oBhM9C+aVRBGI/k/rnWx1KMd1Fnq0lDzH6LYYcjzQ8ZOfCjczzDEKQE1m4QUHJ
         P7qo+rwvV3kj0/EA+KwDBD80VCLde5X9VNMS19XtziFNEIFKNpwJ8XW9v3wnnbWBV81D
         rbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfIitrTzG0kYGsQee7qOvaKUSlyn9qPrdsWicpb/74w=;
        b=pqdOmdQUotwoMM6RF1in+JaxLNvW3MAMSQ3XsFfRDfY/C8pkn4fxfAYlOl/CP7R0e5
         NZTp6KrfGMCaLMKl+T+WlQx7Wc18/9+FTzxbCHTLNP9/3oQZRW09+h++jRE9J0AwfFsV
         Jivj3fbdtmGomqvpu25IUdyErnC7/in9zCtyPsiNDWSA/HUa9GnTS7A/WT4FaFqfcK0f
         cuhAngRS1gCyNN4yHrkFcbqhUP6vfmQy0Do/uBPx1ACTXUokmauhP9oqgFwTQJFIPuXl
         WS4qbW5YkmSibLWeyT2aPaafWa5m0Uv61R+Aw4cEBIsFymrIezzlb1ROjt6qRohsjQ6x
         lsQQ==
X-Gm-Message-State: AOAM531SAg+UTyOneVP9Qbre/pAKFRp01xFHezzrXQkdLLPwYk7BHxoH
        iBsP8ytRLxbdx5PRJKu031qtOnkLCGI/JXQVaOZfMQ==
X-Google-Smtp-Source: ABdhPJxxyIO5gE/FW7Ccb1rQQNTV3IlPS83BGOiY6YaUktKB6S8qVl7FS3C9ZC9Su3t5gctCYvy/iyePByi5ThQXDg4=
X-Received: by 2002:a92:de4d:: with SMTP id e13mr24089537ilr.283.1635913376421;
 Tue, 02 Nov 2021 21:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211102235734.497713-1-dlatypov@google.com> <CABVgOSkGjL4J3jRfpSLkz70=HUccwRXmF-1mLdD-7FRWv+rNCQ@mail.gmail.com>
In-Reply-To: <CABVgOSkGjL4J3jRfpSLkz70=HUccwRXmF-1mLdD-7FRWv+rNCQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 2 Nov 2021 21:22:45 -0700
Message-ID: <CAGS_qxpXLqrJWnb5N+2R5MRk2ZPxau+6NNB4BjVpViXoeQThgg@mail.gmail.com>
Subject: Re: [PATCH] kunit: add run_checks.py script to validate kunit changes
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 2, 2021 at 7:38 PM David Gow <davidgow@google.com> wrote:
>
> On Wed, Nov 3, 2021 at 7:57 AM 'Daniel Latypov' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > This formalizes the checks KUnit maintainers have been running (or in
> > other cases: forgetting to run).
>
> Guilty as charged. :-)

I was largely referring to myself :)

> >
> > This script also runs them all in parallel to minimize friction (pytype
> > can be fairly slow, but not slower than running kunit.py).
> >
> > Example output:
> > $ ./tools/testing/kunit/run_checks.py
> > Waiting on 4 checks (kunit_tool_test.py, kunit smoke test, pytype, mypy)...
> > kunit_tool_test.py: PASSED
> > mypy: PASSED
> > pytype: PASSED
> > kunit smoke test: PASSED
> >
> > On failure or timeout (5 minutes), it'll dump out the stdout/stderr.
> > E.g. adding in a type-checking error:
> >   mypy: FAILED
> >   > kunit.py:54: error: Name 'nonexistent_function' is not defined
> >   > Found 1 error in 1 file (checked 8 source files)
> >
> > mypy and pytype are two Python type-checkers and must be installed.
> > This file treats them as optional and will mark them as SKIPPED if not
> > installed.
> >
> > This tool also runs `kunit.py run --kunitconfig=lib/kunit` to run
> > KUnit's own KUnit tests and to verify KUnit kernel code and kunit.py
> > play nicely together.
> >
> > It uses --build_dir=kunit_run_checks so as not to clobber the default
> > build_dir, which helps make it faster by reducing the need to rebuild,
> > esp. if you're been passing in --arch instead of using UML.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Thanks -- this is working well here. A couple of minor suggestions
> below, but even without them, this is very useful.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> >  tools/testing/kunit/run_checks.py | 76 +++++++++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100755 tools/testing/kunit/run_checks.py
> >
> > diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
> > new file mode 100755
> > index 000000000000..d03ca3f84b91
> > --- /dev/null
> > +++ b/tools/testing/kunit/run_checks.py
> > @@ -0,0 +1,76 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# This file runs some basic checks to verify kunit works.
> > +# It is only of interest if you're making changes to KUnit itself.
> > +#
> > +# Copyright (C) 2021, Google LLC.
> > +# Author: Daniel Latypov <dlatypov@google.com.com>
> > +
> > +from concurrent import futures
> > +import datetime
> > +import os
> > +import shutil
> > +import subprocess
> > +import sys
> > +import textwrap
> > +from typing import Dict, List, Sequence, Tuple
> > +
> > +ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
> > +_TIMEOUT = datetime.timedelta(minutes=5).total_seconds()
> > +
> > +commands: Dict[str, Sequence[str]] = {
> > +       'kunit_tool_test.py': ['./kunit_tool_test.py'],
> > +       'kunit smoke test': ['./kunit.py', 'run', '--kunitconfig=lib/kunit', '--build_dir=kunit_run_checks'],
> > +       'pytype': ['/bin/sh', '-c', 'pytype *.py'],
> > +       'mypy': ['/bin/sh', '-c', 'mypy *.py'],
> > +}
> > +
> > +# The user might not have mypy or pytype installed, skip them if so.
> > +# Note: you can install both via `$ pip install mypy pytype`
> > +necessary_deps : Dict[str, str] = {
> > +       'pytype': 'pytype',
> > +       'mypy': 'mypy',
> > +}
> > +
> > +def main(argv: Sequence[str]) -> None:
> > +       if len(argv) > 1:
> > +               raise RuntimeError('Too many command-line arguments.')
>
> What does the command-line argument here actually do? It looks like
> nothing, because the argv variable is shadowed below?
>
> Or was this supposed to check that there are no arguments, which
> doesn't work because argv[] is stripped of its first element in the
> 'if __name__=='__main__'?

It was supposed to check for no args.
I forgot I already stripped it off (this bit of code here was
autogenerated for me by a snippet).

>
> > +
> > +       future_to_name: Dict[futures.Future, str] = {}
> > +       executor = futures.ThreadPoolExecutor(max_workers=len(commands))
> > +       for name, argv in commands.items():
> > +               if name in necessary_deps and shutil.which(necessary_deps[name]) is None:
> > +                       print(f'{name}: SKIPPED, {necessary_deps[name]} not in $PATH')
> > +                       continue
> > +               f = executor.submit(run_cmd, argv)
> > +               future_to_name[f] = name
> > +
> > +       print(f'Waiting on {len(future_to_name)} checks ({", ".join(future_to_name.values())})...')
> > +       for f in  futures.as_completed(future_to_name.keys()):
> > +               name = future_to_name[f]
> > +               ex = f.exception()
> > +               if not ex:
> > +                       print(f'{name}: PASSED')
> > +                       continue
> > +
> > +               if isinstance(ex, subprocess.TimeoutExpired):
> > +                       print(f'{name}: TIMED OUT')
> > +               elif isinstance(ex, subprocess.CalledProcessError):
> > +                       print(f'{name}: FAILED')
> > +               else:
> > +                       print('{name}: unexpected exception: {ex}')
> > +                       continue
> > +
> > +               output = ex.output
> > +               if output:
> > +                       print(textwrap.indent(output.decode(), '> '))
> > +       executor.shutdown()
> > +
> > +
> > +def run_cmd(argv: Sequence[str]):
> > +       subprocess.check_output(argv, stderr=subprocess.STDOUT, cwd=ABS_TOOL_PATH, timeout=_TIMEOUT)
> > +
> > +
> > +if __name__ == '__main__':
> > +       main(sys.argv[1:])
>
> Any chance we could get this to return a non-zero exit code if one of
> these checks fails?

Oh, I thought I did this before sending it out.
Will add this in for v2.

>
> >
> > base-commit: 52a5d80a2225e2d0b2a8f4656b76aead2a443b2a
> > --
> > 2.33.1.1089.g2158813163f-goog
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20211102235734.497713-1-dlatypov%40google.com.
