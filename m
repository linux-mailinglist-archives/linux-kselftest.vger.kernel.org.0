Return-Path: <linux-kselftest+bounces-14506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905339424BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 05:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E454CB234C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 03:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B07E14F70;
	Wed, 31 Jul 2024 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0XZPEKM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69B517BA2
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 03:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395179; cv=none; b=dXMEE4iMtBYPnw5Wcoo/i4QF4Z9pLRv84TgnhSY11FCAbwua+KHByQc3+YWGF7Bs1ZpGGAxT7kPhWFBcs3Z/aD6N4ZNAyICQGo6fQ+tP107pZsBRi7kRpHwVmzW9hCtkW9qGsE3L6cJKXFhg4BEpEevCQDq+CsJPdy1wyX4rZzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395179; c=relaxed/simple;
	bh=1WP5OehfJAI76PqeNlDSi0pg1mFnKkUaDVjz0r+bsBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aa6gDcjbuKKdIZpIm1UYbqXipqrM/uISFRolttSZ8vrgDjF9XeJZvoX/gUF0XjhVyYtDeRbuGUAPt0Zl5kM2STJBF3WhxTFlhwQjKAy11clS8ED7sZMbmoFkjXQ3NIkW2dHHP2LcNFVkr+gRKxwomXe8Nss11TPlcRFAcEhFQ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U0XZPEKM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44fee2bfd28so190101cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 20:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722395176; x=1722999976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KqWnr2tB2EAR1VMPA5HfqWSbBLimEFFpFZrgedD7mng=;
        b=U0XZPEKMxwnuJKvi6NXzWsjCfg7W4OrEeWas1rsK3Fhr9fWkgdEZvc3LSiVGN4dmH/
         ehTkUfYui6CEfw+MB2gCJQ4t4WtuD8I1prsh6NbJA7OFSBDOjbujFb6HXrce1dTSsBBz
         QPjEziCBYCPXRLx05/SAP4udLZilPyzAhKAShOcqI1hNbGRI63/X8ccQcYCVGPXifVlt
         izHI/F+JUecaIywob5EKPMkPwrIWsLMs6tYn/BEK+Bc1Wsu2xSAW6MwQqTZaQTHOa7qP
         H7LMstcM69EZo1qvJmJahKaQ9jP4bfQmMrkHIDE6SjSCYdQbLpetfJiB77gihGR5VPnM
         4gJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722395176; x=1722999976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqWnr2tB2EAR1VMPA5HfqWSbBLimEFFpFZrgedD7mng=;
        b=J00WMeV7lCeltDituN+E4j837v3LTFSDP2ECz+eSt1GB+CVkDWLu1H5bwdhiRhKIia
         qY5j0uJFw721inXc7O8U2Ye5qFAc3O37QtdK+nqeng0htw1T2WyQFtbHP+EdS8J2VDw6
         EQJauiNCD4fALgt6MoN9rb2ZM8vAezwAY0b8QHmkJoUW4eOzTjYHlxeWr3J7SGx+D+A1
         JRxqoo+5k66zfmpnJXZgeUFQo0EEOBw3po7UUsg9+bWvsr13o3JTLBvAJZY7DxMGNz1Q
         0srg8JscUuXl0+QGUtaF/rIpIMppEjhBTisY08Pc1lAXRygFr5EZaPO2+yyt5xh55kNp
         AQVg==
X-Forwarded-Encrypted: i=1; AJvYcCXT+LtLJ/E6BYAG2hSBtUOZiHCuqj7Rw9FalLidW60FzOpzFY088DyzfLAJHjiTSN8aV/Ykt9wZdd8DqND5hr9/c0paWl8bSvhp5ry/ijxf
X-Gm-Message-State: AOJu0YyaxyLNOOXLFh/UC2JcEBRd4sRVD75NC64UP4Birh99NmQUQOar
	qjhz/2BqNub7x2P1mYRlGKdai2pvoef7HkR3UcvD8zafyzh9N795YHeYfSWewvN4JwzZh4/ieVK
	C/CQn9jR0zl4J/0yxqdBhzqQAokh+8tcIzj3G
X-Google-Smtp-Source: AGHT+IHq6aUQGeXlOf/Q1UYSu80byimCj04UgEyuJYoGmvtNtsZ6g05MMU/rGmASAuzcgzrYXPgwbE5E+1ATceelIoE=
X-Received: by 2002:ac8:5889:0:b0:447:dbac:facd with SMTP id
 d75a77b69052e-45041a4965bmr2159861cf.24.1722395176366; Tue, 30 Jul 2024
 20:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <27b91030-b01f-44e4-82f7-93b3e11e8d74@linuxfoundation.org>
 <49108735-c776-4b6f-8264-62a827dd7b26@collabora.com> <0c2a5c8e-e48a-40f1-bc84-01669a5b8741@linuxfoundation.org>
In-Reply-To: <0c2a5c8e-e48a-40f1-bc84-01669a5b8741@linuxfoundation.org>
From: David Gow <davidgow@google.com>
Date: Wed, 31 Jul 2024 11:06:05 +0800
Message-ID: <CABVgOSmTtox4kdEFHwkZR=N0iHQY3tpugWSFU0exYzHOHYJp_Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] bitmap: Convert test_bitmap to kunit test
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kees@kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, kernel@collabora.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000af0de7061e826039"

--000000000000af0de7061e826039
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 23:49, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 7/29/24 02:29, Muhammad Usama Anjum wrote:
> > On 7/27/24 12:26 AM, Shuah Khan wrote:
> >> On 7/26/24 05:06, Muhammad Usama Anjum wrote:
> >>> In this series, test_bitmap is being converted to kunit test. Multiple
> >>> patches will make the review process smooth.
> >>>
> >>> - Patch-1: Convert the tests in lib/test_bitmap.c to kunit
> >>> - Patch-2: Rename the lib/test_bitmap.c to lib/bitmap_kunit.c and other
> >>>              configuration options
> >>> - Patch-3: Remove the bitmap.sh selftest
> >>>
> >>> Muhammad Usama Anjum (3):
> >>>     bitmap: convert test_bitmap to KUnit test
> >>>     bitmap: Rename module
> >>>     selftests: lib: remove test_bitmap
> >>>
> >>>    MAINTAINERS                           |   2 +-
> >>>    lib/Kconfig.debug                     |  15 +-
> >>>    lib/Makefile                          |   2 +-
> >>>    lib/{test_bitmap.c => bitmap_kunit.c} | 624 ++++++++++++--------------
> >>>    tools/testing/selftests/lib/Makefile  |   2 +-
> >>>    tools/testing/selftests/lib/bitmap.sh |   3 -
> >>>    tools/testing/selftests/lib/config    |   1 -
> >>>    7 files changed, 295 insertions(+), 354 deletions(-)
> >>>    rename lib/{test_bitmap.c => bitmap_kunit.c} (70%)
> >>>    delete mode 100755 tools/testing/selftests/lib/bitmap.sh
> >>>
> >>
> >> Can you tell me how this conversion helps?
> >>
> >> It is removing the ability to run bitmap tests during boot.
> >> It doesn't make sense to blindly convert all test under lib
> >> to kunit - Nack on this change or any change that takes away
> >> the ability to run tests and makes them dependent on kunit.
> > Let's discuss this on discussion thread [1].
>
> So - it doesn't mean that it is a done deal. Each patch will be
> reviewed on individual basis. This test in particular clearly its
> use-case right in the config which was deleted without understanding
> it.
>
> -config TEST_BITMAP
> -       tristate "Test bitmap_*() family of functions at runtime"
> -       help
> -         Enable this option to test the bitmap functions at boot.
>
>
> This line above is the important piece of information which tells
> you how the test is intended to be used.
>
> 1. You can enable this option and boot the kernel to check for regressions.

Converting the test to KUnit _does not break this_. You can still
enable this option and boot the kernel to test for regressions if it's
a KUnit test.

> 2. You can load the module on a running kernel to check for health.

This is where the disagreement lies in my mind. While you can do this
with KUnit, the kernel does have to have been built with CONFIG_KUNIT
enabled (either built-in or as a module).

(Indeed, KUnit adds the ability to trigger a test at runtime even if
it's built-in, via debugfs, so it's possible to do so even if
CONFIG_MODULES is disabled. That's a pretty niche use-case, I admit,
but I'd guess that the bitmap functionailty breaking in a way which
disappears when CONFIG_KUNIT is enabled is as well.)

In general, though, my interpretation of "Test ... at runtime" in
config option descriptions has not precluded introducing the
CONFIG_KUNIT dependency. We already have several KUnit tests with that
in their description, several of which were ported to KUnit later.

>
> Converting it to kunit drops support for these two use-cases which
> are user-space regressions. You don't want to do that.
>
> -
> -         If unsure, say N.
> -
>   config TEST_UUID
>         tristate "Test functions located in the uuid module at runtime"
>
> @@ -2813,6 +2806,14 @@ config USERCOPY_KUNIT_TEST
>           on the copy_to/from_user infrastructure, making sure basic
>           user/kernel boundary testing is working.
>
> +config BITMAP_KUNIT_TEST
> +       tristate "KUnit Test for bitmap_*() family of functions"
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the "bitmap_kunit" module that runs tests for
> +         bitmaps int the kernel making sure that there isn't any bug.
>
> And this isn't complete even. I don'ty see tristate in here.

(This looks like it's tristate to me?)

>
> I responded to the thread that started this flurry of conversion activity
> stating that converting tests without thinking through the use-cases
> isn't what we want to do.
>
> Reports aren't everything. The primary reason we have these tests is for
> developers to be able to test. Reports can be improved and shouldn't
> come at the expense of coverage and testing. Any patch that does that
> will be NACKed.
>
> thanks,
> -- Shuah

--000000000000af0de7061e826039
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
hvcNAQkEMSIEIJk24MM2OVbCE3PMX80g9gMPCXNaUD15bcaXlO9dB1DgMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDczMTAzMDYxNlowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAd6wrS
2ZDiCPLdToluc+DJ900o/Nsn1KYd4sZgvDnFjPQ1ihGQj4y/1D3oKLRzfyd/wKnj1v3+Twzxcid7
jA7fswVRbXhIcxWSbNOHgvAW9IYnYeOuRbHs9lTEbkwTRVjjBPgcVjSQgX4njRlYFPoZCTDw6W3D
wNb3+cACC3zqh0piRh0JIO/1rurGENTO39IqEnvPtZpcpBB7nYEOzp8Nj98kk9g+1D43l2XeGxPs
CJ5/UCTnwPtRPwDX29IS38L44vGdAbzAkHo4QgriwYLFcQSpCnV6VHIKwG9BVHyVKu+LXFvW29DV
IQLCPfHW1BXtvZ4Acq2DpjuUyHfZvZ2N
--000000000000af0de7061e826039--

