Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965F3591921
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Aug 2022 09:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbiHMHE1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 Aug 2022 03:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiHMHEW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 Aug 2022 03:04:22 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7512C128
        for <linux-kselftest@vger.kernel.org>; Sat, 13 Aug 2022 00:04:20 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id v128so2766018vsb.10
        for <linux-kselftest@vger.kernel.org>; Sat, 13 Aug 2022 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=S3/qXGg6fVArXgOELPUc71mkvyZ+/F8m+2U3NmTyoTE=;
        b=gPfxUt9l8kEcZgSnzhnoAoRUtRQV/65Ese1TQJkn2/kuV5vnS8ZAnxKrU+63GoNdeW
         C0E/bhqp84FiXwNQGHizF+Taxx6VpN3mtNmYDQcBoByq1XcAZaR1M76eBz2N1EebQsg/
         xXd/dQrUHDvpnuHM/Quv8blhRpwvgVeEEmcWh/mcOOWopYPSqbzxZ2vElqSx/sL5gZ7L
         3/5sKIL0hOH638IRGQIi7Qi9099hHfgB8VDJwsEmolGBjp5DdVFXJWkFO+FZ4kGGGycl
         bghOtailNE+JN8vtWKZuyGDgzgqi0zQdGiTuBN25QYs0lNyIoU6zc9BFmjT20MT5NCRW
         EGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=S3/qXGg6fVArXgOELPUc71mkvyZ+/F8m+2U3NmTyoTE=;
        b=m1zaXsxPm5DMFj/CpR/9vVULqo9TjcYV7ty7gajsDI4Z1jBM9Cf+/5T95Th0Zzgm2D
         gmFroQPbpPZodf/NC++mq+dYQfO3qOJi/E61KlwtL7QOIbjIu+gucK80rDy0Z+S6kQSc
         q2RIbLDWxqX2bc+zHd2ij0MFMr+mOIucVovEQwuKhP560YBpYl/t1HH5As5mQ4GUu4En
         PKXyCmmpDsXVxIVW/CIPghY+9bJyHa+LHCDb2XOdOPTFRrGFuH/lNpRClFczSAzmPiQn
         vJKRrGOXPj1AMVMRpeoY/a7zeEvZLb485Tu0Vi9WiVmb57ueDZGRuiR5hiltYy7QZUMp
         EN2g==
X-Gm-Message-State: ACgBeo0HOgnVrQiEAQ8p3SiXRGhq0o4tFzZUdmTVePb4aRFZvYWLA0UM
        bVI1YeoPzI+o3cb8HjzebrAF5FjBdgRuLrxvCI+Ddg==
X-Google-Smtp-Source: AA6agR6H6wmd/1vr/oN1Pq+KeYmC576ZBGz5G/43a7RU2f/n2IpyBIV3/JV89JOLJEOFZ4PSBxfs3oA5dSjR8JWSBr4=
X-Received: by 2002:a67:cb0c:0:b0:357:9897:32d4 with SMTP id
 b12-20020a67cb0c000000b00357989732d4mr3306231vsl.18.1660374259512; Sat, 13
 Aug 2022 00:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220813042055.136832-1-tales.aparecida@gmail.com> <20220813042055.136832-4-tales.aparecida@gmail.com>
In-Reply-To: <20220813042055.136832-4-tales.aparecida@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 13 Aug 2022 15:04:08 +0800
Message-ID: <CABVgOSmQwAF5KROoK1DfZ8deeqBFL+SH57F4W=TO_qEeysoWPA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Documentation: KUnit: Fix non-uml anchor
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f2ee7505e61a01dd"
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

--000000000000f2ee7505e61a01dd
Content-Type: text/plain; charset="UTF-8"

On Sat, Aug 13, 2022 at 12:21 PM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> The section was rewritten but its anchor got left behind.
> Fix the anchor and add some references to running on QEMU.
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---

Thanks very much for fixing these. This is something we tried to clean
up last year when Qemu support happened, and we definitely missed
these bits.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  Documentation/dev-tools/kunit/faq.rst         | 6 +++---
>  Documentation/dev-tools/kunit/run_wrapper.rst | 2 ++
>  Documentation/dev-tools/kunit/usage.rst       | 4 ++--
>  3 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
> index 172e239791a8..f1b4cef68ced 100644
> --- a/Documentation/dev-tools/kunit/faq.rst
> +++ b/Documentation/dev-tools/kunit/faq.rst
> @@ -31,7 +31,8 @@ For the most part, the KUnit core framework (what we use to write the tests)
>  can compile to any architecture. It compiles like just another part of the
>  kernel and runs when the kernel boots, or when built as a module, when the
>  module is loaded.  However, there is infrastructure, like the KUnit Wrapper
> -(``tools/testing/kunit/kunit.py``) that does not support other architectures.
> +(``tools/testing/kunit/kunit.py``) that might not support some architectures
> +(see :ref:`kunit-on-qemu`).
>
>  In short, yes, you can run KUnit on other architectures, but it might require
>  more work than using KUnit on UML.
> @@ -95,8 +96,7 @@ things to try.
>     seeing. When tests are built-in, they will execute when the kernel boots, and
>     modules will automatically execute associated tests when loaded. Test results
>     can be collected from ``/sys/kernel/debug/kunit/<test suite>/results``, and
> -   can be parsed with ``kunit.py parse``. For more details, see "KUnit on
> -   non-UML architectures" in Documentation/dev-tools/kunit/usage.rst.
> +   can be parsed with ``kunit.py parse``. For more details, see :ref:`kunit-on-qemu`.
>
>  If none of the above tricks help, you are always welcome to email any issues to
>  kunit-dev@googlegroups.com.
> diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
> index db1e867820e7..a1070def284f 100644
> --- a/Documentation/dev-tools/kunit/run_wrapper.rst
> +++ b/Documentation/dev-tools/kunit/run_wrapper.rst
> @@ -165,6 +165,8 @@ example: if we only want to run KUnit resource tests, use:
>
>  This uses the standard glob format with wildcard characters.
>
> +.. _kunit-on-qemu:
> +
>  Run Tests on qemu
>  =================
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 44158eecb51e..2737863ef365 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -165,6 +165,8 @@ built as a module).
>
>  For more information, see Documentation/dev-tools/kunit/api/test.rst.
>
> +.. _kunit-on-non-uml:
> +
>  Writing Tests For Other Architectures
>  -------------------------------------
>
> @@ -544,8 +546,6 @@ By reusing the same ``cases`` array from above, we can write the test as a
>                 {}
>         };
>
> -.. _kunit-on-non-uml:
> -
>  Exiting Early on Failed Expectations
>  ------------------------------------
>
> --
> 2.37.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220813042055.136832-4-tales.aparecida%40gmail.com.

--000000000000f2ee7505e61a01dd
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB7
DepSVt3P8x7LekVKJAId51GRdU+bESYTp3/RcC/6wTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MTMwNzA0MTlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAX7IoUN2TnR5qyh8IikgA
Vh2HzgNRO1i0O5SlcbiBarMeUyGkDmC39D0a7IhmpiGKhOAem/aMvKN1G1TxTMT9zs6dNgTeJj6Q
e4WLOB8lVjqT6Yi9sZvpe+0xnHaL+6uBm1WxB50nCWVJ7MC8Xl30DfXfZIT+DCFu6giF/qsuCAPy
Zy/If4TdBKTFROoc0AhC/dkTbT7Q4P07zNGjN5Xw5nIQmulD78pMzktLpikHnapWA/yJAnh1rTm5
h9iFMgTlb4Txry+SJvG8q6OB9dn2kjdYiJLjZQdtetX5bgpWKxK5fXzLiMRmZk+wod4Twk6ROuU1
C7KgfrIEnqyq3kTm/Q==
--000000000000f2ee7505e61a01dd--
