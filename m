Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793AA494976
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jan 2022 09:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359227AbiATI3w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jan 2022 03:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359207AbiATI3r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jan 2022 03:29:47 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C071C06173F
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 00:29:46 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso18610082wma.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 00:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRg1Hi7fshLwZOXJunSDXWp8Mi+a04TIBKVjfzILXqc=;
        b=M6g6UzMtANcIE6R4pMS/wZvbQfFH0RkIxyOzQqhAI5EN/IntkdglHlmWBK62vPP7id
         vmQbKOeMQsm6tAmbtdp9N9+5FB1ESJ1eFJZrmZqngpPN2G7CzWA7v8wJm4WciJotfe9f
         3C6m2J0VKRBONU6jHsG4xee3adDuJMIRxucBHV9tylitRlr2WiO25ICuIIvHEUSwid3a
         3jHTR3fvwAWYe4QCOhzzgztvTzOutWRX7vsbG6dj3dyhFhxOoFhHX2lzLr5M6eyHMg9d
         1OahmGnGpJVPOS+VoO1jlj52rq+crn4c1xr6XEgJP1ohOuQKkqVq+1cwLN4BwHh5FH1H
         F3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRg1Hi7fshLwZOXJunSDXWp8Mi+a04TIBKVjfzILXqc=;
        b=Vwgr2l+mPS4qic81xqI5du28PtpIQrapMeXy2FaeAKO1bgEunWmHpsgU4B4lzRh/28
         SFTRIYoTfupgTjiUg5AUfLA9lq7PHY0yxal9DSRijtlhHWSDL/i7H/3q4aq4iaCys7F9
         QZbbpP5EUQRIHtQYtjaICYsQyccvAx5CMGQNpNvpASgw0j10UQIs52YnCPEIOJC+Nk80
         LBNln46h4fT8HwtUaE7uBUjMgp8wVkkaLKdaLZGDzp2LmGdcWS9ItBlPKcPEtpSi2KpY
         heU4CKW5a78FWlDdMXgAY0bm/CWtJjAmZkl9lOLRmZ4y4itAweIDCdp8FKrtZwWRUoQS
         g3kQ==
X-Gm-Message-State: AOAM533wZCMFcav+AGuTa/J+Nr8HzleHkOYPs6ASwF8pXQ7g58eLktfI
        f4VnyeABgPqiuOFmFcXgCOb4I/VdAagUpJ0AEb+QeQ==
X-Google-Smtp-Source: ABdhPJy/5kiTt1Crf4M9DcuwFpzxOJ8PMTolsMnrwikR8TJcWxjZaNhtDsqGR85pW/LSE9SUMdrZANpkXmv8ZOQ5FGI=
X-Received: by 2002:a5d:6e8a:: with SMTP id k10mr33643975wrz.113.1642667384748;
 Thu, 20 Jan 2022 00:29:44 -0800 (PST)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com>
In-Reply-To: <20220118190922.1557074-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 20 Jan 2022 16:29:33 +0800
Message-ID: <CABVgOSnY8Ctc9vuVX+Fjmmd3L5kpXnzMXJQ0LPXAgmjCKsrYYw@mail.gmail.com>
Subject: Re: [PATCH 1/5] kunit: tool: drop mostly unused KunitResult.result field
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

On Wed, Jan 19, 2022 at 3:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This field is only used to pass along the parsed Test object from
> parse_tests().
> Everywhere else the `result` field is ignored.
>
> Instead make parse_tests() explicitly return a KunitResult and Test so
> we can retire the `result` field.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I personally prefer having the Test as part of the result -- it gives
a slightly rust-esque sense of needing to check the actual result
before using anything that's parsed. (Also, I'm still not used to the
whole multiple return value thing, which is not as clear as an
explicit named struct member, IMHO).
That being said, we're not actually checking the result before using
the Test, and certainly the use of Any and mashing a textual error
message in the same field is rather unpleasant.

My ideal solution would be to rename 'result' to something more
sensible ('parsed_test', maybe?), and make it explicitly a Test rather
than Any (and either add a separate field for the textual error
message, or remove it as in this patch, having noticed that it's
almost completely redundant to the enum).

That being said, I can live with the current solution, but'd ideally
like a comment or something to make the return value Tuple a bit more
obvious.

Thoughts?


-- David

>  tools/testing/kunit/kunit.py | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 7a706f96f68d..9274c6355809 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -17,7 +17,7 @@ assert sys.version_info >= (3, 7), "Python version is too old"
>
>  from dataclasses import dataclass
>  from enum import Enum, auto
> -from typing import Any, Iterable, Sequence, List, Optional
> +from typing import Iterable, List, Optional, Sequence, Tuple
>
>  import kunit_json
>  import kunit_kernel
> @@ -32,7 +32,6 @@ class KunitStatus(Enum):
>  @dataclass
>  class KunitResult:
>         status: KunitStatus
> -       result: Any
>         elapsed_time: float
>
>  @dataclass
> @@ -82,10 +81,8 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
>         config_end = time.time()
>         if not success:
>                 return KunitResult(KunitStatus.CONFIG_FAILURE,
> -                                  'could not configure kernel',
>                                    config_end - config_start)
>         return KunitResult(KunitStatus.SUCCESS,
> -                          'configured kernel successfully',
>                            config_end - config_start)
>
>  def build_tests(linux: kunit_kernel.LinuxSourceTree,
> @@ -100,14 +97,11 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
>         build_end = time.time()
>         if not success:
>                 return KunitResult(KunitStatus.BUILD_FAILURE,
> -                                  'could not build kernel',
>                                    build_end - build_start)
>         if not success:
>                 return KunitResult(KunitStatus.BUILD_FAILURE,
> -                                  'could not build kernel',
>                                    build_end - build_start)
>         return KunitResult(KunitStatus.SUCCESS,
> -                          'built kernel successfully',
>                            build_end - build_start)
>
>  def config_and_build_tests(linux: kunit_kernel.LinuxSourceTree,
> @@ -173,14 +167,14 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
>                         filter_glob=filter_glob,
>                         build_dir=request.build_dir)
>
> -               result = parse_tests(request, run_result)
> +               _, test_result = parse_tests(request, run_result)
>                 # run_kernel() doesn't block on the kernel exiting.
>                 # That only happens after we get the last line of output from `run_result`.
>                 # So exec_time here actually contains parsing + execution time, which is fine.
>                 test_end = time.time()
>                 exec_time += test_end - test_start
>
> -               test_counts.add_subtest_counts(result.result.counts)
> +               test_counts.add_subtest_counts(test_result.counts)
>
>         if len(filter_globs) == 1 and test_counts.crashed > 0:
>                 bd = request.build_dir
> @@ -189,7 +183,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
>                                 bd, bd, kunit_kernel.get_outfile_path(bd), bd, sys.argv[0]))
>
>         kunit_status = _map_to_overall_status(test_counts.get_status())
> -       return KunitResult(status=kunit_status, result=result, elapsed_time=exec_time)
> +       return KunitResult(status=kunit_status, elapsed_time=exec_time)
>
>  def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
>         if test_status in (kunit_parser.TestStatus.SUCCESS, kunit_parser.TestStatus.SKIPPED):
> @@ -197,7 +191,7 @@ def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
>         else:
>                 return KunitStatus.TEST_FAILURE
>
> -def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitResult:
> +def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> Tuple[KunitResult, kunit_parser.Test]:
>         parse_start = time.time()
>
>         test_result = kunit_parser.Test()
> @@ -231,11 +225,9 @@ def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitR
>                         print(json_obj)
>
>         if test_result.status != kunit_parser.TestStatus.SUCCESS:
> -               return KunitResult(KunitStatus.TEST_FAILURE, test_result,
> -                                  parse_end - parse_start)
> +               return KunitResult(KunitStatus.TEST_FAILURE, parse_end - parse_start), test_result
>
> -       return KunitResult(KunitStatus.SUCCESS, test_result,
> -                               parse_end - parse_start)
> +       return KunitResult(KunitStatus.SUCCESS, parse_end - parse_start), test_result
>
>  def run_tests(linux: kunit_kernel.LinuxSourceTree,
>               request: KunitRequest) -> KunitResult:
> @@ -513,7 +505,7 @@ def main(argv, linux=None):
>                 request = KunitParseRequest(raw_output=cli_args.raw_output,
>                                             build_dir='',
>                                             json=cli_args.json)
> -               result = parse_tests(request, kunit_output)
> +               result, _ = parse_tests(request, kunit_output)
>                 if result.status != KunitStatus.SUCCESS:
>                         sys.exit(1)
>         else:
>
> base-commit: f079ab01b5609fb0c9acc52c88168bf1eed82373
> --
> 2.34.1.703.g22d0c6ccf7-goog
>
