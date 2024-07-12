Return-Path: <linux-kselftest+bounces-13639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD5192F592
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 08:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679FC1F21E13
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 06:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF23219E2;
	Fri, 12 Jul 2024 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5tTAjEY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65769567D
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Jul 2024 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720765872; cv=none; b=W3qHKllSr9MikJVlBeqT9PRQVllRxS6fsYP8Cr/9nKLv4vIPQK2D8mLbHzLBGpGpdXVicL/32CY0nIt0RWV/g50LMbbCD37Ao3IBRtFEt3wHnioDlohbkB/aNQuC/D/D0eTmi9xn6CL8CbhHcC24y7uauXoHFBjoRck9Ag3+k84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720765872; c=relaxed/simple;
	bh=myXjWKGQrfPefdYWOLvzexTEnAjbCXINKDtRbi1bnLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmCoobBe8DOI34oO+qH8S6EPq+Qk3QBpKXTMQaLEN1NTO0PPjYT2kxTucGBtVA7f0UczCYDlvUoodhIx5SIKSBWSpVow05w+6/NKUDW5FOZ4Sfo3VlZGqFlX/D9FB4ZgoXRu3DvIfuA+7X0osWgepcvEkRDR7vtDhAIebigV22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5tTAjEY; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44e534a1fbeso118941cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2024 23:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720765870; x=1721370670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gNrKQvie6HrKTo+bh0Z1VNRyk7umOL9WiYnRKpoYJP4=;
        b=P5tTAjEYX7Bv722VmsuaVqhg8jM1DpX4MQwLoawzVh43LgmSG3PMKeGrwomaNWb8od
         +aDGoNL5jTb+nsRIpa285eqJNtaOMD93QS7jsp9bPMn1XgZMd4kpIpkda8e5I/wUdxdH
         nMEWJpl/Ih2YEVClF+J4U8ccO5/pw+TsRwpnORHcoKtL+OlT0GaZmL6otxUnEKzQbaK4
         8vuIoHoheUdDu8l/rUR8WlSiTfIH8YfqncT+VzCTNEmHGZphzk4ObiVx2MIWBwFAptL1
         2BR8euyQBgBQnByZbJXBhQ+hw0DUBel/ncjJvWk5HLD7go+LMWZ4jzvnFhDRDVGscizY
         djPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720765870; x=1721370670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNrKQvie6HrKTo+bh0Z1VNRyk7umOL9WiYnRKpoYJP4=;
        b=QhLIACG/053cCnaJPbWElI4Z0BHSs1Vc8m3/U4WVI96+KXOh2l4Ip7PNDKAqRs2LTS
         JDkvQo1Q45+q5oQGWzISGYdewkeYonZFdO08Eu1CcSi3v8iuGbKDMnyYr7eeB/V2vBsT
         WF7XLT0mvetEZbea1gwRODyxRw2QYUTxjOaOfUFjVMwE9CDjTr3uYtnPn5TVDfHcJ2ml
         KSPzUumcOCJA+Wc8UAm1bCMhlXhOorOA32LBj+bKdorMQ2lulDBfGvTw+aMXVs+sfY8M
         u6uyKZRGJL4dyT5yuZmuXtLC+mGTUufDCApbtg850GDwE+nfgtyLdQagf5GGhMvprC6l
         mgTg==
X-Forwarded-Encrypted: i=1; AJvYcCXsgj/u024+MgDpfltsCpx6q1LpjKbrD6f3tiNhV+VNl1moxy4rzIS6SVnsQnSl6pIZrpcLkWWFuqFnfEF79qfBYzgFgr0RjMNrnXw149V6
X-Gm-Message-State: AOJu0Yw02eWD8lJoPeBVD/EqWCLuB7clLJJBUR/x02aJqC1SJyLNLDny
	jLinN+wik0RoloGO+WnwrL+QrlufqhGzIoMITfC1Z1aaFnqZ5pwSpcphpwt1EWMjr/JTRGdrcHY
	DXLyklJnJWBSA+Ez4S+avzhgENzLbh3qHAnBo
X-Google-Smtp-Source: AGHT+IECHi4Kcm+OnR5krlgw01mHCPsKYlovxeJ8I7Z6JxOsEVd+/xIR6yZkS2nGwZEBW9G4WtM/AiDCFSlo47/yCcI=
X-Received: by 2002:ac8:528d:0:b0:447:f958:ab83 with SMTP id
 d75a77b69052e-44e9e36a42emr1287931cf.21.1720765870107; Thu, 11 Jul 2024
 23:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711193729.108720-1-ericchancf@google.com> <20240711193917.109380-1-ericchancf@google.com>
In-Reply-To: <20240711193917.109380-1-ericchancf@google.com>
From: David Gow <davidgow@google.com>
Date: Fri, 12 Jul 2024 14:30:57 +0800
Message-ID: <CABVgOS=hdXSFkWGOiNhPm4z9KF_UTMGSZR36sKbzOjxCcS0p=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kunit: Fix the comment of KUNIT_ASSERT_STRNEQ as assertion
To: Eric Chan <ericchancf@google.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000075a3fc061d0706a5"

--00000000000075a3fc061d0706a5
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 03:39, Eric Chan <ericchancf@google.com> wrote:
>
> The current comment for KUNIT_ASSERT_STRNEQ incorrectly describes it as
> an expectation. Since KUNIT_ASSERT_STRNEQ is an assertion, updates the
> comment to correctly refer to it as such.
>
> Signed-off-by: Eric Chan <ericchancf@google.com>
> ---

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David

>  include/kunit/test.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 61637ef32302..87a232421089 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1420,12 +1420,12 @@ do {                                                                           \
>                                    ##__VA_ARGS__)
>
>  /**
> - * KUNIT_ASSERT_STRNEQ() - Expects that strings @left and @right are not equal.
> + * KUNIT_ASSERT_STRNEQ() - An assertion that strings @left and @right are not equal.
>   * @test: The test context object.
>   * @left: an arbitrary expression that evaluates to a null terminated string.
>   * @right: an arbitrary expression that evaluates to a null terminated string.
>   *
> - * Sets an expectation that the values that @left and @right evaluate to are
> + * Sets an assertion that the values that @left and @right evaluate to are
>   * not equal. This is semantically equivalent to
>   * KUNIT_ASSERT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_ASSERT_TRUE()
>   * for more information.
> --
> 2.45.2.993.g49e7a77208-goog
>

--00000000000075a3fc061d0706a5
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
hvcNAQkEMSIEIKbfDTgIPL+WlrlxTn3StBoeGiMzhclzFPrOWbAxi+lQMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcxMjA2MzExMFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBl4a/z
Z1tG/QjMwZSA8juy7YWMy0UwFbLkHDXTQMbLLAul0a3bl+PwmGkJNBXPw0a4erjWbrCSwTVK1bzG
7ES4ERQsJRo4Px/UgLybD1vQUwgTyFJPFdRZ6u9pKwMZ6AKsd62+YcDmIP6TuZElGRiHLMB1+EU+
5AqQyMFEZc1eQsAkJ8OMLkNIdMQ/bKRENkQk3WAau5J5X2CUpgXTZcEpUsLv3HD5lYYDMYSsWcSI
B2y8VA5Cbdaqq3Faewmq5UkWCo2bq2LsXqWg7M01HHeUFn7SyWXFYP62/s1K13EpfxerQJyh249s
0NGt9rHOfeVRQ2dTMAzTtTP0qPRba70f
--00000000000075a3fc061d0706a5--

