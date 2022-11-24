Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78308637467
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Nov 2022 09:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKXItM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Nov 2022 03:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiKXItL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Nov 2022 03:49:11 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2A6E2234
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Nov 2022 00:49:10 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id g65so573933vsc.11
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Nov 2022 00:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hR4hQ/Uo34bAtaMt6lykYHSrOQpbNiDwPqnk22pixJU=;
        b=eDQu2lXYRy1jtYIocsklv5aa87sS6gp/COs10f91FkqgCiNb/StLTbRFtifbBJ4ZJC
         0kQ7bIDt1vqoCA8l8IEVMUVvDTQtFu0Hk9W0dxDqX+cU7ACiACXA+jIsZD0qeAsFtttk
         UVTu4A/cOE1RjY43czjLx0SmI/W5aBQHecHqNhURggVvyE8ezhripGZnDZoxYpvFlS/d
         dmJhMWWySCto49ZTWzxbv1fcS7DzkLy8wh/uY6lVlwERoKGaGBbED/ta2H/hkSivPgol
         al1L6GLTjO7Ks9rAoSCeOPQSfrlPxjVOyUGXucjoCqVmbf9Si9rrBP8kTrG8OUGaNhfz
         kbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hR4hQ/Uo34bAtaMt6lykYHSrOQpbNiDwPqnk22pixJU=;
        b=EGsFD7sV/57litRT3RRd6G+rGgcA4wrv5tET1gKQ+p3Gu5cRRFb+Bg07AjMJ/qwqva
         RPJqZegK5btVeRpt41dhM0I4fY3Yo64RetXQOBVNk3rziLDJJiF8/do5AV7txMb8+71/
         TT97Y0CLfD5vk8RYUtqVVuG5BlgHb65tkw6OLJCs4gNEtGBXlsLp7cW/mW4I21YXerSW
         +udYEf0D5HnRMmUXGWvppno40ig9PDExbO6C/D5LNL/ddi4sdntRJfXuwSW4cspQ5RJp
         wJgOgCP5+622ZpwCSXv7RGPP8nSyJgcRUaYPumP32K1vZUFm+fbQ4MxpC5LGI3EthfOo
         7k1A==
X-Gm-Message-State: ANoB5pmEHUKld7y/fLHf+XjMXx8Q08ywS4huVZCPINtg00gt/lhzU7Ri
        xfFQ4ATCaQseUE1grrxnxEuP5hEieo1J02VgawGGKw==
X-Google-Smtp-Source: AA0mqf4XwhWYRSH7i2RdMcf2VM5GzYiTZp/UWtnpe0BftyypywX5/pj/C6DdGI6ZuoClr9KfhaaaOXRv7Y7QNvDUawE=
X-Received: by 2002:a05:6102:5785:b0:3b0:7178:7fe8 with SMTP id
 dh5-20020a056102578500b003b071787fe8mr3441623vsb.38.1669279749352; Thu, 24
 Nov 2022 00:49:09 -0800 (PST)
MIME-Version: 1.0
References: <20221123182558.2203639-1-rmoar@google.com> <20221123182558.2203639-2-rmoar@google.com>
In-Reply-To: <20221123182558.2203639-2-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 24 Nov 2022 16:48:58 +0800
Message-ID: <CABVgOS=eqSoMrEN7f8iyzpG-oQL_U2130ipWr78rEyYMqaeHDQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kunit: improve KTAP compliance of KUnit test output
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, mauro.chehab@linux.intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, isabbasso@riseup.net,
        anders.roxell@linaro.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000082527a05ee337ad7"
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

--00000000000082527a05ee337ad7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2022 at 2:26 AM Rae Moar <rmoar@google.com> wrote:
>
> Change KUnit test output to better comply with KTAP v1 specifications
> found here: https://kernel.org/doc/html/latest/dev-tools/ktap.html.
> 1) Use "KTAP version 1" instead of "TAP version 14" as test output header
> 2) Remove '-' between test number and test name on test result lines
> 2) Add KTAP version lines to each subtest header as well
>
> Note that the new KUnit output still includes the =E2=80=9C# Subtest=E2=
=80=9D line now
> located after the KTAP version line. This does not completely match the
> KTAP v1 spec but since it is classified as a diagnostic line, it is not
> expected to be disruptive or break any existing parsers. This
> =E2=80=9C# Subtest=E2=80=9D line comes from the TAP 14 spec
> (https://testanything.org/tap-version-14-specification.html) and it is
> used to define the test name before the results.
>
> Original output:
>
>  TAP version 14
>  1..1
>    # Subtest: kunit-test-suite
>    1..3
>    ok 1 - kunit_test_1
>    ok 2 - kunit_test_2
>    ok 3 - kunit_test_3
>  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
>  # Totals: pass:3 fail:0 skip:0 total:3
>  ok 1 - kunit-test-suite
>
> New output:
>
>  KTAP version 1
>  1..1
>    KTAP version 1
>    # Subtest: kunit-test-suite
>    1..3
>    ok 1 kunit_test_1
>    ok 2 kunit_test_2
>    ok 3 kunit_test_3
>  # kunit-test-suite: pass:3 fail:0 skip:0 total:3
>  # Totals: pass:3 fail:0 skip:0 total:3
>  ok 1 kunit-test-suite
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
>
> Changes since v2:
> https://lore.kernel.org/all/20221121184743.1123556-2-rmoar@google.com/
> - Made fixes discussed on the v2 patch to now correctly output test
>   results after second level testing
>
> Changes since v1:
> https://lore.kernel.org/all/20221104194705.3245738-1-rmoar@google.com/
> - Switch order of patches to make changes to the parser before making
>   changes to the test output
> - Change location of the new KTAP version line in subtest header to be
>   before the subtest header line
>

Thanks for fixing those. This looks good to me now.

I'm not aware of anyone who's actively parsing KUnit test results
who'd be broken by this (IIRC, all the CI systems are just grepping
for 'ok' / 'not ok' or actually using kunit.py to parse.)

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/debugfs.c  | 2 +-
>  lib/kunit/executor.c | 6 +++---
>  lib/kunit/test.c     | 9 ++++++---
>  3 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 1048ef1b8d6e..de0ee2e03ed6 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -63,7 +63,7 @@ static int debugfs_print_results(struct seq_file *seq, =
void *v)
>         kunit_suite_for_each_test_case(suite, test_case)
>                 debugfs_print_result(seq, suite, test_case);
>
> -       seq_printf(seq, "%s %d - %s\n",
> +       seq_printf(seq, "%s %d %s\n",
>                    kunit_status_to_ok_not_ok(success), 1, suite->name);
>         return 0;
>  }
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 9bbc422c284b..74982b83707c 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -166,7 +166,7 @@ static void kunit_exec_run_tests(struct suite_set *su=
ite_set)
>  {
>         size_t num_suites =3D suite_set->end - suite_set->start;
>
> -       pr_info("TAP version 14\n");
> +       pr_info("KTAP version 1\n");
>         pr_info("1..%zu\n", num_suites);
>
>         __kunit_test_suites_init(suite_set->start, num_suites);
> @@ -177,8 +177,8 @@ static void kunit_exec_list_tests(struct suite_set *s=
uite_set)
>         struct kunit_suite * const *suites;
>         struct kunit_case *test_case;
>
> -       /* Hack: print a tap header so kunit.py can find the start of KUn=
it output. */
> -       pr_info("TAP version 14\n");
> +       /* Hack: print a ktap header so kunit.py can find the start of KU=
nit output. */
> +       pr_info("KTAP version 1\n");
>
>         for (suites =3D suite_set->start; suites < suite_set->end; suites=
++)
>                 kunit_suite_for_each_test_case((*suites), test_case) {
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 90640a43cf62..1c9d8d962d67 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -149,6 +149,7 @@ EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
>
>  static void kunit_print_suite_start(struct kunit_suite *suite)
>  {
> +       kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "KTAP version 1\=
n");
>         kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "# Subtest: %s",
>                   suite->name);
>         kunit_log(KERN_INFO, suite, KUNIT_SUBTEST_INDENT "1..%zd",
> @@ -175,13 +176,13 @@ static void kunit_print_ok_not_ok(void *test_or_sui=
te,
>          * representation.
>          */
>         if (suite)
> -               pr_info("%s %zd - %s%s%s\n",
> +               pr_info("%s %zd %s%s%s\n",
>                         kunit_status_to_ok_not_ok(status),
>                         test_number, description, directive_header,
>                         (status =3D=3D KUNIT_SKIPPED) ? directive : "");
>         else
>                 kunit_log(KERN_INFO, test,
> -                         KUNIT_SUBTEST_INDENT "%s %zd - %s%s%s",
> +                         KUNIT_SUBTEST_INDENT "%s %zd %s%s%s",
>                           kunit_status_to_ok_not_ok(status),
>                           test_number, description, directive_header,
>                           (status =3D=3D KUNIT_SKIPPED) ? directive : "")=
;
> @@ -542,6 +543,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         /* Get initial param. */
>                         param_desc[0] =3D '\0';
>                         test.param_value =3D test_case->generate_params(N=
ULL, param_desc);
> +                       kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
> +                                 "KTAP version 1\n");
>                         kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT =
KUNIT_SUBTEST_INDENT
>                                   "# Subtest: %s", test_case->name);
>
> @@ -555,7 +558,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                                 kunit_log(KERN_INFO, &test,
>                                           KUNIT_SUBTEST_INDENT KUNIT_SUBT=
EST_INDENT
> -                                         "%s %d - %s",
> +                                         "%s %d %s",
>                                           kunit_status_to_ok_not_ok(test.=
status),
>                                           test.param_index + 1, param_des=
c);
>
> --
> 2.38.1.584.g0f3c55d4c2-goog
>

--00000000000082527a05ee337ad7
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBp
kEKcploO+QluCIByHsWSWy0InASHORLCtL+Fzez3XjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMjQwODQ5MDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAxvZv2DfQ1UhNiReptO4W
duxVPBxj9JABZuhf9kz7gXJB0czcQ6ryXN5lfnsgURr1cVewzLk+ufrS/BycnUinAA6T5YTUAN7u
v6f/o3nCJ4L9nYRkdGj7k8T1OjkIiBhF6OQXAp4A4GE6fE2ivCyFoys2HooX6rAf3PboSBMAZHcZ
en6/lMXyX1eXdrzZjPvi+wd8AcaM6AfWgTvCw/JlGNC3ZNBBCOrVJemnd46W7K+WtKzWS122cDGA
KDAt7q9/deleUEfbp3NKv+cDsAkv04ejIN/CCn5c12DvS4d7sj69UmODb8orLeTjgG7jnlZy7Plc
FYtuFZUkkmwg24iagA==
--00000000000082527a05ee337ad7--
