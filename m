Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A1C5A21E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 09:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245330AbiHZHaB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 03:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245318AbiHZH36 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 03:29:58 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C9E2AE3
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Aug 2022 00:29:56 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id z14so269146uam.10
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Aug 2022 00:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zXXFpTHxpo2nY/nLIWjRZWTVfSuv8a5GhuaAnMTuak4=;
        b=r/SJKIMdS+OMslLs21558FzM5N876wSJr0nkIiPBgh2jvwHzECvuUdJ5QOBDFHTabD
         A3RgwfW/qFd1zO19hMX6TMOLCsYU14vfGV/4mxDcuhllPapFwa66JpNr/eDNRJsEmrtH
         FchvtOcy4VeQn0Is9ZgyMxjsBzfZnYxtlMVphTdXjX/2MQri6MkEe/ICk/3C9wL25+AV
         66F8LNR5GXPIpPf0GmqtjZW9HLNd/ONL8UIlysNpmwHoO9gmNq5FVK2U7PdTYl0sbVa/
         8kuKZky0X7G3JBiqkNHWSl4eTWfBxiotR3HpqqQKW4ixtS/Dy0EurMdeRHBtJtDJ85ub
         aeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zXXFpTHxpo2nY/nLIWjRZWTVfSuv8a5GhuaAnMTuak4=;
        b=PjGEV5zCgzVGp6Pt1qRGQEn0giV5q5hL1lesdcKskKb9iGVS+UT4G4yYYX5RDE5Vic
         Mgg264YsYpnvcBl5UoXibP49Mo2COo6Jlndql5GiwpjjwFgyX5fixW+/3kkQsVYzQe6t
         dTBW/NGzvep/lFZkhu35gjiAb1CFhEO5mmBshKN+4UifWxxRGzvH2CZmLAGr05xepcz1
         X4KCpWC4+zrf0yH0CWU39MMeWnXgMmXP3MXFvIMz1wBu+SoG89D3LypwaGQlQ8iROzFG
         966hNdm0MnAv+Bn8r04op8USueyiNKv/E86LeSiLF8Vcza6hcresXB+bSU6r4hsoFCae
         tbZg==
X-Gm-Message-State: ACgBeo1qKT2mrIQmatT0zWVrmQJTtL6/yr9V4YIEf4dogOR8ID4epMea
        K2T9g3i+nsQMbT9kWvoRBwylMQBxHmIBAJvYcozeLA==
X-Google-Smtp-Source: AA6agR54ZG8qKVeafytfKt1PWeZASXjS48mLkoaHVp+GzzEaQXfM0iQf+IVf9YXNgQYYGxIMCRai/vdomjwPlx9/3Sc=
X-Received: by 2002:ab0:14ad:0:b0:39f:255c:2ea9 with SMTP id
 d42-20020ab014ad000000b0039f255c2ea9mr2804290uae.52.1661498995743; Fri, 26
 Aug 2022 00:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220822022646.98581-1-tales.aparecida@gmail.com> <20220822022646.98581-3-tales.aparecida@gmail.com>
In-Reply-To: <20220822022646.98581-3-tales.aparecida@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 26 Aug 2022 15:29:44 +0800
Message-ID: <CABVgOSnmRaSHm5D0DvRW9T2wpaGvzMwUuxPi=tHnLrOATMfEtQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] Documentation: KUnit: avoid repeating "kunit.py
 run" in start.rst
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
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
        boundary="00000000000074057c05e71fe1ed"
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

--00000000000074057c05e71fe1ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2022 at 10:30 AM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Combine two sections mentioning "kunit.py run" to streamline the
> getting-started guide. Update "kunit.py run" expected output in
> the guide and run_wrapper.
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
>
> ---
> Notes:
>     Update the expected output and the note that follows it (Ma=C3=ADra C=
anal and
>     Sadiya Kazi). The output was updated on the commit: 45ba7a893ad8
>     ("kunit: kunit_tool: Separate out config/build/exec/parse")
>     Add word "step" to note and fix the case of "kernel".
> ---

Seems okay to me.

FYI: The old "Generating .config" message is still technically correct
for the first time kunit_tool is run. I don't think it matters one way
or the other, though...

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  Documentation/dev-tools/kunit/run_wrapper.rst |  2 +-
>  Documentation/dev-tools/kunit/start.rst       | 38 ++++++++-----------
>  2 files changed, 16 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentatio=
n/dev-tools/kunit/run_wrapper.rst
> index 518cf87ea732..6b33caf6c8ab 100644
> --- a/Documentation/dev-tools/kunit/run_wrapper.rst
> +++ b/Documentation/dev-tools/kunit/run_wrapper.rst
> @@ -22,7 +22,7 @@ We should see the following:
>
>  .. code-block::
>
> -       Generating .config...
> +       Configuring KUnit Kernel ...
>         Building KUnit kernel...
>         Starting KUnit kernel...
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-=
tools/kunit/start.rst
> index e730df1f468e..2e31350a85e1 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -19,7 +19,21 @@ can run kunit_tool:
>
>         ./tools/testing/kunit/kunit.py run
>
> -For more information on this wrapper, see:
> +If everything worked correctly, you should see the following:
> +
> +.. code-block::
> +
> +       Configuring KUnit Kernel ...
> +       Building KUnit Kernel ...
> +       Starting KUnit Kernel ...
> +
> +The tests will pass or fail.
> +
> +.. note ::
> +   Because it is building a lot of sources for the first time,
> +   the ``Building KUnit Kernel`` step may take a while.
> +
> +For detailed information on this wrapper, see:
>  Documentation/dev-tools/kunit/run_wrapper.rst.
>
>  Creating a ``.kunitconfig``
> @@ -74,28 +88,6 @@ you if you have not included dependencies for the opti=
ons used.
>     tools like ``make menuconfig O=3D.kunit``. As long as its a superset =
of
>     ``.kunitconfig``, kunit.py won't overwrite your changes.
>
> -Running Tests (KUnit Wrapper)
> ------------------------------
> -1. To make sure that everything is set up correctly, invoke the Python
> -   wrapper from your kernel repository:
> -
> -.. code-block:: bash
> -
> -       ./tools/testing/kunit/kunit.py run
> -
> -If everything worked correctly, you should see the following:
> -
> -.. code-block::
> -
> -       Generating .config ...
> -       Building KUnit Kernel ...
> -       Starting KUnit Kernel ...
> -
> -The tests will pass or fail.
> -
> -.. note ::
> -   Because it is building a lot of sources for the first time, the
> -   ``Building KUnit kernel`` may take a while.
>
>  Running Tests without the KUnit Wrapper
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> 2.37.2
>

--00000000000074057c05e71fe1ed
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBa
9BIjPuZCvhsJi5VH2KY7R8lNBgkP0XcPPQ5LVHIiQjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MjYwNzI5NTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEARQ/KD+iIKnMLRvVAQBTp
ZeKPDBbWWHiuU2ABSxcuBVTWLmYUUagTLRJu9dqQseTNkDhbiD2BC3FCY8G6rAUrh4zPz31a0qRQ
DBv/dZkpOUMVJVpol9QGUL17EE1V6P1F2hCuBUkIR0vV+Ux3tFbULbdTsaVZwOPstsewN2m4itK2
yAKwPDzcKWeSVyHCcfhzNaTCkxXj3GgyS3ZkQesF99csk+L1kjk8YoJ9oSV47hXR5VdwhdvbhVsz
yuEQKvwQxnrdYs2qD/6l01yz2ggVNILDBC/SvBDgh7RJOSEaoTW+RUJ69qdqMJgqAZ1vGGQtnK1S
p6mIlEvqDymgQTS6dw==
--00000000000074057c05e71fe1ed--
