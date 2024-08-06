Return-Path: <linux-kselftest+bounces-14825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB3494873F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 04:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2141428107E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 02:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC734AD5B;
	Tue,  6 Aug 2024 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y7yy+Vmk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EDB184D
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Aug 2024 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909950; cv=none; b=qZDgz8lFLW1hC9xNReYwD4zh7gVpKHwkDexuF+g2hsFoBBHRzfOyBYl4GzWyg4ZI+/GRXNCrSjzNUZ2ErxQsQotfwnMcCq9buGtHqvj8gNfl7nEFqiyZk1Q7docKFMvOu3wBR2xXi8glZ3QfiDzau70nnZMCaHDhM9kSEHS+xqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909950; c=relaxed/simple;
	bh=QOFcGwY0dfE5pTlRTkKwx0v8srd1t2MdbaP5WpKRbS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATZL64ILfS/yt7WbbArJZOk3UCICl3B5/6rhVIt0V+WPQM4GKXCTMo2M5Q5il04SE9Z0puT3NBocHIrHgJcwcoTxSSzCBHDSN1omPRGA05jJjK3welQEh009tS6ZjBxsFXtQ4LUp/BkKFRHvChOLzIK4q+mfGKMk64QEyodUa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y7yy+Vmk; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45029af1408so84361cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Aug 2024 19:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722909948; x=1723514748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QOFcGwY0dfE5pTlRTkKwx0v8srd1t2MdbaP5WpKRbS4=;
        b=Y7yy+Vmk0U/k2/1nfMdJS9wv/4IwjwnNMuggYXPMzKwcUlrHgTDTXPJiUmz/TleZob
         DpvL7ubP54kZWbVwsRbcvCnZ31dzRbUnvE1Fw8YjJixPj+LJSimqr4DGNqVYsqPEOC8k
         9kCR2gnMOdKEi936MePxdI6W2vFJN9W+wJ1RPqfMlQYUzSDwf2vsJJH6cWRQU7VWMMOQ
         UK/WDCFGulc70Le7Hf6ArMLh3n8GEFyHbVxhYJHjVaZ9sj3qNQQg3vH3yiKR7M+OdMH+
         3pquj9b2zCnthqigXhvXOn2vdSfRIebHeN4dgPC3uDD9vRjbjLrmhB7NCdtTWCSC1o1O
         gUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722909948; x=1723514748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOFcGwY0dfE5pTlRTkKwx0v8srd1t2MdbaP5WpKRbS4=;
        b=X68UUmUi1F6REv+M8loRZksDG4Q66vHX3SjfBhEsj3RPaoZVcIU6X3FOTO7RAME4da
         WSQL0NQuiBrJT/Qd4flafdpfFgLPj3NgLCWuJY376ZIOTDalc/5PV45bUE2C8LMLtTK0
         vqEyqzt+P1mte0B5K8RV3rockAEDImCbu/EuijfQxy476o3WBksfNhEEkUbgs2o295vV
         E5CwX4EErp+qGMExjdDcp90cEQYL/7umxqTumWH0JgR0w0CS6Sp3WLNttaWbA7aBOTRM
         vfu+/sYgH8fvAG2NrWQA4ah06B2Jrgdzg9CcrCdBVLK6aT2dP7FKAAGs87+eYEqQnRWh
         pMTA==
X-Forwarded-Encrypted: i=1; AJvYcCUfJfejRGwAbt7LnXNcQBOawvBA1uuD+fMIMz7GmatwIXBuXSWKEv7kbL4oF1ydBE0ssvXqcUYYewAM5ESVD1AClCCkm/csq3balk5FcHUQ
X-Gm-Message-State: AOJu0YwUBsrfqNWTwErxPRr+Du/shI3epz07ZlP/UJK/llfQIhNHIFCh
	HgkqDuxCWS4AoaYdtBiAqts1Z52ghMa43AKSw7B+VFAi5g+Cnu1YN5Ol3DEDjPrRrs4gRqVWC+v
	N5nSYyd047IeuHDpCVuLzk69YsRK6ptDEjRoA
X-Google-Smtp-Source: AGHT+IGTGLp275OMy7GJaTKyETvGaANpJWPQ0m4N0P7BzQznKGlow/QggGN034uk+hjkyhImdcC6mGzfsLzMa3Y5SXw=
X-Received: by 2002:a05:622a:288:b0:447:e792:c797 with SMTP id
 d75a77b69052e-451bd21e471mr917161cf.29.1722909947922; Mon, 05 Aug 2024
 19:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731070207.3918687-1-davidgow@google.com> <CAA1CXcDKht4vOL-acxrARbm6JhGna8_k8wjYJ-vHONink8aZ=w@mail.gmail.com>
In-Reply-To: <CAA1CXcDKht4vOL-acxrARbm6JhGna8_k8wjYJ-vHONink8aZ=w@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Tue, 6 Aug 2024 10:05:35 +0800
Message-ID: <CABVgOSnBhzh=n0VeKY=TZVT_BU=Mx-rTO9kbDo7XuxALtDCVng@mail.gmail.com>
Subject: Re: [PATCH] kunit: Device wrappers should also manage driver name
To: Nico Pache <npache@redhat.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Ripard <mripard@kernel.org>, 
	Kees Cook <kees@kernel.org>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000075fddb061efa3b9b"

--00000000000075fddb061efa3b9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Aug 2024 at 08:23, Nico Pache <npache@redhat.com> wrote:
>
> On Wed, Jul 31, 2024 at 1:02=E2=80=AFAM David Gow <davidgow@google.com> w=
rote:
> >
> > kunit_driver_create() accepts a name for the driver, but does not copy
> > it, so if that name is either on the stack, or otherwise freed, we end
> > up with a use-after-free when the driver is cleaned up.
> >
> > Instead, strdup() the name, and manage it as another KUnit allocation.
> > As there was no existing kunit_kstrdup(), we add one. Further, add a
> > kunit_ variant of strdup_const() and kfree_const(), so we don't need to
> > allocate and manage the string in the majority of cases where it's a
> > constant.
> >
> > This fixes a KASAN splat with overflow.overflow_allocation_test, when
> > built as a module.
> >
> > Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> > Reported-by: Nico Pache <npache@redhat.com>
>
> Hi David,
>
> This is failing in the Fedora-ark build process [1] which builds the
> KUNIT tests as modules.
>
> + /usr/bin/make <SNIP> modules
> ...
> ERROR: modpost: "__start_rodata" [lib/kunit/kunit.ko] undefined!
> ERROR: modpost: "__end_rodata" [lib/kunit/kunit.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
> make[1]: *** [/builddir/build/BUILD/kernel-6.11.0-build/kernel-6.11-rc2/l=
inux-6.11.0-0.rc2.22.ov.fc41.x86_64/Makefile:1895:
> modpost] Error 2
> make: *** [Makefile:236: __sub-make] Error 2
> + exit 1
>
> This seems related to
>
> +#include <asm/sections.h>
>
> which defines __<start|end>_rodata.
>
> When I tried exporting these symbols I got:
>
> ERROR: modpost: vmlinux: '__start_rodata' exported twice. Previous
> export was in vmlinux
>
> So I'm not sure what the problem is here.
>
> [1] - https://kojipkgs.fedoraproject.org//work/tasks/9116/121539116/build=
.log
>
> Cheers
> -- Nico
>

Thanks -- I've tried disabling the use of is_kernel_rodata() if KUnit
is built as a module, and that seems to fix it here. I've also moved
the new kunit_kstrdup_const() and kunit_kfree_const() functions into
kunit.ko, so they're not inlined into other modules where they could
cause problems:
https://lore.kernel.org/linux-kselftest/20240806020136.3481593-1-davidgow@g=
oogle.com/

-- David

--00000000000075fddb061efa3b9b
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
hvcNAQkEMSIEIDkRmhdvlCfhpAEalWcAO5Y3DejQNlmrNtpMb9It8DFoMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDgwNjAyMDU0OFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCJgF1I
u6fLeM46ZZC5Rxlt6SvTofP+qRWOfJXknMcULY35rBdjwS099BjZT43fN4ESIXLE1zVu8ijsCEsr
9EM6RVKV7vLpa+IlhtF7yegixdAFElRli++5uVZc28xRjhPL+KqtoXYWnbNTk94eGBLTGtiAvjaC
qYJ8jbncJN0n20fEv3/kwLvFYP120pZzhQl3XXw74fnpkmXSuv7gNbI8VMedtuGxuVKlMzohRaOf
Epvtfq8cPAHmOIbFcrKd4VvR6KYyYyvRZJ0hJK1z+BOBxOPIe7HIAbCnQ2T2jjOpPUdBpxoqBTTT
kw743J13cdC0TOzuGkP7RqErLfaVqI/P
--00000000000075fddb061efa3b9b--

