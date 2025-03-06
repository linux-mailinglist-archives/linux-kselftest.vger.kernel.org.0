Return-Path: <linux-kselftest+bounces-28381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A294DA545B2
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 10:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D5D1883376
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 09:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B731C861F;
	Thu,  6 Mar 2025 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHf0+04U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015E207E11
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251605; cv=none; b=ciXIdocjvwAMQ9p3cLyD2dGg/WZ4H0x85tmhf7tf6G1IP6mPWiyhK7G26vArGZhDdq/bl3ws6I1Q0T5/faL900q8c25x190hVDMKktXNK4cgYg9uli/f+fT2t2ck+v0rPcp3i53a4F5VkYErTHlg8e1KpRnNW6gH8kw3E8oxecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251605; c=relaxed/simple;
	bh=va9mITd4oo1Sgkbyc5hOTuLhBCn2glHA7AQoz8RP2QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDvXjS7AB5jxDnOikzmKH/yHyfzv7UmKCQxuEbgE5P7+B+T2t/iwogfdLCqs+aicUFb8fJKRXwk5IPUIsN2Qko85axdBSxAWKOVGf84h2MqM3hHtvR3coXi4NGtIyCZZeY7palW2dOwY7KF3M5//EfQVGnUqxo0Xqm1G87hTSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HHf0+04U; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6dd049b5428so4085296d6.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 01:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741251603; x=1741856403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=min2nR3M70cpd3J+GI+jV/w1GYtiV5d40qZezL/fx3k=;
        b=HHf0+04UxmF2v4bAaXjX/LzxJxF2YT2Fjus+LNlI3GQZipwZs9MSxdftzxfDXok36q
         6AbGPXYhdJF8cFL2gMvThAqbjqIGrjhGTs6+3RTehko2NjQuuLFTgHrzCYN9jRrHZj10
         m1Ez1ZNeheJYK4YyFeHIPn1jLIg6hq8XE9CAiqvI7hWI/C595xrGoGrV1Ajx8vWoejnl
         Pjpx7wJocG6S2yu+v57j/+n9TCHYmD8spiuOJ150y1G01qPaIU3ksqO+1brRRHfcpy2k
         5XIOZ1Yy5AOobKuNA70kuHqcFnG+AwrKVHhwiUxpLsb/RWwSMayFlcXhD8MdpV9oYlW5
         2/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251603; x=1741856403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=min2nR3M70cpd3J+GI+jV/w1GYtiV5d40qZezL/fx3k=;
        b=ZGtphBTbOFrKn+5xx1rFFr1uPVf5rjjDeq7Dhu3ZibZmVd8KwVwSc9CuT/TQ+quKi0
         4ZZPAt8XyrWiUunUYt5UTZvRMFltNLvhikUohp7b66Y76KNKdBNcjUjgy/RgA0W0nfSY
         PmKtoZS2U9SYQv+pD7qrnYNlgUTpaQHNFUU32NQ5JCsDyt6RprfY+RfrWdsKTk0u2Qyk
         Ue8l0g0yzl5CFXK1Vs2FWTC3PV5Pvze4yYKUCWhrzXXVNO/+mY7v+QLcNeT+6AGKFnJK
         aHw98ckveUIAn0vMMlTQqq33dlEIC2jLgsKVXl5gGHfAmVhYWuUS3Bj70873zaSrPY+B
         tZgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwhcognwywFcZrg5aw4Y+Hz8BBabqDdCB370LL8YDLj4GoFId7N4N76y0ypSeMAa19xtSYlHX0ye4j21ym4Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQAAjjZbNk+hW+ybj/TWcn6rFXjQm/6aYRKbeIGY8xVz2cgbsu
	g/dmJ0cQKV+NOA6xls40SgRBe3wGI5IXr1LazIBopWtC37ah/DMgpSiocUqLQTAX69CMnaXXaFi
	DSMbbo+zq5SEKyLid7ZlBpyYxph8bXn1QXIPC
X-Gm-Gg: ASbGncucZxx80xL7+di/TbaFNAuTbkwn20GEkzZUFhyPofJrh9+p5OqZAfAbZSxIdAs
	5Hgnsya6+RgcruA7Kqg+cye6gxZvSyTN87WkJLdTffeBdRe3AHxKgMGhLiKL5nNeZQcy8qEBTxn
	xygFwLBvRaw56b9eQjirNt4k2apcA=
X-Google-Smtp-Source: AGHT+IEnTFk+qPOlTSbiY7+YUxlqRjEgDgoxk4hAxmHddfCpJ8+QENxWifylJ16vDQJsXnW7ueQYkIbHgErRNL+2GnQ=
X-Received: by 2002:ad4:5ae9:0:b0:6e8:9a55:8259 with SMTP id
 6a1803df08f44-6e8e6cfedf3mr93849766d6.9.1741251602571; Thu, 06 Mar 2025
 01:00:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306002933.1893355-1-rmoar@google.com>
In-Reply-To: <20250306002933.1893355-1-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Thu, 6 Mar 2025 16:59:49 +0800
X-Gm-Features: AQ5f1Jry7uhKagxn_pWuMsODdfHkO3aKU3Urde0moQ7csvmBpcY3u_Da2JYfP8Q
Message-ID: <CABVgOSkwrb36rrhH3H17fhYOnywhTgTh06aDaKXT4jZp474sRQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix bug in parsing test plan
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, jackmanb@google.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000043dd65062fa8bb31"

--00000000000043dd65062fa8bb31
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 08:29, Rae Moar <rmoar@google.com> wrote:
>
> A bug was identified where the KTAP below caused an infinite loop:
>
>  TAP version 13
>  ok 4 test_case
>  1..4
>
> The infinite loop was caused by the parser not parsing a test plan
> if following a test result line.
>
> Fix bug to correctly parse test plan and add error if test plan is
> missing.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Thanks for looking into this: I don't think we want to unconditionally
error if there's no test plan, though. Pretty much no parameterised
tests include one -- it's not always possible to know how many tests
there'll be in advance -- so this triggers all of the time.

Maybe we can only include an error if we find a test plan line after
an existing result, or something?

-- David

>  tools/testing/kunit/kunit_parser.py    | 12 +++++++-----
>  tools/testing/kunit/kunit_tool_test.py |  5 ++---
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 29fc27e8949b..5dcbc670e1dc 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -761,20 +761,22 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
>                 test.name = "main"
>                 ktap_line = parse_ktap_header(lines, test, printer)
>                 test.log.extend(parse_diagnostic(lines))
> -               parse_test_plan(lines, test)
> +               plan_line = parse_test_plan(lines, test)
>                 parent_test = True
>         else:
>                 # If not the main test, attempt to parse a test header containing
>                 # the KTAP version line and/or subtest header line
>                 ktap_line = parse_ktap_header(lines, test, printer)
>                 subtest_line = parse_test_header(lines, test)
> +               test.log.extend(parse_diagnostic(lines))
> +               plan_line = parse_test_plan(lines, test)
>                 parent_test = (ktap_line or subtest_line)
>                 if parent_test:
> -                       # If KTAP version line and/or subtest header is found, attempt
> -                       # to parse test plan and print test header
> -                       test.log.extend(parse_diagnostic(lines))
> -                       parse_test_plan(lines, test)
>                         print_test_header(test, printer)
> +
> +       if parent_test and not plan_line:
> +                       test.add_error(printer, 'missing test plan!')
> +
>         expected_count = test.expected_count
>         subtests = []
>         test_num = 1
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 0bcb0cc002f8..e1e142c1a850 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -181,8 +181,7 @@ class KUnitParserTest(unittest.TestCase):
>                         result = kunit_parser.parse_run_tests(
>                                 kunit_parser.extract_tap_lines(
>                                 file.readlines()), stdout)
> -               # A missing test plan is not an error.
> -               self.assertEqual(result.counts, kunit_parser.TestCounts(passed=10, errors=0))
> +               self.assertEqual(result.counts, kunit_parser.TestCounts(passed=10, errors=2))
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
>
>         def test_no_tests(self):
> @@ -203,7 +202,7 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(
>                         kunit_parser.TestStatus.NO_TESTS,
>                         result.subtests[0].subtests[0].status)
> -               self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=1))
> +               self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=2))
>
>
>         def test_no_kunit_output(self):
>
> base-commit: 0619a4868fc1b32b07fb9ed6c69adc5e5cf4e4b2
> --
> 2.48.1.711.g2feabab25a-goog
>

--00000000000043dd65062fa8bb31
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
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
YE9NAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHgsCGkO2Hex
N6ybc+GeQEb6790qMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQAs
exV05yVDmPhHRqOq9lAbfWOUvEf8zydxabZUHna6bayb83jD2eb9nMGGEprfuNBRmFg35sgF1TyN
+ieuQakvQYmY8tzK49hhHa2Y3qhGCTqYTHO3ypHvhHsZiGbL0gmdgB9P8ssVIws//34ae99GUOxo
XKTxPwwsQ5Arq42besv3/HXAW+4nRAT8d3ht5ZWCHc5rjL/vdGzu7PaYo3u0da69AZ8Sh4Gf5yoc
QANr2ZkMrxXbLmSmnRvbkQrzlZp2YbTFnczx46429D6q75/FNFOL1vAjxtRAPzkyACvW0eKvchza
TMvvD3IWERLlcBL5yXpENc3rI8/wVjqgAWYxlFg1b/4b/TCgYe2MZC0rx4Uh3zTIbmPNiHdN6QZ9
oDiYzWUcqWZ5jCO4bMKNlVJXeCvdANLHuhcC8FONj5VzNgYXs6gWkp9/Wt6XnQPX4dF4JBa8JdL/
cT46RJIzoiJHEx/8syO5FparZHIKbkunoq6niPsRaQUGeqWc56H4Z1sQXuBJN9fhqkIkG0Ywfrwt
uFrCoYIRlx4rSVHpBIKgnsgdm0SFQK72MPmIkfhfq9Fh0h8AjhF73sLO7K5BfwWkx1gwMySyNY0e
PCRYr6WEVOkUJS0a0fui693ymMPFLQAimmz8EpyFok4Ju066StkYO1dIgUIla4x61auxkWHwnzGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg2ERQGafR2K3SU77d/gRKgSMUJ8Dc
6XQa9prbdxBnXSowGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MzA2MDkwMDAzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEABp2uoUthODqlYcwjbnhQK4eN/UJWZQgUdd3lmRBTonA3XZltQdNQqg2W7oLds4ou
KYUhSwiaQZHP+R45eOdaLHq6w8M4RAzgVXZaNJyZ6TSeR6gUGlZ6CbUyHycG+xc/pOIT5TFEzsyj
9MkGvQLvUhSoIdAOm6hVLFFSy6FDwVHgfoX1JKDpmt7TgGajWaiby3XtqB3R1qUjOMF7171b4JL2
5QtvFTRpTL/H6hpMMcQu7V+r7hX/77oXJLmFIWfrW/XoOPgOEyzvMXyBB7tgwizfxvx9YHCbhPoT
TAnc8dWkomrgZnnCFZX7324qXmlmdnI1Mxezvlt5yysHzM1NqQ==
--00000000000043dd65062fa8bb31--

