Return-Path: <linux-kselftest+bounces-13028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153ED91ED9C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 06:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3825A1C21269
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 04:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D643526ACC;
	Tue,  2 Jul 2024 04:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y6CtEla0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555AF2030B
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jul 2024 04:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893125; cv=none; b=syDCnCEQ9y5euSUYx/IcTSGA0zPmM2x0ouT5W0yRt5/TFqMlAZ8w5sOrI8CZtwyBZC27wFjvMYV11v/DtCsCQyvUll5f6oNZhVwZj/BRs2CEbMHvzk6Lj3B8ji5j0jmtEauXWG/6Tng9qTzmIYAWDfBxYd2S4FqeH9mr58Svawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893125; c=relaxed/simple;
	bh=fNImaXG4xknWnuSssOVHel4K8kBrZzxAti/tqI73XRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5jpFqMYimydOomATjVQgcPA+vPmOlk8aUBfNJcmNUB5WJfNTm3bv7RKjP/6+wc9PxwreW1kKdkNOdXND5mjlbO3zi9PGw+yYK7/38YP7C+dr04blYyL7Ta/RocyPboYHzpYzTqPfU0LySdFoycmLiWFadsK3CVTinAhCiT3C+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y6CtEla0; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-444fe7e9f11so765031cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Jul 2024 21:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719893123; x=1720497923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fNImaXG4xknWnuSssOVHel4K8kBrZzxAti/tqI73XRc=;
        b=y6CtEla0hWMdsMehtMLi8mMZ3XZ/jfZZYnk9aYKELHM9g9bOcS91rpeTRnjcjl7jgd
         p+rZoSTqvGhhKXtk86k2hJmer3of2ORQBB1pJjNxU/AFfvH4ch+vMHLiE3o65yo5Mps3
         u6eipKJOGPC01KIAHsYRIDnO/80ZjLhdxKxW8gnAYx7S1qv1Mq1uhpUTDhXaX1ejgr3i
         dTT1l1WUpCfbmPuCCY8lxvjHlW6STXzbsmNv5YhNg10D136pdB8oc7Nup/6vr/xlc2pP
         oxhhU3Gxt5EAe00y8XBFnOBDm5DZodzINGHXA7hLoAJ6X/KvGz9UdqGk2ASaZsSq3LkS
         1F3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719893123; x=1720497923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNImaXG4xknWnuSssOVHel4K8kBrZzxAti/tqI73XRc=;
        b=oaDXJS9OZphyPLYHqdaWyRVy4SZMRzr8gLZ+A25Qq2IBOHnoC+Dgwi4ykK6+u5lHC/
         FzwAbC7Q5c4e6rsdh82mRMWXrUQFOx/oevNnwcXwhiIbCCzxWxzkEPqD4WPyW3UzfHzX
         1tH2V/TlFavIjd8wTXLv5yr7rAxzhOMPEWwJN8j0W8G4wH9e74/QfPBv9Zb8TLFE8Ujh
         tnnL/EKloe9+WUa0mI2rF6Z28UVPWX0falFI5PTdvq/qeR+JmB9aiYlU3GdBXswkXwFw
         z/0fEAlj1LFBQGDeH9eILM3UxXDsqlRh6aNUwFGIEvZodRxLRyVpX6YzPZyvQUySL/0H
         3QRw==
X-Forwarded-Encrypted: i=1; AJvYcCXFjhESbFYqEPc+aIBrU4bQPSBTLzoqo6O+MTTcvnW12zx6OE+fnpAxwXG8285Ui4O8uE8Aqk1H8adsueB5hbCpAiIEdPaxZbNYAmftgKpY
X-Gm-Message-State: AOJu0YxkU2YEIFkTsO0I/dwhB7wvWLJeK55SkFahssuuWe1lDhB5XDyv
	2P+kjCLxEaM1qdmKiY/kINUtoJYSOoJPrXnlM7jrR6spsnGtuPTA8Evtf7yXisyUhK+tVJ82IKi
	6MYfhLVjZffgZOe3S1TgIGSl5vylD87pqdWCp
X-Google-Smtp-Source: AGHT+IERnb8c9twaRApiB6apELSkVdUVuCvxqT8JyCmXCXDDLsHGhtHYDy4PTcuFVgv+tVRHq1244xcxH3u9Pp+J/rU=
X-Received: by 2002:a05:622a:4709:b0:444:e9b9:708f with SMTP id
 d75a77b69052e-4465df8c326mr6031971cf.21.1719893122967; Mon, 01 Jul 2024
 21:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619202511.it.861-kees@kernel.org>
In-Reply-To: <20240619202511.it.861-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Tue, 2 Jul 2024 12:05:10 +0800
Message-ID: <CABVgOSk7RCMak0ZjRaTE4tYAwV5ZZ2ZHdWC7RWO0Vo6ZwORMdQ@mail.gmail.com>
Subject: Re: [PATCH v2] kunit/usercopy: Disable testing on !CONFIG_MMU
To: Kees Cook <kees@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, kernel test robot <lkp@intel.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ae864d061c3bd2f6"

--000000000000ae864d061c3bd2f6
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 04:25, Kees Cook <kees@kernel.org> wrote:
>
> Since arch_pick_mmap_layout() is an inline for non-MMU systems, disable
> this test there.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406160505.uBge6TMY-lkp@intel.com/
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Resending as v2 with Shuah in To:
> ---
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

--000000000000ae864d061c3bd2f6
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
hvcNAQkEMSIEIERdrr/H+lcdIq/omLS+iZA7EBY0pE5H3TdzU0sC0PyaMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcwMjA0MDUyM1owaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAeCMCg
tCdPjIqGlcKMlKtJmPCqeRkGLVnYVmfq+0NHbmKYhVRPrt9gBRN22kMzWLYXDkQEJ8Y3fhCJBmMc
AdP1zNzBBuj4aooMxRpItgXoXskUBJ/Y8/r99knnZeV5JTPNVMIbLIYkAiRrrNYp42r7sXs5u6AK
ZttK2Xy7KbPhwmwI9QRfCFgG1PQG5cnWgZYLBN+TJN7bHkElYCFz4oWw3BmKFuSw/lZL9mWdCLdG
3wPWI+ANRH8czQ57qCn8hzHfYhVok00jyKdbuD0XT6tqGwudI4ybSSGZR3HA84tRR93CkRUrHALn
L3HraDUZYCsnK9h2y3vsaT+OBkeAyNvy
--000000000000ae864d061c3bd2f6--

