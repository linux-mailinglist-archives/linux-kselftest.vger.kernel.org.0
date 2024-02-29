Return-Path: <linux-kselftest+bounces-5604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F64186C313
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B716B20BA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 08:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4467847F42;
	Thu, 29 Feb 2024 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLzRDgzh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E4A47F6F
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194040; cv=none; b=oUz5Y4RGMSCWwRix7aNIDUqegvdzpG+r1Ty7FGEaAhqsoDuCvhDzwTPoDqEyf+aby1jWT3JV5wQqTJO3VsVfxFZ8FLBBjoifN59AWjmFAn6QuWAzwJ7g5qrcj6etEJ5fmxC7Hc8oeailQYp9HJfmuIYo4Q6p1m/EkIYgoMZ8uAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194040; c=relaxed/simple;
	bh=Tcrj5PaTBlSfeqJdxpgBCa29aLn3bhGSkWgig3s0wIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E530V26mPhwiuSFewiaeBVx+43O5pFm4sUOsNHLL9CF+faJCcQdDGJA1GrKVc5W33PMUVn1gmj8Ju9BMrYHVzWrPK1fERWx23XsdL8iEJH15noU029KRgIrUuxfL1sZsuFCU48/PoM3UH6plQGA4Fxa9JzG2Ve2QvQAS74pO9C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KLzRDgzh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4129a5f7b54so34805e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 00:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709194037; x=1709798837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J1GKzv9fxvAgcgPRJPTNzNq3ux5zopHWERycMDmh7sk=;
        b=KLzRDgzhCQWGKHUjcQ6v+DKDQkMQyTNf8fb6A/h+jzYwZ1jnGRcW0lVEPMiafWazuu
         9FKtR/nDeg8nfE7TGjzSRHbK8uXJjpuWqErBxbOzZzKTO5obayE6Ldy5qUn7JpOXs2Zq
         7kBpvK9+jpDua7ItAZ2rpvBCWLItl5qpHk5pHoWA8nl5CUnGSz7jFwx7Amvofb+3IK3W
         gOP4BnLlpmPH/gTPBv4J9bKqdC1fxapCkiYesJjNYIODHBSCdfvM3aHEMCfTlLQvK+fc
         bOcnp6sG3p+bKbIUATzR3qPcC/wzU0tGkEMdo9wxuNp2ZK76XSrdHp3xEP90xisIu4lY
         GNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709194037; x=1709798837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1GKzv9fxvAgcgPRJPTNzNq3ux5zopHWERycMDmh7sk=;
        b=AHasjiYSEdPb/gMxxnS07SxQ1AbcCeu2nAEC2G95JkT5S9CpltMjDW4u6gAUoMlF40
         5qgRDh4brzYI5dt4W8hbgT4gwcSQJDLEN3xMUBT31S7tLgyX+tGxeyta0DDvO3ojazU9
         h1kdfOs8ttD7DQzEJTarl6+aR6br08pPhJxNg3hNYnzpjzDj/Aut1HpvT5GuUVW4UJLO
         gEpRTADnzrP0yyY6bwtWK7fREBgHV3kWfKBqrGbFpRWjJ7xy5ima+qpMdksh8Br7Aam2
         03e0x8Q3yLcDIGQuxjxThkSdB+0hJ7Qd6SAPEuGFzshWRnt7MtHYvJkAVHqzqdwA8Weo
         w5EA==
X-Forwarded-Encrypted: i=1; AJvYcCXwQWQSyconFyl7ZS1C2SgewRavLXHqZbHMTMvooFzdoRWfwla7GDJEkY0Ex3HR0M0synQNyKVASATG9/s1FS34ZpIfYmmNexmuPOGawo+P
X-Gm-Message-State: AOJu0Yw3OBrhscvSnffYIG1AjZXLa0xq9Vk/RpIvU6dpiC3buDPaSkNQ
	hqEQVMWDpxvknnzUwovN7sBQw8ERgi1H/VHRjdRw7jLIJCwNm0cMAl8kkPmKyi03xa5746V7L36
	h1AYnjGEEiWPAY6DM3Eah7ZhltmQ24i2OzSW3
X-Google-Smtp-Source: AGHT+IEWUXRyvDJzguGJRJo9u6ikk3lpMufTn7b98D3Fo26NgVA3wj/ZyQyWVNHb90PS/WA4SgMHs7gH1Un5tLZFcfg=
X-Received: by 2002:a05:600c:a386:b0:412:aa80:bdd9 with SMTP id
 hn6-20020a05600ca38600b00412aa80bdd9mr86479wmb.2.1709194036479; Thu, 29 Feb
 2024 00:07:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net> <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk>
 <ZdzZ5tk459bgUrgz@ghost> <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com> <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net> <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk> <Zd58jvN3PjQSe+yt@ghost>
 <c0449c0a-33bc-49c4-97e3-56a79a6ce93e@csgroup.eu> <02bb92c3-a14c-4a77-a3b0-a7c857d1d60d@roeck-us.net>
 <CAMuHMdW-sUYr8_y6av9Dbtz6JJAxBUsiTGZcK2QYEHo0x1z44w@mail.gmail.com> <e9112858-76b8-4b91-88b1-b5694cda3350@roeck-us.net>
In-Reply-To: <e9112858-76b8-4b91-88b1-b5694cda3350@roeck-us.net>
From: David Gow <davidgow@google.com>
Date: Thu, 29 Feb 2024 16:07:03 +0800
Message-ID: <CABVgOSn0uD+595fLvC0FWUoznCQTv0NeMAykyiOaS956eXQvGQ@mail.gmail.com>
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
To: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Charlie Jenkins <charlie@rivosinc.com>, "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Parisc List <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	KUnit Development <kunit-dev@googlegroups.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006d76ad061280bf8b"

--0000000000006d76ad061280bf8b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Feb 2024 at 23:40, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 2/28/24 02:15, Geert Uytterhoeven wrote:
> > CC testing
> >
> > On Wed, Feb 28, 2024 at 8:59=E2=80=AFAM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> >> On 2/27/24 23:25, Christophe Leroy wrote:
> >> [ ... ]
> >>>>
> >>>> This test case is supposed to be as true to the "general case" as
> >>>> possible, so I have aligned the data along 14 + NET_IP_ALIGN. On ARM
> >>>> this will be a 16-byte boundary since NET_IP_ALIGN is 2. A driver th=
at
> >>>> does not follow this may not be appropriately tested by this test ca=
se,
> >>>> but anyone is welcome to submit additional test cases that address t=
his
> >>>> additional alignment concern.
> >>>
> >>> But then this test case is becoming less and less true to the "genera=
l
> >>> case" with this patch, whereas your initial implementation was almost
> >>> perfect as it was covering most cases, a lot more than what we get wi=
th
> >>> that patch applied.
> >>>
> >> NP with me if that is where people want to go. I'll simply disable che=
cksum
> >> tests on all architectures which don't support unaligned accesses (so =
far
> >> it looks like that is only arm with thumb instructions, and possibly n=
ios2).
> >> I personally find that less desirable and would have preferred a secon=
d
> >> configurable set of tests for unaligned accesses, but I have no proble=
m
> >> with it.
> >
> > IMHO the tests should validate the expected functionality.  If a test
> > fails, either functionality is missing or behaves wrong, or the test
> > is wrong.
> >
> > What is the point of writing tests for a core functionality like networ=
k
> > checksumming that do not match the expected functionality?
> >
>
> Tough one. I can't enable CONFIG_NET_TEST on nios2, parisc, and arm with =
THUMB
> enabled due to crashes or hangs in gso tests. I accept that. Downside is =
that I
> have to disable CONFIG_NET_TEST on those architectures/platforms entirely=
,
> meaning a whole class of tests are missing for those architectures. I wou=
ld
> prefer to have a configuration option such as CONFIG_NET_GSO_TEST to let =
me
> disable the problematic tests for the affected platforms so I can run all
> the other network unit tests. Yes, obviously something is wrong either wi=
th
> the affected tests or with the implementation of the tested functionality
> on the affected systems, but that could be handled separately if a separa=
te
> configuration option existed, and new regressions in other tests on the a=
ffected
> architectures could be identified as they happen.
>
> This case is similar. I'd prefer to have a separate configuration option,
> say, CONFIG_CHECKSUM_MISALIGNED_KUNIT, which I can disable to be able to
> run the common checksum tests on platforms / architectures which don't
> support unaligned accesses.
>
> However, as I said, if the community wants to take a harsh stance, I have=
 no
> problem with just disabling groups of tests entirely on platforms which h=
ave
> a problem with part of it.
>
> Guenter
>

I think the ideal solution is for there to be some official stance on
the required alignment, for every architecture to support that, and
for the tests to exercise it. Now, judging from the sheer number of
replies in this thread, it seems like there isn't any real agreement
on that. (From my quick reading of some of the checksum code, my
assumption was that this was either 1- or 2- byte alignment required,
with 4-byte alignment being ideal for performance reasons in most
setups).

If different architectures have different alignment requirements
(ouch!), my feeling is that the test suite should be written to the
maximum such alignment (as any non-architecture-specific code will
need to align things anyway), and architectures/drivers with
non-aligned buffers can have their own tests. If it turns out there
are a lot of such drivers/architectures, then we can add the extra
config option.

I'd rather, if there is a config option to disable these tests, it be
of the form ARCH_HAS_UNALIGNED_CHECKSUM to enable it, or similar.
There's also the option of having the test 'skip' itself on a
configuration which doesn't support it. That way it'll still show up
in the list of tests, but with a description, like "Disabled due to
checksum alignment requirements" or something, which may be more
obvious to people debugging it later.

For the gso test hangs, I think it's probably quite sensible to have a
config option for the GSO tests generally. I'd be more hesitant to
have a separate CONFIG_NET_GSO_FREQUENTLY_BROKEN_TESTS, which is
selected automatically by a bunch of architectures. At that point, I
think we need to either just fix the bugs, or start thinking about a
better solution for these tests / architectures.

One of the things I'm hoping to work on this year is some improvements
to KUnit tooling to automatically run tests across a wider set of
architectures and configs, so test authors can catch this sort of
thing before even sending patches out. We can do a bit of this with
the manual --arch <arch> option to kunit.py, but very few people will
test things across more than a couple of architectures, and rarely
will we get good testing on the less common architectures, like 32-bit
ones, big endian ones, or ones with stricter alignment requirements.
So we can do better there.

tl;dr: I think it's a good idea for tests to sit behind config
options. Obviously they shouldn't be either too broad, or too
granular, but common sense usually prevails here. I'd rather not have
config options explicitly for "broken" tests, though: if you have to,
try to make the config option for the missing/broken feature (HAS_xxx)
rather than the test if possible. Otherwise, 'skip' the test, with a
suitable reason string if you can.

-- David

--0000000000006d76ad061280bf8b
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
hvcNAQkEMSIEIIVyzxSwGRZg5JxRkLSUHB9wqFyP3fi9S3bEMxHOaqQZMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIyOTA4MDcxN1owaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC/+wsd
GwQPh9tdZKUFSs0RwYglR1KgW3SsibVE7u3r6zvVZwq8UjYDYIGN9HaVdi4i5hYcL3rHh/VUycV5
tDrWfKZmupf8p4rLtVxWsLXGx/dr+6vvHb6Eo8S6Vk5nMnBJGAFmLn9BdJFaVSoD5H5cyP+xMdUK
Os4CypoXefMsjpyRBrmWfesGkVrqoGQ4EH1nRqoNymu2VDhzQWp/eXsyw4H2QgUZG6uLI10lXOz7
aO8Ytlo76fz2/aZ6mOKg/TlIV4JLXBHovrjvPm7DzotcEdu68Kj4cOWsVKqdKYXaAQ3Ld55iP+nI
4oKw9aP3nkWQP/YHvwPsojJzathx3wa3
--0000000000006d76ad061280bf8b--

