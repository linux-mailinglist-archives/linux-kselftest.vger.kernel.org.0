Return-Path: <linux-kselftest+bounces-10896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A1C8D4479
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 06:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A449B1C20C13
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 04:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1263143757;
	Thu, 30 May 2024 04:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ytKRTYsi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8528E7
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 04:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717042967; cv=none; b=XwtQMBehrkI0uW17uM44PANukRctTDXsBwl1hQ7w/1skZM0TXHPpe9TJZoJzn5rs8tuXYF42ipUn810u8qmo+aG7hgWuzhCrXyzLzaPprDzz4RNLP1T7MhOjeX3Ul90qSurVIBKxPOaRgFf4alzyYgxzdYddlIa7I1GecwpN6jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717042967; c=relaxed/simple;
	bh=QTQHmekd8IJLws57lbmxGnSEIU9Utza/JoAYgUPSWTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMs5W3e1BTIhQRsFnCm430K/iL0F7W5GMmVoQJ8Vgx9HnbQaqV1nMlwEgLxf68L/c58/G5V+Kpk3V6jQZg1Zj6GHesjQwwBH71/xRw7ILBArP3nBTf6bBu7rLrT6RT2gVfjR57ZifHbVRmEuMmdafRePt5QVUqPpmRcG6SpN0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ytKRTYsi; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43dfe020675so200751cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 21:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717042965; x=1717647765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TFBLXyl+s6zFaoUppi0ZKBGUu7UjnZeOMGeEDUnAfKU=;
        b=ytKRTYsiuxehMNbjoHSlKvIAuhxb5hngntcR57DmIOObS3rEWsGhJQGcNXyey8F5gt
         BTGWvH1B9AknjYEPhlOw/nLER7n1tGZdrkOoQYZNX3evF2E3rdrgCnKHwFzrMz0S8vim
         qvufKEmjQMUSnAtdDII07XgS2Fywo9gg/6YTJRyC/HiSBtXtZdpFriDtrJ4W93FjxI9R
         L7PCXhQbm1V04OKnVZqL1EJMcAn1o3a2D+ydXJYYSlV87ozp1yQBk/U2wDh7qJakiUqq
         v/3HiDg4NlW1jRx4OMTF6n3uvisub3yV6mrF4U9nIoDOME4tAw1NFkrVMEwLYqwV8Hwh
         J8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717042965; x=1717647765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFBLXyl+s6zFaoUppi0ZKBGUu7UjnZeOMGeEDUnAfKU=;
        b=SVbjOidpj2qtj6zswBdCQAq/on0R4oU/Fy0lBNq8+6qAgE/TZiFnclH1sgH87Mpuwp
         q8qBrW+iBEzfpmPg2RxAj2M5z18d2x3g7G089O8F1G55vMVCZR2b+6faggetp/ZVnzdX
         z7nP4bwg5wQGxxDpizWMi02KWmcrmXHyqjyAg9qVzgUu+jiiGOKretiunc4fx/yOmhsO
         30d65I99TSlEMAY5ML3Dts0iT3nCS/cQ84PgotFx/A+wcsehmR784nuiPL6PrQu/EcUu
         ZrSLl+uV1qoD/nmzTnqS4WPi6Vkgo/YPdLk923sdcwMt+Q/M73oItp0AsjIxNMyUSdld
         +/lA==
X-Forwarded-Encrypted: i=1; AJvYcCUbr57xkqH5ec1/+cHKFTvrR7fvDwk0Ds8UzAarV1Zse6mcJlkh2XT48ZYmz52gtaOCBwbSFxLXBRVTYEt5tc0pPvWTIJEcC+HiyOwPTvBy
X-Gm-Message-State: AOJu0Yxeivwie/huBM/Zm2FDU2elHXQfhrt4KSiP5YhVw7VC8e7Swr/R
	nU3DsrdR6jmS/z+2K3Qsk66hMSSruBP3Iv54N/TMLaQrAKh5T2th00D3lMx4eeDlVm5x7EOWPz0
	KbdLvtlxH/6uuZJlxX1JuBZR/6vdWkqvOPLzB
X-Google-Smtp-Source: AGHT+IHCkFzf2/etPUWs8QgM9kINz0Ajf33AWvBIbvxwx7hwW1jESougvmtnULBz0vUWfEzxUZLiTyZOCNmalNRIi8A=
X-Received: by 2002:a05:622a:4809:b0:43d:dc3b:518c with SMTP id
 d75a77b69052e-43feb3a3342mr1005361cf.11.1717042965087; Wed, 29 May 2024
 21:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516211731.1635930-1-ivan.orlov0322@gmail.com>
In-Reply-To: <20240516211731.1635930-1-ivan.orlov0322@gmail.com>
From: David Gow <davidgow@google.com>
Date: Thu, 30 May 2024 12:22:31 +0800
Message-ID: <CABVgOSkFt5beXua-DsFPzebSm1S=o3rqnctzzHHtg-pZC=zssA@mail.gmail.com>
Subject: Re: [PATCH v5] kunit: Cover 'assert.c' with tests
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kunit-dev@googlegroups.com, skhan@linuxfoundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000007538c0619a4382d"

--00000000000007538c0619a4382d
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 May 2024 at 05:17, Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>
> There are multiple assertion formatting functions in the `assert.c`
> file, which are not covered with tests yet. Implement the KUnit test
> for these functions.
>
> The test consists of 11 test cases for the following functions:
>
> 1) 'is_literal'
> 2) 'is_str_literal'
> 3) 'kunit_assert_prologue', test case for multiple assert types
> 4) 'kunit_assert_print_msg'
> 5) 'kunit_unary_assert_format'
> 6) 'kunit_ptr_not_err_assert_format'
> 7) 'kunit_binary_assert_format'
> 8) 'kunit_binary_ptr_assert_format'
> 9) 'kunit_binary_str_assert_format'
> 10) 'kunit_assert_hexdump'
> 11) 'kunit_mem_assert_format'
>
> The test aims at maximizing the branch coverage for the assertion
> formatting functions.
>
> As you can see, it covers some of the static helper functions as
> well, so mark the static functions in `assert.c` as 'VISIBLE_IF_KUNIT'
> and conditionally export them with EXPORT_SYMBOL_IF_KUNIT. Add the
> corresponding definitions to `assert.h`.
>
> Build the assert test when CONFIG_KUNIT_TEST is enabled, similar to
> how it is done for the string stream test.
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---

This looks good to me, and passes all of my tests locally.

Note that this does have some checkpatch warnings:

WARNING: Using vsprintf specifier '%px' potentially exposes the kernel
memory layout, if you don't really need the address please consider
using '%p'.
#426: FILE: lib/kunit/assert_test.c:250:
+       snprintf(addr_var_a, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_a);

WARNING: Using vsprintf specifier '%px' potentially exposes the kernel
memory layout, if you don't really need the address please consider
using '%p'.
#427: FILE: lib/kunit/assert_test.c:251:
+       snprintf(addr_var_b, TEST_PTR_EXPECTED_BUF_SIZE, "%px", var_b);

These are necessary, as KUnit _does_ expose the kernel memory layout
(on purpose), as it's useful for debugging. This is one of the reasons
why KUnit tests taint the kernel: to make it clear that this could be
a problem.

Acked-by: David Gow <davidgow@google.com>

Cheers,
-- David

--00000000000007538c0619a4382d
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
hvcNAQkEMSIEIPJNBL0CBdD08nNFOwOa0t1eOlhQH1BaGHQBuBBB0ltDMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUzMDA0MjI0NVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA5VAkN
SpfI+XwKcn7YEu5RyPIxIp7kDDxVnna/b0JgXwP9lhVIcWsEq6SptDSbUu5nF9atNteedRXHy4JW
YMuXcQN2aw9ZLg4VHPn5f8QTxe/DpT5V4yR3RKgy76j4bM07CYNB9JSlhBq2K35W6J6Bk2p2ho8m
jbCY8NHzRWj5vX0YtOrJjOtA/Dd8A6bEOkVyRtOvYIAaNDRkH5CCCGlDSfACSM7xsr5aZG3cte3u
p51AfkslLQYza81mAyCf8wlHYyF0B11bvaXxcZfdewjn4K1/T6b5z86CjDOURlwtSxo8MZo1VBVM
vZh9ePpwO4INCYq1TKuYsGJfBArhp+TE
--00000000000007538c0619a4382d--

