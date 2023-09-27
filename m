Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AEB7AF8E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 05:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjI0D5o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 23:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjI0D4Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 23:56:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CF58A5E
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:25:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4063c2ed5ebso33185e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 20:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695785104; x=1696389904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nyQnvSxknUXvfJgdqDZ7KMyMC7Fx3w7rzFTLOuyZUxA=;
        b=JrQyS+Fqk4ehnXwMEiH681RI9bm4pYPtNuaUJ36zOPyUIA57i2yIytgr/55Lu8+er9
         LAzZj49wYC6HtIkYh2aDVn1pqHBZGa4MoU3vVTPKZOKc74XkBUqLrChEGnJ7m5/iUxgz
         kGvj9kuVNKhPA/JOG/H75w2zlQw1q3olnGRAiebYFxeVBRGF3M7QxFYS+PfuIa+5S0FK
         bW28vOuNUuX78cEJ6FxiyV7W0jkk2aqZUFchMB+TWT79WzUymLUEALLyg19A1/BUEqTQ
         aG5yAK5miwCIdFMcm9wMquvtXedLb2aPdIxNUpL6SDtzA4b8n+wD+aqPkWdpw2xgrcZk
         8/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695785104; x=1696389904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyQnvSxknUXvfJgdqDZ7KMyMC7Fx3w7rzFTLOuyZUxA=;
        b=ZTTcslZgRojvtty2CXzeCFf+OltyU6PlJ0akXaDg1SU/YeR5Do+TRx1J4Vw2Xoogwp
         /crmlqxwUICbB025iNWkuK1Qe+cYo30rstLkf8E/3/Q/w++Z6y9LaQKI6f2YJF62hHup
         b+g68j2Brf/ZBKWpGQA+P1TeYhtWTc1u5h1bddqMrvd+uGa2cMpYtsIoOlWu7QFXgZIY
         y37dCAjKjqdfV7MN1nYCrCVVOT0SavKRxW6hK7BwiBuR+ZfmNBjVuKxrKN5y/0hAKV8i
         CgtN7koWpxDHKvjWK1QVw6ppe1iurxMKD7ZqGRwfNct0+++aJeqv8z7rVk9jGyWyrIis
         2jXQ==
X-Gm-Message-State: AOJu0Yx9b5exgHWZNF6tjeCKHiLAlrUgaVKYwBZwSx6Sq9VAgS525dT3
        X7XNT617bjGMhS2nc0b5Xx87R4py5tIclOW8qtlxkQ==
X-Google-Smtp-Source: AGHT+IElt5P11QC2tEp1XRtAf3RMDfYMv7C8cEveYjInHhNqgbiilOl4KPHjgo3kqqF1eaMxy8bVDy0JLUl/YXD4o1U=
X-Received: by 2002:a05:600c:2946:b0:405:320a:44f9 with SMTP id
 n6-20020a05600c294600b00405320a44f9mr151329wmd.5.1695785104323; Tue, 26 Sep
 2023 20:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230923005404.3633619-1-make_ruc2021@163.com>
In-Reply-To: <20230923005404.3633619-1-make_ruc2021@163.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 27 Sep 2023 11:24:50 +0800
Message-ID: <CABVgOS=XrsBdMTENB6-pmr7PCV-vPY4T=sX2L-XARJR2oQ8p2g@mail.gmail.com>
Subject: Re: [PATCH v3] list: test: potential dereference of null pointer
To:     Ma Ke <make_ruc2021@163.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c9780506064ebce3"
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

--000000000000c9780506064ebce3
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Sept 2023 at 08:54, Ma Ke <make_ruc2021@163.com> wrote:
>
> To avoid the failure of alloc, we could check the return value of
> kmalloc() and kzalloc().
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---

Thanks very much. This looks good to me. We could change the rest of
the allocations to also use kunit_kzalloc(), but equally that can be
left to another patch.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/list-test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/lib/list-test.c b/lib/list-test.c
> index 0cc27de9cec8..a0b478042477 100644
> --- a/lib/list-test.c
> +++ b/lib/list-test.c
> @@ -26,10 +26,12 @@ static void list_test_list_init(struct kunit *test)
>
>         INIT_LIST_HEAD(&list2);
>
> -       list4 = kzalloc(sizeof(*list4), GFP_KERNEL | __GFP_NOFAIL);
> +       list4 = kunit_kzalloc(test, sizeof(*list4), GFP_KERNEL | __GFP_NOFAIL);
> +       KUNIT_ASSERT_NOT_NULL(test, list4);
>         INIT_LIST_HEAD(list4);
>
>         list5 = kmalloc(sizeof(*list5), GFP_KERNEL | __GFP_NOFAIL);
> +       KUNIT_ASSERT_NOT_NULL(test, list5);
>         memset(list5, 0xFF, sizeof(*list5));
>         INIT_LIST_HEAD(list5);
>
> @@ -40,7 +42,6 @@ static void list_test_list_init(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, list_empty_careful(list4));
>         KUNIT_EXPECT_TRUE(test, list_empty_careful(list5));
>
> -       kfree(list4);
>         kfree(list5);
>  }
>
> --
> 2.37.2
>

--000000000000c9780506064ebce3
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBI
EwjBSHx7IkO7stXp+uZin/1BuFSbDJsezcB/DGbhsTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MjcwMzI1MDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAcqJ+2PWZTmhWVLkIEca/
cTkcbgzxCof70isrgXu2L9TkEnyXO5npPxaO+k3LznlGcu4drHUirr4+NL1IGMgueEjCBcKPOlwA
hagmCS65PlepjjYJRMPeE6RWxGOIL9+FKhP9v66S6sfGraROXH0ew9D9eAiy0muM8H5g3mOwiODD
/2An8l9IiwDTGLWFQG//EqStPkaKZDc+eFl0pOCN0OPfegPrjB0LJXgz+MW5zvLSXu0Dz5vwcUoM
dh7bPnHmbHEfhTAOpwb6PQAVPfvFMSNaxbW+iz5BTT/KI/NioxbQglm2mOPp2xPkBWR4FNW2lEjC
/oPftjnB3sNhJL3w2A==
--000000000000c9780506064ebce3--
