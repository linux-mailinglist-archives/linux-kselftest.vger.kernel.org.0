Return-Path: <linux-kselftest+bounces-13540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168AD92DEE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 05:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21E9283E82
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 03:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E8920332;
	Thu, 11 Jul 2024 03:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+cIlAI0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154781A291
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 03:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720669787; cv=none; b=BRjiMl1YTqT42Uy+HMkt9DcZK/dA+PtlK8JfRtetu6miaOvEF8nyGVZqkUm+Mj9dD8+vUhorGJpjy9qC/Mn4VAP9KvH/KdvtUjJ5jRQr0O/rkdMijL/nkukO3hIx7YwZFnjYwbopezU5j8IaePPhyPNT5g+w3NDr45lOIl0lO0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720669787; c=relaxed/simple;
	bh=T6bKjiC8yaQMk4Ql54wUejnzkroYY6Lth1rXommJvRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvPuwjcHuixy1gbAyozXWmkDc/dJAUdCD89/Oo+57bmlEoRCS4lzvcU4oPXJzj9r5i8/FcBGbCTtB+ayfMDUdRTyVTkbgr4z5JVMiQcfkYFWSOqyvj/+ae23xnvYSa+Rd/8b+cLMopgAPU7Xvrul39Hy5/JvNeQRPOI4u/kFEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+cIlAI0; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44664ad946eso96901cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 20:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720669785; x=1721274585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FoGKVDpEOijzRvpciPbi6L9kwP8TfsdQ1Y0kZOrtJOY=;
        b=B+cIlAI0kLM8ooB+eNq0uhxMOrXMFUeZvtEYh5YCil5GkvO55M2kpZi7J+BUjXI0QS
         cIapQQ+tTajWveDRwgMvWIAbRYjfDpOsyugRVeWpVMzfWjCjFHuIrzDsLyNH65gGRKR/
         ghJLutmA7Z5JrAghE1KgrJlToddQLpTiuBa5HZV5pBcElBuhksEztzsDVuYQgOGb50jB
         qSoxuA8RbydCk5ROtsnxdMMXRZM9XD5/e7OoKXdOa+qA2krZUEeeaybDncjkdFC1nGlJ
         7cd2t9qporr0J1X6PKEHOBFLvVQTHwkxrqZoINwnF+mDpY/lHYRhq5qchsnATh73PBrn
         s1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720669785; x=1721274585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FoGKVDpEOijzRvpciPbi6L9kwP8TfsdQ1Y0kZOrtJOY=;
        b=h7Xea4+k6kuahRWvi+/dJTduMVUEpMCeyO0YSIFbtLtg6XGxY/6amSARCKwU1gY8UY
         Ij+hqwdsvC6LwxY9XkE7K79MpXmy/mr4RFfScg0m1s0+DLROkDnMSjrIM8cQod1neUh2
         UBmr3pRAnVyAfDzrRLfIzchd57NKb3mCHJcOEz7Gbs7GICEOy1AuhnZIXzgoAoxO3tXp
         3XE5y5oDYf2Ngi8LA+Yg+GEeVKYAfVVZ/aZI0Tkf8RoSIc3YUUh8vIpXkgz5IgKgqcoR
         Ys+NhmA5blw3uOJc9aJ5fKd6nE2DVT3oqioB7PtCfQG/0Xi38avs5V7bsc2bj+3ygZ4s
         oRJw==
X-Forwarded-Encrypted: i=1; AJvYcCW/6XJlTSzfEWMlgCOrVrJIRF8WGXwsGaSPTRSVoJ4bTO5fk0r5KaSUHxnqLZoJSeNuLNSCGr+MjFI9XziYDLJYVtpSnZcF8XvXPbF0DQAV
X-Gm-Message-State: AOJu0YyQxUaAuVDlfZzkiaMOBZD/9DjDB1PmQqRa8Pe9CHi7HESmMS/z
	dhjbdMcLmzv1yEvu1Y9xO05c/cs6varimRc4MBAz+t+ezSdmFWoqkzUL6/IHjVBnU97SQJNM/A7
	wTQ/fIFQJ9zzyoQfeuID8lClgNSRC9nCUd9Hk
X-Google-Smtp-Source: AGHT+IFbzQv8Oi/RPOj69gFpNM/l0dRuKZ5AUI3WBFAG/a7eymg6kcl0kazNC7bIAXbhyFPXVCzOY8Fh7XAiZUq2ZPI=
X-Received: by 2002:ac8:5650:0:b0:447:d7fd:63f with SMTP id
 d75a77b69052e-44d35b2b4abmr1081231cf.19.1720669784825; Wed, 10 Jul 2024
 20:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710170448.1399967-1-ericchancf@google.com> <20240710170643.1401358-1-ericchancf@google.com>
In-Reply-To: <20240710170643.1401358-1-ericchancf@google.com>
From: David Gow <davidgow@google.com>
Date: Thu, 11 Jul 2024 11:49:33 +0800
Message-ID: <CABVgOSkJOyLDZmPk5vj+o7aRbEZFDJvynWRacNJZ_M_gn9x1XQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: Rename KUNIT_ASSERT_FAILURE to KUNIT_ASSERT
 for readability
To: Eric Chan <ericchancf@google.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000054966d061cf0a7eb"

--00000000000054966d061cf0a7eb
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 01:06, Eric Chan <ericchancf@google.com> wrote:
>
> Both KUNIT_FAIL and KUNIT_ASSERT_FAILURE defined to KUNIT_FAIL_ASSERTION
> with different tpye of kunit_assert_type. The current naming of
> KUNIT_ASSERT_FAILURE and KUNIT_FAIL_ASSERTION is confusing due to their
> similarities. To improve readability and symmetry, renames
> KUNIT_ASSERT_FAILURE to KUNIT_ASSERT. Makes the naming consistent,
> with KUNIT_FAIL and KUNIT_ASSERT being symmetrical.
> Additionally, an explanation for KUNIT_ASSERT has been added to clarify
> its usage.
>
> Signed-off-by: Eric Chan <ericchancf@google.com>
> ---

I personally am not a fan of KUNIT_ASSERT() as a name here: to me it
implies that we're checking a boolean (like KUNIT_ASSERT_TRUE()).

Does making this 'KUNIT_FAIL_AND_EXIT()' / 'KUNIT_FAIL_AND_ABORT()' or
similar seem clearer to you?

(Or possibly we could make this KUNIT_FAIL(), and make the existing
KUNIT_FAIL() become KUNIT_MARK_FAILED(), though I think it's not worth
the churn personally.)

-- David




>  drivers/input/tests/input_test.c |  2 +-
>  include/kunit/assert.h           |  2 +-
>  include/kunit/test.h             | 13 ++++++++++++-
>  3 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
> index 2fa5b725ae0a..cbab24a265fa 100644
> --- a/drivers/input/tests/input_test.c
> +++ b/drivers/input/tests/input_test.c
> @@ -31,7 +31,7 @@ static int input_test_init(struct kunit *test)
>         ret = input_register_device(input_dev);
>         if (ret) {
>                 input_free_device(input_dev);
> -               KUNIT_ASSERT_FAILURE(test, "Register device failed: %d", ret);
> +               KUNIT_ASSERT(test, "Register device failed: %d", ret);
>         }
>
>         test->priv = input_dev;
> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
> index 24c2b9fa61e8..02c6f7bb1d26 100644
> --- a/include/kunit/assert.h
> +++ b/include/kunit/assert.h
> @@ -60,7 +60,7 @@ void kunit_assert_prologue(const struct kunit_loc *loc,
>   * struct kunit_fail_assert - Represents a plain fail expectation/assertion.
>   * @assert: The parent of this type.
>   *
> - * Represents a simple KUNIT_FAIL/KUNIT_ASSERT_FAILURE that always fails.
> + * Represents a simple KUNIT_FAIL/KUNIT_ASSERT that always fails.
>   */
>  struct kunit_fail_assert {
>         struct kunit_assert assert;
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 87a232421089..d1b085fd5dc3 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1193,7 +1193,18 @@ do {                                                                            \
>                                                 fmt,                           \
>                                                 ##__VA_ARGS__)
>
> -#define KUNIT_ASSERT_FAILURE(test, fmt, ...) \
> +/**
> + * KUNIT_ASSERT() - Always causes a test to assert when evaluated.
> + * @test: The test context object.
> + * @fmt: an informational message to be printed when the assertion is made.
> + * @...: string format arguments.
> + *
> + * The opposite of KUNIT_SUCCEED(), it is an assertion that always fails. In
> + * other words, it always results in a failed assertion, and consequently
> + * always causes the test case to assert when evaluated. See KUNIT_ASSERT_TRUE()
> + * for more information.
> + */
> +#define KUNIT_ASSERT(test, fmt, ...) \
>         KUNIT_FAIL_ASSERTION(test, KUNIT_ASSERTION, fmt, ##__VA_ARGS__)
>
>  /**
> --
> 2.45.2.803.g4e1b14247a-goog
>

--00000000000054966d061cf0a7eb
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
hvcNAQkEMSIEIN14yK9IsT8m2SWZBhhrGAQPFRfS4X46inHaWvdM4vLbMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcxMTAzNDk0NVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCEcrkD
QAat388wrN1S1OSALx9Ca93Ieod0DBTAZLm09hu2ErX0h6iVbfyyI7T7l0RDnvtq2LcOiFwHKsYX
yBSlJV6Qh7k6rKF2QvYVCGkC72SRUIPeN4BhhhyvbzkxiBOwPC46dfaYml0oaWpffinhlt4u9i/H
f1tpvzMbQbRUs8iSJ53Lp8ngkW39siPNEsrk5xCJ2o1IqkN0J61tylba5qKVKVKyqqiRdXvuSVyN
fXyjGVs6EI6hGvaFbg/0PvZL7juowDY/Y3rQDFKHpcwpLe4xDpGmNd4FLsYwuNIbp+JPkBJ/zfZ2
y4nzMknNWGviQ99Gh6G/INjGYo9zj5/d
--00000000000054966d061cf0a7eb--

