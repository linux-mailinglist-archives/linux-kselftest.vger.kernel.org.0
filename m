Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCD86A2577
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBYAZ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBYAZ1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:25:27 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04A56F03A
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 16:25:23 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-536c02eea4dso24701607b3.4
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Feb 2023 16:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G10G+2me8jWFCtUR2TsWKtrzVtOB9z/KQCFeBqx3WZs=;
        b=SmUzAwfxei85wnPtFanS/PoR05mKkU6KxsFWRKPaLmlQsWkjdiptM0qfwu7tVifIrg
         1RE/fZrs0oFl3V0yHcbwCx731CdqGB1pdu95B93CV2MxcACcsxe0dT4VzBsXY9cZn4H0
         py3FQAurdJ152X6rbhQd2TMZeOAqIItH2BeIvhrr863huWWBblVEYnu4dAf8r6JnLtKU
         pFq9672hWwg+BoS/5tjw0WQCjeXiM1QGsB+lkEd0dHOeaj2sHj4tXNyIplzFudghpnW4
         yWO3mrrBeyXNPw8uSF+sNZC0CuIPxaQ0XN0/Dj24OsjiSd8ifpsFFPg//TzCIziMnsmm
         kINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G10G+2me8jWFCtUR2TsWKtrzVtOB9z/KQCFeBqx3WZs=;
        b=VJ6ABxiLWunkb6orhs8b/ujE2KBYQ0MgNVmOBcN2B3T5fsPI/RTRQJ6xjGacSP8X0E
         8rQgomlrBOVuZ5WCFm+w8BvahSfWtH9mt0XpmFgmZTD3uocx8lZnRft8/iKoz1lFkA4n
         GcLDFyTb2ChJ3eVivhGxeQZYk7Q27D0KiqPmfLEsCcJnPCq1RSaSSeKymLikZZuO6YIo
         +V60TEBqRBsUaT1CvX5F2dTIhOepk1K7TEOloGvQxfsfaKsGi0l47CA1KjEPPjRUAgHy
         jHqnfwBUEC4KsVI5ozyvrvizCAN9D3TfNJtGfsBrcLXJzg94KLTUs3KCSMaV7DfbSA9m
         ZM5Q==
X-Gm-Message-State: AO0yUKWFtCmYNnfxiIHgkQDKHBI8C2yABKCpa6SroRdDouT3o4tp9YwC
        6UPiaqjUAjhSyhiF1zxKKjY79oZztlLssdBKlKbwtQ==
X-Google-Smtp-Source: AK7set9/s6MqiL5vrYzNlW80C1p9m82ZTZ7l6K+tReN5z/8pigW+XUSm6O293ENFGUsTUi1mssyjE4IKHzYx7ehFHuI=
X-Received: by 2002:a81:4425:0:b0:52f:69d:cc75 with SMTP id
 r37-20020a814425000000b0052f069dcc75mr5532545ywa.6.1677284722871; Fri, 24 Feb
 2023 16:25:22 -0800 (PST)
MIME-Version: 1.0
References: <02cf36b9-6526-576b-1fd3-a59b67c8c123@linuxfoundation.org> <CAHk-=wiEf7irTKwPJ0jTMOF3CS-13UXmF6Fns3wuWpOZ_wGyZQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiEf7irTKwPJ0jTMOF3CS-13UXmF6Fns3wuWpOZ_wGyZQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 25 Feb 2023 08:25:11 +0800
Message-ID: <CABVgOSnqZAuWZJpER4B_hPHorj3DZSpv+ygudC-wSVZ5-o14uQ@mail.gmail.com>
Subject: Re: [GIT PULL] KUnit next update for Linux 6.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001e161005f57b48d4"
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

--0000000000001e161005f57b48d4
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Feb 2023 at 07:23, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Feb 21, 2023 at 5:51 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >
> > This KUnit update for Linux 6.3-rc1 consists of cleanups, new features,
> > and documentation updates:
>
> Hmm. I have not actually bisected this or tried to otherwise figure
> out exactly what is wrong, but the kunit code ends up being really
> annoying for my build testing.

This will be due to 7170b7ed6acb ("kunit: Add "hooks" to call into
KUnit when it's built as a module").

The "hooks.o" file is special in that it needs to be built-in even
when the other KUnit files are built as a module, and clearly the
kbuild hackery for that has fallen apart.

>
> In particular, if I do
>
>      make
>
> repeatedly - ie with no other changes in between - the kunit code ends
> up re-building itself for no apparent reason.
>
> Which then causes a re-link and makes it all really slow.
>
> Maybe I'm barking up the wrong tree, but just do
>
>    make allmodconfig
>
> and then do two plain "make"s in succession (feel free to add "-jXYZ"
> to make it go much faster ;).
>
> The second build - that shouldn't have to re-build anything - still does this:
>
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   CHK     kernel/kheaders_data.tar.xz
>   CC      lib/kunit/hooks.o
>   AR      lib/built-in.a
>   CC      lib/kunit/hooks.o
>   AR      lib/kunit/lib.a
>   AR      built-in.a
>   AR      vmlinux.a
>   LD      vmlinux.o
>   ...
>
> and it all takes much longer than an empty kernel build _should_ take.

As best I can tell, this is kbuild getting very confused by the way
we're adding lib/kunit/hooks.o directly in lib/Makefile (rather than
going through lib/kunit/Makefile).

Moving lib/kunit/hooks.c -> lib/kunit_hooks.c and adjusting the
makefile to match _seems_ to fix it here:
---
diff --git a/lib/Makefile b/lib/Makefile
index 469be6240523..bb87df427cff 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -131,10 +131,8 @@ obj-$(CONFIG_KUNIT) += kunit/
# Include the KUnit hooks unconditionally. They'll compile to nothing if
# CONFIG_KUNIT=n, otherwise will be a small table of static data (static key,
# function pointers) which need to be built-in even when KUnit is a module.
-ifeq ($(CONFIG_KUNIT), m)
-obj-y += kunit/hooks.o
-else
-obj-$(CONFIG_KUNIT) += kunit/hooks.o
+ifdef CONFIG_KUNIT
+obj-y += kunit_hooks.o
endif
---

Splitting the KUnit code up like that is a little bit ugly, so I'm
open to any suggestions of how better to structure it.

Regardless, I'll play around a bit and see if I can come up with
anything better before sending that out.

Sorry for the inconvenience!

-- David

--0000000000001e161005f57b48d4
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCp
qKvRNH0Rzmfp2fP9sc+jV9m0OX00tN7SSCUhn2J5kTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAyMjUwMDI1MjNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAPeDStx3iAnpH5IKWR4Mc
OspuWCLheUSawkXqD06iO+1oRJDBQglNwSaiMXC9EmcdybOadEn4g83TRNSRWl4x1PTOcn/3FrVb
yac78QAE/+VTmRhjaW4CQFbu/LzZuOLmLTscbe8tUhwBUH0uRQauWWjI2QrbB/9+9WbkZDbtw4Ie
9fTpzwy0lp9MOt4wDY6TlO3+63eqJNlgxG7ct8Z7kJPg1/43pXy7Snwy6d1nVaO1DdxFI6Luvvjh
NaIrASDpa7UA8EQ8uRxB/2yCak66Oha8zmDYMhjZKl6N3H9bwSpJeS/2oiwDwoUkxyrkTSPsSFfb
A/GROgIbdvI3m2bd7w==
--0000000000001e161005f57b48d4--
