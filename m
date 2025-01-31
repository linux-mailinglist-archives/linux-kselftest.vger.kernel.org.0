Return-Path: <linux-kselftest+bounces-25482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F53BA23ADB
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 09:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5BB188870F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F676154BE3;
	Fri, 31 Jan 2025 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjheAfVw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3413A3ED
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Jan 2025 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738313141; cv=none; b=CaKax0jOGZac3yKCYbTNuPedgJydrmKPZqbiUvdGt1BdSubXI3olNgRK7x2kOPPdSRE6z1WaoyZDhSyJaSocLelVo+v5DylJJVzYaT6V4e3k81Zh6sD/5Sn+svHTn1gIDZk2bF55YvZNMCKXgWUgLN7crnw/6dsPrKvfTApjc2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738313141; c=relaxed/simple;
	bh=aZY2IO1Jx4uSXUarYNuwDVDNM27TLQiNRNJ1rC8ttMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcVi6yWM4LmRJWCemEQA0bIgA+5fi1zho/JE+F+1lsBBeLxZvkb1bpj7whGQaD7OZvsELT8/chqylZBAxY9d3yCkkThpLznp4oG4aobb8UaUBa189riPubHMEBoVoSujL/mx3wInXk1Dy/FkRBTNAIsIi1jmS/nHo+qP33Ee5Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rjheAfVw; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d8e8cb8605so8550336d6.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jan 2025 00:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738313139; x=1738917939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3yARhsOyibk8jmXIPdxgSPR3ABVtUIdE/VajqvVQ0l0=;
        b=rjheAfVw0tNcZkx8e/xTYrNdiyWccyLYAXteQFW4H4ZnVD7BQ74xS7AHdIwMswB/Pf
         NjFm5x3gqDs5KS28sfq/dJCO/MIgYFarJ/tyDbvED8tS/xKyXbk/jHoPmLYrrkRFJMqa
         8l2getwjbBSdtSweYIQoomqqcT0p6c+g+7ci5H5JuM7K23PH9JE2VNPXCDrFExs1OjuE
         JAYD3yvvTFhtCVouXEi3dGhfvlhMV/XT8lx/miS3Xj41vhfmJ3cd3xUQcXGs5Xc4oVnU
         aM+ZX9toa79FpSD9raCwAqjMda14fdUaohG/TV0SfpOizN7LyHqHpFqi+9aD0bqp6GF6
         KV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738313139; x=1738917939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3yARhsOyibk8jmXIPdxgSPR3ABVtUIdE/VajqvVQ0l0=;
        b=u1V5BAHS2taZmsCH/vfe1dPjzdTHZqNC8n3BgJN8o/oQJuVzF9mG68j1AMrdk98G4l
         fxMfy2V3m/leDqRlKERPMPDMeKO37YGYohl74g4IQXUehRIXGStf9lQS05RbXHHvPWYI
         TT0I+y3yDdWFGzv4liEvgRHjigIEu8+Si6vgNBiOarsd4NIITjz43uB3Y/VPqddKZIZu
         wshnDRz2DsNJ/hVlL7rPpIxhpGEheo4Sly7GvVh0cY6TZ4jSM9MojbjX6a0NcudP4wfW
         gEfBb5o+wVCD9v+L/SjdgddVjF1R3r4EjMEMvZpWlO5KgBpEGTzvm0u4REQO5JGRQJBC
         ZWZA==
X-Forwarded-Encrypted: i=1; AJvYcCVsQcvAd/ognvx0RC9J96uHo46488NpaxbJX9JJD4pdGKd5KCkForQb8yVxEZTpZHX7RarYfIjbeXeMMJ25U2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrL7xzqvJr/7TgnhwhJm4yUb0zQ8GKMx3RQdtvtVWMHBFuMJmU
	NPTvKnbjWMhjk41iPgH2VLnLsMBZV3/nh0KTIxFf5pSMw69mFDDTPHwHWEM8GnDZbQSnpbJQKjI
	J/pLrKhMLt4H1WGX+G3i6lKpxu4AGM1oiYvX1
X-Gm-Gg: ASbGnctilm+qQPaLTGseWY3eOif7Rb+H+j6z2U8q9ikMkVbtXJvFOiuf2Z4D9E4qMgq
	OOVOE/MM0Mr7Pmzj69KL/2CI+ADVlk65zXNybv1aoMPkxvdSO52DEzcz/6i4hKw1XFdmXdWY5gg
	==
X-Google-Smtp-Source: AGHT+IFuKIf772YSMtPnJAuDqZgHOyHVI5gTlk2gnfRGsntyBamK8s4H4iElGr83hcaJyRHdkYnC9C5SuyOnHIV+XuE=
X-Received: by 2002:a05:6214:459d:b0:6d8:7d7c:bdd5 with SMTP id
 6a1803df08f44-6e243c640c8mr201309766d6.36.1738313138608; Fri, 31 Jan 2025
 00:45:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124-kunit-qboot-v1-1-815e4d4c6f7c@google.com>
In-Reply-To: <20250124-kunit-qboot-v1-1-815e4d4c6f7c@google.com>
From: David Gow <davidgow@google.com>
Date: Fri, 31 Jan 2025 16:45:27 +0800
X-Gm-Features: AWEUYZmm1AHb4v06dOr_i6Y24FqUH1Eskdwr4ADjdLyz_7CnJSK_1ir2vKBzL4Y
Message-ID: <CABVgOSnB8OeBgiBhkGyGiuXpJocUHimfS+aX75kwZ=DqvaWpPA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Use qboot on QEMU x86_64
To: Brendan Jackman <jackmanb@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002a3b0d062cfc9188"

--0000000000002a3b0d062cfc9188
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Jan 2025 at 19:01, Brendan Jackman <jackmanb@google.com> wrote:
>
> As noted in [0], SeaBIOS (QEMU default) makes a mess of the terminal,
> qboot does not.
>
> It turns out this is actually useful with kunit.py, since the user is
> exposed to this issue if they set --raw_output=all.
>
> qboot is also faster than SeaBIOS, but it's is marginal for this
> usecase.
>
> [0] https://lore.kernel.org/all/CA+i-1C0wYb-gZ8Mwh3WSVpbk-LF-Uo+njVbASJPe1WXDURoV7A@mail.gmail.com/
>
> Both SeaBIOS and qboot are x86-specific.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

This looks good to me, thanks. My only real concern is that qboot
might need a newer version of qemu, but it seems to have been around
for 10 years, and is working under Debian here, so it's probably fine.

One future idea would be to look into microvms, which might be even
faster. I'll give myself a TODO to experiment with those.

This'll go in post-rc1, but nevertheless, it's:
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/qemu_configs/x86_64.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/qemu_configs/x86_64.py b/tools/testing/kunit/qemu_configs/x86_64.py
> index dc794907686304b325dbe180149169dd79bcd44f..4a6bf4e048f5b05c889e3b9b03046f14cc9b0bcc 100644
> --- a/tools/testing/kunit/qemu_configs/x86_64.py
> +++ b/tools/testing/kunit/qemu_configs/x86_64.py
> @@ -7,4 +7,6 @@ CONFIG_SERIAL_8250_CONSOLE=y''',
>                            qemu_arch='x86_64',
>                            kernel_path='arch/x86/boot/bzImage',
>                            kernel_command_line='console=ttyS0',
> -                          extra_qemu_params=[])
> +                          # qboot is faster than SeaBIOS and doesn't mess up
> +                          # the terminal.
> +                          extra_qemu_params=['-bios', 'qboot.rom'])
>
> ---
> base-commit: 8ea24baaaa869adeb39c6b9ce7542657a7251b56
> change-id: 20250124-kunit-qboot-5201945f7e86
>
> Best regards,
> --
> Brendan Jackman <jackmanb@google.com>
>

--0000000000002a3b0d062cfc9188
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
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg+nX4nm/Vv9TnU7EV4KqckDbCds5e
mlIWYqoS5dnNMlMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MTMxMDg0NTM5WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAC03zyxGJTDJg2Io9nb7y2ZnKvB438A7DiYlQ3tX7egaQ9sU
DPrYfbpnXlXQVJS0kSy9gueqClldMakA5ogMJsGi9xK91ZehJns4lzwmC4sK/+bsyzJdE4CvbbCt
fxylEmoluu0++qxwU/Ssc8ZUECIp5LFvtOmMyAsbEEufvCicdh/v8a++7UifpwJ5O9b56CBiERaK
Rxg02JwwON5CCmwtiJbsHikOVZCVLL3qatlf/wUdnnRkD2VapLnNoSW4OFGVgn4/OvgRtJXWPLTX
P0gfJ7NQ4V5voLEDJADAPOFSBMbbCe9IdmxbzhHMVf7FkLwQ81ZJsTS9lHMTTh1EDIE=
--0000000000002a3b0d062cfc9188--

