Return-Path: <linux-kselftest+bounces-48182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A683CF28D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 09:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD1613014AFF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 08:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B7D2E62B5;
	Mon,  5 Jan 2026 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IIfduynE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB972D060E
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603396; cv=none; b=JKRb7Pc32xtt9KEuxB6CB4BC2o8MCfwapQrUvKr2AML2y8L5qaXJvNoNIgzPUmFZ27pXQdA/C6IbMWxrSYJp25MEt5PAJ58PkboKE5Y8/LHelMY8U5A+Cd+KyKsjKn8s31/8Yl7vxgqaUjwZUvdQ425kz/gqmKn1c4FyV9Rx2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603396; c=relaxed/simple;
	bh=XvELefyUPFRtNZ59Ma8IE8ylnRZfF+jSRwPTUINV9DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZM1DkLwjBR3tC5oCiI6XLZ6xsfO/3A7cdRMbCwberc++q4uWYNUaA3vml6KAytui13xDS51IoATa6mzACs88JSwXsMIJuCG1lRDDk0Q2VYB91JQrrDNfbnejJ7aY5uvd82MWmiP+TxD1jJ+LF2eeFtQPDEGTKRovc4MxqtcGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IIfduynE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so6900017f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 00:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767603392; x=1768208192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7WCZ9b0JAQBcRBQIiUYHjvh9zl0gsgJP/p1j83wck7I=;
        b=IIfduynE1SpuzcvEe8H2JmWrfTduW2YgTUGfeadxsZDGt2iTzXS4wsG7tZ4a+B9osa
         vNeGpvLPNZbxFQAmH/+rF6kkxYVDPftLRfUJmNSnUvGJEiU0i8zIGzVsGc7K0EQ4zRtu
         AwVHT7ygNlsvI83mJiyFkv/LcQ4OC4Hu2i3WC8DH+NRk8tqdRKNnunxor4e42ieHMClm
         lJwy+IsZd6K1p5SLWHCpweRU96E+POQShsj/n4eD86toBVL2l1jCIfsJe78xysr2Pbxk
         +CqktdDoLM508uTI7qD9W5CXORvMTRMUnRF0HzRUqAL8IMRu/Ey1UDc48bAuUS7DUNob
         9yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767603392; x=1768208192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WCZ9b0JAQBcRBQIiUYHjvh9zl0gsgJP/p1j83wck7I=;
        b=nm0FgGf7rSwLcnuCGVR4JZbpRQBiTaRCaOnb+QUHdO0rt3T0qp1Qjhydvj/sklZvHK
         l7SbzjspVoXUk7glxwroEOLrC5so7w9zfhosTIyK5KTzgtYCGgByZNIrLU8RmPX6BFOA
         dkamlShWQLxyYoIq/4CJ6AV2aENZM6nvXSwLfaD56NjVjs54Fnq2ZywPhdnP1VPBVIJU
         bswQEtZe9n5pslXxU53UWj+gy+ysNBHgNuD7Dbc4IsEjnsRrd1wYiW+WgcRcCLdKehnx
         FuU5BooJHNmdfhmOWg6Fc4OGDBS9etce6SEG+LVbevkLGRH4oqmxiN1FZTErnSRHg2Ej
         At1A==
X-Forwarded-Encrypted: i=1; AJvYcCW1JC1hgSdRgUhi/DQSUvf+k3ZQj5Ufc312aDLf9ICSNm5brIEWIpp3Fn+pOG3piUE2Cs6eOo89ah9X9Nor3Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoy2wHBtZs31CcadD6xTU95BOLkAHOGJbI5SqWTd+9tqceoG8h
	GKjVpTLmFIi4aTuHOy9Pmz0Yof2lXRbp2OcKe7XiWl9WP9DSrcZU4UOnpu9mRtTEZ/2NvRe+PMx
	FS4bzn1itAd9/NtWKfOHM9j1xSV6qtyEnd4QMn2LokLqiZNCnq8zr8YbT
X-Gm-Gg: AY/fxX7DQgd+FBA/3ujRWMymrCVRBbEoZ7DYc4K3SGxeJ7LJQi5480vv9SdarM/c3r3
	W7U90GnzxykmryUAhNRNwKvvNxSJ5irxA/N/xcn4nxydNPlP4AU1aFknbByG/m9KEAxpWZdYWhx
	StZPRjo24Czb+UZ/E3+hRtpMFgO/0FVZvZLa4DDuL5GIjtrooV7Qru0SzueMOcCl6YgSY3k72F4
	krtL/6S9aLi5a4DpY/C3SvoL4elG2Mz6ICxtrZ7YnBe49WX+0LPIc199qxNBD5PY1VRfxJP/jPq
	pCB/
X-Google-Smtp-Source: AGHT+IGGfteEOKg48MhPnTh3vb2Y6QcXSam3/ezf7TbpWB6Bubd5063lH74XU0br9AAL0fkhJyLV9UlwqM9bMrTpoOA=
X-Received: by 2002:a5d:64e7:0:b0:430:f463:b6ae with SMTP id
 ffacd0b85a97d-4324e50c890mr73374364f8f.53.1767603392175; Mon, 05 Jan 2026
 00:56:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102-kunit-armeb-v1-1-e8e5475d735c@linutronix.de>
In-Reply-To: <20260102-kunit-armeb-v1-1-e8e5475d735c@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Mon, 5 Jan 2026 16:56:19 +0800
X-Gm-Features: AQt7F2por-Wm-6k5G3PEW5Wkrj5FfPMM9Yp51mGVu_BBKUksvKW5awKAB7uOzN4
Message-ID: <CABVgOSnGNd1n_yMuTLJj=fVHeoD3_+VvGxSw1ffV80B9CubRtw@mail.gmail.com>
Subject: Re: [PATCH] kunit: qemu_configs: Add 32-bit big endian ARM configuration
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005539fb0647a03cba"

--0000000000005539fb0647a03cba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Jan 2026 at 15:20, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Add a basic config to run kunit tests on 32-bit big endian ARM.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
> The test string_test_memset64 currently fails. The fix is here:
> https://lore.kernel.org/lkml/20260102-armeb-memset64-v1-1-9aa15fb8e820@li=
nutronix.de/
> ---

Thanks! This works here with:
./tools/testing/kunit/kunit.py run --arch armeb
--cross_compile=3Darm-linux-gnueabi-

(though big-endian arm isn't supported on LLVM=3D1 configs)

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  tools/testing/kunit/qemu_configs/armeb.py | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tools/testing/kunit/qemu_configs/armeb.py b/tools/testing/ku=
nit/qemu_configs/armeb.py
> new file mode 100644
> index 000000000000..86d326651490
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/armeb.py
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH =3D QemuArchParams(linux_arch=3D'arm',
> +                          kconfig=3D'''
> +CONFIG_CPU_BIG_ENDIAN=3Dy
> +CONFIG_ARCH_VIRT=3Dy
> +CONFIG_SERIAL_AMBA_PL010=3Dy
> +CONFIG_SERIAL_AMBA_PL010_CONSOLE=3Dy
> +CONFIG_SERIAL_AMBA_PL011=3Dy
> +CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy''',
> +                          qemu_arch=3D'arm',
> +                          kernel_path=3D'arch/arm/boot/zImage',
> +                          kernel_command_line=3D'console=3DttyAMA0',
> +                          extra_qemu_params=3D['-machine', 'virt'])
>
> ---
> base-commit: a77b19b747c8a53ac16289685b0f77085a2ad553
> change-id: 20251230-kunit-armeb-b4ecff7d3cba
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>

--0000000000005539fb0647a03cba
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQghgQFRc1tSxu9SpiDc9BcKi6h3yhz
PnBds1Bd0IDLKSYwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTA1MDg1NjMyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAo8Wk8F/tPT748+mjWfg5xljRRkHa19HYSRc8yiFkprHJp6MZxRvwFr/nFbDuTP4Y
QPX9l4qFmwCfLbYQr7XSw/qAnmzp0TKAlp0eWqnzEtL3iSv6sXOQhFmNr1u+Tcr1hCfrgz9PFFZs
Oyc+wFmt4PVDQIYgk/mjboU9cr6Sy8NsuYn/OAzsnbzAtoc5TwR0+fzrfNojnXhEe4D2rMT/0VIK
qv1l1t3DPzid73loQZAu2Khk92zYppeWTA+/o2eiW/likoi204wQSNxEtT0qnMjKZwgX3S10dRHL
cdslHnnj/CcyHeJcB0XUoNijb5Eyz/MaaBvwxV7Qgr1gMlQ52Q==
--0000000000005539fb0647a03cba--

