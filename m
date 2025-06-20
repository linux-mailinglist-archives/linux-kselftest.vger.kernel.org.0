Return-Path: <linux-kselftest+bounces-35417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8C5AE17BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 11:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12D11BC20E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 09:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37880284B4A;
	Fri, 20 Jun 2025 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JubSga43"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B190284B25
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412280; cv=none; b=l9mCUohnAWK3GzI0OSba6rXPyECpLV+kHWb+yWVwxkEC2taFyoToSbP0o4tdQAPiV4tO6/lvAhJF7ZNbdG3O+Hs69JGGYOkrD3hKWA7QcURK1NmDjvwvrDUkOku5gCySWX1vZG+5MPpvN2GrAsOsLly74Gcf7oI27kWpiAlQxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412280; c=relaxed/simple;
	bh=l60HFoNy8jplcV7JqasKZQLg8XLMjTIQoR/OVM7+En0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZo673WdLsvtpw4loaNwomLoX/oFbYjgfZ/SJB9fOzgfuGVrV/S8pIRKQbXO9386EIY93U6E81ZwP/UU0xYKMEOEW+osM6ILHHZPKgzd0Lsfevzm4yO2kwn6H+08Z5uK2y9HQyOZ+k1hCzNO4hHnzWO+/46m3BPo7Ie+PXEd1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JubSga43; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fad3400ea3so16153036d6.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 02:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750412277; x=1751017077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U6v7gyiGx3piYyWvLEX4etSrmtTQi5mfLnouyB7QgfI=;
        b=JubSga4397qVLMR20PMBatebLQA/iPIadVOiM1K+afVJcmumBnNlsECRv+WGv4IF8h
         a18OU6fzCt3WycRoY5nvEvovWOlexRQK+IA112hfB7JxOMnyz8KhBsmy2fE45KiSN5D1
         y3oWXQbvVcQKOt2jPW3aopkK9sycq51r6s/tkdMA5pCQ3vwnlIXvBUomEBtEOaRhFBbD
         tu+zTVNsLKVaeFgelAo/J8nMNw6chH5LcoenPPk5hQTAepgjn5M55+iJyCZSQzU2bGoA
         DxhDW/l+vnf475hYbkCBzs64F3xOmoa+jnfBz+knVEDz0WDLDZozBBoL3sMuEYZDkUCe
         d9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750412277; x=1751017077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6v7gyiGx3piYyWvLEX4etSrmtTQi5mfLnouyB7QgfI=;
        b=mc52lIj9+ollQi4AdOavIAepmvA7OAcAYNeohWI5ofEtxxK6e047cMD2gSMrFsc+lY
         LkktOHbjvru4DH22h9h2M+EDcYpfocm7cPNEy8zQTKIB62uo8nsBXgdjw7nb9YsXmzBK
         z1fWNa0K1wzr2/hr6/JghH3LIiTc9hrLDlmp4/SYl/jrm0eL/6CQgyYiGziQ6xDUHIo4
         w5RZ6jejIA9Qs64fVTq8X/1AyAdSAddPrVpEmHdSzXU57sYjusKJEvFdXocpyYSGeO0s
         lgY05R7FFI/4wAZl6+6uBa4WW+HxPduCcObb5rZaTsqUm6L6g32FsoFwPpodksMdCU5I
         21Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWtwAdOwrjEm5UbiDIzSEas/OhO/joYEFjoRhitLRsynB6SL92vWGixvIkyywzwy6vRW93F71+LRrI0UFfmHTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHbvPNQA2d5bALKumaLQ6EcMx6r6GZLTBe3WNwWqAYx8JRv+3I
	YYxlIZ949gdHEvoOsre/SIUDgyF1GZsQqQ/BT+LFlqGCD+WWEZFifMhgA6TuVgp/5DQTRPpqeom
	zYpJGkHyiLc9z7sK7lKQSjYyAHJOEuPK7K9WG5cE7
X-Gm-Gg: ASbGncuUCPOpeFrKLu91X+1f2tEOzfcsrbPZx+FIxmSHLPeAIQUPkkeJJEwH+5Kp0vk
	B4fPnNbonqBsBehiCkN9qAhlZ73hGkxmSN6mOTd6Q9QXvn5ynTTX9BjoKh5zlEIeDpRv/LWo2nV
	yJDwWulBXHkNrUsDjsQuqkiLQvg1G49i79+BtiQhvqbS5glNPDtsIDhvxKsLeyrJUJAQuOQKmBf
	fZwZA==
X-Google-Smtp-Source: AGHT+IH1TD7sFLVLxLNDZ8cOfYRjL/tT2kVxcg2PElAyBtkqeDrdZR4VhtKx2gcfBWmyNH4WFLtTAKj4ScRPvS1jgHY=
X-Received: by 2002:a05:6214:124d:b0:6fa:c697:97a5 with SMTP id
 6a1803df08f44-6fd0a46f07fmr36390116d6.15.1750412277186; Fri, 20 Jun 2025
 02:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de> <20250611-kunit-kselftests-v3-9-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-9-55e3d148cbc6@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Fri, 20 Jun 2025 17:37:44 +0800
X-Gm-Features: Ac12FXwRaH3OfJhCzT5AZcyk8RCDXf0-Z1aDXf_aau98Tkhf8caX_HLkU_59kY8
Message-ID: <CABVgOSkG3dY3THo5DQOvWj1xX8XFFnnk7CXvVE2opQJZg4nwXg@mail.gmail.com>
Subject: Re: [PATCH v3 09/16] kunit: tool: Don't overwrite test status based
 on subtest counts
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	workflows@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000697030637fd9e91"

--0000000000000697030637fd9e91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jun 2025 at 15:38, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> If a subtest itself reports success, but the outer testcase fails,
> the whole testcase should be reported as a failure.
> However the status is recalculated based on the test counts,
> overwriting the outer test result.
> Synthesize a failed test in this case to make sure the failure is not
> swallowed.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---

Hmm... this is definitely a nasty edge-case. I don't completely like
this solution, but none of the other options seem drastically better.

I think the more obvious options are either to _always_ count tests
alongside their subtests, or to _never_ do so, but acknowledge that
"test failed, but failure count is 0" is a valid option. But neither
of those are especially satisfying, either greatly inflating test
counts, or creating obvious contradictions.

So I'm tentatively in favour of this, but if anyone has a nicer way of
doing it, I'm all ears.

The implementation looks good. If we can add the explicit checks for
the sub(sub)test results as mentioned in the previous patch, that'd be
even better.

Reviewed-by: David Gow <davidgow@google.com>

>  tools/testing/kunit/kunit_parser.py                                  | 5=
 +++++
>  tools/testing/kunit/kunit_tool_test.py                               | 2=
 +-
>  tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log | 3=
 +++
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/ku=
nit_parser.py
> index c176487356e6c94882046b19ea696d750905b8d5..2478beb28fc3db825855ad462=
00340e884da7df1 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -686,6 +686,11 @@ def bubble_up_test_results(test: Test) -> None:
>                 counts.add_status(status)
>         elif test.counts.get_status() =3D=3D TestStatus.TEST_CRASHED:
>                 test.status =3D TestStatus.TEST_CRASHED
> +       if not test.ok_status():
> +               for t in subtests:
> +                       if not t.ok_status():
> +                               counts.add_status(t.status)
> +                               break
>
>  def parse_test(lines: LineStream, expected_num: int, log: List[str], is_=
subtest: bool, printer: Printer) -> Test:
>         """
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit=
/kunit_tool_test.py
> index 691cde9b030f7729128490c1bdb42ccee1967ad6..c25f52650837e83325b06bddd=
2aa665fd29f91d9 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -170,7 +170,7 @@ class KUnitParserTest(unittest.TestCase):
>                 with open(nested_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.=
status)
> -               self.assertEqual(result.counts.failed, 2)
> +               self.assertEqual(result.counts.failed, 3)
>                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.=
subtests[0].status)

Could we add:
self.assertEqual(kunit_parser.TestStatus.SUCCESS,
result.subtests[0].subtests[0].status)

>                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.=
subtests[1].status)

and

self.assertEqual(kunit_parser.TestStatus.FAILURE,
result.subtests[1].subtests[0].status)


>
> diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure-ne=
sted.log b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested=
.log
> index 835816e0a07715a514f5f5afab1b6250037feaf4..cd9033c464792e6294905a567=
6346684182874ad 100644
> --- a/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.lo=
g
> +++ b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.lo=
g
> @@ -1,5 +1,8 @@
>  KTAP version 1
>  1..2
> +    KTAP version 1
> +    1..1
> +        ok 1 test 1
>  not ok 1 subtest 1
>      KTAP version 1
>      1..1
>
> --
> 2.49.0
>

--0000000000000697030637fd9e91
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
jmkLAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFBp5bTxrTm/d
WMmRETO8lNkA4c7fMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBF
tO3/N2l9hTaij/K0xCpLwIlrqpNo0nMAvvG5LPQQjSeHnTh06tWTgsPCOJ65GX+bqWRDwGTu8WTq
c5ihCNOikBs25j82yeLkfdbeN/tzRGUb2RD+8n9I3CnyMSG49U2s0ZdncsrIVFh47KW2TpHTF7R8
N1dri01wPg8hw4u0+XoczR2TiBrBOISKmAlkAi+P9ivT31gSHdbopoL4x0V2Ow9IOp0chrQQUZtP
KBytLhzUzd9wIsE0QMNDbw6jeG8+a4sd17zpXSbBywIGw7sEvPtnBjMaf5ib3kznlOne6tuDVx4y
QFExTCSrP3OTMUkNbpIdgzg2CHQ2aB8i8YsTZ8Q8Q8ztPJ+xDNsqBUeYxILLjTjxQQovToqipB3f
6IMyk+lWCdDS+iCLYZULV1BTHSdwp1NM3t4jZ8TMlV+JzAyRqz4lzSl8ptkFhKBJ7w2tDrZ3BEXB
8ASUByRxeh+pC1Z5/HhqfiWMVPjaWmlRRJVlRk+ObKIv2CblwxMYlo2Mn8rrbEDyfum1RTMW55Z6
Vumvw5QTHe29TYxSiusovM6OD5y0I+4zaIaYDx/AtF0mMOFXb1MDyynf1CDxhtkgnrBUseHSOU2e
MYs7IqzRap5xsgpJS+t7cp/P8fdlCNvsXss9zZa279tKwaxR0U2IzGxRGsWKGxDysn1HT6pqMDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAUXA7LnOuRz2DvkWTeMc
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgD3zuI9iU4DB2wbGfklbpYijAIovy
hOAXyvOCGLVDNOgwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NjIwMDkzNzU3WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAk424lyjHkVMODpnptIS1uEWFky04fRHhprsSPrXGp9cLUVyFUa/mqVhutk/W8gEp
oJ4DcPJOjyIemXr3xyPmfeBCqA1V0SC8MKAKtbRPxTLLDbJw2FKQ+LO5Q8ZnUjtps38cnVLlyzAU
pCww4YB2eFodo9qAryoHfeB8RpVY0uWsPeKdvwnKky1iDMfse8ffuAiRpcAceh89WStzAxrgmR6c
CJXFN+xEbzTbOzXz/eXkHJytuCN3IwveVis0rWv+Kg/9c7q1IJICTf68R89aeh1sS/wUMCrOenhH
IZ5XJipV6nHg0K2D+ZPSxMwDpN9spvIRlocSwZiWkOlP13uO6Q==
--0000000000000697030637fd9e91--

