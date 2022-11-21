Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CC3632E2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Nov 2022 21:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiKUUvt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 15:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiKUUvs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 15:51:48 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A93C9A87
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 12:51:47 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id n189so2587422yba.8
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 12:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rzk/OoHldFb62sgZsjulPSkjrNjPl5Xo51StZUIwQR4=;
        b=oOb+iJxhz4nONMEq0oTcLXm8I9REhxu1SiJRcnUJH7TOoXnCjFr79nrjXAE7cviCER
         Ll0T/+g62FhTyFnCmhqx9eX3zkv17IvbNRamtQWw7FMBltzjTeTCakJdFjH3GywilbEq
         QYQvGOqFh+gVdHCta3PorKTg1qb5x9MjMhnNXfugdZMg0T1psFSGnlucv+zgcFXGv3AX
         Xq2lFsyZGy9EyfFMSKVn9ytYXqDwEAwETzocYb1Oed56RHUxDY+6Pvw9h5P2BoMaOpSN
         +RlzFrBx0NvME3Tp/7LQ9rrMuVswfWUdzpyQ7R5aqDPWA9/ReSI8O9sJWXR16VSsM3Ge
         ArQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rzk/OoHldFb62sgZsjulPSkjrNjPl5Xo51StZUIwQR4=;
        b=HNZv6nbJC2+9NzZ5mkY+4n0p+5NN65mRsTNgIr7lwjVnkn1ZQLH3mqHhYczIF8CXi3
         hhOqeotkQghtLrfWmMDj8oscdV3tyIDmfmtetY2qfj9NPMN0aOaLDy0raeN1uyl6rvLP
         n3zyg1QelslR6WFNfwJizdGxOJCqxy9cA/CrCAwD3TJxoGWcAbJ9dSRTd0GhNQUnbbYh
         XUwBRtsniKMxbPcfWtTyZ/E7aPH+Fy7KFGLvjfuyOsRgkCNne9SYUhZTvQwu/d0QWaJt
         2XLFe3XLtS4Ex3AMXXaCwNphlM6z1EGpU4psSWS3dx3/3CGmrn0PzoVJpN96r3Is/4oD
         YvwA==
X-Gm-Message-State: ANoB5pkDy4xoPO62N17euY/5osVU+PhTpxa2GaHqPZXkWOu1ABLmzdQ4
        ItyaXtFNp9Gur+sYyijdxDB98PE5FDP6aNHmXFEGsw==
X-Google-Smtp-Source: AA0mqf6ipoHwUmZz4HXsVS/RR8mpYN5nWwxKgxevEBxAvKonZJL6DGgCWM5ht34hS6ztC7I7xVU41WAU0zwvBgEtg6g=
X-Received: by 2002:a25:4289:0:b0:6ca:e43:d9ff with SMTP id
 p131-20020a254289000000b006ca0e43d9ffmr18347709yba.543.1669063906174; Mon, 21
 Nov 2022 12:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20221121184743.1123556-1-rmoar@google.com>
In-Reply-To: <20221121184743.1123556-1-rmoar@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 21 Nov 2022 12:51:35 -0800
Message-ID: <CAGS_qxp1U4rR_g72YX1MEk+oHVda2sLFBjYVQqkD0jkzEG765A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: tool: parse KTAP compliant test output
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, mauro.chehab@linux.intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, isabbasso@riseup.net,
        anders.roxell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 21, 2022 at 10:48 AM Rae Moar <rmoar@google.com> wrote:
>
> Change the KUnit parser to be able to parse test output that complies wit=
h
> the KTAP version 1 specification format found here:
> https://kernel.org/doc/html/latest/dev-tools/ktap.html. Ensure the parser
> is able to parse tests with the original KUnit test output format as
> well.
>
> KUnit parser now accepts any of the following test output formats:
>
> Original KUnit test output format:
>
>  TAP version 14
>  1..1
>    # Subtest: kunit-test-suite
>    1..3
>    ok 1 - kunit_test_1
>    ok 2 - kunit_test_2
>    ok 3 - kunit_test_3
>  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
>  # Totals: pass:3 fail:0 skip:0 total:3
>  ok 1 - kunit-test-suite
>
> KTAP version 1 test output format:
>
>  KTAP version 1
>  1..1
>    KTAP version 1
>    1..3
>    ok 1 kunit_test_1
>    ok 2 kunit_test_2
>    ok 3 kunit_test_3
>  ok 1 kunit-test-suite
>
> New KUnit test output format (changes made in the next patch of
> this series):
>
>  KTAP version 1
>  1..1
>    KTAP version 1
>    # Subtest: kunit-test-suite
>    1..3
>    ok 1 kunit_test_1
>    ok 2 kunit_test_2
>    ok 3 kunit_test_3
>  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
>  # Totals: pass:3 fail:0 skip:0 total:3
>  ok 1 kunit-test-suite
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

Still looks good to me overall.
As noted offline, this sadly has a conflict with another recent patch,
so it won't apply to the kunit branch right now.
That's my fault:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/c=
ommit/?h=3Dkunit&id=3D2a883a9f5c1f1c7bb9d9116da68e2ef2faeae5b8

I found a few optional nits down below that we could also address in
the rebased v3.

> Reviewed-by: David Gow <davidgow@google.com>
> ---
>
> Changes since v1:
> https://lore.kernel.org/all/20221104194705.3245738-2-rmoar@google.com/
> - Switch order of patches to make changes to the parser before making
>   changes to the test output
> - Change placeholder label for test header from =E2=80=9CTest suite=E2=80=
=9D to empty
>   string
> - Change parser to approve the new KTAP version line in the subtest heade=
r
>   to be before the subtest header line rather than after.

Thanks, as noted on the child patch, I think this will make our lives
easier in the future, even if it technically violates the v1 spec
(which requires the test plan right after the KTAP header IIUC).

Given the wording
  Diagnostic lines can be anywhere in the test output.
I assume most implementations would likely ignore unexpected lines
beginning with "# " already.

> - Note: Considered changing parser to allow for the top-level of testing
>   to have a '# Subtest' line as discussed in v1 but this breaks the
>   missing test plan test. So I think it would be best to add this ability
>   at a later time or after top-level test name and result lines are
>   discussed for KTAP v2.

Makes sense to me.

>         message =3D test.name
> +       if message !=3D "":
> +               # Add a leading space before the subtest counts only if a=
 test name
> +               # is provided using a "# Subtest" header line.
> +               message +=3D " "
>         if test.expected_count:
>                 if test.expected_count =3D=3D 1:
> -                       message +=3D ' (1 subtest)'
> +                       message +=3D '(1 subtest)'

Thanks, I like this output a lot better than having "Test suite" as a
placeholder name.
Tested this out by tweaking some kunit output locally and I get

[12:39:11] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D (4 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[12:39:11] [PASSED] parse_filter_test
[12:39:11] [PASSED] filter_suites_test
[12:39:11] [PASSED] filter_suites_test_glob_test
[12:39:11] [PASSED] filter_suites_to_empty_test
[12:39:11] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] kunit_exe=
cutor_test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>                 else:
> -                       message +=3D f' ({test.expected_count} subtests)'
> +                       message +=3D f'({test.expected_count} subtests)'
>         stdout.print_with_timestamp(format_test_divider(message, len(mess=
age)))
>
>  def print_log(log: Iterable[str]) -> None:
> @@ -647,7 +653,7 @@ def bubble_up_test_results(test: Test) -> None:
>         elif test.counts.get_status() =3D=3D TestStatus.TEST_CRASHED:
>                 test.status =3D TestStatus.TEST_CRASHED
>
> -def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> =
Test:
> +def parse_test(lines: LineStream, expected_num: int, log: List[str], is_=
subtest: bool) -> Test:
>         """
>         Finds next test to parse in LineStream, creates new Test object,
>         parses any subtests of the test, populates Test object with all
> @@ -665,15 +671,32 @@ def parse_test(lines: LineStream, expected_num: int=
, log: List[str]) -> Test:
>         1..4
>         [subtests]
>
> -       - Subtest header line
> +       - Subtest header (must include either the KTAP version line or
> +         "# Subtest" header line)
>
> -       Example:
> +       Example (preferred format with both KTAP version line and
> +       "# Subtest" line):
> +
> +       KTAP version 1
> +       # Subtest: name
> +       1..3
> +       [subtests]
> +       ok 1 name
> +
> +       Example (only "# Subtest" line):
>
>         # Subtest: name
>         1..3
>         [subtests]
>         ok 1 name
>
> +       Example (only KTAP version line, compliant with KTAP v1 spec):
> +
> +       KTAP version 1
> +       1..3
> +       [subtests]
> +       ok 1 name
> +
>         - Test result line
>
>         Example:
> @@ -685,28 +708,29 @@ def parse_test(lines: LineStream, expected_num: int=
, log: List[str]) -> Test:
>         expected_num - expected test number for test to be parsed
>         log - list of strings containing any preceding diagnostic lines
>                 corresponding to the current test
> +       is_subtest - boolean indicating whether test is a subtest
>
>         Return:
>         Test object populated with characteristics and any subtests
>         """
>         test =3D Test()
>         test.log.extend(log)
> -       parent_test =3D False
> -       main =3D parse_ktap_header(lines, test)
> -       if main:
> -               # If KTAP/TAP header is found, attempt to parse
> +       if not is_subtest:
> +               # If parsing the main/top-level test, parse KTAP version =
line and
>                 # test plan
>                 test.name =3D "main"
> +               ktap_line =3D parse_ktap_header(lines, test)
>                 parse_test_plan(lines, test)
>                 parent_test =3D True
>         else:
> -               # If KTAP/TAP header is not found, test must be subtest
> -               # header or test result line so parse attempt to parser
> -               # subtest header
> -               parent_test =3D parse_test_header(lines, test)
> +               # If not the main test, attempt to parse a test header co=
ntatining

typo: contatin =3D> contain

> +               # the KTAP version line and/or subtest header line
> +               ktap_line =3D parse_ktap_header(lines, test)
> +               subtest_line =3D parse_test_header(lines, test)
> +               parent_test =3D (ktap_line or subtest_line)

LGTM (this is where we changed to parse the KTAP header before " # Subtest"=
).

Optional: do we want to extend kunit_tool_test.py to validate this logic to=
o?
E.g. given input like

KTAP version 1
1..1
  KTAP version 1
  # Subtest: suite
  1..1
  ok 1 - test
ok 1 - subtest

we could assert that the parsed output contains "suite (1 subtest)"

i.e.
self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))

Daniel
