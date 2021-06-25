Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FFE3B3B71
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 06:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhFYET6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 00:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFYET5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 00:19:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ADCC061574
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Jun 2021 21:17:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l12so8338773wrt.3
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Jun 2021 21:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zrImexsEC3g3TpudvQa0p1jKu4+Yy/5SIYTRb13jdOM=;
        b=nern5TJzXsn/QahADNkAjmKhKeN408xrA0ezOYbzm16IOZvfJm1FDYpCAfi+Mp9NaM
         n1aYVUj2EimScceFlx9U54thImxGpxVMtVbdwMd6mU/GNcgnnZN00OS0UFHM5/S6vzN1
         LQX7lo2fGys0Ydl2/Ngg0ISBgaJ1ZI5XdHlestih1D9qfeOmRiT/+CtTItUHyfxecAvF
         h+BYS1vmvy6lLpNRSHK/TL2uZcfZeKl8Rbdhyavmw+pAkXBuGIrJnjh2frvoAwVpZW8y
         LonI/PUR+HB1SKeTp5pqIc3SpSfrO2abexAxVCfexs0TGF+MjOC3NvAM22lIzRAOneM5
         agGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zrImexsEC3g3TpudvQa0p1jKu4+Yy/5SIYTRb13jdOM=;
        b=Px31vJfARvxq50ycHBgfOr8WRGhJFxuVwUyXvRnJyTHiT7TT5rdEfD7Sz9XjWnH1el
         l9ggOGYm3uVVtda19n59TPMW2TusnyaCokBSYM30h1xTG9ZGvjQSxCS7g0pcq+gyS/nH
         yk6EQ3yhNkpi4BgM6zYDKbV508n81Svr3z20a2o4iG4efyJMWzr58qYCC2hRJQeMvbFi
         e4IOcq69DmmRzIgqu8f353dZRRMiHj68ytcmwlM295MQjwp0ExRsu1Zw/jS1Q4kb5qfy
         4612S3I1+282iSFuUxfo93XYI6lAo96K/IgLXy59Y9dfAdjbVjb4QTQ6Wn60+Gb/DGis
         sQGQ==
X-Gm-Message-State: AOAM5334SNxb2mKD9yaZTUS2btMGaegtZm0lPOfWbQokcTVbIZGs5cz6
        CHfsLqZfMwJRe71z2JDt+knnT19ZgIy+Q1pdmjLrEA==
X-Google-Smtp-Source: ABdhPJxMa4jod27pV44xJSpnrm7aHxtJpAKxpSz9Q2TVvgsRe/HvtgKJZXmVtda2PMAliAMu8FvwOZFJk9e9sgPazEo=
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr6113863wrt.288.1624594655281;
 Thu, 24 Jun 2021 21:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210623190919.956814-1-dlatypov@google.com>
In-Reply-To: <20210623190919.956814-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Jun 2021 12:17:23 +0800
Message-ID: <CABVgOSm3m2NMZqHSpDRexs_EOdC7SnKmb_iTb738iZPW0m_Nrg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: remove unnecessary "annotations" import
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000584a3305c58f6bcf"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000584a3305c58f6bcf
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 24, 2021 at 3:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> The import was working around the fact "tuple[T]" was used instead of
> typing.Tuple[T].
>
> Convert it to use type.Tuple to be consistent with how the rest of the
> code is anotated.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This looks sensible and works for me.

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David

>  tools/testing/kunit/kunit_kernel.py | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index e1951fa60027..5987d5b1b874 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -6,15 +6,13 @@
>  # Author: Felix Guo <felixguoxiuping@gmail.com>
>  # Author: Brendan Higgins <brendanhiggins@google.com>
>
> -from __future__ import annotations
>  import importlib.util
>  import logging
>  import subprocess
>  import os
>  import shutil
>  import signal
> -from typing import Iterator
> -from typing import Optional
> +from typing import Iterator, Optional, Tuple
>
>  from contextlib import ExitStack
>
> @@ -208,7 +206,7 @@ def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceT
>                 raise ConfigError(arch + ' is not a valid arch')
>
>  def get_source_tree_ops_from_qemu_config(config_path: str,
> -                                        cross_compile: Optional[str]) -> tuple[
> +                                        cross_compile: Optional[str]) -> Tuple[
>                                                          str, LinuxSourceTreeOperations]:
>         # The module name/path has very little to do with where the actual file
>         # exists (I learned this through experimentation and could not find it
>
> base-commit: 87c9c16317882dd6dbbc07e349bc3223e14f3244
> --
> 2.32.0.93.g670b81a890-goog
>

--000000000000584a3305c58f6bcf
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNUwggO9oAMCAQICEAGb+Q77il3T2Ss3sWOT
zKkwDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMTAyMDUy
MzQwMjdaFw0yMTA4MDQyMzQwMjdaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCp88g1fYbjEPVlaL9sUToZwjKCeCIS
JqYR/IR1FgbA8vq7+rNlr9/1AFLZe4/qh3CwWzh42UIERZpqut/ict9jfisWWKnXPaEQkibkZ+NL
OPIT51cC0QX5nv7zFf28tPZ6V4KewX3UtB/8JDcybfVeQlZ0S1UMVfg93wMXe59FKN/QYbLDzQSg
Yc/5ExUVV6UgoEXVbxTuJv45hvdihw6Eme65MfC0CUPeiZ1sfQjfSYi7CY517JOATvD84ZPX0GQV
cRb6N52CERoIy/7ni857uvf5fAmGdzR6VZgtGL5/nO1Jb/KmNMsat7pnRbgHx5qYLLN2+oCS8Jp7
0VoZRTiBAgMBAAGjggHRMIIBzTAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFG2lY2ZX
ILbFHw0h01NI0v+AeczGMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwgZoGCCsGAQUF
BwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9nc2F0
bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNv
bS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouseLHIb
0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vY2Ev
Z3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCNr3LBERPjVctGdVEb
/hN6/N6F2eUWxZLSUbuV7fOle0OvI8xz2AUBrOYQLp94ox9LqmsATKPsBl2uiktsvfs/AXNMcmOz
qsWHzfqp4XlvNgQsC/UyUMWxZoEyTDfTSat09yQjkFJ7viwzrqqscmTx5oTZz8TPRt0mbxwx3qry
wDzYxadSUQXNpNnfi0FBDYUUfuCLFWPsPsAXmgh483u0RbNik9OY/ozNq1Gvg/U0jQOlJf2IiKbE
kUL5Vq8gDDu6bETx5bHmRmSjHhwo7eVbxywczpzdFsU3dauZ3BzqhLy2pRGGzZybSH/3mf7o9y15
gmRHE7WzPLrsULHG/TM8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAyMDIw
AhABm/kO+4pd09krN7Fjk8ypMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAsEPGe
f5z8OWTjngXPBasPDmC5m7EcPuxDosu9gY0OHDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yMTA2MjUwNDE3MzVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqG
SIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAiywvJKlHqmWQ89lp76F+UL2c
8KYD/jEkv2uozQDgTs2YyrxcJn/fKBhw2ij4hJsFeH1UXifnUyPPN5UgSZtrDZCSspnrmfvLkp1B
n047PN9q6+gDGCDzkc3ynfg40MXLlEwwkOZb3k22i34FfiOUnEyz9nICtxjVN/UCuPhilVDZxNTI
WG9Y6bNt9Q26SnTaQqp32R3Z/Pg5kcmHxIZ8MLbfZHxjrKnV9iDQJXwgJDTOPLwpIfoCfMz3WcBZ
i5lnBwv3VNz+fUe2ZYIjHLI2PKISxnLurnXe/uq06GX4lqaulDy9N+OKj3hocqs0HHEcv7cp9DrX
ElZnWsbgFgU0mg==
--000000000000584a3305c58f6bcf--
