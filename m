Return-Path: <linux-kselftest+bounces-3443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C774383A042
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 04:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3A61C21EEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 03:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054632919;
	Wed, 24 Jan 2024 03:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/Nq4PAA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4653A63AA
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 03:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706068199; cv=none; b=iv6yspFT5BzgRlB4RTcM0qV03u7VAmSk7zq56U6H3HJgEAp6Xyl5lrfXZmKAL0af6XqcAtxOYJLWVoXAYVtXAIX3xje9D9C5OzpDN8X2YBbJtQRaSt5lyIW0jZqIVjYJuIcmayUiii4QHuuSw7HDEyyWCX59l1Adeg3lGnAfpf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706068199; c=relaxed/simple;
	bh=LtqA8Vmxj9JlZ4tWroN3+glzbyJNHGjhtR1KFae/sdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/R3j5zPKWmRCg24mcLd8DlFwLBJ0ErAQgWLkCJrOV4KrPlJ7Cut56hx+T7Xab/4OgDS9kBHajj06X0PpOhgBCHgk/xPKqugaGHh5c1ViQTN1Uuc2D+680b1nLdr8U58AEKj0MrXpFzhzCq3cIIoyDZPgRybWbp4QmbuNRB3DIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/Nq4PAA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55c89dbef80so3316a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 19:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706068196; x=1706672996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cazQCL+HpNkVZJySpieD4n/Yu4Ti9GxLC8twsP4ZjFU=;
        b=H/Nq4PAAZEaM6RAv7qAKYXdDD+5Bl7QjoYfQtdHFAzHmqEbjgod1cRgDVUCAtAwCuz
         m9CZz+mg8qqh5S/PAlrx970skRb8cIQOLtcFtHjNT8fo4+4bqGwOW9mRf8HByFE5D6MS
         cq1sDI0T9Xi3qOy6/Kkysc9oHTONmRcrKydzASbvH31SSyfIKyV/3VaAFu0foHdGL75I
         5zYFwnHcW242ofhM+M7faHvX0UxDroVBGFsMv6wRcFPJoHDSeHQFEnJaVFUQpV7dXRjp
         IP4q9y8PWMubOT9+hsMO6sgg19xxNyhpvbeKWTH1iy/xfo1g/wKyPCWFrlZIkAO7XZhA
         xJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706068196; x=1706672996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cazQCL+HpNkVZJySpieD4n/Yu4Ti9GxLC8twsP4ZjFU=;
        b=w4ZmFVk0HLx1KKExudBvOtcnNcaO00ExDPFOUfjeCIvE5acJMYLStn/sLmFeqKvJPe
         HJ2keExoSUbqxeRFnv3nhYlPV6JS1Tm9+FJNn+xb9TsfVn0tjNH0ySKu0WsYLLkI9AaD
         j0HetxYYXfJOcxMsnPrJ4xsd3mVVzApz2S9oqDDmdZG2nVxLJOU13Qu5GTZHFwvuV2D8
         McfnqvzO4lw6UOiB206NM9cY+cSAgs4WsoOsnP58g+I9zHk2boWNc0emk3xFTb7uIAIt
         Qc7lWgb2A1lvbmlSNKLb91aTs/ajTuSTqY4LqjFxvsJnT2qe/Ghvo4PTi6yp5+PJRWqx
         cwgg==
X-Gm-Message-State: AOJu0YxcPv0jBBgNr9f0H6g+k7HN9DeUMD5wHLdSjn3BYndml4w73Iew
	A6CNfFHdUlYzuiUEkaNFQaOPpoRQWCAC7B6b0vgUYa5U31m4i3mcl5ppyTxEyQEh4DuAOatgaos
	a0sfPGoLQbYOMIsUuYp2siqoQmGd+c0YG8naBl/HyVDNFBYMcNs34
X-Google-Smtp-Source: AGHT+IEQQAVK27uKe7FtIZmXcphf5MHwp8rZyqHW6+RlgwvIzE05u/4rynX1s/2WxhbXLXL3Jnw70adAmSSDH0J1bQM=
X-Received: by 2002:a05:6402:1d84:b0:55a:4959:4978 with SMTP id
 dk4-20020a0564021d8400b0055a49594978mr7796edb.7.1706068196329; Tue, 23 Jan
 2024 19:49:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122171408.3328510-1-lucas.demarchi@intel.com>
 <CABVgOSmjyCf5DSh+LJtaLubHN3F_mrFo=ZRk23u2PEmmkLBUjA@mail.gmail.com> <gi2oosfohy3jjjvuazlg76se6m4w76ys5gxtmj5ngquxwqzz46@s7vgxulxzhao>
In-Reply-To: <gi2oosfohy3jjjvuazlg76se6m4w76ys5gxtmj5ngquxwqzz46@s7vgxulxzhao>
From: David Gow <davidgow@google.com>
Date: Wed, 24 Jan 2024 11:49:43 +0800
Message-ID: <CABVgOSmm8Arj2RvHcsQYMssrK_GKq-wNixjFtmB6AAxhs2hgMg@mail.gmail.com>
Subject: Re: Re: [PATCH v2] kunit: Mark filter* params as rw
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Rae Moar <rmoar@google.com>, linux-kernel@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, linux-kselftest@vger.kernel.org, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d3b140060fa8f43d"

--000000000000d3b140060fa8f43d
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 00:31, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Tue, Jan 23, 2024 at 04:01:49PM +0800, David Gow wrote:
> >On Tue, 23 Jan 2024 at 01:14, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> >>
> >> By allowing the filter_glob parameter to be written to, it's possible to
> >> tweak the testsuites that will be executed on new module loads. This
> >> makes it easier to run specific tests without having to reload kunit and
> >> provides a way to filter tests on real HW even if kunit is builtin.
> >> Example for xe driver:
> >>
> >> 1) Run just 1 test
> >>         # echo -n xe_bo > /sys/module/kunit/parameters/filter_glob
> >>         # modprobe -r xe_live_test
> >>         # modprobe xe_live_test
> >>         # ls /sys/kernel/debug/kunit/
> >>         xe_bo
> >>
> >> 2) Run all tests
> >>         # echo \* > /sys/module/kunit/parameters/filter_glob
> >>         # modprobe -r xe_live_test
> >>         # modprobe xe_live_test
> >>         # ls /sys/kernel/debug/kunit/
> >>         xe_bo  xe_dma_buf  xe_migrate  xe_mocs
> >>
> >> For completeness and to cover other use cases, also change filter and
> >> filter_action to rw.
> >>
> >> Link: https://lore.kernel.org/intel-xe/dzacvbdditbneiu3e3fmstjmttcbne44yspumpkd6sjn56jqpk@vxu7sksbqrp6/
> >> Reviewed-by: Rae Moar <rmoar@google.com>
> >> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> >> ---
> >
> >This looks good to me, and works here.
> >
> >Reviewed-by: David Gow <davidgow@google.com>
>
> are you going to merge this through kunit tree or should I carry it in
> drm ?
>

I think we'll merge it via KUnit for 6.9, but if you need it sooner, I
doubt it'd cause problems if it went in via DRM instead.

-- David

--000000000000d3b140060fa8f43d
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
hvcNAQkEMSIEIFVsBGhvJV69xU35CIDS7vGZp8aI15MdEiWoPZzPWToWMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEyNDAzNDk1NlowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCRzswJ
crbDoTIfQJ66qiEB4G9rpdsfsGbTuYkrymsLC1AxXgc5pgXvQhh0uncPbXn8WYApQ4z1/ooEJC1W
6UJh/LPyKpF9eqKzG/imu52CuLCa4zDgzc0bnWRwTLrqqEtrC/smSZTbUl8lJJhSGrrlOJ1XKuQU
SmsOqO+gOIkBesmPNyw+yCQ4yW5Nj3rWqMHQcdWTQmUPI4Jej7uSVHY7k0wFEBrtYyKXtqT26tnM
maNr5WGjr5Vn2Mzq8KbGtX1FwpdncGgYI00Tyf3VzPyC22KSB42YrQXzvjKWMpR86nC8w3yGdcJ3
Et1IdvboNJy/RcOYU9r7FbZAtVIHOzyk
--000000000000d3b140060fa8f43d--

