Return-Path: <linux-kselftest+bounces-2361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C973581C7C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 11:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5351C24EEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AE2FBE5;
	Fri, 22 Dec 2023 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBJez3ya"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC4D10A0C
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso10669a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 02:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703239384; x=1703844184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j8KRgl+3zHkE/puXFpyOcwZ4XwAeKoslBcriKgmKo0Q=;
        b=YBJez3yaASXbm1+ON8alyU8tCJUH7fZmCW+7I/x5RcQjd7F8/4ubfdIOY6fOGvjRsC
         95YM0uSGR4Tp5VDu5I/RR+rqlxiZ/G6sl3eZq1fNRQcDJK9UBeRLpP5qtxx+NbobJ2tN
         4g8WVtP1N0GtM0yAAfOVqpT7bdi172iqbijRCFzw3ewshkh6aK67UTk2IJcjq2bBVYmC
         Nd/wqllZjWmPmxLEBFjZoyt4XcwUMBBUuVWAVWPgEWOh76qnZeBUohZmEfR9MsCsB3Bv
         ypi0pmPNguZtFUKpBlNPLtf1pqjc0VHUTE63WLOjPjWzwC5uLHk7ex6SknJmSJuhDJRo
         KI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703239384; x=1703844184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8KRgl+3zHkE/puXFpyOcwZ4XwAeKoslBcriKgmKo0Q=;
        b=ng3iigsSYVLf1Yb9KDqxy+UW7zLX8CY2ziV7czeZaJ69hGZFFlHnky2XehTSKwn6v3
         hAQDkTlt/d6BHvZQDJINujtARIh7b7hH6JEURKtHQ/lNflDKrN/UGjHMpHimPJ5FilOd
         ktpwxMmWUggztl1F6C2UR+LcsLU1GzEh7I807QCuUHgvMWNl3J7gN+BRh3wRtUXX8NWW
         X+KQ0fw5TIrNyQ0lgWjn/VmRP8/rIpuh6IllCVY9yA7cmoMHNrI1hWC5BSvFBguR6yJH
         vaagpUOKtZGKDcmcW/0W5agCUZWFXtzYKxEG3pC8wT16DNULeVctj7ErZzCNgl3se4M0
         4U4g==
X-Gm-Message-State: AOJu0YztprwmLpyxnjBiQt/2zIFv44q++/hA1uZPpuEJUwrN8mbuXsag
	o7FO8HEXaFmjZIom4uXgwMBeWtx+Eca0d1pUlw5qgmj6tu9Ar38ZBJjg/Sb8bw==
X-Google-Smtp-Source: AGHT+IHy4z/t2Va50FsIUc/pu2c7UtArwWmahNKSHYZNeRj0BziHt1PHMt3k+n3OytKBcmI0K7IrWZef+ur5lScLaEk=
X-Received: by 2002:a50:f611:0:b0:553:faf5:6841 with SMTP id
 c17-20020a50f611000000b00553faf56841mr69709edn.5.1703239383668; Fri, 22 Dec
 2023 02:03:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220151952.415232-1-benjamin@sipsolutions.net> <20231220151952.415232-3-benjamin@sipsolutions.net>
In-Reply-To: <20231220151952.415232-3-benjamin@sipsolutions.net>
From: David Gow <davidgow@google.com>
Date: Fri, 22 Dec 2023 18:02:52 +0800
Message-ID: <CABVgOSmq+vWoqDWye_4AveLTQep3z+xCUPT8KhQM5CheUm3HOw@mail.gmail.com>
Subject: Re: [PATCH 2/6] kunit: add a convenience allocation wrapper for SKBs
To: benjamin@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Benjamin Berg <benjamin.berg@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000074d9d4060d1652be"

--00000000000074d9d4060d1652be
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 23:20, <benjamin@sipsolutions.net> wrote:
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

I'm happy with this as-is, but do think there's a discussion to be had
about where subsystem-specific KUnit helpers should live. I think,
because this is just a header (and it mirrors the normal
linux/skbuff.h), that having it in include/kunit works well.

If it needed a source file, I'm not 100% sure whether it should be in
net/core/ or lib/kunit.

Regardless, this looks good to me, modulo the small nitpick below.

Reviewed-by: David Gow <davidgow@google.com>

>  include/kunit/skbuff.h | 56 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 include/kunit/skbuff.h
>
> diff --git a/include/kunit/skbuff.h b/include/kunit/skbuff.h
> new file mode 100644
> index 000000000000..2144d01e556f
> --- /dev/null
> +++ b/include/kunit/skbuff.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Base unit test (KUnit) API.

This probably needs a better description which mentions skbuff, and
that it's for resource management.


> + *
> + * Copyright (C) 2023 Intel Corporation
> + */
> +
> +#ifndef _KUNIT_SKBUFF_H
> +#define _KUNIT_SKBUFF_H
> +
> +#include <kunit/resource.h>
> +#include <linux/skbuff.h>
> +
> +static void kunit_action_kfree_skb(void *p)
> +{
> +       kfree_skb((struct sk_buff *)p);
> +}
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
> +
> +       if (kunit_add_action_or_reset(test, kunit_action_kfree_skb, res))
> +               return NULL;
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
> +       kunit_release_action(test, kunit_action_kfree_skb, (void *)skb);
> +}
> +
> +#endif /* _KUNIT_SKBUFF_H */
> --
> 2.43.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20231220151952.415232-3-benjamin%40sipsolutions.net.

--00000000000074d9d4060d1652be
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDs
KTglr7rY/5EJe/jxIAt6KmLDKr10cIMrm1uJX6u5UTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMjIxMDAzMDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEATvXJAoV7u2mzzOhV4JS/
FStSwq+pYG6wrW01sqBcgdnpaRLYlFZPwTkIeHchzCgoiGDSzifx+Rulc6RllyaaUWU/xVeZAdhk
fn2iHtWei/IPf/hFHIeEUTy0nQLBhQMOplAl6ED55emtw2ECX8s87m+RuJHvKgwjSFzhbx5ptwRa
EatQsmM1XnhuJ2aVFwrU7VDiog3LUlh1+DFhrjA5pddHv5SE/4EwdVNmj7TddxVMPPcQ9B9sT7T7
TIhFDBH/hefkj77UbXqhq3+lWxtML00VfmBzEFMBUJZ4HTb0EpYiyWKBR/k+H1ke84sY0UAOQmbW
f8WV8gSOFdQrbYOQhQ==
--00000000000074d9d4060d1652be--

