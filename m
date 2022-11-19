Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07667630D45
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Nov 2022 09:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiKSIZE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Nov 2022 03:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiKSIZD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Nov 2022 03:25:03 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ED2ACEAD
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Nov 2022 00:25:02 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id d185so6892631vsd.0
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Nov 2022 00:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FEnk3lOFrjqHhhACgIGD4yMteD6QWFLnJ9Z0EekQw+0=;
        b=p/fmhPnfkRN3RTLlSZC4o/eFS3zAjErXJk33CMlXY+RU6P69Lf5oj292rpaSCi6XVl
         7JYcEV0bkGZsnDqnGM4ThBhtmqVZlBfX15yloIwIdsFQiP6n1rdgkG2HJrFhPwOgF9Lt
         GH0PRJyPqXsb7UyhM7uvVgxGGpgoePcJAZghetjvT3e54PiYh+pCTDx+hy+Rcc3MSl1y
         cIe0qSpemxpMg63nVfT7gM+bgZc1srFGZ/D3VtjVoZV8I3JN114/NQjtyDtWlyxwZbSm
         F9Gzd+PrHKX0JLl1uABMVrF2+UwxGzU+MWkK69qvMFcSbIfC/+lxvgX84o4zc2nG3O7Q
         ijNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEnk3lOFrjqHhhACgIGD4yMteD6QWFLnJ9Z0EekQw+0=;
        b=t731hCRvAmhPmZzy7oNnqpOKQlAo5ULUZxCAYsnr/AjAus4BEqB7RjDEqIoMCiHFp1
         0WCofj+UtLkHFJRuh/JZmAS2BxWrO74bCLfPJaWQilVcK59QwUdXIm7hnxSUzfNZdpbQ
         2wq6m/e7iLb7ZWy+ujcUmv0hTkFXsRI9damRHSQ+uKQdDEn4qV/A89HdvISNA+y2NWGB
         7/covwZUEqbrpwMjOTve77SmqlS0P490bxgTZwDTpS1fJ3nJs/df90nh+N0OHpCgtsAS
         pGgZV79I4JT7Azi3yRnoTX/vxuClZbCWxutEI5ktxh5eg1hi6XKKeXPlsbxPqiAsAZ5c
         LLnA==
X-Gm-Message-State: ANoB5pku3J872JwpZteJgt2EF1AL9sUP68CSkPvapawm4QJkEnN8H7IN
        BAKU/KC/7g6Ih050nrqCseFE63B386Y/Zu/6ps997KOQ5b0=
X-Google-Smtp-Source: AA0mqf49qoOsRCpYMDwP6CcFAB5kKqF06GSVrJmajFn7RtQr/k/AwUkJHIWh2+2rFUBEcLfSMbbsCQ632ckzzYE4RDM=
X-Received: by 2002:a05:6102:3c82:b0:3aa:17f4:d63d with SMTP id
 c2-20020a0561023c8200b003aa17f4d63dmr6226760vsv.22.1668846301727; Sat, 19 Nov
 2022 00:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20221109212032.123021-1-dlatypov@google.com>
In-Reply-To: <20221109212032.123021-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 19 Nov 2022 16:24:50 +0800
Message-ID: <CABVgOS=inucWN+gSar+fK5py-RDB2vq8pdr0WScMDGGf5oxo8Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: remove KUNIT_INIT_MEM_ASSERTION macro
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000004baa305edce8fba"
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

--00000000000004baa305edce8fba
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 10, 2022 at 5:20 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit 870f63b7cd78 ("kunit: eliminate KUNIT_INIT_*_ASSERT_STRUCT
> macros") removed all the other macros of this type.
>
> But it raced with commit b8a926bea8b1 ("kunit: Introduce
> KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros"), which added another
> instance.
>
> Remove KUNIT_INIT_MEM_ASSERTION and just use the generic
> KUNIT_INIT_ASSERT macro instead.
> Rename the `size` arg to avoid conflicts by appending a "_" (like we did
> in the previous commit).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Thanks for catching this. Looks good and works here.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  include/kunit/assert.h |  7 -------
>  include/kunit/test.h   | 12 ++++++------
>  2 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index 43144cfddc19..24c2b9fa61e8 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -192,13 +192,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>                                     const struct va_format *message,
>                                     struct string_stream *stream);
>
> -#define KUNIT_INIT_MEM_ASSERT_STRUCT(text_, left_val, right_val, size_) {      \
> -       .text = text_,                                                         \
> -       .left_value = left_val,                                                \
> -       .right_value = right_val,                                              \
> -       .size = size_                                                          \
> -}
> -
>  /**
>   * struct kunit_mem_assert - An expectation/assertion that compares two
>   *     memory blocks.
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index d7f60e8aab30..4666a4d199ea 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -666,13 +666,13 @@ do {                                                                             \
>                             left,                                              \
>                             op,                                                \
>                             right,                                             \
> -                           size,                                              \
> +                           size_,                                             \
>                             fmt,                                               \
>                             ...)                                               \
>  do {                                                                          \
>         const void *__left = (left);                                           \
>         const void *__right = (right);                                         \
> -       const size_t __size = (size);                                          \
> +       const size_t __size = (size_);                                         \
>         static const struct kunit_binary_assert_text __text = {                \
>                 .operation = #op,                                              \
>                 .left_text = #left,                                            \
> @@ -686,10 +686,10 @@ do {                                                                             \
>                       assert_type,                                             \
>                       kunit_mem_assert,                                        \
>                       kunit_mem_assert_format,                                 \
> -                     KUNIT_INIT_MEM_ASSERT_STRUCT(&__text,                    \
> -                                                  __left,                     \
> -                                                  __right,                    \
> -                                                  __size),                    \
> +                     KUNIT_INIT_ASSERT(.text = &__text,                       \
> +                                       .left_value = __left,                  \
> +                                       .right_value = __right,                \
> +                                       .size = __size),                       \
>                       fmt,                                                     \
>                       ##__VA_ARGS__);                                          \
>  } while (0)
>
> base-commit: 870f63b7cd78d0055902d839a60408f7428b4e84
> --
> 2.38.1.431.g37b22c650d-goog
>

--00000000000004baa305edce8fba
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBC
riGXpKZPcKIXX2Nnlm0QtYDeF7S1lZsgGB5TxZbQ8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjExMTkwODI1MDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAmmg35rN9OImUbiFTq0yB
SWrxs9PF9GYfP2rsIBuKtWG7e6JCibmPXkwfQ3Nq9NMNrJ24vQ9whjl0J0oDTFV68Fxt6Xk09R16
bNmjBBr16dZyGTs+TIYobWG9b1Zu3LDgs5QFIgA9B9MZulAaZmo+ElxuBrhjZ7kdyjhSfdQ/Gw4b
DVxamNiN1BafhYQYYjwyBxFPx0IKmh39zWBzBDH/7CpotUogmJvrCrRvq5GY6y2MBfei62+s45PV
5r22bh/4wA8TbUo42AZa/KgQyY2ifumaYWhBfDtcJK4RiXmYiHA+M5WwNrYeDJXTnVsnYS7R8C2+
0cH52/NjOJ683mNSNQ==
--00000000000004baa305edce8fba--
