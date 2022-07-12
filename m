Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE475712F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jul 2022 09:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiGLHTg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jul 2022 03:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiGLHTd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jul 2022 03:19:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C7EDEAE
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jul 2022 00:19:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o4so9891714wrh.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jul 2022 00:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQdDG4/QZAy9f/dH1GGc4ywkGCrcHAnjT/NlkSpgq/I=;
        b=SMhrKfKEfVmBsmZUFvKc3FL/BTr7sFwlb4u9ZNEQSxuFx4FaP5mk4UgZ48/k4CTILn
         B0Kyr0DBQv2OhLTbBf+nluUXO5+A5xcgasFkwi9l9OhBdyYdFNIucEiYzpGDRi2JSOdo
         4ixUyDZOAcH8N2tVa5zoemkT9iSd4gSoW+dk6gDyYeReZI3yavokxJjgVZ8QG3sPG2WY
         WfBaMuo0aawawbtHbVAJkeEKimzuxaYHSYlBCr3GfNlitE2hx0xrbAKp21WbYM/3XP2+
         4uDmIZHCiYL1iE4JslSBAHcOTa7GBwmL2MSJqL+qaEoHcgB3W0QF+J8IcsDQorudqvCt
         6/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQdDG4/QZAy9f/dH1GGc4ywkGCrcHAnjT/NlkSpgq/I=;
        b=aoaIIZg5//ojXUpPY2yErgxy+s/CPQ6qN0Ma/rhrWXg6MsWLS20R0S1rljZGCanaHT
         8fzL8v07BxMGrZvYBnkqelJHr+tTUlkH+ybf0ZXfKDBYjfH4Qf+3tbbNuTwV7Q/o/Xhg
         a9HCJ2V2qhl7sLVldbf6E6kjhdSPkZggvjwx9is4A4N4/pJEnvxR6xO3OrV8/+kjamZL
         lAVVuzeH9uFD3Jho51LdNdpPGVkI9HdHNdRMo4ABPIRP9RHZrFXusxUCDHvBrIMwdcVJ
         Em9DKqH2EuxtHNu4KiXew1V5M8NjPTyNmoNAb0RX+H4TBIPWeMVm7Ux8hKTGYL5+IasJ
         RDdQ==
X-Gm-Message-State: AJIora/aWaqG9OOlWvfj6DW8vqtz1wPjOey4tVGwVtfd3Xtad+5eSoFL
        XmZgTaMpuFSjncfDItt3beXlV44VkXSRRQifIlAOkQ==
X-Google-Smtp-Source: AGRyM1tu7uvjAakm2E5phW8PHa+BxBSNdykerlRB9Bw0zuH+Gb/3l4pHyhL8kYh6W29eQGpqM6MYIVXtgUVwc1ZNz6k=
X-Received: by 2002:adf:fd4a:0:b0:21d:8b59:dcb1 with SMTP id
 h10-20020adffd4a000000b0021d8b59dcb1mr20181622wrs.622.1657610368960; Tue, 12
 Jul 2022 00:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220711162713.2467476-1-dlatypov@google.com>
In-Reply-To: <20220711162713.2467476-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 12 Jul 2022 15:19:17 +0800
Message-ID: <CABVgOS=FzA5oKkTEJLMp6=funMiLqp5SzcwOcoqdfVeuxMQLqA@mail.gmail.com>
Subject: Re: [PATCH] clk: explicitly disable CONFIG_UML_PCI_OVER_VIRTIO in .kunitconfig
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003bcc6105e3967d9b"
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

--0000000000003bcc6105e3967d9b
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 12, 2022 at 12:27 AM 'Daniel Latypov' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> CONFIG_UML_PCI_OVER_VIRTIO=y is needed to enable CONFIG_PCI=y on UML.
> However, this causes test failures when running the clk tests, i.e.
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/clk
>
> A snippet of the particular error is:
> >     ok 1 - clk_gate_test_parent_rate
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 45 at lib/logic_iomem.c:141 __raw_readl+0x9f/0xd0
>
> This is triggered by this cast in the test:
>    143          ctx->fake_mem = (void __force __iomem *)&ctx->fake_reg;
> this seems to work except when logic iomem is enabled, i.e.
> CONFIG_INDIRECT_IOMEM=y.
>
> As a short-term fix, explicitly disable CONFIG_UML_PCI_OVER_VIRTIO in
> drivers/clk/.kunitconfig so we can enable it for everyone else by
> default in kunit.py.
>
> The long-term fix probably requires something more complicated, like
>   #ifdef CONFIG_INDIRECT_IOMEM
>     logic_iomem_add_region(...);
>   #endif
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reported-by: Maxime Ripard <maxime@cerno.tech>
> Tested-by: Maxime Ripard <maxime@cerno.tech>
> ---
> Note: this targeting the -kselftest kunit branch.
> There's a commit that triggers this by enabling logic iomem by default
> [1] and there's also a commit that lets disable it via kunitconfig file
> [2], which this fix relies on.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=6fc3a8636a7b0f7dbd6d0a4e450e765dc17518d4
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=8a7c6f859a20ca36a9e3ce71662de697898c9ef5
> ---

Looks good, works for me (and doesn't break either i386 or arm64,
which I also tested on).

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  drivers/clk/.kunitconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/.kunitconfig b/drivers/clk/.kunitconfig
> index cdbc7d7deba9..2fbeb71316f8 100644
> --- a/drivers/clk/.kunitconfig
> +++ b/drivers/clk/.kunitconfig
> @@ -2,3 +2,4 @@ CONFIG_KUNIT=y
>  CONFIG_COMMON_CLK=y
>  CONFIG_CLK_KUNIT_TEST=y
>  CONFIG_CLK_GATE_KUNIT_TEST=y
> +CONFIG_UML_PCI_OVER_VIRTIO=n
>
> base-commit: 7635778bac7e46458392c1261e3916e8e9e86860
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220711162713.2467476-1-dlatypov%40google.com.

--0000000000003bcc6105e3967d9b
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBc
UHKisVTKbyvY4pnUEfVA4bNRBUr8jO+EzGm/HED/FjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA3MTIwNzE5MjlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAEtpVOtBnifipDV4Tl2IO
UUE8RCR5Xl3U6rwhDmxKRz6iEN1INU/p+xGZWCoWjNYaaQv05HPzHQPjgq7+bcT+8FZZ6YsJfQee
+m2pJESFb59f5JnAD4I/MG2TcJpbSNPvt0BX+7AWm3QS97iyI8laJypURXy35okOrqM2cSG8NLF4
klNfv8BmbCkAk1hJ/Hd1sSrk0X+8zPK1ES4r6AH7dnlQaRdiVeoIrDjl0DuhanSomNJw2ASLhfLR
3BLIz/BdZPv3yeUgjBIIU30VFbqU+e8ypAOgZ0zySHNcDfupu4iDt3m030Y3cAZ6oDy2sK+eX2Nl
Kw5frsT8CLAAbcR57A==
--0000000000003bcc6105e3967d9b--
