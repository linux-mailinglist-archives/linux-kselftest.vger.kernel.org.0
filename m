Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8C0757575
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 09:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjGRHjV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 03:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjGRHjT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 03:39:19 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A2210E0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 00:39:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so60875e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 00:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689665955; x=1692257955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6GTed9SNLiPJnFwgilY3yaxxXZjEGTnEZZXRndb1swI=;
        b=s/i37XqjEr2T8JsaG19Edmdqzpm2Om9h15TuGvYYkFfCgfg8dory6jzmq0aZ2p+60o
         YJvG/B4MXK447Nk/Z7dJRy1uzKPlspbkr1ADQhVSB6z+a6R9wXC1hoU/7L4Nl3CJfzJP
         NXMq3dqF37mIEIyaUfNwYbX6wdUmeJ7PPrFD2l9okUx+YMumcOurxI2fnLiAYCLq3DXC
         IQhJqvCLFE9zv2tTohn5rJz90AYms6dyKIBHL6w3QGHp63C3jkbRs4xKQqNxUajmKh+a
         8NyzH9LdBKe3y8UMxv6YmrcAtcVdI+rfgRFQ0YCUDlWzWhTX0fl+NeyEI0VmAL0gs0BN
         ds6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689665955; x=1692257955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GTed9SNLiPJnFwgilY3yaxxXZjEGTnEZZXRndb1swI=;
        b=hT+aV3dud/owtn+0fJW3HKBsBlz8OzxWuifkGSla5WHKQJC65+qklCgCh3TTSSgDu7
         S4i8X1HfEOKTVsFdo7c8+cGorGKiqiqYugBIujHP3NR7PLqt6wgVd9sTWxl6CVDGLqES
         J6SMarx6SY6vJUrSbFAbyoHSdMQtwDYN1ZtUPuIfbgWPyt0Mw0gxIeCavQrWm+cLejqP
         X9DXUFqsGVMamlIxjYlFxpI3lceU+75l2BWIkbnAD7fi1XQzOpw17KnsxUc0wpohUtDm
         X7ZA05VutD7E+wb482Y1TsOpmw0TazEO3kdTtU9CdA59664QPQYxolSte2R02i0TGYmA
         hWdw==
X-Gm-Message-State: ABy/qLYp1T38dEkKqMVi3RqsC/r1GV6wvZCLJtSkU+cRB/9QRojqbxNX
        dgkCnUa6HSThl6m0j+f8J+Rf/+jLeRAq/IpPLD895g==
X-Google-Smtp-Source: APBJJlGecDn/73hjUqYjyLVtT6Io4VoObOCgRnxcWfmMeyqTmuA/I5Gu7pQdfJYFbWXl5/qe4pfTbwPMEejg8hFnKKk=
X-Received: by 2002:a05:600c:1497:b0:3f7:3654:8d3 with SMTP id
 c23-20020a05600c149700b003f7365408d3mr76964wmh.2.1689665955321; Tue, 18 Jul
 2023 00:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com> <20230707210947.1208717-4-rmoar@google.com>
In-Reply-To: <20230707210947.1208717-4-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 18 Jul 2023 15:39:03 +0800
Message-ID: <CABVgOS=V2uAS3NvToM2kd0YYvY2=8PbnH0ex88XbUoxkqn1i+g@mail.gmail.com>
Subject: Re: [RFC v2 3/9] kunit: Add module attribute
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001320500600be0396"
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

--0000000000001320500600be0396
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Jul 2023 at 05:09, Rae Moar <rmoar@google.com> wrote:
>
> Add module attribute to the test attribute API. This attribute stores the
> module name associated with the test using KBUILD_MODNAME.
>
> The name of a test suite and the module name often do not match. A
> reference to the module name associated with the suite could be extremely
> helpful in running tests as modules without needing to check the codebase.
>
> This attribute will be printed for each suite.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---
>

This has already been convenient for me, thanks.

Reviewed-by: David Gow <davidgow@google.com>


-- David

> Changes: since v1:
> - This is a new patch.
>
>  include/kunit/test.h   | 13 ++++++++-----
>  lib/kunit/attributes.c | 28 +++++++++++++++++++++++++++-
>  2 files changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index c255c98a58f7..cdfc3f42e899 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -129,6 +129,7 @@ struct kunit_case {
>
>         /* private: internal use only. */
>         enum kunit_status status;
> +       char *module_name;
>         char *log;
>  };
>
> @@ -153,7 +154,9 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>   * &struct kunit_case object from it. See the documentation for
>   * &struct kunit_case for an example on how to use it.
>   */
> -#define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
> +#define KUNIT_CASE(test_name)                  \
> +               { .run_case = test_name, .name = #test_name,    \
> +                 .module_name = KBUILD_MODNAME}
>
>  /**
>   * KUNIT_CASE_ATTR - A helper for creating a &struct kunit_case
> @@ -165,7 +168,7 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>   */
>  #define KUNIT_CASE_ATTR(test_name, attributes)                 \
>                 { .run_case = test_name, .name = #test_name,    \
> -                 .attr = attributes }
> +                 .attr = attributes, .module_name = KBUILD_MODNAME}
>
>  /**
>   * KUNIT_CASE_SLOW - A helper for creating a &struct kunit_case
> @@ -176,7 +179,7 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>
>  #define KUNIT_CASE_SLOW(test_name)                     \
>                 { .run_case = test_name, .name = #test_name,    \
> -                 .attr.speed = KUNIT_SPEED_SLOW }
> +                 .attr.speed = KUNIT_SPEED_SLOW, .module_name = KBUILD_MODNAME}
>
>  /**
>   * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
> @@ -197,7 +200,7 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>   */
>  #define KUNIT_CASE_PARAM(test_name, gen_params)                        \
>                 { .run_case = test_name, .name = #test_name,    \
> -                 .generate_params = gen_params }
> +                 .generate_params = gen_params, .module_name = KBUILD_MODNAME}
>
>  /**
>   * KUNIT_CASE_PARAM_ATTR - A helper for creating a parameterized &struct
> @@ -211,7 +214,7 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>  #define KUNIT_CASE_PARAM_ATTR(test_name, gen_params, attributes)       \
>                 { .run_case = test_name, .name = #test_name,    \
>                   .generate_params = gen_params,                                \
> -                 .attr = attributes }
> +                 .attr = attributes, .module_name = KBUILD_MODNAME}
>
>  /**
>   * struct kunit_suite - describes a related collection of &struct kunit_case
> diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
> index e97096dbb3b1..43dcb5de8b8f 100644
> --- a/lib/kunit/attributes.c
> +++ b/lib/kunit/attributes.c
> @@ -61,6 +61,12 @@ static const char *attr_speed_to_string(void *attr, bool *to_free)
>         return attr_enum_to_string(attr, speed_str_list, to_free);
>  }
>
> +static const char *attr_string_to_string(void *attr, bool *to_free)
> +{
> +       *to_free = false;
> +       return (char *) attr;
> +}
> +
>  /* Get Attribute Methods */
>
>  static void *attr_speed_get(void *test_or_suite, bool is_test)
> @@ -74,6 +80,18 @@ static void *attr_speed_get(void *test_or_suite, bool is_test)
>                 return ((void *) suite->attr.speed);
>  }
>
> +static void *attr_module_get(void *test_or_suite, bool is_test)
> +{
> +       struct kunit_suite *suite = is_test ? NULL : test_or_suite;
> +       struct kunit_case *test = is_test ? test_or_suite : NULL;
> +
> +       // Suites get their module attribute from their first test_case
> +       if (test)
> +               return ((void *) test->module_name);
> +       else
> +               return ((void *) suite->test_cases[0].module_name);
> +}
> +
>  /* Attribute Struct Definitions */
>
>  static const struct kunit_attr speed_attr = {
> @@ -84,9 +102,17 @@ static const struct kunit_attr speed_attr = {
>         .print = PRINT_ALWAYS,
>  };
>
> +static const struct kunit_attr module_attr = {
> +       .name = "module",
> +       .get_attr = attr_module_get,
> +       .to_string = attr_string_to_string,
> +       .attr_default = (void *)"",
> +       .print = PRINT_SUITE,
> +};
> +
>  /* List of all Test Attributes */
>
> -static struct kunit_attr kunit_attr_list[] = {speed_attr};
> +static struct kunit_attr kunit_attr_list[] = {speed_attr, module_attr};
>
>  /* Helper Functions to Access Attributes */
>
> --
> 2.41.0.255.g8b1d071c50-goog
>

--0000000000001320500600be0396
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA7
VWV3upR1g1fAZmfEgV2Ul6NJp2Wo8MZ1eoDplS651zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA3MTgwNzM5MTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAIsGdxXQoFr7/KOaRv90l
keQZ89dCTrOhCkq/vlXBEHw/TBApXCIJBNPa30qw+3sPSAgfxZvW6CaDBP/Edm2/ug7vC3glKKhY
imlcAZeXPpZZwAjPWWNCxu7gqznmSxseAvbQijf279b8ZpUT+MIedfJoLCvyCF/2w1S3Ty2ujzkM
AYkW/VIcoO5n9zzaVfYkSawfdn0Ic8zWKgq4n5syqbzPmdN+++pS8SjTsZQn+fKNdlE3z7qTeeSu
qp/5ewfF0X0VWLDHx8NOQ8AoH6U/NbUc+HGiW/cKjMbJZN3+AjDxXH46jYi+g9qVp7mCK1oWJSjU
D50oTv9BOB0XIVi08A==
--0000000000001320500600be0396--
