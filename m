Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0654AD20A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 08:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347963AbiBHHRa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 02:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347960AbiBHHR3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 02:17:29 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F541C0401F2
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 23:17:27 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r131so5915547wma.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 23:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxAv/cQGmyL3We1NKWE7yS2G3w67ORuTqCLok6KSDZ0=;
        b=cOQyyuU6zf10X00pB4kZnDf+XtYWFUawyuOa9NZ9tQfU0CPVpV62++xO/n8d7l6HgL
         0Cw4JLSllLr8Guy8pj4kBLgpuZC7+3AlP5Q92CwR3AA4MForJWDA/kYQf+zAy8WeDiVM
         fHSz81Q2hXxJ9vCqB9LqDhv1yI94qGng2P9PFNb18mxB9eKx3zzNxSQTh6XAS7fcDRYz
         Abp0m8yWotNk/1TYMXjMOUrWIdxxytDmig7bv9x4Hns0+LN5dD01FphM5pJ7WI1Mx9R7
         mwUpITCjPgS2IQQ6ZoMtEiRV0oCc/B4eUFaeG31BD+/RXMqhW1kBBGwYvkTCLnXcZvIJ
         tb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxAv/cQGmyL3We1NKWE7yS2G3w67ORuTqCLok6KSDZ0=;
        b=BPwHXFulA+PFNHfU2tRZn/I4vtkptoS1mAou7TmP3POIRLqwNEVf9z+ZSp2VHiV6Q9
         pwQ+oaCvc0VDHb/jVnE3lNGUg7FOi8V4MeqlHuk1pZlsxWY77qEHHCPyC66ZGdH6jiyk
         Z/baKwWvdc8qc2uzfP6gMG6q83DHIYjQOTsK/O1oF3rcZsDw5/yusWWIQRYZ/zBg4ujY
         wtS/c8pXW57oFcN3EPsYiV2tQNUWJsh3zhsIr+pLWomKFzsOK2kjbrBKWcN+1w8bHiRG
         Rx0h9iK4yHmmSDnAIWv/YYTNtx4Q8dKoZ+RKCCz4k1gLOW8mXBA+83lSGlaJkpbnEdCI
         EYgA==
X-Gm-Message-State: AOAM531xRbhoC1w5vQwODJPBGt3Tf2CVq1lhOT4xeQyjQIPofwwLtKzQ
        6FBJJ0tv6OE6kTBMnh99zm8zrRmU/A3YG7rqWN1T3w==
X-Google-Smtp-Source: ABdhPJw6CwqYZNijjCXuMKPfy81z2jcWqGougNDD5v8t/jmD9m7usDyqgokKfQyZPPSlwLzh3Tmvs17+eBbrB3JE0Y8=
X-Received: by 2002:a7b:cb8a:: with SMTP id m10mr84612wmi.39.1644304645728;
 Mon, 07 Feb 2022 23:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20220207162813.3091899-1-frowand.list@gmail.com>
In-Reply-To: <20220207162813.3091899-1-frowand.list@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 8 Feb 2022 15:17:14 +0800
Message-ID: <CABVgOSn3qVWUPAc8A6bKpt19OAsh5YXD=R1_OZKoSijB8v4+Rg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Documentation: dev-tools: clarify KTAP
 specification wording
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
        boundary="00000000000055f56305d77c8245"
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

--00000000000055f56305d77c8245
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 8, 2022 at 12:28 AM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Add the spec version to the title line.
>
> Explain likely source of "Unknown lines".
>
> "Unknown lines" in nested tests are optionally indented.
>
> Add "Unknown lines" items to differences between TAP & KTAP list
>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---

Thanks for fixing this. I'm happy with this version.

Reviewed-by: David Gow <davidgow@google.com>

>
> Changes since version 1
>   - Explain likely source of "Unknown lines"
>   - "Unknown line" in nested tests are optionally indented
>   - Add "Unknown lines" items to differences between TAP & KTAP list
>
>  Documentation/dev-tools/ktap.rst | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
> index 878530cb9c27..9c40c94d3f12 100644
> --- a/Documentation/dev-tools/ktap.rst
> +++ b/Documentation/dev-tools/ktap.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0
>
> -========================================
> -The Kernel Test Anything Protocol (KTAP)
> -========================================
> +===================================================
> +The Kernel Test Anything Protocol (KTAP), version 1
> +===================================================
>
>  TAP, or the Test Anything Protocol is a format for specifying test results used
>  by a number of projects. It's website and specification are found at this `link
> @@ -174,6 +174,13 @@ There may be lines within KTAP output that do not follow the format of one of
>  the four formats for lines described above. This is allowed, however, they will
>  not influence the status of the tests.
>
> +This is an important difference from TAP.  Kernel tests may print messages
> +to the system console or a log file.  Both of these destinations may contain
> +messages either from unrelated kernel or userspace activity, or kernel
> +messages from non-test code that is invoked by the test.  The kernel code
> +invoked by the test likely is not aware that a test is in progress and
> +thus can not print the message as a diagnostic message.
> +
>  Nested tests
>  ------------
>
> @@ -186,10 +193,13 @@ starting with another KTAP version line and test plan, and end with the overall
>  result. If one of the subtests fail, for example, the parent test should also
>  fail.
>
> -Additionally, all result lines in a subtest should be indented. One level of
> +Additionally, all lines in a subtest should be indented. One level of
>  indentation is two spaces: "  ". The indentation should begin at the version
>  line and should end before the parent test's result line.
>
> +"Unknown lines" are not considered to be lines in a subtest and thus are
> +allowed to be either indented or not indented.
> +
>  An example of a test with two nested subtests:
>
>  .. code-block::
> @@ -225,9 +235,11 @@ Major differences between TAP and KTAP
>  --------------------------------------
>
>  Note the major differences between the TAP and KTAP specification:
> -- yaml and json are not recommended in diagnostic messages
> -- TODO directive not recognized
> +- yaml and json are not recommended in KTAP diagnostic messages
> +- TODO directive not recognized in KTAP
>  - KTAP allows for an arbitrary number of tests to be nested
> +- TAP includes "Unknown lines" in the category of "Anything else"
> +- TAP says "Unknown lines" are "incorrect; KTAP allows "Unknown lines"

Nit: unmached quotes around "incorrect".

>
>  The TAP14 specification does permit nested tests, but instead of using another
>  nested version line, uses a line of the form
> --
> Frank Rowand <frank.rowand@sony.com>
>

--00000000000055f56305d77c8245
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAl
/ZZBLrQNgOa5ykcrp+FqVN8NbT1wvYwCWWqNyO+WdjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAyMDgwNzE3MjZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAc+LcDqo6IolbyUgbgGaJ
1LcISX9ZwiKgUmKNtJE8HBF8tGusZVsDooy1j/POloAr8KZ9oqdO8U9+OghkQZVZh4EZo9l70UZP
AlvuJD4Z/82D6bcnLricyF8j72hbn3ZixNKLMQaxBeIoxw7WjjYpCZsBQsdfZt7IrWDuur04rRIq
+LuThVqMyz9tmv4v2Cyrrnw8VE/MXbskMKryqfgu0OslWRQfwq1d8DwJMcFksIL+TvdVknxXI113
cKegBGjh+9Lv8nXYQDDge0cLrBaUTRQLdqkhzLKGvEbJEVLZST9Y4iLSuhfvZTnMtHGNcvwAVYgY
G6xll4Ag2hqj4sYSfw==
--00000000000055f56305d77c8245--
