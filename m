Return-Path: <linux-kselftest+bounces-49135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5411D2EC23
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 10:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB7733045494
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A183570AB;
	Fri, 16 Jan 2026 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVC69cd6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F525356A37
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555838; cv=pass; b=bGRASZnBphK6hMvGpEfHpKBE26YgCV06y0TC74O5hYsu3dUSC1KjObCDu0+tSg7//oP76Jq1ik5w84fOMsz8T/DnMPjtNHlRrP6XoVuhAYZP4SfpsobsJ7qqNW2L4gMZ38ReJbMlPMSIy3xbxXyCCwQcn5c4pUx3ee+av7FERwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555838; c=relaxed/simple;
	bh=6KNEvfQtXcIY1fNeyduAVcCO0ceL2Qnv40SDH7bOgto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFzlQd40rvRbUVIlg/ZAQEAnJLDOzuOnxZ2lSI7PSqwmUd+kH15HkflEAwYfEFEPujKjt2LI/hls8EcX07YJo+jIxobnSBdy+stHF97KPqvw+Gw688fEIpC+l7h4uUk6Q9z75n3W6ALHz1gFViAqF3b/vlNE+XTyOxlaD3JwfH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uVC69cd6; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so21478935e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 01:30:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768555833; cv=none;
        d=google.com; s=arc-20240605;
        b=Mw0t0cCWc/lzMXjcWfocGlyZyGIWefz5GkAEUqKLLNMqm/Vplc6x1OF9ThPlk2EobV
         7HQGCxxjFyo2pcL71paCJyS5lbiOSufd2RPacByRuyyHuYsXFlGtAH53UNEWoatwzTwx
         NwqaYugKrwufb6nCMSab3QX3j8MUplFCkZxCd0Aodil5iMrlnK9CikpvGKBcPjpCN49R
         j9a0zGVuqs+zCKlM1jqiP+1xV0NvQfP59ATgQQeEgmPjFKTx2cp4MO8OmLXvumJ+AE6t
         Y+bUjS7vlY8nPR3jjt1Gd53vEwvY0QPyBo0jkI8RRRTkz9hVapPC6BjHXunRa7CTZvbI
         BLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dAUl0GMblGI56X30SIR3EDBwPD5EPhbwzVLX3i/wRUc=;
        fh=N+XU5fvaoF/fQiOStCUEbqliGa7bEK05FMli8ap3NvI=;
        b=DOd+/QWFH+IK1bRHqklQfmeoM+liUzeZvAb0+OT1m6lsnZb9FJvHsygWhyFwi+emZ0
         JK4ays0+8KOoBUlVplQ+gvK2ru8sUa2h2hZstF4mn/SLvEbOEQk/gMS1C1TvD0S/kJ32
         IGgkIFtIhRw0kE8tjUwMDpBCrhZ7JRRjWh+d3AHJy0rOV+xKuzX3DENOR75uKy/1cBTo
         +M5ruyvFtLClWi9MwJGMiffkqcWmUm0qdT7e/V/FKVXOAWddl/kTWeZMDrOr3loUPT9k
         8VGtYyzCFsAojAHpzImb542NCYat9m2ojlRK0yoDV18KVqHrwBW9erMBPeMFpPnugBKx
         4qnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768555833; x=1769160633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dAUl0GMblGI56X30SIR3EDBwPD5EPhbwzVLX3i/wRUc=;
        b=uVC69cd6dl6d8YnNQASyqg34rpdn4iaK8hF3/aPMgntfZj8ZESUCav8GuyCO5j8xxx
         SZ3bCHre8V1au1tPzsAfO4DBY3YeWH0cdpj8pIPvBnb1lXqtp7Q/QwXYGetLC+6lUUCI
         gergBMtKhGG6IUyvuwNblGHvLO1VeKDbp7fj36qJBaGY3nDvEZAHoKZ5EQuQ2+axbs+D
         58roJE4r2672W/QC7CSUAcSgS578JgVGYHhVjMVMthrk4Sy6HeJNvE2dsIp9Nym7Lcpw
         EwJMfkdFD6x6ZBweY9ACxoLKr/+MFUi0KZsC/Rt2IQqin9iLUpV7mBm8pBrm/jpAPV8S
         WSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768555833; x=1769160633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAUl0GMblGI56X30SIR3EDBwPD5EPhbwzVLX3i/wRUc=;
        b=YnpXpOzAglwKGnq82eb8R6eXCNh2z4LjDMMGwDABfUOxMtUB8J9+o/FqZd/tUa4Wqo
         DR8JVqncdzIsdSg9a7sKUFGkwXnwu6gi1W3wFX75cxHDQtcVhvnAoO4mo+QJ6bpjg6mo
         OzfiAgrF2sLmQGvCjWS6bUS7qVQGne54DE/0EF6H17x30Iplk+zr20zMmT2BE7ElqLug
         oopSClmMdcA9Dkcmih6ufunBgtGbc5wTr1jxxy3V0Ulurfhjbpgi6Kc4txiIOq9ziM9O
         XKFGoz5Q44HaPG7vOsTbyurbtqzYfC7Ltq4aoVnzm32O2iwuqleibn29Gq8xG40kLpV8
         FOJg==
X-Forwarded-Encrypted: i=1; AJvYcCVzbi29mwBrTYMmuxz4IjeK5UBN/7ApkhiwEP6sVUgPz8HILAfiyrmA623KSdbEtv2ZR7MOLl3aGUfen2jogz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW4iPL2SAUOxdomDByh5fng7wQcE2/HxI/ifcvvTzb0pB/VWp0
	81HZ7RFRIzwcvr5foUTZf8oBa2VQNgVGL5rAdZwWrol+OKYAb23rJyPXviQApIS7UqCoG290dH7
	JdxcYXDlly81BfTjuuPRQiCSCo1NVU1nZenyxeOKE
X-Gm-Gg: AY/fxX6TEEnA5XnQF+zoThfaZ/eM9B+vSBdG4OrTK4mJeUAZ1DTg3AaHPnEU3wNjJtn
	+DvUetKwCFWP454F9KiYY2Az9dauQecSmma5Sakwa/I9BIqsHsLH9s6WYIt8b59UvWX51BdsG/d
	S8TIJnzuqIqVBCBDQoSiPezA46rjheW0nbXQ5Vc6nbkibfA1tUGC0XRzlqz+4FT4ziUTyH9uiN/
	VrlIwo0rPaJSsgVZBPzj7eRYrNhn+R3nGhpJ5TRtOgajoFO5m/xocNeeHooF3zKZVcbZg==
X-Received: by 2002:a05:600c:4e50:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-4801e34dafbmr25638165e9.33.1768555832421; Fri, 16 Jan 2026
 01:30:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112041322.2168-1-always.starving0@gmail.com>
In-Reply-To: <20260112041322.2168-1-always.starving0@gmail.com>
From: David Gow <davidgow@google.com>
Date: Fri, 16 Jan 2026 17:30:19 +0800
X-Gm-Features: AZwV_Qju1iQ5ldQ5W0MvdzQFEWskCs2-eM2KChk-yMN2FCHphFFxNC6XmryzbtY
Message-ID: <CABVgOSmnqS5Qy=HVFTj_JivoBggKvw-iKaX==4C0SGLK82Tf6w@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: suppress confusing error output in test
To: Jinseok Kim <always.starving0@gmail.com>
Cc: brendan.higgins@linux.dev, raemoar63@gmail.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000032ca6f06487dfe89"

--00000000000032ca6f06487dfe89
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 at 12:14, Jinseok Kim <always.starving0@gmail.com> wrote:
>
> When running kunit_tool_test.py, the test_run_raw_output_invalid test
> prints invalid usage text and error messages to stderr. This happens because the
> test triggers kunit.main() with an invalid argument, causing argparse to
> print the usage and exit.
>
> This output is confusing to the user because it looks like a test failure
> or usage error, even though the test passed successfully. Furthermore,
> argparse displays 'usage: kunit_tool_test.py run ...', which is misleading
> since the test script itself does not accept the 'run' command.
>
> This patch mocks sys.stderr in the test to suppress this expected error
> output, making the test execution output cleaner.
>
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---

This has been slightly annoying for a long time, so thanks for fixing it.

One minor nitpick in the commit description, otherwise this is good:

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit
description?)
#11:
prints invalid usage text and error messages to stderr. This happens because the

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  tools/testing/kunit/kunit_tool_test.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index bbba921e0eac..7a8ba8e4f1d4 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -8,6 +8,7 @@
>
>  import unittest
>  from unittest import mock
> +import io
>
>  import tempfile, shutil # Handling test_tmpdir
>
> @@ -688,8 +689,9 @@ class KUnitMainTest(unittest.TestCase):
>
>         def test_run_raw_output_invalid(self):
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
> -               with self.assertRaises(SystemExit) as e:
> -                       kunit.main(['run', '--raw_output=invalid'])
> +               with mock.patch('sys.stderr', new=io.StringIO()):
> +                       with self.assertRaises(SystemExit) as e:
> +                               kunit.main(['run', '--raw_output=invalid'])
>                 self.assertNotEqual(e.exception.code, 0)
>
>         def test_run_raw_output_does_not_take_positional_args(self):
> --
> 2.43.0

--00000000000032ca6f06487dfe89
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgt8+AS2L6Ft8pLQmAnzq5qdCYcn8s
IKTbFbo9zJ7f8+gwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTE2MDkzMDMzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAf4FyH+tR6AR+lg4OFwEEV28DaQvNFSGw3QzfVXw6kAlvboU33ZV9uVFigiFCvWfT
Rpf6GmMrodgtq6qu9lRJtH/mNkJJkCcmDpMiPcZYurojiixInJFe35z03Ga/h3KBPfqwfibYdSsd
KQlDM+EwnE0Jjk9w6e3FGhbXPngBv3fXCTuzdb1N4B322LU99SG45WFllmaER5HCjBgd6MuEyHfj
o0w70dBCSlXyPyYhxrB4BVEmwf8b5dKzQqDzn0VjnPN/O3Es3nJUj+98Q/j6+HEW7aFVAEQyEQLc
D1TJbslQQJ+WVGSUr/2eXlQEKyTAfg34F3PhQXRZVjVD51JHHQ==
--00000000000032ca6f06487dfe89--

