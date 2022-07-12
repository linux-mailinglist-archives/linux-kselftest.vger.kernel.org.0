Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F22571260
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jul 2022 08:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiGLGoX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jul 2022 02:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGLGoW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jul 2022 02:44:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9BB3C16B
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Jul 2022 23:44:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id z23-20020a7bc7d7000000b003a2e00222acso431941wmk.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Jul 2022 23:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r22yBfvlsp+SYsY+YbhHyWp1k5zwCQF3cuuKNB+I4i0=;
        b=nzYNwbcwtVuX5jBy5CgVusZPUsZg+WA6TJHWLsfLN/HvqQxm7HG3ouY50wXz1yhv27
         GHxdxqZLfT2e4qUhZMeI6TPYBSYwpmWfS4Jj7pfyOEdnKmLHqromXFK6xIfUtFL3KUrP
         AZ2MbooJ21iAuYH+uGDcG+qHRuyco2U4hE3f4RNEUW96oyD28L52jqhbTACBVeYw+u6+
         3NjG7rRRFgf835sI1x2QIXar4g/VDwl6P3kAPh/dvs//GKl7HUzP7n15CyMbWLzOiftg
         Lk6aqqnfBPWv1jlMuWCbZT64bdVJGnaHrctaUW9GTkuZ1s6QYOQMZzJgr22mICFoVHNi
         TLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r22yBfvlsp+SYsY+YbhHyWp1k5zwCQF3cuuKNB+I4i0=;
        b=R+piF5D6vHlFzMyYQSZnUigoxXlqeP23OXnDQLb2zSHVE4yUU7Fok0MBhk5hRw4FpP
         8YY3OzM7LmlINe5L8adDzHG6Nx+0pB+DGSkHXCDiAaVFvKjkMAhOpdmUafk5yptzLj6w
         pzhgDf8fPCgmYMaBr0bz71y8VIUHUNHnhQ23Ch7ieM/kFTopXJHyGecZ6LVsyXYBpOHW
         XiSU0LGaiOQSfSLaAyg464G9iMLsz5wJyoB5XEuNdfdt6XlK+Q6WLPRya9uyQRjsL60k
         I4N2dczYnj5hW61UveCetvXXxQI4vshc6E6Jlkv/EGSK8scSmnCV/TjotlB1TM6CbofB
         r+Vg==
X-Gm-Message-State: AJIora9OxkWwTKQlcb8v9dgretH15SuDOKE4/OWNDOz7RZBwX7Tov0ug
        NSYLCtZLkTc59xYLrp37Yw0O5cGz8UlUBRFcZ0Wn7w==
X-Google-Smtp-Source: AGRyM1tZaNY3RnpsWXPhubtirONGD9WJkruBLM3+IN0NN9iASwGWk+J9hyYDSii8WApr2iertUTtnt4b6jMvtc4zgRQ=
X-Received: by 2002:a05:600c:34ce:b0:3a0:3b4b:9022 with SMTP id
 d14-20020a05600c34ce00b003a03b4b9022mr2117717wmq.66.1657608259479; Mon, 11
 Jul 2022 23:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220711162713.2467476-1-dlatypov@google.com> <20220711204859.3DDD5C34115@smtp.kernel.org>
 <CAGS_qxqxGfQ5tA063XoRbL1ktimyfmt+CuucJ_rsYVnoi4i7gw@mail.gmail.com>
In-Reply-To: <CAGS_qxqxGfQ5tA063XoRbL1ktimyfmt+CuucJ_rsYVnoi4i7gw@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 12 Jul 2022 14:44:08 +0800
Message-ID: <CABVgOS=bm5TmEBd8jxuTPJy426OgC14ryqn4FLQR1pHNf5uhsw@mail.gmail.com>
Subject: Re: [PATCH] clk: explicitly disable CONFIG_UML_PCI_OVER_VIRTIO in .kunitconfig
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-clk@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007f960f05e395ffd5"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000007f960f05e395ffd5
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 12, 2022 at 7:03 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Mon, Jul 11, 2022 at 1:49 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Daniel Latypov (2022-07-11 09:27:13)
> > > CONFIG_UML_PCI_OVER_VIRTIO=y is needed to enable CONFIG_PCI=y on UML.
> > > However, this causes test failures when running the clk tests, i.e.
> > > $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/clk
> > >
> > > A snippet of the particular error is:
> > > >     ok 1 - clk_gate_test_parent_rate
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 0 PID: 45 at lib/logic_iomem.c:141 __raw_readl+0x9f/0xd0
> > >
> > > This is triggered by this cast in the test:
> > >    143          ctx->fake_mem = (void __force __iomem *)&ctx->fake_reg;
> > > this seems to work except when logic iomem is enabled, i.e.
> > > CONFIG_INDIRECT_IOMEM=y.
> > >
> > > As a short-term fix, explicitly disable CONFIG_UML_PCI_OVER_VIRTIO in
> > > drivers/clk/.kunitconfig so we can enable it for everyone else by
> > > default in kunit.py.
> > >
> > > The long-term fix probably requires something more complicated, like
> > >   #ifdef CONFIG_INDIRECT_IOMEM
> > >     logic_iomem_add_region(...);
> > >   #endif
> >
> > If this is how platform IO is mocked then yes we'll have to implement
> > that.
>
> It's not clear that it will be, but it's likely.
> Until it's more clear, I figured we'd go with this simple bandaid fix for now.
>
> There was initially some talk of using function-level
> "stubbing"/"mocking" [1] to do the same, but Brendan started playing
> around with logic iomem more. He and David can comment on it more
> cogently than I can.

So, as I understand it, casting a regular pointer to an __iomem
pointer (as the clk test does) isn't technically correct, though it
does work on almost every architecture out there. If we want some way
of intercepting I/O access, then then that'll need to be handled by
the various read()/write() functions.

UML doesn't support iomem at all out of the box, and logic_iomem is a
way of implementing it which allow us to attach handler functions to
blocks of memory, albeit with more constraints about what addresses
get used. Brendan started implementing a "fake hardware" interface on
top of this here, though it's still in-progress:
https://kunit-review.googlesource.com/c/linux/+/5272/4

Ultimately, I think the 'correct' solution here will be
logic_iomem-based, but doing that nicely will probably require one of
two things:
- logic_iomem to support non-UML architectures as well (becoming a
generic "insert a 'fake' device here" system)
- logic_iomem to have some way of "passing through" access to an io
memory region through to the normal underlying memory.

Ideally, we'll have both, and maybe even defaults which will allow
hacks like this to continue working (perhaps with a warning?). That'll
require some significant (and probably not uncontroversial) work on
how iomem accesses work in general, though, possibly with performance
impact.

The other option of using function redirection on the io read()
write() functions exists, and would be a bit simpler in the
short-term, but would probably result in a lot of tests reimplementing
this, and also would have some performance impacts, as the I/O
accesses wouldn't be able to be inlined if KUNIT is enabled.

Cheers,
-- David

--0000000000007f960f05e395ffd5
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
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAGH0uAg+eV8wUdHQOJ7
yfswDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMjA2MjAw
MjAzNTNaFw0yMjEyMTcwMjAzNTNaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCv9aO5pJtu5ZPHSb99iASzp2mcnJtk
JIh8xsJ+fNj9OOm0B7Rbg2l0+F4c19b1DyIzz/DHXIX9Gc55kfd4TBzhITOJmB+WdbaWS8Lnr9gu
SVO8OISymO6uVA0Lmkfne3zV0TwRtFkEeff0+P+MqdaLutOmOcLQRp8eAzb/TNKToSROBYmBRcuA
hDOMCVZZozIJ7T4nHBjfOrR+nJ4mjBIDRnDucs4dazypyiYiHYLfedCxp8vldywHMsTxl59Ue9Yk
RVewDw3HWvWUIMbc+Y636UXdUn4axP1TXN0khUpexMoc5qCHxpBIE/AyeS4WPASlE8uVY9Qg8dT6
kJmeOT+ZAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFDyAvtuc
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBn
Tk66uJbvglg0AKHX/x9QBJo9CpMpTq1HZEq2FGB/JzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA3MTIwNjQ0MTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAURDWVVbo39P6Fu6M/q7O
bf56OiM9u1dc0ScLJCMYnpvpJGQS38C8nCBZwcYajFWO6hz5W/YtOSRStKF7zPHY+CaQ7lk1pD3N
bW5/dB3ryH1aEmRs4NOalJkhJm48Pe4JHxpdmPIDC9WLacXN6vRStThkoL+GIAlg2q45U20nqakA
OssWtfUuvOv1geY0g0dFds4cYZxPjgV1eH7tbZ2XqlsMKiPyK8buBWy4eGEQ1R0aUPXSg8FF5DpC
1itT9aulzOc3KiJW4s8UTaDJPV0g6IOpY2pyMCYSWtPLWaLvJniJfKEFkclazl8/YYXshnN392mb
GwNMlikx8xcElsu/UA==
--0000000000007f960f05e395ffd5--
