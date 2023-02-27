Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5296A4FE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Feb 2023 00:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjB0X4S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 18:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjB0X4R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 18:56:17 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B7D2A150
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Feb 2023 15:56:15 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id f13so14095070vsg.6
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Feb 2023 15:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f+O532VNa5uuYXas5j7oG3WEYjZ7tPSlzdcE1yYbUO0=;
        b=XgIzquBU0Xz35R9KT9aptB/ZybA2zIMJ8FULzhtg16cR82S26JSWjwXHlVwni5XJq7
         9iMbhX8yuF36UyJFVXD/v5UZwR604lZ89oIKHIaDU+ArmXBs3httR6FOTZT+8gbD1Vuk
         LO6mBBmr0UbmhoqJ9DLU1RzUNXP0jLJ3Ha9wUx+hk5bWlEeGuddalAdl7X3DuSrGKpKl
         zC2oJzIXaWRAPT2VHNCRmczwB/z9ZZMCmRrBPe3G9cTLBZSF5TjVgij//NvcMtW3YE9y
         ZQRhv574xnp5tkYI9TkK4evuz3ZaobW/dqHIQeFOGZFUo+X0SDU6GiC7KIXjnt/Dp17c
         WdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+O532VNa5uuYXas5j7oG3WEYjZ7tPSlzdcE1yYbUO0=;
        b=j/5sOzMwOWa074FpL7KL3EO/k0l/PRJIRfEeLzcs1b+5BnJ/WcBHlevp/MqR7DJVBz
         vHIkV8kH3TFaLm/Tu9WqWPDnrICFPJi/M+0sKPuHL7MYqvcL65YV77R9hhkZeeb9MstE
         MdwJHPvYTXwfnji8LcTXhAvmwJgQ6rbAUEpiI5BHsKh8pX/j4Omvqpmwg040wFtbFd/f
         y1numYfB3JdT+QxX1renlJ8JZGiibxurBiPaPho+4hWKJUhj42J1w5CeSKYVD46M4siq
         adOAv/52zSsYyVgG+EVvKK/GlEoy6Vt/q1Fczmrsyyg7wojzIxtrWPDi01gjuDZLVc+X
         8Xig==
X-Gm-Message-State: AO0yUKVoxlriQgMqE1/M3zZFCoJsm3FsAJPR/HHxvRMC/c62C1+QNl7R
        KCz9bKowlfj8zD5xetEybFXvlSQD4DfyrnzOD3RNfw==
X-Google-Smtp-Source: AK7set8y0Y3l6/xEaklbRICO0tAX2Cya8iDz1v1N7AO1WXjXiiKZor160np96QQ7F2hdJ29vIWCO2stZGj+UxhPQ3GY=
X-Received: by 2002:a05:6102:504:b0:414:2344:c353 with SMTP id
 l4-20020a056102050400b004142344c353mr843081vsa.5.1677542173953; Mon, 27 Feb
 2023 15:56:13 -0800 (PST)
MIME-Version: 1.0
References: <20230225014529.2259752-1-davidgow@google.com> <CAHk-=wgK07PQ_DBBbAbSJ41t__6de1xZ6q7RRu-JS=2SU0wqLQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgK07PQ_DBBbAbSJ41t__6de1xZ6q7RRu-JS=2SU0wqLQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 28 Feb 2023 07:56:02 +0800
Message-ID: <CABVgOSnkfmj5FXN5176g5J7Sjef8e+2w--3F52SWqtb34QCXEg@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix 'hooks.o' build by recursing into kunit
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000064c68d05f5b739d0"
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

--00000000000064c68d05f5b739d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Feb 2023 at 06:43, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Feb 24, 2023 at 5:45=E2=80=AFPM David Gow <davidgow@google.com> w=
rote:
> >
> > +# Some KUnit files (hooks.o) need to be built-in even when KUnit is a =
module,
> > +# so we can't just use obj-$(CONFIG_KUNIT).
> > +ifdef CONFIG_KUNIT
> > +obj-y +=3D kunit/
> >  endif
>
> We actually have a pattern for this, although I guess it's rare enough
> that "pattern" isn't necessarily the right word.
>
> But you can find things like the Hyper-V drivers having similar
> issues, and so the driver Makefile has
>
>     obj-$(subst m,y,$(CONFIG_HYPERV))       +=3D hv/
>
> See a few other cases with
>
>     git grep "subst m,y,"
>
> but I guess the "ifdef CONFIG_KUNIT" thing works too. I can only find
> one case of that (in arch/mips/Kbuild).
>
> Another way of dealing with this - that is more common for individual
> object files rather than directories - is to just do
>
>     kunit-dir-$(CONFIG_KUNIT) :=3D kunit/
>     obj-y +=3D $(kunit-dir-y) $(kunit-dir-m)
>
> which admittedly is also not a hugely common pattern, but does exist
> in various places (see for example the 'sfp-bus.o' file and CONFIG_SFP
> in drivers/net/phy/Makefile.
>
> That last pattern is probably most common in scripts/Makefile.lib,
> where we have things like
>
>        hostprogs +=3D $(hostprogs-always-y) $(hostprogs-always-m)
>
> which is similar but not the exact same thing.
>
> Anyway, I guess I'll just apply that patch as-is, I just wanted to
> point out that the particular pattern it uses may be simple, but we've
> generally tried to just do our Makefile evaluations with "arithmetic"
> rather than conditionals.
>
>               Linus

Thanks, Linus.

(And also thanks to Mikhail Gavrilov and Thorsten Leemhuis for testing
this change as well.)

It's certainly been an educational experience!

Of those other options, personally I find the "subst m,y" one most
obvious, but I'll probably leave it as the conditional for now, unless
you think trying to make it more consistent is worth the extra churn.

Regardless, I'll look into adding a note about this to
Documentation/kbuild/makefiles.rst.

Cheers,
-- David

--00000000000064c68d05f5b739d0
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
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
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCY
up7un/4fsaRdJmzjxQ9she6JNXjjCCCCchDedpOwMDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAyMjcyMzU2MTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAbLg19iNSdiIdMl3gVASW
AEvEAzMa6hFFIZM/vSdxlz0YAwB9HX20x/erS0eRbGoLHoFtT1+7YAdDnFBh97LwP3b/mZhDPys2
jigxGg2njYZunPkSdPL0E5BvXWtrpQhEwolKkGYAK2jVmDUFlJMJuByLMno6w7+veGELqb4sZs0o
nz3RdUdbh/kIKTjgdWfW67T0MWdfUGTFrCiYO6dAwG8RTAAW/DnK94dW9iro3KNg8jd80yYSfij8
Br6POUzsgpElt4rR6E5Yxv99p3BWJ91WOtJr8Iwv4QpDFBExPMqMNklpGo9dwsP6ifQBh3diaU8K
rTJlWKltwbnCtw5SAw==
--00000000000064c68d05f5b739d0--
