Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EDB413770
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Sep 2021 18:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhIUQW3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Sep 2021 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhIUQWY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Sep 2021 12:22:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A7EC06124A
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Sep 2021 09:19:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w17so32791943wrv.10
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Sep 2021 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKVGrhptbQ2tPiSL11nU0NzuroCFSqGvZwC9U+FzQXo=;
        b=cnPF/ciB+iDSyvwxImERVYo6y1riM5QaBbXOBdYqlfMOBn5DmGuMeNMjPqpvQQxwd/
         Sl/cTDYIdhOAI8hvMLemRECUrCA4vYkmVS7GznZvY026VR1ny7iCWWXwPOAuLuJRBtA4
         LdrslU2N3CzM1oixg0AR5CvGCZ317KZUj7vBbauKP2HZLnY2JUqUkYpcR0WMjydZapDp
         GYbE9VZR1oYOKfXG6j4RUgzTP0708tHOl5zNRh/cHf0v45UJZSmZrvbYuqZV7yN0GuOd
         +269i8WMxbA1c7J373jf9HJlZYx1Q0vNzFIx5JvtoU1wbL7pwVVr5HLYDzH614iNqdLu
         VimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKVGrhptbQ2tPiSL11nU0NzuroCFSqGvZwC9U+FzQXo=;
        b=OoESCpLOWflPxVppuLDbicmxOYXAHUbCBbljlWYcDcSXVv9UW/nosdseFpYjFkiR40
         K3K/gyR67rnCOfIOL7383kQVSlLrBf9eoNIO/Fs/OGmTek0qZhkN0MlHJJxo6HxVPRsa
         w5fl7PmS10C+v+JJ0rTVxIWvUJIfhOl1M2Cn7qE+Ric2R2zbhAd0i9XHEAtKHEwDTq/P
         opwZJVNdJ9iCHQ9fZGAfIRB+N0jnzHFVtfybQHIAnP4j2HVo3mha611ivDz94XKOKboy
         averIYKkjHTjezZ/q4FzCzvwdfM8+SZ3wOuBzeOFZSxkVK0NrZqI2biJxZXZeLFr67rS
         jJhg==
X-Gm-Message-State: AOAM530yToEVL+kZ/jv22AcPbhx157Qu1JJJquwazlIAEIfgzG2uIwW/
        ts4UUq2h8W6OK8hGhsbTUjQO5ZD87YdxJE3EC3QffA==
X-Google-Smtp-Source: ABdhPJyyuA1e+uumxVvmaTLP0O0qfCPf138r+ak1Oej8DfIhZDRDI8CkWwglj8dr+zecAMd163VXykg5wFi3e1WUQwk=
X-Received: by 2002:a05:6000:124b:: with SMTP id j11mr36621327wrx.147.1632241164364;
 Tue, 21 Sep 2021 09:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210903161405.1861312-1-dlatypov@google.com>
In-Reply-To: <20210903161405.1861312-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 22 Sep 2021 00:19:12 +0800
Message-ID: <CABVgOSmJBpAcVOTxF1FZptUL4+bcLzBPieSDmfMVtkCuCQ6ouA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: better handling of quasi-bool args (--json, --raw_output)
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

On Sat, Sep 4, 2021 at 12:14 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Problem:
>
> What does this do?
> $ kunit.py run --json
> Well, it runs all the tests and prints test results out as JSON.
>
> And next is
> $ kunit.py run my-test-suite --json
> This runs just `my-test-suite` and prints results out as JSON.
>
> But what about?
> $ kunit.py run --json my-test-suite
> This runs all the tests and stores the json results in a "my-test-suite"
> file.
>
> Why:
> --json, and now --raw_output are actually string flags. They just have a
> default value. --json in particular takes the name of an output file.
>
> It was intended that you'd do
> $ kunit.py run --json=my_output_file my-test-suite
> if you ever wanted to specify the value.
>
> Workaround:
> It doesn't seem like there's a way to make
> https://docs.python.org/3/library/argparse.html only accept arg values
> after a '='.
>
> I believe that `--json` should "just work" regardless of where it is.
> So this patch automatically rewrites a bare `--json` to `--json=stdout`.
>
> That makes the examples above work the same way.
> Add a regression test that can catch this for --raw_output.
>
> Fixes: 6a499c9c42d0 ("kunit: tool: make --raw_output support only showing kunit output")
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
Thanks! This definitely is a real issue that we need to fix: it's been
sheer luck that I haven't hit it several times.

I do think the implementation here is both hacky, and requires a
little bit more Python knowledge than I'm personally super comfortable
with. The comments are good, though, which makes me reasonably content
that I could work with it if I had to.

Additionally, it produces a mypy warning:
tools/testing/kunit/kunit.py:207: error: Incompatible return value
type (got "Iterator[str]", expected "Sequence[str]")

Regardless, this works very well from the user point of view, so it's:
Tested-by: David Gow <davidgow@google.com>

Thanks,
-- David

>  tools/testing/kunit/kunit.py           | 24 ++++++++++++++++++++++--
>  tools/testing/kunit/kunit_tool_test.py |  8 ++++++++
>  2 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 5a931456e718..95d62020e4f2 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -16,7 +16,7 @@ assert sys.version_info >= (3, 7), "Python version is too old"
>
>  from collections import namedtuple
>  from enum import Enum, auto
> -from typing import Iterable
> +from typing import Iterable, Sequence
>
>  import kunit_config
>  import kunit_json
> @@ -186,6 +186,26 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
>                                 exec_result.elapsed_time))
>         return parse_result
>
> +# Problem:
> +# $ kunit.py run --json
> +# works as one would expect and prints the parsed test results as JSON.
> +# $ kunit.py run --json suite_name
> +# would *not* pass suite_name as the filter_glob and print as json.
> +# argparse will consider it to be another way of writing
> +# $ kunit.py run --json=suite_name
> +# i.e. it would run all tests, and dump the json to a `suite_name` file.
> +# So we hackily automatically rewrite --json => --json=stdout
> +pseudo_bool_flag_defaults = {
> +               '--json': 'stdout',
> +               '--raw_output': 'kunit',
> +}
> +def massage_argv(argv: Sequence[str]) -> Sequence[str]:
> +       def massage_arg(arg: str) -> str:
> +               if arg not in pseudo_bool_flag_defaults:
> +                       return arg
> +               return  f'{arg}={pseudo_bool_flag_defaults[arg]}'
> +       return map(massage_arg, argv)
> +
>  def add_common_opts(parser) -> None:
>         parser.add_argument('--build_dir',
>                             help='As in the make command, it specifies the build '
> @@ -303,7 +323,7 @@ def main(argv, linux=None):
>                                   help='Specifies the file to read results from.',
>                                   type=str, nargs='?', metavar='input_file')
>
> -       cli_args = parser.parse_args(argv)
> +       cli_args = parser.parse_args(massage_argv(argv))
>
>         if get_kernel_root_path():
>                 os.chdir(get_kernel_root_path())
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 619c4554cbff..1edcc8373b4e 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -408,6 +408,14 @@ class KUnitMainTest(unittest.TestCase):
>                         self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
>                         self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
>
> +       def test_run_raw_output_does_not_take_positional_args(self):
> +               # --raw_output is a string flag, but we don't want it to consume
> +               # any positional arguments, only ones after an '='
> +               self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
> +               kunit.main(['run', '--raw_output', 'filter_glob'], self.linux_source_mock)
> +               self.linux_source_mock.run_kernel.assert_called_once_with(
> +                       args=None, build_dir='.kunit', filter_glob='filter_glob', timeout=300)
> +
>         def test_exec_timeout(self):
>                 timeout = 3453
>                 kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
>
> base-commit: a9c9a6f741cdaa2fa9ba24a790db8d07295761e3
> --
> 2.33.0.153.gba50c8fa24-goog
>
