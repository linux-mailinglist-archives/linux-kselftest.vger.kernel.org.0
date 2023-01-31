Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C61682077
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 01:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjAaAOu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 19:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjAaAOs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 19:14:48 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0405910D2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 16:14:47 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id 22so6637565vkn.2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 16:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiBS8mOlSNnUDRLFFqZbuno5gs8yeYa4v2kE5D5sAj4=;
        b=ILQ2gGX8n54fqtWKPXvodEoEVnBfJXbx8EDTywUPvckZgwNlrfXrQ/jFbqd89rKGje
         qGRViAmtVcbVvDIau97UbWFgmdP9bpLM9zu4Re3hT2lGCamp5sX9oiUQV3V7U94MJh56
         HtxJkGJBqGhDWYtCzfjDn3cq4UDVbiKzm+rEfEHtCP2wNXVzYwLgeHWOo3b2j9ZgveEd
         5o1Dm2dl0RaiHGJI4B53qUI9yj0UOEobD/oyaG+n1zRUnb1yx5q/eAl82OuCl/ySRSNh
         hx0+v7BEzON/2t7WUeu0ATMtSCRHVs7pf7svgfmOFcntvZQS10N806kLKXHe4tfIANyu
         3MRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZiBS8mOlSNnUDRLFFqZbuno5gs8yeYa4v2kE5D5sAj4=;
        b=SHxTicNJ8I1c8jkwS4pQJR2DSokwy4fTPCDRaGq/pCesBCSTksp4qRnJhVcEAT42/G
         H5JGAznB5vO5O6lobAA9c+R0KnyQ98TReh/SJ6GOi95qHIvMzLEGa/l+OE41KSHLntUV
         bDXxLfMrI+s9rvH5jifGQf6iimF41x4KAS5YxXhxLWKcIHoqIqpRtvS4LMVHxY8zaXQL
         CRZEkCdtgLV/04gOvnODpSgf0Swhew5NrsVx/NqcucVxcHl05Ty+79HOnJ0Cxv1gKlJE
         fvqD8J7cjXPglnFCe/z67PT6zsvBPJUkVy+eQ/iAuLvaF52nHnvL0HuImW1d0d/Jl12v
         Dhaw==
X-Gm-Message-State: AO0yUKULT2/zO7Df9OtRDud1S5/+BqVE99v1q+wLV4E6eaG610QhVIVs
        Y4TNNSN2kDUhkrOcWnrhOewx2kjfOiNQh6AFu6I9rw==
X-Google-Smtp-Source: AK7set/hyAoJM49lyt0V8W2pMN9Ouelb9rmIVOrGn/1QZoGauQ7QWcDbcJiHVpdnmajSvTWomJ0hNUNLxGEYISh7ITA=
X-Received: by 2002:a1f:b695:0:b0:3e2:5b03:a395 with SMTP id
 g143-20020a1fb695000000b003e25b03a395mr3012579vkf.4.1675124086060; Mon, 30
 Jan 2023 16:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20230128071007.1134942-1-davidgow@google.com> <CAFd5g47r-J+0FMt+F3pmVWBBKNXEqRD03Jh_i2HjUBhZBM8rdg@mail.gmail.com>
In-Reply-To: <CAFd5g47r-J+0FMt+F3pmVWBBKNXEqRD03Jh_i2HjUBhZBM8rdg@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 31 Jan 2023 08:14:31 +0800
Message-ID: <CABVgOS=Wegv+PiA2N2Eo5zxEDWi_5m9PuoLJPMxw2d2SR0FWEg@mail.gmail.com>
Subject: Re: [PATCH] kunit: Add "hooks" to call into KUnit when it's built as
 a module
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001f27b005f384385b"
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

--0000000000001f27b005f384385b
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Jan 2023 at 08:04, Brendan Higgins <brendanhiggins@google.com> wrote:
>
> On Sat, Jan 28, 2023 at 2:10 AM 'David Gow' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > KUnit has several macros and functions intended for use from non-test
> > code. These hooks, currently the kunit_get_current_test() and
> > kunit_fail_current_test() macros, didn't work when CONFIG_KUNIT=m.
> >
> > In order to support this case, the required functions and static data
> > need to be available unconditionally, even when KUnit itself is not
> > built-in. The new 'hooks.c' file is therefore always included, and has
> > both the static key required for kunit_get_current_test(), and a table
> > of function pointers in struct kunit_hooks_table. This is filled in with
> > the real implementations by kunit_install_hooks(), which is kept in
> > hooks-impl.h and called when the kunit module is loaded.
> >
> > This can  be extended for future features which require similar
> > "hook" behaviour, such as static stubs, by simply adding new entries to
> > the struct, and the appropriate code to set them.
> > Signed-off-by: David Gow <davidgow@google.com>
>
> I agree with Rae that a new file for just setting the pointer seems a
> bit much, but I also understand the point of separating it out now -
> not sure of a better place for it to live. Aside from that, looks good
> to me:
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks Rae and Brendan.

The reasoning behind the separate file here is that, because the hook
implementations are not "static" (as they can be found spread across
different files), they need to have a separate prototype. This
would've required two prototypes (one in the file which had the
implementation, one in the file which set the pointer), so it made
sense to combine these into one header.

Adding the code to set the function pointers to that header made sense
just to keep a couple of the lists of hooks together. It's still a
pain that these are spread between "hooks-impl.h" and "test-bug.h",
but it's probably worth it to avoid either making all of the hook
implementations even more public, or using the more complicated macro
magic (at least for now).

Cheers,
-- David

--0000000000001f27b005f384385b
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBB
cQKFr8R5Kbgtlyvq3edkouVX2HXdydOqaeePFh4HcjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMzEwMDE0NDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAK6+sxRrfFXwYYwsNLerD
2T1dgh0fIpoCGiBgGGog1V7OO2ftBOc//eM6oOz1xykyF+Ux1qp0YVq51d6kMh31lJVIzMaRbo/D
fUZzupMuwl12LAc/BwtND9eMswgBfbBSuFh4bk3XjYRvc73VdRnbT5ifbyt4qersl9KGtb4ckZLo
44GkZQ2PkGKDEXQso9m/EduFi1N1Lvm3jyIjOMr0Qvrva51R3molu58Ro1fcgSGnb37rHlFVOACR
BUsCBcfrphk939hpHIu8jNK31kx5ZU23/Pqd7vROKFzYpTyh/XaLbiNzUW7bWLqwQs/hMafyDS+s
iS1Mki3RPHMa3/LPfg==
--0000000000001f27b005f384385b--
