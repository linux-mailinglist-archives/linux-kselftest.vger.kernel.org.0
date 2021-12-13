Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D994732DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 18:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbhLMRYp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 12:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbhLMRYp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 12:24:45 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E8EC06173F
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Dec 2021 09:24:45 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id 15so15696989ilq.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Dec 2021 09:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izyPlV9s0tLTAm1bln4PLV07W4NiOuUYJ+h3tC2rZQU=;
        b=L0yHgl5pDE97iwbnffL0ku07lI6XItptlcgK9ck39E3x3NU/nrTUqNU08cnJ/yUzBd
         0x56ANvbsiPB/V3I+DaiN62gZ8XKmtxYQF6JtMIdJ5sGdLP/zZ/BiOPMcDoQCZlB4UQV
         RkJtgLNdJXdkkHJuJZC47W/iCZHy+Z12hicpgnxdjpAZ0D19yEVWbEQCOHNfE7s5jdk5
         10gEHvxckK6KHJ3TZWsmkV7s5by8bonnQF//Fo38jWT6d5V6iHRErDZT5aKflqqkgWe4
         Vt5c1ul90bdHCbAFPeXfYCkdvW1YLtszg6rSVCUGeDcNOcoOD0VdGENdlvedirL4RbK9
         JaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izyPlV9s0tLTAm1bln4PLV07W4NiOuUYJ+h3tC2rZQU=;
        b=5F/FyWJwoocy5kRfUE3hNgdfe7RsKqVmTAxktInZCcQMlIkOtzBJGgwWyxc1scck8+
         GBTceWIDiNmGFnyAbHydJj87zXhRTAPPF46dxPFfQJq8t7nVexWim0JZ6ZR5kd7y39mg
         UCFVTzFOfwhJ0CodIVDJpKmUROeU+2RtFuHKK4DrJw8L/KnS9MXuRmVnz9PvDNa0eKf6
         P620RRLuWd3aXx+qfn5NanUGNOpG4Urq9GNG83iFyOCSZPt8zW4vY0+0jdxP7uvBEBPT
         au46+zqa/+AWWQCHBQZbZjZ5hA97/GQ3EbFChSHU3OB+/PftdRPsXlYaxDNr3ggLyOUp
         ah3A==
X-Gm-Message-State: AOAM531A132i6NOWJ6LHbnvNQBOCzpc/x42DWFwiQUuY7emoODDY1cPz
        Pk9ojH2p7ZxVcemw1L5C9Gogg6UOCCzFzoE7kN1tSg==
X-Google-Smtp-Source: ABdhPJycnm2C06ujzF8qEW+PQFkoSKqxTYZ8z0mySQetvQ6cFneJ7i9qhDQWx4Q4OSCWDxlfI2eqX5hvkEx77luR3OA=
X-Received: by 2002:a92:d586:: with SMTP id a6mr13074796iln.293.1639416284276;
 Mon, 13 Dec 2021 09:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20211212033229.527955-1-davidgow@google.com>
In-Reply-To: <20211212033229.527955-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 13 Dec 2021 09:24:33 -0800
Message-ID: <CAGS_qxrDxVPDGqSqpVTF5wq23Q=3WDitc+k2VtOzQwm_N6Cyjg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: Default --jobs to number of CPUs
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Dec 11, 2021 at 7:32 PM David Gow <davidgow@google.com> wrote:
>
> The --jobs parameter for kunit_tool currently defaults to 8 CPUs,
> regardless of the number available. For systems with significantly more
> (or less), this is not as efficient. Instead, default --jobs to the
> number of CPUs available to the process: while there are as many
> superstitions as to exactly what the ideal jobs:CPU ratio is, this seems
> sufficiently sensible to me.
>
> A new helper function to get the default number of jobs is added:
> get_default_jobs() -- this is used in kunit_tool_test instead of a
> hardcoded value, or an explicit call to len(os.sched_getaffinity()), so
> should be more flexible if this needs to change in the future.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Looks good to me.
I played around with a few commands like
$ taskset 0x3 ./tools/testing/kunit/kunit.py run
and saw it pick the pass the expected --jobs value to make.

> ---
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20211211084928.410669-1-davidgow@google.com/
> - Use len(os.sched_getaffinity()) instead of os.cpu_count(), which gives
>   the number of available processors (to this process), rather than the
>   total.
> - Fix kunit_tool_test.py, which had 8 jobs hardcoded in a couple of
>   places.
> - Thanks to Daniel Latypov for these suggestions.
>
> ---
>
>  tools/testing/kunit/kunit.py           | 5 ++++-
>  tools/testing/kunit/kunit_tool_test.py | 5 +++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 68e6f461c758..6b0ddd6d0115 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -264,6 +264,9 @@ def massage_argv(argv: Sequence[str]) -> Sequence[str]:
>                 return  f'{arg}={pseudo_bool_flag_defaults[arg]}'
>         return list(map(massage_arg, argv))
>
> +def get_default_jobs() -> int:
> +       return len(os.sched_getaffinity(0))
> +
>  def add_common_opts(parser) -> None:
>         parser.add_argument('--build_dir',
>                             help='As in the make command, it specifies the build '
> @@ -310,7 +313,7 @@ def add_build_opts(parser) -> None:
>         parser.add_argument('--jobs',
>                             help='As in the make command, "Specifies  the number of '
>                             'jobs (commands) to run simultaneously."',
> -                           type=int, default=8, metavar='jobs')
> +                           type=int, default=get_default_jobs(), metavar='jobs')
>
>  def add_exec_opts(parser) -> None:
>         parser.add_argument('--timeout',
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 9c4126731457..512936241a56 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -419,7 +419,7 @@ class KUnitMainTest(unittest.TestCase):
>         def test_build_passes_args_pass(self):
>                 kunit.main(['build'], self.linux_source_mock)
>                 self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
> -               self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, '.kunit', None)
> +               self.linux_source_mock.build_kernel.assert_called_once_with(False, kunit.get_default_jobs(), '.kunit', None)
>                 self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
>
>         def test_exec_passes_args_pass(self):
> @@ -525,8 +525,9 @@ class KUnitMainTest(unittest.TestCase):
>
>         def test_build_builddir(self):
>                 build_dir = '.kunit'
> +               jobs = kunit.get_default_jobs()
>                 kunit.main(['build', '--build_dir', build_dir], self.linux_source_mock)
> -               self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, build_dir, None)
> +               self.linux_source_mock.build_kernel.assert_called_once_with(False, jobs, build_dir, None)
>
>         def test_exec_builddir(self):
>                 build_dir = '.kunit'
> --
> 2.34.1.173.g76aa8bc2d0-goog
>
