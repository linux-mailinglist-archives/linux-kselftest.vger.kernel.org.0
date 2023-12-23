Return-Path: <linux-kselftest+bounces-2413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39BA81D262
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Dec 2023 06:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE9E1F21794
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Dec 2023 05:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A7F469E;
	Sat, 23 Dec 2023 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0VkO9xBW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA403D71
	for <linux-kselftest@vger.kernel.org>; Sat, 23 Dec 2023 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so17115a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 21:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703308154; x=1703912954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kK/xsKUCSECIbI/rzcKb+/n8gMhyjeQcqJZ+9fRnw2c=;
        b=0VkO9xBW8kL3XWvfF9fvrCaqAMEAJIayhlsmm7UL1t0YOEkqoC4f4/e3LUFWt9bi8j
         96qC8F2xrUXfcY6wjcLbPyBIl+NeN3fF0IFfmaIhYO0y685lJT+Jrh8eoQA5KWfMAVJq
         N8zg4rJi5EnbC0lUwPXCBZkqXmzHgP6oxNlNYJoPone5AoIXrTpqt+SrVvhdmRvt+hCf
         KI8JmbLlVta6TcNBwnDbdc9zLtKSiI6shV6EJ9zQX8H6y8ZekfGIn6G/bMKrVuXdrxfu
         /hlZGWjrJf4w0MBEHsOxxSAYpaMTeXeeE9ygv5Q6NHEvzENQsGqSYDFA634r3XH28X2D
         dVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703308154; x=1703912954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kK/xsKUCSECIbI/rzcKb+/n8gMhyjeQcqJZ+9fRnw2c=;
        b=eTpbZbEpusAcmOrATr/Vo68i8VWAg9J8kU/4ysfermsiKfeRem98JGVkm5fmcRyUtU
         opjrUSLZ6scC7SUFUWRhgZrejfBqzQ+8rLTAX6THhtl7BakgLDQVKhjaAHBfQneXTKYU
         vM7B2OdShp7qDi1MFiNRF7T3SY39U/6Kj86n+biSbuft7op5ITbIHCIEckPbZfwE2K7l
         F53I0BmEyEaS6yc6Pn24R8bakhLc5dBXnQtr9yfoibhSBpNriMKWpl9YCNNlOtb2D4VD
         s7xEiCz9CcVtABS8ogMkUAHIjZqfPBrhYvmmKtbMn22WAaw3rOgoNdbSGNptNeQVAFdI
         Q/OQ==
X-Gm-Message-State: AOJu0Yxha0HwEs5t5vQC2XQbO/4TZleJomLyBgrq1UpuDM5Glk5ouStD
	VwPsuojT2KpBoJ0Tb/S0TdFmZwQAxx3SEHDY24B3vSwj7YzF
X-Google-Smtp-Source: AGHT+IGq/GAXjltbSvGZHSSgIw1yIRYyltRj1sMDSFhXmwlI1q3SQ5pOk4hgWQI05jRmRiflPB/FPusm+u8z1lTiMi0=
X-Received: by 2002:a50:cd8a:0:b0:553:ee95:2b4f with SMTP id
 p10-20020a50cd8a000000b00553ee952b4fmr163610edi.3.1703308153966; Fri, 22 Dec
 2023 21:09:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220151952.415232-1-benjamin@sipsolutions.net>
 <20231220151952.415232-2-benjamin@sipsolutions.net> <CABVgOSkTCk4WRstLM+pKQeKRtPYPCOE_LCV9GfoRVdZLfW1Zaw@mail.gmail.com>
 <2412a9caed7161459ad95043cbdd74e092fb27d1.camel@sipsolutions.net>
In-Reply-To: <2412a9caed7161459ad95043cbdd74e092fb27d1.camel@sipsolutions.net>
From: David Gow <davidgow@google.com>
Date: Sat, 23 Dec 2023 13:09:01 +0800
Message-ID: <CABVgOSnopc5GMwjua0UuMG7HdGSy+7eKn9yB8x+1KoYhAROrEA@mail.gmail.com>
Subject: Re: [PATCH 1/6] kunit: add parameter generation macro using
 description from array
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007bce7e060d265547"

--0000000000007bce7e060d265547
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Dec 2023 at 23:09, Benjamin Berg <benjamin@sipsolutions.net> wrote:
>
> On Fri, 2023-12-22 at 18:02 +0800, David Gow wrote:
> > On Wed, 20 Dec 2023 at 23:20, <benjamin@sipsolutions.net> wrote:
> > >
> > > From: Benjamin Berg <benjamin.berg@intel.com>
> > >
> > > The existing KUNIT_ARRAY_PARAM macro requires a separate function
> > > to
> > > get the description. However, in a lot of cases the description can
> > > just be copied directly from the array. Add a second macro that
> > > avoids having to write a static function just for a single strscpy.
> > >
> > > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > > ---
> >
> > I'm generally pretty happy with this, though note the checkpatch
> > warning below.
> >
> > There was some discussion at plumbers about expanding the
> > parameterised test APIs, so we may need to adjust the implementation
> > of this down the line, but I don't think that'll happen for a while,
> > so don't worry.
> >
> > With the warnings fixed, this is:
>
> I think the checkpatch warning is a false positive. It seems to confuse
> the * as a multiplication due to typeof() looking like a function call
> rather than a variable declaration.
>
> Benjamin
>

Ah, yeah: this appears to be due to checkpatch not handling nested ()
within a typeof().

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

--0000000000007bce7e060d265547
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDl
uomiHEQAKE6NqQIJQ8B6XPM/g3BzQQcQ49IxaBhBHDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMjMwNTA5MTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAgCAVKAa/C74cSPqiaTLA
J/TeekxO4Vrqewmy7dfkV+S2EDNFVBnScpf4yCefeOC3vHN5FOa34GFBgYFipzpHPl9byr3ROvmb
klZtSPEEo5t+BVUP52/Q3qZBr4FOetl5r+WfeFCiORzDY9HqoZb5V1m6SZHUwTaKxQy1bKYaG2u+
3vc4wjS3DpSbuo/63ILYkEoLItuGVwhMW/Cu64WxtK2CGbpDXfs384ijKwGMzk/mLQ8kui84U/N3
Y+sW3c0XHfpQId0K2Buv7zsZI8NpoZFAcsanGX/ufGVGJJJeHdmphEDPd9ICZ7cjmDk127XlBRaq
mwOlIfI3DuDOZr4ylA==
--0000000000007bce7e060d265547--

