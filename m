Return-Path: <linux-kselftest+bounces-48180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5628FCF28C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 09:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04B9030046CB
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 08:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B03330FF33;
	Mon,  5 Jan 2026 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKi+eGFC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B631ED72
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603382; cv=none; b=EdQhIqD2uFiv398groG8ONi/AtcMOJDpOLQ02jRIQVlYbNdHgktW8nPi6QvbpySpvM4qMbkSQDkIYD2nJOnNxsxlRmBr2UUhhD1zU6RZJ4w3oeQW8N84rXUz6Ul49yNvVbArCL+ImuzTIEV7zKooLX7mG4yNsMFSPkn21jaaDms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603382; c=relaxed/simple;
	bh=BPmYXOEvB1XHDxQojthNv3MU1MQ8GiFGy2e986YxUl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwhoOjrPZ63/jRziA2SDTQH6lVkGh0Y/VQyhXdN7/XD2GW/aGDo4uXE95YpPBTc4sfWQpxjuEAVdwwYu5x3Sv+RrTL+tW+RDD4s2rKtGnwH8qz2MZQt9Q8tVb9pJ4AAuWL4kDaxwIZh9InC3fbq6SLod4rBNkln9P3nTOYps3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKi+eGFC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-430f57cd471so6411384f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 00:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767603378; x=1768208178; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AdpvOlkuDq2jqIRLS+OBhfhqvCxlOrHreAQrKu1DUQg=;
        b=fKi+eGFC8Et5WWVB/G+Bs2+iFW0E21VJoBJYEAkdpoaYX20lg4r2spERZ7NfIJuzAu
         Qs27etEj3NNyAV13oEDH10ODgTFPnbdnccZw9C99j6imrUgmKieWfs3EmCjjSnX98K6F
         nRuO1CH0A74o967WDm63uE7U+skWYAhi6jIRaEnpVG4LNggznpXPkb1Ay2ubaEv1kjXb
         xR2grmbKM7KD/ii2gnLnfgFcmpVphQ5hA8WJd/5TGOUBLBqejOB4bTwrYZoadNQ5Hgjg
         0OYNVd5teF0ihqWxhYfzkaWcgNn62I+SoACzujuQMifKiCfHiiWxf7GIpIBIFwvg9CUL
         FKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767603378; x=1768208178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdpvOlkuDq2jqIRLS+OBhfhqvCxlOrHreAQrKu1DUQg=;
        b=AA1cv51mQo5nE4BHBkPgiHs7IxBndthHpySMItvDIYVUEbEuRraF/N999nihPJPitl
         /mEwkb5ycDTgMwjQufOvHY09luNun+EOVCcfJ12r63HWlEcny5oWRB7vDryjQdiV7l6Y
         NkSYCKpefvllpYvRB6ehPQnkl7MFSB/whG/w7wds5g3E1v1tJGifXx8yKS1Zna+T6Grd
         l/XqJzYxwriMxKev1k/3fPrrFRQ42MSkdz1WevHy6uinMuqBBGQkBJJOZWVxCwnMIzLF
         lBtbHGPGFbpOHVCs10sRZ9IdMiK4d5ZPpasGVQV/ajoY8bXPIcd4hpYGUNI+rddzSHjR
         rtDg==
X-Forwarded-Encrypted: i=1; AJvYcCVXJeddYlF1ShSWV9bfKjZhNm+CNTWwJAeZ0EkNo5xjJXSNsdoqonpKfznuxs1te4rLrNYtIdHdtpLHA6hLsJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgItu3Foj7ONPy0Kn21Wj0umcCmkfwK6Sw06vRnGDMQL4nLGp
	89SWvO+GXTN93ON68aAWa0maFim1P4eCDzaiQznndIMEWleLngnidQDNeReJrRlSY/RPGHAiPgp
	Q3sYN2V3resQgGCA1AjxnNSF9rnPSPOSVuKCxaEAl
X-Gm-Gg: AY/fxX56PlRR2Rl5Jue2A4KKZW5ghymNI4t0vk3N+KSlSHEZqR+k04y3LEhVb6CfXQe
	Gf9nAZCoeTcZx/VZZcm5UhE606MPvsjvYWvYvlgOO6vS5TUmwAo/HFHYbLCZBcFWW1Zd7F/Tc0B
	1ErjikYNnBKqaYa1FzSwiAw+enOYfxZh5O+rOvu301Kv44UvR62Qi0Mq+G98p0TrFlorCjTrplN
	/Tm73C8QkOiZ19c/fi9iCFOhV2OWO92ZLevlrmBk0hdjs7l/OxEwOFD/vgp7xzzyEkJsg==
X-Google-Smtp-Source: AGHT+IGy8/K/3vfcagno4C39MU5ReQDvwliLoVIXIOiPPekEgKBSG/3qGSHkVjkLj36865ExToPzhl3HDcr/lceWF+Q=
X-Received: by 2002:a5d:64e9:0:b0:430:f58d:40da with SMTP id
 ffacd0b85a97d-4324e4c68d6mr63873607f8f.10.1767603377622; Mon, 05 Jan 2026
 00:56:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230-kunit-pytest-v1-0-e2dae0dae200@linutronix.de> <20251230-kunit-pytest-v1-1-e2dae0dae200@linutronix.de>
In-Reply-To: <20251230-kunit-pytest-v1-1-e2dae0dae200@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Mon, 5 Jan 2026 16:56:05 +0800
X-Gm-Features: AQt7F2qgFWT74QrOy5aUtSYBQTlKfsUzehURu-zpw92h2RpIGciF1iwBcm2_sJE
Message-ID: <CABVgOSnvZ3ruCj3ags0=hRfAhtG9d=Fz_fF=wEG6W3YhNQmN1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: test: Rename test_data_path() to _test_data_path()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000077e0460647a03be8"

--00000000000077e0460647a03be8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Dec 2025 at 20:56, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Running the KUnit testsuite through pytest fails, as the function
> test_data_path() is recognized as a test function. Its execution fails
> as pytest tries to resolve the 'path' argument as a fixture which does
> not exist.
>
> Rename the function, so the helper function is not incorrectly
> recognized as a test function.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---

Thanks -- I'd never tried pytest, but it's working with this series.

Although, it's worth noting that we add another call to
test_data_path() in "kunit: tool: Add test for nested test result
reporting", which conflicts here.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David




>  tools/testing/kunit/kunit_tool_test.py | 54 +++++++++++++++++-----------=
------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit=
/kunit_tool_test.py
> index bbba921e0eac..fd7ca89596c0 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -36,7 +36,7 @@ def setUpModule():
>  def tearDownModule():
>         shutil.rmtree(test_tmpdir)
>
> -def test_data_path(path):
> +def _test_data_path(path):
>         return os.path.join(abs_test_data_dir, path)
>
>  class KconfigTest(unittest.TestCase):
> @@ -52,7 +52,7 @@ class KconfigTest(unittest.TestCase):
>                 self.assertFalse(kconfig1.is_subset_of(kconfig0))
>
>         def test_read_from_file(self):
> -               kconfig_path =3D test_data_path('test_read_from_file.kcon=
fig')
> +               kconfig_path =3D _test_data_path('test_read_from_file.kco=
nfig')
>
>                 kconfig =3D kunit_config.parse_file(kconfig_path)
>
> @@ -98,7 +98,7 @@ class KUnitParserTest(unittest.TestCase):
>                 raise AssertionError(f'"{needle}" not found in {list(back=
up)}!')
>
>         def test_output_isolated_correctly(self):
> -               log_path =3D test_data_path('test_output_isolated_correct=
ly.log')
> +               log_path =3D _test_data_path('test_output_isolated_correc=
tly.log')
>                 with open(log_path) as file:
>                         result =3D kunit_parser.extract_tap_lines(file.re=
adlines())
>                 self.assertContains('TAP version 14', result)
> @@ -109,7 +109,7 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertContains('ok 1 - example', result)
>
>         def test_output_with_prefix_isolated_correctly(self):
> -               log_path =3D test_data_path('test_pound_sign.log')
> +               log_path =3D _test_data_path('test_pound_sign.log')
>                 with open(log_path) as file:
>                         result =3D kunit_parser.extract_tap_lines(file.re=
adlines())
>                 self.assertContains('TAP version 14', result)
> @@ -138,35 +138,35 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertContains('ok 3 - string-stream-test', result)
>
>         def test_parse_successful_test_log(self):
> -               all_passed_log =3D test_data_path('test_is_test_passed-al=
l_passed.log')
> +               all_passed_log =3D _test_data_path('test_is_test_passed-a=
ll_passed.log')
>                 with open(all_passed_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.=
status)
>                 self.assertEqual(result.counts.errors, 0)
>
>         def test_parse_successful_nested_tests_log(self):
> -               all_passed_log =3D test_data_path('test_is_test_passed-al=
l_passed_nested.log')
> +               all_passed_log =3D _test_data_path('test_is_test_passed-a=
ll_passed_nested.log')
>                 with open(all_passed_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.=
status)
>                 self.assertEqual(result.counts.errors, 0)
>
>         def test_kselftest_nested(self):
> -               kselftest_log =3D test_data_path('test_is_test_passed-kse=
lftest.log')
> +               kselftest_log =3D _test_data_path('test_is_test_passed-ks=
elftest.log')
>                 with open(kselftest_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.=
status)
>                 self.assertEqual(result.counts.errors, 0)
>
>         def test_parse_failed_test_log(self):
> -               failed_log =3D test_data_path('test_is_test_passed-failur=
e.log')
> +               failed_log =3D _test_data_path('test_is_test_passed-failu=
re.log')
>                 with open(failed_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.=
status)
>                 self.assertEqual(result.counts.errors, 0)
>
>         def test_no_header(self):
> -               empty_log =3D test_data_path('test_is_test_passed-no_test=
s_run_no_header.log')
> +               empty_log =3D _test_data_path('test_is_test_passed-no_tes=
ts_run_no_header.log')
>                 with open(empty_log) as file:
>                         result =3D kunit_parser.parse_run_tests(
>                                 kunit_parser.extract_tap_lines(file.readl=
ines()), stdout)
> @@ -175,7 +175,7 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(result.counts.errors, 1)
>
>         def test_missing_test_plan(self):
> -               missing_plan_log =3D test_data_path('test_is_test_passed-=
'
> +               missing_plan_log =3D _test_data_path('test_is_test_passed=
-'
>                         'missing_plan.log')
>                 with open(missing_plan_log) as file:
>                         result =3D kunit_parser.parse_run_tests(
> @@ -186,7 +186,7 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.=
status)
>
>         def test_no_tests(self):
> -               header_log =3D test_data_path('test_is_test_passed-no_tes=
ts_run_with_header.log')
> +               header_log =3D _test_data_path('test_is_test_passed-no_te=
sts_run_with_header.log')
>                 with open(header_log) as file:
>                         result =3D kunit_parser.parse_run_tests(
>                                 kunit_parser.extract_tap_lines(file.readl=
ines()), stdout)
> @@ -195,7 +195,7 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(result.counts.errors, 1)
>
>         def test_no_tests_no_plan(self):
> -               no_plan_log =3D test_data_path('test_is_test_passed-no_te=
sts_no_plan.log')
> +               no_plan_log =3D _test_data_path('test_is_test_passed-no_t=
ests_no_plan.log')
>                 with open(no_plan_log) as file:
>                         result =3D kunit_parser.parse_run_tests(
>                                 kunit_parser.extract_tap_lines(file.readl=
ines()), stdout)
> @@ -207,7 +207,7 @@ class KUnitParserTest(unittest.TestCase):
>
>
>         def test_no_kunit_output(self):
> -               crash_log =3D test_data_path('test_insufficient_memory.lo=
g')
> +               crash_log =3D _test_data_path('test_insufficient_memory.l=
og')
>                 print_mock =3D mock.patch('kunit_printer.Printer.print').=
start()
>                 with open(crash_log) as file:
>                         result =3D kunit_parser.parse_run_tests(
> @@ -218,7 +218,7 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(result.counts.errors, 1)
>
>         def test_skipped_test(self):
> -               skipped_log =3D test_data_path('test_skip_tests.log')
> +               skipped_log =3D _test_data_path('test_skip_tests.log')
>                 with open(skipped_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>
> @@ -227,7 +227,7 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(result.counts, kunit_parser.TestCounts(p=
assed=3D4, skipped=3D1))
>
>         def test_skipped_all_tests(self):
> -               skipped_log =3D test_data_path('test_skip_all_tests.log')
> +               skipped_log =3D _test_data_path('test_skip_all_tests.log'=
)
>                 with open(skipped_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>
> @@ -235,7 +235,7 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(result.counts, kunit_parser.TestCounts(s=
kipped=3D5))
>
>         def test_ignores_hyphen(self):
> -               hyphen_log =3D test_data_path('test_strip_hyphen.log')
> +               hyphen_log =3D _test_data_path('test_strip_hyphen.log')
>                 with open(hyphen_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>
> @@ -249,7 +249,7 @@ class KUnitParserTest(unittest.TestCase):
>                         result.subtests[1].name)
>
>         def test_ignores_prefix_printk_time(self):
> -               prefix_log =3D test_data_path('test_config_printk_time.lo=
g')
> +               prefix_log =3D _test_data_path('test_config_printk_time.l=
og')
>                 with open(prefix_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.=
status)
> @@ -257,7 +257,7 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(result.counts.errors, 0)
>
>         def test_ignores_multiple_prefixes(self):
> -               prefix_log =3D test_data_path('test_multiple_prefixes.log=
')
> +               prefix_log =3D _test_data_path('test_multiple_prefixes.lo=
g')
>                 with open(prefix_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.=
status)
> @@ -265,7 +265,7 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(result.counts.errors, 0)
>
>         def test_prefix_mixed_kernel_output(self):
> -               mixed_prefix_log =3D test_data_path('test_interrupted_tap=
_output.log')
> +               mixed_prefix_log =3D _test_data_path('test_interrupted_ta=
p_output.log')
>                 with open(mixed_prefix_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.=
status)
> @@ -273,7 +273,7 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(result.counts.errors, 0)
>
>         def test_prefix_poundsign(self):
> -               pound_log =3D test_data_path('test_pound_sign.log')
> +               pound_log =3D _test_data_path('test_pound_sign.log')
>                 with open(pound_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.=
status)
> @@ -281,7 +281,7 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(result.counts.errors, 0)
>
>         def test_kernel_panic_end(self):
> -               panic_log =3D test_data_path('test_kernel_panic_interrupt=
.log')
> +               panic_log =3D _test_data_path('test_kernel_panic_interrup=
t.log')
>                 with open(panic_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.TEST_CRASHED, re=
sult.status)
> @@ -289,7 +289,7 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertGreaterEqual(result.counts.errors, 1)
>
>         def test_pound_no_prefix(self):
> -               pound_log =3D test_data_path('test_pound_no_prefix.log')
> +               pound_log =3D _test_data_path('test_pound_no_prefix.log')
>                 with open(pound_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.=
status)
> @@ -318,7 +318,7 @@ class KUnitParserTest(unittest.TestCase):
>                         'Failures: all_failed_suite, some_failed_suite.te=
st2')
>
>         def test_ktap_format(self):
> -               ktap_log =3D test_data_path('test_parse_ktap_output.log')
> +               ktap_log =3D _test_data_path('test_parse_ktap_output.log'=
)
>                 with open(ktap_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>                 self.assertEqual(result.counts, kunit_parser.TestCounts(p=
assed=3D3))
> @@ -327,13 +327,13 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual('case_2', result.subtests[0].subtests[1]=
.name)
>
>         def test_parse_subtest_header(self):
> -               ktap_log =3D test_data_path('test_parse_subtest_header.lo=
g')
> +               ktap_log =3D _test_data_path('test_parse_subtest_header.l=
og')
>                 with open(ktap_log) as file:
>                         kunit_parser.parse_run_tests(file.readlines(), st=
dout)
>                 self.print_mock.assert_any_call(StrContains('suite (1 sub=
test)'))
>
>         def test_parse_attributes(self):
> -               ktap_log =3D test_data_path('test_parse_attributes.log')
> +               ktap_log =3D _test_data_path('test_parse_attributes.log')
>                 with open(ktap_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>
> @@ -555,7 +555,7 @@ class KUnitJsonTest(unittest.TestCase):
>                 self.addCleanup(mock.patch.stopall)
>
>         def _json_for(self, log_file):
> -               with open(test_data_path(log_file)) as file:
> +               with open(_test_data_path(log_file)) as file:
>                         test_result =3D kunit_parser.parse_run_tests(file=
, stdout)
>                         json_obj =3D kunit_json.get_json_result(
>                                 test=3Dtest_result,
> @@ -596,7 +596,7 @@ class StrContains(str):
>
>  class KUnitMainTest(unittest.TestCase):
>         def setUp(self):
> -               path =3D test_data_path('test_is_test_passed-all_passed.l=
og')
> +               path =3D _test_data_path('test_is_test_passed-all_passed.=
log')
>                 with open(path) as file:
>                         all_passed_log =3D file.readlines()
>
>
> --
> 2.52.0
>

--00000000000077e0460647a03be8
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
NjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjAeFw0xNDEyMTAwMDAw
MDBaFw0zNDEyMTAwMDAwMDBaMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMw
EQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMIICIjANBgkqhkiG9w0BAQEF
AAOCAg8AMIICCgKCAgEAlQfoc8pm+ewUyns89w0I8bRFCyyCtEjG61s8roO4QZIzFKRvf+kqzMaw
iGvFtonRxrL/FM5RFCHsSt0bWsbWh+5NOhUG7WRmC5KAykTec5RO86eJf094YwjIElBtQmYvTbl5
KE1SGooagLcZgQ5+xIq8ZEwhHENo1z08isWyZtWQmrcxBsW+4m0yBqYe+bnrqqO4v76CY1DQ8BiJ
3+QPefXqoh8q0nAue+e8k7ttU+JIfIwQBzj/ZrJ3YX7g6ow8qrSk9vOVShIHbf2MsonP0KBhd8hY
dLDUIzr3XTrKotudCd5dRC2Q8YHNV5L6frxQBGM032uTGL5rNrI55KwkNrfw77YcE1eTtt6y+OKF
t3OiuDWqRfLgnTahb1SK8XJWbi6IxVFCRBWU7qPFOJabTk5aC0fzBjZJdzC8cTflpuwhCHX85mEW
P3fV2ZGXhAps1AJNdMAU7f05+4PyXhShBLAL6f7uj+FuC7IIs2FmCWqxBjplllnA8DX9ydoojRoR
h3CBCqiadR2eOoYFAJ7bgNYl+dwFnidZTHY5W+r5paHYgw/R/98wEfmFzzNI9cptZBQselhP00sI
ScWVZBpjDnk99bOMylitnEJFeW4OhxlcVLFltr+Mm9wT6Q1vuC7cZ27JixG1hBSKABlwg3mRl5HU
Gie/Nx4yB9gUYzwoTK8CAwEAAaNjMGEwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFK5sBaOTE+Ki5+LXHNbH8H/IZ1OgMB8GA1UdIwQYMBaAFK5sBaOTE+Ki5+LXHNbH
8H/IZ1OgMA0GCSqGSIb3DQEBDAUAA4ICAQCDJe3o0f2VUs2ewASgkWnmXNCE3tytok/oR3jWZZip
W6g8h3wCitFutxZz5l/AVJjVdL7BzeIRka0jGD3d4XJElrSVXsB7jpl4FkMTVlezorM7tXfcQHKs
o+ubNT6xCCGh58RDN3kyvrXnnCxMvEMpmY4w06wh4OMd+tgHM3ZUACIquU0gLnBo2uVT/INc053y
/0QMRGby0uO9RgAabQK6JV2NoTFR3VRGHE3bmZbvGhwEXKYV73jgef5d2z6qTFX9mhWpb+Gm+99w
MOnD7kJG7cKTBYn6fWN7P9BxgXwA6JiuDng0wyX7rwqfIGvdOxOPEoziQRpIenOgd2nHtlx/gsge
/lgbKCuobK1ebcAF0nu364D+JTf+AptorEJdw+71zNzwUHXSNmmc5nsE324GabbeCglIWYfrexRg
emSqaUPvkcdM7BjdbO9TLYyZ4V7ycj7PVMi9Z+ykD0xF/9O5MCMHTI8Qv4aW2ZlatJlXHKTMuxWJ
U7osBQ/kxJ4ZsRg01Uyduu33H68klQR4qAO77oHl2l98i0qhkHQlp7M+S8gsVr3HyO844lyS8Hn3
nIS6dC1hASB+ftHyTwdZX4stQ1LrRgyU4fVmR3l31VRbH60kN8tFWk6gREjI2LCZxRWECfbWSUnA
ZbjmGnFuoKjxguhFPmzWAtcKZ4MFWsmkEDCCBeQwggPMoAMCAQICEAGEC3/wSMy6MPZFqg/DMj8w
DQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMzAeFw0yNTEwMTMyMzQ3
NDlaFw0yNjA0MTEyMzQ3NDlaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC7T8v6fZyfEDlp38NMe4GOXuodILGOFXh6
iVuecsKchx1gCg5Qebyxm+ndfb6ePkd2zzsBOkBJmYrx4G009e+oyTnynr5KXvucs+wLlgm53QU7
6pYikvqTM2hezoWz48Ve/6Jq/6I/eAzKGhn4E/3zG15ETIeMpPFy/E7/lGqq+HFRCb6s0tl/QWhC
BiR+n2UvmXbVWPSR51aRAifsKqiuraeU5g9bGCcbuvdbiYQf1AzNDilkvA6FfUaOPTzVj3rgMyZb
mnZpzWOV1bfib3tYXd2x4IvUS3xlvrap0g9EiDxJKUhCskOf7dPTjaS/kku768Y6U/sDVH5ptgvP
Dxz3AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHZtY3XkWtC2
e2Idfk+0JyK7BLzzMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBo
hqjbVaHxZoT6HHUuwQcTlbgXpuVi59bQPrSwb/6Pn1t3h3SLeuUCvOYpoQjxlWy/FexsPW+nWS0I
PUmWpt6sxbIRTKPfb7cPk32XezfnA0jexucybiXzkZKTrbI7zoMOzDIWpTKYZAonB9Zzi7Dso4An
ZOtz/E3yhdR/q1MK30d5fiCS0vorEd0Oy8Jzcc7TJ2HGMzEEXiFFvVrJYJHvfYOeXE4ywAG6YWO0
x78+bXeB9vkeWHhOYKyYXuAXrnHASddEICg1QlJCHDAISMC1Wn/tjqTMTt3sDAe+dhi9V1FEGTbG
g9PxPVP4huJEMIBu/MWNMzHfiW4E7eCHVPrmtX7CFDlMik7qsgQBbO5h6EcxBamhIflfMgoISsRJ
Vyll2E5BNVwkNstMgU3WMg5yIaQcuGFgFnMTrQcaLEEFPV3cCP9pgXovYDirnB7FKNdCZNHfeBY1
HEXJ2jIPDP6nWSbYoRry0TvPgxh5ZeM5+sc1L7kY75C8U4FV3t4qdC+p7rgqfAggdvDPa5BJbTRg
KAzwyf3z7XUrYp38pXybmDnsEcRNBIOEqBXoiBxZXaKQqaY921nWAroMM/6I6CVpTnu6JEeQkoi4
IgGIEaTFPcgAjvpDQ8waLJL84EP6rbLW6dop+97BXbeO9L/fFf40kBhve6IggpJSeU9RdCQ5czGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAYQLf/BIzLow9kWqD8My
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg8bcOHTRdfGNLqRA9DlC55OblssPX
zgiUKt/eS1bhdE8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTA1MDg1NjE4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAOqfMssTFyn7izb8UJq21WJSywy5KJRpEZ32mtvQP0/vjo1MmlTaTwtYCYBqqRhzu
g4u1OWWYzX9ZHZVnNyNMzvkW6Y5AEVqkRNlqpEvNJw0ZIRkLXruVv3hCsjy4S5O4dOiUNya/t1pW
2beDgK2Uh4pFhxyl9ZjPMAYnr2oVsKYSgN7fW3UjXZxlwjtK8NwRqpCm0M3Hr0+xf7N9ILw0BCkK
KLDA5qTsiGE0FFWCXUxxRabYTBE38biIS6fWzfonlDtwUgD/A1i7uYB2s74gYemVJ1ckZoPArcru
pqmCZ8040BNXpRWl7p50zm0bAbuECjNz2ypPgCw+lgA7J/JYVw==
--00000000000077e0460647a03be8--

