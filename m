Return-Path: <linux-kselftest+bounces-33245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEDEABA92B
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 11:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E001BA1E83
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 09:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF481E25E3;
	Sat, 17 May 2025 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QunvvY5M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99241DFDB8
	for <linux-kselftest@vger.kernel.org>; Sat, 17 May 2025 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747474940; cv=none; b=YVeZtPnL3gqmOOUEJOmDsEU1zW0j+VFULP5PkuqRWnW4nSptxon675qkGjYEk3J+4k6w9zRyYAumvOcKmrCbc9ROGDINVeUxg+A9bjuisPyykM5JGNbaqVRl0HL1McDbUc2k9VKQse7b5gkIGW9vxW2Fia61fHutqA1vP9ovkaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747474940; c=relaxed/simple;
	bh=j8JHH4hS9h31pwop3q1AhYHukwosET52SFQ1vZ+x3q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I246gloDdDRPmDr06NA2d0cJDe91sNOC1gap9OdE+Cn56IUMv57i8LTvvQnLuBmKnj9efiBVe96R63A52Oc4/iM3eQjzZ8B7MFHDGLZ9ae3jM6v+9x8Dz1se+w2xn6UvWtEjIO5u7mMEjv515lYChs0aBDgtUyyHiAhySc5g1Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QunvvY5M; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f0ad74483fso30513686d6.1
        for <linux-kselftest@vger.kernel.org>; Sat, 17 May 2025 02:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747474936; x=1748079736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3+GYV7wlXl3tsOIP/3Sbr/2ngWUOqMl+DvLfS8nLEMo=;
        b=QunvvY5MDHG/9Ynw+0E0cXR9+XoeQZbaCrJODwqnDWhKQXKTxAY9Kky6JCCLz2xb6B
         B1wZnD8L5HuTq1qpORfNOQQJGia3Edmtd/O/QmV33ah5iY0rXUB1zjuBV0j21UIo9BPo
         tkTW5yZx1qoh77/KdS7j42CFRfqyVn9yi3pMN1JZR/5xLWqCIPHTtjvzkCNiWVyVizMl
         tOXqHxttYhA+LWWwBv5r9MdRYPHk+KaDNbBjjJ0+5782dlAKj3c0dDsgeglwM73nbL3u
         Xq3JoYQKRnXhbs/NO1+vnY4w7/RSCgilb3NuTZy7QR/MkxeOKgwq+S5MGy1CGPDT0SFD
         g1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747474936; x=1748079736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+GYV7wlXl3tsOIP/3Sbr/2ngWUOqMl+DvLfS8nLEMo=;
        b=aBcm7wcE08g4hxcvQ2rj79PpjBoK+LHV8UuOwvxrEXZbsrtQftm8Xp3VCzd8uSlD3z
         QKK246e9uaNUUqyATJeQeXmjxmYnOJTpsT182zNp/s1/cuMbSX8L9zqdZlS5d3qOHkpg
         5Mq4dsryM7M/qMfmkYUUHWPHnB7sm9ulB6n+Ft4soqiFjnXQzUgq0/r8gILp085zsG1L
         dEicsjWrve09F6et4zjpTV4wdrTfP5P/NqyMWUvvjB4SKWZs7dZrdCT6OJAReCw5EPt4
         09p5jyQyHo4BAHRKgXbbXiiRRiDYbbYfgq9v3GSSriip2FBu2Hym4/CsqIdGgFIzJmOM
         FS/g==
X-Forwarded-Encrypted: i=1; AJvYcCVlJ2dSzsBkIjhoAPgDmdUTO3XddrHq02gj/c0ut0r1ciLMv9AU4CA3x1jRDlF1tLRZdDpSjXfna/3lJApU9fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+Hi7Sb6m2LvH6fJOKwbwQf95p03hknyBT3qStG/QtIcnsWBE
	hIELD2B1Z6dfqfRU+17MKFuAGATuIAwM9bgwSRqz0yqDf9tRaMvYefpaEBTHIFcow1A2oDXPaqb
	vi/UNSVaeYEwbewY199NdNYeqzcLbhU84Vf00tIkR
X-Gm-Gg: ASbGncsi5sX3gKIpSTAjcGJ2WSIHd36FSQhEW7TaBNw/4+jHGcYb6ZzvFMJIwJfkU5Q
	eOJXrDlzgWSl25VgSXsM4frRLPipwiwR/XxnN4UQnldyD+3FIFtTHQoJwmw/1l6ZESHsUuaeTcK
	F4RI/5RoEfYGpKBmjaUBz+7l9AaY36sCwD/Q==
X-Google-Smtp-Source: AGHT+IGptkbq2Cat0/G+nXayMrRAR95WUxnfTSBaeQENkod2hQrj1q6n/ospfd/2XZEwzgObUZ5ngHoDN98WmfEbUA8=
X-Received: by 2002:ad4:4ea6:0:b0:6e8:9866:7398 with SMTP id
 6a1803df08f44-6f8b0827d98mr108121706d6.22.1747474935543; Sat, 17 May 2025
 02:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516201615.1237037-1-rmoar@google.com>
In-Reply-To: <20250516201615.1237037-1-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Sat, 17 May 2025 17:42:00 +0800
X-Gm-Features: AX0GCFsfeep3gxGmUcnBe95Wcxi_DIU0Y4aPbvZN2VWnneJZvGkRE6Dt9nil18I
Message-ID: <CABVgOSkNofHFvq2QxrT5tKV+9Z13AnYu+xvRr0f0Ae_hg6i4_w@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: add test counts to JSON output
To: Rae Moar <rmoar@google.com>
Cc: brendan.higgins@linux.dev, skhan@linuxfoundation.org, dlatypov@google.com, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d0f946063551b692"

--000000000000d0f946063551b692
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 May 2025 at 04:17, Rae Moar <rmoar@google.com> wrote:
>
> Add the test counts to the JSON output from kunit.py. For example:
>
> ...
> "git_branch": "kselftest",
> "misc":
> {
>     "tests": 2,
>     "passed": 1.
>     "failed": 1,
>     "crashed": 0,
>     "skipped": 0,
>     "errors": 0,
> }
> ...
>
> To output the JSON using the following command:
> ./tools/testing/kunit/kunit.py run example --json
>
> This has been requested by KUnit users. The counts are in a "misc"
> field because the JSON output needs to be compliant with the KCIDB
> submission guide. There are no counts fields but there is a "misc" field
> in the guide.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Thanks! It's very nice to see `"failed": 0`!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit_json.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
> index 10ff65689dd8..80fa4e354a17 100644
> --- a/tools/testing/kunit/kunit_json.py
> +++ b/tools/testing/kunit/kunit_json.py
> @@ -39,10 +39,20 @@ def _get_group_json(test: Test, common_fields: JsonObj) -> JsonObj:
>                 status = _status_map.get(subtest.status, "FAIL")
>                 test_cases.append({"name": subtest.name, "status": status})
>
> +       test_counts = test.counts
> +       counts_json = {
> +               "tests": test_counts.total(),
> +               "passed": test_counts.passed,
> +               "failed": test_counts.failed,
> +               "crashed": test_counts.crashed,
> +               "skipped": test_counts.skipped,
> +               "errors": test_counts.errors,
> +       }
>         test_group = {
>                 "name": test.name,
>                 "sub_groups": sub_groups,
>                 "test_cases": test_cases,
> +               "misc": counts_json
>         }
>         test_group.update(common_fields)
>         return test_group
>
> base-commit: c2493384e8110d5a4792fff4b9d46e47b78ea10a
> --
> 2.49.0.1101.gccaa498523-goog
>

--000000000000d0f946063551b692
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
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgLugZ7sj1rGG7uB/ahFEy00jKQCNO
PVDl51h+XnTJKgwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NTE3MDk0MjE2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAAqOo+dX+FLWnROLDIMkwhRZ/0Or0UIl1OVGgoL6yegNrvdz5SkPi5f9DkYvRmSJl
eZMNhwQvGmF5G6/DdsTtTksdMUsqZQkxJTlfEk9IGOpyLmwVd3s0GU32CzFJKBWYZ1CmjrFCfkiR
8Bl8cBSG4GUEot/1UO8jtk9T7EqAiTPR1bxRTA659yTsEEnIPwI1p9zFA2GU52jSqZeBqqx2+jyy
ytCII1pdCK2LppcfbPHq0DH4ZXv3zX5Mk39TlQZnGmJtjsYibhKwoRaRt1BoylgPNEEmHtu300J5
7eejhfPQEPOhd+vLRfdc5PskUrN8zS6CZt21LIkH/K5pWmVIZQ==
--000000000000d0f946063551b692--

