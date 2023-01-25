Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE267AA62
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 07:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjAYGiX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 01:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjAYGiW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 01:38:22 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5533F2A3
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 22:38:21 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id c15so4199054uas.2
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 22:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V/Vj4XAt0f/+81NZ06h7dxEafqSmssg2WS/uOyx4ZsI=;
        b=mn+Y6lfM+XM7dAX5PtUnSPuWlXCu2/6nCG+kOilmgJcd1VtWslzATA/4ocbYaNgayV
         3TUiet2t/+CT4+KiXG4/gpwp5l3vFlt4WqJiOX5twWDG5Y4G7x1TFMfGloXAkrDQN1rY
         h3E2BaWDvaj+XVnwp65PX7mu3tffiqgu+SYjSieXUxZ/5YXwNsWKL7tX5KmFSDnGn3S9
         fkSDKfOaqED6DxLn77V4WyMiKTzkJ7U3xRs8tcP3jxWwZuJpcZx3Rjh1e9qkyEcqSSmV
         baCaMApix/meWlJzWcfzw2CzmUev+4KGaAlOhdqoji20tWukUN2L5LS8cUqIC9T9kzeh
         HTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/Vj4XAt0f/+81NZ06h7dxEafqSmssg2WS/uOyx4ZsI=;
        b=JmWI0HYqozl0fzvhwLqPyPADjL3oppXOhlf623720wtjhEIvRm2XT5z5q4Maqn/dM/
         vSkNWpDGxm8/0znuE5OK3uF7V1euvKij0LJS89lHn3Nh4RAS0jcYcbzeQes9uMgNptw3
         967ujXPJrzFxGitXOxNAifGH9gYeiLbKfZgQlGChna1nS9fkuqTEs7cJ986O9z+7rxZr
         k9L2IgjKIas1DVpgzOSaHQY6sH7mLDAZDf/nF8L3xZNwvWltBFF6Ni9Rs1HWHcmQpHoy
         aFLYLAiJPwXldH87dF58JHLOcantx4BW5vx8RNTZbBOgOtEok6FgiJTgE9A5r2ixH+IY
         0B8A==
X-Gm-Message-State: AFqh2koN7Cv9ZhnZONJjxMuWOMhpRMbu1IQ5iXDKIZ+HVvshdxOTfXJB
        sWXtC17dWIsEPGBuoYuq5u3gVoDQPs99NuRhtnweDPty7qjzlpfkYcg=
X-Google-Smtp-Source: AMrXdXtrpm0DykpuTo8YHoJNv7Aw0k7FU59u9Oacd3hflPVW8jRLF6uHwTZ09IvWmOHGd/nvjKgdz/dnnHLlONgktPA=
X-Received: by 2002:ab0:3155:0:b0:419:25c5:30dc with SMTP id
 e21-20020ab03155000000b0041925c530dcmr3745651uam.26.1674628700126; Tue, 24
 Jan 2023 22:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20230125061927.141538-1-rmoar@google.com>
In-Reply-To: <20230125061927.141538-1-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 25 Jan 2023 14:38:08 +0800
Message-ID: <CABVgOSkaBJE1FMSquPaZ=5ULFLyfrkMYKixn0YLZZJAtKoNG_g@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: fix bug in KUNIT_EXPECT_MEMEQ
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d1dfc905f310e026"
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

--000000000000d1dfc905f310e026
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jan 2023 at 14:19, Rae Moar <rmoar@google.com> wrote:
>
> In KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ, add check if one of the
> inputs is NULL and fail if this is the case.
>
> Currently, the kernel crashes if one of the inputs is NULL. Instead,
> fail the test and add an appropriate error message.
>
> This was found by the kernel test robot:
> https://lore.kernel.org/all/202212191448.D6EDPdOh-lkp@intel.com/
>
> Reported-by: kernel test robot <lkp@intel.com>
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

This looks good to me, modulo a small formatting issue with the
continuation backslashes (see below).

It might be worth considering this as a fix to the patch which first
introduced the MEMEQ macros with a Fixes tag, e.g.:
Fixes: b8a926bea8b1 ("kunit: Introduce KUNIT_EXPECT_MEMEQ and
KUNIT_EXPECT_MEMNEQ macros")

Otherwise, this is:
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  include/kunit/test.h |  7 ++++---
>  lib/kunit/assert.c   | 40 +++++++++++++++++++++++++---------------
>  2 files changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 87ea90576b50..3c7045e22512 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -683,9 +683,10 @@ do {                                                                              \
>                 .right_text = #right,                                          \
>         };                                                                     \
>                                                                                \
> -       if (likely(memcmp(__left, __right, __size) op 0))                      \
> -               break;                                                         \
> -                                                                              \
> +       if (likely(__left && __right))                     \
> +               if (likely(memcmp(__left, __right, __size) op 0))            \
> +                       break;                                                         \
> +                                                                                              \

The backslashes no longer line up here.

>         _KUNIT_FAILED(test,                                                    \
>                       assert_type,                                             \
>                       kunit_mem_assert,                                        \
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index f5b50babe38d..05a09652f5a1 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -241,24 +241,34 @@ void kunit_mem_assert_format(const struct kunit_assert *assert,
>         mem_assert = container_of(assert, struct kunit_mem_assert,
>                                   assert);
>
> -       string_stream_add(stream,
> -                         KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
> -                         mem_assert->text->left_text,
> -                         mem_assert->text->operation,
> -                         mem_assert->text->right_text);
> +       if (!mem_assert->left_value) {
> +               string_stream_add(stream,
> +                                 KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
> +                                 mem_assert->text->left_text);
> +       } else if (!mem_assert->right_value) {
> +               string_stream_add(stream,
> +                                 KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
> +                                 mem_assert->text->right_text);
> +       } else {
> +               string_stream_add(stream,
> +                               KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
> +                               mem_assert->text->left_text,
> +                               mem_assert->text->operation,
> +                               mem_assert->text->right_text);
>
> -       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
> -                         mem_assert->text->left_text);
> -       kunit_assert_hexdump(stream, mem_assert->left_value,
> -                            mem_assert->right_value, mem_assert->size);
> +               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
> +                               mem_assert->text->left_text);
> +               kunit_assert_hexdump(stream, mem_assert->left_value,
> +                                       mem_assert->right_value, mem_assert->size);
>
> -       string_stream_add(stream, "\n");
> +               string_stream_add(stream, "\n");
>
> -       string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
> -                         mem_assert->text->right_text);
> -       kunit_assert_hexdump(stream, mem_assert->right_value,
> -                            mem_assert->left_value, mem_assert->size);
> +               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
> +                               mem_assert->text->right_text);
> +               kunit_assert_hexdump(stream, mem_assert->right_value,
> +                                       mem_assert->left_value, mem_assert->size);
>
> -       kunit_assert_print_msg(message, stream);
> +               kunit_assert_print_msg(message, stream);
> +       }
>  }
>  EXPORT_SYMBOL_GPL(kunit_mem_assert_format);
>
> base-commit: 5cb26c298ffde271d9bd1dd1b87ad028218f77fe
> --
> 2.39.1.405.gd4c25cc71f-goog
>

--000000000000d1dfc905f310e026
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
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDM
B0uuZmCMMek4jfUCcJ+a4C2/9PTc8ACqVjASBiv2DjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMjUwNjM4MjBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAL8z4NN+CIGf5vv/uBEQJ
KVIjgltcYo0nnGdyjXd1msDs3S0G0DCBvDfphOQvSnAQd+xl6unCBo6EUEtujDbb5zhpjU/awAbp
49atZaWjp9URunSTzvoIlXzcklLh+wkmYPq0xwtPGL5FA+HFYazkaqBkQyOBqACSozE0bxVKtfKd
r9+QsMgNhjMxnqdDx82X2b0VUQpxxUYBeb89gc01lS4+XqlPCY7IV/O87TR1RkZ9ytSeWrHi4EY2
1oljyVCAtH+NYd0eKd23QwwTnhLw2rWKhxZQHM9KCqQB/K9CiYXaTYsMoDhnTPFDLEqc3hOUyt0Q
+gc86qMvqfqdMAWLEA==
--000000000000d1dfc905f310e026--
