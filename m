Return-Path: <linux-kselftest+bounces-47731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 459FECCF676
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 11:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA0B730150FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 10:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFFD2E973F;
	Fri, 19 Dec 2025 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjiyTp0Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053027FD68
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140702; cv=none; b=HxhumgBe1ICH1CGWY8BOc3GKLjbhgKwk+mnPja9tC6jUV7J0i3+Yz/QKTILbQljBsYQcbVr+GateAWlOw7PvQBcqZadUc9NRtLmcvjMeXsIVc93rZ8nAtFInKbj/wPKv7Dw1yi7/Z0oFr9LnZ5NXnMIQpbeEsXblS6N/FTIcXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140702; c=relaxed/simple;
	bh=OLZv749CILVylEbhNzdp9D27eApJjUFNdGNOJ0j4r5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozWBWB5wU6xda7ih7vW9kQKKiLb0IvYrUll1Of5WrnD4FrqQHLKycGrvOvvDy2fXCEy7UDIlBIWNBwIYQW1nQ98dbJO0+y+GzSHkZa/x+dkevrXqDylNrSJ78EFXJYJXp8fIQpYva1plSIKLqPh8dVYgK0E3PYFhRKlEoe7K780=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fjiyTp0Y; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so816927f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 02:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766140699; x=1766745499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x1vCKp7H/c5dibxbqc0Rn4r6uJ00sjAtn7WthhoiU+E=;
        b=fjiyTp0Ycn0wpFm3zVUvoeOxEgOJCy3KUaY7azW3PwhI7eUlJ/4XqRoMQqUT7SYJXV
         78Pgqxlf3P0O3qTNieeCkqALTb5jJwcekBRd/QKi+4B1x4Z8znx9x9KrZrLZ+T+7QPi/
         F8+ZYVgcXdl9GDoI6ZINHUb6tMiopA7JefJpvtq3xXzQB0YwlL1FCFpF/wI1BCHiGSVr
         et9dBGuOtu8xwTY6DZvWBbeE3VPTa4ZqcKCunB+nAoj+058Mm0BdrcaRQOtNqiwdqOGj
         oYVyiUMyqHJTavqK/+ZXvDK7b19l1/ilfnFmRacYsCDaDyzP44HKQDQSNNzSESBQgrD2
         W8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766140699; x=1766745499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1vCKp7H/c5dibxbqc0Rn4r6uJ00sjAtn7WthhoiU+E=;
        b=FzagilpD6Hme/Qd+8XWSdeequwxv9ZhtPxnL92UzDFRibGiFDoenfEgrNDz22kXzOD
         jqp4qv6uK9tExZbruhbs/b9PlTq9ok0/piMsem3KOQ9SN48H3n3pU/AjbwALoxxaWFJW
         ES9e4dAtmt6AhkDI6QMkrHzdmgqXRLdmKYU6mn/j7hmebmjKzq60y8SfcnYodtitQgGr
         eIkqiKMMR+rgDMDO+0tcJN16vUH09H8Ut71JN4XTKtfBmQeiqahlCtOKFdDeQiGXfndr
         BI42FBgM0+Mj3OSTmO+4tKVuXwYtQnTsCdGUJ10BNIBEv7zxFBzKWy1mzD1Rqc42AohZ
         B0FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTgNwcOi/m81nRXXPiasfrmc4IlOJphvwfcBoqXb47Nuf1cyW5/Hgi+IeyA4Xeof3IWZOUqmFSQI0Hc97g5nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI2ZBBLFv5b5P7EhqSjFOXw/ESKs2RNeZaG6QQc1oYrjF1SPwu
	6cZgQhvnhna0RkxZrOt7ocDl1n1ep4JLBFmbpYItXKS0FDJvDs73zVllpXCVzwJjIOYUCbwVZXn
	YHenp8Wj+radgVcrEj94CqufPHrPY2YhoVioc5z3a
X-Gm-Gg: AY/fxX7fUxdPHILAdihpVpBG/JlO9AmAq04PqhvTki7KWS8fJ9psJ9Fa5J4bWCSor0f
	+DgGU3tcpxrvZTjSm1tWbEIyuMF2R36rT2xdDf/u2ScOFGIXAy5ZCeDW5PKzeuFk9MIdg8pCVWT
	yPWX+3sRVi8IPccR//kc0fcC4M49jsHat3CAfOslJGhJg+3OMmOLxYw4KMOaLZ6EuWBZjTq2A8a
	UjwaCA6reDCwQERsmHAuVZibbVG1L3OjF+tgy0PbI2N8r+kYAFgWbnvMQElgRKFUbGifA==
X-Google-Smtp-Source: AGHT+IGhAyuczhLniTkoice5o9Y6ydgin3z4fXRCN3rjlJdb+ERnfHojsVy9trknFvgrK4KgAHNV28cHlGddnnjPl+A=
X-Received: by 2002:a05:6000:178f:b0:431:5ac:1ea with SMTP id
 ffacd0b85a97d-4324e4fb37dmr2789521f8f.39.1766140698390; Fri, 19 Dec 2025
 02:38:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211182208.2791025-1-gary@kernel.org>
In-Reply-To: <20251211182208.2791025-1-gary@kernel.org>
From: David Gow <davidgow@google.com>
Date: Fri, 19 Dec 2025 18:38:05 +0800
X-Gm-Features: AQt7F2oQPJGrwvDgJhqN3JJZxAhvU_KYfbZhWCejbbPuDCEmicjo8-EJx49tAOU
Message-ID: <CABVgOSmHcC1dZwVNvAyQKrAcJMkL-aVpwzSM_QqQFsr2KNH-mQ@mail.gmail.com>
Subject: Re: [PATCH] rust: fix off-by-one line number in rustdoc tests
To: Gary Guo <gary@garyguo.net>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fcb72106464bacb6"

--000000000000fcb72106464bacb6
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Dec 2025 at 02:22, Gary Guo <gary@kernel.org> wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> When the `#![allow]` line was added, the doctest line number anchor
> isn't updated which causes the line number printed in kunit test to be
> off-by-one.
>
> Fixes: ab844cf32058 ("rust: allow `unreachable_pub` for doctests")
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---

Nice catch!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  scripts/rustdoc_test_gen.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
> index be05610496605..6fd9f5c84e2e4 100644
> --- a/scripts/rustdoc_test_gen.rs
> +++ b/scripts/rustdoc_test_gen.rs
> @@ -206,7 +206,7 @@ macro_rules! assert_eq {{
>
>      /// The anchor where the test code body starts.
>      #[allow(unused)]
> -    static __DOCTEST_ANCHOR: i32 = ::core::line!() as i32 + {body_offset} + 1;
> +    static __DOCTEST_ANCHOR: i32 = ::core::line!() as i32 + {body_offset} + 2;
>      {{
>          #![allow(unreachable_pub, clippy::disallowed_names)]
>          {body}
>
> base-commit: 559e608c46553c107dbba19dae0854af7b219400
> --
> 2.51.2
>

--000000000000fcb72106464bacb6
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg1CX01OpjUyehXyRN0gU+mjhYdc+G
KT9Cc24pbMzRGYUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MjE5MTAzODE4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAhvMk+tpRRq52wqGYlwMbWg/Uw99sjpaj5k0Eu/RrC+zmDNbh+P6HstXLAe6WItwT
9BgajbuETRgRt0WglmO6pFfFWB06sIaZPlrUpo/fJ+YOPH9a7Ozc6FLnaR32cS0oSz9ztj4DSKbH
GApohBzIl4EkkXHbSOsDig7+lcszo1KUbUHoYe/cEAGdpDwjuWli/XhjxvAu2HJ87pc4N0S0HeKQ
mHZSKsM9lgK+mJDQZTtBT+Gb83E+F1uIFcv2y3opa2PRDw7SoolUNvhWrozC8htQcpX/rEUfwP9X
66IbngQgC1bG0p3cljyDtSYNfKQeMT4wRwMq0khin0QT0ZcZiQ==
--000000000000fcb72106464bacb6--

