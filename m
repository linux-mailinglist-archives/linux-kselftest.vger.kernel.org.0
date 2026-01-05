Return-Path: <linux-kselftest+bounces-48181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B05CF28C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 09:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFB24303803E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6378E328B46;
	Mon,  5 Jan 2026 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DKJYSKcn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64172314B69
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603384; cv=none; b=Id1sqx83hH6Q2fkAkc4XqCFt3T1xHhCEO/FreSI7kAJjwl18XNFRt0z0yTnQadPKid5blSqYgm1XkTdokwK0Jl026HL19suPaKHzTzgsc8dFDTyiS995b4W9H23P+bY0Twky/558TTDmCd9tpQIDFOmVkY7JAxAkieyFMOCh5S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603384; c=relaxed/simple;
	bh=iTlGreV2w8SjHKl86xelDjC/ZW1j+XTSo7S5D75L4tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqSE2Bb2TGKb2ZSja6o1y/DdoYUg3OsAP7dSSirq+k0lv9Ve2T/BMDukahcosOkOBKhK3QWqTKy395VHS/RndSyOKHPC6DobMJ3/rbaLNmBfi6xwV+o7UfvtyLPfiyFNk5lihDrAjawAnACgj80LCppS9Kzbpl+/lATdNBs4ezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DKJYSKcn; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so5620497f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 00:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767603381; x=1768208181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qihe0EaKGLBEO/eRXXQkA9oA7nKyELGCzbs3Dp/akrc=;
        b=DKJYSKcnuXOOyS044D2ODAOK7FtQzygaq4IUyRPmcs5KgPM7UgvlHV5/JfgO9DXpL4
         CQBK/1MPEVGSPEpxooK3G3YwA/RWcB5FgF+6oWCJuXvdYAkkFUlvzMLsHax70w1vfpP1
         ygcvEelJK4gT7T4gTBSRhBDBEV6kg7lCC1VF12qHZ6/TS9MJsyPxQwrQfFMydqmb2IEe
         RHYN0aaqXXPTAPLmONZMDjo9UrBZw1KHN7Yktq0z90uwVik1bioulmfBnkAdIg42KlyQ
         gt2jvzmNZmIkVik+7CGWLH2uSPDSl04nA5AIu24iPLgDbcoiiWUttceKyRhPkn+83PP4
         6bLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767603381; x=1768208181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qihe0EaKGLBEO/eRXXQkA9oA7nKyELGCzbs3Dp/akrc=;
        b=CWygprwJiFqLcSuC9LGPyfqNu72KVbI2AH6UdoKqvswoIMrqKsBpBDrudQJhFauIcE
         fnOgHdSmTJukDnAV9DBAQB5QyL5kDEV8Qi09TTm9RQ1rRVRw7IvnSSiTqBc6HtLphCTS
         baO3WEVj/I1MFNK8RS+KvjleYMc0wL0E6IJsD3SXZbZgxcKu1RoLRMnoP+1NUWFSF6YA
         59CMIUQx9vRWDhZlEZ44QXKVFNHm8oyCLatGxah4cqrrOBaetVE6qza+hETIqXSCwz2s
         kPummDtKrPE9VJNyMJzN2dQufi12FTZMOpagHTHQpthBTKciim4+PvolPMBHGWnl/SSU
         hJDg==
X-Forwarded-Encrypted: i=1; AJvYcCXADy9egFoq3h3hDfQwj0hyCmsZnyKuvYLRuORpytjqDrr57PXAN7BvSA6LpSVgG3Pa8pwYdrXBFM+a2Xd+2wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdOb+86hg0Aj0hX1nqFTBfQIGNKa31yv54jq3jI0TbKzUJHPBu
	QvlYZ78NOJeSo+uTusCxsN1WcHLioFpFChpT73sRhIP4QaAK59h5vMesA/UWSGrOwuvgH+XtmVF
	ANDRsg9FCBbMDWrfbiTGj/fzwjcR4MX66JQTIGh2U
X-Gm-Gg: AY/fxX4SZEqDZN2XRBHFYRuY6jwEP/cWXjX5c41OpAWsjf/YRaq1RUP22TtsTdU0wJJ
	XpWOuMjIJoQ8LyEYu7jkw86Y4zlZt5wFdomjQstFxBUpTur8+OvqY9B5m0meKUHrw9WNpqH6jen
	v9VEKkfz4VZwgrT5cSMyjTbtW0oDYt/XuzLgnj8s+Pf89o/VtzaLGVV3nhcx30uTWS7/V3aYFHj
	SKuFvvTKhCKjPQUw9fENgQ23tPfeQtKISAakKrJMgDhIVuzFXJcodaxmneBzSX+YLNYK6llGSas
	6iKs
X-Google-Smtp-Source: AGHT+IERv3CsQkGfbsDRci9yRLrECICMOgPW3EyBxK6riZ2LYJzAOtZdaBZmlhrEwEnP9z4jwtt8jjN4EO75TABY+5o=
X-Received: by 2002:a5d:5d88:0:b0:432:8537:85ca with SMTP id
 ffacd0b85a97d-432853785f1mr32422283f8f.50.1767603380521; Mon, 05 Jan 2026
 00:56:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230-kunit-pytest-v1-0-e2dae0dae200@linutronix.de> <20251230-kunit-pytest-v1-2-e2dae0dae200@linutronix.de>
In-Reply-To: <20251230-kunit-pytest-v1-2-e2dae0dae200@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Mon, 5 Jan 2026 16:56:07 +0800
X-Gm-Features: AQt7F2qsUKqLNkIiDkVToIFeEbFdUvyqYTUmPYNvnk6O-0DofwdM4lKe1jGRIa0
Message-ID: <CABVgOS=gU1_GFN0yyA0MzF_QPY3ueLPvC0egZqP_n210q4LsGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: tool: test: Don't rely on implicit working
 directory change
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a330ea0647a03bb8"

--000000000000a330ea0647a03bb8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Dec 2025 at 20:56, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> If no kunitconfig_paths are passed to LinuxSourceTree() it falls back to
> DEFAULT_KUNITCONFIG_PATH. This resolution only works when the current
> working directory is the root of the source tree. This works by chance
> when running the full testsuite through the default unittest runner, as
> some tests will change the current working directory as a side-effect of
> 'kunit.main()'. When running a single testcase or using pytest, which
> resets the working directory for each test, this assumption breaks.
>
> Explicitly specify an empty kunitconfig for the affected tests.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  tools/testing/kunit/kunit_tool_test.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit=
/kunit_tool_test.py
> index fd7ca89596c0..584275ce6ba6 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -466,7 +466,8 @@ class LinuxSourceTreeTest(unittest.TestCase):
>                 want_kconfig =3D kunit_config.Kconfig()
>                 want_kconfig.add_entry('NOT_REAL', 'y')
>
> -               tree =3D kunit_kernel.LinuxSourceTree('', kconfig_add=3D[=
'CONFIG_NOT_REAL=3Dy'])
> +               tree =3D kunit_kernel.LinuxSourceTree('', kunitconfig_pat=
hs=3D[os.devnull],
> +                                                   kconfig_add=3D['CONFI=
G_NOT_REAL=3Dy'])
>                 self.assertTrue(want_kconfig.is_subset_of(tree._kconfig),=
 msg=3Dtree._kconfig)
>
>         def test_invalid_arch(self):
> @@ -478,7 +479,7 @@ class LinuxSourceTreeTest(unittest.TestCase):
>                         return subprocess.Popen(['echo "hi\nbye"'], shell=
=3DTrue, text=3DTrue, stdout=3Dsubprocess.PIPE)
>
>                 with tempfile.TemporaryDirectory('') as build_dir:
> -                       tree =3D kunit_kernel.LinuxSourceTree(build_dir)
> +                       tree =3D kunit_kernel.LinuxSourceTree(build_dir, =
kunitconfig_paths=3D[os.devnull])
>                         mock.patch.object(tree._ops, 'start', side_effect=
=3Dfake_start).start()
>
>                         with self.assertRaises(ValueError):
>
> --
> 2.52.0
>

--000000000000a330ea0647a03bb8
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgcmmCYUHuSAl+Y30fo/Nf+Q8ItlF1
EIi7/5hG/5VnweQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTA1MDg1NjIxWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEACa/ZE6/Kn8+sEmLWb8MPQdJnfiPYAE8v1sAgh7c1GzcicqlAzIGrgXZMFp39D9Y2
KTZNsxvZ0NO1we/jBS1znt+EKEXbDCHdRqlp0ATCDkV2wzaV0Nt1bgPIXDElcdTr10gRaii/Ps3F
c4tEabZD6Mz1I6UaKl/oDWzVIM07YE1iDQBgn1WcX7RmkZbgq0ac+mxi753IkgJcYgJG3npMG81/
PvJJYh+y3uH0xjx7gyizYm7bXKvg3I0T3/gUcoA8UILJriHwFqrr3VV3hwisBSywA980kQl0BdRD
BRULtumcHuA+ADHUDh86skM1ZJ83pDTLdjgvhPzoPd4Ueb0Dpg==
--000000000000a330ea0647a03bb8--

