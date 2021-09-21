Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C547B413773
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Sep 2021 18:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhIUQWf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Sep 2021 12:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbhIUQW2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Sep 2021 12:22:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FFBC061767
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Sep 2021 09:20:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t18so40859914wrb.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Sep 2021 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=078yoIIes6XudmrA4ndvhJcU0cqJ5ibZSu/SRqkDGds=;
        b=LD7Xem73lecJCrN4VziR5KcEWxK5iCEy6tqZaK5KCA9LB0VCuJchCA0iT98pdeX3zG
         WCDjpZYupCOQz9C2hEONtTu7PinvrJFwHqLMpE+jyDBrQe5s8VITYlFWygdOR15gX//b
         dRgBFxrZENPcbUyM1VT+x7LIla20YSnzht1ryfdiAivrI5ne2O9XD3pLMGWU1CMxhJQO
         qaStlXjXQGtdMiGiQU0Bvo9pT0pCo3+kz9eY1y45vXvgVuuc4QqQnt50IAPxgQ+1LO+X
         eh1CaAjN/kP2/L7zxJW/mNQQLYjL9EUpL4A6//mtFzgoYCe6gODwctowDPBBCnA0qmjq
         hyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=078yoIIes6XudmrA4ndvhJcU0cqJ5ibZSu/SRqkDGds=;
        b=v2ENjTeVlfJs2vOwSPRzfpjWhTKAEyWTuJYubjSUutHKtRH9z5oguI/GfMdIpRc8TU
         2Nnqnj1igqwZQugrf7wza3Z8EgHTh13Q3qN6O+ziMPlQ8grEUwXRpiUMuuyZ/2Si45rG
         7/c57RvTG54iPd0CSxEumalLQDJ7uplDefYZzQFdMJ5pvy0IikPDPkOvBHUDrGvY26bZ
         snjhJJUJpbrQhtgwy7AjNPMokKZpujVmxvHa6llB6YqMuShea99C2aH9PmZY8dvLTxmC
         c00VRH+nqHNrDcjIZb9xNAtjC6xQQgEpEKg4p1gyXhI/joML+jpVfICLcz3n1c+Bxvqt
         P4fw==
X-Gm-Message-State: AOAM530dyRA+W9hcLoZtuu33W6wGzuc1vbfUt5OgKbD3/ltuSLr+NaHh
        kGE/CxwlZSOBPBjS/mFX1OXXUOrxZoh71V0pErtI8g==
X-Google-Smtp-Source: ABdhPJxaDiXULVbh/F82K9ZFKKGTEq6b50WBbTfis9z0VqZVmbdS3XARCUgkO9Ie6hE4+J0O81R8wqC5QZUZpUwtI8E=
X-Received: by 2002:adf:d1e9:: with SMTP id g9mr24352051wrd.200.1632241203757;
 Tue, 21 Sep 2021 09:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210916223903.1592541-1-dlatypov@google.com>
In-Reply-To: <20210916223903.1592541-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 22 Sep 2021 00:19:52 +0800
Message-ID: <CABVgOSk3K5PGii7uMBpqRRxgVZpxPX19CMn8cYp_782T1ycZig@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: make --raw_output only support showing kunit output
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

On Fri, Sep 17, 2021 at 6:39 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit 6a499c9c42d0 ("kunit: tool: make --raw_output support only
> showing kunit output") made --raw_output a string-typed argument.
> Passing --raw_output=kunit would make it only show KUnit-related output
> and not everything.
>
> However, converting it to a string-typed argument had side effects.
>
> These calls used to work:
> $ kunit.py run --raw_output
> $ kunit.py run --raw_output suite_filter
> $ kunit.py run suite_filter --raw_output
>
> But now the second is actually parsed as
> $ kunit.py run --raw_output=suite_filter
>
> So the order you add in --raw_output now matters and command lines that
> used to work might not anymore.
>
> Change --raw_output back to a boolean flag, but change its behavior to
> match that of the former --raw_output=kunit.
> The assumption is that this is what most people wanted to see anyways.
>
> To get the old behavior, users can simply do:
> $ kunit.py run >/dev/null; cat .kunit/test.log
> They don't have any easy way of getting the --raw_output=kunit behavior.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
>
> Meta: this is an alternative to
> https://lore.kernel.org/linux-kselftest/20210903161405.1861312-1-dlatypov@google.com/
>
> I'd slightly prefer that approach, but if we're fine with giving up the
> old --raw_output semantics entirely, this would be cleaner.
> I'd also assume that most people would prefer the new semantics, but I'm
> not sure of that.
>
> ---

Thanks. I'm happy with either approach, but this is the one I properly
understand. If you'd rather push the other one, I agree that it's
better from a user perspective, so I'm okay with that: it's just a bit
beyond my comfort zone Python-hacks wise.

If we do go with this one, and I need the whole output, just running
the UML 'linux' binary is another option, which I've used in the past.
That's a bit trickier for qemu though: maybe there's some benefit in
having a --dry-run option for kunit.py run which just prints the
command used to execute the kernel. That's obviously beyond the scope
of this, though.

Regardless, this is
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  Documentation/dev-tools/kunit/kunit-tool.rst |  7 -------
>  tools/testing/kunit/kunit.py                 | 12 +++---------
>  tools/testing/kunit/kunit_tool_test.py       | 13 ++++++-------
>  3 files changed, 9 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
> index ae52e0f489f9..03404746f1f6 100644
> --- a/Documentation/dev-tools/kunit/kunit-tool.rst
> +++ b/Documentation/dev-tools/kunit/kunit-tool.rst
> @@ -114,13 +114,6 @@ results in TAP format, you can pass the ``--raw_output`` argument.
>
>         ./tools/testing/kunit/kunit.py run --raw_output
>
> -The raw output from test runs may contain other, non-KUnit kernel log
> -lines. You can see just KUnit output with ``--raw_output=kunit``:
> -
> -.. code-block:: bash
> -
> -       ./tools/testing/kunit/kunit.py run --raw_output=kunit
> -
>  If you have KUnit results in their raw TAP format, you can parse them and print
>  the human-readable summary with the ``parse`` command for kunit_tool. This
>  accepts a filename for an argument, or will read from standard input.
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 5a931456e718..3626a56472b5 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -115,13 +115,7 @@ def parse_tests(request: KunitParseRequest) -> KunitResult:
>                                               'Tests not Parsed.')
>
>         if request.raw_output:
> -               output: Iterable[str] = request.input_data
> -               if request.raw_output == 'all':
> -                       pass
> -               elif request.raw_output == 'kunit':
> -                       output = kunit_parser.extract_tap_lines(output)
> -               else:
> -                       print(f'Unknown --raw_output option "{request.raw_output}"', file=sys.stderr)
> +               output = kunit_parser.extract_tap_lines(request.input_data)
>                 for line in output:
>                         print(line.rstrip())
>
> @@ -256,8 +250,8 @@ def add_exec_opts(parser) -> None:
>
>  def add_parse_opts(parser) -> None:
>         parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
> -                           'If set to --raw_output=kunit, filters to just KUnit output.',
> -                           type=str, nargs='?', const='all', default=None)
> +                           'It will only show output from KUnit.',
> +                           action='store_true')
>         parser.add_argument('--json',
>                             nargs='?',
>                             help='Stores test results in a JSON, and either '
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 619c4554cbff..55ed3dac31ee 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -399,14 +399,13 @@ class KUnitMainTest(unittest.TestCase):
>                         self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
>                         self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
>
> -       def test_run_raw_output_kunit(self):
> +       def test_run_raw_output_does_not_take_positional_args(self):
> +               # --raw_output might eventually support an argument, but we don't want it
> +               # to consume any positional arguments, only ones after an '='.
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
> -               kunit.main(['run', '--raw_output=kunit'], self.linux_source_mock)
> -               self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
> -               self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
> -               for call in self.print_mock.call_args_list:
> -                       self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
> -                       self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
> +               kunit.main(['run', '--raw_output', 'filter_glob'], self.linux_source_mock)
> +               self.linux_source_mock.run_kernel.assert_called_once_with(
> +                       args=None, build_dir='.kunit', filter_glob='filter_glob', timeout=300)
>
>         def test_exec_timeout(self):
>                 timeout = 3453
>
> base-commit: 316346243be6df12799c0b64b788e06bad97c30b
> --
> 2.33.0.464.g1972c5931b-goog
>
