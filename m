Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFE16A26A5
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 02:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBYBuz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 20:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYBuz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 20:50:55 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193A967E2A
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 17:50:54 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-536b7ffdd34so27848347b3.6
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 17:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8q1ASQVZhva3yO0JDIyC0VQGCS21JYsR8XRnjwCdaNE=;
        b=lx/2ypKCbml+jC/nQ7J3scM039SMqC77KaGv8L/KdVhSAIus0BmbecfeqlIdONzbj6
         E5eRML6BpYI4he/ejC4QWMkbyQZh/TGpoQnqZMKdfRepMuJrV8CGzUfu7j/c6kw5cwcx
         ra0X+bhHLYzUFpLxXw37x4NqvOGj0w8z1CPkeQlOLaIyYnNxjZ6VVksDEdnB00wFgnMv
         WtIhUqIuZXFGUrGR2KCRDtJf5M6B02oXsVdNNV9XZsPxeQ2tfIijxhMzYNeDuBRSxn60
         35WE8EXa8A7ybbRPuVEXg9VSMZTjMoGxg0nxx4fGv/+IznXImRHflJRGZYnahlC+soJh
         +XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8q1ASQVZhva3yO0JDIyC0VQGCS21JYsR8XRnjwCdaNE=;
        b=2vVIaJtiSrHxjZMtXl0/MxIlC5WIR5jsL3qAnJOUQ3wZmqty7ZHIcYZIRlUPd0g4HJ
         MusWhXvzn0Uk2mgmP7YsIZoOdZd/bfJoS3+0cLxjT6jNB4IBu2eOmWo85i2YkqjtPWlV
         X9hJE3T2uKeNEpLn+VxgGRCBxJ2oN0DFeNHFyS5YJqKyjtH1nbyJ+wIkCTXNYUq4WD3A
         8Oiq6j52M+sT3aiRx9o/ndzG89i3wyDofketTPNnYQfsgdAgxCEIG7dEqL4n/GxzZ7eF
         do1A9j5iPYWBEvD5AoHYtmVavA3TQB3983fWrgj2JkN5QO5BzwhIq+yLZ3ySHzk/QnSS
         lyxA==
X-Gm-Message-State: AO0yUKW7oXxq6SdaLgT05/YiQokgpaIRZeQuGgoGoe3s+Fd36dvs6etw
        oZmPrcE0vZB1VEC3GCDaRbOwTOJ8Pmfx+vVtFPpDQn5Pyff6Yx9QkvktyA==
X-Google-Smtp-Source: AK7set8G9HDu7ztJyA023ROzcdsWIlydrFzmDlrgKSTIRP8aOwLIvIz8yc9ksf6dEYCpW0llptYKtZdE/hrNR9xPDRE=
X-Received: by 2002:a81:ac58:0:b0:535:5e8c:65ef with SMTP id
 z24-20020a81ac58000000b005355e8c65efmr5617918ywj.6.1677289853117; Fri, 24 Feb
 2023 17:50:53 -0800 (PST)
MIME-Version: 1.0
References: <02cf36b9-6526-576b-1fd3-a59b67c8c123@linuxfoundation.org>
 <CAHk-=wiEf7irTKwPJ0jTMOF3CS-13UXmF6Fns3wuWpOZ_wGyZQ@mail.gmail.com> <CABVgOSnqZAuWZJpER4B_hPHorj3DZSpv+ygudC-wSVZ5-o14uQ@mail.gmail.com>
In-Reply-To: <CABVgOSnqZAuWZJpER4B_hPHorj3DZSpv+ygudC-wSVZ5-o14uQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 25 Feb 2023 09:50:40 +0800
Message-ID: <CABVgOSn4p75DkjQLbGpPeVO=Yx-v-fhHAKuMfo7B96-QCp5szg@mail.gmail.com>
Subject: Re: [GIT PULL] KUnit next update for Linux 6.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e80eaa05f57c79e3"
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

--000000000000e80eaa05f57c79e3
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Feb 2023 at 08:25, David Gow <davidgow@google.com> wrote:
>
> On Sat, 25 Feb 2023 at 07:23, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, Feb 21, 2023 at 5:51 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> > >
> > > This KUnit update for Linux 6.3-rc1 consists of cleanups, new features,
> > > and documentation updates:
> >
> > Hmm. I have not actually bisected this or tried to otherwise figure
> > out exactly what is wrong, but the kunit code ends up being really
> > annoying for my build testing.
>
> This will be due to 7170b7ed6acb ("kunit: Add "hooks" to call into
> KUnit when it's built as a module").
>
> The "hooks.o" file is special in that it needs to be built-in even
> when the other KUnit files are built as a module, and clearly the
> kbuild hackery for that has fallen apart.
>
> >
> > In particular, if I do
> >
> >      make
> >
> > repeatedly - ie with no other changes in between - the kunit code ends
> > up re-building itself for no apparent reason.
> >
> > Which then causes a re-link and makes it all really slow.
> >
> > Maybe I'm barking up the wrong tree, but just do
> >
> >    make allmodconfig
> >
> > and then do two plain "make"s in succession (feel free to add "-jXYZ"
> > to make it go much faster ;).
> >
> > The second build - that shouldn't have to re-build anything - still does this:
> >
> >   CALL    scripts/checksyscalls.sh
> >   DESCEND objtool
> >   CHK     kernel/kheaders_data.tar.xz
> >   CC      lib/kunit/hooks.o
> >   AR      lib/built-in.a
> >   CC      lib/kunit/hooks.o
> >   AR      lib/kunit/lib.a
> >   AR      built-in.a
> >   AR      vmlinux.a
> >   LD      vmlinux.o
> >   ...
> >
> > and it all takes much longer than an empty kernel build _should_ take.
>
> As best I can tell, this is kbuild getting very confused by the way
> we're adding lib/kunit/hooks.o directly in lib/Makefile (rather than
> going through lib/kunit/Makefile).
>
> Moving lib/kunit/hooks.c -> lib/kunit_hooks.c and adjusting the
> makefile to match _seems_ to fix it here:
> ---
> diff --git a/lib/Makefile b/lib/Makefile
> index 469be6240523..bb87df427cff 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -131,10 +131,8 @@ obj-$(CONFIG_KUNIT) += kunit/
> # Include the KUnit hooks unconditionally. They'll compile to nothing if
> # CONFIG_KUNIT=n, otherwise will be a small table of static data (static key,
> # function pointers) which need to be built-in even when KUnit is a module.
> -ifeq ($(CONFIG_KUNIT), m)
> -obj-y += kunit/hooks.o
> -else
> -obj-$(CONFIG_KUNIT) += kunit/hooks.o
> +ifdef CONFIG_KUNIT
> +obj-y += kunit_hooks.o
> endif
> ---
>
> Splitting the KUnit code up like that is a little bit ugly, so I'm
> open to any suggestions of how better to structure it.
>
> Regardless, I'll play around a bit and see if I can come up with
> anything better before sending that out.

I managed to get it working by always recursing into the kunit/
directory with obj-y, which is cleaner.
So this patch should fix it:
https://lore.kernel.org/linux-kselftest/20230225014529.2259752-1-davidgow@google.com/T/#u

Sorry again,
-- David

--000000000000e80eaa05f57c79e3
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCC
Fd2/jxxOSioI3PFGNUG3u0TgQfXwW090iP17wy4hGzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAyMjUwMTUwNTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAEC5DeBc4kHhnoaPvkduz
0Jpl3rVEd0KV/ELaTMpdsiKUsAOmDGZxmu3mGNHzgyy7FvTHTAEM60zlysi/F8JWcmu5L9JNo4cz
i529GOGP/WsYs2L2bI7CtkxktIS2eSphlWALUpA/sx+9Qqw5ffdJqIqKpPw8SzivTdGEAzKuV2M1
12PD6hR60uNtYKQOcSpG3nqeGF+7xArYZBxMw0afJ27X58wI3idqJZJMr+vDgWaliK6nb/uOTEN0
ulmlrebFepgjQbrD/DbmHf1jBUNiUlO8cAFQtlENApW61AVsCa03FoADTbyWxXWj9qcb9B2WekFT
wyLxP/4hLt1GHlRc4w==
--000000000000e80eaa05f57c79e3--
