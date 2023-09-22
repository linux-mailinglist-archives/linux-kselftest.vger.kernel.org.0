Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60A67AAAB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjIVHsV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 03:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIVHsR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 03:48:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D66197
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 00:48:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-404f881aa48so82635e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Sep 2023 00:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695368889; x=1695973689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6trdNj+b2JqxCTEKkX+c1XYi9EeyDnkQGPjQmVOol+g=;
        b=Fc4SOOgUO2U4ufZkatcvrBx3BJmPgcOuTu1Q3N5MOWW2lle9vDzjaJCVUAYwhE94Ud
         GDeG65bmgrje9Lts29EomtvhMxXW/2qT/hjL2ox4NIqBF7/Nr+JOsjeqszrXbosMeP6t
         psvkPozfDMo4jt5ax73bOs2p3Yg5Zw9GS65bm1NabzE+kykBF9bMESzs3v78tGxPfUT9
         DOe4vSjApr7Cas+HI/jlazr4WORiZN3KzLZ+H6MMCo9IDvnBfFlBsQRG6EH1DqZnlmO+
         434iqwxwr6/d5kvhPrdSa7l+WoPWf11My737TYLaC+BBGaVbcVrO2VDXwvuaTyBnBgbD
         PeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695368889; x=1695973689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6trdNj+b2JqxCTEKkX+c1XYi9EeyDnkQGPjQmVOol+g=;
        b=MAifMoI26BDCg1BjsY5Hnu9LIkEbmWxG67tTLJfqyREsEkWzedZcWpmkTn0qtHLTQG
         l9dAEVX76d9Ld68dHx4QBPvCsjsBLIHJ39SkD6eUjP3ZCoe8tnmZTsGnAzEQ3OgaN+U4
         tMrpTZpfJWALUzVwHNFSMLfPsQYyCsE7PpppTHtJhqG1aqonJs76gJeq4qFUE08q6e24
         vrjGq7JLZ948tK88uF3I7VUrpnhW3bh4Bc6U02zkKzCyBbTEzueAh5e1c2LthwRzQnht
         J7MrV+dPOELmJ7BTwnZYe15iSa8yy2z6xMzako+XOV4+T9b5gCT90skfJsbBZMKy8X/T
         6qcA==
X-Gm-Message-State: AOJu0YwPrjESevJobO1bl3pMr1vI6JXzIwM3e77qNhlvLp5h9e9CD/z/
        BcxWmKuuOaO+Xmn3WrOD5+7wvosEIdpIm1xZwtTzhA==
X-Google-Smtp-Source: AGHT+IETga4GhRSSiGGPrpRmwZmWKsAmkR3WKnJTNKRKXjvk3jvEuZfYQFBfa+naVKfA8xRTret//4SpsEhc/zY3K4s=
X-Received: by 2002:a05:600c:5102:b0:405:35bf:7362 with SMTP id
 o2-20020a05600c510200b0040535bf7362mr52954wms.0.1695368889512; Fri, 22 Sep
 2023 00:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230922071020.2554677-1-ruanjinjie@huawei.com> <20230922071020.2554677-4-ruanjinjie@huawei.com>
In-Reply-To: <20230922071020.2554677-4-ruanjinjie@huawei.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 22 Sep 2023 15:47:57 +0800
Message-ID: <CABVgOSkYP196nDscFaNkbDTLsWCTupDWubKTSB7jMnHz1_6_wg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] kunit: Fix possible memory leak in kunit_filter_suites()
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, skhan@linuxfoundation.org,
        dlatypov@google.com, rmoar@google.com,
        janusz.krzysztofik@linux.intel.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000070d5af0605edd4ff"
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

--00000000000070d5af0605edd4ff
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Sept 2023 at 15:11, 'Jinjie Ruan' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> If the outer layer for loop is iterated more than once and it fails not
> in the first iteration, the filtered_suite and filtered_suite->test_cases
> allocated in the last kunit_filter_attr_tests() in last inner for loop
> is leaked.
>
> So add a new free_filtered_suite err label and free the filtered_suite
> and filtered_suite->test_cases so far. And change kmalloc_array of copy
> to kcalloc to Clear the copy to make the kfree safe.
>
> Fixes: 5d31f71efcb6 ("kunit: add kunit.filter_glob cmdline option to filter suites")
> Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Rae Moar <rmoar@google.com>
> ---
> v2:
> - Add Reviewed-by.
> ---

This looks good to me. There are a couple of things in this code which
probably could be cleaned up (as I noted in v2), but that's something
we can do separately.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/executor.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 9358ed2df839..1236b3cd2fbb 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -157,10 +157,11 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>         struct kunit_suite_set filtered = {NULL, NULL};
>         struct kunit_glob_filter parsed_glob;
>         struct kunit_attr_filter *parsed_filters = NULL;
> +       struct kunit_suite * const *suites;
>
>         const size_t max = suite_set->end - suite_set->start;
>
> -       copy = kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
> +       copy = kcalloc(max, sizeof(*filtered.start), GFP_KERNEL);
>         if (!copy) { /* won't be able to run anything, return an empty set */
>                 return filtered;
>         }
> @@ -195,7 +196,7 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>                                         parsed_glob.test_glob);
>                         if (IS_ERR(filtered_suite)) {
>                                 *err = PTR_ERR(filtered_suite);
> -                               goto free_parsed_filters;
> +                               goto free_filtered_suite;
>                         }
>                 }
>                 if (filter_count > 0 && parsed_filters != NULL) {
> @@ -212,11 +213,11 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>                                 filtered_suite = new_filtered_suite;
>
>                                 if (*err)
> -                                       goto free_parsed_filters;
> +                                       goto free_filtered_suite;
>
>                                 if (IS_ERR(filtered_suite)) {
>                                         *err = PTR_ERR(filtered_suite);
> -                                       goto free_parsed_filters;
> +                                       goto free_filtered_suite;
>                                 }
>                                 if (!filtered_suite)
>                                         break;
> @@ -231,6 +232,14 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>         filtered.start = copy_start;
>         filtered.end = copy;
>
> +free_filtered_suite:
> +       if (*err) {
> +               for (suites = copy_start; suites < copy; suites++) {
> +                       kfree((*suites)->test_cases);
> +                       kfree(*suites);
> +               }
> +       }
> +
>  free_parsed_filters:
>         if (filter_count)
>                 kfree(parsed_filters);
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230922071020.2554677-4-ruanjinjie%40huawei.com.

--00000000000070d5af0605edd4ff
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDo
3XyJXJZeJKZtxZ7CNsn+Rx1xyEsR19uM6sF25kDG1TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MjIwNzQ4MDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAEN8+3DSTfNsXFljpX6lD
8jUzcLJwbAPrNxuaRzf4TKlQLMTsbUbSlFoeLq6/G89SYJkb6JJNj+rPejGoqLeEbNZB951Phkk6
xRxgk1ANE7xRhmFUdes+4uUFbrYysNVfrgJDGnGmP9o8T9w4dVzyhfV3FdFl5TefSrWCouZtD0ld
TSqzbedypyhcP+QCF0GkwtjOJuCEoJIB614bJ2dQiA7EHa9Bt/SqH4HQUoA+1s0cO8pq/9NNoBj5
x3Zs+0BAtvzAK5wsP2ys15cBwKmTtbSRNmc1zRrDHPkoO6Ffsu73jH/WcV+ldeuNbX2d4/BG26Mq
tSozu0ueHVBqLzOWKg==
--00000000000070d5af0605edd4ff--
