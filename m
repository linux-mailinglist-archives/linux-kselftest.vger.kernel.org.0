Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6119968204D
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 01:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjAaABv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 19:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjAaABf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 19:01:35 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BA430EAD
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 16:00:57 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id s24so7019267vsi.12
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 16:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+B63s09bxtXTGxYb+zooef0veztANKzjAcoxIgF0uuE=;
        b=OV+iNvcJBqDA0KISIrF6Cpmdq6KH8rCU0vceo3oFTjkElu4txu2sIasu4ugJLj2DAt
         t8Qxn4lSlQJbS3DkDKnT2txb7GexfaXiaPbffEm6eESMlDoXKdU7sAa5C50TlSx9GVhH
         MpV8+asic4BO5hL0NWU71a/g3KZJc7tTKX3Z9zAVmKLV3faZQUHND/FS4Ik4pjSrg9KJ
         LgBiUjYSZMrc0OWleiCBz8yR7bVAHdnpV97jChmQEnSqt75A/X2tIniDezxVJDl6wYZ4
         FKQauizoRkZZOkfHEEw19QGkK4hbT42scK/jNgcm7WrEJhVJLSu0DWNboHP9DMdxNZSw
         KuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+B63s09bxtXTGxYb+zooef0veztANKzjAcoxIgF0uuE=;
        b=IDCw6v1w0tonGr0/WtYkTQomG0Yn+CxYSNgAD85xHsiZ9DqFAp0ZbsFkIgtZWAC9lw
         DdYcn0dERN6MHp+K9eiD4Lr1olP9ZJLZXJ13mJRzDHVjYUFJlFsUAN6WPyzNBVwJb8PX
         JxMbDANmKMw3sHBbIBAQaJkg46oKFbDNVPJX/GNB7Hgx0qQKLwIJZeXxDHCP7fYWiW0t
         uPCwuP6Pkkk0CgQslgNzsfMiXGqSmtSipAqolsDi+AaWGjTIJBx+k5u+3zxmk/J4W9kD
         dKzdlBV7hpSA4zPKVFnJk8GIbmlcb0IRaQjPB0iWrvU1LgJ4+vLwhYf+peElXmtfFmvv
         Q+wQ==
X-Gm-Message-State: AFqh2kouoqKU5X4fK9Mnbfa23KR4+W87+00M6baTAMLIrcZSnSL3RMTV
        Igki6VaiKs0zodoweLfCEfrP5T1oofPUNMIjv+U3cg==
X-Google-Smtp-Source: AMrXdXsFGVqmumebPGCY4ZqTyKyRgWRBWTO1KtujgUYv2UWe47vPVYCuG+BGFFwvCHicDzVCLzeSRsGrvUXi/5j0Jj0=
X-Received: by 2002:a67:1544:0:b0:3d2:3594:dba8 with SMTP id
 65-20020a671544000000b003d23594dba8mr7686576vsv.18.1675123255423; Mon, 30 Jan
 2023 16:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20230127145708.12915-1-andriy.shevchenko@linux.intel.com>
 <CABVgOSmZsAQcf6Ou_tyZL=hpiJcxMxXzmMfV5wRyCPBsb_d0UQ@mail.gmail.com> <CAK7LNASsnDymUS=Pyo77g=0v58fMn38PY66A887nC8_E6_qXAg@mail.gmail.com>
In-Reply-To: <CAK7LNASsnDymUS=Pyo77g=0v58fMn38PY66A887nC8_E6_qXAg@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 31 Jan 2023 08:00:40 +0800
Message-ID: <CABVgOSnRC3AuUo4Qc2K3pXEcj3Wbt9LE2DTbejGrPOCKefxB2g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] .gitignore: Unignore .kunitconfig
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009cffef05f38406d7"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000009cffef05f38406d7
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Jan 2023 at 22:37, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Jan 28, 2023 at 3:56 PM David Gow <davidgow@google.com> wrote:
> >
> > On Fri, 27 Jan 2023 at 22:56, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > There are almost dozen of .kunitconfig files that are ignored but
> > > tracked. Unignore them.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> >
> > Thanks! Only the original root-directory .kunitignore file was
> > intended to be ignored, and that's no longer as important, and is now
> > in the build dir anyway.
> >
> > Reviewed-by: David Gow <davidgow@google.com>
> >
> > Cheers,
> > -- David
> >
> > >  .gitignore | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/.gitignore b/.gitignore
> > > index 22984d22d29e..e4f2ba0be516 100644
> > > --- a/.gitignore
> > > +++ b/.gitignore
> > > @@ -100,6 +100,7 @@ modules.order
> > >  !.get_maintainer.ignore
> > >  !.gitattributes
> > >  !.gitignore
> > > +!.kunitconfig
> > >  !.mailmap
> > >  !.rustfmt.toml
> > >
> > > --
> > > 2.39.0
> > >
>
>
> Why is this a dot file in the first place?
>

In short, historical reasons.

The long answer is that there are two places "kunitconfig" files are
used: as a user-provided file with their preferred test config (which
is kept local), and as a recommended test config for a given subsystem
(which is checked in).
Originally, no .kunitconfig files were checked in: one was either
autogenerated or manually modified and left in the root source
directory. This eventually moved into the build directory, and a
number of features which de-emphasized it in favour of command-line
arguments and the (new) checked-in per-subsystem configs, which
probably shouldn't be hidden.

There's no fundamental reason (other than it being a bit annoying to
rename everything and update the code) we can't change it, either for
all kunitconfig files, or just the checked-in ones, if that's
preferred.

-- David

--0000000000009cffef05f38406d7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAHHLXCbS0CYcocWQtL1
FY8wDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMzAxMjkw
NjQ2MThaFw0yMzA3MjgwNjQ2MThaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+31G8qfgjYj6KzASqulKfP5LGLw1o
hZ6j8Uv9o+fA+zL+2wOPYHLNIb6jyAS16+FwevgTr7d9QynTPBiCGE9Wb/i2ob9aBcupQVtBjlJZ
I6qUXdVBlo5zsORdNV7/XEqlpu+X5MK5gNHlWhe8gNpAhADSib2H4rjBvFF2yi9BHBAYZU95f0IN
cSS0WDNSSCktPaXtAGsI3tslroyjFYUluwGklmQms/tV8f/52zc7A5lzX+hxnnJdsRgirJRI9Sb6
Uypzk06KLxOO2Pg9SFn6MwbAO6LuInpokhxcULUz3g/CMQBmEMSEzPPnfDIAqwDI0Kqh0NAin+V4
fQxJfDCZAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFJyglaiY
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCc
w4j0mYs6jb3zVte3/9Jgrq6hG2dT+iHYk1+65ufePzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMzEwMDAwNTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAHK1RX1ZScr4UtaKzmJv2
JMZi28uUh5/HrZamcb7sLMn4jQj2+zT50NNWFTY2h1AbhZsKL+ICW0Gc6DXbwPwfC07O7JJY0zFu
UulMtb1gcPuesRDQNNeV1ecndofXSFNm8tucWdlADXHO4f5qMkdiAYTNj73LvtQcrhaICYK9BEAI
o/9Ay1SgUpThDacj4gJTC8nHgE4e1bVFMe66zZ++1AmI8bK1DNSzKJWnI9vsmtN9x1bIRJZDG4Fe
iQ221ulbJM5GTPR7i+HHdGnfYXwnm3z4nvC6OGpGB4Wnii6Jv9TSJradqGnRZL2vkBoV0jqfp2Xb
qvA7pQZI2pqVAC69Ig==
--0000000000009cffef05f38406d7--
