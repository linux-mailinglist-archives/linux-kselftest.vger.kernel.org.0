Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C55436F63
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Oct 2021 03:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJVBcM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 21:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhJVBcM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 21:32:12 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAA2C061764
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 18:29:55 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id j3so2659806ilr.6
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 18:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3jDBk9yo6edEGUuLwwaGLCXLGM6rDEU8cNKE6u53Dk=;
        b=oxbZC7ZhdszFv0Hb2S0jw4TtI/KtS15YhuoM+td6UKf8Lk3b7v45BgaaIZcV08Pv9p
         qzpAG6oJ4oGon3Iu32Dq5WQ09YAIc5ha54mHceVOkRXpW2F3cgbYB6q+rH56+Zlw3Z8G
         e1df350l668uaFM+P656oyIhAIaZQKHjqlDrQypLS3aTuPhfPpaAIK6xvU0oaMCduvwJ
         ng2QsUslga3G7Sx5AGuTGctLe6OZhCGdNYt6obHx7gJIlGV/ZbzzE2nRaZL6E0lXv1P/
         hwPNadOsGUYYsDCaaqBM4MT+WeBrQ09Pg6SXeiYRqDtGDA95crWSmf326nGO/muwYcUm
         +eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3jDBk9yo6edEGUuLwwaGLCXLGM6rDEU8cNKE6u53Dk=;
        b=0e/NtABa0nLwLQznhiW8ZnqV2a2Z3kIo7ISRakztCtM5SErFr0RAaOFISVh+KUOKGC
         QvcG70LkMzKnp7pYaQt0zOecs8lsStv8alwm+HVWuiCelmjbrnMktK7J//OUyDvwJzng
         E4nVpUdMigisDtSkwHtWgXMaWC9YoQR3vo+Op2SKSX0C5jDOhyT5kpLLJXxoLjLYn5vZ
         rx+tIrAs8wxFPprkwUaFg4Zi16ZJgT/DGIiOBkMJwT/8P7qJPefEdu21EUgjefrvd2LV
         FM4fOa6phgoEcm5cHYAzmjUPb/kV5nWiKqaKIghr/2lSoay3aG1iwWvRrM7w5fvQIZxp
         DUlA==
X-Gm-Message-State: AOAM533seFdj6jTT43FarFU9Ck2OGklhYTyn/aG525NVADtCzEcB9XJB
        8IuFsWj1Juzdvi8SCfr6V6gIbDxVor6EVSHLBPURxg==
X-Google-Smtp-Source: ABdhPJzIcijVx0u8vP2/ilhqKw53hS2Rv+mSujkBZjeFpghYtPw3LN2tb012rXfai1OQ0aFDYuBtXkJzukmEeSjMPds=
X-Received: by 2002:a92:cf44:: with SMTP id c4mr5888531ilr.293.1634866195037;
 Thu, 21 Oct 2021 18:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211021062819.1313964-1-davidgow@google.com>
In-Reply-To: <20211021062819.1313964-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 21 Oct 2021 18:29:43 -0700
Message-ID: <CAGS_qxoBhfaE7NLzKWrsxwwz9BFeLRzb9Ycc-6U29pmtceqCTQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: Do not error on tests without test plans
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

On Wed, Oct 20, 2021 at 11:28 PM David Gow <davidgow@google.com> wrote:
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

This works well, but there's an edge case.

This patch means we no longer print an error when there are no test
cases in a subtest.
We relied on a check just a bit lower in this function.

Consider

$ ./tools/testing/kunit/kunit.py parse <<EOF
TAP version 14
1..1
  # Subtest: suite
  1..1
    # Subtest: case
  ok 1 - case
ok 1 - suite
EOF

This produces the following output (timestamps removed)

============================================================
==================== suite (1 subtest) =====================
=========================== case ===========================
====================== [PASSED] case =======================
====================== [PASSED] suite ======================
============================================================

Should we surface some sort of error here?


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
