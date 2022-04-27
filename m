Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFB2510E6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 04:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356924AbiD0B7S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 21:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiD0B7S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 21:59:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AD926572
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 18:56:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k2so487330wrd.5
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 18:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1XITDKkKMXEvGR6wHSxQR7Dnn5vxvTdwOI+43boU+Y=;
        b=DvteIVsTERlPdq785HxdY/JHfpIa/Fn8EHOFFAicEgPikYPNXVP/bOXVcFUGNF2Eau
         zouMCMvVfKcfVIOxOjnYH/eeNa1i/RCsOJIfIyVM/GBBWsHv75e+geyXmlZO8LFWtzYQ
         UonIFACzW35DMrZPC/X8ZiUnvl6Pv3mmlHxXw5zxYJXfd/qw+5WtrrVEJBkbf8C5o5rw
         uc25VEQK1f1KSRL5UPyzEHrs7uU83qa/zOD6hAtPkGGgSxUGQgwuMgTcqLemMIVVP8aS
         g0Ctf+R2hvu9WY+G+y4ifkq2DbktdrH58XLtc3rDtBhexKawsynIgLPYK+ZshgZkuanY
         a0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1XITDKkKMXEvGR6wHSxQR7Dnn5vxvTdwOI+43boU+Y=;
        b=WTl14BlbOfMXGKIWQKABqTjEjl+DS7FsRQcYGUZq4+3ouAv5weJQO8MzRvgrUQbPCr
         Nkb02hK0ZYuxWPDtLWjhjTpq8PzucPhuE8HSxXSRRTwI8+m5gCJ1okvJ4SGkPheeWMuS
         vRXlPiLbVAmwPgb1a1X9DbiVFC30+lIyJZZiIRLjN8O3X6gYVz235es9Pk3Pth9EftYN
         dUUN6O5mGJZslSotKVSWhrDrAjv4A4fwK7nQng/GX4RjGF1Ee7zRs25weOGzkloEFFjr
         JgFA2swMmCNN0eu/VrucblLHR+rZtsCS7sIvdQtkUF5mIdVecOv7e6xxsQHzEhTPBqMX
         X+BQ==
X-Gm-Message-State: AOAM531B1F0q50Y+fZnT5RJi6OV6zie3axFT6Sv+4FDFOcg3IE6flB6I
        fK7O5mMfyZjg96THjGlXXie0t9WNLUIJ69QyqlVmQA==
X-Google-Smtp-Source: ABdhPJza1jDO1StoqkRTkPkEkKnqgyF+QJ8ONXV7V5Nd3lEtn/hD1OsNT7u4pPeBoW10gw0LBRlVhCKBsXvSruionWc=
X-Received: by 2002:a05:6000:18a6:b0:20a:e019:4e61 with SMTP id
 b6-20020a05600018a600b0020ae0194e61mr7794135wri.46.1651024565729; Tue, 26 Apr
 2022 18:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220426181925.3940286-1-dlatypov@google.com>
In-Reply-To: <20220426181925.3940286-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 27 Apr 2022 09:55:54 +0800
Message-ID: <CABVgOS=_yOGkCfh34K-tiqd4mdJD+gbJOmhurP9-8LouC2WUmQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: rename print_subtest_{start,end} for clarity (s/subtest/suite)
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c667e405dd991c3d"
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

--000000000000c667e405dd991c3d
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 27, 2022 at 2:19 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> These names sound more general than they are.
>
> The _end() function increments a `static int kunit_suite_counter`, so it
> can only safely be called on suites, aka top-level subtests.
> It would need to have a separate counter for each level of subtest to be
> generic enough.
>
> So rename it to make it clear it's only appropriate for suites.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Fair enough! This does make more sense now we have more complex hierarchies.

Reviewed-by: David Gow <davidgow@google.com>


>  lib/kunit/test.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 0f66c13d126e..64ee6a9d8003 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -134,7 +134,7 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
>  }
>  EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
>
> -static void kunit_print_subtest_start(struct kunit_suite *suite)
> +static void kunit_print_suite_start(struct kunit_suite *suite)
>  {
>         kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
>                   suite->name);
> @@ -192,7 +192,7 @@ EXPORT_SYMBOL_GPL(kunit_suite_has_succeeded);
>
>  static size_t kunit_suite_counter = 1;
>
> -static void kunit_print_subtest_end(struct kunit_suite *suite)
> +static void kunit_print_suite_end(struct kunit_suite *suite)
>  {
>         kunit_print_ok_not_ok((void *)suite, false,
>                               kunit_suite_has_succeeded(suite),
> @@ -498,7 +498,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>         struct kunit_result_stats suite_stats = { 0 };
>         struct kunit_result_stats total_stats = { 0 };
>
> -       kunit_print_subtest_start(suite);
> +       kunit_print_suite_start(suite);
>
>         kunit_suite_for_each_test_case(suite, test_case) {
>                 struct kunit test = { .param_value = NULL, .param_index = 0 };
> @@ -552,7 +552,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>         }
>
>         kunit_print_suite_stats(suite, suite_stats, total_stats);
> -       kunit_print_subtest_end(suite);
> +       kunit_print_suite_end(suite);
>
>         return 0;
>  }
>
> base-commit: 59729170afcd4900e08997a482467ffda8d88c7f
> --
> 2.36.0.rc2.479.g8af0fa9b8e-goog
>

--000000000000c667e405dd991c3d
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCi
X00byxnBqWojxnTIH4kdPRVU0zdFQKiShlT0sqVuATAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA0MjcwMTU2MDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAYNHvv9re4r4EzLOZZN0a
2tWOgTpgG1EkNiH1HHSIqhPys+rLztL3DT0bthl2aC6c7qX9NDf0Aen4U1EiIqPYvXBCpohB5JcO
cEHjbNW6m1rVe7lC5pSN11TWe/qCJsRSmFuPLnURZvaeRotsz2A71hMzdDjdgI1bKlBF6pn/16v6
WcPYS/DetgzG0KUytHipw4n+5i9FTi35lPE0KOMdHdTcK4h2ykgwnhlDc59z53oapf6nmTF761Ze
8nsUC99ebxcGL2I3MqpFU6tEDM23cWf5IWJtG8+UMFZVJKBZ/Mz4cgD2UYdRU89wielefMTpSG0/
z5CJoE2IZ0PFDgEPiA==
--000000000000c667e405dd991c3d--
