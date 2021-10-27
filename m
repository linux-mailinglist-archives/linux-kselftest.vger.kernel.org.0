Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE8A43D65C
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 00:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhJ0WPb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 18:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJ0WPa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 18:15:30 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08A7C061745
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 15:13:04 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q127so4559064iod.12
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 15:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nsPi011gcGKznhyjP8gBINhHiBPj2QE+X2X3O0VWlpk=;
        b=MZtSKBHP1KVQ1mjg5IuFaSQD293zXvnDzt0544S3lh+JNRUKzK3t1ttv1plljLefLi
         fB0n2RfBbHIfle2mgpvE83wmLDV40SuJRepz4Sy1qzjZKrbVCzYMOLRr/VUmYZXWY6h3
         wheImgLZt5QAb5G6YzlonG3u2R0r9RfoL74nuP4fRSYaCYIdyR/IrvAjHAQPjDWoeF4E
         qgLcyQzS9qeoQA2r6oGv9Ogz0FFStG0TpvrAJPtjdjMaQcGUPAr8VloRAi0tNaRWHonU
         3UjDGvvsWOajH/556/6IbcWMfQSKhujDCe04xsK/FN4Eq4q6y+GdwsCXrV4DMftnCXF8
         kxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nsPi011gcGKznhyjP8gBINhHiBPj2QE+X2X3O0VWlpk=;
        b=rFUi7PSp1onzBZN+H34EktMFvNrCr6ptm7Cx/gaEVynd2gMuqv0HZZaski+goXDsCh
         9F4LgRa5ABsmLBnLWywu4DzAXyI9muys1O7TJMaMJjmicKLvjs5frRy0aKR00LNsWNxX
         qnxWFGo9+ovz5epEw62IenBluWOepV+GVa4bjepx6nP6f8ff2GAwqco5tLf6YIjh/SJI
         7vwyO9kkDu4yrVwQ9Vac0wGZOsM2S4ZUs3o/374z1a1/1cFykcZtqRvuRfP8YqJ4Qf1x
         6YNr0BudN7YHSpb/Nqlm9S2GhlVBZrttQUTy1RrsY3Qgd9EEYbwtpgXLJZ4X2ngQvabe
         4UUQ==
X-Gm-Message-State: AOAM531QvOKzHq3Yi3C2VZnCeZ6SlaE7QVpnqaBwP5bX3/QRVZm2ZK6A
        15KP9WwQ/gt2uiLqATiEtOA2A3dQPDBeMHRJRIBD+Q==
X-Google-Smtp-Source: ABdhPJwnKnH5eg4CHR4DQH4tbzYgXD2kRYKfzNsaBOrSDwm/OgpJbhqbbqA4QefQdPSg7bUSYn+TlUCA1iJ2HtpKLq4=
X-Received: by 2002:a05:6638:dc6:: with SMTP id m6mr390546jaj.48.1635372783922;
 Wed, 27 Oct 2021 15:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211027013702.2039566-1-davidgow@google.com>
In-Reply-To: <20211027013702.2039566-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 27 Oct 2021 15:12:52 -0700
Message-ID: <CAGS_qxo2=NmXEnEnkg4E_1k-DXwniGK8xFZi08nKZZkb8otXzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kunit: tool: Do not error on tests without test plans
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 26, 2021 at 6:37 PM David Gow <davidgow@google.com> wrote:
>
> The (K)TAP spec encourages test output to begin with a 'test plan': a
> count of the number of tests being run of the form:
> 1..n
>
> However, some test suites might not know the number of subtests in
> advance (for example, KUnit's parameterised tests use a generator
> function). In this case, it's not possible to print the test plan in
> advance.
>
> kunit_tool already parses test output which doesn't contain a plan, but
> reports an error. Since we want to use nested subtests with KUnit
> paramterised tests, remove this error.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

This looks to be unchanged from v1.
Looks good to me given kunit itself will report SKIPPED for parameterised tests.

> ---
>  tools/testing/kunit/kunit_parser.py    | 5 ++---
>  tools/testing/kunit/kunit_tool_test.py | 5 ++++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 3355196d0515..50ded55c168c 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -340,8 +340,8 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
>         """
>         Parses test plan line and stores the expected number of subtests in
>         test object. Reports an error if expected count is 0.
> -       Returns False and reports missing test plan error if fails to parse
> -       test plan.
> +       Returns False and sets expected_count to None if there is no valid test
> +       plan.
>
>         Accepted format:
>         - '1..[number of subtests]'
> @@ -356,7 +356,6 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
>         match = TEST_PLAN.match(lines.peek())
>         if not match:
>                 test.expected_count = None
> -               test.add_error('missing plan line!')
>                 return False
>         test.log.append(lines.pop())
>         expected_count = int(match.group(1))
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 9c4126731457..bc8793145713 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -191,7 +191,10 @@ class KUnitParserTest(unittest.TestCase):
>                         result = kunit_parser.parse_run_tests(
>                                 kunit_parser.extract_tap_lines(
>                                 file.readlines()))
> -               self.assertEqual(2, result.test.counts.errors)
> +               # A missing test plan is not an error.
> +               self.assertEqual(0, result.test.counts.errors)
> +               # All tests should be accounted for.
> +               self.assertEqual(10, result.test.counts.total())
>                 self.assertEqual(
>                         kunit_parser.TestStatus.SUCCESS,
>                         result.status)
> --
> 2.33.0.1079.g6e70778dc9-goog
>
