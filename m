Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D065F7BC64B
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 11:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjJGJAg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 05:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJGJAf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 05:00:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC86BC
        for <linux-kselftest@vger.kernel.org>; Sat,  7 Oct 2023 02:00:32 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5068b69f4aeso2650e87.0
        for <linux-kselftest@vger.kernel.org>; Sat, 07 Oct 2023 02:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696669231; x=1697274031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=msMoaBn1dW2sjohY+krgnp4nEeIWA1M+bQ4ZOhn4PtE=;
        b=euiqUUEiBwb02uUO1Z92o/Qjyx2eFkPhBWq4v2NAo8rQDJDve1sG2C1/5qOvB6htz/
         x2WLeZqBTmuLCwOsMEPxatZv5EkaqKvYim+OOUSVv2QXuODpH1YyJ1CEH96MmOhGLp45
         ToISj4e7Gh0Gqft5m2y8IFNAtZ+CKuXUPoFK3z8trAyK9/aaDtqcuQIv+ixZibFjc3hc
         SpF4F1v8lwOVBPZKYMpyphTyRnJ/rkooI/JjWYC42/d5Eowcp0SmBI9ns0hS+n+nawPy
         oNeilKFMx1BaA8K8V0XdQeZokKPC8lXBxzsIWr2Kgyvz9fwPq71V0sts+HrXppvqaTtS
         mY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696669231; x=1697274031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msMoaBn1dW2sjohY+krgnp4nEeIWA1M+bQ4ZOhn4PtE=;
        b=C6Bf/UU1XnA5xa2yL3tehrrzaA6N3zK46m4nHulL6E1LIqcqU1X2H0PVbnacai6gU6
         DMYBrnHAAPzgw7VHY+NS62SCeMSJzC4uTwtOIP5jHA++NOIBkWZNN4QFVDH1XW/RdFOU
         lFroMjHFEQmo6UXHG+W90dd5R5WR08oVmF4SPrTKKYJIpqL4li+BhVfEvnD2PqsxUfCJ
         Ow4/JSojgjwFUFLYwHGQQxCjw1XNb8HikE5aPYB8QZnlTXufKoLWgVe9oaHiCEKJZaez
         Pj2P6VNvLtyDZoW6Xz6wBdyyTa48jqldguc4+D1g7tt6xQD+gggRahzi8/nqJh6w+HC9
         32Pw==
X-Gm-Message-State: AOJu0YynlEE6qnu9bsGWYwLeKS3Dh2/i3uIoJYxJX4e6b+WBrGg8MyUa
        rwHiuolr4Pf+qE5V0s4vE3fEwjB+E9yN2SteifyyYA==
X-Google-Smtp-Source: AGHT+IEljwCo+lWu+XRDCE81+8E16BxH6eFN9tvkH6e4/p2DQNQcvX1oQn36s23hHkagV4p19rcOYkgoS+O6jjKvy/U=
X-Received: by 2002:ac2:447c:0:b0:501:ba53:a4f7 with SMTP id
 y28-20020ac2447c000000b00501ba53a4f7mr134748lfl.0.1696669230663; Sat, 07 Oct
 2023 02:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231004205700.1511-1-michal.wajdeczko@intel.com>
In-Reply-To: <20231004205700.1511-1-michal.wajdeczko@intel.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 7 Oct 2023 17:00:16 +0800
Message-ID: <CABVgOSnnoPBL8DBmiRrKyQBubGBsfbsd5JDhpw9mhLcga1+85A@mail.gmail.com>
Subject: Re: [PATCH] kunit: Reset suite counter right before running tests
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Rae Moar <rmoar@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d36d3106071c96e3"
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

--000000000000d36d3106071c96e3
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Oct 2023 at 04:57, Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> Today we reset the suite counter as part of the suite cleanup,
> called from the module exit callback, but it might not work that
> well as one can try to collect results without unloading a previous
> test (either unintentionally or due to dependencies).
>
> For easy reproduction try to load the kunit-test.ko and then
> collect and parse results from the kunit-example-test.ko load.
> Parser will complain about mismatch of expected test number:
>
> [ ] KTAP version 1
> [ ] 1..1
> [ ]     # example: initializing suite
> [ ]     KTAP version 1
> [ ]     # Subtest: example
> ..
> [ ] # example: pass:5 fail:0 skip:4 total:9
> [ ] # Totals: pass:6 fail:0 skip:6 total:12
> [ ] ok 7 example
>
> [ ] [ERROR] Test: example: Expected test number 1 but found 7
> [ ] ===================== [PASSED] example =====================
> [ ] ============================================================
> [ ] Testing complete. Ran 12 tests: passed: 6, skipped: 6, errors: 1
>
> Since we are now printing suite test plan on every module load,
> right before running suite tests, we should make sure that suite
> counter will also start from 1. Easiest solution seems to be move
> counter reset to the __kunit_test_suites_init() function.
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> ---

This looks good to me. Thanks. Originally the suite counter was a
static variable in __kunit_test_suites_exit(), before we had to deal
with modules properly.

This seems much better, though.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index f2eb71f1a66c..9325d309ed82 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -670,6 +670,8 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
>                 return 0;
>         }
>
> +       kunit_suite_counter = 1;
> +
>         static_branch_inc(&kunit_running);
>
>         for (i = 0; i < num_suites; i++) {
> @@ -696,8 +698,6 @@ void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites)
>
>         for (i = 0; i < num_suites; i++)
>                 kunit_exit_suite(suites[i]);
> -
> -       kunit_suite_counter = 1;
>  }
>  EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
>
> --
> 2.25.1
>

--000000000000d36d3106071c96e3
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA5
Wn2ZYo7KUoAxLF5cOZKJmA7o2yy+U6jXPQph6x1CdjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEwMDcwOTAwMzFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAJIYEcaNEig10mq3MqS9n
GnuCE0+5g+p07n1zBLPLPS45d+971cBgiP82yBIpbwoi0JdC5BVMrz40M4k+Za9UJkEfNz+qSMlq
+DLSzT4p8qEZKDzjlKQbhg3hwejZcwDGyxKKB7pGdZZZzQbUhwMDUwaEQo6Oo80wA2edY2LtRW8D
2TfDHucwEk8ovmlTK4orQM2bUGaOodJrIsE8uu6TTT+Ab3pxvCW3Y1ppROWneAwzpSJCtt6HuWLd
gIT9JQZH0i2E4C/4kLNjY8CqYXc3irqOBI2SfFpkpoaWIcgdpSWFmj78qVbpaKv8bnt0uJX7B6Wc
0YHfOOE1uXlM+nscQA==
--000000000000d36d3106071c96e3--
