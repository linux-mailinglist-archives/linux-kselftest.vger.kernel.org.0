Return-Path: <linux-kselftest+bounces-8662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C41298ADF1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2777FB25641
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 08:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3FD502B5;
	Tue, 23 Apr 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7LD94iq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0948481D1
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859242; cv=none; b=JD5+OOn1hQ0NxgJGMjNr7UcSPDdVsUhr2VqOkUy+t6ZTN+iUIjuBSbKK3YsA7PTAjcJvwuUBErYAjImmYG61WA4xi6S+GeC1ZouOkH2dSiUjFuPBqCZY9uJTGZ3IWaJRvB9hcFQtcCRe6ebWapirDJv2l2ddjBH5K8TsaOATnqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859242; c=relaxed/simple;
	bh=Q8F2vmk6ZOOyuNUuqMNwLmK58/7EHVOYB3Hm8gX49zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOkz2ivI9jXkQr9LxWOQz3uLPSlOBs4z6iy2GgUMrkA7MrpGOXxmJt/dbVsR1+lErD7uwemQ+vdbjMl4Eb/Diz+HA6f6T41Z74+ngSGA4cqAZGrsfwOY6LpAHNeg3iheeYQKLMQ+n9UBIcP0CSGrZv9Yy0OommVpxMb8i0Wavfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k7LD94iq; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43989e6ca42so262141cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713859240; x=1714464040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OgzFG/dIOOKSPcn2gWqKes7BmwXB0zJuu+WUY+4ykOw=;
        b=k7LD94iq/x/y+edzr/s5gv1WzqB8oVYxPofTNkIwWKzXYLEv1CgzwVv3WQnB+iolhP
         VtY53pzKQ7NfKkOL2r9S+TRfGiBQke/yu0MeOOJspsYmcoucdMombvXwH7hWmAEAKEHw
         f+jKF63Zr6A52hrGWrYaS86cQ0u6EDhwpGO1GD4E41L36H7UTIB1JhXJOcMJ6AEur9wF
         qVmRP8+ZRWoEXHFWQ0y2CkSEvL4snPc2Zj+mE/0IW4MmeMz/4swO/SNzpUhdWV0LlfI1
         C9Vyz+V9Nr6ifFVkDLnX8APZwruRC1dCRqjahOwL420/WSgDua+r/n0isq59OGxVxs5U
         StZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713859240; x=1714464040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgzFG/dIOOKSPcn2gWqKes7BmwXB0zJuu+WUY+4ykOw=;
        b=jog2icUWJ0rMQPOh38J4PgkXbmvKtuQngS2eC4n2LmGV3DlCQ/7MVHx8jp22r+Wen4
         7CWw6mHSM4fgv5mFqyuBHess4/VTwV3YtnCpZTjfVCAu8TEYZRu594Vs/G2G1PcsVGZl
         X4Vic7uBQ+Xo/nbDcACMcxwIeHd+6kiIiGMNIsJYgiD99hT7XTIIzR17hjohvjJyyxBF
         SSbZq0/Ris5OM+Lxh9aOjTInxgcrMrxHqAs7FgLw7oLo2w05GPOlLaKdFCDTjg+D493G
         aCnG26hRXXSG6INiLOc00oIJd4NHs7ouqs4zRA+J1GBeoatCFwCsYMbDeFUcFjC6+wNx
         te1A==
X-Forwarded-Encrypted: i=1; AJvYcCWJRYZ1h1tEEzQL/Vilfn5f2Iw+twY38nM/1/SRKHnwFSq4pfY2CAesnzZRSSYsu3dl8fx39YMgW3hqCeYvyUV0ZFOZvmZI6pjN+acXFgLi
X-Gm-Message-State: AOJu0YwKsgeqJF95fHjW6TzF20u5Ad7IRX7OEeMt1FknnOHf63TAP1OR
	FMtAcGRhory9cEW3JxIis84lpxCIDkPVdKBWtNrVF2a83HMxYKTWGxHNCSK1rS8XjE/8xj4UlT8
	FlZSnag1Rc/ZafjU4sglAp6CDvTTGhg/1R6L7
X-Google-Smtp-Source: AGHT+IGWgEFzvLK9uPenYjUI4EUDCWkzSlbhZxXqwo2E6P6nifQrY8VUUV8e/q9WolN8SgJOaZSEQz3WJfwHwxD2Lds=
X-Received: by 2002:ac8:6edd:0:b0:437:c6c5:f30e with SMTP id
 f29-20020ac86edd000000b00437c6c5f30emr163820qtv.17.1713859239648; Tue, 23 Apr
 2024 01:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419132504.9488-1-wander@redhat.com> <20240419132504.9488-3-wander@redhat.com>
 <2024041919-unify-improve-d4a5@gregkh> <CAAq0SUnjc03N5kHgJ8vwk19BjzQr8DCRCokh09npmCs2mxxwXA@mail.gmail.com>
In-Reply-To: <CAAq0SUnjc03N5kHgJ8vwk19BjzQr8DCRCokh09npmCs2mxxwXA@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Tue, 23 Apr 2024 16:00:25 +0800
Message-ID: <CABVgOSkC8iK52LW4-H8=Z4FQ7CdepgYHrw_e6f9k1PQRXH_pgA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] kunit: avoid memory leak on device register error
To: Wander Lairson Costa <wander@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <linux-kselftest@vger.kernel.org>, 
	"open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)" <kunit-dev@googlegroups.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003249d80616bef3f7"

--0000000000003249d80616bef3f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Apr 2024 at 22:11, Wander Lairson Costa <wander@redhat.com> wrot=
e:
>
> On Fri, Apr 19, 2024 at 11:03=E2=80=AFAM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Apr 19, 2024 at 10:25:02AM -0300, Wander Lairson Costa wrote:
> > > If the device register fails, free the allocated memory before
> > > returning.
> > >
> > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > > Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> > > ---
> > >  lib/kunit/device.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> > > index 25c81ed465fb..d8c09dcb3e79 100644
> > > --- a/lib/kunit/device.c
> > > +++ b/lib/kunit/device.c
> > > @@ -131,6 +131,7 @@ static struct kunit_device *kunit_device_register=
_internal(struct kunit *test,
> > >       err =3D device_register(&kunit_dev->dev);
> > >       if (err) {
> > >               put_device(&kunit_dev->dev);
> > > +             kfree(kunit_dev);
> >
> > This still looks wrong, the release function for the device should free
> > the memory here, not this kfree, as the reference count in the embedded
> > 'struct device' handles the memory logic for the whole structure (if
> > not, then something is REALLY wrong...)
> >
> > You _do_ have a release function for the device, right?  If not, you
> > should be getting loud messages in the kernel log when releasing a
> > device here.
> >
>
> Ok, I got it. Yes, there is a release function. So this patch is
> wrong, ignore it. Should I send a v5 with only the other patch?
>

Thanks. Don't worry about sending a v5: just patch 1 of v4 is now in
the kunit branch:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/c=
ommit/?h=3Dkunit&id=3D63761ec5971ea47c1f2d7698f03e1c6ffb9fb22a

Cheers,
-- David

--0000000000003249d80616bef3f7
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
hvcNAQkEMSIEIGSOBimVPPGSA0JuQ4FhjmzwIqB2amX7BakLNnO45pkbMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQyMzA4MDA0MFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBrGrNz
NiUjPznlQlhqCOvBDnjmFVzle1yTByv8m8xcmMpEYjRUKaituqRCRuAwtTojU5UCsf7KCEzmZnkQ
1N96xHQUdWs4TIAzcTl/ivKYTFiE1Tbhcb7zQZiFZXtLRwPSHV03RAHSua2Z++IyGMLwQgjzoWyJ
L/NgNHwunhgYjFPrX1yZCkilnSbWj6QdN+Y6V8bkIM2T7qChS/dCCDavNeiSYDuy6IjNvQpr8S4X
vGF2gloqDGZoNfFcWg9bdalUx+WPuXZaiJYBGXJct6bTPiUs8I2c2KD/jjYMOQj22j6hFEeTWFw1
EiymVjU1Mi3iewp9e1/5ln3S76rWFZsf
--0000000000003249d80616bef3f7--

