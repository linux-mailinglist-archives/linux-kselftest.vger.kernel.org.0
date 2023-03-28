Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D296CC051
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 15:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjC1NNI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjC1NNB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 09:13:01 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F5761BF
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 06:12:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p34so6916422wms.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 06:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680009178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i7SMYW2LWI7a+0QleYFEjJeTalB4jNEAdVZ0KOAcX+M=;
        b=EKqkSVn6WmNT7XBGhZpKUZuuZbYag74KErzcxtkbUxdASqV1XTPFuSGkc3ykGbb1XL
         +hmEsQseUBoOIJXgrqWFLTSJ+OJ9uhEC+iP5UDSJJMBpvukwj/KwC/XUf8Mlwp8ynS5y
         2D1xrw9VACfZrypqHqxb4zonfP+qTjycEu9aX2dFbekOB6Av62t3Bbc+Z6eHg6f1kBrY
         yNLM/jRXcX1KpAqJJhCE9V8dVok3N3ejKn8bOPIwOLDEQLxlbUQDVCh7u1AOa4C95DFP
         SHOtlaVr/jekaaN/jz2OMsz/14bQWP5BWTfFVf+7VHAqi2XFFcg2IT8PNUNsPo3wueSH
         FLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7SMYW2LWI7a+0QleYFEjJeTalB4jNEAdVZ0KOAcX+M=;
        b=TdKdZ+NqibtLh0z89YeSlguGoM9fiMaMAlqHEdu0qEahnJlCrYgk0xTUM5PHuVIbFu
         +HQMsDadCbEdzYViXHFUVQi3caQgVedCLNtDYK8+oYsylnUnsoM/c+jJFWqHq551jUqp
         tYdzCIUlBO7GM/zIYK5S3pcNZqsdszScYam7AG/VybtKCvAwqQP7dlxG56czxXoXSFnb
         2/nEcnakzlGS5ymtmXo4e62AfpzRaoroPxBWSiYa/8Mo1cIP0dMouCI9eMUtjazTCK2b
         DrwZbh9h3EyqDqXl4IlA+xndzbXBZgSC7v0nhVWClyjZ8A8ulmFn0e6zu974R6iQ5c1I
         K3DA==
X-Gm-Message-State: AAQBX9cfOYeM//Ks0vLm/QQFGbw4i9FkSYVRHgVwxmhR7jsypd9pFbNk
        Q5k1rAwORRb7Er6WNJAAIoOofFFfN3ctW/WrQU97Bw==
X-Google-Smtp-Source: AKy350YUuLb9PZGVexyQAx7y5EiY8X4a5H2r1Fc4CcZBqJyi4nkelaQAfQKEpVUHWUexOLvsv9Ta5X3FLbLw13Fzkf8=
X-Received: by 2002:a05:600c:2296:b0:3ef:5da6:45e2 with SMTP id
 22-20020a05600c229600b003ef5da645e2mr2743005wmf.3.1680009178071; Tue, 28 Mar
 2023 06:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <0bfe4ca4863c22208d09d9b437cc563ed50877a1.camel@sipsolutions.net>
 <CABVgOSmtyYDTNO+fREYpsO+BLeGYmajVPjrqqrxq+88HfPFsjQ@mail.gmail.com> <3bca9d93e10d5fab7e6f1a3f0b9aa36dd941a915.camel@sipsolutions.net>
In-Reply-To: <3bca9d93e10d5fab7e6f1a3f0b9aa36dd941a915.camel@sipsolutions.net>
From:   David Gow <davidgow@google.com>
Date:   Tue, 28 Mar 2023 21:12:45 +0800
Message-ID: <CABVgOSmWTOAyrcS4VpSq5tXBg4_FTRH2Z2iAyKnkGwHJvAnMcg@mail.gmail.com>
Subject: Re: new kunit infrastructure
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org,
        Benjamin Berg <benjamin@sipsolutions.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004dac3005f7f59e6d"
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

--0000000000004dac3005f7f59e6d
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Mar 2023 at 20:54, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Hi David,
>
> Thanks for the quick reply!
>
> > "established process" is probably overselling it, but we're more than
> > happy to accept improvements and additions to KUnit.
>
> Yeah I guess I was expecting that. Was more wondering if you had
> anything in mind other than sending it to kunit-dev/linux-kselftest
> lists. I'll assume no for now :-)

Those lists (plus the lists / maintainers of anything the feature is
going to heavily interact with) are the right spot. There's also
#kunit on oftc, or feel free to reach out to Brendan or I to try to
sort out a video meeting if you'd rather something more real-time.

But the lists are probably best. :-)

>
> > > For example, we have this macro that makes KUNIT_ARRAY_PARAM easier by
> > > letting you just declare an array of test cases:
> > >
> > > /* Similar to KUNIT_ARRAY_PARAM, but avoiding an extra function */
> > > #define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)                                        \
> > >         static const void *name##_gen_params(const void *prev, char *desc)                      \
> > >         {                                                                                       \
> > >                 typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);      \
> > >                 if (__next - (array) < ARRAY_SIZE((array))) {                                   \
> > >                         strscpy(desc, __next->desc_member, KUNIT_PARAM_DESC_SIZE);              \
> > >                         return __next;                                                          \
> > >                 }                                                                               \
> > >                 return NULL;                                                                    \
> > >         }
> > >
> >
> > Very neat! I'm more than happy to see this added.
>
> Credits to Benjamin, FWIW. We'll send a patch.
>
> > We're definitely in favour of adding these sorts of helpers. Thus far,
> > these have mostly lived alongside the tests or subsystem being tested,
> > but if they're widely useful then they can sit alongside the KUnit
> > code.
> >
> > My personal feeling is that it's better to have these sorts of
> > subsystem-specific helpers be written and maintained as part of the
> > subsystems (like the tests themselves), largely because that's where
> > the subsystem expertise lies, but we're definitely happy to review any
> > such patches to make sure they fit into the KUnit infrastructure well.
>
> Right, that all makes sense. But ...
>
> > (And, of course, if something spans several subsystems, then lib/kunit
> > may be the best place to keep it.)
>
> Exactly. Even for wifi, being split between cfg80211 and mac80211 makes
> things harder than they should be and less clean if it's part of
> cfg80211 and then somehow exposed to other bits, and then possibly
> refactored into somewhere else in net if that starts using it.
>
> So I think in the case of test-managed SKBs, it would make sense to put
> it into lib/kunit.
>

Yeah, my only other thought is 'somewhere in net', but you'd know net
better than me. :-)

> > Yeah, it's a combination of "no-one has needed it yet", "no-one
> > working on KUnit understands it well enough", and "we haven't had the
> > time yet". We are a bit hesitant to add these features without having
> > tests that use them, too: often things will be coded by hand for one
> > or two tests, and only then refactored out into a common helper.
>
> Right, we're already at that place adding tests to cfg80211 and mac80211
> now, basically.
>
> > There are a few other similar helpers being worked on at the moment,
> > mostly around providing test-managed "struct device"s, so this is
> > definitely an active field of development.
>
> Great.
>
> I think we'll just send a couple of patches to start out with, for SKBs
> and the test case array macro above.
>

Sounds good!

Cheers,
-- David

--0000000000004dac3005f7f59e6d
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCe
Yomp5TAsv2JrVPcJhbimscTBiuj8ArBiFPqCIXBDaDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMjgxMzEyNThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAKKOE8dqTtFe1E+575mzy
pUTagrR4nGkB9PuhNLgPKtFHstNbWgayra4KqNtv6BaOXnN2OenZhTlLAzPkVDHxC/5lQdQ+p8N1
XKumpA+JcOBg3vrKxX0cqpHRotuhQ5OeN/ERi4eaBm3O/Occc/WZ/h+eaKT63ambfbenUxB+GAkg
5BajPUgDQPeA5kL9LsnzviFOh4LiIXxoR6jVxaT2N2SQuomJvAXxj7hN2gJnQLmVxUS8Xs8R1jR5
LN0PjeuJdeRsNwf/IQuurKZgoqeSqmsIKX+BYDE/NmelbrZnZ1pJX4OXcuZsrfbbjYQkYWaKTdnt
1fkkD2JpU9yTd5q83g==
--0000000000004dac3005f7f59e6d--
