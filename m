Return-Path: <linux-kselftest+bounces-21719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86929C2AFC
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 08:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435F41F21362
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 07:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188A54D8AD;
	Sat,  9 Nov 2024 07:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DLDh1sxU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647AF233D62
	for <linux-kselftest@vger.kernel.org>; Sat,  9 Nov 2024 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731136711; cv=none; b=KR5QSib9WT93lbLzGx5Vn7x857wmVfAFwf9xqJR9giq3DumK1aZn7tHJI5j3avzFin8HcCb35hc2oAxNbSfHU/mtum9Rw/0xnwmgJlZ//MddNP63PfJjeGRzNEZ6JL+kDbpyt4CzoJHXR1ORpJQsrL6JY+eJpwNNK5T/ViBT/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731136711; c=relaxed/simple;
	bh=tPn4nRBpT+83Q7JW5+msME2MVpzkTShipYHROt4kmC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqBNlxM7zAan6FQ2lBVlhqjxkmmQ/pSRkqyujjuL6Pt0b5lkfAi1+KHTyLAjN6rzd98Vcp1peFpyIemtEJmQNM5igSYZG29BX8nZJXWhGwguxwDKfa4U3aNuEsmh9Jw+ySNoR0i4Ms15kli2/J2as43HHfyOue1wxFf3EO1d8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DLDh1sxU; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbce9e4598so16698116d6.2
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Nov 2024 23:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731136708; x=1731741508; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tPn4nRBpT+83Q7JW5+msME2MVpzkTShipYHROt4kmC0=;
        b=DLDh1sxUeWlB8XK5hjU7fhU3PDCy9lnp74ld5BOFNqZf4cwgwW8c2EqURj2xC0MEk8
         DrA6JbIrOrP9icDK9n9Ya966J2hZC2MwmcTdtAcuAd9mgsYY7RCrA+kWn2Ybr2dEkd52
         Yzk2wKtQuzZw/aumA8SbqBvxxjrB8BMazpcC7u0DSyBrG5fHnqYmgppEjrpBWJxcI8QS
         2QUnmhBaYVUX9fcbRZSjG08j9dta60dHCPVSGki//KsvdeT8hywk79byc4/KPGfxzkv9
         W7KbFMeKdx3QtaAfwKYm975TzYCC8QysViJ91HJxvgoCDAEwlcFRzXhQiSs6gx5pLReR
         9tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731136708; x=1731741508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPn4nRBpT+83Q7JW5+msME2MVpzkTShipYHROt4kmC0=;
        b=BoZKoxr+dJ+JTSMdovhc8Z/7B6FND52FYEIHufAir1Gb5tHdYTC7fv17VaruFPR9FD
         /Qdlvb5vUdUJLvUgl6CEFF/zuAbJvZoN7lL/7EjQleDKKY60QtweplR493N3d7BQwd6I
         oO2CsK1LWZqMsXsu+MOipln6g2vhrU38zL9ZyWjjLjKQ75kM0/nx6b9NgmivJ0u3VWdz
         dJOVZTczCjm73YTO+YL3GudacRauK82MDOzSfHmYzJOeMyDkwKHYwaWwrbGaClxT8RWu
         WwNhcSVfwHF7+jmDC7mS/WJXSVd1cSv70j9BOURLSzwGaiygt/62OtPQ1E2EwZQjYUFL
         Nu/g==
X-Forwarded-Encrypted: i=1; AJvYcCVWhpalyp8UOLtobp2SakkxWT9LIA3H6t7t8HFhQkxSPZcITvA/1pRZVtfks9U580OC8qjwBX6lBdB74aYD3mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10VqoD5paEPl59aq8Mt7RyUy8ofe1ddacxPjCISfnRX4DJl7X
	ix41M60ytj0Ki2SaetNLM3czqGgUF9cf+MFncQsxFkr9mKy7GB9ZIhBXOxpTzOrZsrPbaR7NT+4
	3IqWzeHdmh61s0AiLQh9qFkV7Iagwxz+t600+
X-Google-Smtp-Source: AGHT+IHAWSYuBgQKpn1u12KZG5dcUUzULEtiOZ+VskujpPkKap7+8ijG2ds9PNO6eevs22vlhFKwKAZsd+rnicyZyYU=
X-Received: by 2002:a05:6214:5412:b0:6d3:89d3:c6ea with SMTP id
 6a1803df08f44-6d39e101c4bmr85360686d6.7.1731136708085; Fri, 08 Nov 2024
 23:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+i-1C2-PGPcfSJB4oLqHN3jAE9CDY+iNaW9WCiRB6zF0fgQ3Q@mail.gmail.com>
In-Reply-To: <CA+i-1C2-PGPcfSJB4oLqHN3jAE9CDY+iNaW9WCiRB6zF0fgQ3Q@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 9 Nov 2024 15:18:14 +0800
Message-ID: <CABVgOS=hxOxiX361Bz0==YNBCgqedJyHdWUm+-Szq8Bqqx1MxQ@mail.gmail.com>
Subject: Re: "stty sane" in kunit.py
To: Brendan Jackman <jackmanb@google.com>
Cc: Daniel Latypov <dlatypov@google.com>, Brendan Higgins <brendanhiggins@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000092dda8062675ac7f"

--00000000000092dda8062675ac7f
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 18:49, Brendan Jackman <jackmanb@google.com> wrote:
>
> Hi all,
>
> Does anyone know what the 'stty sane' invocation in kunit.py is about?
>
> The other day I ran into an issue when running it via watchexec[1]. At
> the time I believed that it was there to clean up after the firmware
> that QEMU runs potentially messed up the terminal.
>
> However, I just realised I'm not sure if that makes sense - stty is
> about setting terminal settings via ioctl. I don't think QEMU or its
> guests are messing up the terminal with ioctls, they're just writing
> funny control characters.
>
> What's going on here? I guess one of:
>
> 1. Terminal is messed up with ctrl chars but ioctls are the
> easiest/only way to reliably clean it up.
>
> 2. Nobody thought about this unimportant detail so hard before and
> there's no particular rationale in place here.
>
> 3. I made bad assumptions about why the `stty sane` is there.
>
> If it's 1 or 2 I wonder if there's an alternative way to clean up
> without getting the SIGTTOU issue.
>
> Or, maybe it doesn't matter and the fact that this was ever a problem
> is just a bug in watchexec (maybe you can tell I haven't actually
> taken the time to research the SIGTTOU thing properly). But thought
> I'd raise it in case this points to issues people might have using
> kunit.py in CI.
>
> [1] https://github.com/watchexec/watchexec/issues/874
> [2] https://gist.github.com/bjackman/27fd9980d87c5556c20e67a6ed891500


If I remember correctly, this was due to UML sometimes messing up the
terminal (not QEMU, though QEMU definitely does the same thing
sometimes), possibly just when it terminated uncleanly. It may also
have been, as Daniel notes, something to do with the --alltests
option, which used allyesconfig, so could enable some strange
settings.

We definitely didn't look into things closely enough to determine if
it was just control codes, or actual IOCTLs. I suspect it's just
control codes, but UML does have some strange TTY options (though I
think those don't affect us, as we usually pipe the results though.)

'stty sane' was probably used because it worked, and 'reset' would
clear the screen, leaving us without the results visible.

If there's another way which doesn't break anything, I'd be happy to
change it. Maybe outputting '\033c' would do it?

-- David

--00000000000092dda8062675ac7f
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgkiNnl/98xuYXyaR8Gi9iWUzvurLc
1uykTU8y1JIt2pMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MTA5MDcxODI4WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAFRVlFflpdraM9Bi+aftqhmSxs7ygnPuNFlHDqkhPlcMnq5Y
J9tTZwy0uOOPcWj4hrblt321j/KDPKWRKWuuDsEzt/rNZ9OmeCWV7ICqKqj49f/fcHTknQzd76gK
c9JrQwO4f6bh6I7o3jg7PDEpAjRBkAa/YdnV/3NaD7yDE+HaVB2VeZLYw1k2aLk36espc039Hja3
jkpmQPSIVE8TJlkE2dLc1RVgGMWd4bge/AH6+J9P7vOIRoMDynm4x6HwSTwpqzq+58tHiygO29HE
jlq6Ntb2TtYNlADBncr+rjaL89JFv9ufx234pdbjfdw+GtKkyHMMxkpjz7f/sy5hU+M=
--00000000000092dda8062675ac7f--

