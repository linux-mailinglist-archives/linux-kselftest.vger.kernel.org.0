Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A206C5C1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 02:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCWBdH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 21:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjCWBdG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 21:33:06 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A5E9031
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Mar 2023 18:32:27 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id z83so23170138ybb.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Mar 2023 18:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679535082;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpkZg0p6mleP2TND1umq8qi9d/10TYnYr35CMN6Ojug=;
        b=mK9MpOQta0pZF7KHPOesied/UCeDCeS3e3R/GAOLCjU8mFsjiYV1MR/XoYr3SxhcpF
         FVv3QQzVH89zGPPoEr8aQ4Uu2e6qvDrxWcbwIbnTslMqIxhT/26s+x7oiSP5MC+VcCwK
         yMnfjfuuwAqf9nndmP4EDDipZQiT+uOU1UfRFiBim+4tjcBM9VLKy5Lix0Ft4Q6xoi0N
         JHQ3ygw3aqQAwsTPI5k9Ph8oJ6Vup9TtsEWxFZ17m6Xpee3V7112QdmczB7RjLdb2w2/
         0DouT3EGgDI/ahG6OaV+e/IvOcO7tiIO5pNY9gWXIlvLtuUNLiSQK6G2c+7ClfE9Vldd
         EHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679535082;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpkZg0p6mleP2TND1umq8qi9d/10TYnYr35CMN6Ojug=;
        b=t+2uvUm6Jhc383fJnqfhPq226g1jMMeAIbj1fv2XwJQ4vQufkP5Yn7zZKzuYcG0oiH
         cLuo9H6N/t6KMc4vWUIUq5/K54gui3EgnPd5KZ/5BthR9rEaSN+dVvdZcHqpeQgOdpdz
         Gh8J9fg4QttIQB5VvonrnhPDFlduhyOPhqqrrrlTKP5fEjxMnY570VxPb7pg0TFwNNzB
         mY3yq5NtO4aMqSCCVJOquoevRgB6iRoXI50+sl0YtdT4gVJI5VpTw1cmd8D4giZoBqDI
         3njE0U6QiPynx/LRkI2yMB+KMfQdPJlpN29OXbnvCmwHjROvzyUKmWcR3Nq5yhfVDnc0
         vJkw==
X-Gm-Message-State: AAQBX9cjdKahAZm4nnck3Uj435DifFHTWHhs+nrlZJkxlI393MvJW1z+
        XCltF2cg0Z0TF20kN4DmEB9MnRDNyAMJzPOajUdMIA==
X-Google-Smtp-Source: AKy350b4+C0DI+K6U36PFUPU14kQshnkZVKcGFL2ES932Z8hOuHAxa4BiF0jE0iKKgbbL7/bCWhhBStSB8MZVsctHhM=
X-Received: by 2002:a05:6902:1141:b0:b74:aac4:7800 with SMTP id
 p1-20020a056902114100b00b74aac47800mr868304ybu.6.1679535082410; Wed, 22 Mar
 2023 18:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <ZBumkUcw8cQfjvO7@sirena.org.uk>
In-Reply-To: <ZBumkUcw8cQfjvO7@sirena.org.uk>
From:   David Gow <davidgow@google.com>
Date:   Thu, 23 Mar 2023 09:31:10 +0800
Message-ID: <CABVgOSk-3vSPsWDDzVO4GnzN8FAbBpx_jfKgTc9B=o7FODBhiA@mail.gmail.com>
Subject: Re: Running KUnit using the wrapper script
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ff42de05f7873b42"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000ff42de05f7873b42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Mar 2023 at 09:08, Mark Brown <broonie@kernel.org> wrote:
>
> I've been trying to do some stuff with KUnit but I can't seem to
> find a current tree where KUnit builds.  Running on Debian stable
> starting from a clean -next tree and running:
>
>    ./tools/testing/kunit/kunit.py config
>    ./tools/testing/kunit/kunit.py build
>
> based on Documentation/dev-tools/kunit/start.rst.  However I get:
>
> [00:42:59] Configuring KUnit Kernel ...
> [00:42:59] Building KUnit Kernel ...
> Populating config with:
> $ make ARCH=3Dum O=3D.kunit olddefconfig
> Building with:
> $ make ARCH=3Dum O=3D.kunit --jobs=3D8
> ERROR:root:In file included from /usr/include/stdlib.h:1013,
>                  from ../arch/x86/um/os-Linux/registers.c:8:
> /usr/include/x86_64-linux-gnu/bits/stdlib-float.h: In function =E2=80=98a=
tof=E2=80=99:
> /usr/include/x86_64-linux-gnu/bits/stdlib-float.h:26:1: error: SSE regist=
er return with SSE disabled
>    26 | {
>       | ^
> make[4]: *** [../scripts/Makefile.build:252: arch/x86/um/os-Linux/registe=
rs.o] Error 1
> make[3]: *** [../scripts/Makefile.build:494: arch/x86/um/os-Linux] Error =
2
> make[3]: *** Waiting for unfinished jobs....
> In file included from /usr/include/stdlib.h:1013,
>                  from ../arch/um/drivers/fd.c:7:
> /usr/include/x86_64-linux-gnu/bits/stdlib-float.h: In function =E2=80=98a=
tof=E2=80=99:
> /usr/include/x86_64-linux-gnu/bits/stdlib-float.h:26:1: error: SSE regist=
er return with SSE disabled
>    26 | {
>       | ^
> make[3]: *** [../scripts/Makefile.build:252: arch/um/drivers/fd.o] Error =
1
> make[3]: *** Waiting for unfinished jobs....
> In file included from /usr/include/stdlib.h:1013,
>                  from ../arch/um/os-Linux/skas/process.c:7:
> /usr/include/x86_64-linux-gnu/bits/stdlib-float.h: In function =E2=80=98a=
tof=E2=80=99:
> /usr/include/x86_64-linux-gnu/bits/stdlib-float.h:26:1: error: SSE regist=
er return with SSE disabled
>    26 | {
>       | ^
> make[4]: *** [../scripts/Makefile.build:252: arch/um/os-Linux/skas/proces=
s.o] Error 1
> make[3]: *** [../scripts/Makefile.build:494: arch/um/os-Linux/skas] Error=
 2
> make[2]: *** [../scripts/Makefile.build:494: arch/um/os-Linux] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[2]: *** [../scripts/Makefile.build:494: arch/x86/um] Error 2
> make[2]: *** [../scripts/Makefile.build:494: arch/um/drivers] Error 2
> In file included from /usr/include/stdlib.h:1013,
>                  from arch/um/kernel/config.c:7:
> /usr/include/x86_64-linux-gnu/bits/stdlib-float.h: In function =E2=80=98a=
tof=E2=80=99:
> /usr/include/x86_64-linux-gnu/bits/stdlib-float.h:26:1: error: SSE regist=
er return with SSE disabled
>    26 | {
>       | ^
> make[3]: *** [../scripts/Makefile.build:252: arch/um/kernel/config.o] Err=
or 1
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [../scripts/Makefile.build:494: arch/um/kernel] Error 2
> make[1]: *** [/home/broonie/git/bisect/Makefile:2028: .] Error 2
> make: *** [Makefile:226: __sub-make] Error 2
>
> [00:43:20] Elapsed time: 20.233s

Hi Mark,

This one is my fault, I'm afraid. We're triggering a bug in older gcc
versions (<11) at the moment.

Patch to work around it is here, or it should be fine with gcc >=3D 11 or c=
lang:
https://lore.kernel.org/linux-um/20230318041555.4192172-1-davidgow@google.c=
om/

(The gcc bug is described here:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D99652 )

>
> which isn't ideal.  v6.2 is also broken, albeit differently:
>
> ERROR:root:`.exit.text' referenced in section `.uml.exitcall.exit' of arc=
h/um/drivers/virtio_uml.o: defined in discarded section `.exit.text' of arc=
h/um/drivers/virtio_uml.o
> collect2: error: ld returned 1 exit status
> make[2]: *** [../scripts/Makefile.vmlinux:35: vmlinux] Error 1
> make[1]: *** [/home/broonie/git/linux/Makefile:1264: vmlinux] Error 2
> make: *** [Makefile:242: __sub-make] Error 2
>

Hmm... I haven't seen this one here: v6.2 builds and runs fine with
gcc 10, 11, and clang 14.

Looks like maybe it's an issue with older binutils. Maybe this patch
will fix it:
https://lore.kernel.org/all/20230207164156.537378-1-masahiroy@kernel.org/

> which makes bisecting a bit of an issue.  The kunit-fixes, kunit
> and kunit-next trees in -next have the former error.  Can anyone
> point me at a tree/config/commands that's suitable for working on
> KUnit at the minute?

The most convenient workarounds (other than having newer gcc /
binutils) are probably to either run against a different architecture
(e.g. --arch x86_64) or to build with clang (--make_options LLVM=3D1).
Those should be a bit more stable for bisections than UML on the older
gcc versions.

Sorry for the mess!
-- David

--000000000000ff42de05f7873b42
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCH
zFrQWqYIdRo6JJ2U2r737mnys2pxwgK+W+Cj6GDjZjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMjMwMTMxMjJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEANzqsGso8+ejQaNcO1evi
UZPQ+bjy+bjk6v/xJvvyICZzUXZvYs7ZkTF6XOz/pJ6yVY7H36kZOWsZYVRPQpjdX9NOPn0Y/w7C
8zpTcbKOynGVyrVPqEXyMQtlJpsAr7rImcY7voizGjELUoy2Ys02IgggkUlG8elYYbqVFwg18mG0
k1o13enVKxQJBz3MHLznNhionCQLI972zUaO0S9IOVlCUBPspBoBAdTz4DektmVsLnC9PqLuDEbN
Vt58hvOmp6aN6thpy9zS6plz7hSH5I6siE0EOxMVfPDMw4RysC7GsAgWixLbrmNx6vSLS7lW/juT
doCv1o+T73+awp5ZGQ==
--000000000000ff42de05f7873b42--
