Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20007B3F8C
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Sep 2023 10:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjI3I6w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 30 Sep 2023 04:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3I6w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 30 Sep 2023 04:58:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D9D1A5
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Sep 2023 01:58:49 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4063bfc6c03so40235e9.0
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Sep 2023 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696064328; x=1696669128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ka+59Az1AJnNzm9tN9A2lH0/cm3R3FlakeuVf7qxAc=;
        b=U13FWhP2g0lAwbd3L7ihn6VVozLC67CzHi5Rx9oo42I2ujZfVkAruKhHAkIqEbSTlz
         pMIRHRsc05ONHLTG6X3q9nFrzFqATKkeRjVN9BKnofyYNHH89zrujJq9FKdoAlKqfYUY
         u5T0wAQafIMgX58rrWMHLVsZM4EUSWUnvXtzoJYqzQaP6RYe8sk7+7bqv5Gdg9np/Lj9
         J9QBmmG9Msev2/T3J/IZ0NzMMVIvd9cWut+QOYMjzo0tVVZu+WWJwxHy8XJQTFjclHLX
         FNSuD1XaOsYsApdMuXs+Tu3XJFD+GfdS10a5KQa4OUGe1AjOQ1tqH2n/vqIJGLLg3Jea
         +LoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696064328; x=1696669128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ka+59Az1AJnNzm9tN9A2lH0/cm3R3FlakeuVf7qxAc=;
        b=e2Y9QOHx/KCN/qUjX9LgjUOu0nna2zLjgqW71jL9WLXYf0pqYK0o3CU2bP3gN5RPQt
         dgZyXZg693VISCd6ytuCpr1w96pgbfzvlr1KWeFjnUIWa3KdkdeQpFHY1RXbwe88Z5zs
         eZJgojn/bFDqwGdF0X9M7mWhAa89ai5bgilptmrSEzuOp0LmHxJWRHbB4Q4wp03S55HS
         2niD4ynj0cNRd9RmvWorN3qsKVF5nt4coUIEQSdTFRNqOiNavlczUkN0w/pmI6bAo6Qe
         f4e3I93iv9Kc2DPjBGWMmj4N7jzsNFHxwIHzt68zT1qjnderXAD1rKuxroXVMVrIDEZN
         cTRQ==
X-Gm-Message-State: AOJu0YygKLpBWYzk/tusda3UQjKVn0evNkh3PHNfVu3u7Gi/J/rT1nXl
        WcvYm5u2eZWMHRIuhGagjHZLLOHEtLN9iJ1oGHzggQ==
X-Google-Smtp-Source: AGHT+IH1kZz2X2qDjjDOEJh8GArpoeRfEXPF0ki3+hn9Q0AWDG4h8uVV5/DESoahPYxVApFqg4Yqs9lCSnK5FSm8ukI=
X-Received: by 2002:a7b:cd99:0:b0:406:4e80:b8ef with SMTP id
 y25-20020a7bcd99000000b004064e80b8efmr33957wmj.6.1696064327951; Sat, 30 Sep
 2023 01:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230926220208.1423-1-michal.wajdeczko@intel.com> <20230926220208.1423-2-michal.wajdeczko@intel.com>
In-Reply-To: <20230926220208.1423-2-michal.wajdeczko@intel.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 30 Sep 2023 16:58:35 +0800
Message-ID: <CABVgOSkchs02HpfHZWZWSXe6X5U6nfPTDM1_-RDKybm2oixnFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: Allow to filter entries from zero terminated arrays
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Rae Moar <rmoar@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d0b0d806068fbfd9"
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

--000000000000d0b0d806068fbfd9
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Sept 2023 at 06:02, Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> In some cases we may want to generate params based on existing
> zero terminated array, but with some entries filtered out.
> Extend macro KUNIT_ZERO_ARRAY_PARAM to accept filter function
> and provide example how to use it.
>
> $ ./tools/testing/kunit/kunit.py run \
>     --kunitconfig ./lib/kunit/.kunitconfig *.example_params*
>
> [ ] Starting KUnit Kernel (1/1)...
> [ ] ============================================================
> [ ] ========================= example  =========================
> [ ] =================== example_params_test  ===================
> [ ] [SKIPPED] example value 3
> [ ] [PASSED] example value 2
> [ ] [PASSED] example value 1
> [ ] [SKIPPED] example value 0
> [ ] =============== [PASSED] example_params_test ===============
> [ ] =================== example_params_test  ===================
> [ ] [SKIPPED] example value 3
> [ ] [PASSED] example value 2
> [ ] [PASSED] example value 1
> [ ] =============== [PASSED] example_params_test ===============
> [ ] =================== example_params_test  ===================
> [ ] [PASSED] example value 2
> [ ] [PASSED] example value 1
> [ ] =============== [PASSED] example_params_test ===============
> [ ] ===================== [PASSED] example =====================
> [ ] ============================================================
> [ ] Testing complete. Ran 9 tests: passed: 6, skipped: 3
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> ---

I tend to agree with Rae here that this is:
a) starting to get quite specific, and might be better served by a
per-test generator function than a generic helper here, and
b) probably would need to be implemented for both  ZERO_ARRAY_PARAM
and the regular ARRAY_PARAM, for consistency's sake.

I'd probably err on the side of letting tests implement something like
this themselves, and then reconsider a helper macro once there are
several tests all using the same thing. If, for example, all the users
of this are just checking PCI ids, or something, it may make more
sense to just have a PCI-specific macro they can share.

Regardless, I'd love to see a real-world example of this being used,
which may make it seem less niche.

Thanks,
-- David

>  include/kunit/test.h           | 19 +++++++++++++++++--
>  lib/kunit/kunit-example-test.c |  9 +++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 280113ceb6a6..8a87d1ce37e0 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1515,20 +1515,24 @@ do {                                                                           \
>         }
>
>  /**
> - * KUNIT_ZERO_ARRAY_PARAM() - Define test parameter generator from a zero terminated array.
> + * KUNIT_FILTERED_ZERO_ARRAY_PARAM() - Define test parameter generator from a zero terminated array.
>   * @name:  prefix for the test parameter generator function.
>   * @array: zero terminated array of test parameters.
>   * @get_desc: function to convert param to description; NULL to use default
> + * @filter: function to filter out unwanted params (like duplicates); can be NULL
>   *
>   * Define function @name_gen_params which uses zero terminated @array to generate parameters.
>   */
> -#define KUNIT_ZERO_ARRAY_PARAM(name, array, get_desc)                                          \
> +#define KUNIT_FILTERED_ZERO_ARRAY_PARAM(name, array, get_desc, filter)                         \
>         static const void *name##_gen_params(const void *prev, char *desc)                      \
>         {                                                                                       \
>                 typeof((array)[0]) *__prev = prev;                                              \
>                 typeof(__prev) __next = __prev ? __prev + 1 : (array);                          \
>                 void (*__get_desc)(typeof(__next), char *) = get_desc;                          \
> +               bool (*__filter)(typeof(__prev), typeof(__next)) = filter;                      \
>                 for (; memchr_inv(__next, 0, sizeof(*__next)); __prev = __next++) {             \
> +                       if (__filter && !__filter(__prev, __next))                              \
> +                               continue;                                                       \
>                         if (__get_desc)                                                         \
>                                 __get_desc(__next, desc);                                       \
>                         return __next;                                                          \
> @@ -1536,6 +1540,17 @@ do {                                                                            \
>                 return NULL;                                                                    \
>         }
>
> +/**
> + * KUNIT_ZERO_ARRAY_PARAM() - Define test parameter generator from a zero terminated array.
> + * @name:  prefix for the test parameter generator function.
> + * @array: zero terminated array of test parameters.
> + * @get_desc: function to convert param to description; NULL to use default
> + *
> + * Define function @name_gen_params which uses zero terminated @array to generate parameters.
> + */
> +#define KUNIT_ZERO_ARRAY_PARAM(name, array, get_desc)  \
> +       KUNIT_FILTERED_ZERO_ARRAY_PARAM(name, array, get_desc, NULL)
> +
>  // TODO(dlatypov@google.com): consider eventually migrating users to explicitly
>  // include resource.h themselves if they need it.
>  #include <kunit/resource.h>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index ad9ebcfd513e..a3268754392c 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -201,8 +201,16 @@ static void example_param_get_desc(const struct example_param *p, char *desc)
>         snprintf(desc, KUNIT_PARAM_DESC_SIZE, "example value %d", p->value);
>  }
>
> +static bool example_param_filter(const struct example_param *prev,
> +                                const struct example_param *next)
> +{
> +       return next->value < 3;
> +}
> +
>  KUNIT_ARRAY_PARAM(example, example_params_array, example_param_get_desc);
>  KUNIT_ZERO_ARRAY_PARAM(example_zero, example_params_array, example_param_get_desc);
> +KUNIT_FILTERED_ZERO_ARRAY_PARAM(example_filter, example_params_array, example_param_get_desc,
> +                               example_param_filter);

I think we'd probably want some more comments around these examples,
just to make it a little clearer what the difference between these
features are and what results we should expect. The purpose the the
'example_test' is basically documentation, so I think we'll want to
either make this a clearer example of how/why you'd want to use this,
or leave it out of the examples (and just document it in the
documentation, and possibly test it in another kunit test).


>
>  /*
>   * This test shows the use of params.
> @@ -248,6 +256,7 @@ static struct kunit_case example_test_cases[] = {
>         KUNIT_CASE(example_static_stub_test),
>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
>         KUNIT_CASE_PARAM(example_params_test, example_zero_gen_params),
> +       KUNIT_CASE_PARAM(example_params_test, example_filter_gen_params),
>         KUNIT_CASE_SLOW(example_slow_test),
>         {}
>  };
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230926220208.1423-2-michal.wajdeczko%40intel.com.

--000000000000d0b0d806068fbfd9
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDr
aIEUyctSER30M+/RgpIcvdaPVfkzEGvU2zkaOxhNQDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MzAwODU4NDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAExDeFbZeOCZHhTiMEv+E
D5QRi1m6rKpa5koUPaO2IuHCplFyS0DcItRk2zik5Gu++awW2Lwtb6UKv9bCpFacHFDL+h+qoS1M
7jsOGW2tpWVODJn09RMJrFOI2l76YzYtmw3i5j+JmyLKFZ4enIB+lw1OPQFXI8/REy9oTPlDXN4X
WX+RBSoKYLBvdFqCe4E9rdAnR/NgU5klMsXYWmELX5vlcUi4J4S+EOSERHAmbw4RBDe5/gp50iNM
nmIxTZ98941Tvxh/wX1esZbBJ0ilDm/L/ouFkRY/wBh2oZ1RYdwSku4ITEPqeP1HOa1fCDfHhcGR
u5KFNFOaoM4IiEp1Rg==
--000000000000d0b0d806068fbfd9--
