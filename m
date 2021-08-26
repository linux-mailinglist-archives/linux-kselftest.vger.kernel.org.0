Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62C53F818D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 06:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhHZEWL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Aug 2021 00:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhHZEWK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Aug 2021 00:22:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88B0C0613C1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 21:21:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z4so2784095wrr.6
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 21:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqiB7c1Z9XcGZUEwKVWzCrWdTbtlx+NC89TeoGFmDVc=;
        b=OUi3mfrb6wGFv8z4xyhFetyDSFiIEPri52LvAHU2V2pU0c8WMy/N/gFdDxXyXA/E1M
         c3Mu+x6jSvdhYBy6i9lvnZc9J641TugcaBfid29a1xip9GWQ16koXDmw1Rb1VqLAfJRF
         GA0BXDmDUzjeRlYT3vi8MOoUAYyPuC56jGQCC4nvNgWC8Gl/YLdj9I4IZT4oF6y8NgDF
         29CyuHcK59HBIOm0C0wTJ05rV4trhwz+ojC0n4X4VbDlN0wlTiZCDIDlsHxMHxCdG+ze
         rX0LssbTdAqPNsGpbZwdDbeI5a62Pw2amZdy+LizXYyBu3EgWQhTz1sgvNuf8jPd3Jf5
         0e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqiB7c1Z9XcGZUEwKVWzCrWdTbtlx+NC89TeoGFmDVc=;
        b=ar25FWq3ePqAb+d/GDB5m1TIx0gWwxKRsVWQH3USHjmAUs5ZZKfxOwb+uCPPpJwyj8
         1QudqU6es6+7Z463Yt17A/i1ej7zrcDClgLbZzT+EotkQLvkRRWgag7itgIfMxM6j7xi
         4qHk28T1PpvRH3HZwp/tT1rBy+2CTW3qhx3dAgWONGkR/vzDKFM+w4ZNm07aKCQKXIrL
         z6KzJilcMCXIqEgEDp5Ei2a1r5mtFulXUibc7lxbm4rCS7P+kQD44DyKGMYmfqiimI8v
         zHjEqLBws0+WfTgTSYXfVJKc/oDS/+QSBRXg0uFQwFv4OjkxrPg+dUToC7dY2EKpnWw3
         7IXQ==
X-Gm-Message-State: AOAM530fUYjMHX7D2JE/iIi7gXirrGtBGmSjf6xU1X8TQDSc0Kw1CU14
        1wVTn4Tow0r9JjLdnrVS+PRsLsFUk99/xnl/NPIqnw==
X-Google-Smtp-Source: ABdhPJxEy2TlLGjpCk2RMUqLtuIJjkkI4vcoXK76UuY/4/v016SbyMIF2y4caw+WizaC+FKe8aiTNnUYMKSg4npS4+k=
X-Received: by 2002:a5d:64e6:: with SMTP id g6mr1464029wri.288.1629951682092;
 Wed, 25 Aug 2021 21:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210826012626.1163705-1-isabellabdoamaral@usp.br> <20210826012626.1163705-4-isabellabdoamaral@usp.br>
In-Reply-To: <20210826012626.1163705-4-isabellabdoamaral@usp.br>
From:   David Gow <davidgow@google.com>
Date:   Thu, 26 Aug 2021 12:21:11 +0800
Message-ID: <CABVgOSkhN-DPYnhuTG1hGU-2aP0MEaKjz+0=Sr_VNKUhpgz79g@mail.gmail.com>
Subject: Re: [PATCH 3/6] test_hash.c: split test_int_hash into arch-specific functions
To:     Isabella Basso <isabellabdoamaral@usp.br>
Cc:     linux@sciencehorizons.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000008f6fa05ca6eb3c3"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000008f6fa05ca6eb3c3
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 26, 2021 at 9:26 AM Isabella Basso <isabellabdoamaral@usp.br> wrote:
>
> Split the The test_int_hash function to keep its mainloop separate from
> arch-specific chunks, which are only compiled as needed. This aims at
> improving readability.
>
> Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
> ---

I like this, but have a note below. It _may_ be worth combining some
of these test refactoring patches with the KUnit port patch:
definitely a matter of taste rather than something I think is
necessary, but I personally think they're related enough they could go
together if you wanted.

Cheers,
-- David

>  lib/test_hash.c | 84 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 54 insertions(+), 30 deletions(-)
>
> diff --git a/lib/test_hash.c b/lib/test_hash.c
> index 8bcc645a7294..ed75c768c231 100644
> --- a/lib/test_hash.c
> +++ b/lib/test_hash.c
> @@ -61,6 +61,45 @@ fill_buf(char *buf, size_t len, u32 seed)
>         }
>  }
>
> +#ifdef HAVE_ARCH__HASH_32
> +static bool __init
> +test_int_hash32(u32 *h0, u32 *h1, u32 *h2)

I'm unsure about this name. Having test_int_hash32() test only
__hash_32(), where test_int_hash64() tests hash_64() feels a little
bit inconsistent. Maybe this is somewhere we should have the extra
underscore like in HAVE_ARCH__HASH_32.

I get that because the architecture-specific hash_32() is removed
earlier, there's no need for an extra function to test how that
compares against a generic function, so there's no conflict here, but
it did confuse me briefly.

The other option is, as mentioned in the earlier patch, to keep the
architecture-specific hash_32() (and _maybe_ get rid of __hash_32()
entirely), in which case this name would be perfect for testing that.

> +{
> +       hash_or[1][0] |= *h2 = __hash_32_generic(h0);
> +#if HAVE_ARCH__HASH_32 == 1
> +       if (*h1 != *h2) {
> +               pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
> +                      *h0, *h1, *h2);
> +               return false;
> +       }
> +#endif
> +       return true;
> +}
> +#endif
> +
> +#ifdef HAVE_ARCH_HASH_64
> +static bool __init
> +test_int_hash64(unsigned long long h64, u32 *h0, u32 *h1, u32 *h2, u32 const *m, int k)
> +{
> +       *h2 = hash_64_generic(*h64, *k);
> +#if HAVE_ARCH_HASH_64 == 1
> +       if (*h1 != *h2) {
> +               pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() = %#x",
> +                      *h64, *k, *h1, *h2);
> +               return false;
> +       }
> +#else
> +       if (*h2 > *m) {
> +               pr_err("hash_64_generic(%#llx, %d) = %#x > %#x",
> +                      *h64, *k, *h1, *m);
> +               return false;
> +       }
> +#endif
> +       return true;
> +
> +}
> +#endif
> +
>  /*
>   * Test the various integer hash functions.  h64 (or its low-order bits)
>   * is the integer to hash.  hash_or accumulates the OR of the hash values,
> @@ -74,19 +113,17 @@ static bool __init
>  test_int_hash(unsigned long long h64)
>  {
>         int k;
> -       u32 h0 = (u32)h64, h1, h2;
> +       u32 h0 = (u32)h64, h1;
> +
> +#if defined HAVE_ARCH__HASH_32 || defined HAVE_ARCH_HASH_64
> +       u32 h2;
> +#endif
>
>         /* Test __hash32 */
>         hash_or[0][0] |= h1 = __hash_32(h0);
>  #ifdef HAVE_ARCH__HASH_32
> -       hash_or[1][0] |= h2 = __hash_32_generic(h0);
> -#if HAVE_ARCH__HASH_32 == 1
> -       if (h1 != h2) {
> -               pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
> -                       h0, h1, h2);
> +       if (!test_int_hash32(&h0, &h1, &h2))
>                 return false;
> -       }
> -#endif
>  #endif
>
>         /* Test k = 1..32 bits */
> @@ -107,24 +144,11 @@ test_int_hash(unsigned long long h64)
>                         return false;
>                 }
>  #ifdef HAVE_ARCH_HASH_64
> -               h2 = hash_64_generic(h64, k);
> -#if HAVE_ARCH_HASH_64 == 1
> -               if (h1 != h2) {
> -                       pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() "
> -                               "= %#x", h64, k, h1, h2);
> +               if (!test_int_hash64(&h64, &h0, &h1, &h2, &m, &k))
>                         return false;
> -               }
> -#else
> -               if (h2 > m) {
> -                       pr_err("hash_64_generic(%#llx, %d) = %#x > %#x",
> -                               h64, k, h1, m);
> -                       return false;
> -               }
> -#endif
>  #endif
>         }
>
> -       (void)h2;       /* Suppress unused variable warning */
>         return true;
>  }
>
> @@ -150,15 +174,15 @@ test_hash_init(void)
>                         /* Check that hashlen_string gets the length right */
>                         if (hashlen_len(hashlen) != j-i) {
>                                 pr_err("hashlen_string(%d..%d) returned length"
> -                                       " %u, expected %d",
> -                                       i, j, hashlen_len(hashlen), j-i);
> +                                      " %u, expected %d",
> +                                      i, j, hashlen_len(hashlen), j-i);

These whitespace changes probably aren't necessary.

>                                 return -EINVAL;
>                         }
>                         /* Check that the hashes match */
>                         if (hashlen_hash(hashlen) != h0) {
>                                 pr_err("hashlen_string(%d..%d) = %08x != "
> -                                       "full_name_hash() = %08x",
> -                                       i, j, hashlen_hash(hashlen), h0);
> +                                      "full_name_hash() = %08x",
> +                                      i, j, hashlen_hash(hashlen), h0);

These whitespace changes probably aren't necessary.

>                                 return -EINVAL;
>                         }
>
> @@ -178,14 +202,14 @@ test_hash_init(void)
>         }
>         if (~hash_or[0][0]) {
>                 pr_err("OR of all __hash_32 results = %#x != %#x",
> -                       hash_or[0][0], -1u);
> +                      hash_or[0][0], -1u);

This whitespace change probably isn't necessary.

>                 return -EINVAL;
>         }
>  #ifdef HAVE_ARCH__HASH_32
>  #if HAVE_ARCH__HASH_32 != 1    /* Test is pointless if results match */
>         if (~hash_or[1][0]) {
>                 pr_err("OR of all __hash_32_generic results = %#x != %#x",
> -                       hash_or[1][0], -1u);
> +                      hash_or[1][0], -1u);

You get the idea...

>                 return -EINVAL;
>         }
>  #endif
> @@ -197,12 +221,12 @@ test_hash_init(void)
>
>                 if (hash_or[0][i] != m) {
>                         pr_err("OR of all hash_32(%d) results = %#x "
> -                               "(%#x expected)", i, hash_or[0][i], m);
> +                              "(%#x expected)", i, hash_or[0][i], m);
>                         return -EINVAL;
>                 }
>                 if (hash_or[1][i] != m) {
>                         pr_err("OR of all hash_64(%d) results = %#x "
> -                               "(%#x expected)", i, hash_or[1][i], m);
> +                              "(%#x expected)", i, hash_or[1][i], m);
>                         return -EINVAL;
>                 }
>         }
> --
> 2.33.0
>

--00000000000008f6fa05ca6eb3c3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnAYJKoZIhvcNAQcCoIIPjTCCD4kCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz2MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
/nKVAPkPCzwfEPbL1262MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwgZoGCCsGAQUF
BwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNv
bS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouseLHIb
0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vY2Ev
Z3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA+XCDyl6gdUzbfGv+D
Xg1PhWeHLeXCPc9+sNLwRPD9AYET0o6RJYqNAVFC77sI4quIUtKk+H44VwMwNOhX3PY+69dzUd2E
XLgutq81YK/Kt/wRUdEbgvDhvjumsVENI6xc4xZzAXAZqJLK+AR5oNtx0o9GC2el89ZF3yPI8KqH
1aOYvtgDisoXXmst9rm6Njnt9AitTax0LwWdl1yGwnA6cqJfq8h7Ehg+6X3TGW4wMM1RsB9tLL2d
osQsJT49+adAbU2yODf/XkIQevor0sIhJuxYkLay9G2GK1DCEmqUfbXWF5yQRxBkhVXHodFI2+V1
OPxk5TOVVOId6G/60Hq4MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAyMDIw
AhABeyW1Dfueu+w9B/G1jwK+MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBML9GI
uJSeL6ge8FZ4Ll6IaQ4SSj+qAWpn3SV4QZ5oyTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMTA4MjYwNDIxMjJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqG
SIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAeblLowh3DKxJeKcP2T2OG6Zm
5ixCaohqwbeBruyqQayroaKfvCMx68SI1yudISem8IBzgcJ7DCuTkuOYbIjhzzwfdTQN+l/PKSEF
uCAFwv8gDiC+rDmQx60hZXJyqY9GaCKFI1jRBc4DqQy0MsiQWZ3A/0Sj9URd1UO3x6pRPGRV4Qjf
DRQWVx/sDrCXgVcyel8vF+OkR8Ec9Z9Pw8pAp+7/SMOFIcOY5zy7SNFFDZXyj9MpUDmbFl+meFtD
0hR+B8RkXoJzqs6vxjtk2XCYT7qBdSy4Rxic/a35NA89YeWKcgQVLssrRyXt7RqGczY095EjFZNZ
Ih+wycxAXaGspg==
--00000000000008f6fa05ca6eb3c3--
