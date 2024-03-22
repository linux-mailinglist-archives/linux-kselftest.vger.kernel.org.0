Return-Path: <linux-kselftest+bounces-6483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD3B8865B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 05:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE7B1C22391
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 04:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF653539A;
	Fri, 22 Mar 2024 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9X48vWL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D306FAE
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Mar 2024 04:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711080746; cv=none; b=pF9eupDrHDMJ0i3j3XgGias//+uHSPQrj2R19h7xhGAea8cZdOI7q7wQUFB0luQRqPFayEFqkjCGc5SPalOhQqMxXmOZd+T9Ml1uhUkDza6WGpO+Aae8vjQzeNWMc7RpwKdg3Tyd2qFLsRxts74X5Q6Fr5MuiAgacXOr/GiKB9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711080746; c=relaxed/simple;
	bh=9tZbuE6vP5dNDVQEaCNGvmbsxv8hGV0gUWXaWJ10HQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uM3mKvUWhQ6ywmKJElp2Owgq1joORQfWnvsydQepqVJ+5+FoSlzwhMNiZKCrA/2G/M1qZr4UKSFkK50Gc/LzRpGPXqzJBaq7k8Q6bMGTMnHBbTNobdFaDs/56Q784+a8T4b2edSrZATNE3kSO3Igo+RS4cAJ2RQeiJk3JToPGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9X48vWL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-568c3888ad7so7934a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 21:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711080743; x=1711685543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uUpp/KAPARwMu/n/Wtld5eLIYsZnxoHAWz/R2S5fjY0=;
        b=B9X48vWLR9BgXclslCIO10Ia+CT5RSK42OunYR52ccMVmjTvvVPKH4iwp8olOa7d9a
         eU4BzC9gmbiETGWfznXzrGg3KOLEDBY/4FkFG/f6KI81hAQhiAiz24ZnsXtYMIZwTVBY
         KErKR4q2dhivfLYm9Ojt0fqIB7QN21v8q3pZzgBG8+8RQczc2aT85aWfSF9VlZ2Ejdei
         oc7Joeu/caPOGAKEgtIWCEoE6CCLjOP6Iechq5+DiJaJaZO7rRwvaPcimNtZJceHWqXo
         lKZapJqnVEaSz9A/7pMth2DYmCnjvLQzOOaOmOsfdJHl1OZaRqpHXQwaMxcbEI59ZzIT
         pFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711080743; x=1711685543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUpp/KAPARwMu/n/Wtld5eLIYsZnxoHAWz/R2S5fjY0=;
        b=XSE57GLuBonHA+OwZE7e2zlj6h5Vcwjubx32OTBKJrwDM1hjbws3H5ruEI2jkQ2bon
         fh/aSBo2gq/Aa5zfjr+65g5sw0hx9gGBYSLgGnHu9l//eXU2yYq8tgIXRGThWUi5nXn5
         m4T0XYJGFgGqxLWGDoKXz9iqJ8aDV78dtDdzzqn14wI2J76C3Nxaxc1zoujAtkfJ1MrJ
         yC+5F3R2GR4zPX0VvIwRQZOLFWJnVtPzaxm9V8exXAcO5wVd5+GVp4HADBJODULh8rn7
         NjaZii4vCPcTmZEZGsLOl/uFUgHIUIzEYKyU9kTz3mKE6ln9QvTAh9vcrb8F1aPcgga3
         tuCw==
X-Forwarded-Encrypted: i=1; AJvYcCVUaiKy/GTAHlJ5Z1rlPyHIQwfSl+PTIhlMXyv5JSe7017b9Aj4d0hjS4q3dYJYzt4Xy3mBzXM1Jq9CsK9M9OvJQxJEt4MS6ruu4ggGMaND
X-Gm-Message-State: AOJu0YyBILqMBxQfFUhJR6u5dkpUaRhK1OCXMAj/+nigpql7EKUTvvxX
	t/R34Ewoxxb6c5mR2XnQyGwyemajPWO0hSdJd9n6vK6IXqoYzcK+mjZmfpUIYGdh8ANeVRv1D1J
	+6vwKP0vg4CwFcov3c4pGalSX2Gj6TjXpn6Fc
X-Google-Smtp-Source: AGHT+IGxanXjgGcOapF59tHbF2WoOg7zW4/uF2onBPnCibCnAINNFzUr1hhboYKE0sEYEJzwOnupeijArSEBuUy3IHQ=
X-Received: by 2002:aa7:cd12:0:b0:56b:b464:d529 with SMTP id
 b18-20020aa7cd12000000b0056bb464d529mr329111edw.2.1711080743058; Thu, 21 Mar
 2024 21:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320171424.6536-1-shikemeng@huaweicloud.com>
In-Reply-To: <20240320171424.6536-1-shikemeng@huaweicloud.com>
From: David Gow <davidgow@google.com>
Date: Fri, 22 Mar 2024 12:12:10 +0800
Message-ID: <CABVgOSkJz5ZRePqQR3naK__MxoRLsE3VV0TJOhfjOYxmRayA8A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: correct KUNIT_VERY_SLOW to KUNIT_SPEED_VERY_SLOW
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, corbet@lwn.net, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e8ac410614380756"

--000000000000e8ac410614380756
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Mar 2024 at 16:18, Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>
> There is no KUNIT_VERY_SLOW, I guess we mean KUNIT_SPEED_VERY_SLOW.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---

Nice catch, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/kunit/running_tips.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
> index bd689db6fdd2..482f598d141c 100644
> --- a/Documentation/dev-tools/kunit/running_tips.rst
> +++ b/Documentation/dev-tools/kunit/running_tips.rst
> @@ -294,7 +294,7 @@ macro to define the test case instead of ``KUNIT_CASE(test_name)``.
>  .. code-block:: c
>
>         static const struct kunit_attributes example_attr = {
> -               .speed = KUNIT_VERY_SLOW,
> +               .speed = KUNIT_SPEED_VERY_SLOW,
>         };
>
>         static struct kunit_case example_test_cases[] = {
> @@ -311,7 +311,7 @@ suite definition.
>  .. code-block:: c
>
>         static const struct kunit_attributes example_attr = {
> -               .speed = KUNIT_VERY_SLOW,
> +               .speed = KUNIT_SPEED_VERY_SLOW,
>         };
>
>         static struct kunit_suite example_test_suite = {
> --
> 2.30.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20240320171424.6536-1-shikemeng%40huaweicloud.com.

--000000000000e8ac410614380756
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIL1LdKj94T/2R0cL4Yidkga41orJF2jK/ZbbD9dlZSrhMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMyMjA0MTIyM1owaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDLI9nR
4dXnqqk9dYWfoXVlGGPRRH9uNhuwXsMKXEtdTamGK0p05eOZS8TrxB4jE4kSPYUHv15QYew3OuxJ
z+1zVT32RMeIvIFYM6zEc4zqU+fLeSU29IzOwPwIjQsoNF1h1GuSlJaRwfrikQ5NncMSjGOHY9Rj
5j6TRplumPMIqG1ed+0ZMYNtThvRyQERzPlMeTLuIm/lihwu8k/upEDBfa8zlc3Xr9ldcPkg+j9j
JkCTTJl7mG7IIrqCPL+2VKCIbzwh0lIEu0EnAB90eG7YUAA5X2p9Lgs6MKbo9BkyvBQ1XBr9DXhF
va9pYk9sgfI0kkLEqQyK7NkYvnkVzV15
--000000000000e8ac410614380756--

