Return-Path: <linux-kselftest+bounces-44031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF3CC08860
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 04:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFB3D4E284D
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 02:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE62C220F29;
	Sat, 25 Oct 2025 02:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FtA8Oomh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266ED1917CD
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 02:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761357717; cv=none; b=HnAOu/sVP8wf9WjkTzwbf3DsuQwyU0YqCSVRrLrGIavpWOzN0TECPH+cdaumttIbwQZVi0AyH7EUODVQotceLb3ElaH919T2U30ZXHR3P07E6JN34qaGJp4WkKVQQ7Kkjr29RpHZppCSkRg2kArbGaFGf0XhyP42TUhYlrYNvmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761357717; c=relaxed/simple;
	bh=pxHF7aCPTSuaOZ3n4O1WVutMCWGT/Cep9MtiGz9tLtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1t/UKkY2PRjv9FUgf2uBK0oPEeBGEUTWwlhHuDGuEiJupsQmzLCDhcFAznMIFHh14hWyyXn9tkSFwZ0Chj38eTqnEqJdAtuGWW03jOijOx3Haq0yajDrGNAJnN6LmTPVhUKsTqyPCC5yVbNUc5P79wUVJ6uXAS2MXWST9y3W3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FtA8Oomh; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-87c217f4aaaso30938926d6.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 19:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761357715; x=1761962515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pxHF7aCPTSuaOZ3n4O1WVutMCWGT/Cep9MtiGz9tLtM=;
        b=FtA8OomhCw8bx6cxer3u1Y4UoYLNAV0FHqbRxLThXuqqXtnDF7ajqk+/HM5UN86vGJ
         3EcbRp57h5RIdiSeu+PXR96zJkY4GVag8z072iKuFqYCgqguljGAlS7e8zuIsjERWenm
         Dbtc+QEZ4PA2ayrWZbZYmjK5MFMy2Ydt3i3zcrtDwLK3++NLYzgSjPleRsstg/9EotmL
         zThQrHYzzqiRKL2hu3iiHVDDsv4g9J0Bn0JV9/dMD79r1A6ee2IX5IpIshsoJmm8Hf6g
         Oq1Mmf4vfLeK2csX0E/vrnZahAKeiRdaZWV9MztzqsM5s9IHReHhPtxnOkCyTL+InxRN
         uvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761357715; x=1761962515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxHF7aCPTSuaOZ3n4O1WVutMCWGT/Cep9MtiGz9tLtM=;
        b=kY6fXYFH6uBSYr6RFiKB9DFtd1EkNht7LILlqsdXP9RDwoawEiBPoICzkp7aQQrXl6
         AHAAY1OSCxgAXA1YrJ4PdAwNuWz7rw1HbKIpnqosCOFyeexUnobtiEKLJRH47u4cLD0g
         4sE/2gYctP7e6CxdTQgWKakwnuLP3I9FCgQ8IEElFOwD9Z0z7C1JV83tKVictyJh/ueG
         tw/Hw4rrLwfx041slB4xrjz7uwBRxjAUmvwBofLZENrVe7CtGpIM0tl4P8cEC60SMbtJ
         L7BUwwZ1aq6GWcPXC5NxykZ/L+zzvaw67b/QirWi19NJrenxN9906J6fJjiY9TD1iZnM
         zkuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJfmUNI17TQzospQR/2o7a/MmSAWVoI3Gxw5uxa29D1efsODVKHihGDJgmijvenXWN6o0kL7sif+OnUrjfRbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEuoJYldY+HOFjaQaJPaw9rNtkEaB+zVEPHPyEVyajLe4kv+rf
	QQclsbcinFv/lGXXM/KcmtMdxRy2Rudlqfdztr5ijQ+6ZaHcbZToM0IcSQEwGcrM/DfV9A18VWI
	KhwJvIeG9O3eXHdnJor1ACQmumX6JwewwBiQrdNkn
X-Gm-Gg: ASbGnct4nn9qC/TwVz/aVRn1LWrtDyYKozh058gUfXqmB0ZA21RjoubXZP+tt3FWvlN
	FrOYejNs4f0fm/ejBXGuUSvyP3XfZhttCekQTJV717/smUqdptZF8SMZcImTsClurM9ZH2uhuQo
	NT2kgGBQX68LwVTk5W9+ZIxoCoglcuQ063RS0nTWb6UoBg/KgkIx7TX8pBxXx+tseuz9Rsg42ED
	38BEVDit5IxqFOdhCTkpXrtfq9Sz3A+f6XjWqMfAZMjh+US0iP/rVs/1LM=
X-Google-Smtp-Source: AGHT+IGMH1Mjstucqikk2yraD6yYMqR/aR7r/WMdA42xIFAcP85Hk0f42Mv9DfjH0BFpxb3K0eCJcbA7TFXy0vsOY+s=
X-Received: by 2002:a05:6214:2606:b0:87c:26eb:f804 with SMTP id
 6a1803df08f44-87c26ebfafamr382307596d6.56.1761357714627; Fri, 24 Oct 2025
 19:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024190101.2091549-1-cmllamas@google.com>
In-Reply-To: <20251024190101.2091549-1-cmllamas@google.com>
From: David Gow <davidgow@google.com>
Date: Sat, 25 Oct 2025 10:01:42 +0800
X-Gm-Features: AWmQ_bnxy8-W84LZ5o2fkhwEq_EMtDFG3B9FmaV8I5Rs9uy4PzmemVqBWiCqdCA
Message-ID: <CABVgOSme356Q1efgBZrEScTEbr1L_Sdc1MY_F=knYR+pjHRTew@mail.gmail.com>
Subject: Re: [PATCH] kunit: prevent log overwrite in param_tests
To: Carlos Llamas <cmllamas@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Marie Zhussupova <marievic@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Tiffany Yang <ynaffit@google.com>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f226840641f20c3c"

--000000000000f226840641f20c3c
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Oct 2025 at 03:01, Carlos Llamas <cmllamas@google.com> wrote:
>
> When running parameterized tests, each test case is initialized with
> kunit_init_test(). This function takes the test_case->log as a parameter
> but it clears it via string_stream_clear() on each iteration.
>
> This results in only the log from the last parameter being preserved in
> the test_case->log and the results from the previous parameters are lost
> from the debugfs entry.
>
> Fix this by manually setting the param_test.log to the test_case->log
> after it has been initialized. This prevents kunit_init_test() from
> clearing the log on each iteration.
>
> Fixes: 4b59300ba4d2 ("kunit: Add parent kunit for parameterized test context")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Thanks, Carlos: this is a nice catch!

There was some thought about keeping a separate struct kunit_case (or
equivalent) for individual test parameter (so we could provide more
detail in debugfs), which would negate the need for this, but there
are other problems with that, so just re-using the test_case->log is
definitely the way to go for now.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

--000000000000f226840641f20c3c
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgvclfmfMcFe0rd3uA3Q18mB/5EhAZ
8rLzEUHUVGycbeMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MDI1MDIwMTU1WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAJqftHsLnSVAwVmsFLT2H1Ri5ww4SxWSh0Dsmwli+OjhpX9O6QUkoVwnxDc3cuoGW
CCCI0DhaqIgfv6yqycqYEIhGPFhxD485tfiLGNm/lLhH9I9cjJJ/G7uQyQRILJaWi6zwXyl/lKrb
G8ifaqegygxMw2rwZJBoNzo7mgyT5DIU4HDaLvWOpmW0JYsuHHIDfzOIvmzX6lxQrI9sH13YiIF1
jYAF2gt4MgX3jL+deqUt+mCuAiWVY+FJIgcKxrnh8Y/0hrMxw8VeIlP5QuIsz3Zxpab7ItTCl2Oc
A0blTTHMlwy1Wla5ftrCc0F95aBN6C0Ns0tAFbspeLpp2RQoMg==
--000000000000f226840641f20c3c--

