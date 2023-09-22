Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70EF7AAAB7
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 09:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjIVHsP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 03:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIVHsJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 03:48:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB91E198
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 00:48:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53074ee0c2aso8598a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 00:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695368882; x=1695973682; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5CT3UQ5NI46kucYi6f3ErRDfCXc54hO4VXKUPLYZfJ8=;
        b=eLW7lwyMdStglfayCRWN1CrT/JgbCX7nef+wT72jYcwf5cktGds1ft0mGI+6AT8KHD
         gWQeBe4ZcC9IV38XQxCQ+mBqsB+hGZ+4O14opqhp4EXGPNZxztGz+UFMDBHwDoNXlKcc
         pYklUoQh8QPAcg6NMWwe6LPKvjS1VT0S3oAKzCP0oChEWeuVdewwTbCFuG7z942eBLiv
         2ZWgL+VBXU92Qg7w+DJJh5/zqI0WPDCQ3DGMu3mwSOkEzybZHYZuEjhmLpHB3Y7NjVAY
         55/GRFE5NKBTJULzQSHhKd1bB5IkesicftbGfs7QO0E1HwQwbO0RRekb8R9rzvMAw3zb
         PPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695368882; x=1695973682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CT3UQ5NI46kucYi6f3ErRDfCXc54hO4VXKUPLYZfJ8=;
        b=arOgoEZo9eiOcrg9kEXVbxTSCGFNfTRqBDgEqghETLkNAx1U9Bf5LuucXb88gM+Aye
         pjbHNtSXG7QnJ8VbwhCnF7kcDsC4HLvH+jhh8gWgxsOsHwY5oNkWxnFasHoc0noTul4d
         rKvlRFYIu4FE0bAgQoBNW48ApXXUOyDIMxDum12a2JCPxaUnnyAV+7aOdgeNuUcTOG4t
         +cez8I1w2R4XjY3DhgRQ4fG3+UAuZfUNN6OAT0BXbsd5zHTaUiFo7mYgqfpLBo7VNDsV
         /DRmYJNdr6IiMmx1LK9fukSrYD+k9w1y1HtTiCG5Y6swxQ1CeF2HuiRCF8AMyL8yizwQ
         QoJg==
X-Gm-Message-State: AOJu0Yyr/oqtjtjmghaT+D+0vkUh9BaMoK00CTTqWJju6pBIq5W3wRDe
        GWRl9vWydBEJZCTiWa8Pd1MJd2EhA3EDKhbNcZRLRA==
X-Google-Smtp-Source: AGHT+IHFkrwu8Vt2261u1PUncJ54OWZThdsHyMugm/F5xdiccm21aXjJql6wvF/e2B2UaqfY+v6l7q2RNkrMKuMcJLo=
X-Received: by 2002:a50:cd5c:0:b0:523:b133:57fe with SMTP id
 d28-20020a50cd5c000000b00523b13357femr29681edj.1.1695368882298; Fri, 22 Sep
 2023 00:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230922071020.2554677-1-ruanjinjie@huawei.com> <20230922071020.2554677-2-ruanjinjie@huawei.com>
In-Reply-To: <20230922071020.2554677-2-ruanjinjie@huawei.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 22 Sep 2023 15:47:50 +0800
Message-ID: <CABVgOSmS8Gkqam1tvnQNPcmRh64M+A34Mfj_j066g7FuZnjTAQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] kunit: Fix missed memory release in kunit_free_suite_set()
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, skhan@linuxfoundation.org,
        dlatypov@google.com, rmoar@google.com,
        janusz.krzysztofik@linux.intel.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000048a5c0605edd44f"
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

--000000000000048a5c0605edd44f
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Sept 2023 at 15:11, 'Jinjie Ruan' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> modprobe cpumask_kunit and rmmod cpumask_kunit, kmemleak detect
> a suspected memory leak as below.
>
> If kunit_filter_suites() in kunit_module_init() succeeds, the
> suite_set.start will not be NULL and the kunit_free_suite_set() in
> kunit_module_exit() should free all the memory which has not
> been freed. However the test_cases in suites is left out.
>
> unreferenced object 0xffff54ac47e83200 (size 512):
>   comm "modprobe", pid 592, jiffies 4294913238 (age 1367.612s)
>   hex dump (first 32 bytes):
>     84 13 1a f0 d3 b6 ff ff 30 68 1a f0 d3 b6 ff ff  ........0h......
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000008dec63a2>] slab_post_alloc_hook+0xb8/0x368
>     [<00000000ec280d8e>] __kmem_cache_alloc_node+0x174/0x290
>     [<00000000896c7740>] __kmalloc+0x60/0x2c0
>     [<000000007a50fa06>] kunit_filter_suites+0x254/0x5b8
>     [<0000000078cc98e2>] kunit_module_notify+0xf4/0x240
>     [<0000000033cea952>] notifier_call_chain+0x98/0x17c
>     [<00000000973d05cc>] notifier_call_chain_robust+0x4c/0xa4
>     [<000000005f95895f>] blocking_notifier_call_chain_robust+0x4c/0x74
>     [<0000000048e36fa7>] load_module+0x1a2c/0x1c40
>     [<0000000004eb8a91>] init_module_from_file+0x94/0xcc
>     [<0000000037dbba28>] idempotent_init_module+0x184/0x278
>     [<00000000161b75cb>] __arm64_sys_finit_module+0x68/0xa8
>     [<000000006dc1669b>] invoke_syscall+0x44/0x100
>     [<00000000fa87e304>] el0_svc_common.constprop.1+0x68/0xe0
>     [<000000009d8ad866>] do_el0_svc+0x1c/0x28
>     [<000000005b83c607>] el0_svc+0x3c/0xc4
>
> Fixes: e5857d396f35 ("kunit: flatten kunit_suite*** to kunit_suite** in .kunit_test_suites")
> Fixes: b67abaad4d25 ("kunit: Allow kunit test modules to use test filtering")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Rae Moar <rmoar@google.com>
> ---
> v2:
> - Add Reviewed-by.
> ---

Whoops -- v3 came through while I was reviewing v2.

This looks good, thanks.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David



>  lib/kunit/executor.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index a6348489d45f..a037a46fae5e 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -137,8 +137,10 @@ void kunit_free_suite_set(struct kunit_suite_set suite_set)
>  {
>         struct kunit_suite * const *suites;
>
> -       for (suites = suite_set.start; suites < suite_set.end; suites++)
> +       for (suites = suite_set.start; suites < suite_set.end; suites++) {
> +               kfree((*suites)->test_cases);
>                 kfree(*suites);
> +       }
>         kfree(suite_set.start);
>  }
>
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230922071020.2554677-2-ruanjinjie%40huawei.com.

--000000000000048a5c0605edd44f
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAM
yJZs+dM33b/t5Z9iNY53+w1eAzaj/6PwVkGbSoRHVjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MjIwNzQ4MDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEASHdtu+sKAEB9B7eQBIHS
oyidngvjtdVLYAqLJe9LosArGY3KQfu9kkUHE+9pTBwS0su3IHaOErNMeJKOmGzF1bC5wu/AijdD
E9Kr+gWf/S3NZGdPLkmmGBYtKsgplbCcWMlImZKwmXFDr85H8BvEdFF5GjmqDL2bm/U4VQssxU4M
xlfbk0187TGPPH/aUO0lIh0IZxaUpC+86iGU/VnoD+LrrP3pBJnuUf9brZVAfXBhFrRvJlwwGFpD
6i960D3uyUJdHr6EOu/MnsxAjRTV2CP2VFsNnSzxBoCBnfXbnaYRDsidSwUSDAahsyuOaqsDzoYI
btTP0UBMFiNqJ2zHLw==
--000000000000048a5c0605edd44f--
