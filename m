Return-Path: <linux-kselftest+bounces-21909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B289C690F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 07:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 362C9B21454
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 06:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCC5171E6E;
	Wed, 13 Nov 2024 06:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQYfJMqy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4A110F1
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731477953; cv=none; b=LnnkuOPCbsseCp/xjWI2SDdVn1iTpd1FK9KGw2H96faJwMfZwLzOG0sHTC4etq9KV3S2orMUs0bgaI8dsyq+EBzwmNtWPLNzJ9BW4fG4VVlLB/gp5KkrBuvvTxnsw0AhrxmSC+dxulmYNIkQhjwWtD+Vw4kRqXfJV/4l1E8iAwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731477953; c=relaxed/simple;
	bh=s0MFGgfaycOdVkNnnmVNyoy9I3sZ8cG1fLtGdQjaq4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxK7XZsyA4YVxYQKSEdxPmDtvSDgOawm+R6VZ4eUaXQGSAN6RtumSwB/JQy8e6fggmSua7Orkjnn8BH7p09Z0hDkKWDuT5dZjw/+8c4Zx49g9RMot6Q0M6aK8ja8uFXNFD9jCWP5KZFM/nnrJuiLn+BSTTjrWdxIzD/RZ6HwbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQYfJMqy; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4608e389407so82877621cf.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2024 22:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731477948; x=1732082748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fc4PW+jno7ie8vwHuwO4p+vlWYDHlV3Jav95QSV+8vE=;
        b=fQYfJMqyCUDObxoK8eAOORDkNrjO+I8iua/hO//4ByK99yzy8/E9M1YzzdJFKHODrQ
         QO4NXPnEWCK8SGg5RX7xI379aL+BdDWld54joNMY7a/OM78AyI6YQOcxkCIuYEdRTcKG
         U07BgCrTasmiP3hS2zCgktba7sZKXLHdt4bCJhg4mjkzttXEmpJ2DTTKofZe9Pie4kV7
         ulWXV8JjyyrdpXwDV24GDw81vooznhJRau4vDEj39btClVhHXeh2t0YrMsG++5S6I68v
         Q1XpOJXc4DrpaGKUzGB8eGTCPQMecsGqK3QVvonCWumL90FDXShwtL/JMpQrFjM6IKuN
         okfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731477948; x=1732082748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fc4PW+jno7ie8vwHuwO4p+vlWYDHlV3Jav95QSV+8vE=;
        b=SwTxMBHjJlJYB6gbAHrebvj+cFgl25sLtnRlh/snxNuwvpUPWDO9MXMRlwgfJA0sHS
         lleqrokSiSNm6lbxRvrTm4uamoBzJ97zS9Sf62Jeg1TBf26IsLa5DMniOO8uhe/SGhM8
         9Q+9zaX/4/lcdtwtso30mTKkK2I5DtoqQgj79MDmzPtREzSq1ALyHR+SQfBut2v/hw9E
         ZexW2qUJFsIKwQ2uexzRo3M9xfToTuYuUxboNq4QL68YWj0N/h+++xrW8/2E2Fdoc+n4
         jq9BITriWuO8wj9isKYgoSEThweGXjwihOYjuhl9kbdVqpaKfVMEkPbGsParQGL7zHz0
         R55g==
X-Forwarded-Encrypted: i=1; AJvYcCW2xoTVAyycsWztQ9b6y7C7H802xFliqgigMlkQjFBX+LLNf5T4Ds8kALL7cIc2n/snAPOwXNRqThfuFlZEISs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnvuc5BtHyGnagvON08HAiZCgR34xmqHTtDDJKH3q/zaRM4Sa0
	JNiK3Ekd8YwtbnODunYMmsAJ7buy9Tze4crzqI8rPeMF3RJyFLx2tc4OXGwOaFqwWOFMBFc0CZz
	SUhVbKgFD7nbtSuYnZUKeNg+3kZQ4cbS6BdMn
X-Google-Smtp-Source: AGHT+IE3zJ3yP/S0/TRCWaf8mXaoiuidocUNQNV0R4ss6UE+jnNXD2O6RXRoxcFQua4gPUvK1hy2/r4ytyv2ACnoHxM=
X-Received: by 2002:a05:6214:33c7:b0:6d1:8552:a732 with SMTP id
 6a1803df08f44-6d39e1554admr259190176d6.4.1731477947195; Tue, 12 Nov 2024
 22:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028224242.3304844-1-rmoar@google.com>
In-Reply-To: <20241028224242.3304844-1-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Wed, 13 Nov 2024 14:05:32 +0800
Message-ID: <CABVgOS=DnPaKSruJgt3X7s0Pk8k=QpucS_NA=5QYkOx4OiWBvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: Only print the summary
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, brendanhiggins@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000006e9440626c520bf"

--00000000000006e9440626c520bf
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Oct 2024 at 06:43, Rae Moar <rmoar@google.com> wrote:
>
> From: David Gow <davidgow@google.com>
>
> Allow only printing the summary at the end of a test run, rather than all
> individual test results. This summary will list a few failing tests if
> there are any.
>
> To use:
>
> ./tools/testing/kunit/kunit.py run --summary
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---

Thanks very much for tidying this up for me. I like this much better
than the hack with /dev/null (and with the tests passing).

There are a couple of issues, though, with mypy and the _is_color
variable. Both to do with the Printer class, details below. The
_is_color one is a showstopper, I'm afraid. --summary isn't working at
all here.

Cheers,
-- David

>  tools/testing/kunit/kunit.py           |  18 +++-
>  tools/testing/kunit/kunit_parser.py    | 109 +++++++++++++------------
>  tools/testing/kunit/kunit_printer.py   |   7 +-
>  tools/testing/kunit/kunit_tool_test.py |  55 +++++++------
>  4 files changed, 107 insertions(+), 82 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index bc74088c458a..27c55a7fc1a0 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -23,7 +23,7 @@ from typing import Iterable, List, Optional, Sequence, Tuple
>  import kunit_json
>  import kunit_kernel
>  import kunit_parser
> -from kunit_printer import stdout
> +from kunit_printer import stdout, null_printer
>
>  class KunitStatus(Enum):
>         SUCCESS = auto()
> @@ -49,6 +49,7 @@ class KunitBuildRequest(KunitConfigRequest):
>  class KunitParseRequest:
>         raw_output: Optional[str]
>         json: Optional[str]
> +       summary: bool
>
>  @dataclass
>  class KunitExecRequest(KunitParseRequest):
> @@ -235,11 +236,16 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
>                 parse_time = time.time() - parse_start
>                 return KunitResult(KunitStatus.SUCCESS, parse_time), fake_test
>
> +       default_printer = stdout
> +       if request.summary:
> +               default_printer = null_printer
>
>         # Actually parse the test results.
> -       test = kunit_parser.parse_run_tests(input_data)
> +       test = kunit_parser.parse_run_tests(input_data, default_printer)
>         parse_time = time.time() - parse_start
>
> +       kunit_parser.print_summary_line(test, stdout)
> +
>         if request.json:
>                 json_str = kunit_json.get_json_result(
>                                         test=test,
> @@ -413,6 +419,10 @@ def add_parse_opts(parser: argparse.ArgumentParser) -> None:
>                             help='Prints parsed test results as JSON to stdout or a file if '
>                             'a filename is specified. Does nothing if --raw_output is set.',
>                             type=str, const='stdout', default=None, metavar='FILE')
> +       parser.add_argument('--summary',
> +                           help='Prints only the summary line for parsed test results.'
> +                               'Does nothing if --raw_output is set.',
> +                           action='store_true')
>
>
>  def tree_from_args(cli_args: argparse.Namespace) -> kunit_kernel.LinuxSourceTree:
> @@ -448,6 +458,7 @@ def run_handler(cli_args: argparse.Namespace) -> None:
>                                         jobs=cli_args.jobs,
>                                         raw_output=cli_args.raw_output,
>                                         json=cli_args.json,
> +                                       summary=cli_args.summary,
>                                         timeout=cli_args.timeout,
>                                         filter_glob=cli_args.filter_glob,
>                                         filter=cli_args.filter,
> @@ -495,6 +506,7 @@ def exec_handler(cli_args: argparse.Namespace) -> None:
>         exec_request = KunitExecRequest(raw_output=cli_args.raw_output,
>                                         build_dir=cli_args.build_dir,
>                                         json=cli_args.json,
> +                                       summary=cli_args.summary,
>                                         timeout=cli_args.timeout,
>                                         filter_glob=cli_args.filter_glob,
>                                         filter=cli_args.filter,
> @@ -520,7 +532,7 @@ def parse_handler(cli_args: argparse.Namespace) -> None:
>         # We know nothing about how the result was created!
>         metadata = kunit_json.Metadata()
>         request = KunitParseRequest(raw_output=cli_args.raw_output,
> -                                       json=cli_args.json)
> +                                       json=cli_args.json, summary=cli_args.summary)
>         result, _ = parse_tests(request, metadata, kunit_output)
>         if result.status != KunitStatus.SUCCESS:
>                 sys.exit(1)
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index ce34be15c929..732f448263de 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -17,7 +17,7 @@ import textwrap
>  from enum import Enum, auto
>  from typing import Iterable, Iterator, List, Optional, Tuple
>
> -from kunit_printer import stdout
> +from kunit_printer import Printer, stdout
>
>  class Test:
>         """
> @@ -54,10 +54,10 @@ class Test:
>                 """Returns string representation of a Test class object."""
>                 return str(self)
>
> -       def add_error(self, error_message: str) -> None:
> +       def add_error(self, printer: Printer, error_message: str) -> None:
>                 """Records an error that occurred while parsing this test."""
>                 self.counts.errors += 1
> -               stdout.print_with_timestamp(stdout.red('[ERROR]') + f' Test: {self.name}: {error_message}')
> +               printer.print_with_timestamp(stdout.red('[ERROR]') + f' Test: {self.name}: {error_message}')
>
>         def ok_status(self) -> bool:
>                 """Returns true if the status was ok, i.e. passed or skipped."""
> @@ -251,7 +251,7 @@ KTAP_VERSIONS = [1]
>  TAP_VERSIONS = [13, 14]
>
>  def check_version(version_num: int, accepted_versions: List[int],
> -                       version_type: str, test: Test) -> None:
> +                       version_type: str, test: Test, printer: Printer) -> None:
>         """
>         Adds error to test object if version number is too high or too
>         low.
> @@ -263,13 +263,14 @@ def check_version(version_num: int, accepted_versions: List[int],
>         version_type - 'KTAP' or 'TAP' depending on the type of
>                 version line.
>         test - Test object for current test being parsed
> +       printer - Printer object to output error
>         """
>         if version_num < min(accepted_versions):
> -               test.add_error(f'{version_type} version lower than expected!')
> +               test.add_error(printer, f'{version_type} version lower than expected!')
>         elif version_num > max(accepted_versions):
> -               test.add_error(f'{version_type} version higer than expected!')
> +               test.add_error(printer, f'{version_type} version higer than expected!')
>
> -def parse_ktap_header(lines: LineStream, test: Test) -> bool:
> +def parse_ktap_header(lines: LineStream, test: Test, printer: Printer) -> bool:
>         """
>         Parses KTAP/TAP header line and checks version number.
>         Returns False if fails to parse KTAP/TAP header line.
> @@ -281,6 +282,7 @@ def parse_ktap_header(lines: LineStream, test: Test) -> bool:
>         Parameters:
>         lines - LineStream of KTAP output to parse
>         test - Test object for current test being parsed
> +       printer - Printer object to output results
>
>         Return:
>         True if successfully parsed KTAP/TAP header line
> @@ -289,10 +291,10 @@ def parse_ktap_header(lines: LineStream, test: Test) -> bool:
>         tap_match = TAP_START.match(lines.peek())
>         if ktap_match:
>                 version_num = int(ktap_match.group(1))
> -               check_version(version_num, KTAP_VERSIONS, 'KTAP', test)
> +               check_version(version_num, KTAP_VERSIONS, 'KTAP', test, printer)
>         elif tap_match:
>                 version_num = int(tap_match.group(1))
> -               check_version(version_num, TAP_VERSIONS, 'TAP', test)
> +               check_version(version_num, TAP_VERSIONS, 'TAP', test, printer)
>         else:
>                 return False
>         lines.pop()
> @@ -380,7 +382,7 @@ def peek_test_name_match(lines: LineStream, test: Test) -> bool:
>         return name == test.name
>
>  def parse_test_result(lines: LineStream, test: Test,
> -                       expected_num: int) -> bool:
> +                       expected_num: int, printer: Printer) -> bool:
>         """
>         Parses test result line and stores the status and name in the test
>         object. Reports an error if the test number does not match expected
> @@ -398,6 +400,7 @@ def parse_test_result(lines: LineStream, test: Test,
>         lines - LineStream of KTAP output to parse
>         test - Test object for current test being parsed
>         expected_num - expected test number for current test
> +       printer - Printer object to output results
>
>         Return:
>         True if successfully parsed a test result line.
> @@ -420,7 +423,7 @@ def parse_test_result(lines: LineStream, test: Test,
>         # Check test num
>         num = int(match.group(2))
>         if num != expected_num:
> -               test.add_error(f'Expected test number {expected_num} but found {num}')
> +               test.add_error(printer, f'Expected test number {expected_num} but found {num}')
>
>         # Set status of test object
>         status = match.group(1)
> @@ -486,7 +489,7 @@ def format_test_divider(message: str, len_message: int) -> str:
>                 len_2 = difference - len_1
>         return ('=' * len_1) + f' {message} ' + ('=' * len_2)
>
> -def print_test_header(test: Test) -> None:
> +def print_test_header(test: Test, printer: Printer) -> None:
>         """
>         Prints test header with test name and optionally the expected number
>         of subtests.
> @@ -496,6 +499,7 @@ def print_test_header(test: Test) -> None:
>
>         Parameters:
>         test - Test object representing current test being printed
> +       printer - Printer object to output results
>         """
>         message = test.name
>         if message != "":
> @@ -507,15 +511,15 @@ def print_test_header(test: Test) -> None:
>                         message += '(1 subtest)'
>                 else:
>                         message += f'({test.expected_count} subtests)'
> -       stdout.print_with_timestamp(format_test_divider(message, len(message)))
> +       printer.print_with_timestamp(format_test_divider(message, len(message)))
>
> -def print_log(log: Iterable[str]) -> None:
> +def print_log(log: Iterable[str], printer: Printer) -> None:
>         """Prints all strings in saved log for test in yellow."""
>         formatted = textwrap.dedent('\n'.join(log))
>         for line in formatted.splitlines():
> -               stdout.print_with_timestamp(stdout.yellow(line))
> +               printer.print_with_timestamp(printer.yellow(line))
>
> -def format_test_result(test: Test) -> str:
> +def format_test_result(test: Test, printer: Printer) -> str:
>         """
>         Returns string with formatted test result with colored status and test
>         name.
> @@ -525,23 +529,24 @@ def format_test_result(test: Test) -> str:
>
>         Parameters:
>         test - Test object representing current test being printed
> +       printer - Printer object to output results
>
>         Return:
>         String containing formatted test result
>         """
>         if test.status == TestStatus.SUCCESS:
> -               return stdout.green('[PASSED] ') + test.name
> +               return printer.green('[PASSED] ') + test.name
>         if test.status == TestStatus.SKIPPED:
> -               return stdout.yellow('[SKIPPED] ') + test.name
> +               return printer.yellow('[SKIPPED] ') + test.name
>         if test.status == TestStatus.NO_TESTS:
> -               return stdout.yellow('[NO TESTS RUN] ') + test.name
> +               return printer.yellow('[NO TESTS RUN] ') + test.name
>         if test.status == TestStatus.TEST_CRASHED:
> -               print_log(test.log)
> +               print_log(test.log, printer)
>                 return stdout.red('[CRASHED] ') + test.name
> -       print_log(test.log)
> -       return stdout.red('[FAILED] ') + test.name
> +       print_log(test.log, printer)
> +       return printer.red('[FAILED] ') + test.name
>
> -def print_test_result(test: Test) -> None:
> +def print_test_result(test: Test, printer: Printer) -> None:
>         """
>         Prints result line with status of test.
>
> @@ -550,10 +555,11 @@ def print_test_result(test: Test) -> None:
>
>         Parameters:
>         test - Test object representing current test being printed
> +       printer - Printer object
>         """
> -       stdout.print_with_timestamp(format_test_result(test))
> +       printer.print_with_timestamp(format_test_result(test, printer))
>
> -def print_test_footer(test: Test) -> None:
> +def print_test_footer(test: Test, printer: Printer) -> None:
>         """
>         Prints test footer with status of test.
>
> @@ -562,10 +568,11 @@ def print_test_footer(test: Test) -> None:
>
>         Parameters:
>         test - Test object representing current test being printed
> +       printer - Printer object to output results
>         """
> -       message = format_test_result(test)
> -       stdout.print_with_timestamp(format_test_divider(message,
> -               len(message) - stdout.color_len()))
> +       message = format_test_result(test, printer)
> +       printer.print_with_timestamp(format_test_divider(message,
> +               len(message) - printer.color_len()))
>
>
>
> @@ -601,7 +608,7 @@ def _summarize_failed_tests(test: Test) -> str:
>         return 'Failures: ' + ', '.join(failures)
>
>
> -def print_summary_line(test: Test) -> None:
> +def print_summary_line(test: Test, printer: Printer) -> None:
>         """
>         Prints summary line of test object. Color of line is dependent on
>         status of test. Color is green if test passes, yellow if test is
> @@ -614,6 +621,7 @@ def print_summary_line(test: Test) -> None:
>         Errors: 0"
>
>         test - Test object representing current test being printed
> +       printer - Printer object to output results
>         """
>         if test.status == TestStatus.SUCCESS:
>                 color = stdout.green
> @@ -621,7 +629,7 @@ def print_summary_line(test: Test) -> None:
>                 color = stdout.yellow
>         else:
>                 color = stdout.red
> -       stdout.print_with_timestamp(color(f'Testing complete. {test.counts}'))
> +       printer.print_with_timestamp(color(f'Testing complete. {test.counts}'))
>
>         # Summarize failures that might have gone off-screen since we had a lot
>         # of tests (arbitrarily defined as >=100 for now).
> @@ -630,7 +638,7 @@ def print_summary_line(test: Test) -> None:
>         summarized = _summarize_failed_tests(test)
>         if not summarized:
>                 return
> -       stdout.print_with_timestamp(color(summarized))
> +       printer.print_with_timestamp(color(summarized))
>
>  # Other methods:
>
> @@ -654,7 +662,7 @@ def bubble_up_test_results(test: Test) -> None:
>         elif test.counts.get_status() == TestStatus.TEST_CRASHED:
>                 test.status = TestStatus.TEST_CRASHED
>
> -def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest: bool) -> Test:
> +def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest: bool, printer: Printer) -> Test:
>         """
>         Finds next test to parse in LineStream, creates new Test object,
>         parses any subtests of the test, populates Test object with all
> @@ -710,6 +718,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
>         log - list of strings containing any preceding diagnostic lines
>                 corresponding to the current test
>         is_subtest - boolean indicating whether test is a subtest
> +       printer - Printer object to output results
>
>         Return:
>         Test object populated with characteristics and any subtests
> @@ -725,14 +734,14 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
>                 # If parsing the main/top-level test, parse KTAP version line and
>                 # test plan
>                 test.name = "main"
> -               ktap_line = parse_ktap_header(lines, test)
> +               ktap_line = parse_ktap_header(lines, test, printer)
>                 test.log.extend(parse_diagnostic(lines))
>                 parse_test_plan(lines, test)
>                 parent_test = True
>         else:
>                 # If not the main test, attempt to parse a test header containing
>                 # the KTAP version line and/or subtest header line
> -               ktap_line = parse_ktap_header(lines, test)
> +               ktap_line = parse_ktap_header(lines, test, printer)
>                 subtest_line = parse_test_header(lines, test)
>                 parent_test = (ktap_line or subtest_line)
>                 if parent_test:
> @@ -740,7 +749,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
>                         # to parse test plan and print test header
>                         test.log.extend(parse_diagnostic(lines))
>                         parse_test_plan(lines, test)
> -                       print_test_header(test)
> +                       print_test_header(test, printer)
>         expected_count = test.expected_count
>         subtests = []
>         test_num = 1
> @@ -758,16 +767,16 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
>                                 # If parser reaches end of test before
>                                 # parsing expected number of subtests, print
>                                 # crashed subtest and record error
> -                               test.add_error('missing expected subtest!')
> +                               test.add_error(printer, 'missing expected subtest!')
>                                 sub_test.log.extend(sub_log)
>                                 test.counts.add_status(
>                                         TestStatus.TEST_CRASHED)
> -                               print_test_result(sub_test)
> +                               print_test_result(sub_test, printer)
>                         else:
>                                 test.log.extend(sub_log)
>                                 break
>                 else:
> -                       sub_test = parse_test(lines, test_num, sub_log, True)
> +                       sub_test = parse_test(lines, test_num, sub_log, True, printer)
>                 subtests.append(sub_test)
>                 test_num += 1
>         test.subtests = subtests
> @@ -775,51 +784,51 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
>                 # If not main test, look for test result line
>                 test.log.extend(parse_diagnostic(lines))
>                 if test.name != "" and not peek_test_name_match(lines, test):
> -                       test.add_error('missing subtest result line!')
> +                       test.add_error(printer, 'missing subtest result line!')
>                 else:
> -                       parse_test_result(lines, test, expected_num)
> +                       parse_test_result(lines, test, expected_num, printer)
>
>         # Check for there being no subtests within parent test
>         if parent_test and len(subtests) == 0:
>                 # Don't override a bad status if this test had one reported.
>                 # Assumption: no subtests means CRASHED is from Test.__init__()
>                 if test.status in (TestStatus.TEST_CRASHED, TestStatus.SUCCESS):
> -                       print_log(test.log)
> +                       print_log(test.log, printer)
>                         test.status = TestStatus.NO_TESTS
> -                       test.add_error('0 tests run!')
> +                       test.add_error(printer, '0 tests run!')
>
>         # Add statuses to TestCounts attribute in Test object
>         bubble_up_test_results(test)
>         if parent_test and is_subtest:
>                 # If test has subtests and is not the main test object, print
>                 # footer.
> -               print_test_footer(test)
> +               print_test_footer(test, printer)
>         elif is_subtest:
> -               print_test_result(test)
> +               print_test_result(test, printer)
>         return test
>
> -def parse_run_tests(kernel_output: Iterable[str]) -> Test:
> +def parse_run_tests(kernel_output: Iterable[str], printer: Printer) -> Test:
>         """
>         Using kernel output, extract KTAP lines, parse the lines for test
>         results and print condensed test results and summary line.
>
>         Parameters:
>         kernel_output - Iterable object contains lines of kernel output
> +       printer - Printer object to output results
>
>         Return:
>         Test - the main test object with all subtests.
>         """
> -       stdout.print_with_timestamp(DIVIDER)
> +       printer.print_with_timestamp(DIVIDER)
>         lines = extract_tap_lines(kernel_output)
>         test = Test()
>         if not lines:
>                 test.name = '<missing>'
> -               test.add_error('Could not find any KTAP output. Did any KUnit tests run?')
> +               test.add_error(printer, 'Could not find any KTAP output. Did any KUnit tests run?')
>                 test.status = TestStatus.FAILURE_TO_PARSE_TESTS
>         else:
> -               test = parse_test(lines, 0, [], False)
> +               test = parse_test(lines, 0, [], False, printer)
>                 if test.status != TestStatus.NO_TESTS:
>                         test.status = test.counts.get_status()
> -       stdout.print_with_timestamp(DIVIDER)
> -       print_summary_line(test)
> +       printer.print_with_timestamp(DIVIDER)
>         return test
> diff --git a/tools/testing/kunit/kunit_printer.py b/tools/testing/kunit/kunit_printer.py
> index 015adf87dc2c..2c55b4b67bfc 100644
> --- a/tools/testing/kunit/kunit_printer.py
> +++ b/tools/testing/kunit/kunit_printer.py
> @@ -17,10 +17,12 @@ class Printer:
>
>         def __init__(self, output: typing.IO[str]):

This makes mypy complain:
> kunit_printer.py:51: error: Argument 1 to "Printer" has incompatible type "None"; expected "IO[str]"  [arg-type]
> Found 1 error in 1 file (checked 9 source files)

Presumably there's a way to mark this as optional...

>                 self._output = output
> -               self._use_color = output.isatty()
> +               if output is not None:
> +                       self._use_color = output.isatty()

This breaks use of color() -- and therefore everything when --summary is passed.

For example:
> $ qemu-system-m68k -nodefaults -m 1024 -kernel .kunit-m68k/vmlinux -append 'kunit.enable=1 console=hvc0 kunit_shutdown=reboot' -no-reboot -nographic -serial stdio -machine virt
> Traceback (most recent call last):
>   File "/usr/local/google/home/davidgow/linux-kselftest/tools/testing/kunit/./kunit.py", line 613, in <module>
>     main(sys.argv[1:])
>   File "/usr/local/google/home/davidgow/linux-kselftest/tools/testing/kunit/./kunit.py", line 609, in main
>     subcomand_handler(cli_args)
>   File "/usr/local/google/home/davidgow/linux-kselftest/tools/testing/kunit/./kunit.py", line 478, in run_handler
>     result = run_tests(linux, request)
>              ^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/google/home/davidgow/linux-kselftest/tools/testing/kunit/./kunit.py", line 281, in run_tests
>     exec_result = exec_tests(linux, request)
>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/google/home/davidgow/linux-kselftest/tools/testing/kunit/./kunit.py", line 198, in exec_tests
>     _, test_result = parse_tests(request, metadata, run_result)
>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/google/home/davidgow/linux-kselftest/tools/testing/kunit/./kunit.py", line 245, in parse_tests
>     test = kunit_parser.parse_run_tests(input_data, default_printer)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/google/home/davidgow/linux-kselftest/tools/testing/kunit/kunit_parser.py", line 855, in parse_run_tests
>     test = parse_test(lines, 0, [], False, printer)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/google/home/davidgow/linux-kselftest/tools/testing/kunit/kunit_parser.py", line 804, in parse_test
>     sub_test = parse_test(lines, test_num, sub_log, True, printer)
>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/google/home/davidgow/linux-kselftest/tools/testing/kunit/kunit_parser.py", line 804, in parse_test
>     sub_test = parse_test(lines, test_num, sub_log, True, printer)
>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/google/home/davidgow/linux-kselftest/tools/testing/kunit/kunit_parser.py", line 832, in parse_test
>     print_test_result(test, printer)
>   File "/usr/local/google/home/davidgow/linux-kselftest/tools/testing/kunit/kunit_parser.py", line 560, in print_test_result
>     printer.print_with_timestamp(format_test_result(test, printer))
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/google/home/davidgow/linux-kselftest/tools/testing/kunit/kunit_parser.py", line 538, in format_test_result
>     return printer.green('[PASSED] ') + test.name
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/google/home/davidgow/linux-kselftest/tools/testing/kunit/kunit_printer.py", line 43, in green
>     return self._color('\033[1;32m', text)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/google/home/davidgow/linux-kselftest/tools/testing/kunit/kunit_printer.py", line 32, in _color
>     if not self._use_color:
>            ^^^^^^^^^^^^^^^
> AttributeError: 'Printer' object has no attribute '_use_color'


Can we just set _use_color to false here, instead of leaving it unset?

>
>         def print(self, message: str) -> None:
> -               print(message, file=self._output)
> +               if self._output is not None:
> +                       print(message, file=self._output)
>
>         def print_with_timestamp(self, message: str) -> None:
>                 ts = datetime.datetime.now().strftime('%H:%M:%S')
> @@ -46,3 +48,4 @@ class Printer:
>
>  # Provides a default instance that prints to stdout
>  stdout = Printer(sys.stdout)
> +null_printer = Printer(None)
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 2beb7327e53f..02aa296d8850 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -23,6 +23,7 @@ import kunit_parser
>  import kunit_kernel
>  import kunit_json
>  import kunit
> +from kunit_printer import stdout
>
>  test_tmpdir = ''
>  abs_test_data_dir = ''
> @@ -139,28 +140,28 @@ class KUnitParserTest(unittest.TestCase):
>         def test_parse_successful_test_log(self):
>                 all_passed_log = test_data_path('test_is_test_passed-all_passed.log')
>                 with open(all_passed_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
>                 self.assertEqual(result.counts.errors, 0)
>
>         def test_parse_successful_nested_tests_log(self):
>                 all_passed_log = test_data_path('test_is_test_passed-all_passed_nested.log')
>                 with open(all_passed_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
>                 self.assertEqual(result.counts.errors, 0)
>
>         def test_kselftest_nested(self):
>                 kselftest_log = test_data_path('test_is_test_passed-kselftest.log')
>                 with open(kselftest_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
>                 self.assertEqual(result.counts.errors, 0)
>
>         def test_parse_failed_test_log(self):
>                 failed_log = test_data_path('test_is_test_passed-failure.log')
>                 with open(failed_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
>                 self.assertEqual(result.counts.errors, 0)
>
> @@ -168,7 +169,7 @@ class KUnitParserTest(unittest.TestCase):
>                 empty_log = test_data_path('test_is_test_passed-no_tests_run_no_header.log')
>                 with open(empty_log) as file:
>                         result = kunit_parser.parse_run_tests(
> -                               kunit_parser.extract_tap_lines(file.readlines()))
> +                               kunit_parser.extract_tap_lines(file.readlines()), stdout)
>                 self.assertEqual(0, len(result.subtests))
>                 self.assertEqual(kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS, result.status)
>                 self.assertEqual(result.counts.errors, 1)
> @@ -179,7 +180,7 @@ class KUnitParserTest(unittest.TestCase):
>                 with open(missing_plan_log) as file:
>                         result = kunit_parser.parse_run_tests(
>                                 kunit_parser.extract_tap_lines(
> -                               file.readlines()))
> +                               file.readlines()), stdout)
>                 # A missing test plan is not an error.
>                 self.assertEqual(result.counts, kunit_parser.TestCounts(passed=10, errors=0))
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
> @@ -188,7 +189,7 @@ class KUnitParserTest(unittest.TestCase):
>                 header_log = test_data_path('test_is_test_passed-no_tests_run_with_header.log')
>                 with open(header_log) as file:
>                         result = kunit_parser.parse_run_tests(
> -                               kunit_parser.extract_tap_lines(file.readlines()))
> +                               kunit_parser.extract_tap_lines(file.readlines()), stdout)
>                 self.assertEqual(0, len(result.subtests))
>                 self.assertEqual(kunit_parser.TestStatus.NO_TESTS, result.status)
>                 self.assertEqual(result.counts.errors, 1)
> @@ -197,7 +198,7 @@ class KUnitParserTest(unittest.TestCase):
>                 no_plan_log = test_data_path('test_is_test_passed-no_tests_no_plan.log')
>                 with open(no_plan_log) as file:
>                         result = kunit_parser.parse_run_tests(
> -                               kunit_parser.extract_tap_lines(file.readlines()))
> +                               kunit_parser.extract_tap_lines(file.readlines()), stdout)
>                 self.assertEqual(0, len(result.subtests[0].subtests[0].subtests))
>                 self.assertEqual(
>                         kunit_parser.TestStatus.NO_TESTS,
> @@ -210,7 +211,7 @@ class KUnitParserTest(unittest.TestCase):
>                 print_mock = mock.patch('kunit_printer.Printer.print').start()
>                 with open(crash_log) as file:
>                         result = kunit_parser.parse_run_tests(
> -                               kunit_parser.extract_tap_lines(file.readlines()))
> +                               kunit_parser.extract_tap_lines(file.readlines()), stdout)
>                 print_mock.assert_any_call(StrContains('Could not find any KTAP output.'))
>                 print_mock.stop()
>                 self.assertEqual(0, len(result.subtests))
> @@ -219,7 +220,7 @@ class KUnitParserTest(unittest.TestCase):
>         def test_skipped_test(self):
>                 skipped_log = test_data_path('test_skip_tests.log')
>                 with open(skipped_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
>
>                 # A skipped test does not fail the whole suite.
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
> @@ -228,7 +229,7 @@ class KUnitParserTest(unittest.TestCase):
>         def test_skipped_all_tests(self):
>                 skipped_log = test_data_path('test_skip_all_tests.log')
>                 with open(skipped_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
>
>                 self.assertEqual(kunit_parser.TestStatus.SKIPPED, result.status)
>                 self.assertEqual(result.counts, kunit_parser.TestCounts(skipped=5))
> @@ -236,7 +237,7 @@ class KUnitParserTest(unittest.TestCase):
>         def test_ignores_hyphen(self):
>                 hyphen_log = test_data_path('test_strip_hyphen.log')
>                 with open(hyphen_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
>
>                 # A skipped test does not fail the whole suite.
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
> @@ -250,7 +251,7 @@ class KUnitParserTest(unittest.TestCase):
>         def test_ignores_prefix_printk_time(self):
>                 prefix_log = test_data_path('test_config_printk_time.log')
>                 with open(prefix_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
>                 self.assertEqual('kunit-resource-test', result.subtests[0].name)
>                 self.assertEqual(result.counts.errors, 0)
> @@ -258,7 +259,7 @@ class KUnitParserTest(unittest.TestCase):
>         def test_ignores_multiple_prefixes(self):
>                 prefix_log = test_data_path('test_multiple_prefixes.log')
>                 with open(prefix_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
>                 self.assertEqual('kunit-resource-test', result.subtests[0].name)
>                 self.assertEqual(result.counts.errors, 0)
> @@ -266,7 +267,7 @@ class KUnitParserTest(unittest.TestCase):
>         def test_prefix_mixed_kernel_output(self):
>                 mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
>                 with open(mixed_prefix_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
>                 self.assertEqual('kunit-resource-test', result.subtests[0].name)
>                 self.assertEqual(result.counts.errors, 0)
> @@ -274,7 +275,7 @@ class KUnitParserTest(unittest.TestCase):
>         def test_prefix_poundsign(self):
>                 pound_log = test_data_path('test_pound_sign.log')
>                 with open(pound_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
>                 self.assertEqual('kunit-resource-test', result.subtests[0].name)
>                 self.assertEqual(result.counts.errors, 0)
> @@ -282,7 +283,7 @@ class KUnitParserTest(unittest.TestCase):
>         def test_kernel_panic_end(self):
>                 panic_log = test_data_path('test_kernel_panic_interrupt.log')
>                 with open(panic_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.TEST_CRASHED, result.status)
>                 self.assertEqual('kunit-resource-test', result.subtests[0].name)
>                 self.assertGreaterEqual(result.counts.errors, 1)
> @@ -290,7 +291,7 @@ class KUnitParserTest(unittest.TestCase):
>         def test_pound_no_prefix(self):
>                 pound_log = test_data_path('test_pound_no_prefix.log')
>                 with open(pound_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
>                 self.assertEqual('kunit-resource-test', result.subtests[0].name)
>                 self.assertEqual(result.counts.errors, 0)
> @@ -310,7 +311,7 @@ class KUnitParserTest(unittest.TestCase):
>                         not ok 2 - test2
>                 not ok 1 - some_failed_suite
>                 """
> -               result = kunit_parser.parse_run_tests(output.splitlines())
> +               result = kunit_parser.parse_run_tests(output.splitlines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
>
>                 self.assertEqual(kunit_parser._summarize_failed_tests(result),
> @@ -319,7 +320,7 @@ class KUnitParserTest(unittest.TestCase):
>         def test_ktap_format(self):
>                 ktap_log = test_data_path('test_parse_ktap_output.log')
>                 with open(ktap_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
>                 self.assertEqual(result.counts, kunit_parser.TestCounts(passed=3))
>                 self.assertEqual('suite', result.subtests[0].name)
>                 self.assertEqual('case_1', result.subtests[0].subtests[0].name)
> @@ -328,13 +329,13 @@ class KUnitParserTest(unittest.TestCase):
>         def test_parse_subtest_header(self):
>                 ktap_log = test_data_path('test_parse_subtest_header.log')
>                 with open(ktap_log) as file:
> -                       kunit_parser.parse_run_tests(file.readlines())
> +                       kunit_parser.parse_run_tests(file.readlines(), stdout)
>                 self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
>
>         def test_parse_attributes(self):
>                 ktap_log = test_data_path('test_parse_attributes.log')
>                 with open(ktap_log) as file:
> -                       result = kunit_parser.parse_run_tests(file.readlines())
> +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
>
>                 # Test should pass with no errors
>                 self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=0))
> @@ -355,7 +356,7 @@ class KUnitParserTest(unittest.TestCase):
>                     Indented more.
>                 not ok 1 test1
>                 """
> -               result = kunit_parser.parse_run_tests(output.splitlines())
> +               result = kunit_parser.parse_run_tests(output.splitlines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
>
>                 self.print_mock.assert_any_call(StrContains('Test output.'))
> @@ -544,7 +545,7 @@ class KUnitJsonTest(unittest.TestCase):
>
>         def _json_for(self, log_file):
>                 with open(test_data_path(log_file)) as file:
> -                       test_result = kunit_parser.parse_run_tests(file)
> +                       test_result = kunit_parser.parse_run_tests(file, stdout)
>                         json_obj = kunit_json.get_json_result(
>                                 test=test_result,
>                                 metadata=kunit_json.Metadata())
> @@ -810,7 +811,7 @@ class KUnitMainTest(unittest.TestCase):
>                 self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
>
>                 got = kunit._list_tests(self.linux_source_mock,
> -                                    kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', '', None, None, 'suite', False, False))
> +                                    kunit.KunitExecRequest(None, None, False, '.kunit', 300, 'suite*', '', None, None, 'suite', False, False))
>                 self.assertEqual(got, want)
>                 # Should respect the user's filter glob when listing tests.
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> @@ -823,7 +824,7 @@ class KUnitMainTest(unittest.TestCase):
>
>                 # Should respect the user's filter glob when listing tests.
>                 mock_tests.assert_called_once_with(mock.ANY,
> -                                    kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*.test*', '', None, None, 'suite', False, False))
> +                                    kunit.KunitExecRequest(None, None, False, '.kunit', 300, 'suite*.test*', '', None, None, 'suite', False, False))
>                 self.linux_source_mock.run_kernel.assert_has_calls([
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', filter='', filter_action=None, timeout=300),
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', filter='', filter_action=None, timeout=300),
> @@ -836,7 +837,7 @@ class KUnitMainTest(unittest.TestCase):
>
>                 # Should respect the user's filter glob when listing tests.
>                 mock_tests.assert_called_once_with(mock.ANY,
> -                                    kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', '', None, None, 'test', False, False))
> +                                    kunit.KunitExecRequest(None, None, False, '.kunit', 300, 'suite*', '', None, None, 'test', False, False))
>                 self.linux_source_mock.run_kernel.assert_has_calls([
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', filter='', filter_action=None, timeout=300),
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', filter='', filter_action=None, timeout=300),
>
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> --
> 2.47.0.163.g1226f6d8fa-goog
>

--00000000000006e9440626c520bf
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgHdv+GFxNjeXq6pFUY188tZuwCy8R
KdNPOWPaGYDdmvswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MTEzMDYwNTQ4WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAAJ3PW1dArojABRY55a3tmV0ZxaojqoaAWXdo9dYMmnTQHw1
Cu2Ujt20P+42VS+eRyXJYihsCLFT8uUntoQsWOR4SI0QgzjDEG6+ZhX5gG/D7M4ofCmglaZOpaxu
Fp9RVFWElI6B+9uDRxgbKXffIVX/FUZw/gbs/Kti8YF22CZfmnKlybgBuSHOoTbsNFuULKWvYOLj
4jFltR/fm8leNjbo8pZrK684V2GSC0fwYFWAdDHqnoIVytCDvc/943drohZDZnddnBe+bsuzNKXN
ro2CKPrG7anYW6Ak69bfFFD3kx/TSMD+V5XKApnfbDmh61coD6OQ7LGO5K/eG25aAPA=
--00000000000006e9440626c520bf--

