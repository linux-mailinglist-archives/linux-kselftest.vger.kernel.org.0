Return-Path: <linux-kselftest+bounces-47752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D97ECD297A
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 07:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E503300DC80
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 06:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC282C0293;
	Sat, 20 Dec 2025 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="It1Y46Tt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1FF29DB6E
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Dec 2025 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766213971; cv=none; b=XH47Rh+4JbA7VDSvMI16WpKqqfk1rY5N/nn6NpbovHfwKOKBiQstvq0g9B9id6DquLWZPgfcwfavG2v1bNWSi/GORBSbQ5vgEV6pb/R6MoSPEXntNjbkBRf9ZXg+GUwFHywl5QemuWf+I+OuFml3NZJz1xwLZCIE98lRIbW3eb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766213971; c=relaxed/simple;
	bh=gI5f7kfPJiqCVUddek4rmCDEZFUx5zqtcK54Qpa5FYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1bCe2NMyg6j95yVN01q1/WmG2bSRMjpEH6UD+vnIl6t4wkqfh9IIQ+FLxxNM5bb3c/hYLRvkVBehqyvDiPrkJ4MilCf1G//4a9jzZYPivzKVpp29gZJie+1qThx2KnBw2Z+CxlGYDZg4Mi2nqGQfMu7ttMX7Q7ydrfzOMEX0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=It1Y46Tt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fbc544b09so1732867f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 22:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766213968; x=1766818768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ggr1CKvV/ue4dNFX3uJWs6Va/ctcKaKrP3vFkJMZfr8=;
        b=It1Y46Tt7AiHLp1EG3Clp3pGiXPO1TWSoSyq74Cv0B1hwjazGwvjAvYMyFtUdUV+6A
         joQu5XM+ebYdqGNfKWQ4xJwQAZI1wdYXbKeddXfDZapm6hJuxB1Zfl1/AIIutiIfWR51
         PHBnnnTR+I+D2bKklPMnSnX/7YHU9Cyw5uU73psjC2SPi3T3SiFPyF+xlADKCilrZyEn
         WU7jG+fUszMLR5CrB90lO37g/Gbw+NISqLc33wazUNVWnS4/MomC/1L6rXC8JqLv+iYP
         3H8opjei/nxRHCc2jeCCZqCTbRfe9qe0c+AJE/EjPoicrVhD12pkgaD4SSyydcIiQ7ir
         kbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766213968; x=1766818768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggr1CKvV/ue4dNFX3uJWs6Va/ctcKaKrP3vFkJMZfr8=;
        b=X4Ys9td6X3DaCUQzh8yaBYpwzAvdjXXcv8DoNYDXIPtuB/+g0U5MtmwGTtjwftRKHQ
         c9SPKR9olMFa0yPe05517FeVyFc8z9dNY5bqB8hJjDMbGH2y0am0lxP1KjAapZPrwfnO
         m8nWvujLr59U/Pyv0Dupns8RNlpM7igoOygMUa3HtfuinR+XlUlYQ0A+kU5kErnT0aNT
         9zZ0hFBVc6qDg+D/PhPDPMeIYalHYJNw3SAa40BlsGhOe52xwIMWne5Yv6+AUxfLt87n
         05s2NGU8hyqBmd4U457gRBGRGA2jqQWd9gI4nptB51x5YE61cBIZwG+OGH0ZzNuWgqtM
         o7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnLxHMfu0sP3/HUAmYO1M6l0KbIOIi1dMOZPLO6uWr2tZ1OXEObW6KLChvCIBAVeVzUw5/zc6m8NepE9LRmgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaZas1wXPYG35tjUnKBgm9YB/khD+ZZaspXrW9eVV6Ma7B/SeT
	DOKvykRWJTxPY/U+Nkyw+I/zV+NxVeFMdeMRwZ5F4v/B1SHLsneAg+DiqbHsge/lPuKH+YrLA3t
	wy5VgLibMuSQbRBX14YmId5tMwWJVZbApt3HeRi1huaALyO0quS11u4rGS04=
X-Gm-Gg: AY/fxX4NYa6Vl2EEtCPMbLDqq74UG15xoAjr684X3yjbIVR5rRs3/fSWETra37NTfmZ
	YlIcQ++TDZh4JpUBrxtJxS5qOn7gaiRhjx8pSxZv+My+Zsz4Aq0aVSTRW6mCjXSWvQbmXmRrXES
	hfC7/IWSe13ih4AimrotxWbGBhEqocEDvvFhC18sLNVJXUShrmWhwkRy/VXe8Vh6izgbJdXbDS4
	+suhe0WDYRsW+xB+Z/cHnXteidYS5njdCBUpy/68lLs4MEOYNt2aFdSQJmGD5RF5M6mgg==
X-Google-Smtp-Source: AGHT+IHODH3wfzjGmpYAWaFi4tRAxKBsUViU9x2Sgtx2bOEhQPbHO4g64YHi1ItfrTFoxlSesslq4LKz5vwPPWBMmjw=
X-Received: by 2002:a05:6000:24c7:b0:42f:bc6d:e46c with SMTP id
 ffacd0b85a97d-4324e4d1032mr5923331f8f.26.1766213967692; Fri, 19 Dec 2025
 22:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219161212.1648076-1-rf@opensource.cirrus.com>
In-Reply-To: <20251219161212.1648076-1-rf@opensource.cirrus.com>
From: David Gow <davidgow@google.com>
Date: Sat, 20 Dec 2025 14:59:15 +0800
X-Gm-Features: AQt7F2qecbmaeVSCSVATHOGbqvUTZVMh1bdmtkEhg4tv7y1Z-hyiTHHNQIuk8DU
Message-ID: <CABVgOSkn1EW6kCocBb6GUyk4h0qQHkDUYmLMs7F9Ja8ii_gOVQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Protect KUNIT_BINARY_STR_ASSERTION against ERR_PTR values
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: brendan.higgins@linux.dev, raemoar63@gmail.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002c3bba06465cbc45"

--0000000000002c3bba06465cbc45
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Dec 2025 at 00:12, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Replace the NULL checks with IS_ERR_OR_NULL() in
> KUNIT_BINARY_STR_ASSERTION() to prevent the strcmp() faulting if a
> passed pointer is an ERR_PTR.
>
> Commit 7ece381aa72d4 ("kunit: Protect string comparisons against NULL")
> added the checks for NULL on both pointers so that asserts would fail,
> instead of faulting, if either pointer is NULL. But either pointer
> could hold an ERR_PTR value.
>
> This assumes that the assertion is expecting both strings to be valid,
> and is asserting the equality of their _content_.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

This looks good to me, though I do acknowledge the general hate for
IS_ERR_OR_NULL()[1], and particularly how it can annoy things like
smatch. For an assertion, though, where we're really asserting that
both are valid strings which are equal, I think this is okay.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

[1]: https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/
>  include/kunit/test.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 5ec5182b5e57..9cd1594ab697 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -906,7 +906,8 @@ do {                                                                               \
>         };                                                                     \
>                                                                                \
>         _KUNIT_SAVE_LOC(test);                                                 \
> -       if (likely((__left) && (__right) && (strcmp(__left, __right) op 0)))   \
> +       if (likely(!IS_ERR_OR_NULL(__left) && !IS_ERR_OR_NULL(__right) &&      \
> +           (strcmp(__left, __right) op 0)))                                   \
>                 break;                                                         \
>                                                                                \
>                                                                                \
> --
> 2.47.3
>

--0000000000002c3bba06465cbc45
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQggPWHlGO8w35vnRXnuI2wpfEpF5aH
87fp0Z90YRGRVkYwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MjIwMDY1OTI4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEABAdqJLk+v1sqdZXa0oR4gsFdAOldGEnPmmEotvPbZry7v+K9iK1bu7rffSAnQEjr
oDQpnTVho7GG4rAmRutKsKS3/VfPU0bqJoXm5voBYhloEq1Iw5vSJpBAks1wTROZqYbwveuyvtRD
SW/maeb74dqCFdqQoE2ht2/0b9zbWqQUVcazYH17Wv+co9osWbqFZ4FYSjBK2jHDAyFOA76RIK+Q
TQVusd2eMx5XZ2NG7SMLlmzJSVr3WfWbFr0gb+t4X6N7R6SVbA+sP7kslCYtRA5P3CEY+flV2sFp
5BpW35nJOKH4Q8OEDGn/Pr5RA6YNcJ+r47tyqIHL4ENbFsMwsA==
--0000000000002c3bba06465cbc45--

