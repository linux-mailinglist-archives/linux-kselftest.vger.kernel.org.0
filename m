Return-Path: <linux-kselftest+bounces-11488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C680C901118
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30E81C216F6
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAF4177982;
	Sat,  8 Jun 2024 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2lkzY/cx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48257176FCF
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Jun 2024 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717838436; cv=none; b=ohVmjmBnV3PGisVWPjQF+1JfSq0utxAOZFKRFkDhi3768uIADVrRnxmln88OPlVE2/orXjFe4vrNqKoUdT73Uin7ewOm29eEAYQUEcKYaoFsVfpAGa1OIpGZQ6H0L/4VYIP9EIWvCdUw7rj/GYOlTBnSeS4iFsJ9f0g28WlmCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717838436; c=relaxed/simple;
	bh=PiVVnumuhJOSnoYGRmhnZx86ZnEUOgEb1W04S1qp1Nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVR9ds60dMT/K1zM28qKBnA63Z0rXS+VslPd7MwP1oKu2zslKsKErowNjrAvQaEPRHoF2Y1s19LSPFPueNs/8KyHB+ygJ1/lOhfN0BreGUwWqZzID/1tdOSZuMIUzTCLYBZtP0lf9W8BLap+hFVskZLFZXkSsYMFq6VwidE1lXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2lkzY/cx; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4400cc0dad1so215701cf.0
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Jun 2024 02:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717838434; x=1718443234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O+UYSSUsyztlX95Fbaly70mpf40f8bImYc6cmo/r810=;
        b=2lkzY/cxyApugXasjDTNqi0xNEechIQsEf4qnOs9dBf8RLjiRToffCyEvPnbTpOWv7
         2jT2fUcngCTHZ6qJUAlTo/HNLw5j1CYr6bhE2E0HNYrHPDorSV8H8xeSoJQbmUB0XHgs
         WkEJTH0wiBFOwnIxWTlP9HfuPY8RecY+s1SN1FfnA0ExSuSic09xQqrxHF/w60Q5Bzww
         QxWmA8yRuSIdIBszhHFoeQLyFZUcgvO3n+xNCbwqCsvhhO8sWh80tv63WMddKvYUjo/5
         0LPa9HzVyTOOpkngNmCbeXqpph7FrgZk3JGnm1TgppWHF+y/KpgJ35aDTgAvtIYotST4
         F8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717838434; x=1718443234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+UYSSUsyztlX95Fbaly70mpf40f8bImYc6cmo/r810=;
        b=vf/gHEap4leByBT4+H7ofBubMwQka2ya1nLwsdosL+5IBRyWl6AxypQQQu22F+gxxv
         yxsGmVLO5j5UFKGdDWJdAoC2OQFkuEcym+qUlR+bollRB8a4hO/9USSsiGPG7zlKJkmi
         IhMeCYnxnxAcEha37cY0m2igghrC56iPe8vpO/acM9jvqdHgtsak6nhZMThKu5KPX/JL
         AxjOxKO7fRchNP0jV2gNIcU9DGCzFZHwPjja/X0HtU5xmSHYjiFoUYrujymb6xh+Tvzp
         N7zFtdQaM4Tm/T2ZyL35228Q07lEcXj8sJgiWHI9CPzxmA+zdcpVVriPiEtzBxvuWVyH
         M/pw==
X-Forwarded-Encrypted: i=1; AJvYcCUio45eWDXVUqaqSlfPd0NCuUV2sCUvi0ULN4ADJr+bDYeujHtoAYefCqxpFhdO19h5hkKRZh8hm0GUsUilNmpWY2N4fi5VsUqBU/X7lJ/9
X-Gm-Message-State: AOJu0YwlhBnEDWLmdJayaRjv6E/RS69/sY8tqSe1a0eWMgThEyEe3/03
	dA154LkY0nlkk1m7PJZGeIfBSeL1zB0OEPmLedLKoPYeZRMFyjB/RAWnIYUaYJdl4vQ6R3pqVeC
	Q8osq9PHWomZ7UBkBaGhfLQmplUzZaoblWH2C
X-Google-Smtp-Source: AGHT+IEkZaWubzFqUaW+MugQhideaEywgmWtl92Zcv3vR+wIhbNAGbxlNJdK119TvsaE5ioU7IvtjMap0ZQDtCwF78Y=
X-Received: by 2002:a05:622a:5104:b0:43f:dbfc:1f1b with SMTP id
 d75a77b69052e-44056453d50mr1884271cf.18.1717838433976; Sat, 08 Jun 2024
 02:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604123204.10412-1-ivan.orlov0322@gmail.com> <20240604123204.10412-3-ivan.orlov0322@gmail.com>
In-Reply-To: <20240604123204.10412-3-ivan.orlov0322@gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 8 Jun 2024 17:20:22 +0800
Message-ID: <CABVgOSkHzgp34wYaQbk2gq-fNZtW_G5X6+Mf1Z6Ty3vPrCeL-g@mail.gmail.com>
Subject: Re: [PATCH 2/5] kunit: kunit-test: Remove stub for log tests
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ac6484061a5d6da3"

--000000000000ac6484061a5d6da3
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 20:32, Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>
> Since now we are exporting string-stream functions into the KUnit
> namespace, we can safely use them in kunit-test when it is compiled as
> a module as well. So, remove the stubs used when kunit-test is compiled
> as a module. Import the KUnit namespace in the test.
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---

Nice to see these finally work for modules!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/kunit-test.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index e3412e0ca399..42178d5a97d1 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -577,12 +577,6 @@ static struct kunit_suite kunit_resource_test_suite = {
>         .test_cases = kunit_resource_test_cases,
>  };
>
> -/*
> - * Log tests call string_stream functions, which aren't exported. So only
> - * build this code if this test is built-in.
> - */
> -#if IS_BUILTIN(CONFIG_KUNIT_TEST)
> -
>  /* This avoids a cast warning if kfree() is passed direct to kunit_add_action(). */
>  KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
>
> @@ -637,17 +631,6 @@ static void kunit_log_newline_test(struct kunit *test)
>                 kunit_skip(test, "only useful when debugfs is enabled");
>         }
>  }
> -#else
> -static void kunit_log_test(struct kunit *test)
> -{
> -       kunit_skip(test, "Log tests only run when built-in");
> -}
> -
> -static void kunit_log_newline_test(struct kunit *test)
> -{
> -       kunit_skip(test, "Log tests only run when built-in");
> -}
> -#endif /* IS_BUILTIN(CONFIG_KUNIT_TEST) */
>
>  static struct kunit_case kunit_log_test_cases[] = {
>         KUNIT_CASE(kunit_log_test),
> @@ -871,4 +854,5 @@ kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
>                   &kunit_current_test_suite, &kunit_device_test_suite,
>                   &kunit_fault_test_suite);
>
> +MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
>  MODULE_LICENSE("GPL v2");
> --
> 2.34.1
>

--000000000000ac6484061a5d6da3
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
hvcNAQkEMSIEIH7NJ742icCQpj8jDMTSBHagTZ3u0IIm4bCQAmy8APbFMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYwODA5MjAzNFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAMuX3V
u9ZDxlh3ob9CxC0W0ghnM7S9uHXeX3slxr2UtD7WVSAk2RMwcjhnaL8LvBHRV6nU/62xx0dlH4oh
GcFhlbD1XQBYF+Fm0tHfBSVEOa6WXC06uB4aQtVP/CNqTm3EUCweospzwoUE8Q4nfLxGadgHmhMr
O/nby+rxoKyWTdqioSTyI0IDWOPLmrb9tdZ612b1ElEvPhGTPxGSXMTeHr9ME+BVxHkfc6/1L/yd
B4ibhA2BCcXx4NG7HM2jI0FEMcMbdOE/DG3nITGTNDeatJywd4gU32QRImWmAPgsDhxMDbma80Qw
otOINH9bdHZNLk7YXvU5ybpHdYBw0id5
--000000000000ac6484061a5d6da3--

