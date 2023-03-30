Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7DA6CFB63
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 08:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjC3GRe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 02:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC3GRd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 02:17:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1257140DD
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 23:17:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so10984075wms.2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 23:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680157050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f9jA5pONXkWYKKh6ImaL4CDIbobIYcz/Kp1zbJpbc+k=;
        b=nDnHOuwyqaP1Yiw20nMG5SX3/nZNIjVdmhVVfcQMS5fdyf0Wb8geH4VmRTfJZejULm
         iXTauOUJ1+VQ/4kcxDhF1CSeIcyWTlc2jqWCMbzNG/asi/nHj3t0W643IwzwIzagN6Zc
         okSrGR3kUG+KUCBzZgKDNge3r+r7am1TeR/BeY1bpHF5/e6e4tkcKA/9HWIMZGE/+U3q
         9ntdq3+t+gSxBl26OD/PrInw2CY/bVlKwRzlqkh3DQU6612i3vcB/rGX4c1npaSVU09X
         mZ3hlq3x4WqjN4POUeMR637+aUKEExH/pz51KSgWfWz95eq+/gqx2mU/zWdYAbwcKZvn
         62gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680157050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9jA5pONXkWYKKh6ImaL4CDIbobIYcz/Kp1zbJpbc+k=;
        b=DCV9x+vmtPp83BwKLisHlxfKx3icxVtbjenXRgPqhEvcMyblnbWZ0qkG2zix/5DUXM
         g7bu4ZMXfeZY98EV6aqGd/YdUPLZrMoJE/c1SYo/J0GyNemgLHjIiO88z+TcHNFUgc49
         cNCeFn2OzB9Dln+jfrhTZlAhZ5dV5GKus/ubdSQu4AMj8CgTwkSYP2n5gUHl9XEUChYc
         dIwW55yh4aTQ51M5jikUjyM32SafXVg5Brb97c0y5HeOpOlbCtc5UGM0ZjNlRq7pSH1Z
         nH10U7IzfZc4OqR8QRoHr1hhmwQQiI0W27OCP3dVK+tXKYQeaxd5K+XscTbgRo6y7AVK
         g5zA==
X-Gm-Message-State: AAQBX9c1oWLeXQwnWFQAwrJLMG/S3gOSiMD/JVT84FW8rhgFjdrHiBVq
        qqWp86vewVBXQ+UXfxnwOwf+xCsPuHoYMIsbR3YTtA==
X-Google-Smtp-Source: AKy350YZk0oXtjZWx7hNAQJkxLSUijCrG/dysAFpxA4w10aYo8HAWOf3jLSvuAOGDbcr0aqIPlmKV7OsO0l2djebcSI=
X-Received: by 2002:a05:600c:1ca2:b0:3ed:dc54:5c18 with SMTP id
 k34-20020a05600c1ca200b003eddc545c18mr1886067wms.3.1680157050395; Wed, 29 Mar
 2023 23:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230329172311.71861-1-benjamin@sipsolutions.net> <20230329172311.71861-2-benjamin@sipsolutions.net>
In-Reply-To: <20230329172311.71861-2-benjamin@sipsolutions.net>
From:   David Gow <davidgow@google.com>
Date:   Thu, 30 Mar 2023 14:17:19 +0800
Message-ID: <CABVgOSkcT0f5ex6E_cbepy4R2=qmSdVwgv0XLjaFp=rg=jDzbg@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: add ability to register a simple cleanup function
To:     benjamin@sipsolutions.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Johannes Berg <johannes@sipsolutions.net>,
        Benjamin Berg <benjamin.berg@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002d54e105f8180cf9"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000002d54e105f8180cf9
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Mar 2023 at 01:23, <benjamin@sipsolutions.net> wrote:
>
> From: Benjamin Berg <benjamin.berg@intel.com>
>
> This is useful to e.g. automatically free resources at the end of the
> test, without having to deal with kunit resource objects directly.
>
> The whole point of doing this is that the callback is guaranteed to
> happen in case the test aborts (due to an assertion). As such, use
> assertions internally rather than requiring further error checking by
> the API user.
>
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---

Thanks!

I've actually been working on something similar here:
https://lore.kernel.org/linux-kselftest/20230325043104.3761770-2-davidgow@google.com/

Maxime suggested that it might be worth naming this kunit_add_action()
for consistency with devm_add_action(). We also need the cancel/remove
and trigger/release helpers for some of the other device helpers.

Hopefully between these, we can have something which works for everyone.

Cheers,
-- David




>  include/kunit/test.h | 20 ++++++++++++++++++++
>  lib/kunit/test.c     | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 519b90261c72..ab1dacf1c9f4 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -373,6 +373,26 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
>         return kunit_kmalloc_array(test, n, size, gfp | __GFP_ZERO);
>  }
>
> +typedef void (*kunit_cleanup_t)(const void *);
> +
> +/**
> + * kunit_add_cleanup() - Add post-test cleanup action.
> + * @test: The test case to which the resource belongs.
> + * @cleanup_func: function to call at end of test.
> + * @data: data to pass to @free_func.
> + * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
> + *
> + * This adds a cleanup action to be executed after the test completes.
> + * Internally this is handled using a *test managed resource*.
> + *
> + * This function will abort the test on failure.
> + *
> + * Note: KUnit needs to allocate memory for a kunit_resource object. You must
> + * specify an @internal_gfp that is compatible with the current context.
> + */
> +void kunit_add_cleanup(struct kunit *test, kunit_cleanup_t cleanup_func,
> +                      const void *data, gfp_t internal_gfp);
> +
>  void kunit_cleanup(struct kunit *test);
>
>  void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c9e15bb60058..72d956dfc324 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -719,6 +719,43 @@ void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp)
>  }
>  EXPORT_SYMBOL_GPL(kunit_kmalloc_array);
>
> +struct kunit_auto_cleanup {
> +       struct kunit_resource resource;
> +       kunit_cleanup_t cleanup_func;
> +};
> +
> +static void kunit_auto_cleanup_free(struct kunit_resource *res)
> +{
> +       struct kunit_auto_cleanup *cleanup;
> +
> +       cleanup = container_of(res, struct kunit_auto_cleanup, resource);
> +
> +       cleanup->cleanup_func(cleanup->resource.data);
> +}
> +
> +void kunit_add_cleanup(struct kunit *test, kunit_cleanup_t cleanup_func,
> +                      const void *data, gfp_t internal_gfp)
> +{
> +       struct kunit_auto_cleanup *res;
> +
> +       KUNIT_ASSERT_NOT_NULL_MSG(test, cleanup_func,
> +                                 "Cleanup function must not be NULL");
> +
> +       res = kzalloc(sizeof(*res), internal_gfp);
> +       if (!res) {
> +               cleanup_func(data);
> +               KUNIT_ASSERT_FAILURE(test, "Could not allocate resource for cleanup");
> +       }
> +
> +       res->cleanup_func = cleanup_func;
> +       res->resource.should_kfree = true;
> +
> +       /* Cannot fail as init is NULL */
> +       __kunit_add_resource(test, NULL, kunit_auto_cleanup_free,
> +                            &res->resource, (void *)data);
> +}
> +EXPORT_SYMBOL_GPL(kunit_add_cleanup);
> +
>  static inline bool kunit_kfree_match(struct kunit *test,
>                                      struct kunit_resource *res, void *match_data)
>  {
> --
> 2.39.2
>

--0000000000002d54e105f8180cf9
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB7
XoLz5JWZijpPX64+g1+8Xc4g+QiwsCLLcn61l56cfTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMzAwNjE3MzBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAMaQtS4ExOw0n7fEk2PdD
Pv7u5hTzd5noM1La+xwFtKvr6V+jojv+g4znxJzHU3CSGniri8+vjUqmKReMNK3F1wJ0ci/cCyck
yj0xQD0BKHTh48yZTDCw1C1nvExGTwqqYSrSanoEjFVl/Yv1mEovUYbfCt+g1Sy9xXIm4QaKYSUi
7xHNZh8SW2pX43n8E4BtVeWzHYZymtmAbYVn4pxTFCguR4cxoWXD4lEuT+A3Zu3+m8IoRCT/O6gK
EcnXHOBaKkBbyJHR+Wrnr9f420lwCQBuo5AT8scukyttrJUvH4gLf+Aj83UETb1nGB9ZJv1FXlP2
6V4z6cPKYLGMI44+5Q==
--0000000000002d54e105f8180cf9--
