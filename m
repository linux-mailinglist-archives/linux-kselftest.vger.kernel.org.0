Return-Path: <linux-kselftest+bounces-13641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8B392F597
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 08:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DD4283447
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 06:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C0A219E2;
	Fri, 12 Jul 2024 06:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKmwdQ/E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3313D889
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2024 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720765933; cv=none; b=CAEwlSfEKKbePaOy1mzU8Zm4fz+18BNmLW3b7BN2QOYgBKh2BodEcxQMET9Zlxr9+PxCrJJzb8/xcfz2clixjgalxNb1nYdKMiBgsAKBDOtOTB3sGC6Pd8bCyW2+zta21x8uib3TzZJMpnFHbnC7YkGu4POsyaUzpxJgDIcFYJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720765933; c=relaxed/simple;
	bh=j3WoYsVmpnqRdAu9kAi8ctnHT/Q08ksnAh2lHV3riG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aa+lbBCOBk5t7flRhtY9cy/cZhSrzjupBnblIx5Mf+ff7oJ+n+pEiTD7jmwBB6KPHP96oRfff8vQpcoi1yngSXcoShBZLksvVEwXNpUp2Gx4iaiBrhGi+ife0paruqdzgLzkBr1g8ON26a9JIadHz0M5XkULE2CUFQCM/na3TTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKmwdQ/E; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-447df43324fso124091cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 23:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720765931; x=1721370731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KkrwlDFnK6kmweodUceyT+o/OMq25YxRhtYLdYup1Pw=;
        b=aKmwdQ/EjNXYFzgNdr/3ArRyGRaPivxN6EGRKHZsXwRR6I+E0B9NJ1XgiipJHLAqoH
         M9/bTE1w17iEZVLOqlT4I04+8AyVO0wsQZgzF0+NpMTn81mtoYRXLvrw5qJPAl0/G+ib
         rwEX/1xcWydvJyUJuGANejjhTcZBJBvpHASI69S1PuIdaWvFO0mOe9VKiBYnGcLgYPzc
         gAjuFYqP6pT3IhMEboN9ARqy10fjefljByajtQI2JJUVpvWdIxV+10WvKzXkXURlraWN
         glCd3XPX5uh/mRmBmZxV8x3bsr33SeIzpWuyc25E/tIMXFYzaFbDL6cH7T3qpRMAt1nE
         MWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720765931; x=1721370731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkrwlDFnK6kmweodUceyT+o/OMq25YxRhtYLdYup1Pw=;
        b=Ar8kJKTVQO019w5A/sMm+pSYyWfE+tYwHvV5x34e0mfv94vWYjHqAKjLII6OYsMmD/
         iuFtXLB2yT6fxMhXD+A6T7vuSEUOEpubhTVWqNM05ZMrR2KJzX+g2WrriARa+HEu/UtC
         DX1Z/sYpVWzyk+LXauuSrYg/lpd9HbbGu5t9lQB+nVFvtDeHJloOchTplhsVh+j3kZRN
         rDvXj+qJZSwuiDpUQzqOFguvqpYCDEFx9Py+/ohSQj/KT4Gy0f7hYJ9yr/I1hqTUkpY5
         yU8JNU5SD+OgvevD7vBGhU0Mm2Yu6CRY21k8gFFWzlIjVvF0eLfUcTn9803zxs5kiJVk
         ITWw==
X-Forwarded-Encrypted: i=1; AJvYcCXHmEm4d94vg+rmCDk9HY6gpAeLdotmCswS84eIAaORumGddKgJq6+l6Do829W5bCGRKyfXerfePUtLf59hQA1ngIH/rcMYUBchNuH4Nkz5
X-Gm-Message-State: AOJu0YzdPUapQBXip2J/9gobkFqtVw9dt9drlg7IcYl2pxQMa1BKksMG
	zGB95YCZf+HBh/po08CQba/rKtI6Af4xDl6XUID5BWGhqqOY/Me7zgPirZmr2UqhC4UNFHdWuP5
	cBe9/P/caaRcTHVMD27MytDZb3tRgb+7bmfnL
X-Google-Smtp-Source: AGHT+IFlhUoWhKvbw9Lw7EdmY9oxuz/3DlRh20G7yP7XubMWcMybNfriE+QzewI7Kp+uf4uyLnJmRtu3P1dvozUcFj4=
X-Received: by 2002:a05:622a:1aa1:b0:447:fad8:ccc1 with SMTP id
 d75a77b69052e-44e7522c65cmr2275061cf.22.1720765931261; Thu, 11 Jul 2024
 23:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711193729.108720-1-ericchancf@google.com> <20240711193945.110170-1-ericchancf@google.com>
In-Reply-To: <20240711193945.110170-1-ericchancf@google.com>
From: David Gow <davidgow@google.com>
Date: Fri, 12 Jul 2024 14:31:59 +0800
Message-ID: <CABVgOSmvAWcXqO4nLQqCw=rf+7SXjD+xw3Uw7sc5vkAc=Lp37A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kunit: Introduce KUNIT_ASSERT_MEMEQ and
 KUNIT_ASSERT_MEMNEQ macros
To: Eric Chan <ericchancf@google.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001a8f3e061d070a09"

--0000000000001a8f3e061d070a09
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 03:39, Eric Chan <ericchancf@google.com> wrote:
>
> Introduces KUNIT_ASSERT_MEMEQ and KUNIT_ASSERT_MEMNEQ macros
> to provide assert-type equivalents for memory comparison.
> While KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ are available for
> expectations, the addition of these new macros ensures that assertions
> can also be used for memory comparisons, enhancing the consistency and
> completeness of the kunit framework.
>
> Signed-off-by: Eric Chan <ericchancf@google.com>
> ---

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  include/kunit/test.h | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 774c42721412..67ad0e026bbf 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1451,6 +1451,60 @@ do {                                                                            \
>                                    fmt,                                        \
>                                    ##__VA_ARGS__)
>
> +/**
> + * KUNIT_ASSERT_MEMEQ() - Asserts that the first @size bytes of @left and @right are equal.
> + * @test: The test context object.
> + * @left: An arbitrary expression that evaluates to the specified size.
> + * @right: An arbitrary expression that evaluates to the specified size.
> + * @size: Number of bytes compared.
> + *
> + * Sets an assertion that the values that @left and @right evaluate to are
> + * equal. This is semantically equivalent to
> + * KUNIT_ASSERT_TRUE(@test, !memcmp((@left), (@right), (@size))). See
> + * KUNIT_ASSERT_TRUE() for more information.
> + *
> + * Although this assertion works for any memory block, it is not recommended
> + * for comparing more structured data, such as structs. This assertion is
> + * recommended for comparing, for example, data arrays.
> + */
> +#define KUNIT_ASSERT_MEMEQ(test, left, right, size) \
> +       KUNIT_ASSERT_MEMEQ_MSG(test, left, right, size, NULL)
> +
> +#define KUNIT_ASSERT_MEMEQ_MSG(test, left, right, size, fmt, ...)             \
> +       KUNIT_MEM_ASSERTION(test,                                              \
> +                           KUNIT_ASSERTION,                                   \
> +                           left, ==, right,                                   \
> +                           size,                                              \
> +                           fmt,                                               \
> +                           ##__VA_ARGS__)
> +
> +/**
> + * KUNIT_ASSERT_MEMNEQ() - Asserts that the first @size bytes of @left and @right are not equal.
> + * @test: The test context object.
> + * @left: An arbitrary expression that evaluates to the specified size.
> + * @right: An arbitrary expression that evaluates to the specified size.
> + * @size: Number of bytes compared.
> + *
> + * Sets an assertion that the values that @left and @right evaluate to are
> + * not equal. This is semantically equivalent to
> + * KUNIT_ASSERT_TRUE(@test, memcmp((@left), (@right), (@size))). See
> + * KUNIT_ASSERT_TRUE() for more information.
> + *
> + * Although this assertion works for any memory block, it is not recommended
> + * for comparing more structured data, such as structs. This assertion is
> + * recommended for comparing, for example, data arrays.
> + */
> +#define KUNIT_ASSERT_MEMNEQ(test, left, right, size) \
> +       KUNIT_ASSERT_MEMNEQ_MSG(test, left, right, size, NULL)
> +
> +#define KUNIT_ASSERT_MEMNEQ_MSG(test, left, right, size, fmt, ...)            \
> +       KUNIT_MEM_ASSERTION(test,                                              \
> +                           KUNIT_ASSERTION,                                   \
> +                           left, !=, right,                                   \
> +                           size,                                              \
> +                           fmt,                                               \
> +                           ##__VA_ARGS__)
> +
>  /**
>   * KUNIT_ASSERT_NULL() - Asserts that pointers @ptr is null.
>   * @test: The test context object.
> --
> 2.45.2.993.g49e7a77208-goog
>

--0000000000001a8f3e061d070a09
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIF5/Vq8IWKoYpIhYlY6jG005IfaZYE7R8dcfONzCX013MBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcxMjA2MzIxMVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB5Rzl6
QEYYnQQN+yQCTszrq9+0/0JzylirlydBgcGBDc8id6mY2l/RPDaLUbBrB0ex+tGnBOL6VhPGqwXz
BsmAI9hnC1NgvlKzkuCxhApmLv6JRCTJE1h/qZLHL558DM/R0+vVFIS8xaRYCFijKXXILz7u4oej
p8MA1/Mgl08DT9WKGsKwpa16aa1ofGOcCLQg6UAY1i3FBi26PrSDmg6+sOAd6QxPJj6HkCztGdN9
RQ49btetQTw366jbltwmc4+TJExJ0W2SNgLpwWmdaoC0RP0RnEyVoo0t2TgpnCW9diYX2tKRFBAc
iTr4PiEslb/IUPQR3LO85HAmzZrVVshr
--0000000000001a8f3e061d070a09--

