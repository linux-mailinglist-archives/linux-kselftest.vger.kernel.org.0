Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B823F630D37
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Nov 2022 09:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKSIRL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Nov 2022 03:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiKSIRK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Nov 2022 03:17:10 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBA88FFB7
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Nov 2022 00:17:09 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id l190so6833040vsc.10
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Nov 2022 00:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OzBWvQUHDyMVbEAfvkkJtF75VcEXTDKIMsY/ugedrN8=;
        b=dvh7nu6MRojLTX2RzGIJIEra1h+2WJA8+ZSQSjvwwB8FVJm07OogqM2PbeWoZLUOPY
         797pXDa6wLSe6k0B7DfCnxJk1thrx/ib/6j09i94DmEGUGY+BKq7aQGBUUb65Kxu44dB
         gWjDQY10KN+N0D6+Odnx2EaTj/Wk4hr41mCrtxs2hKJTyJr1v61lpNzUpUZAVfX1Wxw/
         oPh2FciwIZwKVkNI/QWMg4kjAy9ayMs+a05L4e3qbbAc9onkXt+dnBIPjwvtN03WUpLB
         agx6fK2N01AM/WN0/Akh/Lw3mV53OvPpum8u2ztlZnQNJkaIi7LTYwPZ6/AlaWp7BpQ5
         SEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzBWvQUHDyMVbEAfvkkJtF75VcEXTDKIMsY/ugedrN8=;
        b=PA9qsIkjWkpViWvl/FEhKzRuYeiCBSgXWx4k904hrtkWe03Ezj9aVLlBwJKpCqZdQE
         XjoDEgsYDio5JdAVWf/he4ho3H1YW2WEQW57Ou9DDTxqERpSabUgHS0B+ZSKRhJyIJg8
         NNjemYeOvzTn+g1AzcHET3+zA6cfloKgDbCvu9e9qcAIEQxlKYO/N+IpL9DwHYn6X1Bo
         dnv79+l0KHtOh0+ciXUmahsAMp/U490mCnlTYLG2UtnT0m531H3b3tZISBWFAxOJOKly
         /4GAMkY9QdE76LvG6S/+Zw43Tb/OgQ+AUE2x3gzDvtEWlXSRszNsUa/VvB6StF9lOgGp
         3Xdg==
X-Gm-Message-State: ANoB5pnal8pnimAPpl+sERBozwWIInuOBQrRVpNkCcmOEdcYUiw9/IZa
        aj85ridKl2F/emTMQtibzkhBFTYGAT21EUbCDloJLg==
X-Google-Smtp-Source: AA0mqf4WHyNazwFcoPPRjM3TBEt7OKLzq8pEf3GEP7+iXsDS3wnG2VnKIIbzn5A+oU9XHTGSuycAeQxl4MpySYFeunA=
X-Received: by 2002:a05:6102:c0d:b0:3af:2b1c:9908 with SMTP id
 x13-20020a0561020c0d00b003af2b1c9908mr6600739vss.18.1668845828149; Sat, 19
 Nov 2022 00:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20221111182906.1377191-1-dlatypov@google.com>
In-Reply-To: <20221111182906.1377191-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 19 Nov 2022 16:16:56 +0800
Message-ID: <CABVgOSmKzmnPbfrHfHmG5uBdBL6xOy7et-uGJCF_8Mi2p30wgQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] Documentation: KUnit: make usage.rst a superset of
 tips.rst, remove duplication
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        skhan@linuxfoundation.org, Sadiya Kazi <sadiyakazi@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ca16e605edce72a3"
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

--000000000000ca16e605edce72a3
Content-Type: text/plain; charset="UTF-8"

On Sat, Nov 12, 2022 at 2:29 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> usage.rst had most of the content of the tips.rst page copied over.
> But it's missing https://www.kernel.org/doc/html/v6.0/dev-tools/kunit/tips.html#customizing-error-messages
> Copy it over so we can retire tips.rst w/o losing content.
>
> And in that process, it also gained a duplicate section about how
> KUNIT_ASSERT_*() exit the test case early. Remove that.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>
> ---

Looks good to me, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/kunit/usage.rst | 49 ++++++++++++++++---------
>  1 file changed, 31 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 2737863ef365..b0a6c3bc0eeb 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -118,6 +118,37 @@ expectation could crash the test case. `ASSERT_NOT_ERR_OR_NULL(...)` allows us
>  to bail out of the test case if the appropriate conditions are not satisfied to
>  complete the test.
>
> +Customizing error messages
> +--------------------------
> +
> +Each of the ``KUNIT_EXPECT`` and ``KUNIT_ASSERT`` macros have a ``_MSG``
> +variant.  These take a format string and arguments to provide additional
> +context to the automatically generated error messages.
> +
> +.. code-block:: c
> +
> +       char some_str[41];
> +       generate_sha1_hex_string(some_str);
> +
> +       /* Before. Not easy to tell why the test failed. */
> +       KUNIT_EXPECT_EQ(test, strlen(some_str), 40);
> +
> +       /* After. Now we see the offending string. */
> +       KUNIT_EXPECT_EQ_MSG(test, strlen(some_str), 40, "some_str='%s'", some_str);
> +
> +Alternatively, one can take full control over the error message by using
> +``KUNIT_FAIL()``, e.g.
> +
> +.. code-block:: c
> +
> +       /* Before */
> +       KUNIT_EXPECT_EQ(test, some_setup_function(), 0);
> +
> +       /* After: full control over the failure message. */
> +       if (some_setup_function())
> +               KUNIT_FAIL(test, "Failed to setup thing for testing");
> +
> +
>  Test Suites
>  ~~~~~~~~~~~
>
> @@ -546,24 +577,6 @@ By reusing the same ``cases`` array from above, we can write the test as a
>                 {}
>         };
>
> -Exiting Early on Failed Expectations
> -------------------------------------
> -
> -We can use ``KUNIT_EXPECT_EQ`` to mark the test as failed and continue
> -execution.  In some cases, it is unsafe to continue. We can use the
> -``KUNIT_ASSERT`` variant to exit on failure.
> -
> -.. code-block:: c
> -
> -       void example_test_user_alloc_function(struct kunit *test)
> -       {
> -               void *object = alloc_some_object_for_me();
> -
> -               /* Make sure we got a valid pointer back. */
> -               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, object);
> -               do_something_with_object(object);
> -       }
> -
>  Allocating Memory
>  -----------------
>
>
> base-commit: 870f63b7cd78d0055902d839a60408f7428b4e84
> --
> 2.38.1.431.g37b22c650d-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20221111182906.1377191-1-dlatypov%40google.com.

--000000000000ca16e605edce72a3
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBf
c3U5bwlAQdJs7z2b028n1ksiezfhaRgFUQHeWmbonDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMTkwODE3MDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAzGuQR6UqlZJHcUPVlQlY
4eSonGJ5z5DlzPwzHHFExHBshxGR3RNe+8h6A4w9GjvlKTzlp1T1KTwSvsyMnoibSIolA+lDevaR
PQaKtC1UwAP0d4mBd6/4RH/GePObsKwmk48DDUaAGtv6YQnuZOj+oC9Y/pJd7SsZmrLPIJ9Mwndo
lll0j6lsoa+FsQYHj5bcyJr5LSsE7gEqpWjWqI2cNNZ9M1/TUxG3zG2TnBgzL5KT7zRoyF0fSxMf
SA0ZP11i3UGCwoh0YZEa32R2/xuN4FcfL76N0cHR0oInKKAZdeDFdVAm5oxqW4OdnC0PSYxvnldU
v52sZodGTWGCc3OA2Q==
--000000000000ca16e605edce72a3--
