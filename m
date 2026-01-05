Return-Path: <linux-kselftest+bounces-48177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FA1CF2897
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 09:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24EB330024C8
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 08:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4FA32862F;
	Mon,  5 Jan 2026 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tD2OdBCA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1144328625
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603241; cv=none; b=AQNx8wdLhUklFrjlnU/gCAlx8zBE0PFVTRoe0Y0xyAkYRAewQHhzeWbWYr3nesPlyD6G/ikXwZtjGYPTTUyW17gBBdLWNEMDGLZukKpmvqauMQFdzbXVqkqzrjBYySA0bPaczR2jiR9sHAHlypJjmMXuOP1zdTtDB1L3X9dyC78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603241; c=relaxed/simple;
	bh=3jlXz6tdQr0mWnUrAZOqy1sGT64PyRM/MLgiiXMnSkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGEPZ6cgw+jRV6ROkNGX2zrBCmWH0vCdbOjy/OfneAF7QahXuI8PkItvDmvzZ1JWs1LpsXmigBlmoyCKlxH5YKaWgxoiWVn8uMlvUutK4uptjqyIdrqxMSw/5jiuGmhSYi9Mv7ye8l/DRyoU7nwJVFcbS6Gbfs2AOPADDwK3Hvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tD2OdBCA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47755de027eso82993585e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 00:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767603236; x=1768208036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bxRGeZvCpFhKm5kl5HKM2Isa7CqkT4Kj2F8+Oe2hpqw=;
        b=tD2OdBCAvL1rceJwNixyQJtNJDxcZCI8ef3eGBcl9OBTSfBQX1km8eocHdcOgjwM1T
         1DDR3qB1HhpWtnXgoqHUCwhhN5CgMwlJCE0yPoNTEriAgVp/1zpeUqpZHCl153QueU1F
         hIQ87YmNXgEwElQB34c8mgq7aYAlVJW4B01F6QDnNjLHHa8+GYZDa3rzUGrWpu4e3F3G
         sE35MYZWaT5a0p8Kuzg98byfM+eYGmWc/7Ki1ZXOwcwhrN4aIXfaWMTAOurf0o3GFl4X
         u2JhuQtUu4L1wjbXcT0PgstqqbTYJW56t0mAEJhHYd5Z2P5JZdOqFThbU65z77zoOzNB
         tHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767603236; x=1768208036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxRGeZvCpFhKm5kl5HKM2Isa7CqkT4Kj2F8+Oe2hpqw=;
        b=p2Np5sT5vMDJWQ44tbYqDN2sB+7XkVqqSShAtwGwXHjqIEtVQRkEgfX1gbgh4tg0On
         3/xixYnXXi6Xvj9PMyZ658SyZVJBifv2TPRY4WIYX8fe1WLNf83Ut0bYRcjRfb+tqduX
         3duGhPjGtLzU04NKZCyXkm5Su3fcXAzpXhQt2kslgJhkkYGgwaREmpANu04toQh7/P1l
         wxSR0/6Q28uMHcgOoHyJvPyIQoFmckT75JMxdqQoiefnNMFdBWjToYMKQJe51a+HyPzo
         MXL69/Gaj9PcnI0I34h2gLEkXu1uR3nshxjaeVBp4ZOlHoeW/SxKsWOiy30wMC914MDB
         xTXw==
X-Forwarded-Encrypted: i=1; AJvYcCVIh/XjMjoYZL96hjf/NDXNsYli/LUoiWWFhLigUQ3r5aNAdoUu3bWYs4r9bnfQDSKGx34ihIpk/iqVo/NVSQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7uwRC7Tis5cplKgQPWP8tO/RwDx1hiD0xVJ+rScfRtzwdHDJZ
	dKjIXuEiKJSCBD98yPUus3UANqGteWIXgMfa6ms6GyOQ2QU3Ct2OhGoKeB7i7e/nMvwcfBA4tFL
	Hx4ps1iwSgPwrZABQZDxRCC1NtX732K5YP4Z76OFt
X-Gm-Gg: AY/fxX7Nb1Y3K/OPYOLPCPQd5NWG7KRP/8UZyD2K+yVMgURmvz8PYxqw6Wt2s1skufH
	ZmnH3Koc2Ua+FYgMqgmBgHzarNZFBV01rD4TLqw+ktI7Lfhd8CR29qz5MRwEIGxlSbx/a+kuHmy
	/5YgHdMHrgxMVxiP+bCFngjSd7N5sP8KAjW7wfKRNyOv+nFcoPVen4uL+BNt3qhQuOdXehehOYW
	vvsMLTR7lP5pg2OuYLQ9uT5b6YBBo1kD0NaFelQDE0C9s/M8G+wdIvarUjXDD7AaIBvbg==
X-Google-Smtp-Source: AGHT+IF81at/Znn9NZwx5Zc8SqYLegjBkIpqRxYHHhRsZZkX2LXTqaEjAaLVqXhboqBnjdXLQgD8L6O6z0kfjiwPR9A=
X-Received: by 2002:a05:600c:444b:b0:477:9814:6882 with SMTP id
 5b1f17b1804b1-47d1953b77fmr534160615e9.5.1767603236068; Mon, 05 Jan 2026
 00:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251228-kunit-kbuild_output-v1-1-f1fb30fe060f@gmail.com>
In-Reply-To: <20251228-kunit-kbuild_output-v1-1-f1fb30fe060f@gmail.com>
From: David Gow <davidgow@google.com>
Date: Mon, 5 Jan 2026 16:53:43 +0800
X-Gm-Features: AQt7F2rexa4jHx9uumg6v8BRMwdM48Hk3S2iLP3OMLtTZQ1l18Zr63Z7BzKmpWE
Message-ID: <CABVgOSkE1ndm+Mv0S5+XO3Ofd8eP5Ke7-ZbfVBc=-kOEDAkrYA@mail.gmail.com>
Subject: Re: [PATCH RFC] kunit: respect KBUILD_OUTPUT env variable by default
To: Ryota Sakamoto <sakamo.ryota@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000006afe20647a0338a"

--00000000000006afe20647a0338a
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Dec 2025 at 15:57, Ryota Sakamoto <sakamo.ryota@gmail.com> wrote:
>
> Currently, kunit.py ignores the KBUILD_OUTPUT env variable and always
> defaults to .kunit in the working directory. This behavior is inconsistent
> with standard Kbuild behavior, where KBUILD_OUTPUT defines the build
> artifact location.
>
> This patch modifies kunit.py to respect KBUILD_OUTPUT if set.  A .kunit
> subdirectory is created inside KBUILD_OUTPUT to avoid polluting the build
> directory.
>
> Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
> ---

Thanks!

Two small thoughts:
- Do we want to make KBUILD_OUTPUT the KUnit output directory
directly, rather than nesting .kunit?
- Do we want to make the --build_dir option relative to KBUILD_OUTPUT,
instead of the current directory?

Personally, I think the answer to both of those is probably no, so I'm
happy to take this as-is.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  tools/testing/kunit/kunit.py           |  7 ++++++-
>  tools/testing/kunit/kunit_tool_test.py | 19 +++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index cd99c1956331dbbfb06cf4ddf130db3dcf2a7c31..e3d82a038f93df0e86952da92461bc2e02f69ed1 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -323,11 +323,16 @@ def get_default_jobs() -> int:
>                 return ncpu
>         raise RuntimeError("os.cpu_count() returned None")
>
> +def get_default_build_dir() -> str:
> +       if 'KBUILD_OUTPUT' in os.environ:
> +               return os.path.join(os.environ['KBUILD_OUTPUT'], '.kunit')
> +       return '.kunit'
> +
>  def add_common_opts(parser: argparse.ArgumentParser) -> None:
>         parser.add_argument('--build_dir',
>                             help='As in the make command, it specifies the build '
>                             'directory.',
> -                           type=str, default='.kunit', metavar='DIR')
> +                           type=str, default=get_default_build_dir(), metavar='DIR')
>         parser.add_argument('--make_options',
>                             help='X=Y make option, can be repeated.',
>                             action='append', metavar='X=Y')
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index bbba921e0eacb18663abfcabb2bccf330d8666f5..a55b5085310d1bc54a549d3f36a83f7697fb8881 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -601,6 +601,7 @@ class KUnitMainTest(unittest.TestCase):
>                         all_passed_log = file.readlines()
>
>                 self.print_mock = mock.patch('kunit_printer.Printer.print').start()
> +               mock.patch.dict(os.environ, clear=True).start()
>                 self.addCleanup(mock.patch.stopall)
>
>                 self.mock_linux_init = mock.patch.object(kunit_kernel, 'LinuxSourceTree').start()
> @@ -723,6 +724,24 @@ class KUnitMainTest(unittest.TestCase):
>                         args=None, build_dir=build_dir, filter_glob='', filter='', filter_action=None, timeout=300)
>                 self.print_mock.assert_any_call(StrContains('Testing complete.'))
>
> +       @mock.patch.dict(os.environ, {'KBUILD_OUTPUT': '/tmp'})
> +       def test_run_builddir_from_env(self):
> +               build_dir = '/tmp/.kunit'
> +               kunit.main(['run'])
> +               self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
> +               self.linux_source_mock.run_kernel.assert_called_once_with(
> +                       args=None, build_dir=build_dir, filter_glob='', filter='', filter_action=None, timeout=300)
> +               self.print_mock.assert_any_call(StrContains('Testing complete.'))
> +
> +       @mock.patch.dict(os.environ, {'KBUILD_OUTPUT': '/tmp'})
> +       def test_run_builddir_override(self):
> +               build_dir = '.kunit'
> +               kunit.main(['run', '--build_dir=.kunit'])
> +               self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
> +               self.linux_source_mock.run_kernel.assert_called_once_with(
> +                       args=None, build_dir=build_dir, filter_glob='', filter='', filter_action=None, timeout=300)
> +               self.print_mock.assert_any_call(StrContains('Testing complete.'))
> +
>         def test_config_builddir(self):
>                 build_dir = '.kunit'
>                 kunit.main(['config', '--build_dir', build_dir])
>
> ---
> base-commit: ccd1cdca5cd433c8a5dff78b69a79b31d9b77ee1
> change-id: 20251228-kunit-kbuild_output-5d21a89fa603
>
> Best regards,
> --
> Ryota Sakamoto <sakamo.ryota@gmail.com>
>

--00000000000006afe20647a0338a
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg5G3CNqbDdzre9pt8nRdu4nEqWBBD
iFhu75iBeA6+4TswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTA1MDg1MzU2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAZ0xf4lgsjJOEz1nYgWgN1VVCtSWZ77E/nf7Ejn3K/bkb4ldtjFfcWwIeSJW0Kc+/
e7cCZd0WX0ZTrl2hDwHN1MHo9joK8k+bGlrvaxya0J9uyEXsTDLpAD0ODjxMo6pMzsP6pkOoNp8f
eQg7dEoKkWHoHoFlLYQYp7L5Y2R+RhBU1JQVvJ0NGT4M9YiaqAYOgq60RaKxmUD7WdW3Btp+Za/n
MN/PlLxTPCW1w12l9KOSLtgFP7sbWGgwUtCAJKnJOR93ggCfdwmMosmLPv0W7fbfoEfGNEdwb2+E
/xpMG+aWjQtU1sHobqQVFzYYWU8Z4jryliIENT5rIIjRTOKHFg==
--00000000000006afe20647a0338a--

