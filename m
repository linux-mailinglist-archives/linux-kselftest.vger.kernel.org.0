Return-Path: <linux-kselftest+bounces-2096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC778155EB
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Dec 2023 02:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E14B222A2
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Dec 2023 01:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2CAED7;
	Sat, 16 Dec 2023 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2INKfFX5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3218A10F1
	for <linux-kselftest@vger.kernel.org>; Sat, 16 Dec 2023 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so5539a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 17:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702689616; x=1703294416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xEBeVTo4Jr4XZQEXknQBfdq3XHHHlWUDfj3jqDegxpU=;
        b=2INKfFX5mPWcA8EnazZ1cvR+3rmleMVgyODijed9lOM2HxCY7ImKhMGhVf392sJ0yB
         /EbuPA5+Q9wa3flfFLLsvvMUmDBguePIkpVT9RY/pFQuDwVLrCfGilr9S1gnTXLtt8q7
         SiiOflsfqiahF30aoNg2SGjW9btbqHaBt4r5cJ9NjHTFb8vw0oxAH3LNmkttvo8beXS3
         7wExng0MuHT3RdL9PRUaINIpAMG8keQUrjaeV91SfWFfPi/X9WbGYS9wBYLgAyU0OT/i
         i9dbR3AZFUwBSzLlXIitxvtv2lWmm+KqO5RKxZ3jyB9b18ejT1Tgu+pFO57n1ycnpi0i
         m1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702689616; x=1703294416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEBeVTo4Jr4XZQEXknQBfdq3XHHHlWUDfj3jqDegxpU=;
        b=B24TJkQkpdpYgMGK9JyGTKu4hV3VQbCKddj2XQwm+iPIDT7NaXmItS94wTudI2RFu1
         qvMC6tVTxYZwIYS8DSrucGioBLs3dDJe+6RFWHxRPOCDDC2BFdH2/XoM1iSF8Krynood
         8SAY6aWWZ0kbIyVaN6QksSJmnkVxC3YW9nBkzITq9fYPkj5LpHI3tw+36m3DyqTTaWWd
         /ujMHWsKiqPrKPLFAw9ZspRrvtTwS4xsMJ4kiZ8/cRCbfDtpPkRTcJZw8P0rf+EhA498
         UtuxQNS9qQIpot/cy6aPm+Md30hBIEEPsJbppqBHRwF7mFO+U7NAC+OqUoQmChVC3UNy
         llVA==
X-Gm-Message-State: AOJu0YwW4R5bq/mWc02iAcqtWHDFxS+jUWf6Cn2dZMao76lgWqvvwejU
	bwhm0Rfy+sMp72W/hiGbvsxd5TeT9OObbBR35DbPxhIC3IN7
X-Google-Smtp-Source: AGHT+IGnzxZdkgaHuKuNUBZw440TDMxgH9easecK5eLdMkJoLeXa1FtCYVI5fYlcAUvPoIc+rA85ZzQ6L6Rf+kRqsFs=
X-Received: by 2002:a50:d781:0:b0:551:f450:752a with SMTP id
 w1-20020a50d781000000b00551f450752amr69949edi.6.1702689616081; Fri, 15 Dec
 2023 17:20:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215151327.1835-1-michal.wajdeczko@intel.com> <20231215151327.1835-3-michal.wajdeczko@intel.com>
In-Reply-To: <20231215151327.1835-3-michal.wajdeczko@intel.com>
From: David Gow <davidgow@google.com>
Date: Sat, 16 Dec 2023 09:20:03 +0800
Message-ID: <CABVgOS=imuVpgwwhSb8AQ_=YG2bfK8T5DE9yYr_XUb1CPDzxgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: Reset test->priv after each param iteration
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Rae Moar <rmoar@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c31171060c96510d"

--000000000000c31171060c96510d
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Dec 2023 at 23:13, Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> If we run parameterized test that uses test->priv to prepare some
> custom data, then value of test->priv will leak to the next param
> iteration and may be unexpected.  This could be easily seen if
> we promote example_priv_test to parameterized test as then only
> first test iteration will be successful:
>
> $ ./tools/testing/kunit/kunit.py run \
>         --kunitconfig ./lib/kunit/.kunitconfig *.example_priv*
>
> [ ] Starting KUnit Kernel (1/1)...
> [ ] ============================================================
> [ ] =================== example (1 subtest) ====================
> [ ] ==================== example_priv_test  ====================
> [ ] [PASSED] example value 3
> [ ] # example_priv_test: initializing
> [ ] # example_priv_test: ASSERTION FAILED at lib/kunit/kunit-example-test.c:230
> [ ] Expected test->priv == ((void *)0), but
> [ ]     test->priv == 0000000060dfe290
> [ ]     ((void *)0) == 0000000000000000
> [ ] # example_priv_test: cleaning up
> [ ] [FAILED] example value 2
> [ ] # example_priv_test: initializing
> [ ] # example_priv_test: ASSERTION FAILED at lib/kunit/kunit-example-test.c:230
> [ ] Expected test->priv == ((void *)0), but
> [ ]     test->priv == 0000000060dfe290
> [ ]     ((void *)0) == 0000000000000000
> [ ] # example_priv_test: cleaning up
> [ ] [FAILED] example value 1
> [ ] # example_priv_test: initializing
> [ ] # example_priv_test: ASSERTION FAILED at lib/kunit/kunit-example-test.c:230
> [ ] Expected test->priv == ((void *)0), but
> [ ]     test->priv == 0000000060dfe290
> [ ]     ((void *)0) == 0000000000000000
> [ ] # example_priv_test: cleaning up
> [ ] [FAILED] example value 0
> [ ] # example_priv_test: initializing
> [ ] # example_priv_test: cleaning up
> [ ] # example_priv_test: pass:1 fail:3 skip:0 total:4
> [ ] ================ [FAILED] example_priv_test ================
> [ ]     # example: initializing suite
> [ ]     # module: kunit_example_test
> [ ]     # example: exiting suite
> [ ] # Totals: pass:1 fail:3 skip:0 total:4
> [ ] ===================== [FAILED] example =====================
>
> Fix that by resetting test->priv after each param iteration, in
> similar way what we did for the test->status.
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> ---

Looks good to me. I'd vaguely assumed we'd treat test.priv as having
an undefined value on test start, but thinking about it, I like making
it explicitly NULL better.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

--000000000000c31171060c96510d
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAN
5pmaGVmcQH4zFHbM0cHKmjvHWxQCzlghgyLmj54uDTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMTYwMTIwMTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAovUvUlKik6fLclShkaQo
PmNEc7koUIH08+2S3FnTZhkYrDHbmDCJ7qR/p9/RLOIvRCk/vyILVEAIwhQ4aZBdrzTEwlQ9n2Jr
tMysE39pIUYW8HylBnE5qIHypRcgQHQU1Ksk5j5rk3g0n+pJbJ14U78FUvGl9expqhubqaMfT+b+
6eEpLa2B6P1BPFQTGK62Fvg9heogBmRs8G6MSFDuTBNwNFTB8GQggq5N4q0uEvyIa2a2VyCXLrhE
QlhGIJ1nu/XHyq2dcM/fPhHwYBjxvK6yvZ2J9H2YJpBK0BBbVsCFk44MBgyVzjmQwZwSOdpyLckg
bs5oK/KFhJXuvxmwog==
--000000000000c31171060c96510d--

