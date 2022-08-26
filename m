Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABBE5A21EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 09:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245429AbiHZHaw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 03:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245450AbiHZHa3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 03:30:29 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB70815A32
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Aug 2022 00:30:24 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id k2so864352vsk.8
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Aug 2022 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uSTjAxCS3xB4Gb+cioSl20UGm9tIyfFJwwmLXB6rKnE=;
        b=tJqbckZAmQrN8sup9kMRTi6mzXEkOwz4sDw2KBSlRzmPW7oh0SIUVlnCJXpcwM6DDq
         Sc2yinGrdv3X76dzcp7R6FDP1EqVZpaBXmVnetuffS5rgPuem225Uyubs/IZxezWTZbo
         kn8RAL5NLi5MDsYBFWNKnnV+qzXpuTxF3uR6NMPQZpWULhY9slDRrrlmEQxjcU2TCNFs
         Zmm+VcHNCptG0vCSM0K4kk1cqRaZP73805sR6F1rqz8jNWHJ1wXYQYicrkLqKgBzjShw
         a7gJSqw4J9cr2Gjoqh8xCDz5OKMR9bmC8wml1fRtAG20YnOCW67O+pq1sIfGlqQNktUT
         1c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uSTjAxCS3xB4Gb+cioSl20UGm9tIyfFJwwmLXB6rKnE=;
        b=qd/FSpyLYJCrpGUyoba9OJ0d4V8nswKzeCBOQrqPTrbtEp3SPDVmfyD3P0BwayyWt0
         N1beszBx9tz2tvq/OnVj1axUZa3RmRKG4dQgjCsx3Bs8rN9WLOGn2LvRbeDbOyu3+VM2
         ML2XRjhJIgI2TLrHYggqdZZiypLHZCBP8qJ0iXVQsBODCLy1cBbTvvtQxMY+Dchw6XR7
         zfCtKbCBA40YiN/hKi13qiVFvnlnEm2Vzj5ss46wxhmVR30JnO9Nm4oOYcrrXaDENbUu
         s+n2xSF7FSOf2Sb74HIG5b1HSXk/KcfwQyA3yyWhUHsnXnZ3eexSlmeLGkKcvD5HnOzD
         /WDg==
X-Gm-Message-State: ACgBeo1M9XWBSqq4A1XR7EP6GlYPK9YXvibTQjsUvC+nqQ05Spz8zqOa
        qLX8diK4BcQiBpjyvXSD8bE1Q0odoFhzNG4Tj8T/wQ==
X-Google-Smtp-Source: AA6agR7t3WpllY3bDzln7kJj831QZ0OAlLfAjHefM23sEsrabUR59rjfcPPvhEZRRSTppeaw1Km9En+9AIdzlkgYrXQ=
X-Received: by 2002:a05:6102:2146:b0:38f:f3d6:51da with SMTP id
 h6-20020a056102214600b0038ff3d651damr2721125vsg.38.1661499024271; Fri, 26 Aug
 2022 00:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220822022646.98581-1-tales.aparecida@gmail.com> <20220822022646.98581-6-tales.aparecida@gmail.com>
In-Reply-To: <20220822022646.98581-6-tales.aparecida@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 26 Aug 2022 15:30:12 +0800
Message-ID: <CABVgOSk4e=UZaH+7mSTiFtxHHoQ9PXo7vg8+_PcZYxnbtDDvbw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] Documentation: KUnit: add intro to the
 getting-started page
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000027e2f005e71fe363"
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

--00000000000027e2f005e71fe363
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2022 at 10:30 AM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Describe the objective of the Getting Started page, which should be a
> brief and beginner-friendly walkthrough for running and writing tests,
> showing the reader where to find detailed instructions in other pages.
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> Reviewed-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
>
> ---
> Notes:
>     Remove recommendation about having compiled the kernel before using
>     kunit_tool. I changed my mind about it after Tim Bird's highlight.
> ---

This is fine.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  Documentation/dev-tools/kunit/start.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-=
tools/kunit/start.rst
> index adf782507999..75fd05286396 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -4,6 +4,10 @@
>  Getting Started
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> +This page contains an overview of the kunit_tool and KUnit framework,
> +teaching how to run existing tests and then how to write a simple test c=
ase,
> +and covers common problems users face when using KUnit for the first tim=
e.
> +
>  Installing Dependencies
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  KUnit has the same dependencies as the Linux kernel. As long as you can
> --
> 2.37.2
>

--00000000000027e2f005e71fe363
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB8
SAdCXFIW4/L7MXqIeP4q4B9U3OHsZZxCiREUHux7CzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MjYwNzMwMjRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAgIYngVRYtnumXwdHhHvJ
GoL/A6pAHex4h1bEisAAQp+NCS0H7f+o4ovcSMLRJ2+aNw3jhw/wjMOXuVtU37OplMN0ULr+2H4X
wW6Eiiq8R5jXCzuZqTsfI+I/HWHRRDxvwDEORvvweD4mvcFLibt/2FMgNxSSN/OS1Cuqu9Mv6mJX
Oj3L+6K7gZbrPNBztnxEfjDmxxoVaT8BJ9U9hEYTe3lXPk8EkS3UA/VaYLJhiQBH39VqKst8zJL0
fqrAkdZIej7jVjTsxKwdJCcuiilfuEy5TXm4r0rqpZnl5Zk/GmwShyw9Og4/p2/cMFgy6K9JmeJA
S81EZEYCXa3reSRH2Q==
--00000000000027e2f005e71fe363--
