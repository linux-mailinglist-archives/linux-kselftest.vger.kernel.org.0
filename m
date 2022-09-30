Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD585F0505
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 08:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiI3GnI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 02:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiI3GnG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 02:43:06 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99BE16EABB
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Sep 2022 23:43:03 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id e3so1367449uax.4
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Sep 2022 23:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yHdCEIOwyAARRW62wU0JYzUI8NZa4oX03buyd/iukaU=;
        b=BhwPst2nIn3u23ABed8WK2gVOnOrN2jwJK0JUZI2L3OnwwCfSF8oxPdr88/N4juWBd
         vnArCWTjmYc0OH3Q2B176s1venozOJIfkzKgTgcYzAG7chEZzQf8FeIW0sYODUvudvFr
         JfgDquwnaOyXW/bYqmhWruHXU+i/vB9+r3oLTuBu+AFgHHH34i3/bDl/afzJDZS/oPGj
         qrYCNB6PdPopQQSwvT6OyOba0b0I168m4DTyAn/Ho4oDWdnpxSrhxqD3XvB1QBYz7tBm
         M7BNScYHC97L+RO/GLlOqFmezrLOQE3B2EEKglqnGXuvCYgccdKsaSwJqLoV0a5WmZko
         ozPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yHdCEIOwyAARRW62wU0JYzUI8NZa4oX03buyd/iukaU=;
        b=SCI0Mi27MR51+c+kwIpfErwHzcc+UyzrsYqKrVwM1jbJ9G9o2b+qyrtKrhDyXOzLRh
         e5Iu3qdOfZ2LzXPY7flQdTfHotkrn7Dp3X5ME+5jj+c7XUrzgnp8D3Afo3fZel8BBWJJ
         0JlpHkojZHiUouR9trpRxiYZq+RQ+b46RcXYStxFezU5Z0daEmGaK6SQhe0UFetuSA5f
         LqyOpx0ULWeAwa91DGkARATSGEibnJlIcd4u9rMBeWzGE7HS6dPf3mQr647y7onUkZZD
         TCy/cqZVNMpMi7Eyb9+5ups3kGRfcyYgv72SRJXk9rVfEQHTyP0+k3sJK2KlnQ7HN/We
         xgUQ==
X-Gm-Message-State: ACrzQf0QwiRZywDBFkQ+1l7XI0MunExT8PstTXLSGMCBCBe+3EIhK+mL
        vvsUhcQMvbq8pcC92xBax8+F+2Ln96FDj93lcGvAYawDbEM=
X-Google-Smtp-Source: AMsMyM5AhFQPWj0G1zKIlny9UQXqxnjwXkgrJjLP8smAZo1SC9IQLZe2S4sLw3YEQ/3f3afhjaSJg5XJOXLChA0BZyc=
X-Received: by 2002:a05:6130:c13:b0:39f:58bb:d51c with SMTP id
 cg19-20020a0561300c1300b0039f58bbd51cmr4037632uab.104.1664520182660; Thu, 29
 Sep 2022 23:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220929132549.56452-1-bagasdotme@gmail.com>
In-Reply-To: <20220929132549.56452-1-bagasdotme@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 30 Sep 2022 14:42:50 +0800
Message-ID: <CABVgOSkT-EWLqr6R=RvbEgmkMAY0680YbRnEBg1un6h-=TzrUg@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: rewrite writing first test instructions
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003a685605e9df4e59"
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

--0000000000003a685605e9df4e59
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 29, 2022 at 9:26 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> The wordings of step-by-step instructions on writing the first Kunit test
> are instructing readers to write codes without knowing what these are about.
> Rewrite these instructions to include the purpose of written code.
>
> While at it, align the code blocks of these contents.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Changes since v1 [1]:
>
>    - Fix jumped list numbering on writing the feature
>
>  This patch is based on Khalid's full path to .kunitconfig patch [2].
>
>  [1]: https://lore.kernel.org/linux-doc/20220929125458.52979-1-bagasdotme@gmail.com/
>  [2]: https://lore.kernel.org/linux-doc/20220929085332.4155-1-khalid.masum.92@gmail.com/
>

While I like the idea behind this, the wording probably needs a bit of
tweaking. In addition, by describing everything in too much detail, I
fear we might just be adding some needless redundancy. My suspicion is
that everyone who's going to be writing KUnit tests already knows C
(or has access to better learning materials than this), so we're
unlikely to need to describe in detail that, e.g., misc_example_add()
adds two numbers together when the code is right there,

Also, I preferred v1 of the full path to .kunitconfig patch, so this
will need rebasing on top of whatever the final version of that turns
out to be.

In any case, further notes are inline, below.

Cheers,
-- David

>  Documentation/dev-tools/kunit/start.rst | 40 ++++++++++++++-----------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index 7999874dc4ddb3..c0a5adf6d8d665 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -131,17 +131,19 @@ are built-in. Otherwise the module will need to be loaded.
>
>  Writing Your First Test
>  =======================
> -In your kernel repository, let's add some code that we can test.
> +In your kernel repository, let's add some code that we can test. For this
> +purpose, we are going to add simple addition driver.

A few issues here:
1. This should be "add _a_ simple addition driver".
2. That being said, I think we could simplify this further, and just
have "let's add a function to test, which adds two numbers together
and lives in its own driver.
3. This is an existing issue, but could we use "In _the_ kernel
repository" or "In _our_ kernel repository" to better match "let's"?

>
> -1. Create a file ``drivers/misc/example.h``, which includes:
> +1. Write the feature that will be tested. First, write the declaration
> +   for ``misc_example_add()`` in ``drivers/misc/example.h``:

As noted above, I think this is starting to verge on needless
redundancy here. I also think there was some benefit in pointing out
that this file is new, so needs to be created.

>
> -.. code-block:: c
> +   .. code-block:: c

Why are all of these code-block declarations being indented? It
doesn't seem to affect the actual documentation build, so I guess it's
harmless, but it'd be better not to have it change unnecessarily and
clutter up the diff.

>
>         int misc_example_add(int left, int right);
>
> -2. Create a file ``drivers/misc/example.c``, which includes:
> +   Then implement the function in ``drivers/misc/example.c``:

>
> -.. code-block:: c
> +   .. code-block:: c

Again, code-block indentation?

>
>         #include <linux/errno.h>
>
> @@ -152,24 +154,25 @@ In your kernel repository, let's add some code that we can test.
>                 return left + right;
>         }
>
> -3. Add the following lines to ``drivers/misc/Kconfig``:
> +2. Add Kconfig menu entry for the feature to ``drivers/misc/Kconfig``:

This needs rewording to add back an article ("a" or "the"), and we
probably want to call this a "Kconfig entry" rather than a "Kconfig
menu entry". Maybe "Add a Kconfig entry for the driver..."?

>
> -.. code-block:: kconfig
> +   .. code-block:: kconfig

Indentation again?

>
>         config MISC_EXAMPLE
>                 bool "My example"
>
> -4. Add the following lines to ``drivers/misc/Makefile``:
> +3. Add the kbuild goal that will build the feature to
> +   ``drivers/misc/Makefile``:

Kbuild goal? I've never heard of this being called a Kbuild goal before?

How about a "make target"?

>
> -.. code-block:: make
> +   .. code-block:: make

Indentation?

>
>         obj-$(CONFIG_MISC_EXAMPLE) += example.o
>
>  Now we are ready to write the test cases.
>
> -1. Add the below test case in ``drivers/misc/example_test.c``:
> +1. Write the test in ``drivers/misc/example_test.c``:

I really like this one!

>
> -.. code-block:: c
> +   .. code-block:: c

Indentation.

>
>         #include <kunit/test.h>
>         #include "example.h"
> @@ -202,31 +205,32 @@ Now we are ready to write the test cases.
>         };
>         kunit_test_suite(misc_example_test_suite);
>
> -2. Add the following lines to ``drivers/misc/Kconfig``:
> +2. Add following Kconfig entry for the test to ``drivers/misc/Kconfig``:

"Add _the_ following Kconfig entry".

>
> -.. code-block:: kconfig
> +   .. code-block:: kconfig

Indentation?

>
>         config MISC_EXAMPLE_TEST
>                 tristate "Test for my example" if !KUNIT_ALL_TESTS
>                 depends on MISC_EXAMPLE && KUNIT=y
>                 default KUNIT_ALL_TESTS
>
> -3. Add the following lines to ``drivers/misc/Makefile``:
> +3. Add kbuild goal of the test to ``drivers/misc/Makefile``:

Add a "make target" for the test?

>
> -.. code-block:: make
> +   .. code-block:: make

Indentation?

>
>         obj-$(CONFIG_MISC_EXAMPLE_TEST) += example_test.o
>
> -4. Add following configuration fragments to ``.kunit/.kunitconfig``:
> +4. Add following configuration fragments for the test to
> +   ``.kunit/.kunitconfig``:

"Add _the_ following".

I still slightly prefer "config entries" or similar here...

>
> -.. code-block:: none
> +   .. code-block:: none

Indentation?

>
>         CONFIG_MISC_EXAMPLE=y
>         CONFIG_MISC_EXAMPLE_TEST=y
>
>  5. Run the test:
>
> -.. code-block:: bash
> +   .. code-block:: bash

Indentation?

>
>         ./tools/testing/kunit/kunit.py run
>
> --
> An old man doll... just what I always wanted! - Clara
>

--0000000000003a685605e9df4e59
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAG
lV6N4Zh2x02+VuseC7zOZ4LfHqfJhbSnnDgIdZsz2jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA5MzAwNjQzMDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAC6baXarQUlzjxsHnPpqu
S90jrcH9jQKiB2r3e3uK/ip4dXaqUBCx7QMHHkQLa3EH+Unqu9P4OzNXEDUZ2TJGPQnvHs7IJuSh
ZV+jxA9PjrulC9/8p0YcGmHYialO/aT5XecA4nxdGY1MmZ3k2wfV2mvbuYHuvD1QGtPtHP+KZEZT
qx5EhsaG77seVoih7RXgsqRXsnwuPs8jBRdgM3UiNm20/4vQvHyMcJiChaVUyu7wcUGb7id0GjyT
rxcCsakNGSRWiYUvkZ8RhD7ryAdD0u4iY6MpgvdaH1haFW20yvZ09vV4qTgcEn/Rc6sKtJ6U0dJh
ncVCY1lvxaC0BSUCzQ==
--0000000000003a685605e9df4e59--
