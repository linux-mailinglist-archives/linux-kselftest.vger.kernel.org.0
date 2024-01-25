Return-Path: <linux-kselftest+bounces-3544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5915383BA55
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 07:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED621C22265
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 06:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE65A10A26;
	Thu, 25 Jan 2024 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQeXNVgf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325A125D7
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165506; cv=none; b=X6v+gnDPEI2LsM1sf4kRAZI7BQO+KLzkzxFWMySWrUVz2nOTjcbybx5YPC0bFHzOPoWaLA+IjT51kahIze99KepOAVjiJdbNWr9QIBLA9yvTOaXA8jaJQZeqtzk+gK6RgZkC2YEoIT9GCPcl9Fg8Zhw1vTPvydzpwD9RcxOCMm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165506; c=relaxed/simple;
	bh=JJeVMlzJ8ardy2AkjaoeSnAtbpHw8LCHtxc3JL8dKyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2tCEPZbvXPC8LavZwtdCLzyvgW/KVpEMf40F4HCfw5QxVq/jqBOeGOrD1OX27wE9aLoui6m0G4zPRYPj3HCsGb+2XISoxnRJ8aFOA7dC3eDK5aUnvfJ3ViJTpLXpj23JRJvB5MRZuVRDmceRWXxZuSrXZxQYJ3XGbaOe8JmwCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQeXNVgf; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55c24a32bf4so8997a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 22:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706165503; x=1706770303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JJeVMlzJ8ardy2AkjaoeSnAtbpHw8LCHtxc3JL8dKyg=;
        b=aQeXNVgfpKU2jSOv2Tw7SsBOfOgbi75jZTdlYBWOEkpzJUwRxSmwlBalwUNv9bouNK
         AbBwvnJ2Ksn/OgjwUAj6UUwHsUxN5YvEKgk/d9JsiiIQJ+bEG1wjWm4QlTegjPhJE9Cd
         LrWv3B5qFxaef1iCxceHQk0qxfH4gpKbxX4jQR8pKPlOxuQ8fpUNKi+iZ+e4qkv/EIt2
         K9bA7gxeXq4PL7cibhav2rrPZHnm9ctWaOtdujdHSXf7YgdxxG0/qw1fO7cos/9DPWng
         WFyIw9DAf3tjcL2UfXLR/vnygvT7bvxw3AG22/XF98KiY0PgpKA+AxdLqUwFdoSMysRG
         Y1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706165503; x=1706770303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJeVMlzJ8ardy2AkjaoeSnAtbpHw8LCHtxc3JL8dKyg=;
        b=uDczgqEWBgliCB9Xx7LAUyyLN8pN/DoQTLEGym9roGckXsmTag6uXjPNsZsSIkQmoN
         F3LzL+9Lcixf/hmgRChDL37LJ+Opg4ulGQ4BQahwq92JYaPDx5oNFBN+NnjNJrJVOajo
         Wp7F9V/vCdW7DGy3rip/Lo7VPkO1vkNDXzSO6LKAJmyucwAf9E2WsZpU3mb8W5tUvHWd
         GPid3/fHOztK004AufXzfzc5U9y+BoWF0VnGimHdO0tJgXLsV/1oTA9z/fiLeatv8AH8
         e0XyJyqE+63/70tp7K5f7jAUuWfC5PaWIMBgZrX6P1OwuvzHVpBfyZlxXxiTyjU88xjg
         SJNQ==
X-Gm-Message-State: AOJu0Yz34BaeplpGFlIT9S+AFvTW+5bJ9Mi+TOYbn8CczafzyMASmBb0
	e2wDrNqRTXGqii6USn6zEKZjRi29N2xwM78Hx2z2O368g+N9Jwo1EjGV3IEaPIltjBIHSjSHNeN
	el/zNS11vAFQQFw2MRq/lNSSHD5kf15Shv8x+
X-Google-Smtp-Source: AGHT+IHRcgggjA4ZiOIk9+RJTltfsj+o92OBZllz4rYYaginl1aDz/oUGE6WlgiEya80dNo2ZV6KKUv0NPA0xTMRrPo=
X-Received: by 2002:aa7:df19:0:b0:55c:f684:424c with SMTP id
 c25-20020aa7df19000000b0055cf684424cmr80424edy.4.1706165501511; Wed, 24 Jan
 2024 22:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122153434.E0254C433C7@smtp.kernel.org> <20240123084504.1de9b8ac@kernel.org>
 <d4c1a7c715a1f47dc45c5d033822d8f47e304bd4.camel@sipsolutions.net> <9390c3aeb374e44810e0e93dd48561c1ef1a39d5.camel@sipsolutions.net>
In-Reply-To: <9390c3aeb374e44810e0e93dd48561c1ef1a39d5.camel@sipsolutions.net>
From: David Gow <davidgow@google.com>
Date: Thu, 25 Jan 2024 14:51:28 +0800
Message-ID: <CABVgOSmg5wrv-FyeLZzBRrzARBCuE7uaKakEHv4BikxMUNUACA@mail.gmail.com>
Subject: Re: pull-request: wireless-2024-01-22
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c14df2060fbf9cbc"

--000000000000c14df2060fbf9cbc
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 02:22, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2024-01-23 at 19:19 +0100, Johannes Berg wrote:
> >
> > We're also adding unit tests to iwlwifi (slowly), any idea if we should
> > enable that here also? It _is_ now possible to build PCI stuff on kunit,
> > but it requires some additional config options (virt-pci etc.), not sure
> > that's desirable here? It doesn't need it at runtime for the tests, of
> > course.
> >
>
> Heh, in fact Miri just posted the first bits:
>
> https://lore.kernel.org/r/20240123200528.a4a8af7c091f.I0fb09083317b331168b99b8db39656a126a5cc4d@changeid
>
>
> Also, should enabling that in
> tools/testing/kunit/configs/all_tests.config go through our tree, or
> better through the kselftest tree?
>

I'd definitely like the iwlwifi tests to be enabled in all_tests.config.

The virt-pci options _should_ already be enabled for the UML configs
under kunit.py by default now (they're in
.../configs/arch_uml.config).

I don't mind which tree the changes to all_tests.config go through --
I suspect it's probably better for them to go in via your tree,
particularly if they end up depending on any new config options.

-- David

--000000000000c14df2060fbf9cbc
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
hvcNAQkEMSIEIP/8jJDtUIeYWYLmJTRHVOrqpUHM63BGYIlM0oCh6twXMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEyNTA2NTE0M1owaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB00ug1
USwjhvG+ke6vdDAP8TZqSFz6+5hEo9odMLOLW4xfypqMkK+kjTXTGZXcWtZqieB0pq+Pau7ErkOI
AQjA0Q7tS525nOw1FaE6w7mY3uRdeHQM4Y7yWDkgwrUIhT2dw3R0Jh+B0QhrulJe4TWMTnuivMsh
jiwA7a0JmTIkG8FoPHuBZ+IGyFwiGeh9PvVKJ4Px+4w8fWAwvlgo1EiFPYW9XXnUdHpvLxjteV29
zJ5CXBRJXyq9eP8giy6bT3FWx9nai31YDJukZ0+6CZ8453doNEOiVc30zKN+XC4q72g2rrg71oKr
FHWpWShWHj0udreqI4PNnU6mpvjboaBK
--000000000000c14df2060fbf9cbc--

