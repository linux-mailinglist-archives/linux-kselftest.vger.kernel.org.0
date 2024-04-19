Return-Path: <linux-kselftest+bounces-8394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26AD8AA7D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 06:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0B91C22476
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 04:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55AFBA50;
	Fri, 19 Apr 2024 04:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZQsci3R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F548F5B
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 04:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713502737; cv=none; b=E6wRLu3YgRmklMa6NloDRsoNPi8erQIbf1NR3hP7lBybipIAWcwm5EpbE8dKs/DeW+eh6zGMOHf1VKU0ORWjYYJ0u3vavTwnGLvph/DF3+VvkQgEfKopRSgcs3L17eQ0pnol8l21wm2N9karHWQAymu2XT9gNZSDnveQDx7QDnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713502737; c=relaxed/simple;
	bh=z0koi5ss+vsVHghpIpH7SpmThNHdhFIZ5FPxPPwBJ9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ov3LpvR7CrXMV6DEbtIgAUtE3RTm5a4gfU05yjHosxUCDAIywZruCUax5tXGIBjWwcqAnUQsTxQDd5Em7pSxIEHeA6dehqrM/iKbiv1oCQQhZU36qgmIqkUIizXq1SvRNoHn3WmVuQ5wscTfuxPRc5/P0YAuUbm9JRGFx+ExDTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZQsci3R; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-436ed871225so142841cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 21:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713502735; x=1714107535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lg2zRPimmnMEi7heBKGKFMqA/gIf5bCR+FfKa4gTmfA=;
        b=jZQsci3RblzJloY81F7qrJC/YjiGOEuywQrPlHqpOGflAYIjzZBT4yqAmou9TgNdbZ
         fcEiEGSeJnMEsAsbuR7NE5BCc/Pd6lBt3a0+W55+MjN+TcdzJNsjTaRHFHQ17Li9sT0x
         I242OO7O7c5h4alOTD4tPwBc5gLL+OvLUaBfH+aeE+bMZnZ2yDAlOb3xZrSCsjZrXwCH
         Z01Hvq0iLFZQTKVyhhARFFpwQWiz5mUuxrV65OkHhPPCV/HJCRuFseCsZsoVK46tpGCv
         PKmv/giUnNIFxfQK7dmMvXvgooZTRHQts1C/kV50gG9UDnGHN/igsRV4UOeEtFxYBafa
         sZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713502735; x=1714107535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lg2zRPimmnMEi7heBKGKFMqA/gIf5bCR+FfKa4gTmfA=;
        b=DQH7mCZp/Qc1x3TX/oLgNWJUl8gMUUfYCdIdSkhyfrWEHSnmDIhrDGxWUFmElEV1Ii
         mc6wIHti1GdUVjn7a9F6OS/sly9B5Gy6MUi3ZCAEXj2dtvaywAo+IoDPzGSjzqFpL7Ie
         DCRy1B9qi5m0T01FFYzdgvxifSDSwfRW0zA6t2Za9PIL92M6gGPA/fcXkh1roiyAGkXh
         rjxhxgEOH1of3OyF79l/9In6zE3+XRBS9P0hTlug9Vi15axywZbGVgQJq08zRhWk0s4p
         /Mt6dVKWUE0MsfCBPPhzeOFqSn2XxSCcVqqo3pImOLPBzYShHpXRA9xS61dpULn4HZfF
         roKA==
X-Forwarded-Encrypted: i=1; AJvYcCXfcRVBg7M17t+EaV+swENM/9cslhLFGhIG+MZDV41ZzDSPOex/EY5qV1Cwn9J2QGTZpDKU9ye06kPp5x4N98YURiiEitkg5feFecR2S8hJ
X-Gm-Message-State: AOJu0Yw7sLLQgRA5VDDSqSZ4RtRazvSTEwIPXdk9lVl5XNJqU0SKTe+q
	vHN5bEvLra9KOYXWeeblSfEnHhLIOUuQ8WhBrsEqAn4cmbTspWZEHC9KyUjLpqrXKh0mFJWVGk7
	TtQfSRYAzzyjUlU7rDiPn6GxuSqGCPMV6+kbP
X-Google-Smtp-Source: AGHT+IEtA4+CpARfB5vsmh3tcDAFtCecqb318nZ1xGMNN45xDP9fukg8WpYQrN3dnZW/45r+OVJ5eg1lH1FLEzj/8fM=
X-Received: by 2002:a05:622a:181e:b0:434:3688:f093 with SMTP id
 t30-20020a05622a181e00b004343688f093mr100837qtc.27.1713502734921; Thu, 18 Apr
 2024 21:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418210236.194190-1-wander@redhat.com> <20240418210236.194190-3-wander@redhat.com>
In-Reply-To: <20240418210236.194190-3-wander@redhat.com>
From: David Gow <davidgow@google.com>
Date: Fri, 19 Apr 2024 12:58:44 +0800
Message-ID: <CABVgOSncx1eS_8EWsNkoDOj+TaNsaW8MpjG8XaFY2Q8JXo+oqQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kunit: avoid memory leak on device register error
To: Wander Lairson Costa <wander@redhat.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Maxime Ripard <mripard@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000dcb98506166bf1d6"

--000000000000dcb98506166bf1d6
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Apr 2024 at 05:02, Wander Lairson Costa <wander@redhat.com> wrote:
>
> If the device register fails, free the allocated memory before
> returning.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> ---

Thanks.

I'm not sure this is correct, though... Shouldn't put_device() free this for us?

The documentation for device_register() says to never free a device
after device_register() has been called, even if it fails:
https://docs.kernel.org/driver-api/infrastructure.html#c.device_register

Or am I missing something?

Cheers,
-- David


>  lib/kunit/device.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> index 25c81ed465fb..bc2e2032e505 100644
> --- a/lib/kunit/device.c
> +++ b/lib/kunit/device.c
> @@ -119,10 +119,8 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
>         kunit_dev->owner = test;
>
>         err = dev_set_name(&kunit_dev->dev, "%s.%s", test->name, name);
> -       if (err) {
> -               kfree(kunit_dev);
> -               return ERR_PTR(err);
> -       }
> +       if (err)
> +               goto error;
>
>         kunit_dev->dev.release = kunit_device_release;
>         kunit_dev->dev.bus = &kunit_bus_type;
> @@ -131,7 +129,7 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
>         err = device_register(&kunit_dev->dev);
>         if (err) {
>                 put_device(&kunit_dev->dev);
> -               return ERR_PTR(err);
> +               goto error;
>         }
>
>         kunit_dev->dev.dma_mask = &kunit_dev->dev.coherent_dma_mask;
> @@ -140,6 +138,9 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
>         kunit_add_action(test, device_unregister_wrapper, &kunit_dev->dev);
>
>         return kunit_dev;
> +error:
> +       kfree(kunit_dev);
> +       return ERR_PTR(err);
>  }
>
>  /*
> --
> 2.44.0
>

--000000000000dcb98506166bf1d6
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
hvcNAQkEMSIEIL56kAejH7/ZrhvsQs2CvaNGqDJhYdmbj9mUIp6iiBBdMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxOTA0NTg1NVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCMlSIl
qvIYPGSTeWbOGP9HioRXuIlV1MeLtwr9/wizSBDP5NK6mFFQP21ln8mti18jst1QbLlyRi/DQFMx
dcWhMDjMOUyeWiiYtLC6IpBIGj6ZgjspyyowioY9ETaJvH70iAZcbLCPE8G9pnckSzPrKZAtkMEr
EnoxKyPSCLpC+4hPXEvvZiURVOG6u+8BIWw1YCCg46xPXBpqfov1xDOEFTNd5p4kaSG5su6HT6px
oS3s8niNFKaOmGiOrqncl6xjCOGySLNLXOQbJ6xv/sH6O9oJePQhA0RyqwhvzxqrEErGF5T0ZNLW
xOarLOSdri8JNsHw0zm/VTYiJ34OehQ6
--000000000000dcb98506166bf1d6--

