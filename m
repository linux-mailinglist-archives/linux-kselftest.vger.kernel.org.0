Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC7A4B076A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 08:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiBJHoV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 02:44:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbiBJHoV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 02:44:21 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE339D71
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 23:44:22 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so3323144wmb.0
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Feb 2022 23:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pu9C/HKumjt8wOQlox6eqWtQF6Dli2eIhKICoSgh4is=;
        b=A3IOA22M725pjiPO6NHnHLOlid2R+LchYjVU+hZQAbRi+mWndkzE0ArQ3IhFTS6vyE
         PmJljEbI08+BxK+Wfe4RDwPO+71WxIV2SaxVE5exBuG3dir/jeUIsPM6XvlgLVrsJT1+
         0mpJ2OHN6W5yIG522TnMX/nOLAdCw6DzhSwOoRyT7nKoqHOmhY4Odj+p0Whp6Bt6l3Xb
         6wrC8qO0ylvOFn4gz/2wSa0Kmh1R3OgcPV0GvJ7wfOpMZ8ui7TfKIKSz8Y7OZAb/xxYH
         9GgCOLeHmrn5H/2ZYD5bLbKEOKM/dS22VYPF+S4OUkd3TdfzCRhs80IqXjy36Qq3AQ0W
         ukwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pu9C/HKumjt8wOQlox6eqWtQF6Dli2eIhKICoSgh4is=;
        b=GMKwgctegN1ZamZfzNRx8libauKHLxnEoJ5rvC351Rdno+07l/6k95WNW1qzJ+Iy+e
         q3jkXgWJfZBiMq96trHqY57PCGRY3c5ZJj4vFlj6MNGA26hnkFlx8t7CEzshn8+XFh71
         lehzM6IFJ9+p0/9LJ8yqBlCduIj977/YoHcKqOhs+Rm9rcwIBj+zTxsdpagR2t5i8P1V
         4Qg1E0PVNSYeHAh+TdPNZ/grp43rcpzhMxCl4niwshcPQiYCu2h8+7Q7i9rJB1bBMYMu
         4xUU1Jjbyah1H1eLlYwGK8K1N3QlduhAgddEDjKAD08jF6ak75X5IjT/upj50GtQWudh
         r1dg==
X-Gm-Message-State: AOAM533jyDYz3UOKCehq8jaC1eMKCL5DCzCwZ4nlKXZkidOs2bwxS2Bs
        7jLAVD30pRQw+oyjPzJRDl1iOUrBYjp1khkqLSqR3A==
X-Google-Smtp-Source: ABdhPJyhLYkrXk39sK1hvxKDUFbbN1uTu0jDZJk2blsOuNGThdImEGE3IyzmwnaYTv8HMQlM6O50yYgfMyJmqkeqg1A=
X-Received: by 2002:a05:600c:350e:: with SMTP id h14mr1025507wmq.166.1644479061243;
 Wed, 09 Feb 2022 23:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20220210023519.3221051-1-frowand.list@gmail.com> <20220210023519.3221051-3-frowand.list@gmail.com>
In-Reply-To: <20220210023519.3221051-3-frowand.list@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 10 Feb 2022 15:44:10 +0800
Message-ID: <CABVgOSkwCtPiqF-OG=mQqcaPqhM=-cBKwXV=sbT_ig1pRCNgcQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] Documentation: dev-tools: fix KTAP specification
 build warnings
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Daniel Latypov <dlatypov@google.com>, kernelci@groups.io,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004fccdb05d7a51ed9"
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

--0000000000004fccdb05d7a51ed9
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 10, 2022 at 10:35 AM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Convert "Major differences between TAP and KTAP" from a bullet list
> to a table.  The bullet list was being formatted as a single
> paragraph.
>
> Add missing required argument in code-block directives.
>
> ---
>
> Table conversion suggested by Shuah.
>
> Patch 2/2 not previously reviewed, so Reviewed-by tags not provided.
>
> Changes since version 3
>   - Add this commit (patch 2/2) to the series
>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---

The table looks good to me, the "none" argument in code-block
directives is already fixed in another patch.

The table bits are:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/ktap.rst | 33 +++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
> index dfb3f10a8b2d..5ee735c6687f 100644
> --- a/Documentation/dev-tools/ktap.rst
> +++ b/Documentation/dev-tools/ktap.rst
> @@ -68,7 +68,7 @@ Test case result lines
>  Test case result lines indicate the final status of a test.
>  They are required and must have the format:
>
> -.. code-block::
> +.. code-block:: none

These code-block changes were already submitted in:
https://lore.kernel.org/lkml/20220131003637.14274-1-rdunlap@infradead.org/T/


>
>         <result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
>
> @@ -117,32 +117,32 @@ separator.
>
>  Example result lines include:
>
> -.. code-block::
> +.. code-block:: none
>
>         ok 1 test_case_name
>
>  The test "test_case_name" passed.
>
> -.. code-block::
> +.. code-block:: none
>
>         not ok 1 test_case_name
>
>  The test "test_case_name" failed.
>
> -.. code-block::
> +.. code-block:: none
>
>         ok 1 test # SKIP necessary dependency unavailable
>
>  The test "test" was SKIPPED with the diagnostic message "necessary dependency
>  unavailable".
>
> -.. code-block::
> +.. code-block:: none
>
>         not ok 1 test # TIMEOUT 30 seconds
>
>  The test "test" timed out, with diagnostic data "30 seconds".
>
> -.. code-block::
> +.. code-block:: none
>
>         ok 5 check return code # rcode=0
>
> @@ -202,7 +202,7 @@ allowed to be either indented or not indented.
>
>  An example of a test with two nested subtests:
>
> -.. code-block::
> +.. code-block:: none
>
>         KTAP version 1
>         1..1
> @@ -215,7 +215,7 @@ An example of a test with two nested subtests:
>
>  An example format with multiple levels of nested testing:
>
> -.. code-block::
> +.. code-block:: none
>
>         KTAP version 1
>         1..2
> @@ -234,12 +234,15 @@ An example format with multiple levels of nested testing:
>  Major differences between TAP and KTAP
>  --------------------------------------
>
> -Note the major differences between the TAP and KTAP specification:
> -- yaml and json are not recommended in KTAP diagnostic messages
> -- TODO directive not recognized in KTAP
> -- KTAP allows for an arbitrary number of tests to be nested
> -- TAP includes "Unknown lines" in the category of "Anything else"
> -- TAP says "Unknown lines" are "incorrect"; KTAP allows "Unknown lines"
> +==================================================   =========  ===============
> +Feature                                              TAP        KTAP
> +==================================================   =========  ===============
> +yaml and json in diagnosic message                   ok         not recommended
> +TODO directive                                       ok         not recognized
> +allows an arbitrary number of tests to be nested     no         yes
> +"Unknown lines" are in category of "Anything else"   yes        no
> +"Unknown lines" are                                  incorrect  allowed
> +==================================================   =========  ===============

This looks good to me, thanks!

>
>  The TAP14 specification does permit nested tests, but instead of using another
>  nested version line, uses a line of the form
> @@ -247,7 +250,7 @@ nested version line, uses a line of the form
>
>  Example KTAP output
>  --------------------
> -.. code-block::
> +.. code-block:: none
>
>         KTAP version 1
>         1..1
> --
> Frank Rowand <frank.rowand@sony.com>
>

--0000000000004fccdb05d7a51ed9
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
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAW
Uj6y8rnjHScNV9crl9BF8jYJPpYgSlKxMNrUGc39EzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAyMTAwNzQ0MjFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAd2lwnOLWnINHsP+066rx
jpvDD7q9H9RCwMKtjD0EyAeUT+LHs4AzuVmDDKSubKWqZAnaitgeY+cDau2kUh4a///VlGcFka+v
CEUAT1JuPve6nwxmjzBupgqhMI7mpIy9DKs0wniJKAAgM/a2Kj6snSMiLNIROFzstIyV4qaEc7Zc
2jCur5ydx4WZZkmaWDQkb9E05QVBSuwdd7VxGynCDa8R98XvUAKWayn9UjlsqJEkDv8FA2Ak5K4N
xZg0k8oBgGblQ4Gf15yVnoLi1jwaUaIhxFdW7V6D7Yo6gIcSPtVBx0N4Nux2YNV/KKltS8AT6eMy
qWalnuPWwkqFIfjNzw==
--0000000000004fccdb05d7a51ed9--
