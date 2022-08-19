Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F595997B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 10:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347103AbiHSIhS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 04:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347405AbiHSIgw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 04:36:52 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3943C61B1B
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 01:34:43 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id m21so1524941uab.13
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gnG5n7t7kM5tLQ6GvelrUae9g4PaSqFMlXyOhSVJavI=;
        b=JEx6HlrizOBmU3wWPsl9Wjt1GbkqjdLM3pW9b2A4JWopo4gfyCBcawoics3lNcb0YS
         NT3ucX8+fUruztlys6R9pBsL0iwo7NEI+gt4BnbMipUno6Da4pqwJisnquZZUWL6F0Be
         /Yl17Ye+dWt/SA6Cw175X0sgtbakN0svk2VkkxUzhBWZBJAzf/rQhyjYLrHk0EnC6k2I
         YtLrFbG+DplTEdR4Lmq4s0Gzf38rA9MqC0OSBD0wFp6dWT6DggMSQ1l8gFFowSn0cRET
         Uj6sh5QtMG2dBM9ZKBzNGD2ZgfgZzex95Bf5FNdX1XL1slfStQVcHjwi7S+iVwq0jg1n
         zQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gnG5n7t7kM5tLQ6GvelrUae9g4PaSqFMlXyOhSVJavI=;
        b=xXoVJ4rwcvP76c0j43OxnWF8AYYl31FL4ApJRZaui90gF046KFZlKgX4RHShx0Y5sF
         4+/+FxCovVP6gQn+qALPs1TXxcVKy0FaZPJwXA2EknTNuQ1BRaondjTpi77GcEKifszO
         lCD3BTsN2NfGHh1++s/QANFsqLl0vm/lq2M9WfGEECfqUZGJCHiJ1YaMFbIOYJU9QIt4
         DY1o7j9JDz2Eezj/sznZo/F+R+kOEpt7h0i3gH0EQnbvMiRCBfjXG4JyD9maVLWtMr28
         PZFpd9FaXvm4q9a8lsbvCWNlkIn7+TJFmaf8kePdShIyJnsNjX6m1d0f/l4hT02QbfU3
         Rt+w==
X-Gm-Message-State: ACgBeo3A7bBChQGCiVZaECxToSZzj1M49wE6BpQ0zcj2MainFdkG+Dre
        BiauDNcBxShY/DfhY14b2gM+8i+YbszlcFeZaXVM6g==
X-Google-Smtp-Source: AA6agR6js/rZ7cAl5nKI4lPs0swl+3Wn3I7GmyFLifwGBDzbErMpFq+37uj8xdHx2xP5xOZ1ORWrqjlx4iguaeloXiA=
X-Received: by 2002:ab0:3b09:0:b0:39a:82bc:88e5 with SMTP id
 n9-20020ab03b09000000b0039a82bc88e5mr2276360uaw.26.1660898082867; Fri, 19 Aug
 2022 01:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220817164851.3574140-1-joefradley@google.com> <20220817164851.3574140-3-joefradley@google.com>
In-Reply-To: <20220817164851.3574140-3-joefradley@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 19 Aug 2022 16:34:31 +0800
Message-ID: <CABVgOSkRRMDz14cpsYBi7SaefbOhGc9V+z+pY_tULkk12Fb-EA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: no longer call module_info(test, "Y") for
 kunit modules
To:     Joe Fradley <joefradley@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000405ad005e693f8e1"
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

--000000000000405ad005e693f8e1
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 18, 2022 at 12:49 AM Joe Fradley <joefradley@google.com> wrote:
>
> Because KUnit test execution is not a guarantee with the kunit.enable
> parameter we want to be careful to only taint the kernel only if an
> actual test runs. Calling module_info(test, "Y") for every KUnit module
> automatically causes the kernel to be tainted upon module load. Therefore,
> we're removing this call and relying on the KUnit framework to taint the
> kernel or not.
>
> Signed-off-by: Joe Fradley <joefradley@google.com>
> ---

Thanks!

This definitely fixes an assumption I'd had about KUnit-usage which
definitely doesn't hold: that all KUnit tests would be in their own
modules (or at least that those modules wouldn't need to be loaded on
otherwise production systems). Given this isn't the case for a number
of modules (thuderbolt, apparmor, probably soon amdgpu), it makles
sense to get rid of this and only taint the kernel when the test is
actually run, not just when it's loaded.

This could be considered a fix for c272612cb4a2 ("kunit: Taint the
kernel when KUnit tests are run"), as it'd already be possible to
load, e.g., thunderbolt, but prevent the tests from executing with a
filter glob which doesn't match any tests. That possibly shouldn't
taint the kernel.

Reviewed-by: David Gow <davidgow@google.com>
Fixes: c272612cb4a2 ("kunit: Taint the kernel when KUnit tests are run")

Cheers,
-- David

>  include/kunit/test.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index c958855681cc..f23d3954aa17 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -251,7 +251,6 @@ static inline int kunit_run_all_tests(void)
>  #endif /* IS_BUILTIN(CONFIG_KUNIT) */
>
>  #define __kunit_test_suites(unique_array, ...)                                \
> -       MODULE_INFO(test, "Y");                                                \
>         static struct kunit_suite *unique_array[]                              \
>         __aligned(sizeof(struct kunit_suite *))                                \
>         __used __section(".kunit_test_suites") = { __VA_ARGS__ }
> --
> 2.37.1.595.g718a3a8f04-goog
>

--000000000000405ad005e693f8e1
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA3
FKMv0rb2xHk3DirulJdRHhbiP8FNxamZGB5WRakw5zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MTkwODM0NDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEARxi3ltyQ8jHqlPurYczC
i2+KJDMHF+h9W9WJcsMRyKiTil0H9OU7RjgwTq8tCpOAVjXjIJeyVOjdfo8rVrHQ+GHSANAIhIdD
kOCq+yQcBAYummKaWCxpFduYmiQQ/4Zv+m5FKmGOnEQOiNE2tnZhVe8mtITb5gFPX5bRdh7uNORG
QjIHlZGjI0ZG9P9svV7L+mYwn3/DM2Q9+zCFfH1bGmc9vgomSTvvEZK6JD6KK9ZeMFXf52vZrLU/
IwYNK/QpUnbsTzBVJi6rA8NxtlL/3xGyS9rTy/VhrfsShoFnpdEK9UyscMTkZvHCkbT09byDX4O5
C8AUgQ8TBDWRJoUgyQ==
--000000000000405ad005e693f8e1--
