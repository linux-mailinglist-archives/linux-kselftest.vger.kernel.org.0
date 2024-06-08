Return-Path: <linux-kselftest+bounces-11489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3974690111A
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B5ACB20E3A
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6BC176FDB;
	Sat,  8 Jun 2024 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxzQn2E6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F471779BC
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Jun 2024 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717838442; cv=none; b=f9nnloexjg+s8HalMNP49birXRuYUJ5VO9kSSLJU97YOXNKLS1FSozTLSUQD36r3yXvY48pzacmrHDJkSDs0i9fC1bkspmQM+5ywaYz67xKQiLynkywTa98Aps+OBUR47rZOIC5W9THR1e9sUO8u3/9E4gGdz+n/0qduPNGK/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717838442; c=relaxed/simple;
	bh=ZkhhemaKP8lCa6ClBeztHADRoDKIRRCsk/T4NIuMC64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NF76Yiic7pnR4XxOmVdD/rQhcg3ALtS5WoLV3S+RaE92ipsOocc3Z/V+O7ZBEeJzVZ0S7uLcdrujiNRw+OPy3XQlxkIrLQVDEDx7w2XPVwP4iFlpRHhqD6PBCDe9+lhu9LVmMic0rEC0ea7jrK0cTVp2q1J5wLJWpzx+iEXXgpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pxzQn2E6; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4400cc0dad1so215821cf.0
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Jun 2024 02:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717838439; x=1718443239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XnqLfwU/A1Xjf8eRjuCMj3A1lwR+H6K/lbw2VTYgr+M=;
        b=pxzQn2E6+6dtucl+p8GDVIFDA9piOroOSIboqBVupQnrNGFghE/CMYXl++wfaodzjh
         DOuKBpLBIz9KVyLqd4MnYkTuzpodMnLqSK+bztG8os/2y35usZGhG8WBRKIxmScASQOH
         US+vYVHPosPNgA7HfobP6py03gnvG53FZBZ9Xe5rCcP6ZZ1ka/RVOh0g+QCOdubpJ5v/
         5MoTefefDWFh8ANMns8bHc9fYOQA3RaCHBI96AyITh5L/9OX3dgCLG4X7LlC9nt0bFX8
         utpiVl2R8+S7km1YknFnK9rosOBHLiOGGYalBEptrpXZVItlubW1THkhIpmS8useqDkG
         l9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717838439; x=1718443239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnqLfwU/A1Xjf8eRjuCMj3A1lwR+H6K/lbw2VTYgr+M=;
        b=IwB6r34L/sGX7HfafM4FtDPA2YKg+2OOReYtmtKCzbGwQfRjM2AxuA5oW32yhUo2Db
         rZQVZXVxLUTAJBMMKhahiVyso8bVWZrbXExhXb49G2DIs0vVGPuaxM28/t0TjES9GEjr
         Xx8ngkjW8WuGaA9AzZYVWVe7bE6DSTHc3/TcgX0oedz2RLpFggLkmUVonjEBZCmxRJtz
         W1Ri+Q+1zqzD0/KxdjVYhCnMuD1IJf264LlgKBnowPMO5IG+WeVWF11Cw5Me1XoaXMqS
         ruLdvY5ut26YTqLs1JnWRMv4M7/4EoWhEzhLBxl5h/QLQi243MT5QevKbyojRrRxUGLx
         226A==
X-Forwarded-Encrypted: i=1; AJvYcCU4ILC/4WWXe33b+kIB2flWg01qo+pYHOciUO9ntEjAe5eN7ssMvJLJnga8cxrKsZYyPaYMaMyCWv8ZxrWwOd8op2O6dkTNqkbc8+69yR5n
X-Gm-Message-State: AOJu0YyVfU++LVKvpi5aQGGiRZH/b+tx1zfI/ZWRqJRJLx1igpZXji2X
	jNl+WjpjJs7MNbPDlH4ynn0JJFw/hIsyEeDc3p9vsduANRdfwlSbtaoFe76QuJIkHsl2DZWwvR/
	ps079x4/QlSWbgpw23Fpyr4Za4L/PNNePJ5ai
X-Google-Smtp-Source: AGHT+IHpZXhPcXTAcXdqJRjtYi1u2AkTEZzkMFL58ERL5FdZueJh39/myZryZpRePKMRR8zE38LnWZZJ0UZjRV7QP/4=
X-Received: by 2002:a05:622a:6106:b0:43e:3833:c5e3 with SMTP id
 d75a77b69052e-440577fbfedmr749301cf.11.1717838439279; Sat, 08 Jun 2024
 02:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604123204.10412-1-ivan.orlov0322@gmail.com> <20240604123204.10412-4-ivan.orlov0322@gmail.com>
In-Reply-To: <20240604123204.10412-4-ivan.orlov0322@gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 8 Jun 2024 17:20:27 +0800
Message-ID: <CABVgOS=yQVDr8pvbfasf72Z7qoumeY7kwexZg5RVPVYBMkXUxA@mail.gmail.com>
Subject: Re: [PATCH 3/5] kunit: string-stream-test: Make it a separate module
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fd8889061a5d6d05"

--000000000000fd8889061a5d6d05
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 20:32, Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>
> Currently, the only way to build string-stream-test is by setting
> CONFIG_KUNIT_TEST=y. However, CONFIG_KUNIT_TEST is a config option for
> a different test (`kunit-test.c`).
>
> Introduce a new Kconfig entry in order to be able to build the
> string-stream-test test as a separate module. Import the KUnit namespace
> in the test so we could have string-stream functions accessible.
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---

Looks good to me. checkpatch complains about the help text not being
long enough, but I personally can't think if what else to sensibly
add.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/Kconfig              | 8 ++++++++
>  lib/kunit/Makefile             | 2 +-
>  lib/kunit/string-stream-test.c | 2 ++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 34d7242d526d..b0713c0f9265 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -45,6 +45,14 @@ config KUNIT_TEST
>           purposes by developers interested in testing that KUnit works as
>           expected.
>
> +config KUNIT_STRING_STREAM_TEST
> +       tristate "KUnit test for string-stream" if !KUNIT_ALL_TESTS
> +       default KUNIT_ALL_TESTS
> +       help
> +         Enables the KUnit test for the string-stream (C++ stream style string
> +         builder used in KUnit for building messages). For the string-stream
> +         implementation, see lib/kunit/string-stream.c.
> +
>  config KUNIT_EXAMPLE_TEST
>         tristate "Example test for KUnit" if !KUNIT_ALL_TESTS
>         default KUNIT_ALL_TESTS
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 900e6447c8e8..4793a3960f07 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -18,10 +18,10 @@ endif
>  obj-y +=                               hooks.o
>
>  obj-$(CONFIG_KUNIT_TEST) +=            kunit-test.o
> +obj-$(CONFIG_KUNIT_STRING_STREAM_TEST) += string-stream-test.o
>
>  # string-stream-test compiles built-in only.
>  ifeq ($(CONFIG_KUNIT_TEST),y)
> -obj-$(CONFIG_KUNIT_TEST) +=            string-stream-test.o
>  obj-$(CONFIG_KUNIT_TEST) +=            assert_test.o
>  endif
>
> diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
> index 7511442ea98f..d03cac934e04 100644
> --- a/lib/kunit/string-stream-test.c
> +++ b/lib/kunit/string-stream-test.c
> @@ -534,3 +534,5 @@ static struct kunit_suite string_stream_test_suite = {
>         .init = string_stream_test_init,
>  };
>  kunit_test_suites(&string_stream_test_suite);
> +MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>

--000000000000fd8889061a5d6d05
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIL9UBCljNIvJ+EnhK/FUFH3aWWSu8owy3hArhxZiHOr9MBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYwODA5MjAzOVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBn/UmX
YUT81mb4F+AtP2wSa3AF9D+w4CeEPzCckGcHLTW16FutofFrnv3DADjfrM6o/qGePHhFtK0RX6ad
C0iqe8kRTL7vQpXwkTWn7UidoGYyCiH2lRnJe6k/QWmq8z1c21q0lBAsNUevZRCokq85W4R7F3cw
d8ve8IDl//KLknvwGJNTT9uS/Is9NcyT5q6TIMlx7BIvf3B9IsxtQi3csInnXq41VCVYDyUj1SWN
toMDBxRnejTeWSTwp6I/7RUE70/00omY1YZb/ggc230dgvJWfYCvBzl1uzVAUdRId9JQyb6iMR+2
hIfvtbm5hFUe/qIjSsr4gBQTJsSoXCWz
--000000000000fd8889061a5d6d05--

