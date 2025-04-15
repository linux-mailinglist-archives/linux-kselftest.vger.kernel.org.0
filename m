Return-Path: <linux-kselftest+bounces-30872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 202F7A89F15
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 15:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23EB817EA67
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5CA29B768;
	Tue, 15 Apr 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AoqAh9ld"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81229AB0A
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744722694; cv=none; b=lHnAnOQkOP8g5NdPmgARpBldWgeiBPl/8D4RxIOXfuUtTiJoeakTz39rgUo2T4SlEH3ZtQx2Mi8o/gMbtiUNkgEuebtt4RtvXFfZosxLFehS16Re0jcH4nJTRDQD80IvQkcqpkcyY0uh/yX/JptpWyi015IYmzGD1x+XxRYW2NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744722694; c=relaxed/simple;
	bh=w2M1gL1wqBV035bhaeNxhQRrqKUSm62uwjfVgXoeB1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBkCkGBGxfPDDdd9N9YMYIjvMONV2CSPd080iSCRmVRqPy+vrmSfuXEPVpw25Vtgs8wU3iLTbijidIhYraXMiQ0stCt8ROIQnqpXllEi8xCgbFlxwf+FNm4btsunzq2VJykptZlHESkgNg5D81ARP8taFlxIc72w9JeebSugFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AoqAh9ld; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8efefec89so50725236d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744722691; x=1745327491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pnrypl4Suf5Q537UeQ0pj0yU7LD49Ay77DV2BmlTaNs=;
        b=AoqAh9ldGnYKYZ7Kjpaba2YWMWmFp+mf6bu3wZFsXb+p8mO23xzRa6wf4ipPJ0mtRX
         2gokavxhifj1iDR7D5miahLZRBxNtHWLXHFgTqGKnSRWUR9EEkR4SeSSlOaeBKSWvctP
         kubGjR5kz5fUQFwccyjvzZ2zLByY+Ug91N6rPRY+V99NkqQ7xjR7i15AMa2pCayBXbvc
         QulLTGGexD3IwkwtjhloB2qsM3H/l96+R6P0bIWSlNh2tOHC0rRQEJiBlWcHj33XroHc
         xMn69ADo0uIRmHrrzhMFNe/xKF141juygKFJjPo5l+A6Gs0/3HncyDvFYun1/sGsHWvI
         xZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744722691; x=1745327491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnrypl4Suf5Q537UeQ0pj0yU7LD49Ay77DV2BmlTaNs=;
        b=TGtSfH3T4Xw1QQ67Cm0+WyGtfdxL8NjdD5GLJE/mFLptqpO516UE/FaYHua5Rgg3d3
         YSvYKk+e//cpmTih2wkS0+uyJ0PUe02AgQ5gtdHSy/6cm6EnhfXm8fRReZXeHBjOw8qi
         7A2asUVGJIhFUB4YoWBsR88pdj0uhqqh+cXUXg5t1bHQqR0xHakn+w8/udMU3oP8npZ9
         uIVPS/PjEP96LvVqgM3IEddJvYF7eOr+I1269oipX4ea+go2khr0WvJd1hNp5DzivsIL
         6X+BaT6cYJPoVXpO+WlxYsjOqM/bQxWdVRh7j/JybRbfu0Kq9m/fgiLvoEgLzr4Ig+2U
         afzA==
X-Forwarded-Encrypted: i=1; AJvYcCU9tsDqqfPwng3VWiuCQqH1hEruUTRzYsCLl7txEGDIGZ/7y7ZVRoJKpJA2GHN5ZCZZc7uAhxz5MBCB1IF3+tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFIFJyCMU5zfSx/TAcQgeiedD+2Uzz+FYoVmNXz1vrmlrqSfZO
	R1ZQu0+JQ4ZDJlQKs92F8ca9bEOlp2mSJu6yiTJ1Fk4NZIxbwxdyH8W8dWJ09ufpsrEcpTScsxx
	mXRQZl8ILTfeAAFmiJcm82ucuShqFGeXloLE+
X-Gm-Gg: ASbGncut+TJGDUcm0d0GBz2hiU0bvQA44oEDoy4RUT5+PKBxK8SKg3SO5j8dzuHmvFE
	CssHsvd+t3fJJAl0WOe0aFe7LDppEnLUuDp9P/1BKLSM5HIMywms437VYtYLuFS6rdZRYrr2j+K
	9opguwOTSoXSXZipzRw4zeqdRZTmzXVQBXQg==
X-Google-Smtp-Source: AGHT+IHUhGrhdBK0K2g+i2RXQB0Bg71hKoXw/u7v7JekyEGawXEm8IcCbJ2wiLGoLffxldwQsHbdV2PWrKV1irie/MI=
X-Received: by 2002:a05:6214:623:b0:6e8:f166:b1a0 with SMTP id
 6a1803df08f44-6f23f19e260mr306449596d6.36.1744722690808; Tue, 15 Apr 2025
 06:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-kunit-ppc-v1-0-f5a170264147@linutronix.de> <20250415-kunit-ppc-v1-2-f5a170264147@linutronix.de>
In-Reply-To: <20250415-kunit-ppc-v1-2-f5a170264147@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Tue, 15 Apr 2025 21:11:16 +0800
X-Gm-Features: ATxdqUFwhP3sRpVojMHru4fdlHLsJs1-vo1qEIsQOxh5fy23tF1izwJW8Yn6toY
Message-ID: <CABVgOSm6TigevXXL7c5g9AmarzYpHtWvuRJd7ubp0K9bgpwVSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: qemu_configs: Add PowerPC 32-bit BE and 64-bit LE
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000043482f0632d0e8ac"

--00000000000043482f0632d0e8ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Apr 2025 at 17:23, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Add basic configs to run kunit tests on some more PowerPC variants.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---

Hmm... a part of me wonders whether it'd make more sense to rename the
64-bit one to powerpc64, to match e.g. arm/arm64. But it's probably
not worth the breakage for existing users.
Equally, I doubt there are enough people who care about 32-bit little
endian to warrant a powerpc32le config (and if there are, they can
always add them in a follow up).

So this looks good as-is, thanks!

Reviewed-by: David Gow <davidgow@google.com>


>  tools/testing/kunit/qemu_configs/powerpc32.py | 17 +++++++++++++++++
>  tools/testing/kunit/qemu_configs/powerpcle.py | 14 ++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/tools/testing/kunit/qemu_configs/powerpc32.py b/tools/testin=
g/kunit/qemu_configs/powerpc32.py
> new file mode 100644
> index 0000000000000000000000000000000000000000..88bd60dbb9483af244d42d3d3=
6c769ce2effe2b4
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/powerpc32.py
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH =3D QemuArchParams(linux_arch=3D'powerpc',
> +                          kconfig=3D'''
> +CONFIG_PPC32=3Dy
> +CONFIG_CPU_BIG_ENDIAN=3Dy
> +CONFIG_ADB_CUDA=3Dy
> +CONFIG_SERIAL_PMACZILOG=3Dy
> +CONFIG_SERIAL_PMACZILOG_TTYS=3Dy
> +CONFIG_SERIAL_PMACZILOG_CONSOLE=3Dy
> +''',
> +                          qemu_arch=3D'ppc',
> +                          kernel_path=3D'vmlinux',
> +                          kernel_command_line=3D'console=3DttyS0',
> +                          extra_qemu_params=3D['-M', 'g3beige', '-cpu', =
'max'])
> diff --git a/tools/testing/kunit/qemu_configs/powerpcle.py b/tools/testin=
g/kunit/qemu_configs/powerpcle.py
> new file mode 100644
> index 0000000000000000000000000000000000000000..7ddee8af4bd79a85a1dbbbd04=
46d3ea47c5947d8
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/powerpcle.py
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH =3D QemuArchParams(linux_arch=3D'powerpc',
> +                          kconfig=3D'''
> +CONFIG_PPC64=3Dy
> +CONFIG_CPU_LITTLE_ENDIAN=3Dy
> +CONFIG_HVC_CONSOLE=3Dy
> +''',
> +                          qemu_arch=3D'ppc64',
> +                          kernel_path=3D'vmlinux',
> +                          kernel_command_line=3D'console=3DttyS0',
> +                          extra_qemu_params=3D['-M', 'pseries', '-cpu', =
'power8'])
>
> --
> 2.49.0
>

--00000000000043482f0632d0e8ac
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
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgRrNEBFZWZgjKsHnMZZhsApBGJASj
PWRx5EQMwTfyzNQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NDE1MTMxMTMxWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAaKsWfo/LrmHMgne9ZNBTfIIZ9cOUNlTNUigoOd9jjNNirjSXm1C7Mpmv49KIUYNg
iNmByY/jr1Wx83ZqMGbx/Tp93GDwLVTWXGMDTmUt9G9Nu4MzdHANGTTLMXRnk32LxPVjjn/+iOhI
GA8Q3Hx3/XPzYRg3yxghwm0aXmYeoV+5h1NGFK1i9PGMygmwkvTvtNJqfk5F9D5HXgsPCNhG+eUN
hbgbQD4wd+7Dwg+NSRjZ0JNF48sp07CXBdP8jyea8wIBZ+5YuRAS3cKoZipO/79REUcF7Orcemjc
ISdN8dwQ225LstwPtci0iQkqQNX/vYD1ru0xzdiECz4sle8MgA==
--00000000000043482f0632d0e8ac--

