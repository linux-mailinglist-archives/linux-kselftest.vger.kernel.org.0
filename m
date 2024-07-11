Return-Path: <linux-kselftest+bounces-13541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EAA92DEE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 05:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B41283F67
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 03:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D626F20332;
	Thu, 11 Jul 2024 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EyxCsDpM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344DB374F5
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 03:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720669792; cv=none; b=pk3Py4q/EudFjHb0mAePJmT/wuavBUcSET5jAP2/T0kWtf6Kov47E5PJJPo9L8BKzfbDniDUwvAqdqDjDRdI1cLM8ZXmj/GlpjqSmbCdygUULpCb3Au6wdxaNZegPDlNWF5hT2HlZbzshzNNxfSt6DVFecLvbUuMgzDc2krwwYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720669792; c=relaxed/simple;
	bh=6QHzHsckvJDngWTi/DXYkSamGnOM1e67ujDauiVc+qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6dfiG3Z/gZRSFg5j+sAsudcRwAB3YRqaQbCYF/EtphUOvQHxVUDYsr6qGnmj8nM0lqVo/h/8uAt1Zz88063C4D+nT2NH99uCB73p9Y0trOdJhYMC/XmfVWPF5tJ++Xb4CUaj/VdpMwZ3jMo2yAXiL3BClMy1h6fgtg6Z5qrQtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EyxCsDpM; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-447f8aa87bfso226131cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 20:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720669790; x=1721274590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0uzZ+9sN8HyP87p9H9ymKBPZjMXN+dYhEjv54HEi/40=;
        b=EyxCsDpMA8AVTF/3k4fr8mRtG1QMzJMXyeJn4qDJg2ab8ESk/PBj2aDDDRlKXVR33G
         KVzg3GC/Fjleu9YX+Nbcq43cXX9bdrydFZf5fkHrQfD1IxMlwu1P3eju307dfIjuEbgN
         Xk8mn2uq8DuYF0gGkixichVE8EqT0l990+iVoopfwom2wqe5Hble1/ofnHsFdb+ngOnT
         I736Ip48l6yM7BQG88iJNUq9ZBgkYoKZ25PkERRx5gIf4C2t1LF6miwcvO0lM3N83kMH
         sD/tv+MhA7EmOcwnoqZD7uAHBg18sad07p5Avj+IKOucgh6ea8Yh3ERLzeL279pA2egs
         Glsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720669790; x=1721274590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uzZ+9sN8HyP87p9H9ymKBPZjMXN+dYhEjv54HEi/40=;
        b=sbKe87vY9zFncMgc5XQs+uiYewQr2eBQXWZhE7S9/Muid0nX0eENbj3iDXp4YlLOqd
         CAlZT97kZi083ao18Nm287Wsrquy8UF0+SB04oF0/nAwlBaGx1j984o7rtDFuS81niqQ
         uvY1OeVHSAzerHUtYktip8AaqeTBwRuAC654DP31E21K8ppo6g+mPKM8pk8yZ4kE0iwo
         A6TiSGDxd5WxE8GFqrErgv7cbJ/xWqFypzJHLWCZe1HbrAaRsDOvjB6ZmvmxLI1v2QkN
         5DAdIUYIWjBPa6kIRvrlC2PFUU4wNw7IRB9xNySryMzGdxxZA9yu7qLTfWehOSv8/ibq
         BrtA==
X-Forwarded-Encrypted: i=1; AJvYcCW+3IUXoWXcRIRWY36ftM8ZjiNR2KOPdEYVI4xWNl8m91Wb7A9elnus0rHbuOryGE8Wt6kbynhJIifU01nQqtgogfep5ZyPq+3hfNcp1jQH
X-Gm-Message-State: AOJu0YwJyDW/7agO7bau53XWxvRBuzzlndAxPlUfinl2N044dctkWi8P
	tNtkykEd0gQnqkKtNv/8AVM3MvbBbdy+TZzO1qj2d30oKMbAjoJhItVYUM91plSv8oUjNR6isBm
	+Dbpjvggz1djsXIe0sMaMT2eXNT4IDNqWGFPb
X-Google-Smtp-Source: AGHT+IE8vdcKy3+cn+5ZDGGgHSvtnQqomXWWbheafyP39WK66FAu+7Y3PUovIWAG5AKoJwCvtgp++H6wh27mWlo2HTU=
X-Received: by 2002:ac8:5650:0:b0:447:d7fd:63f with SMTP id
 d75a77b69052e-44d35b2b4abmr1081341cf.19.1720669790162; Wed, 10 Jul 2024
 20:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710170448.1399967-1-ericchancf@google.com> <20240710170659.1402746-1-ericchancf@google.com>
In-Reply-To: <20240710170659.1402746-1-ericchancf@google.com>
From: David Gow <davidgow@google.com>
Date: Thu, 11 Jul 2024 11:49:38 +0800
Message-ID: <CABVgOS=2Ywq2_T+nGY6J8yQ-bfj0tZ-xDx3ZDsvphj2F1M=rfw@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: Introduce KUNIT_ASSERT_MEMEQ and
 KUNIT_ASSERT_MEMNEQ macros
To: Eric Chan <ericchancf@google.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a499e4061cf0a7e2"

--000000000000a499e4061cf0a7e2
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 01:07, Eric Chan <ericchancf@google.com> wrote:
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

Nice catch, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  include/kunit/test.h | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index d1b085fd5dc3..52bd50d2b150 100644
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
> 2.45.2.803.g4e1b14247a-goog

--000000000000a499e4061cf0a7e2
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBOMwggPLoAMCAQICEAFsPHWl8lqMEwx3lAnp
ufYwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yNDA1MDIx
NjM4MDFaFw0yNDEwMjkxNjM4MDFaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCTXdIWMQF7nbbIaTKZYFFHPZMXJQ+E
UPQgWZ3nEBBk6iSB8aSPiMSq7EAFTQAaoNLZJ8JaIwthCo8I9CKIlhJBTkOZP5uZHraqCDWArgBu
hkcnmzIClwKn7WKRE93IX7Y2S2L8/zs7VKX4KiiFMj24sZ+8PkN81zaSPcxzjWm9VavFSeMzZ8oA
BCXfAl7p6TBuxYDS1gTpiU/0WFmWWAyhEIF3xXcjLSbem0317PyiGmHck1IVTz+lQNTO/fdM5IHR
zrtRFI2hj4BxDQtViyXYHGTn3VsLP3mVeYwqn5IuIXRSLUBL5lm2+6h5/S/Wt99gwQOw+mk0d9bC
weJCltovAgMBAAGjggHfMIIB2zAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFDNpU2Nt
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
hvcNAQkEMSIEIKaEfZNrun4WPR3boKT9b+vYGc+KqkmyLyXJ5J0QIuJRMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcxMTAzNDk1MFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB/NxA2
sM2dze0mw7QXJFI4Vw40xJ3/Nsv/+O6OwOOkqILzh28duOh7lLWXRmF/icgMD0PxfIvJu8wWunrw
UvMs1Uvh+FhLZdcAwrBTgTkhcnvf3/hSB2Z24z3Ta4tRe+7wfoZuzX5wsLpwxiANRLkDftFhM+RG
OgOVVlBTjGA25G9GgUCCSN8ActPM6x5HL2BU8yUMB/pQjUYW1LHjT63VMrCpNh5k4UqEVvMsVDv3
NGudKFCjyoNh5VJtfQDUXZfqz7HRd2J2bECWELQpdAG3tCCfYBWycwbT5EINXoC1bOH2LQ+DB29V
JXuDbrktlfx+LBuOWsZFI3tk2UxMH7fy
--000000000000a499e4061cf0a7e2--

