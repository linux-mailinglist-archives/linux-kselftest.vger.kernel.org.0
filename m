Return-Path: <linux-kselftest+bounces-30829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 979DCA89693
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 10:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DB63B7C19
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 08:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66F82820A8;
	Tue, 15 Apr 2025 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVcNpqGt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234127FD4C
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705611; cv=none; b=j+0wi8i3UZbwLxh/EuZ9xsWE4xtHrUXMGhHh1Nkibgmzt0073mpxZwUPDIX9koz+pAQXSj7xVPDGo6Rt4KwXv4rGPAHTQr82AxLrBOyRIguoQEDPPLblc3WJhU3zLcGSJ+l9vg00oePhLjP4NHtw7hLH6tHTGmOXWTh9QIqpHq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705611; c=relaxed/simple;
	bh=XYfxm7lRBy+E81MvaNcYmadDdMuIGJaLn6yxeKF3MpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOupk29ZzUjUPG9CRkvdhLDoPOA3+uWYF04pTcgMgrCUC2T+G7cFr5xSAIATa3L0vdYxLVo1H3Jz8FoFD/JYgMuRxhhLq3unC++ZsU/s8RRbfhMbyHK3IMHQ684q+F8gaaIG/cOQ6vx7rqTk9CDoLO63xeSnmct6Ly3W56/n5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVcNpqGt; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5a88b34a6so504881485a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Apr 2025 01:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744705609; x=1745310409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=36mhK7BIeZEyRMUidDL6vDPUMxJlTuKvSPgmW3fEfOI=;
        b=mVcNpqGtUR8anZS8oo2WT2ujPcg5nF5giBTmgbpOWTWuH8zaoHqIauJfo5rJ9T2dng
         pAR39vpgcEKEQXwz5KKEnz7V1sW6lJKc1eRW6+KLWCzn2SZEaiiVfg6oinHMMFvbdhyz
         bRWxuxwbnyTKEuD/etQwpafkaddjywA08HiMwaQuCd6TGK6u3qkeN/D7pGic1kG13LTq
         UVS4o3T1Rfkcvm/BMHEbi1DgVY6VNWx1vZefrYVr6Q6mxcnIe3u469wj2dskqeo/WF6N
         qsUwwQijlDnPK5WK6spdTSg7WAbVJnahrUBnJhShNhZeu4lyAsMTVraQ7Esc3Xrs2co3
         NObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744705609; x=1745310409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36mhK7BIeZEyRMUidDL6vDPUMxJlTuKvSPgmW3fEfOI=;
        b=JGCfqkfe8Ak6OH2g9G02en6CT6epAjBKXP+oUQ6YuD8CeuatkFSLSryEzpKH+cV5A6
         033ooHzygHRaH8xYRpGcTEtpz3DXkTQX1d664u/JeR/P383Xr45IfGEQ7TwSLHfieZnC
         FeK4ntFsPUBfqFI95+yuTdSEzU/H1AyQTgiW5/xacqXvSQhwmM+em9frWDG0XDMnAqey
         77M8fW+i0HqNLFyyoUJolAjQX6lBvRqyAwIQa7JTKQQXfeKHSzG9h4OjnFOYVaMei0Qe
         NqunHZPw03YK4cw7SNzU7zAnbbUZUEv6R6SdIAxDf8dkWqP5v8yNxd0EhmhojlLOvBcV
         +BBg==
X-Forwarded-Encrypted: i=1; AJvYcCUh2dSkIA7HWVHmW8FxAFIk7DZjuXudm3vl00gezcP5eZKqhxyTKwvKqNKqB8qUjT+y3/5rof47Evs9fTHKAd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkjiUF6iE/Hi+mCY9pqu32rLZfM490Beyh4SFt/Z8vqu6m4q3F
	CIloC8QmL8eq+bN+I3LfFcckMoU7SHspqyluo9eo9pyrMk92mNJApE1sUjjIVr2c/XypDaFPkM+
	/OwXbq6nuPCYX241E3wGo31GObvdCIB8Im7sl
X-Gm-Gg: ASbGncvnCQOijZsmnSA+it6Ck3Z3Ehmj8F4WjFpAgIc+osMYhcAqZufJdkkfcJMLmZE
	JjwbVdD6iUngl7RXLlwXmTT7AxCTH3XOkArcqqnILuZEK+31k8xwsPKakCvNfAGYDde1G91/2jI
	c7tdlZrrbmSoqMqKMHadoSSC0=
X-Google-Smtp-Source: AGHT+IGHXMBpnFEKgrvNYSfgOgdNAj2t5br74Ns0ujzf2JkqvYEzJ0GoquiLHiY6mEhVaNX7EwtItyJ7QehuXdNca9g=
X-Received: by 2002:a05:620a:2887:b0:7c7:a5cb:2b65 with SMTP id
 af79cd13be357-7c7af14e2f3mr1843775685a.26.1744705608510; Tue, 15 Apr 2025
 01:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415-kunit-mips-v3-0-4ec2461b5a7e@linutronix.de> <20250415-kunit-mips-v3-2-4ec2461b5a7e@linutronix.de>
In-Reply-To: <20250415-kunit-mips-v3-2-4ec2461b5a7e@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Tue, 15 Apr 2025 16:26:34 +0800
X-Gm-Features: ATxdqUGMdfu8V5coif4GbIRv4cQyyOVSNJS0mYgKNE44UdIBfCOgwXQlLVBaG6A
Message-ID: <CABVgOSn3DbDy1Vb7KGejb73ahf-JuTF_-u+nM7-F=0iGpSuebw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kunit: qemu_configs: Add MIPS configurations
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001096500632ccee02"

--0000000000001096500632ccee02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Apr 2025 at 15:10, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Add basic support to run various MIPS variants via kunit_tool using the
> virtualized malta platform.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---

Seems to work fine here. Thanks very much!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David



>  tools/testing/kunit/qemu_configs/mips.py     | 18 ++++++++++++++++++
>  tools/testing/kunit/qemu_configs/mips64.py   | 19 +++++++++++++++++++
>  tools/testing/kunit/qemu_configs/mips64el.py | 19 +++++++++++++++++++
>  tools/testing/kunit/qemu_configs/mipsel.py   | 18 ++++++++++++++++++
>  4 files changed, 74 insertions(+)
>
> diff --git a/tools/testing/kunit/qemu_configs/mips.py b/tools/testing/kun=
it/qemu_configs/mips.py
> new file mode 100644
> index 0000000000000000000000000000000000000000..8899ac157b30bd2ee847eacd5=
b90fe6ad4e5fb04
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/mips.py
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH =3D QemuArchParams(linux_arch=3D'mips',
> +                           kconfig=3D'''
> +CONFIG_32BIT=3Dy
> +CONFIG_CPU_BIG_ENDIAN=3Dy
> +CONFIG_MIPS_MALTA=3Dy
> +CONFIG_SERIAL_8250=3Dy
> +CONFIG_SERIAL_8250_CONSOLE=3Dy
> +CONFIG_POWER_RESET=3Dy
> +CONFIG_POWER_RESET_SYSCON=3Dy
> +''',
> +                           qemu_arch=3D'mips',
> +                           kernel_path=3D'vmlinuz',
> +                           kernel_command_line=3D'console=3DttyS0',
> +                           extra_qemu_params=3D['-M', 'malta'])
> diff --git a/tools/testing/kunit/qemu_configs/mips64.py b/tools/testing/k=
unit/qemu_configs/mips64.py
> new file mode 100644
> index 0000000000000000000000000000000000000000..1478aed05b94da4914f34c6a8=
affdcfe34eb88ea
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/mips64.py
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH =3D QemuArchParams(linux_arch=3D'mips',
> +                           kconfig=3D'''
> +CONFIG_CPU_MIPS64_R2=3Dy
> +CONFIG_64BIT=3Dy
> +CONFIG_CPU_BIG_ENDIAN=3Dy
> +CONFIG_MIPS_MALTA=3Dy
> +CONFIG_SERIAL_8250=3Dy
> +CONFIG_SERIAL_8250_CONSOLE=3Dy
> +CONFIG_POWER_RESET=3Dy
> +CONFIG_POWER_RESET_SYSCON=3Dy
> +''',
> +                           qemu_arch=3D'mips64',
> +                           kernel_path=3D'vmlinuz',
> +                           kernel_command_line=3D'console=3DttyS0',
> +                           extra_qemu_params=3D['-M', 'malta', '-cpu', '=
5KEc'])
> diff --git a/tools/testing/kunit/qemu_configs/mips64el.py b/tools/testing=
/kunit/qemu_configs/mips64el.py
> new file mode 100644
> index 0000000000000000000000000000000000000000..300c711d7a82500b2ebcb4cf1=
467b6f72b5c17aa
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/mips64el.py
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH =3D QemuArchParams(linux_arch=3D'mips',
> +                           kconfig=3D'''
> +CONFIG_CPU_MIPS64_R2=3Dy
> +CONFIG_64BIT=3Dy
> +CONFIG_CPU_LITTLE_ENDIAN=3Dy
> +CONFIG_MIPS_MALTA=3Dy
> +CONFIG_SERIAL_8250=3Dy
> +CONFIG_SERIAL_8250_CONSOLE=3Dy
> +CONFIG_POWER_RESET=3Dy
> +CONFIG_POWER_RESET_SYSCON=3Dy
> +''',
> +                           qemu_arch=3D'mips64el',
> +                           kernel_path=3D'vmlinuz',
> +                           kernel_command_line=3D'console=3DttyS0',
> +                           extra_qemu_params=3D['-M', 'malta', '-cpu', '=
5KEc'])
> diff --git a/tools/testing/kunit/qemu_configs/mipsel.py b/tools/testing/k=
unit/qemu_configs/mipsel.py
> new file mode 100644
> index 0000000000000000000000000000000000000000..3d3543315b45776d0e77fb5c0=
0c8c0a89eafdffd
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/mipsel.py
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH =3D QemuArchParams(linux_arch=3D'mips',
> +                           kconfig=3D'''
> +CONFIG_32BIT=3Dy
> +CONFIG_CPU_LITTLE_ENDIAN=3Dy
> +CONFIG_MIPS_MALTA=3Dy
> +CONFIG_SERIAL_8250=3Dy
> +CONFIG_SERIAL_8250_CONSOLE=3Dy
> +CONFIG_POWER_RESET=3Dy
> +CONFIG_POWER_RESET_SYSCON=3Dy
> +''',
> +                           qemu_arch=3D'mipsel',
> +                           kernel_path=3D'vmlinuz',
> +                           kernel_command_line=3D'console=3DttyS0',
> +                           extra_qemu_params=3D['-M', 'malta'])
>
> --
> 2.49.0
>

--0000000000001096500632ccee02
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
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg+auRn3FUhKELrjooLIb5+LIemuir
0pEY3vXExZ8sG/YwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NDE1MDgyNjQ5WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAnznTiZ64MzLSUYlqXWHLJbasD0ewBqU/JfY95MFWojZncEBl0Yl/Z9qLrsqxRpvL
N03uTn1PZTkMSW6Xe1GSMxc66odRm1PVzDSXpihQaSrBig5oRQdxrYRgUP6RIqrb5GwMa3ybjIYn
M0X0H4nCVJIYWJQ7xZkQKj45J0O9y8QAKacIqf1wElKIdDR39Oj2GliWKCZ6dfqsmoDOR4miW4yH
8Sscjj+U3oGR/VwNatTEBYIomzoE1ZsiJ7NKjanegMljsi+OPAh4HCuvsxFqmpKao9ViH71WrIbR
gYpJfzGZc3UEOYykV/6v9tq+qFLJaGxdnFE3A1OYSvFlxC3WPA==
--0000000000001096500632ccee02--

