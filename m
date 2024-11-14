Return-Path: <linux-kselftest+bounces-22003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B6A9C82D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 06:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3F71F22DD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 05:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F0B17C9E8;
	Thu, 14 Nov 2024 05:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSxsdYII"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B7F54723
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Nov 2024 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731563905; cv=none; b=o1evIZeegAngAcllo+iDeJ3+CTbHVdou+b5K+Mb9PY+NxPODcbS3HlTQIo+FoTDiuYscB23YcIlKskXCZcKLdcY1fCs7BV+slIPwKrHFsjGYtkdeL9ScUgwmJkGGQ/LYOD1V/dqVGKLDfhRt5mWDpmZFh1mZmrDRFhM5e83Zihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731563905; c=relaxed/simple;
	bh=IxILAW1PlEstYLuebV+hwv/XC8qK0VIDDiY4s6kOtwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2AfIhNgrq6hRUVKzmcRuyKXzgxcsuuFVtnYSNCbIVimjo3HgMpZqUx7ibluDx1yQVYlDHmEgvDYZC+kAECUiv0rwY4Y7iT6N3lGefDhuIlltZt3JUIuUzX/XzNIkt+Xl+53rWYKXcHoM/9mMMGCYFj4Dd75yHanNDCBSMz9E90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSxsdYII; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbe53a68b5so1545486d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 21:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731563903; x=1732168703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y3X1WWDQwXMo8DX2+2xjUJWoHroF646lOHnV2F+dC4k=;
        b=rSxsdYII3sU5E1bd8fKQYMRKATNnx/hIz83FJZ4o4fWUezPUZ/iwktXs2N58eV5JRb
         Nl13MR/raq1Gw2aBosdWIY5ztny8XAKjY6u500JohBR3zxKeJCvSP+ASW21CZ+9b8s82
         +XzgCv1q92nG+AoEs/lpGqKvR9jTrSJG5lSx/eqq4TEfC1eOw1aBtT5MRw+L2WlFdLAo
         fwQAO+aeuF6cVhD+U5OnAbiZSHuaA09woA+Tb4tzsVJOW5t77jKiKCyoLPqOrXyyxpW9
         tRXnkvzGzjHvru2MgVu7c8zvW3raRHWSqGoI4N9KajAqe4YKjG2bp7c/VwJvsQ8QiK1+
         y1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731563903; x=1732168703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3X1WWDQwXMo8DX2+2xjUJWoHroF646lOHnV2F+dC4k=;
        b=WPme5i3iXhIV5DxzzK0Ozm0wqqLLsgtd8FUES8JDfcGahDm0gJByiHct6LEqHLq5gY
         24nkZ18er9qczRVHF1JVBX2Iwtd3WLN86dDslvv+scxlGs9eoYCARXgJhyWufeMk/I6e
         JfK2T8YsSDAfINApPaVnD/g5bqoppsOJsjLLSvh0PrfVYsk84tDjjs3EJRVZRC2WTIFn
         8G3WLC/SD3A2Byae53iS+VXT/q8Ganjm99t60dpUjcuHH3vYl9OXz0PPizwWbnX5Ks3Q
         VIIuHdPamb9v59K+49KDK+ohuCxmdK8Rk7aoC5FB9wh114Lsz2Dl6miX6uTvauzSV6tG
         pIKA==
X-Forwarded-Encrypted: i=1; AJvYcCX+grUb7m+5Y6NQt9bDs828DXVeieD2NP7qsGKI5bilCWD2phIxFk/KCmUG3UQSfdPf432cvhQo+PBT7xnZ5t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLxbQtt0scu7E8p2RCYBsZHZtQmZfCJF1E1gEkPxV3qQFkXpG2
	oSiIw1+CnrPuOjFK7ZpA9E+v0uKpWb3LJ4NSAA9g42BWBKmIB6wQeOxnSdbgWY9rwEXvIhU0Y3r
	j7dVJdaMUVk6v0JrYtUo0uokuymswjYca2vGf
X-Google-Smtp-Source: AGHT+IEfey9oF8K5xHF9nUo0l11MxR68eHDdtR8GA/wmBq8Gvo3N05OdpW2NxEMJSLxLdPr3L/FslS2nvxqdUC64CZk=
X-Received: by 2002:a05:6214:4521:b0:6d3:45cb:40eb with SMTP id
 6a1803df08f44-6d3d008e9f8mr136419496d6.10.1731563902801; Wed, 13 Nov 2024
 21:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113222406.1590372-1-rmoar@google.com> <20241113222406.1590372-2-rmoar@google.com>
In-Reply-To: <20241113222406.1590372-2-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Thu, 14 Nov 2024 13:58:07 +0800
Message-ID: <CABVgOSm6Zya0KeutZppYkwuBW47TWgb-XBWGhnNw89y2bkHb_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: tool: print failed tests only
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, brendanhiggins@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005d28dc0626d923b4"

--0000000000005d28dc0626d923b4
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 06:24, Rae Moar <rmoar@google.com> wrote:
>
> Add flag --failed to kunit.py to print only failed tests. This printing
> is done after running is over.
>
> This patch also adds the method print_test() that will also print your
> Test object. Before, all printing of tests occurred during parsing. This
> method could be useful in the future when converting to/from KTAP to this
> pretty-print output.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Thanks very much. This series looks good to me, now.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit.py           | 14 ++++++++++++--
>  tools/testing/kunit/kunit_parser.py    | 25 +++++++++++++++++++++++++
>  tools/testing/kunit/kunit_tool_test.py |  6 +++---
>  3 files changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 27c55a7fc1a0..676fa99a8b19 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -50,6 +50,7 @@ class KunitParseRequest:
>         raw_output: Optional[str]
>         json: Optional[str]
>         summary: bool
> +       failed: bool
>
>  @dataclass
>  class KunitExecRequest(KunitParseRequest):
> @@ -237,13 +238,15 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
>                 return KunitResult(KunitStatus.SUCCESS, parse_time), fake_test
>
>         default_printer = stdout
> -       if request.summary:
> +       if request.summary or request.failed:
>                 default_printer = null_printer
>
>         # Actually parse the test results.
>         test = kunit_parser.parse_run_tests(input_data, default_printer)
>         parse_time = time.time() - parse_start
>
> +       if request.failed:
> +               kunit_parser.print_test(test, request.failed, stdout)
>         kunit_parser.print_summary_line(test, stdout)
>
>         if request.json:
> @@ -423,6 +426,10 @@ def add_parse_opts(parser: argparse.ArgumentParser) -> None:
>                             help='Prints only the summary line for parsed test results.'
>                                 'Does nothing if --raw_output is set.',
>                             action='store_true')
> +       parser.add_argument('--failed',
> +                           help='Prints only the failed parsed test results and summary line.'
> +                               'Does nothing if --raw_output is set.',
> +                           action='store_true')
>
>
>  def tree_from_args(cli_args: argparse.Namespace) -> kunit_kernel.LinuxSourceTree:
> @@ -459,6 +466,7 @@ def run_handler(cli_args: argparse.Namespace) -> None:
>                                         raw_output=cli_args.raw_output,
>                                         json=cli_args.json,
>                                         summary=cli_args.summary,
> +                                       failed=cli_args.failed,
>                                         timeout=cli_args.timeout,
>                                         filter_glob=cli_args.filter_glob,
>                                         filter=cli_args.filter,
> @@ -507,6 +515,7 @@ def exec_handler(cli_args: argparse.Namespace) -> None:
>                                         build_dir=cli_args.build_dir,
>                                         json=cli_args.json,
>                                         summary=cli_args.summary,
> +                                       failed=cli_args.failed,
>                                         timeout=cli_args.timeout,
>                                         filter_glob=cli_args.filter_glob,
>                                         filter=cli_args.filter,
> @@ -532,7 +541,8 @@ def parse_handler(cli_args: argparse.Namespace) -> None:
>         # We know nothing about how the result was created!
>         metadata = kunit_json.Metadata()
>         request = KunitParseRequest(raw_output=cli_args.raw_output,
> -                                       json=cli_args.json, summary=cli_args.summary)
> +                                       json=cli_args.json, summary=cli_args.summary,
> +                                       failed=cli_args.failed)
>         result, _ = parse_tests(request, metadata, kunit_output)
>         if result.status != KunitStatus.SUCCESS:
>                 sys.exit(1)
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 732f448263de..29fc27e8949b 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -574,7 +574,32 @@ def print_test_footer(test: Test, printer: Printer) -> None:
>         printer.print_with_timestamp(format_test_divider(message,
>                 len(message) - printer.color_len()))
>
> +def print_test(test: Test, failed_only: bool, printer: Printer) -> None:
> +       """
> +       Prints Test object to given printer. For a child test, the result line is
> +       printed. For a parent test, the test header, all child test results, and
> +       the test footer are all printed. If failed_only is true, only failed/crashed
> +       tests will be printed.
>
> +       Parameters:
> +       test - Test object to print
> +       failed_only - True if only failed/crashed tests should be printed.
> +       printer - Printer object to output results
> +       """
> +       if test.name == "main":
> +               printer.print_with_timestamp(DIVIDER)
> +               for subtest in test.subtests:
> +                       print_test(subtest, failed_only, printer)
> +               printer.print_with_timestamp(DIVIDER)
> +       elif test.subtests != []:
> +               if not failed_only or not test.ok_status():
> +                       print_test_header(test, printer)
> +                       for subtest in test.subtests:
> +                               print_test(subtest, failed_only, printer)
> +                       print_test_footer(test, printer)
> +       else:
> +               if not failed_only or not test.ok_status():
> +                       print_test_result(test, printer)
>
>  def _summarize_failed_tests(test: Test) -> str:
>         """Tries to summarize all the failing subtests in `test`."""
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 02aa296d8850..0bcb0cc002f8 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -811,7 +811,7 @@ class KUnitMainTest(unittest.TestCase):
>                 self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
>
>                 got = kunit._list_tests(self.linux_source_mock,
> -                                    kunit.KunitExecRequest(None, None, False, '.kunit', 300, 'suite*', '', None, None, 'suite', False, False))
> +                                    kunit.KunitExecRequest(None, None, False, False, '.kunit', 300, 'suite*', '', None, None, 'suite', False, False))
>                 self.assertEqual(got, want)
>                 # Should respect the user's filter glob when listing tests.
>                 self.linux_source_mock.run_kernel.assert_called_once_with(
> @@ -824,7 +824,7 @@ class KUnitMainTest(unittest.TestCase):
>
>                 # Should respect the user's filter glob when listing tests.
>                 mock_tests.assert_called_once_with(mock.ANY,
> -                                    kunit.KunitExecRequest(None, None, False, '.kunit', 300, 'suite*.test*', '', None, None, 'suite', False, False))
> +                                    kunit.KunitExecRequest(None, None, False, False, '.kunit', 300, 'suite*.test*', '', None, None, 'suite', False, False))
>                 self.linux_source_mock.run_kernel.assert_has_calls([
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', filter='', filter_action=None, timeout=300),
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', filter='', filter_action=None, timeout=300),
> @@ -837,7 +837,7 @@ class KUnitMainTest(unittest.TestCase):
>
>                 # Should respect the user's filter glob when listing tests.
>                 mock_tests.assert_called_once_with(mock.ANY,
> -                                    kunit.KunitExecRequest(None, None, False, '.kunit', 300, 'suite*', '', None, None, 'test', False, False))
> +                                    kunit.KunitExecRequest(None, None, False, False, '.kunit', 300, 'suite*', '', None, None, 'test', False, False))
>                 self.linux_source_mock.run_kernel.assert_has_calls([
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', filter='', filter_action=None, timeout=300),
>                         mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', filter='', filter_action=None, timeout=300),
> --
> 2.47.0.277.g8800431eea-goog
>

--0000000000005d28dc0626d923b4
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQghPH4eRMBH4qcrhOeGtpSLzinMC7V
mwi7OvC2h0bl81UwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MTE0MDU1ODIzWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAGrHuapXuKBdExfBXNledjprI5I18R9uOrSXHZMzW2YdrpIW
HSDKrYCENbMvzAFWOFUY7HPH43eVQjSOsTyBmTRjeEEW27ifOYIS2yqzoyp/vNvAVslhiyAXuGok
T6a5n0QlihbltjPY+b9IIp1KHVt2bOyATSLmXHvf4StvpzX1cQbSpRPzLjBGTrZyxZUYy21HhEAq
hlrSAe/Y3GNAxQ+Ukp5O6PQnQZxUZY8v81fnBHmOGWVr5qIhQdw6Ozto4VfoS6+xVeDnnqbFmxwt
hygUpKV0zrIgqbYq1DuB89yKpxPBbAKxw3pzwujevVpBxZugEhOxxDWrM7SitdlwRUU=
--0000000000005d28dc0626d923b4--

