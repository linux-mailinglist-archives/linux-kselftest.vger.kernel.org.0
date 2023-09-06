Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA21793584
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 08:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbjIFGp7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 02:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjIFGp7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 02:45:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEEAE52
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Sep 2023 23:45:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso41005e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Sep 2023 23:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693982750; x=1694587550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WrrxV9K8gRq8tFtzR8KUHE52vlpgIf+HZCmiNf37goI=;
        b=gkHmJGKDwbQsxyPzts5f8uWcEYrDZRmgKxXyMKA+9J+KYODL3oB42JczsXJwb9XNkN
         q+imJK9utfa+3wJbwpkfSB95sX6mQ5e1i3AsvpTXdO2Z1EVXA3iC8QpTDcdpHOfrVaYX
         cOAmtYIqeozAST33/qd6tGU17ETzVViJVQrXJZBLygUVEH6X/Jk3pQpoAL4z1HmrpU0W
         IRXXQSNOzTInzd9netjvixDngwru99vvZvyaCIzrp+UFTSVIcHlF6+1LHy//WAsDY0Kz
         T0Rm1oSGkbLbFuAFentSt0PpLE2l/VfT2MZJy+cX1t6HQBJNc2KgFN/+cosK0C/U0AjX
         Kljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693982750; x=1694587550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrrxV9K8gRq8tFtzR8KUHE52vlpgIf+HZCmiNf37goI=;
        b=fPM1r38lF1JnmdY+VMGbp1hX7dtOJd1+01YUfPQaEv8TmHK74pefL8fbBbBmxDrsoi
         XjyVEfMWliM93s0b3KBTaRqvatnqenTKNRuS+8eamS9Y3LW/bX7P2NnwGbuLOWU9eUFR
         UBGJqL07doFNsEWl+HhqzgOJ7ctxuN6+0wvEh4/IQmfrf4zWf92U4r594yZgOk1eXurk
         FQImjArOp3JsNzkOW/XehQ+7hdDLs5A/vEfTw5KvgKFK4puIoJ8dq/FzER2KqqCFqrpA
         VaxE4nY6VrNWfre74z3Ny6romTBCsJn6MsURX+QgA3unK1hwfrbyQPLvV4xvKy6w3MfQ
         CaEQ==
X-Gm-Message-State: AOJu0YwWaVUThr7ULZYDtJN9LfI8tTX3P1UGW/ejKgJGpmGJKn135iBE
        GSkWquJpG0GYLA0TwTpM0L5QCxNDQ2HrZ3FaHh/Tow==
X-Google-Smtp-Source: AGHT+IFJ7zjbOIVDpY7YVsBQrCrd8MM6PXqJj9yMxGK+8Fz2v85IWPUU2LLFKmvJGCDttOqZLSPZysvd7qsTOAGW0cs=
X-Received: by 2002:a05:600c:1c11:b0:3f7:e4d8:2569 with SMTP id
 j17-20020a05600c1c1100b003f7e4d82569mr57331wms.5.1693982750352; Tue, 05 Sep
 2023 23:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230904132139.103140-1-benjamin@sipsolutions.net>
In-Reply-To: <20230904132139.103140-1-benjamin@sipsolutions.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 6 Sep 2023 14:45:36 +0800
Message-ID: <CABVgOSkvVX3D-fgmO-w6eJm7fxQL1T-tVJ6oMVQVhEn98Bmdqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: add parameter generation macro using
 description from array
To:     benjamin@sipsolutions.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Benjamin Berg <benjamin.berg@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001df6c30604ab18c5"
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

--0000000000001df6c30604ab18c5
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Sept 2023 at 21:22, <benjamin@sipsolutions.net> wrote:
>
> From: Benjamin Berg <benjamin.berg@intel.com>
>
> The existing KUNIT_ARRAY_PARAM macro requires a separate function to
> get the description. However, in a lot of cases the description can
> just be copied directly from the array. Add a second macro that
> avoids having to write a static function just for a single strscpy.
>
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---

Looks good to me: this will be much more convenient. The actual
implementation looks spot on, just a small comment about the
documentation change.

It may make sense to write some tests and/or some follow-up patches to
existing tests to use this macro, too. I'm just a little wary of
introducing something totally unused. (I'm happy to do these myself if
you don't have time, though.)

Regardless, with the documentation fix, this is:
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/kunit/usage.rst |  7 ++++---
>  include/kunit/test.h                    | 19 +++++++++++++++++++
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index c27e1646ecd9..fe8c28d66dfe 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -571,8 +571,9 @@ By reusing the same ``cases`` array from above, we can write the test as a
>         {
>                 strcpy(desc, t->str);
>         }
> -       // Creates `sha1_gen_params()` to iterate over `cases`.
> -       KUNIT_ARRAY_PARAM(sha1, cases, case_to_desc);
> +       // Creates `sha1_gen_params()` to iterate over `cases` while using
> +       // the struct member `str` for the case description.
> +       KUNIT_ARRAY_PARAM_DESC(sha1, cases, str);

I'd suggest either getting rid of the case_to_desc function totally
here, or show both the manual KUNIT_ARRAY_PARAM() example, and then
point out explicitly that KUNIT_ARRAY_PARAM_DESC() can replace it.

Otherwise we end up with a vestigial function which doesn't do
anything and is confusing.


>
>         // Looks no different from a normal test.
>         static void sha1_test(struct kunit *test)
> @@ -588,7 +589,7 @@ By reusing the same ``cases`` array from above, we can write the test as a
>         }
>
>         // Instead of KUNIT_CASE, we use KUNIT_CASE_PARAM and pass in the
> -       // function declared by KUNIT_ARRAY_PARAM.
> +       // function declared by KUNIT_ARRAY_PARAM or KUNIT_ARRAY_PARAM_DESC.
>         static struct kunit_case sha1_test_cases[] = {
>                 KUNIT_CASE_PARAM(sha1_test, sha1_gen_params),
>                 {}
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 68ff01aee244..f60d11e41855 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1516,6 +1516,25 @@ do {                                                                            \
>                 return NULL;                                                                    \
>         }
>
> +/**
> + * KUNIT_ARRAY_PARAM_DESC() - Define test parameter generator from an array.
> + * @name:  prefix for the test parameter generator function.
> + * @array: array of test parameters.
> + * @desc_member: structure member from array element to use as description
> + *
> + * Define function @name_gen_params which uses @array to generate parameters.
> + */
> +#define KUNIT_ARRAY_PARAM_DESC(name, array, desc_member)                                       \
> +       static const void *name##_gen_params(const void *prev, char *desc)                      \
> +       {                                                                                       \
> +               typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);      \
> +               if (__next - (array) < ARRAY_SIZE((array))) {                                   \
> +                       strscpy(desc, __next->desc_member, KUNIT_PARAM_DESC_SIZE);              \
> +                       return __next;                                                          \
> +               }                                                                               \
> +               return NULL;                                                                    \
> +       }
> +
>  // TODO(dlatypov@google.com): consider eventually migrating users to explicitly
>  // include resource.h themselves if they need it.
>  #include <kunit/resource.h>
> --
> 2.41.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230904132139.103140-1-benjamin%40sipsolutions.net.

--0000000000001df6c30604ab18c5
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBw
9x327beZmAvfo3gxtFhIh1ldyK2SdaV1/OKVSUZqxzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MDYwNjQ1NTBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAce2L7mjmP2pKd0MTxEGB
1rPomLxciJ/cKTaFci1ZkKDrd0OQaqe3fAA9oJofPdM9n0rkOc5GTEVSSlTz+47BcKrluGeHfClK
3kvySP4iIGJjiqEONY+0wdryHLwT2VrRC60Lzw9FrYZdV8Hivj34CnBiML3IsCu4B8zO/3fBvcdl
vC5jNonH1estKCuilCn0ntLjYNkvIx8Oj5I/s9lZngG3oGqurtl8Qa5fCULaG/YGnmPiiRbRDUIu
UOyW6pfQznEtO2EIqzSad0L1yCW1atJwMfRutjo5Em0kTLifJAFtsf4qpLuyHUSRx/elGWVRKXaH
EAkUosECqnp/6+6Wbg==
--0000000000001df6c30604ab18c5--
