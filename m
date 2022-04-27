Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B861510E73
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 04:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357014AbiD0B73 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 21:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357011AbiD0B72 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 21:59:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062722CE21
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 18:56:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q23so506851wra.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Apr 2022 18:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUpKBzYXpZ2gnHgy+UGTLH537DdS2++Rr916eyA+llI=;
        b=XVzPzvyVHyCRFKmIQMBBUX2LhGcRsmLm9SnwBjjtNmMdfjl89va24BJOkkQLFrytSR
         06cWzbjw0JidDIpQDGqwxJwuKQ4SmfaEm/iYGNw75Ltzk0Qkte6bGuTnC6xHn9fRwJVa
         CuDP10i/rzoxBVJozKfzljK5Pp6WWxNZoOxgKsLN9E4Yf5iln4hlh9agn2BXCS8dSOxA
         cxviTWKyZx9GvBEUnRF+VNsGd4dNv9ieHRLF+oNq9zmVsC/8Kd2A3Vn6ER3wJKOnrqVw
         vl3flRFt+nw8lErvTJw8CkVT4vuQAQKls5944SM3dPp9i2lqwKOkmJqQGF2OkfN7yKuj
         35dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUpKBzYXpZ2gnHgy+UGTLH537DdS2++Rr916eyA+llI=;
        b=Vl+sN2Xnwvp6w/3jHeS2yRLhqn53ZLOE198EU41qNGZux+MVju+m8n9CpK0+bxOpBb
         Xp/A3Pofz+oj2qVkSipnhnb0dyIuVVWBSb7F6fmd5fXii+2Bd3QpTNHjDdDdPTZR8Iuc
         zaXe0pkQV9nlpZCI4aWnNCXXc2H8PyBjuL5mTzDqf2T4au3GG1zEJAAM1QCLYUgfYuvt
         HmIRNTyJKYy4MOqgcR7XycvjyKt64b+92r2mMLRuHCRNI2mxyAJ0T6ERJkY80AIPyF8k
         wYADEUCpvo2yMr/0Prt+HLaS0CBTMKkt2orfG+wn7UvdqIPa+YCiX5XU8uW4KEJ8Y/MZ
         7vtQ==
X-Gm-Message-State: AOAM530dLMJNkJWFPcet4uu0iIJwbDjb46tNdJMLfv4IiCmDFIj4oH0T
        GvnMHJHL8rvqy1CqRiUdJu2ul+2XmzUryx3OvI+Xyg==
X-Google-Smtp-Source: ABdhPJyLu8BTghjxcRPnDPeuNu3SNypYEHLZywCXXm2HEK/eQI4lfk2nBKxpfnMseFl3ILlJkfc0jqAUb87g6NMV2Ms=
X-Received: by 2002:a5d:6b0e:0:b0:20a:dd17:e452 with SMTP id
 v14-20020a5d6b0e000000b0020add17e452mr9372396wrw.501.1651024577517; Tue, 26
 Apr 2022 18:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220426181925.3940286-1-dlatypov@google.com> <20220426181925.3940286-3-dlatypov@google.com>
In-Reply-To: <20220426181925.3940286-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 27 Apr 2022 09:56:06 +0800
Message-ID: <CABVgOSnU+jQsd_eUvSc1+gpcW3su0W4ZEHUc6kj9zu3nxFVXsQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] kfence: test: use new suite_{init/exit} support, add .kunitconfig
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000079ed7105dd991d45"
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

--00000000000079ed7105dd991d45
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 27, 2022 at 2:19 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently, the kfence test suite could not run via "normal" means since
> KUnit didn't support per-suite setup/teardown. So it manually called
> internal kunit functions to run itself.
> This has some downsides, like missing TAP headers => can't use kunit.py
> to run or even parse the test results (w/o tweaks).
>
> Use the newly added support and convert it over, adding a .kunitconfig
> so it's even easier to run from kunit.py.
>
> People can now run the test via
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=mm/kfence --arch=x86_64
> ...
> [11:02:32] Testing complete. Passed: 23, Failed: 0, Crashed: 0, Skipped: 2, Errors: 0
> [11:02:32] Elapsed time: 43.562s total, 0.003s configuring, 9.268s building, 34.281s running
>
> Cc: kasan-dev@googlegroups.com
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This works for me: I'm very excited to see these tests run more nicely
with kunit_tool (and not break the TAP headers).

I guess the next one to tackle will be the Thunderbolt tests, though
those are more complicated still and need some module changes, IIRC.

Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  mm/kfence/.kunitconfig  |  6 ++++++
>  mm/kfence/kfence_test.c | 31 +++++++++++++------------------
>  2 files changed, 19 insertions(+), 18 deletions(-)
>  create mode 100644 mm/kfence/.kunitconfig
>
> diff --git a/mm/kfence/.kunitconfig b/mm/kfence/.kunitconfig
> new file mode 100644
> index 000000000000..f3d65e939bfa
> --- /dev/null
> +++ b/mm/kfence/.kunitconfig
> @@ -0,0 +1,6 @@
> +CONFIG_KUNIT=y
> +CONFIG_KFENCE=y
> +CONFIG_KFENCE_KUNIT_TEST=y
> +
> +# Additional dependencies.
> +CONFIG_FTRACE=y
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index 1b50f70a4c0f..96206a4ee9ab 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -826,14 +826,6 @@ static void test_exit(struct kunit *test)
>         test_cache_destroy();
>  }
>
> -static struct kunit_suite kfence_test_suite = {
> -       .name = "kfence",
> -       .test_cases = kfence_test_cases,
> -       .init = test_init,
> -       .exit = test_exit,
> -};
> -static struct kunit_suite *kfence_test_suites[] = { &kfence_test_suite, NULL };
> -
>  static void register_tracepoints(struct tracepoint *tp, void *ignore)
>  {
>         check_trace_callback_type_console(probe_console);
> @@ -847,11 +839,7 @@ static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
>                 tracepoint_probe_unregister(tp, probe_console, NULL);
>  }
>
> -/*
> - * We only want to do tracepoints setup and teardown once, therefore we have to
> - * customize the init and exit functions and cannot rely on kunit_test_suite().
> - */
> -static int __init kfence_test_init(void)
> +static int kfence_suite_init(struct kunit_suite *suite)
>  {
>         /*
>          * Because we want to be able to build the test as a module, we need to
> @@ -859,18 +847,25 @@ static int __init kfence_test_init(void)
>          * won't work here.
>          */
>         for_each_kernel_tracepoint(register_tracepoints, NULL);
> -       return __kunit_test_suites_init(kfence_test_suites);
> +       return 0;
>  }
>
> -static void kfence_test_exit(void)
> +static void kfence_suite_exit(struct kunit_suite *suite)
>  {
> -       __kunit_test_suites_exit(kfence_test_suites);
>         for_each_kernel_tracepoint(unregister_tracepoints, NULL);
>         tracepoint_synchronize_unregister();
>  }
>
> -late_initcall_sync(kfence_test_init);
> -module_exit(kfence_test_exit);
> +static struct kunit_suite kfence_test_suite = {
> +       .name = "kfence",
> +       .test_cases = kfence_test_cases,
> +       .init = test_init,
> +       .exit = test_exit,
> +       .suite_init = kfence_suite_init,
> +       .suite_exit = kfence_suite_exit,
> +};
> +
> +kunit_test_suites(&kfence_test_suite);
>
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>");
> --
> 2.36.0.rc2.479.g8af0fa9b8e-goog
>

--00000000000079ed7105dd991d45
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDO
B+2p8LLkQs8XALT+pvPloHN5teI7hKLr37YFvIcy1jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA0MjcwMTU2MTdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAQehjir8ainkO9PiRhFTB
d7pj/NLqEQ+6a5zqBWova8H7VLjB4GAw93OGlMv62Ln6FDiQq/jRu55BpU3f3f4QNmQSvp1x84Cp
6IUlen8I9e+LyVZZbyG7CILw6vfuWBysR7faMT5Zr1bQQAmPNkYTReNlmWYihoSUh6vn2vgI3eHs
PrZ7aoUt6chBtqMVJoTF+qTKBJmkT7tuixtIl1c9DQFk+7Sea37L1ZkXufflcVrN7No32ESeMi1C
Ycz8kWaFFw/xdS/lNa7EDqP1da9CtDKDFJjUBaNpFsTZtc+GXaP7pUihh7nRzdfy0UhfZsBtJwjq
+9tSbAJxuUc+bDHITQ==
--00000000000079ed7105dd991d45--
