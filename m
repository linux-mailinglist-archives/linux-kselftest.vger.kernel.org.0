Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7823D645256
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 03:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiLGCy6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 21:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGCy5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 21:54:57 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106B62EF5F
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Dec 2022 18:54:56 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id r3so3059806vkq.13
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Dec 2022 18:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b92AUF3otjJG6J5DiAW9+h+pJPd9M9NUjS1ArBc8kpA=;
        b=MvSzsyiKHgqaT9tR8J/hC53qV/XnyeZ1lFj7qkiktcuXV4zPbnukLTu5ceBoIhoBUN
         gEs3nrFeym5W1jcvdKSdINZnKUOrFj/6owPn/Vd08F7mvx9Whsamr8fHdLQ63arGOdUk
         XCu4ik3ALKweZtnXui9uFIaFWCDjVxc8ph9eDwy1b928IObi2grIgjfjug2Bd/CMjKdw
         bG88OTtSL+oKzNHgq0YUBIGdeZzhlnwpFBZmppuRwwu1zG58eu2RUMJDkAwxBF84jPln
         CXtVhpHKiDc156x8ZrOhe9edSYBNpWVKj9YBnkYvy1u3AQaeS12X20/7oxxiUVQ2wgDz
         MoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b92AUF3otjJG6J5DiAW9+h+pJPd9M9NUjS1ArBc8kpA=;
        b=LY1Jlf/CdDz6v4bHoPNUB41b4Ho4tQWuClvltgrM7iAQAW9fImHLHSt63X6+sF+X7s
         70Mb/L8Mg9tqzcRlwMdu1/EdxBDD1IfcHEbggR7OupVfpgY1/yTPOE9ESxh90rZ4aSu8
         OUbzYPdRZljhJUXtDo/8DQ1jHgHxz5PPnh0r7PPvNkz8aXxXzsbJ3PgsOjurvOJmOmqi
         NcGX+OSNXm/3E3SEqTRFSZn5lB5PyzxGBBVg7dvRqg54metkKbud47pHoMcU3+tie4o4
         +BYCtxlHTR3HZ5M3rUC0fmi09CFTvxIXNdC8l31sBssyH4bToxhqHgGRFuNk0rYKhmWU
         21tA==
X-Gm-Message-State: ANoB5pnjt52Xnvr7177WDNayoFa9irjYpxPLctgOxAt0+7w+pDB/DP6J
        PCW+R4jmmbp1SAwsTVnGI+akwCyCAnCmtMuSeFL0eg==
X-Google-Smtp-Source: AA0mqf68ajJtQPax1pmUrvSoqG7xsxXARst3K27OmqRvea+nD9SM8zQs/GMOod1N7OrCQNW/HVkyrkQ8qCAD6zq/WIk=
X-Received: by 2002:a1f:5cc5:0:b0:3bd:1d27:eaa with SMTP id
 q188-20020a1f5cc5000000b003bd1d270eaamr15466699vkb.4.1670381695006; Tue, 06
 Dec 2022 18:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20221207014024.340230-1-rmoar@google.com> <3bc67108-9f4a-4cd7-619d-d61816625e1a@canonical.com>
In-Reply-To: <3bc67108-9f4a-4cd7-619d-d61816625e1a@canonical.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 7 Dec 2022 10:54:43 +0800
Message-ID: <CABVgOS==niZi5O4Gk8uxHdnmX4YFs2e6XYG=B+SQ6Po6v6bHkg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] kunit: add macro to allow conditionally exposing
 static symbols to tests
To:     John Johansen <john.johansen@canonical.com>
Cc:     Rae Moar <rmoar@google.com>, brendanhiggins@google.com,
        dlatypov@google.com, skhan@linuxfoundation.org,
        tales.aparecida@gmail.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        apparmor@lists.ubuntu.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000097d84805ef340bbf"
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

--00000000000097d84805ef340bbf
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 7, 2022 at 10:43 AM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 12/6/22 17:40, Rae Moar wrote:
> > Currently in order to test a static function, tests must be included in the
> > same translation unit as the function. However, this can cause issues with
> > including implementation and test code in the same file. As an alternative,
> > the first patch in this series creates a macro that will set a function to
> > be static or not depending on whether CONFIG_KUNIT is enabled. This allows
> > the function to be visible during testing and static otherwise.
> >
> > As an example, the current status quo to test static functions is:
> >
> > === test.c ===
> >
> > static void test_case(struct kunit *test)
> > {
> >    KUNIT_EXPECT_EQ(test, my_func_to_test(), 2);
> > }
> >
> > Then the tests are included in the implementation file as a workaround to
> > the issue of testing static functions:
> >
> > === implementation.c ===
> >
> > static int my_func_to_test() {...}
> > ...
> > #include "test.c"
> >
> > Instead, the function could be defined with this new macro:
> >
> > === implementation.c ===
> >
> > VISIBLE_IF_KUNIT int my_func_to_test() {...}
> >
> > The first patch also creates a macro that will export a symbol into a kunit
> > testing namespace only if CONFIG_KUNIT is enabled. This follows the logic
> > above and allows symbols to be conditionally exported based on the testing
> > status.
> >
> > The second patch in the series updates the policy_unpack test in AppArmor
> > to show an example of how to use both of these macros in order to address
> > the issue of testing static functions. Additionally, the patch allows the
> > policy_unpack test to be built as a module.
> >
> > Changes since v2:
> >   - Add mention of namespacing symbols to the commit message of the
> >     second patch.
> >   - Change module name in the second patch from policy_unpack_test to
> >     apparmor_policy_unpack_test.
> >
> > Changes since v1:
> >   - Changed the namespace of exported symbols for the apparmor
> >     policy_unpack_test by adding the aa_ prefix.
> >   - Separated the documentation comments for macros in
> >     include/kunit/visibility.h.
> >   - Changed copyright date and author for include/kunit/visibility.h.
> >
> > Rae Moar (2):
> >    kunit: add macro to allow conditionally exposing static symbols to
> >      tests
> >    apparmor: test: make static symbols visible during kunit testing
> >
> >   include/kunit/visibility.h                |  33 +++
> >   security/apparmor/Kconfig                 |   4 +-
> >   security/apparmor/Makefile                |   3 +
> >   security/apparmor/include/policy_unpack.h |  50 +++++
> >   security/apparmor/policy_unpack.c         | 238 ++++++++++------------
> >   security/apparmor/policy_unpack_test.c    |  69 ++++---
> >   6 files changed, 229 insertions(+), 168 deletions(-)
> >   create mode 100644 include/kunit/visibility.h
> >
> >
> > base-commit: 0f08f3e2a0186dfb8e33cb46105228eb18448a0e
>
> thanks Rae,
>
> looks good to me, David unless you tell me otherwise I assume this is
> still going in via the kselftest/kunit tree.
>

Yup, both of these are looking good to me (and work fine on my machine).

I've added these to the queue for the kselftest/kunit tree. There's a
chance they won't make it into 6.2, but if not, they should be the
first things in the 6.3 branch.

Thanks very much,
-- David

--00000000000097d84805ef340bbf
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
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAGPil6q1qRMI4xctnaY
SpEwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMjEwMjMw
ODQ3MTFaFw0yMzA0MjEwODQ3MTFaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDOy5O2GPVtBg1bBqW4oCdA74F9u0dQ
yp4AdicypXD/HnquyuG5F25nYDqJtIueywO1V0kAbUCUNJS002MWjXx329Y1bv0p5GeXQ1isO49U
E86YZb+H0Gjz/kU2EUNllD7499UnJUx/36cMNRZ1BytreL0lLR0XNMJnPNzB6nCnWUf2X3sEZKOD
w+7PhYB7CjsyK8n3MrKkMG3uVxoatKMvdsX3DbllFE/ixNbGLfWTTCaPZYOblLYq7hNuvbb3yGSx
UWkinNXOLCsVGVLeGsQyMCfs8m4u3MBGfRHWc2svYunGHGheG8ErIVL2jl2Ly1nIJpPzZPui17Kd
4TY9v0THAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFCNkhjo/
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB9
hCAHtDp2SmCIg48x7Xwsagl5HzrO2Rxx6kO5ZyytNDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEyMDcwMjU0NTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAZ3oK6ZaJ3jPkpkpKdzZD
STwCXyqAB7keaXBPcmIzMLUK6sZ2g0dQ0Dhew1xxjLpcZS+HOuGUIfVyX/KSxfX6pruiZx3rDDio
GZLFpqgHTvXWLBIYDtd5ZPJ1vQguWoK4eYTpruQtJkfiXxYmkwQrgTY6hzRyAoGO4FlEBfO5G6El
DB6qZXRG6+ZbNHTtJ3AAc6pzE+Ogs0VxMgi+5C+Ors1Vxs/E9I9/Rl6zBO8TA9MOAQlTkwO3tgjI
bLoKdxRHuCgWnTGdfrwas5geGDGLTNeCVhhyLm0+pjl2Jo7ihaTZd5nfpOCCIWxo/+jiFzBttd31
hznKlhazXHtM3F1KCA==
--00000000000097d84805ef340bbf--
