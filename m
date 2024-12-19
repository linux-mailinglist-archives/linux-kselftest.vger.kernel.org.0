Return-Path: <linux-kselftest+bounces-23572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F331E9F741F
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 06:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CE0161F4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 05:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B4A2163BC;
	Thu, 19 Dec 2024 05:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUQWGWV2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260B1FAC42
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 05:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734587118; cv=none; b=fEgQ1utfH5kAyY+rupadgihF6o2w68BHdyNya+dkzOrcLvXhgdiHDZ30/7D8SflpoEXxaTXg6w4lpzHU39lVt+hXTsdY9iMx9pGWGa9by8VHmCqLaTrVp7RdEeQAqZPHxpM0ECSh4BX4iS2NgTp2WYVzYv3BnVBv7L0SK0Y5uAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734587118; c=relaxed/simple;
	bh=MDl9TcTQVX2xaly6sYEoHVfRIB+mMa5UUuRStdivLPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Me4X7U4ltfO/3q/QeYc66gHuGQctJc3Ouu0DZqOsL7lJ1dTAMN1Xbw4+zLxCQn6SwJ+E6kcmpLfPNLAxrLkdgtjwWJVUgj1cTQF5soqz0dzbS6L2yihzT+oWz4N3gq4NZkvP0EwPOpOnhz1C/n7yL+OtPcS3nngtndpVQBdVc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eUQWGWV2; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dcdd9a3e54so4418966d6.3
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 21:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734587115; x=1735191915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LZ7wBUGn4sDfqCxCy0UQlqpHDScVN0Q1gCZJPUtk3NA=;
        b=eUQWGWV2ooMAaFh5B938HrvgsFx14OM2ZmzAwTOyTa1y88XVc99iHsvxV3jwAKvDXM
         L76ttpMDA6+JJFM01lxW8V3EP4clF95xMqTs9ICydQ2tQOnIO03jVqHG7Wb8urviAcnF
         urCCfL93YkIDfyWnyA6vGGmUHVWu9CgI/0p1UGt/g/PnhdCBIeOdkr5Juro2K1tZm4+g
         Ks63FY1p84o+tZy/lPCVgvgGtTvqPptt50YWeKR6O75/NHWVZETyOMMAC7dJwk2EPRWM
         VOVoePuENm4YnYWKI4JOP0xgZKfSAHamGdpqEHW5oqnYUW+i2UO76gvcN4T2UoPWhr7Y
         IO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734587115; x=1735191915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZ7wBUGn4sDfqCxCy0UQlqpHDScVN0Q1gCZJPUtk3NA=;
        b=WmD6EKz9fZf0HyrhEgckdXuWAhA1QSQgz0iPPPzsg7ONTnQpHBIjX+tLIt+XtE66BN
         j+THoXvenW2qYfcivL7o8/fE8avsFvG1EyQ5Fl3Lu0Vwrk1TWYkk6TfoyOAzNLFl7/t1
         PD8aiMSEIBNqC4TPqgu6+t0+3dR+ED60P+DKa21UEDUjj2lLoFkGwGqhgwjP+so+YM8F
         JJ09HI1VcBkcabOSD2ZrOf5+e0MCwf+B6xaemc85aTmCfhFDgO5BycsDXBn2f2hEmyn+
         ZJOyiD+ejXC06Q2qJPFLK09hbxOCI7cTw9ZEaJMLN/6pApPCvDGeS47BOAc+/T914fll
         7bVg==
X-Forwarded-Encrypted: i=1; AJvYcCVaTPpg9OaZbUaX1eDRpSFqW1ldzDraSz452JmISmcLRoaePFKs+fEzLVxdQXpaceyjw53zOEClpg6WlP0Fim4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUX/8Xsf10iHqNRIioVAy+cKG/yXNzrOp7P1/dL3BuZOn+u10G
	lw1fPbfQilPNAg9QTV1V7m8osh7GIwNbp9ZlXqDweFXEFNddfSCX1k83p+QxYzX2KqstRR72Ut8
	x4RBbTu0e3pJg3HV5qnQxAhTsQJSnFTDz7wOZ
X-Gm-Gg: ASbGnctNjSumiMPRf13FD4DiB+ucH5iPABWuu3y459EM5ODFZGx/FwtSw4J0PH7JeEp
	yLWW8YrhmPLZ1nN10EnIYaPYQyUoH46DBNwmm/I8=
X-Google-Smtp-Source: AGHT+IGMVdW8ZO39xxQVjYxEaZV0u66oUu5Q8Y8tAHfHGKuoBakYbdb2IDkLnQf4o1AtX9GhLzRaR0fcNdzqlgOBZs0=
X-Received: by 2002:a05:6214:1c8b:b0:6da:dbf0:9640 with SMTP id
 6a1803df08f44-6dd14b77676mr45259196d6.7.1734587115262; Wed, 18 Dec 2024
 21:45:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216201148.535115-1-briannorris@chromium.org> <20241216201148.535115-2-briannorris@chromium.org>
In-Reply-To: <20241216201148.535115-2-briannorris@chromium.org>
From: David Gow <davidgow@google.com>
Date: Thu, 19 Dec 2024 13:45:03 +0800
X-Gm-Features: AbW1kvZb_jsQyJWZK1Gfw8y9d9kTFdXrY5oMu63wlxWIL-tnnf9dEmlSuhyjzv8
Message-ID: <CABVgOSmZUETNa8OfqTvMuGg8Dim3UjLzvKdeJia6aCV7Ydgzdg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drivers: base: Don't match devices with NULL of_node/fwnode/etc
To: Brian Norris <briannorris@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Ripard <mripard@kernel.org>, 
	linux-acpi@vger.kernel.org, Rae Moar <rmoar@google.com>, 
	Rob Herring <robh@kernel.org>, linux-kselftest@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000dec9bf0629990897"

--000000000000dec9bf0629990897
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 04:12, Brian Norris <briannorris@chromium.org> wrote:
>
> of_find_device_by_node(), bus_find_device_by_of_node(),
> bus_find_device_by_fwnode(), ..., all produce arbitrary results when
> provided with a NULL of_node, fwnode, ACPI handle, etc. This is
> counterintuitive, and the source of a few bugs, such as the one fixed by
> commit 5c8418cf4025 ("PCI/pwrctrl: Unregister platform device only if
> one actually exists").
>
> It's hard to imagine a good reason that these device_match_*() APIs
> should return 'true' for a NULL argument. Augment these to return 0
> (false).
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---

Seems sensible enough to me.

Acked-by: David Gow <davidgow@google.com>

I assume this series (including the KUnit test changes) will go in via Greg.

Cheers,
-- David

>
> Changes in v3:
>  * Add Rafael's Acked-by
>
> Changes in v2:
>  * Add Rob's Reviewed-by
>
>  drivers/base/core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 94865c9d8adc..2b7b13fc36d7 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -5246,13 +5246,13 @@ EXPORT_SYMBOL_GPL(device_match_name);
>
>  int device_match_of_node(struct device *dev, const void *np)
>  {
> -       return dev->of_node == np;
> +       return np && dev->of_node == np;
>  }
>  EXPORT_SYMBOL_GPL(device_match_of_node);
>
>  int device_match_fwnode(struct device *dev, const void *fwnode)
>  {
> -       return dev_fwnode(dev) == fwnode;
> +       return fwnode && dev_fwnode(dev) == fwnode;
>  }
>  EXPORT_SYMBOL_GPL(device_match_fwnode);
>
> @@ -5264,13 +5264,13 @@ EXPORT_SYMBOL_GPL(device_match_devt);
>
>  int device_match_acpi_dev(struct device *dev, const void *adev)
>  {
> -       return ACPI_COMPANION(dev) == adev;
> +       return adev && ACPI_COMPANION(dev) == adev;
>  }
>  EXPORT_SYMBOL(device_match_acpi_dev);
>
>  int device_match_acpi_handle(struct device *dev, const void *handle)
>  {
> -       return ACPI_HANDLE(dev) == handle;
> +       return handle && ACPI_HANDLE(dev) == handle;
>  }
>  EXPORT_SYMBOL(device_match_acpi_handle);
>
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

--000000000000dec9bf0629990897
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgvANNJ7q3FYX2uEYdHwUbf+9O+H4J
oK1pPqpRhogFTV8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MjE5MDU0NTE1WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAAG7sHhIMx66EPG+HpRLR5YyqYcZaJ+osEoMpfK93HdyDEoJ
b5TQwnbkR4oq27ViJNk2uTpv6npSeCzGzflJka2UTg5QlRw4yrCgGovXo+J3fNF+uC1/s3jyi+Yl
SNnZoJK5Y0sjrnKLTtOWX1WqYz8iw+SMHXYm3NWx4tjAU+/zaKqxEajrd+tdqWX+j2nGczHDoNAc
DGXWfo2J1lxps+dY8zZ7cYyqNVLX0qQRp04xj+fEmCm3mFbEzWRSgoRj9W+34P8XaNtOhqqtJN5r
tM0Sgy+h/OAZK8S2xT4eiyl71NKscxYaippgWotRuQUBx14oad9NH3qrGQJRyqNt54Q=
--000000000000dec9bf0629990897--

