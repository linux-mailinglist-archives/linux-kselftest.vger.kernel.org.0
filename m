Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6782D424D89
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 08:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbhJGG5u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 02:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbhJGG5c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 02:57:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2397BC06176F
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Oct 2021 23:55:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v17so15735880wrv.9
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Oct 2021 23:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8RUD7tgl7QBdRvO3S95Wf0Fqgv9Sk7pIXK1c0ZKGNo=;
        b=kGbrd6nJPydsGcCe1K/7K2ucX7InBSm+e+PCuITNTKJ24khyutoW8rGdBJSCb+ojdx
         NnFmUzXtqUY0KapTp34iZCFrHIAD6oKfWL74F0GZZE8456ik87GFvuCLS8hTSE8ZqAQw
         /azyoMSCwf6/LWZ++su08CVRkUkdQv9ua9AVJBCL4NVatmUGbsrRLGH1iEMJj3uvgMNI
         +re5NrU96RafWbrBrvEG49SALATPBDYEhsNbOUhMn4YN9JP4qj/Hp3R+VKPd3Ta/jS5j
         iPVIdI1OA3dWxz7IzGxIeNtBOvPU0aKEjxbD+WaNGhCwFmVNpHLBrlR0vHwfby57kRdi
         353Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8RUD7tgl7QBdRvO3S95Wf0Fqgv9Sk7pIXK1c0ZKGNo=;
        b=S54V1hmESiG864srz7ZJsvX1ANTRo0skhKQPxPpnFClS6OkuMJ1scRb3sQA43+xHR8
         bNuB0/mh3uxorLMztlCJYPNHz93KUFkD6lnv0jvIRzP8KJ2MVl535jldWKo1cJ4LR8JF
         I6btO0iaVTJ2XWCVH09hLw6YgWU9Ocfprqk0khBOzU8reqX0cQmLiJkHxh2sc0NM5xd+
         1SXfkvn18Sfn1eCh6HC8DRMx9u+1bxA/nT21TP5BwpvderQk2cvQ0E/T7YtrI5SNNRXl
         aMpMaQAygDapJbeuRAXMtoXaolAaLK8D42jQNPOX7UPEQP5ReVfa3Skon+gay+fbzvTA
         bqag==
X-Gm-Message-State: AOAM531mit2uIkBuyhov0vGyE84deqLn3W5L1ND11jzauycZD+DHxiYG
        9pGnNPucdyAh6BtUqXIp9w6Gh1RxVNdLgXN6KqmsQg==
X-Google-Smtp-Source: ABdhPJyhav1vupCSDW40GLrZgzAwI3C1wfuH+z5yfi4o1Rr8u/qKLGD8HzQDC4g6gB+s8+80wLJb6+PVyNCm29rPuu4=
X-Received: by 2002:a7b:c453:: with SMTP id l19mr2730254wmi.7.1633589735502;
 Wed, 06 Oct 2021 23:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211007054410.290427-1-dlatypov@google.com>
In-Reply-To: <20211007054410.290427-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 7 Oct 2021 14:55:24 +0800
Message-ID: <CABVgOS=V-+DRtjrtEXn6fJgfe-jZJU1t_0CLfWWN=fRUUe74hw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: print parsed test results fully incrementally
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

On Thu, Oct 7, 2021 at 1:44 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> With the parser rework [1] and run_kernel() rework [2], this allows the
> parser to print out test results incrementally.
>
> Currently, that's held up by the fact that the LineStream eagerly
> pre-fetches the next line when you call pop().
> This blocks parse_test_result() from returning until the line *after*
> the "ok 1 - test name" line is also printed.
>
> One can see this with the following example:
> $ (echo -e 'TAP version 14\n1..3\nok 1 - fake test'; sleep 2; echo -e 'ok 2 - fake test 2'; sleep 3; echo -e 'ok 3 - fake test 3') | ./tools/testing/kunit/kunit.py parse
>
> Before this patch [1]: there's a pause before 'fake test' is printed.
> After this patch: 'fake test' is printed out immediately.
>
> This patch also adds
> * a unit test to verify LineStream's behavior directly
> * a test case to ensure that it's lazily calling the generator
> * an explicit exception for when users go beyond EOF
>
> [1] https://lore.kernel.org/linux-kselftest/20211006170049.106852-1-dlatypov@google.com/
> [2] https://lore.kernel.org/linux-kselftest/20211005011340.2826268-1-dlatypov@google.com/
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks. I tried this out with qemu/i386 and it does appropriately
pause while 'time_test_cases' is running, but shows all the results
beforehand. For reference, the output (with timestamps):
[23:53:06] =============== time_test_cases (1 subtest) ================
[23:53:58] [PASSED] time64_to_tm_test_date_range
[23:53:58] ================= [PASSED] time_test_cases =================


Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit_parser.py    | 22 ++++++++++----
>  tools/testing/kunit/kunit_tool_test.py | 42 +++++++++++++++++++++++++-
>  2 files changed, 57 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index f01fd565f978..82900a5f9ad6 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -172,42 +172,51 @@ class TestCounts:
>  class LineStream:
>         """
>         A class to represent the lines of kernel output.
> -       Provides a peek()/pop() interface over an iterator of
> +       Provides a lazy peek()/pop() interface over an iterator of
>         (line#, text).
>         """
>         _lines: Iterator[Tuple[int, str]]
>         _next: Tuple[int, str]
> +       _need_next: bool
>         _done: bool
>
>         def __init__(self, lines: Iterator[Tuple[int, str]]):
>                 """Creates a new LineStream that wraps the given iterator."""
>                 self._lines = lines
>                 self._done = False
> +               self._need_next = True
>                 self._next = (0, '')
> -               self._get_next()
>
>         def _get_next(self) -> None:
> -               """Advances the LineSteam to the next line."""
> +               """Advances the LineSteam to the next line, if necessary."""
> +               if not self._need_next:
> +                       return
>                 try:
>                         self._next = next(self._lines)
>                 except StopIteration:
>                         self._done = True
> +               finally:
> +                       self._need_next = False
>
>         def peek(self) -> str:
>                 """Returns the current line, without advancing the LineStream.
>                 """
> +               self._get_next()
>                 return self._next[1]
>
>         def pop(self) -> str:
>                 """Returns the current line and advances the LineStream to
>                 the next line.
>                 """
> -               n = self._next
> -               self._get_next()
> -               return n[1]
> +               s = self.peek()
> +               if self._done:
> +                       raise ValueError(f'LineStream: going past EOF, last line was {s}')
> +               self._need_next = True
> +               return s
>
>         def __bool__(self) -> bool:
>                 """Returns True if stream has more lines."""
> +               self._get_next()
>                 return not self._done
>
>         # Only used by kunit_tool_test.py.
> @@ -220,6 +229,7 @@ class LineStream:
>
>         def line_number(self) -> int:
>                 """Returns the line number of the current line."""
> +               self._get_next()
>                 return self._next[0]
>
>  # Parsing helper methods:
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index c309ed76aef5..3cb02827c941 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -13,8 +13,9 @@ import tempfile, shutil # Handling test_tmpdir
>
>  import itertools
>  import json
> -import signal
>  import os
> +import signal
> +from typing import Iterable
>
>  import kunit_config
>  import kunit_parser
> @@ -320,6 +321,45 @@ class KUnitParserTest(unittest.TestCase):
>                                 result.status)
>                         self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
>
> +def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
> +       return kunit_parser.LineStream(enumerate(strs, start=1))
> +
> +class LineStreamTest(unittest.TestCase):
> +
> +       def test_basic(self):
> +               stream = line_stream_from_strs(['hello', 'world'])
> +
> +               self.assertTrue(stream, msg='Should be more input')
> +               self.assertEqual(stream.line_number(), 1)
> +               self.assertEqual(stream.peek(), 'hello')
> +               self.assertEqual(stream.pop(), 'hello')
> +
> +               self.assertTrue(stream, msg='Should be more input')
> +               self.assertEqual(stream.line_number(), 2)
> +               self.assertEqual(stream.peek(), 'world')
> +               self.assertEqual(stream.pop(), 'world')
> +
> +               self.assertFalse(stream, msg='Should be no more input')
> +               with self.assertRaisesRegex(ValueError, 'LineStream: going past EOF'):
> +                       stream.pop()
> +
> +       def test_is_lazy(self):
> +               called_times = 0
> +               def generator():
> +                       nonlocal called_times
> +                       for i in range(1,5):
> +                               called_times += 1
> +                               yield called_times, str(called_times)
> +
> +               stream = kunit_parser.LineStream(generator())
> +               self.assertEqual(called_times, 0)
> +
> +               self.assertEqual(stream.pop(), '1')
> +               self.assertEqual(called_times, 1)
> +
> +               self.assertEqual(stream.pop(), '2')
> +               self.assertEqual(called_times, 2)
> +
>  class LinuxSourceTreeTest(unittest.TestCase):
>
>         def setUp(self):
>
> base-commit: 9b409050eaf2da929408fa60fbf535745d828e67
> --
> 2.33.0.882.g93a45727a2-goog
>
