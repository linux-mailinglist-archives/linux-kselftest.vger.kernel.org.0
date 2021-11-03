Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EA5443B6E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 03:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhKCClP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Nov 2021 22:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhKCClO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Nov 2021 22:41:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA186C061203
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Nov 2021 19:38:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so758931wmd.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Nov 2021 19:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aoES21mxO+BOpJ7aTYDTf55urvPoHFLyauMLbJwagys=;
        b=ECjZR0MhaGyRFQMl2ayqi9WNq8eiXCQn6OpKvOXhpa08WZCUIkIZ/a/S4m4sNCCMeZ
         g9z7EB95ToAgEWz0qWPT5Jfr8esIDLisciilU1hAopC0R14jGZVn5IkYP4VPuN7LH+0r
         H4C03cpibOhauh/4gjNYKnr7S++rw+5fIhMPK4X61tScXXei3c0C83aFugog+mSnF8tU
         BWuxbSV7KODvAv0FRL5oNMh/M9mgC23DFRgj2KdZaIB4vgRzHryP8WgGfeOv3MqVbi7H
         YBS+2+lj3a3VeivZ72LZ1WMVzRSq/thIeR4iEIKuG40I6LELSliLTRsZYqGX4UkElgrn
         disw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoES21mxO+BOpJ7aTYDTf55urvPoHFLyauMLbJwagys=;
        b=JeR6j6JHW0MHLNDzWyp4os9XBQ1gZIfl9k686X5sFXRrNVbVyLpvmEQ0gUUOdCahmA
         N0gzDuQNyJHuP/ZfIxEHEyY56pX/PMzX1lxcaDGQxeubpw7PhniEIy+UC9i8xlbpLPvv
         vw1LnxUPP8DuCTSoszieO5jM4TFY8TSaML1iDs2h1HDC+f+17qfTJ3DDzbRl2TvUGbIz
         qEQVSJ15N3L+tEVG7NNozyMsHnWy4Oyn/f99qyiPAqpSQUip8zJwvqDE5a1VJsdTHADv
         BdPhEIpmfZ4smPqq/ja+T86M3aHEmxqaYemw0Hcv0zCVwuCJrccriLkHEIe+kBGqSp3g
         ugPw==
X-Gm-Message-State: AOAM533MIeIQyvBqC8gLmp49GsKPnXg8QhFsGfys5FMGFTSndk9B+laI
        9HL2MoCzcmqum5ZTKNHUxTKPSr0QngZERD7YdsSPZQ==
X-Google-Smtp-Source: ABdhPJxgCrHXirHY7GDGQkTD/Me0GMkrZqEPOQ8BI6i/kiC+iZv3pERm5IzZCD26KYn71STw/D1cee7RognwoAFjvc8=
X-Received: by 2002:a05:600c:253:: with SMTP id 19mr11627703wmj.179.1635907117141;
 Tue, 02 Nov 2021 19:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211102235734.497713-1-dlatypov@google.com>
In-Reply-To: <20211102235734.497713-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 3 Nov 2021 10:38:25 +0800
Message-ID: <CABVgOSkGjL4J3jRfpSLkz70=HUccwRXmF-1mLdD-7FRWv+rNCQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: add run_checks.py script to validate kunit changes
To:     Daniel Latypov <dlatypov@google.com>
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

On Wed, Nov 3, 2021 at 7:57 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> This formalizes the checks KUnit maintainers have been running (or in
> other cases: forgetting to run).

Guilty as charged. :-)
>
> This script also runs them all in parallel to minimize friction (pytype
> can be fairly slow, but not slower than running kunit.py).
>
> Example output:
> $ ./tools/testing/kunit/run_checks.py
> Waiting on 4 checks (kunit_tool_test.py, kunit smoke test, pytype, mypy)...
> kunit_tool_test.py: PASSED
> mypy: PASSED
> pytype: PASSED
> kunit smoke test: PASSED
>
> On failure or timeout (5 minutes), it'll dump out the stdout/stderr.
> E.g. adding in a type-checking error:
>   mypy: FAILED
>   > kunit.py:54: error: Name 'nonexistent_function' is not defined
>   > Found 1 error in 1 file (checked 8 source files)
>
> mypy and pytype are two Python type-checkers and must be installed.
> This file treats them as optional and will mark them as SKIPPED if not
> installed.
>
> This tool also runs `kunit.py run --kunitconfig=lib/kunit` to run
> KUnit's own KUnit tests and to verify KUnit kernel code and kunit.py
> play nicely together.
>
> It uses --build_dir=kunit_run_checks so as not to clobber the default
> build_dir, which helps make it faster by reducing the need to rebuild,
> esp. if you're been passing in --arch instead of using UML.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks -- this is working well here. A couple of minor suggestions
below, but even without them, this is very useful.

Reviewed-by: David Gow <davidgow@google.com>

>  tools/testing/kunit/run_checks.py | 76 +++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100755 tools/testing/kunit/run_checks.py
>
> diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
> new file mode 100755
> index 000000000000..d03ca3f84b91
> --- /dev/null
> +++ b/tools/testing/kunit/run_checks.py
> @@ -0,0 +1,76 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# This file runs some basic checks to verify kunit works.
> +# It is only of interest if you're making changes to KUnit itself.
> +#
> +# Copyright (C) 2021, Google LLC.
> +# Author: Daniel Latypov <dlatypov@google.com.com>
> +
> +from concurrent import futures
> +import datetime
> +import os
> +import shutil
> +import subprocess
> +import sys
> +import textwrap
> +from typing import Dict, List, Sequence, Tuple
> +
> +ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
> +_TIMEOUT = datetime.timedelta(minutes=5).total_seconds()
> +
> +commands: Dict[str, Sequence[str]] = {
> +       'kunit_tool_test.py': ['./kunit_tool_test.py'],
> +       'kunit smoke test': ['./kunit.py', 'run', '--kunitconfig=lib/kunit', '--build_dir=kunit_run_checks'],
> +       'pytype': ['/bin/sh', '-c', 'pytype *.py'],
> +       'mypy': ['/bin/sh', '-c', 'mypy *.py'],
> +}
> +
> +# The user might not have mypy or pytype installed, skip them if so.
> +# Note: you can install both via `$ pip install mypy pytype`
> +necessary_deps : Dict[str, str] = {
> +       'pytype': 'pytype',
> +       'mypy': 'mypy',
> +}
> +
> +def main(argv: Sequence[str]) -> None:
> +       if len(argv) > 1:
> +               raise RuntimeError('Too many command-line arguments.')

What does the command-line argument here actually do? It looks like
nothing, because the argv variable is shadowed below?

Or was this supposed to check that there are no arguments, which
doesn't work because argv[] is stripped of its first element in the
'if __name__=='__main__'?

> +
> +       future_to_name: Dict[futures.Future, str] = {}
> +       executor = futures.ThreadPoolExecutor(max_workers=len(commands))
> +       for name, argv in commands.items():
> +               if name in necessary_deps and shutil.which(necessary_deps[name]) is None:
> +                       print(f'{name}: SKIPPED, {necessary_deps[name]} not in $PATH')
> +                       continue
> +               f = executor.submit(run_cmd, argv)
> +               future_to_name[f] = name
> +
> +       print(f'Waiting on {len(future_to_name)} checks ({", ".join(future_to_name.values())})...')
> +       for f in  futures.as_completed(future_to_name.keys()):
> +               name = future_to_name[f]
> +               ex = f.exception()
> +               if not ex:
> +                       print(f'{name}: PASSED')
> +                       continue
> +
> +               if isinstance(ex, subprocess.TimeoutExpired):
> +                       print(f'{name}: TIMED OUT')
> +               elif isinstance(ex, subprocess.CalledProcessError):
> +                       print(f'{name}: FAILED')
> +               else:
> +                       print('{name}: unexpected exception: {ex}')
> +                       continue
> +
> +               output = ex.output
> +               if output:
> +                       print(textwrap.indent(output.decode(), '> '))
> +       executor.shutdown()
> +
> +
> +def run_cmd(argv: Sequence[str]):
> +       subprocess.check_output(argv, stderr=subprocess.STDOUT, cwd=ABS_TOOL_PATH, timeout=_TIMEOUT)
> +
> +
> +if __name__ == '__main__':
> +       main(sys.argv[1:])

Any chance we could get this to return a non-zero exit code if one of
these checks fails?

>
> base-commit: 52a5d80a2225e2d0b2a8f4656b76aead2a443b2a
> --
> 2.33.1.1089.g2158813163f-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20211102235734.497713-1-dlatypov%40google.com.
