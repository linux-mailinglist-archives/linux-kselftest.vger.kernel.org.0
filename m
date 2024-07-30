Return-Path: <linux-kselftest+bounces-14462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA09940EAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 12:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD061C22792
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 10:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9609195FE5;
	Tue, 30 Jul 2024 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqpJQoZE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2527418A92A
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334272; cv=none; b=CsFmAsxrYkQhJNrRFYWW7iu0EgcgO1AnJFyCLNZhl7zOye6EUVNaUNEK2kn1tQGFlcBdkJBscZOV/3vePeiP+0s+4WiPXpNOJqKMKqadkOM461x3iaEhv8JBjOfDO5ZbW1oya+GlD5FRU4hyy0feNPmDlSOtX+L0DgihRkDHKYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334272; c=relaxed/simple;
	bh=Mq9mXjuI7HFCmNw+0EhR1F5o66LPoTyfyCUa4P7B2J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qluU0C8Y2qyf5OcQ6H5LY9grkg7mZKYRwLFzNeVAHrutdX8GV2bykygMcSv0FKfFUocim0nP1aq8/vbJ7Yt9IVo1U7zsItQcYSddRHbfftOWyQP5NQOWemY+0Ghf3uBJ1orHQVVJD88hAP8R2PfOmZv7jiCIs23cNzGsA1Qr1jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oqpJQoZE; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fe76fa0b8so256821cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 03:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722334270; x=1722939070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mq9mXjuI7HFCmNw+0EhR1F5o66LPoTyfyCUa4P7B2J8=;
        b=oqpJQoZELmMMujyRQOa/1p9OLVlZboDFwJtqhq3UvLqcZLdah4TUq24RhFaIuIBPaf
         Gf/PEyLPbawEOsoKvRh7NrrdPFjjs8Ni8KSRd8yKTkjXRvaxbbygOk/Oq94YvIglc1pD
         85Lj+I+QaLF+3SbELbYwbpSXPoLIhdi177Z9K8b6d6SFFsu+T3R4eXPhL2u9KF2ZGELX
         BOhvKg6rS8BWfdyr2pa1R9y9AGVpBbCQgQdxVnenPFXPgP42p3/XV4nziWOXHZo9eiio
         azwVs5F9EY6gYt50zxcz0CuFdIR/aB+SWBsgkkmTUc3rN+wpUDT2P6G98q/BGmprYm0H
         t6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722334270; x=1722939070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mq9mXjuI7HFCmNw+0EhR1F5o66LPoTyfyCUa4P7B2J8=;
        b=vSPdFjuFwKFFXjKIvRX5CJcmZQNKlXhimp0MQOoNENrtA1g+5mQ+k9NI0oMMRJQTt+
         N7ReeElImtZmZ4/TUNxlpz+IkDSrMVkhkw0Ft18VbSf3LS8v1YL/8DmKj4BEKXPjuJP/
         vtQVQQyKebon+MNJnnQBu5RwssokHbiu8OUJKz6b0uZtkHiY9KXci3FuyGc0F0G4cKxj
         5yYukv/a3mcLHLr1ABs5SVH83WAczk20ckOajCF4PdaKfw1aJPugLuR9ceRFb4uTfTjv
         giNoggYjXB0XCX5Mk7rhCMSu8zqEEsJif/KX6AJrPuGXzb+BcbbXjgOfIVBStxD4fzMe
         tHcg==
X-Forwarded-Encrypted: i=1; AJvYcCVYYFjYa8Ogd5pJ+sdYEsopGskmJejufW1nLix9rcjHo+En8FuUfFZwworadAG0H1rNP9g6s7hUqynu60AuNIgePxbgfF00fCI5RjtsK+QF
X-Gm-Message-State: AOJu0YzC8cU/WsK9Cn3ib92QLo4Ew7vBL6jdx9KYm25nn2caH6SQnGNi
	FpF7hEjcrTH2lJnTTwcB2W9dQlo087/5JUZPfIVyb66msiRq7K00nOCCwbt1pWnsoUGHhTBHCoI
	T6RcKozphrvX2TXxpQsOQ4rFWqJ+sCz4dpQxC
X-Google-Smtp-Source: AGHT+IG0SePltyDmY8OHcoPfYlHDt1L0FzTgPwzX3/Hr1MbyxMIBx2C5JKdN4SwUhPKusMcehLkYy7Vmw+OWkC61Puo=
X-Received: by 2002:a05:622a:3ce:b0:447:e0e1:2a7b with SMTP id
 d75a77b69052e-4503889a224mr1429551cf.23.1722334269817; Tue, 30 Jul 2024
 03:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <20240726110658.2281070-3-usama.anjum@collabora.com> <ZqUvy_h4YblYkIXU@yury-ThinkPad>
 <85f575b4-4842-4189-9bba-9ee1085a5e80@collabora.com> <c0e5978b-7c11-4657-bd07-9962cd04bf9a@infradead.org>
In-Reply-To: <c0e5978b-7c11-4657-bd07-9962cd04bf9a@infradead.org>
From: David Gow <davidgow@google.com>
Date: Tue, 30 Jul 2024 18:10:55 +0800
Message-ID: <CABVgOSnkxgeXXXm9xp5_PvBxtMGbyFN-Jmd6YJ1u6g81MF_fyw@mail.gmail.com>
Subject: Re: [PATCH 2/3] bitmap: Rename module
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, Yury Norov <yury.norov@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kees@kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, kernel@collabora.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005f2b9a061e743235"

--0000000000005f2b9a061e743235
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 22:09, Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 7/29/24 1:07 AM, Muhammad Usama Anjum wrote:
> > On 7/27/24 10:35 PM, Yury Norov wrote:
> >> On Fri, Jul 26, 2024 at 04:06:57PM +0500, Muhammad Usama Anjum wrote:
> >>> Rename module to bitmap_kunit and rename the configuration option
> >>> compliant with kunit framework.
> >>
> >> ... , so those enabling bitmaps testing in their configs by setting
> >> "CONFIG_TEST_BITMAP=y" will suddenly get it broken, and will likely
> >> not realize it until something nasty will happen.
> > CONFIG_TEST_BITMAP was being enabled by the kselftest suite lib. The bitmap
> > test and its config option would disappear. The same test can be run by
> > just enabling KUNIT default config option:
> >
> > KUNIT_ALL_TESTS=y enables this bitmap config by default.
> >
> >>
> >> Sorry, NAK for config rename.
> >>
>
> I agree with Yury. Using KUNIT takes away test coverage for people who
> are willing to run selftests but not use KUNIT.

I can see the point that renaming the config option is just churn, but
is there a reason people would run the bitmap selftest but be unable
or unwilling to use KUnit?

Beyond a brief period of adjustment (which could probably be made
quite minimal with a wrapper script or something), there shouldn't
really be any fundamental difference: KUnit tests can already run at
boot, be configured with a config option, and write output to the
kernel log. There's nothing really being taken away here, and the
bonus of having easier access to run the tests with KUnit's tooling
(or have them automatically run by systems which run KUnit tests)
would seem worthwhile to me, especially since it's optional. And
CONFIG_KUNIT shouldn't be heavy enough to cause problems.

Obviously I can't force people to use KUnit, but this is exactly the
sort of test which would fit KUnit well, and -- forgive me if I'm
missing something -- the only real argument against it I'm hearing is
"it's different". And while that's valid (as I said, churn for churn's
sake isn't great), none of the "people who are willing to run
selftests but not use KUnit" have given reasons why. Especially since
this is the sort of test (testing in-kernel functions) we're
encouraging people to write with KUnit in
Documentation/dev-tools/testing-overview.rst -- if there are good
reasons people are refusing to run these, maybe we need to fix those
or change the recommendation.

-- David

--0000000000005f2b9a061e743235
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
hvcNAQkEMSIEIEnMYbD5KTwLAojtuihp4s6ULEOglrKuBBMq3SN5LUSJMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDczMDEwMTExMFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBaBTVT
gb4vYyZ3+Mr7wXySD0NtjPR+jNbpxgUrE05JocR2f9kDthINbpHnje1QbjTRZmbP3lV5MCXalVDE
yB7/yjOCfc7XNNlo2ydX0ZuonwK35YXIk/2drDkAY1BW7GG6oRRqv5IpI0zUFH4iiAnaGGCUfKyq
kSs2Rm3jMrkUrCGnzh3OLROyASoIDB6A/R0+Letvgxwx9JmKS/lONIJALOZeKtc1auoHgD1k1Bu2
CKc8gIhWTgWSLfDeuV82H3LhG7iCz7e6yogoZVV2G3LNHbhKTPlJS7DGA+D0+S5orillZpbbUJm0
+H8COex8sNBdTBytsoSOd8w7SI60Rons
--0000000000005f2b9a061e743235--

