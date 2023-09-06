Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87B9793583
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 08:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjIFGp7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 02:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbjIFGp7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 02:45:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF27E46
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Sep 2023 23:45:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-402c80b71ecso58955e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Sep 2023 23:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693982753; x=1694587553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h9PAKKLi2CB500G1Eyz+PHdxKt6T5irV+0NgGfTKtlU=;
        b=xaH8kLo9Ox4WrSjfkymeZ/vkiLoHxEXp7JWafbAXeQtrgj0NCmSSeFrNe6aQbS5NSJ
         TMI0Ur7oyHiBuTifZFEOrqgYkqfUI7CpOWaSvg63x4ClInWm3/gQEzm2dGtkB9ueFajZ
         n152EJ/iuWTTKBAzYdlhpRNAHhNs0XGNjD98sArcPqbnih4zXq+JoetjCmXDBfxnXR26
         oP1haB7n5JUjYxXPQbQAYsJwL85V5OdfAFz6GMnPlVpxRfe5CMHeuut8yZLuT0ItSkV7
         2hdcMFr0hubnq+bu82poO2IDGSrZzUFvdLCystpHPJHoCe2fg/8cySkjWg7yBv4lPZLH
         0/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693982753; x=1694587553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9PAKKLi2CB500G1Eyz+PHdxKt6T5irV+0NgGfTKtlU=;
        b=gV7zbvYlP1uex16zV/hXk5QVMZuDueD6UFAli6mTff1PFSzhP3DexWTCwgEdBA3jDs
         A51ERBTevH3UH7oQYWFijxb+U7LMjbShWqRytr777pcB5uvJXRwciaVfwZnXHwIYuMJU
         AAFg2Nxqn3/9rZEEvmLXuvLQvEllJBm8/AA1c0WSJsiAJT7eQ7Ywme8Q1CDh1TzxTLSX
         BsQw1/DHByOtilPGF04SJQfnSypz3/QdtSnFJC/ufK3BZ6NgrxGRzmVsM/H0WozniFA+
         QPZe8g97mdsZaBoKSReR0PVUBYZLbGbtvImN0CRQy/d3WM3gs1Hjj57k8ShjwK0PGkVc
         CgMw==
X-Gm-Message-State: AOJu0YyPlF67dRnmtd9KpqgTwZ2S+U2ZOUwq300N9yI/wWa92tcSXP+k
        p8/SdmsCWmjxrq6lhCF9aN3RgUrubg3zpd3lus5sCQ==
X-Google-Smtp-Source: AGHT+IGgXuBxFKPhfWmVrO2BEImYVwdNvBLk2jzMyVMu/kSccgmbD88Ttz7EIM7dimtkgJw1ZXB36rhu7O55nxibxuM=
X-Received: by 2002:a05:600c:4fd1:b0:3fe:ef25:8b86 with SMTP id
 o17-20020a05600c4fd100b003feef258b86mr87281wmq.4.1693982753369; Tue, 05 Sep
 2023 23:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230904132139.103140-1-benjamin@sipsolutions.net> <20230904132139.103140-2-benjamin@sipsolutions.net>
In-Reply-To: <20230904132139.103140-2-benjamin@sipsolutions.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 6 Sep 2023 14:45:41 +0800
Message-ID: <CABVgOS=4vrEkaDe9LNLqnPoqi3Vg_FJZVj7WMMik42oBZpcS2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: add a convenience allocation wrapper for SKBs
To:     benjamin@sipsolutions.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Benjamin Berg <benjamin.berg@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000049411f0604ab1883"
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

--00000000000049411f0604ab1883
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Sept 2023 at 21:22, <benjamin@sipsolutions.net> wrote:
>
> From: Benjamin Berg <benjamin.berg@intel.com>
>
> Add a simple convenience helper to allocate and zero fill an SKB for the
> use by a kunit test. Also provide a way to free it again in case that
> may be desirable.
>
> This simply mirrors the kunit_kmalloc API.
>
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---

This _looks_ pretty good to me, but again, I'd like to see something
use it, be it a simple test for these helpers, or a real-world test
which takes advantage of them. Particularly since I've not had to use
sk_buffs before, personally, so I'd love to see it actually working.

Otherwise, this seems okay to me. I'll hold off a final judgement
until I've had a chance to actually run it, but I've left a few minor
notes (mostly to myself) below.

Cheers,
-- David

>  include/kunit/skbuff.h | 51 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 include/kunit/skbuff.h
>
> diff --git a/include/kunit/skbuff.h b/include/kunit/skbuff.h
> new file mode 100644
> index 000000000000..947fc8b5b48f
> --- /dev/null
> +++ b/include/kunit/skbuff.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Base unit test (KUnit) API.
> + *
> + * Copyright (C) 2023 Intel Corporation
> + */
> +
> +#ifndef _KUNIT_SKBUFF_H
> +#define _KUNIT_SKBUFF_H

Is it worth us hiding this behind #if IS_ENABLED(CONFIG_KUNIT)? I
suspect not (we haven't bothered for resource.h, and only really do
this for hooks/stubs).

> +
> +#include <kunit/resource.h>
> +#include <linux/skbuff.h>
> +
> +/**
> + * kunit_zalloc_skb() - Allocate and initialize a resource managed skb.
> + * @test: The test case to which the skb belongs
> + * @len: size to allocate
> + *
> + * Allocate a new struct sk_buff with GFP_KERNEL, zero fill the give length
> + * and add it as a resource to the kunit test for automatic cleanup.
> + *
> + * Returns: newly allocated SKB, or %NULL on error
> + */
> +static inline struct sk_buff *kunit_zalloc_skb(struct kunit *test, int len,
> +                                              gfp_t gfp)
> +{
> +       struct sk_buff *res = alloc_skb(len, GFP_KERNEL);
> +
> +       if (!res || skb_pad(res, len))
> +               return NULL;

From a quick look, skb_pad() will free 'res' if it fails? If so, this
is fine, if not we may need to move the add_action call below to
prevent a leak.

> +
> +       if (kunit_add_action_or_reset(test, (kunit_action_t *)kfree_skb, res))
> +               return NULL;

Just be warned that, while casting to kunit_action_t* is fine by me,
some versions of clang are warning on any function pointer casts. So
you can expect some whinge-y automatic emails from the kernel test
robot and similar.

> +
> +       return res;
> +}
> +
> +/**
> + * kunit_kfree_skb() - Like kfree_skb except for allocations managed by KUnit.
> + * @test: The test case to which the resource belongs.
> + * @skb: The SKB to free.
> + */
> +static inline void kunit_kfree_skb(struct kunit *test, struct sk_buff *skb)
> +{
> +       if (!skb)
> +               return;
> +
> +       kunit_release_action(test, (kunit_action_t *)kfree_skb, (void *)skb);

As above, note that the kunit_action_t cast may cause warnings on some
versions of clang. I'm personally okay with it, but if you want to
write a wrapper to avoid it, that's fine by me, too.


> +}
> +
> +#endif /* _KUNIT_SKBUFF_H */
> --
> 2.41.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230904132139.103140-2-benjamin%40sipsolutions.net.

--00000000000049411f0604ab1883
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDc
0YNlb6ibTW2vUtzuA6iSSieTb4FbJ24w2aEYvDUzyzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA5MDYwNjQ1NTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAME7jKlH0JCiKHA9pfGBp
RRJLQJHvGqkCM+N8djg4U+I78/OsVGUiXkbz7kMdlFRfpd5sZ4dXaFEQE2PcwnRgvhmd86Z9ALST
evcdJKZnk1nNPJ81pQFTIxUT65tLTg7UpSBZCHIuEYFPgA8NbgwcwDvv8XUMhupVbuoYeSY5zL48
T4/kio2gZ2VQzUFjZ0uSuOxD3d4g8HKxjps4JSWr0maqATxnVhHuRdrmd9gyvNsY1es0FGFgLZYV
vL6z0wjquXyqFzKediSHAvl5UtfulpOWMKBAVwsgkwNRmQF87AdbFjUmxNgO+E0uyRGwS53czfYf
ihg2W8DopA5MVgcPqw==
--00000000000049411f0604ab1883--
