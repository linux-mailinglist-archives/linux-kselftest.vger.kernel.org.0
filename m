Return-Path: <linux-kselftest+bounces-2362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519FE81C7C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 11:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D529D1F250ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1B4101DA;
	Fri, 22 Dec 2023 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbd0c7ld"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D619911722
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so10916a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 02:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703239388; x=1703844188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n3keAZOOTFhzbSWQhSNoQK9BCKpSTUYPwjC/ley3qF0=;
        b=mbd0c7ldP68NbJcXgU/JxLcHVb6/arVTx37MMjSAXdf2AWDKNRZHnvnGXRUAlAHo3Z
         khQEbbF/585t3WHwkpk4Us5q1WnoLnwft587xECczlRyFteqiQdVwOnorAnUO6Me/S9f
         VBjtefJHTF2bfrT0C+QP3bRMHPWVJOcJOCOJ1+9suxcdFUtIwLuWXhmcckH0od5ioUvv
         nKcoQzgXKvUwPdEsHzOihCYqfTSAIXV99nEr6c8f3sHLfCFQ52gt5ZnHpxy52WGIVdw6
         L5GCVk/8qJ6DXn7/H6n9Jj6ptkeslZn9FrCCXPtZLjNAJ9Vm9/3NczxMQOsIygp+ixT8
         8MkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703239388; x=1703844188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3keAZOOTFhzbSWQhSNoQK9BCKpSTUYPwjC/ley3qF0=;
        b=SzI/M6Xhccoyf77PP2bEPv32q3amct79GhYlG0Vkm5FE7tBK2wBHSfJqL08OSZ7E1/
         Tzz90O7IqG86/9YakVF4JvMXz/G/IVzB0jwlVGg9f64NcoaZHs5H67wvCneQh7GwZD45
         HoKzHVy0lCbGgvqO1Oln2qga3oaOJHzkGGMFjdOwRKSo4pS5Eemms6gRYn4MLwR0gJZN
         ccnDFMTHOB64+GbbpVRqS0WEJNOsSk32yth12ihQIb5qGHJT16ySOS+Ca/kG9zMtopr1
         Zl+WzTYFZODVWHMEvC/CUXSGsfaBsCNokxVeWOuEE9NtlojlEZDu+kqqnzmqOk2Ptzze
         Go+A==
X-Gm-Message-State: AOJu0YxAZm8/oPBrbWOjk2bibKDfX2yaEIQ/p/2MJs89ZGq+hTv5WGhU
	x2PSI697i/SIiVkZMHDPe+O2i72eJKsJa58DIaWzOmH2Q1BJ
X-Google-Smtp-Source: AGHT+IGpXwHZ79rgomiOU9kgzJNEtB4BcIILO29fCz0wX3JZZkeUvC5iCERyu71xs7aVOJND1y9paf+DjDTttKW3ofg=
X-Received: by 2002:a50:c318:0:b0:551:9870:472 with SMTP id
 a24-20020a50c318000000b0055198700472mr71653edb.1.1703239388048; Fri, 22 Dec
 2023 02:03:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220151952.415232-1-benjamin@sipsolutions.net>
 <fab3c87ea726208cbdec03dfd61230e4c8ceb694.camel@sipsolutions.net>
 <ae651d3d-58f7-40de-a625-4882cf0efc9b@linuxfoundation.org>
 <dbcadbe4430cd314373f15a9f4b814e44662bef6.camel@sipsolutions.net> <a2ef9ea4-00e8-4fa4-bc2e-58fbec306503@linuxfoundation.org>
In-Reply-To: <a2ef9ea4-00e8-4fa4-bc2e-58fbec306503@linuxfoundation.org>
From: David Gow <davidgow@google.com>
Date: Fri, 22 Dec 2023 18:02:56 +0800
Message-ID: <CABVgOSkrhEYXvzjtWfdxmKVGZwGnJTKwbd9+kBSRWxbOfyaRUA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add some more cfg80211 and mac80211 kunit tests
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, benjamin@sipsolutions.net, 
	linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Brendan Higgins <brendanhiggins@google.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b71c82060d165290"

--000000000000b71c82060d165290
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Dec 2023 at 05:47, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 12/21/23 13:40, Johannes Berg wrote:
> > On Thu, 2023-12-21 at 13:06 -0700, Shuah Khan wrote:
> >> On 12/21/23 12:39, Johannes Berg wrote:
> >>>>
> >>>> This patchset adds a couple of helpers for kunit as well as tests for
> >>>> cfg80211 and mac80211 that use them.
> >>>
> >>> I can take this through the wireless tree, but then I'd like to have
> >>> ACKs from kunit folks for the kunit patches:
> >>>
> >>
> >> We have run into conflicts in the past with the kunit tree. I take the
> >> kunit patches through linux-kselftest tree. I do want to make sure there
> >> are no conflicts. I don't mind taking these through my tree.
> >
> > OK, fair enough.
> >
> > If you can still put it into 6.8, then I think you can also take the
> > wireless tests, assuming they pass (I haven't run them in the posted
> > version). I don't think we'll have conflicts there, we don't have much
> > work in wireless that's likely to land for 6.8.
> >
>
> Sounds good.
>
> David, will you be able to look at these patches and let me know if
> I can apply for Linux 6.8-rc1.

The two initial KUnit patches look fine, modulo a couple of minor docs
issues and checkpatch warnings. They apply cleanly, and I doubt
there's much chance of there being a merge conflict for 6.8 -- there
are no other changes to the parameterised test macros, and the skb
stuff is in its own file.

The remaining patches don't apply on top of the kunit branch as-is. I
haven't had a chance to review them properly yet; the initial glance I
had didn't show any serious issues (though I think checkpatch
suggested some things to 'check').

So (once those small issues are finished), I'm okay with the first two
patches going in via either tree. The remaining ones are probably best
done via the wireless tree, as they seem to depend on some existing
patches there, so maybe it makes sense to push everything via
wireless.

Cheers,
-- David

--000000000000b71c82060d165290
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDH
s8y2Q/18eZYlmLH0i5FPdFE3oRpedImezAiWiPO/fjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMjIxMDAzMDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAcMa+SUUkgfHVGn3JRWQZ
A1Wo8xsZJqVy5k8NdUrbHyWIIT2X3QPKykrt03tAuCYdZl3S8iR57jLe88Jh9pE83kSu/YRjnKVa
1r9+eLSKBuYVqAfLLdff9EEbHLkEVuBrE1IplcaKN5djBSUm8g/xNsbj4HKzhaXzc00Vt+c1fM+d
nORKw8u5B1PTnd9ArybXqSGnk2jr3x/y5jrFZCwPaGvi7OWGtJwupr76m1Wzy9zTVpzsCE4asDnf
3mwAmXlfQBmdsH4NEoS5XPXOAUIC7vi+4W2qCx0d7cTXdX4m2cdZkqo7Se4HNdBNX6lo/eYUGIkF
MWfIx3XXLXKvD/q4yQ==
--000000000000b71c82060d165290--

