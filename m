Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A595A21E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 09:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiHZHac (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 03:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245403AbiHZHaY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 03:30:24 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF35D3B941
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Aug 2022 00:30:17 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id q67so891790vsa.1
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Aug 2022 00:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9pojPcWlr88eoOi9S1SmXIHzCD7bmQl5bKmOMDp4Ekk=;
        b=Hhd6qH4h+vrSO/z1UjGpx8LbOu4DAfLKwYna9FZgKddsaVF9kImUY9qJboUCeesws9
         dM0cPV6pzrRjGNnBKb6coBOh2eROyMlH14WuHhCbYzz0llyCO7Q34BM+lhk5bYRnvr46
         QRsYQGcyVgxgF4FUg9djsaopJx4yAy0S5XFeS3IPwE8ZzcdiPTpEn0LAJK7TD24B/tfN
         LmQUy77HZCMdhXDthnY9izAAD98YuFlijzb9qtDykcvkRGKwFdBce1ks4r4I3s488ngd
         iOaRUJ/Y79AkRS3CZf3Wde5a6xApsJEG7yDYtj5pO6auFhrb9uR3cTc+97G/DJmGy4Kt
         RCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9pojPcWlr88eoOi9S1SmXIHzCD7bmQl5bKmOMDp4Ekk=;
        b=hwb2dyaW7WlvmzFrUaoZCU7PVFw04ses47TRxJa4NOUxT//tgzi0G3+GeNZjrUe3sd
         zj4S+Kdq67B471tofjSY8nqYpPh8280DntHXxnRKxGA2niE2T+GDXMUhKRx+QNcKB9xs
         wMqCAzYBCtkYKPOtGmWFq2rKF1w/b4294JKEC2ScnovJ1r5CyZK/Dh9MWpjAHxmnR3F1
         keSfTAB9ZlWCZyZYjJOv6AsuXEhWiqX4Q2RVMEwgJuB5S8ixmO6AawWUkffcp3s3qDfq
         R7jIQoqWCLw5o5m8K+pB16bfnN9hqvlHpmjV6Z+VDJSxJpyGfydQSXPQTmARlFKwl3+n
         4dcA==
X-Gm-Message-State: ACgBeo3xM0lqMWRaAeQEBGOeZF7qMAO53b6YdzvirfkNeOIQOOOPbB2h
        +fdd5pWAwtkhALj5zyAE1A6ssVPaanU8M+eF1shyAA==
X-Google-Smtp-Source: AA6agR6UOS1O7idUrfet3k/+tK5WhUGoh8zTw/aiWFM/f1r9BjPHUdUGdeZKxPuGA9fli2zLZqBYdpZ86YJKGnRPASo=
X-Received: by 2002:a67:dc81:0:b0:390:3481:dee2 with SMTP id
 g1-20020a67dc81000000b003903481dee2mr2943634vsk.18.1661499016561; Fri, 26 Aug
 2022 00:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220822022646.98581-1-tales.aparecida@gmail.com> <20220822022646.98581-5-tales.aparecida@gmail.com>
In-Reply-To: <20220822022646.98581-5-tales.aparecida@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 26 Aug 2022 15:30:03 +0800
Message-ID: <CABVgOS=w=4dMKN8XZqC53JRgR8iBrwn23G1t_Qcemdoe8qfZVQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] Documentation: KUnit: Reword start guide for
 selecting tests
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
        boundary="000000000000b29f8d05e71fe2c7"
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

--000000000000b29f8d05e71fe2c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2022 at 10:30 AM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Reword "Creating a ``.kunitconfig``" into "Selecting which tests to run"
> covering the current alternatives for editing configs and glob-filtering
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> Reviewed-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
>
> ---
> Notes:
>     Avoid hyphen in "test case" and "test suite"
>     Fix nit: "any test case that match" -> "...matches"
> ---

Thanks very much: I quite like this, more detailed, description.

I'd prefer we tell people explicitly to use ".kunitconfig" files
rather than "using Kconfig": personally I find the latter is a bit
ambiguous as to which files are being changed, and whether or not
you're changing things using .kunitconfig files, or be directly
modifying .config. "Cutomizing Kconfig" suggests the latter to me.
Though it is a little awkward to call it kunitconfig when doing the
--kconfig_add options, too, so if you'd really prefer it as-is, I'll
live with it.

Other than that, though, I'm really happy with this change. I do think
it's starting to push against the edges of the "Getting Started"
guide: I think if we wanted anything more complicated than this, it'd
be best to just link to the run_wrapper.rst page, but this seems good.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
 -- David

>  Documentation/dev-tools/kunit/start.rst | 90 +++++++++++++++++--------
>  1 file changed, 63 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-=
tools/kunit/start.rst
> index 9beec7d6ac4b..adf782507999 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -52,27 +52,20 @@ The tests will pass or fail.
>  For detailed information on this wrapper, see:
>  Documentation/dev-tools/kunit/run_wrapper.rst.
>
> -Creating a ``.kunitconfig``
> ----------------------------
> -
> -By default, kunit_tool runs a selection of tests. However, you can speci=
fy which
> -unit tests to run by creating a ``.kunitconfig`` file with kernel config=
 options
> -that enable only a specific set of tests and their dependencies.
> -The ``.kunitconfig`` file contains a list of kconfig options which are r=
equired
> -to run the desired targets. The ``.kunitconfig`` also contains any other=
 test
> -specific config options, such as test dependencies. For example: the
> -``FAT_FS`` tests - ``FAT_KUNIT_TEST``, depends on
> -``FAT_FS``. ``FAT_FS`` can be enabled by selecting either ``MSDOS_FS``
> -or ``VFAT_FS``. To run ``FAT_KUNIT_TEST``, the ``.kunitconfig`` has:
> +Selecting which tests to run
> +----------------------------
>
> -.. code-block:: none
> +By default, kunit_tool runs all tests reachable with minimal configurati=
on,
> +that is, using default values for most of the kconfig options.  However,
> +you can select which tests to run by:
>
> -       CONFIG_KUNIT=3Dy
> -       CONFIG_MSDOS_FS=3Dy
> -       CONFIG_FAT_KUNIT_TEST=3Dy
> +- `Customizing Kconfig`_ used to compile the kernel, or
> +- `Filtering tests by name`_ to select specifically which compiled tests=
 to run.
>
> -1. A good starting point for the ``.kunitconfig`` is the KUnit default c=
onfig.
> -   You can generate it by running:
> +Customizing Kconfig
> +~~~~~~~~~~~~~~~~~~~
> +A good starting point for the ``.kunitconfig`` is the KUnit default conf=
ig.
> +If you didn't run ``kunit.py run`` yet, you can generate it by running:
>
>  .. code-block:: bash
>
> @@ -84,27 +77,70 @@ or ``VFAT_FS``. To run ``FAT_KUNIT_TEST``, the ``.kun=
itconfig`` has:
>     ``.kunitconfig`` lives in the ``--build_dir`` used by kunit.py, which=
 is
>     ``.kunit`` by default.
>
> -.. note ::
> +Before running the tests, kunit_tool ensures that all config options
> +set in ``.kunitconfig`` are set in the kernel ``.config``. It will warn
> +you if you have not included dependencies for the options used.
> +
> +There are many ways to customize the configurations:
> +
> +a. Edit ``.kunit/.kunitconfig``. The file should contain the list of kco=
nfig
> +   options required to run the desired tests, including their dependenci=
es.
>     You may want to remove CONFIG_KUNIT_ALL_TESTS from the ``.kunitconfig=
`` as
>     it will enable a number of additional tests that you may not want.
> +   If you need to run on an architecture other than UML see :ref:`kunit-=
on-qemu`.
>
> -2. You can then add any other Kconfig options, for example:
> +b. Enable additional kconfig options on top of ``.kunit/.kunitconfig``.
> +   For example, to include the kernel's linked-list test you can run::
>
> -.. code-block:: none
> +       ./tools/testing/kunit/kunit.py run \
> +               --kconfig_add CONFIG_LIST_KUNIT_TEST=3Dy
>
> -       CONFIG_LIST_KUNIT_TEST=3Dy
> +c. Provide the path of one or more .kunitconfig files from the tree.
> +   For example, to run only ``FAT_FS`` and ``EXT4`` tests you can run::
>
> -Before running the tests, kunit_tool ensures that all config options
> -set in ``.kunitconfig`` are set in the kernel ``.config``. It will warn
> -you if you have not included dependencies for the options used.
> +       ./tools/testing/kunit/kunit.py run \
> +               --kunitconfig ./fs/fat/.kunitconfig \
> +               --kunitconfig ./fs/ext4/.kunitconfig
>
> -.. note ::
> -   If you change the ``.kunitconfig``, kunit.py will trigger a rebuild o=
f the
> +d. If you change the ``.kunitconfig``, kunit.py will trigger a rebuild o=
f the
>     ``.config`` file. But you can edit the ``.config`` file directly or w=
ith
>     tools like ``make menuconfig O=3D.kunit``. As long as its a superset =
of
>     ``.kunitconfig``, kunit.py won't overwrite your changes.
>
>
> +.. note ::
> +
> +       To save a .kunitconfig after finding a satisfactory configuration=
::
> +
> +               make savedefconfig O=3D.kunit
> +               cp .kunit/defconfig .kunit/.kunitconfig
> +
> +Filtering tests by name
> +~~~~~~~~~~~~~~~~~~~~~~~
> +If you want to be more specific than Kconfig can provide, it is also pos=
sible
> +to select which tests to execute at boot-time by passing a glob filter
> +(read instructions regarding the pattern in the manpage :manpage:`glob(7=
)`).
> +If there is a ``"."`` (period) in the filter, it will be interpreted as =
a
> +separator between the name of the test suite and the test case,
> +otherwise, it will be interpreted as the name of the test suite.
> +For example, let's assume we are using the default config:
> +
> +a. inform the name of a test suite, like ``"kunit_executor_test"``,
> +   to run every test case it contains::
> +
> +       ./tools/testing/kunit/kunit.py run "kunit_executor_test"
> +
> +b. inform the name of a test case prefixed by its test suite,
> +   like ``"example.example_simple_test"``, to run specifically that test=
 case::
> +
> +       ./tools/testing/kunit/kunit.py run "example.example_simple_test"
> +
> +c. use wildcard characters (``*?[``) to run any test case that matches t=
he pattern,
> +   like ``"*.*64*"`` to run test cases containing ``"64"`` in the name i=
nside
> +   any test suite::
> +
> +       ./tools/testing/kunit/kunit.py run "*.*64*"
> +

Another interesting distinction is that filtering tests can be done
without using kunit_tool, though that's probably out-of-scope for the
Getting Started documentation.


>  Running Tests without the KUnit Wrapper
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  If you do not want to use the KUnit Wrapper (for example: you want code
> --
> 2.37.2
>

--000000000000b29f8d05e71fe2c7
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCc
Sx5T28cZoTQ9PHOlRfx27lLMcXYv/oyfObRshewVDzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MjYwNzMwMTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEATextapLxlP3S51ywoKk0
jzbB5hgnxtv4QYQX5HGyni5lpThd3MfjZbepvgGMjUDleS6UO4qQD/fPpefdOqNBesEo6w2SSsjX
fxTM3XRdEieq5sP48uqrYucxlYoolrwqwZNersgDgH5Gb5pmsfRDDECQhmWivjS94cL23SKvT58f
hjeUI2Set/VhTVtoPKwL2G2vOZZ3SG5ensuo+6mvLrxMkYDwoUjM9koM+FykKWBN8/vQaaNIIUue
8W4IDzS3fS4SJ63gHvZo2l3p1OlMR5sKA/m10gi4DtuahkcktIY1c5WB+OaWYFZ8ojRd0w352c3A
PIxl+NmFb0L+nS1MBw==
--000000000000b29f8d05e71fe2c7--
