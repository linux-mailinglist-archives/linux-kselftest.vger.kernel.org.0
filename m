Return-Path: <linux-kselftest+bounces-5471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D26286885D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 05:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E613B288288
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 04:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414B152F95;
	Tue, 27 Feb 2024 04:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdRwR18g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C4258AB9
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 04:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008982; cv=none; b=KXg2NiQPYrtWgF5h+QJRtKBMVtDYa9JsCCWabUkeR8doNAMJ01X5LML/KnVMx8YMeNeobAzkXLzxT3aLU01ZSSllzbTrzHae6MEF2l4bee2xiSgFu7XbpPkZ+Jlfwe+9xiNZITWXnoba5xuXeOXieqeXJesnCRbCNXj/g3GnqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008982; c=relaxed/simple;
	bh=YrXlux72FziPHS6Qfs3OyWRN5q2suGcfNj0uooHxzsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DglaIT2fCJ2HqIY31Sw/rlYmxT2cPgrGlIzD+xEifbR9/xdI7TREy94duAOzDoqBrfFX8j78jUxDTlYWddVtDdLAcebKba1tzI/XbzyOu3Kofx8oFvsthWkdxMNuX2L0vL9DU5rtghS/mtt2ZJ/Aq+sKN2WE/NidVeEtaqpVJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rdRwR18g; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso4310a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Feb 2024 20:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709008978; x=1709613778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HMI2SWR5vlNbEgJOKtmgV9mlq8DPg8/MzXrQ7O01WMk=;
        b=rdRwR18gu58o6cN8nI7L54SpMrVn3Tbj0UykR36O2X7Q3HWDuEJ57d5/0HyzlI338u
         PxYD+P1glP8zCHPzjOki7ZDdibvSov7q8RUd6BYAG1PchuE2su9OBXHVoWSZcJP36AgO
         T18nkxauM/GtUJnqy9+9xGef+8fv/PTNHXfdIFE5RMe1IT65Xq8JrtymvQ6Ps/hyDCpQ
         kLPV+kuwf3fdQlDvxRBU2qTBEjJovntqiAH0l+dZV7fhjX858o1ia3nvL/FkLNVT+Rdq
         1V6EDONBxJsmR0VdYhfnHtvElbmFkjF202TLovj1JyWc2tKXwcOG/AG1enHvfHXY9dhV
         Z/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008979; x=1709613779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMI2SWR5vlNbEgJOKtmgV9mlq8DPg8/MzXrQ7O01WMk=;
        b=KijTUNvqTNPxWPNyv3DkDKRjtGifRvpBwVrugdBuWi1ZFAwV66SPzR2zAZK0oUHgaP
         FxDkk0wRm++Ia6hVDllrJ9VbKRzh05lsrKy11LZqo8tlO4Ot4YFALd1OjGG/AP3NM+rK
         8p4wY/aVWHgCm+sGkl0u4SXdbXFBvUjYYENmnutbxfhubHp6auy5uSYCoRAA01sIVYSd
         7Ku1mHNKlU499cBebHWpLKTC4SgMN/DXYn67t2UZkj7d7pnpGJY4xpWRwQ+hMUX2MKQt
         1azNsyIfKd57vkR0lnWlXiyCwq1MpV4j9L2Tuij/i3JEAih0uLoHbs0x/xArsG8NQrPd
         KUBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtSXL0IkMPxE+z15IsItn91OsEgYg+wYTmhKshPPfHGBCPPBn/Thj3wYaTDOZDqI7Z2p3T4Du2maxvYAQuyG0pUvEav2IajAxqYESgu5JQ
X-Gm-Message-State: AOJu0Yw+sgokR6y3BDrD45VKjUS9kHzpK8L6BlPM3+AKIJz/UE53mf8f
	OAKcjZYu04OvQCqkEjRGzoFOxm5lXgwKBMgVL/XTdZAoQ3F7wq9GXkbQVDvgJ1XVntAP/oqwVhu
	UFJ3qEeXK0SP7D1ddC9QZV7oa2U3mqqOQ3M/E
X-Google-Smtp-Source: AGHT+IGmZBJkvmNkm7r7yh3652b93u1GAaWfHi8wZTVjaltKNKpq93Q7Sn9SXKC5meHzYbDMHxks13nnLWFCNbpIvlg=
X-Received: by 2002:a50:ab5e:0:b0:563:f48f:a5bc with SMTP id
 t30-20020a50ab5e000000b00563f48fa5bcmr83997edc.5.1709008978581; Mon, 26 Feb
 2024 20:42:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221125324.718192-1-mripard@kernel.org>
In-Reply-To: <20240221125324.718192-1-mripard@kernel.org>
From: David Gow <davidgow@google.com>
Date: Tue, 27 Feb 2024 12:42:45 +0800
Message-ID: <CABVgOS=f6FYH5nCc6r8=qPUOx9v0WmyQFQk6Lb4hEwxaz5sM=A@mail.gmail.com>
Subject: Re: [PATCH] kunit: Setup DMA masks on the kunit device
To: Maxime Ripard <mripard@kernel.org>
Cc: Rae Moar <rmoar@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001c683e061255a9d6"

--0000000000001c683e061255a9d6
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 20:53, Maxime Ripard <mripard@kernel.org> wrote:
>
> Commit d393acce7b3f ("drm/tests: Switch to kunit devices") switched the
> DRM device creation helpers from an ad-hoc implementation to the new
> kunit device creation helpers introduced in commit d03c720e03bd ("kunit:
> Add APIs for managing devices").
>
> However, while the DRM helpers were using a platform_device, the kunit
> helpers are using a dedicated bus and device type.
>
> That situation creates small differences in the initialisation, and one
> of them is that the kunit devices do not have the DMA masks setup. In
> turn, this means that we can't do any kind of DMA buffer allocation
> anymore, which creates a regression on some (downstream for now) tests.
>
> Let's set up a default DMA mask that should work on any platform to fix
> it.
>
> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Thanks for this.

As Guenter notes, this fixes the ttm tests, which are otherwise
completely broken:
./tools/testing/kunit/kunit.py run --arch x86_64 --kunitconfig
drivers/gpu/drm/ttm/tests/

While I suspect there's probably a discussion to have around what
things KUnit devices should set up (and how much flexibility users
should have there), I think this is definitely a fix worth having in
the meantime.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/device.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> index 644a38a1f5b1..9ea399049749 100644
> --- a/lib/kunit/device.c
> +++ b/lib/kunit/device.c
> @@ -10,6 +10,7 @@
>   */
>
>  #include <linux/device.h>
> +#include <linux/dma-mapping.h>
>
>  #include <kunit/test.h>
>  #include <kunit/device.h>
> @@ -133,6 +134,9 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
>                 return ERR_PTR(err);
>         }
>
> +       kunit_dev->dev.dma_mask = &kunit_dev->dev.coherent_dma_mask;
> +       kunit_dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +
>         kunit_add_action(test, device_unregister_wrapper, &kunit_dev->dev);
>
>         return kunit_dev;
> --
> 2.43.2
>

--0000000000001c683e061255a9d6
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
hvcNAQkEMSIEIPXYL36n7SDZn05WUsXX4EtXUSqYXXgcJrvG4omJkSrwMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIyNzA0NDI1OFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAF8hiM
tREQc+ApILjETzf2btpOES6i419DBJUv1YOLfyv9BcHE0CFFppFwdnbbOnKQkxM+z/rvWBNZ5Bhn
9c15a0M4Gl/S1vsrGwBVUAuL+hBZkJtLfX/jRleoKDKXPoLxylv0vwoufK9u/bVjQXVbYvPRZaeS
7ajJf7eB2gbZnIr8mWyuF7NR1l+T7dxkenN7zFfGy/MxWR6KrAE0i6/xCh/Y3TJSLUX7Wz4UJMn5
oPrDTsUemGZaT8NiBVDZ7twiMCWklq+DoL6ss5oWz6Ixs6k8hIKswgmt3xdyQf0PjhIPu9NabnIP
2uwku9HpIlfCqZgTiOsATHpIXXxp5I8q
--0000000000001c683e061255a9d6--

