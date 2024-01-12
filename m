Return-Path: <linux-kselftest+bounces-2886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC4B82BA3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 05:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5458B1F25E00
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 04:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7871B283;
	Fri, 12 Jan 2024 04:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ysjSMXrZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD81B27B
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Jan 2024 04:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so3834a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 20:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705032425; x=1705637225; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E2D3WnN//dEL34fMCVRDrhtzfAYDNH0EGPLifIuUJP0=;
        b=ysjSMXrZAfFSrTlDk1mIsZ9fLZmwbL3S1888jw72lf05FHEq84FnuAcY3G9eJuytXL
         3xoQdqfW8fkca87nD50v2Im0XDkD/n/TB/GoXY/+JP2jT/2A59VH27HisXPqgv4ysfDb
         Ur4J4RveRFXmr6VlrdysgFZMhPPHzRJhmLq1WZ3hwWkuCNVItM5owX++SQkgqVCCVJJ3
         vfe7Ow/30lEpFVTaL35JC8liCGA8x8Z4zqrFIqn+8KJ5FmSbsgqLCCW1GxrULPEPW9T3
         qo+6c+HAs7xLWGDaL2DAKlM29e3Ph2Y1b4HhVDeWG45JUqXgC28T8EIhwl587HMqApu3
         FoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705032425; x=1705637225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2D3WnN//dEL34fMCVRDrhtzfAYDNH0EGPLifIuUJP0=;
        b=LJ/3rWKkPwf6Ksuj1zLZBdjdYZupeWfTOCuu5dNKeFiLdme2FpXZj5Xhw2GL26pN9J
         1aTgDT2uhBDtxTRAC1gQYKVyjd5LbpVsVHPHJZ/m884I3bNepVCKvd4GapYaBgWuvVwX
         TWw+BShnvvMriSzn9AnH9gcDuj6jfz6LxT5thZwb5P7RhqHXzySiEe7R3O0g74mxPXA1
         Mxnay5VXZ+UeBT1p6ZEVgr9Neok/uglinAjgBPiC3a7Utuco5LqKUYvEdY6G4mnZqzm/
         kOx+8QHM0itmSttqSqFwWZniOyMcZXzy2kWp5+iMUBPc7JFLMidaDH06iSUPAG2A6ih9
         zIHg==
X-Gm-Message-State: AOJu0Yy1ggeVNRpqYFwIwk7JYqjlYz4y+RTLGTGGTb+0ei730jDIl11C
	DI+spq/COYnUfCyFJta3I/zTRU6epGk8PXn/3kyQGoqH5TzG
X-Google-Smtp-Source: AGHT+IHSwPBjiXpVxHHb/RHltoFzihlx3bYB6li2RGPRSVFUtryemOLMObXWMwcaOJMjFqmmnJ+EvsyBQ//k1EGDZVc=
X-Received: by 2002:a05:6402:2804:b0:558:8096:5c2f with SMTP id
 h4-20020a056402280400b0055880965c2fmr275145ede.1.1705032424813; Thu, 11 Jan
 2024 20:07:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110155948.90964-1-marpagan@redhat.com>
In-Reply-To: <20240110155948.90964-1-marpagan@redhat.com>
From: David Gow <davidgow@google.com>
Date: Fri, 12 Jan 2024 12:06:52 +0800
Message-ID: <CABVgOSmb0oFK--1oCO3Y_-4tjpkS2FrkekfMcaU1wmdLZnxGUA@mail.gmail.com>
Subject: Re: [PATCH v4] kunit: run test suites only after module
 initialization completes
To: Marco Pagani <marpagan@redhat.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000083468060eb7cc7e"

--000000000000083468060eb7cc7e
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 23:59, Marco Pagani <marpagan@redhat.com> wrote:
>
> Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
> kunit_free_suite_set()") fixed a wild-memory-access bug that could have
> happened during the loading phase of test suites built and executed as
> loadable modules. However, it also introduced a problematic side effect
> that causes test suites modules to crash when they attempt to register
> fake devices.
>
> When a module is loaded, it traverses the MODULE_STATE_UNFORMED and
> MODULE_STATE_COMING states before reaching the normal operating state
> MODULE_STATE_LIVE. Finally, when the module is removed, it moves to
> MODULE_STATE_GOING before being released. However, if the loading
> function load_module() fails between complete_formation() and
> do_init_module(), the module goes directly from MODULE_STATE_COMING to
> MODULE_STATE_GOING without passing through MODULE_STATE_LIVE.
>
> This behavior was causing kunit_module_exit() to be called without
> having first executed kunit_module_init(). Since kunit_module_exit() is
> responsible for freeing the memory allocated by kunit_module_init()
> through kunit_filter_suites(), this behavior was resulting in a
> wild-memory-access bug.
>
> Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
> kunit_free_suite_set()") fixed this issue by running the tests when the
> module is still in MODULE_STATE_COMING. However, modules in that state
> are not fully initialized, lacking sysfs kobjects. Therefore, if a test
> module attempts to register a fake device, it will inevitably crash.
>
> This patch proposes a different approach to fix the original
> wild-memory-access bug while restoring the normal module execution flow
> by making kunit_module_exit() able to detect if kunit_module_init() has
> previously initialized the tests suite set. In this way, test modules
> can once again register fake devices without crashing.
>
> This behavior is achieved by checking whether mod->kunit_suites is a
> virtual or direct mapping address. If it is a virtual address, then
> kunit_module_init() has allocated the suite_set in kunit_filter_suites()
> using kmalloc_array(). On the contrary, if mod->kunit_suites is still
> pointing to the original address that was set when looking up the
> .kunit_test_suites section of the module, then the loading phase has
> failed and there's no memory to be freed.
>
> v4:
> - rebased on 6.8
> - noted that kunit_filter_suites() must return a virtual address
> v3:
> - add a comment to clarify why the start address is checked
> v2:
> - add include <linux/mm.h>
>
> Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
> Reviewed-by: David Gow <davidgow@google.com>
> Tested-by: Rae Moar <rmoar@google.com>
> Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---

Thanks very much.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

--000000000000083468060eb7cc7e
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIKHSHOPGPMzcrQ8D4C36bPgV03FQ/82KkZl2prHRJfreMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDExMjA0MDcwNVowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBVi+Gy
zwYYle2RTW6mEKzh1u2zg6e73y/5Lyop4MYV/ntdvEyhw21cU5B7iF6PYgnbZRgW30h5l/rJkGNF
Y3Nn5d7FBvjbtyI5+3h3Z5rkcXzUQ+mezdXFjrsXzMeb23ZwXaDi/S/mptxXEvMZgWiHbItcElFA
eUXNqxGNPzVaXNtWduJ3R2tSe4VXvz7hKCUMwpnY9BQ+gUdsJuHSOzuYIa0wwdP0K1rteLGJ4gG+
20JTgjHPd+jFy2AepZWT2v6IC4awf5mll+LgcJuSFhdoX4isebjcp9h1ydZ41uMQq7xKSGylJy8q
RVKNj1S9h44vsRLJ3q+bRcJnBfztzKaM
--000000000000083468060eb7cc7e--

