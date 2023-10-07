Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062C97BC665
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 11:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjJGJTA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 05:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJGJTA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 05:19:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61037BF
        for <linux-kselftest@vger.kernel.org>; Sat,  7 Oct 2023 02:18:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4063bfc6c03so40315e9.0
        for <linux-kselftest@vger.kernel.org>; Sat, 07 Oct 2023 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696670337; x=1697275137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oDrWRofpCVnidHuLeVHXmO/1YM2DEmHjwMRa5DQBOAU=;
        b=G4255i8z05EBISAvgVgRbbqTEMtLW6QXWZX57KHeWkmgDxmVr6WZWSTW2C8fGNCxps
         Y1KCmXpO/Vs4rLX62sg5/MJVSpGZtMFYdbI8U30RszDbzk/PqEStKuP7qrK/ZJ/EDqrr
         A9u86yMqi235qQ9Cckve4ZcQfr2EKx4P0nfj3mi7z9Hufv2Q7+UnM2GaibJdcfjzKVuQ
         yLE28k+I+S9YbUzzJ5mqAFaegUqDHLXtSJgLoNt8slJmsHEWTJJwqg0tLJBEjw6JkIkR
         r/XL8mnGf7LYMhLwnNkAeNinxdUM40pWltlctMQwSfHNoEwArrgaEyg8ONCcsY0LqVqv
         vmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696670337; x=1697275137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDrWRofpCVnidHuLeVHXmO/1YM2DEmHjwMRa5DQBOAU=;
        b=bDfIOejsyEKEaxvM7ULiSqKvPpM0c/kq/lbQGWAhmljPYsT0z1cQH7YmtrY6rtHm0Z
         yWc+1H9yq9BSOtYq1jQ1UoYL1c6xYA2IZphkgJTfCBS1S6JSBf1ah77vZBR915tjPg+U
         1fN+Poiz8iSd6OLZkSMojRqkcmJzIiC2+xXC8No/kt0UcwqrmyvLQClZYJyLEdRMerz3
         KKfux+chKx8e8S3FEGC6qcsioK38I/Bi/o1EzZ57A6JCtKS3gj25wX/NNFJJakaSqjlt
         jBwfmjDBFrzzAb+RiCWhiiPlKDWJZGBFnH+XczPa7ZZ47OGYhlw5oItwOLb3lTMaRWlJ
         5zaA==
X-Gm-Message-State: AOJu0Yyz4suVHBDE8CRJIM4gnFE0gL039mqn5J88vuzfTUrUfsYRi7TN
        r/veEca2iESUniDW3JOxmmrR2BkJ7NEE/nqinayC2A==
X-Google-Smtp-Source: AGHT+IH39YxRUWWTlcQJ6yPBbb8VCIaOaQZbd/NpKrMcLKUj/qTn3VZjdnKje1LzMfToZuZAeV/8bf0U3UCaaykcT2U=
X-Received: by 2002:a05:600c:3b8f:b0:3fe:e9ea:9653 with SMTP id
 n15-20020a05600c3b8f00b003fee9ea9653mr242570wms.4.1696670336704; Sat, 07 Oct
 2023 02:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230925175733.1379-1-michal.wajdeczko@intel.com> <20230925175733.1379-3-michal.wajdeczko@intel.com>
In-Reply-To: <20230925175733.1379-3-michal.wajdeczko@intel.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 7 Oct 2023 17:18:41 +0800
Message-ID: <CABVgOSmwxdw4h4GBnJ0iB=0BzrQCR=rOLBFvFmwUTPaKrSxjbA@mail.gmail.com>
Subject: Re: [PATCH 2/4] kunit: Fix indentation level of suite messages
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Rae Moar <rmoar@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000bf0fff06071cd89f"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000bf0fff06071cd89f
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Sept 2023 at 01:58, Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> A kunit suite is a top level test from the KTAP point of view but
> all suite diagnostic messages are printed at the subtest level:
>
>     $ ./tools/testing/kunit/kunit.py run --raw_output \
>         --kunitconfig ./lib/kunit/.kunitconfig "example.*simple*"
>
>     KTAP version 1
>     1..1
>         # example: initializing suite
>         # example: failed to initialize (-ENODEV)
>     not ok 1 example
>
>     KTAP version 1
>     1..1
>         # example: initializing suite
>         KTAP version 1
>         # Subtest: example
>         # module: kunit_example_test
>         1..1
>         # example_simple_test: initializing
>         # example_simple_test: cleaning up
>         ok 1 example_simple_test
>         # example: exiting suite
>     ok 1 example
>
> Replace hardcoded indent in kunit_printk() with flexible
> indentation based on the argument type (test or suite):
>
>     KTAP version 1
>     1..1
>     # example: initializing suite
>     # example: failed to initialize (-ENODEV)
>     not ok 1 example
>
>     KTAP version 1
>     1..1
>     # example: initializing suite
>         KTAP version 1
>         # Subtest: example
>         # module: kunit_example_test
>         1..1
>         # example_simple_test: initializing
>         # example_simple_test: cleaning up
>         ok 1 example_simple_test
>     # example: exiting suite
>     ok 1 example
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> ---

I think this is looking pretty good overall. It'll need rebasing on
the current kselftest/kunit branch, though.

As Rae points out, some of this will probably need reworking if we
start to support more arbitrary nesting. Equally, we probably need a
name for the 'top level' container (of which suites are effectively
subtests). To add to the name bikeshedding, while 'executor' works
well enough, I think the (K)TAP spec refers to this as the 'test
document'. Is that right, Rae?

>  include/kunit/test.h | 24 ++++++++++++++++++++++--
>  lib/kunit/test.c     |  7 -------
>  2 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 20ed9f9275c9..158876c4cb43 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -509,6 +509,21 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
>                 kunit_try_catch_throw(&((test_or_suite)->try_catch));   \
>         } while (0)
>
> +/* Currently supported test levels */
> +enum {
> +       KUNIT_LEVEL_SUITE = 0,
> +       KUNIT_LEVEL_CASE,
> +       KUNIT_LEVEL_CASE_PARAM,
> +};
> +
> +#define kunit_level(test_or_suite)                                     \
> +       _Generic((test_or_suite),                                       \
> +                struct kunit_suite * : KUNIT_LEVEL_SUITE,              \
> +                struct kunit * : KUNIT_LEVEL_CASE)
> +
> +#define kunit_indent_level(test_or_suite)                              \
> +       (KUNIT_INDENT_LEN * kunit_level(test_or_suite))
> +

This looks good to me. I like the use of _Generic() -- I suspect there
might be one or two other places in the KUnit code it could be useful
in the future.

I don't think we need to handle kunit_case here: once a test is
actually being run (and therefore able to log anything), it's already
got a struct kunit*.


>  /*
>   * printk and log to per-test or per-suite log buffer.  Logging only done
>   * if CONFIG_KUNIT_DEBUGFS is 'y'; if it is 'n', no log is allocated/used.
> @@ -520,9 +535,14 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
>                                  ##__VA_ARGS__);                        \
>         } while (0)
>
> +#define kunit_log_indent(lvl, test_or_suite, fmt, ...)                 \
> +       kunit_log(lvl, test_or_suite, "%*s" fmt,                        \
> +                 kunit_indent_level(test_or_suite), "",                \
> +                 ##__VA_ARGS__)
> +
>  #define kunit_printk(lvl, test, fmt, ...)                              \
> -       kunit_log(lvl, test, KUNIT_SUBTEST_INDENT "# %s: " fmt,         \
> -                 (test)->name, ##__VA_ARGS__)
> +       kunit_log_indent(lvl, test, "# %s: " fmt,                       \
> +                        (test)->name, ##__VA_ARGS__)
>
>  /**
>   * kunit_info() - Prints an INFO level message associated with @test.
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index fb5981ce578d..d10e6d610e20 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -135,13 +135,6 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
>  }
>  EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
>
> -/* Currently supported test levels */
> -enum {
> -       KUNIT_LEVEL_SUITE = 0,
> -       KUNIT_LEVEL_CASE,
> -       KUNIT_LEVEL_CASE_PARAM,
> -};
> -
>  static void kunit_print_suite_start(struct kunit_suite *suite)
>  {
>         /*
> --
> 2.25.1
>

--000000000000bf0fff06071cd89f
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
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAa
SG0Wr4xRc72L1THCO13PGInOwF4UwapZQgAoW02QBTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEwMDcwOTE4NTdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAT5zIR2Q3y8W9iTl7H7Oq
0yKK5kZS9qKyPGsNVCgZczbxsIlDmOPKgRGrztOOWvp7aZ/NzKB5od+Dec/SsK/9TGoF20jp2qfm
/P/bGvmG2TxyjSFmFjsEyOvCoyHghwSajf+sNMyy5I3wNbxo+s+2jB5j03wmNW4qugNhsRLCSp8d
phh7jIyH1EHY4cHyVAFUR5+/E8873tMpDfOTu4LzR9a1ZnmWEy1vfv0M0GIUUbYho0AWFl3pEaod
cU2X3/0EYlxDq3cl/I3DAbqKRM1wFV7fQyRqDIF2X1kiFeVWwZAM9Hq8JGIXPF/GslAVnetd83X0
7oOeMIuNkXGnoIGpwg==
--000000000000bf0fff06071cd89f--
