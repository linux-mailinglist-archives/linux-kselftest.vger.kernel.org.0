Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC29D760D5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjGYIoE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjGYIno (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:43:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394342697
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 01:42:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so58315e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 01:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690274564; x=1690879364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d49fj9dg2nqRAYZI4N+vd4XtWUI8Rzl72CuhEPv0nWk=;
        b=h76O3PraJL7t3a4lw2HpIs9Vf/PRzTOAbHCZLX2eCofTeZ/qCoTDr3Av7IWhIlNk4U
         2fFurVEe9BmYRWFrjUixyK30XX7nd7rAuUABYSTFlnvbQQF7iE1X7UqXlWQNX1CZ3ZD4
         zOQ3j5Sj+ZljcuBgEAYePo0t/WZSARELnmDzRNo4DzazwLEBHilc56vUlnGhUIdThDSi
         sbHFJwLBOtBDpylr5U/k8+NzpVuZ42aa3VhgjXfpVfnhj2vJmr6wykUMbW6ilB+Uw01T
         6Lom8iMikNeS9FJM/jgmicYY7m7LifwwvXnWnnvYwGp0NCBkCa93OtDYPsrQb80ykzVI
         OcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274564; x=1690879364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d49fj9dg2nqRAYZI4N+vd4XtWUI8Rzl72CuhEPv0nWk=;
        b=SV+fQdWFCdlwf07SCTvPbKMu6ibPqWjjoCj9v2hc/vsA4oGhkeAW65KYvW4QeDrEJB
         NjrYSTSbxc8QT2bxCRpcIgZ3bwVXmdJ5Dbr6E4r8rS+3q/WF5qtDmuJn9DDTLNqwyu+I
         qVs2EdDWpHpwLDI7kXqKpGeaGiiEtX8VnpNEsR/6G776RuNTK2UUpN8FBXGkr4nABvaV
         C6lpFTjGz5MqyeatoXq+F6+bQUNjK3eTOiQ2LmB51wWXvPTe7hwhYujQBCdtK6FWLRF0
         8uCq47asSEpZd+mv71qkSSVCR/2LlpDvt9fwz21Juvl2jxSpSQkAEZQZpeGZelzLWWuE
         7Fug==
X-Gm-Message-State: ABy/qLbYG7aM2xyd75I8/rTO3JWYONAwF5Agq22A7x7bOkEHQnIA4LSn
        /UuZoyO+dRCJyMi3idER63KBHWwnwtqTho9XC6KKPQ==
X-Google-Smtp-Source: APBJJlFWi3uSj4qBxNiNlxstKaMd84At700nIYnvwJMh6xXo0PwfmpiCAkUkqZMrFfm7wtQ/VM7WudEiaFj6pxWnk2w=
X-Received: by 2002:a05:600c:1d21:b0:3fd:e15:41e3 with SMTP id
 l33-20020a05600c1d2100b003fd0e1541e3mr52820wms.2.1690274563692; Tue, 25 Jul
 2023 01:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230724162834.1354164-1-rmoar@google.com> <20230724162834.1354164-7-rmoar@google.com>
In-Reply-To: <20230724162834.1354164-7-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 25 Jul 2023 16:42:30 +0800
Message-ID: <CABVgOSkQRSCX1yKeSnpdoWxbNu36oU7Ex1aPZRbbS4LQO8093A@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] kunit: memcpy: Mark tests as slow using test attributes
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f5c8cf06014bb6d7"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000f5c8cf06014bb6d7
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jul 2023 at 00:30, Rae Moar <rmoar@google.com> wrote:
>
> Mark slow memcpy KUnit tests using test attributes.
>
> Tests marked as slow are as follows: memcpy_large_test, memmove_test,
> memmove_large_test, and memmove_overlap_test. These tests were the slowest
> of the memcpy tests and relatively slower to most other KUnit tests. Most
> of these tests are already skipped when CONFIG_MEMCPY_SLOW_KUNIT_TEST is
> not enabled.
>
> These tests can now be filtered using the KUnit test attribute filtering
> feature. Example: --filter "speed>slow". This will run only the tests that
> have speeds faster than slow. The slow attribute will also be outputted in
> KTAP.
>
> Note: This patch is intended to replace the use of
> CONFIG_MEMCPY_SLOW_KUNIT_TEST and to potentially deprecate this feature.
> This patch does not remove the config option but does add a note to the
> config definition commenting on this future shift.
>
> Acked-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David

>
> Changes since v1:
> - No changes.
> Changes since RFC v2:
> - No changes.
> Changes since RFC v1:
> - Added note under CONFIG_MEMCPY_SLOW_KUNIT_TEST.
>
>  lib/Kconfig.debug  | 3 +++
>  lib/memcpy_kunit.c | 8 ++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 550cb967b668..1b3894e861f2 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2701,6 +2701,9 @@ config MEMCPY_SLOW_KUNIT_TEST
>           and bit ranges. These can be very slow, so they are split out
>           as a separate config, in case they need to be disabled.
>
> +         Note this config option will be replaced by the use of KUnit test
> +         attributes.
> +
>  config IS_SIGNED_TYPE_KUNIT_TEST
>         tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
>         depends on KUNIT
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 887926f04731..440aee705ccc 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -551,10 +551,10 @@ static void strtomem_test(struct kunit *test)
>  static struct kunit_case memcpy_test_cases[] = {
>         KUNIT_CASE(memset_test),
>         KUNIT_CASE(memcpy_test),
> -       KUNIT_CASE(memcpy_large_test),
> -       KUNIT_CASE(memmove_test),
> -       KUNIT_CASE(memmove_large_test),
> -       KUNIT_CASE(memmove_overlap_test),
> +       KUNIT_CASE_SLOW(memcpy_large_test),
> +       KUNIT_CASE_SLOW(memmove_test),
> +       KUNIT_CASE_SLOW(memmove_large_test),
> +       KUNIT_CASE_SLOW(memmove_overlap_test),
>         KUNIT_CASE(strtomem_test),
>         {}
>  };
> --
> 2.41.0.487.g6d72f3e995-goog
>

--000000000000f5c8cf06014bb6d7
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD5
9NX+J0SBxf7njXT7fCfO4ac4Tb4MsEC6/WwfSlkxJDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MjUwODQyNDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAIpRgNPRKmTViOZniB5FP
QG0IDSSoDbKaw5kze0ExU6QTcn2lJIAmVrPGT6ezUtxbWx0NjIrQDngS5XbCJ75/s2+gJQTdSEMS
Uo4/SLSmZiLL3Cu4F9lyOxFIYwARLx+dC3kajmU8WJ/vONvk6N2KsLW1F5zqxaxVDLn1SUz2Z/A2
9vQIWdQJt7E5touPB8fwa4iRbwQXO54jIbadOmjFxEUZMbqeBqPPIFSlMsRikF4bTodcusvl3tzI
9iHEHeRTBQzLiTd6bJVNeZhilklKIRsjwnrxr8bHbxJDTW1off4pXiyqfUWS5R52NXoE8lgrIxOl
BzeT4LBXlEOF8UtojQ==
--000000000000f5c8cf06014bb6d7--
