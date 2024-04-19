Return-Path: <linux-kselftest+bounces-8393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151EC8AA7D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 06:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0E9284393
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 04:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81AC8F40;
	Fri, 19 Apr 2024 04:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xwLOfr0W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D434522E
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 04:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713502735; cv=none; b=AU5qodI+9ZvFleCvdRyxTKyjopJrHdAzqnoJwwPmyXcSZCi2B0/ZOC+Awk/On2F3BN3Pl77OipDjlPzRL/3unri3qMhKD0TI1hooBcKzHY77aKNpGddsjUMFk3GUTiJSAER8GDJmDxp5FWMuwN0HisXibnKAn4bxObbOQVhI0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713502735; c=relaxed/simple;
	bh=oA3XEXRaqWJt/I5ZhRUCDMDYPTw6smg6NSBazQ0aYTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcViCaI8KkbPDDWFSC4Gi8qul/xqviRPh3iPGAYopK/5xe3v5INC7PngUKtK8fO07OKI0FNX4JCnBtWFvyCGJaTh1D4QX+YahC/xKcsHWsC/grljHnH4nvoPOxMR4Q5mnGUrz5hk8Pw0DWlhNh3LhqjeiF/fZBiyAdq8zKSWIUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xwLOfr0W; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-434b5abbb0dso141121cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 21:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713502733; x=1714107533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GNEKbjGkHnYYSm5QTwWiK+sxeHw2gsDFaNZQVygQsGU=;
        b=xwLOfr0WTbhB6fZwXTzQXW3+7O5i0//C3Y1DxwrLRJ124faeieBHY0POh2tMEFnjN9
         8nh80/6yT+DDiJTPIgF7MtUju3C/BHLPeYKW7idvKYyMQ2iSo4y8xQcbK4iTSs/gT9ES
         OgJx0+Nf3sM0bx1h+N/zMhu7t4A2NO7aKalQNHeooBDaPA8W5m4fjOat2DDu+Jrp2Fbt
         +Ej0PfuvivatCB2GSNLMfE9GnD5pDGenKoc2lWCM7E2A9JSc1Zi3Eto6z9FUvqnyoGEx
         HAIZhzD8fnupUDyjV1vmy9LdiXvNRoRKopzZYJ59439XBLVVfKQNH7xCofcBs1bH7MrM
         XLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713502733; x=1714107533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNEKbjGkHnYYSm5QTwWiK+sxeHw2gsDFaNZQVygQsGU=;
        b=cx8xUKDGTabR+IiWU9yQqF+9v6ipD/ByYr33mHzIAkdqH9rh2HGV+Py/+rjCq9RrXE
         tM5hV5EYDaKQOoP3Xm+RFe90Dvn3m+Z+o6ykTZG4al+2Hfo9+fBIw29uqVvS6qesgbJe
         CnJg3Y0UkCcx9fmdSASqAes4J3hVIZ+nqkRPW1HCMJlidb6zXTZVM5/f2alkSc5OukwS
         w2cbw66oCUHWR3YnxZKacbCkXlsPOISfdtQjN2+my0EA8A/roUnkpg6gVE04nGrwwq5D
         hRuOkUrD9K+5EguUc23GcLXFcsARX4Djfen1D3e5tYzGW76MTk/ptb5IRTxrEsYTVcyM
         tHGA==
X-Forwarded-Encrypted: i=1; AJvYcCURbed8gENFo8+o8y7gdcta7rGOzsKH50z83YtFxMkS8ddMllpOgKCjrfhgu14hJgwt0DeSPXJOQjUsreLdV4j1cHJJajSkciYQt8MfpOBM
X-Gm-Message-State: AOJu0YzpUimwCw7Lbr5PaibX49JuO+E+EVngXhmaEwQixy1k5IrD9cVM
	TWTdhvmBnZlcWhBO30HY8yNji5stx8tmZSJwN68tUzsG6nY06BsSxVytl5NP40nxi4SXLvIdXtc
	p2j/wfknzikmLtLKZDkhGRfKkRG5X3dVWCGoi
X-Google-Smtp-Source: AGHT+IFJCCs7RE2v/lCajru437Sglk3XPRi1WKbCas/hsQW1Op5YytNMbFL+1ff2t02JnWF/uqWhYobMk8XU605Fp6w=
X-Received: by 2002:a05:622a:2d2:b0:434:7926:b8fc with SMTP id
 a18-20020a05622a02d200b004347926b8fcmr149141qtx.5.1713502733088; Thu, 18 Apr
 2024 21:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418210236.194190-1-wander@redhat.com> <20240418210236.194190-2-wander@redhat.com>
In-Reply-To: <20240418210236.194190-2-wander@redhat.com>
From: David Gow <davidgow@google.com>
Date: Fri, 19 Apr 2024 12:58:39 +0800
Message-ID: <CABVgOSmBaxc+ZLt8mUYiHSUsrLWDHK=uj73MfyZtghrm3vj8yA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: unregister the device on error
To: Wander Lairson Costa <wander@redhat.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c2352306166bf15c"

--000000000000c2352306166bf15c
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Apr 2024 at 05:02, Wander Lairson Costa <wander@redhat.com> wrote:
>
> kunit_init_device() should unregister the device on bus register error,
> but mistakenly it tries to unregister the bus.
>
> Unregister the device instead of the bus.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> ---

Nice catch!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> index abc603730b8e..25c81ed465fb 100644
> --- a/lib/kunit/device.c
> +++ b/lib/kunit/device.c
> @@ -51,7 +51,7 @@ int kunit_bus_init(void)
>
>         error = bus_register(&kunit_bus_type);
>         if (error)
> -               bus_unregister(&kunit_bus_type);
> +               root_device_unregister(kunit_bus_device);
>         return error;
>  }
>
> --
> 2.44.0
>

--000000000000c2352306166bf15c
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
hvcNAQkEMSIEIDKFdpbd3X+mI8udaeRkZkAW9kgv8i6ysBLaKbXlu2QJMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxOTA0NTg1M1owaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAuLTS2
HB1bEjmny9QwYuaHYcxLi/UPxhiJ6ZBYwbN5S5yqkTPHVoI6hHiv5oTDcyXyf3Fk3HxVafufbbIp
Cv7XPrfPWYhN1CKOBzyKHHFEwr7HpzbJqgDsbxTr9fMDbapHPN68E1+gRB5M/Gsg9eJDhKNaQPlU
JX+BuIYDVVNcEwjT0hm2TzuVuOa/cbAWdc2gcQzgZHWFy+kfY2AoOoiAS7UrNGweh/AGb0daUvf6
xankVUctErwtJKqrJgFd/EBCuErez08c6Kq/uzfP84R5LWep/pDaXj7RBb+pK1iuksUvFrCNxiJt
g73tmZ3HGRh0FvGGfPA+cbAvfEW9wJg/
--000000000000c2352306166bf15c--

