Return-Path: <linux-kselftest+bounces-9251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4896E8B92A3
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 02:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46981F2251E
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 00:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA7C171A4;
	Thu,  2 May 2024 00:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufponb2k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39C367
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 00:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714608100; cv=none; b=h8W9gECZ49riokdCUPGHmp+A8qAd4XkBPXA9g3XmGPYQbXKOdFDtC4lu7+ohv8Y8/PIpjI03MCvAsAmeLgcmRukp9ZeaVMOSbhA0wAdpn66deAm5MZJSciWIVgpsG3STOp3i9lkf+kTGpQSpfR/gMfklrPmgUlsnWQPi5vJqD/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714608100; c=relaxed/simple;
	bh=OImkNtzkTliLCWyu0oqLx5jkxe19sr55idKGPXXtp38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0e/pHeKn/9KUojE5ArO68LEnuplxJ99jzhRHcF4rvssujzpKJvvO+Pi7r4Ry/W51f0Ig4/o/J+n+tVKa4q0DdxQq3aD1DQP+0bIyI1egRRfA1IKW2ZSfQt5zOJ83/Cbp5Qp/NM4U6bU8jdZqIqOhNSNmLJLb8Yi/KHfju8cz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ufponb2k; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43989e6ca42so91971cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 17:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714608098; x=1715212898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tFovO3b2PWJCYPLxXp3bR7Ko4iw+Qoq9f7cXgqfjVVc=;
        b=ufponb2ko4J4Rp1IJQ57DxdP2TBXqnMxxtpfJHr5w2/L85lfupdQHlO6ZlsqWn9UTG
         G+prMqYDEUnhdr6sqrFhLxkX+A4QYhmOkV2wDMOrfR4NL1J87b0bqqToNoDRD3VqgFxY
         c6Jl0Kck9B8RFpAFIqRZuwfowCOS3xyGyGUN+UsjV5xAmNUUpzgplLO9B6Y7L4PO7Bxv
         83s9p1Tjw3LaBX9iZpyUgUjNPnqVzR5pQjZmaskoCUsv987AoTGtHboOcFd3yiIiP3aQ
         ed3Aq3hLehYWuuIGR3NX9e6yLUu/2VqW7hFOyFrvG+AnTwB0Tthf1nNjKyQhU/nfHTzR
         11PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714608098; x=1715212898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFovO3b2PWJCYPLxXp3bR7Ko4iw+Qoq9f7cXgqfjVVc=;
        b=MktzL43vYL69QfKSSeGQQ9YVdHHjHVZGaynoyaBPXdo0mPv/DyR2036K6qdh3E+OU+
         IZyvRhF8vFkK5RlrfIwH5uNwsRVxw+/zho/m5MvXa1KH9m3EDJQWjuk9REeteGD/OT+p
         PMIa+gbo7sQVH7v5696NYb6MXk4R9JGvgsLvzM94GGGlvfDMjY0Kl9/YUSeABFSCAqKT
         c/SXOA/eWwxQKase5Ar6/2qqynsELy23G3Dd6WdgvYdc57Uda4vv3p/vGCuI/nEsjYq8
         jZVy/ugdiiu40BbDHzSxz7V8xJvMdecYXx7zWGWpIbsz6KU2EgrQzuEvSQaw6KaT3wpE
         lxDg==
X-Forwarded-Encrypted: i=1; AJvYcCX91T3+N/RwH4J9a+cJg1xVMqxcjG5e2PX52GfwTaNrpvr7U4i4Eq3s3s1Pk4kZBfoCg1w0Bmyk87cnwEyS3H2tshHOUp1uc6qPKwbHZk7f
X-Gm-Message-State: AOJu0Yy9O4hnZqzo//E0sYlwj7T/iZzo9tr3gZDNy5uU4fEa0YB1cYta
	cEf+A9mLyITzFllF8gDG7uD4rJKpzu4IxKpnRpp4KoLebJ1kZuXi+xx/s1DO7U9WbZrlPd0/YYV
	gIjY8tGww7Jwid9LljdzaG/qY6burzRS82n9M
X-Google-Smtp-Source: AGHT+IG4EzBmE7wxJ37+pVBQo74UfmhnF7wKlujKVSXs2YGPLkwaeT6oU0n/Q9JsNxZYyRwGKYs+t5HDr2QCOsfsmK8=
X-Received: by 2002:ac8:5a8b:0:b0:43a:b274:340e with SMTP id
 d75a77b69052e-43ca9f4434emr1219511cf.8.1714608097563; Wed, 01 May 2024
 17:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA1CXcBqcyXma1kGwvfAQ5T24dmuH_Or9RPrVqxDoVq=N4Se3w@mail.gmail.com>
 <20240321143200.1854489-1-smayhew@redhat.com> <CABVgOSmDJpU7km5em_WbY1A04f+AF74a8_4GccjrJk1nW+1Fww@mail.gmail.com>
 <ZjD48CpjXPsmjU5c@aion>
In-Reply-To: <ZjD48CpjXPsmjU5c@aion>
From: David Gow <davidgow@google.com>
Date: Thu, 2 May 2024 08:01:25 +0800
Message-ID: <CABVgOSnyGr+j5LmegYRVBDyXeCpGm-UtfTMzihOWto9oYF+-9Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: bail out early in __kunit_test_suites_init() if
 there are no suites to test
To: Scott Mayhew <smayhew@redhat.com>
Cc: brendanhiggins@google.com, rmoar@google.com, npache@redhat.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-nfs@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009d122806176d4e93"

--0000000000009d122806176d4e93
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 21:58, Scott Mayhew <smayhew@redhat.com> wrote:
>
> On Sat, 23 Mar 2024, David Gow wrote:
>
> > On Thu, 21 Mar 2024 at 22:32, Scott Mayhew <smayhew@redhat.com> wrote:
> > >
> > > Commit c72a870926c2 added a mutex to prevent kunit tests from running
> > > concurrently.  Unfortunately that mutex gets locked during module load
> > > regardless of whether the module actually has any kunit tests.  This
> > > causes a problem for kunit tests that might need to load other kernel
> > > modules (e.g. gss_krb5_test loading the camellia module).
> > >
> > > So check to see if there are actually any tests to run before locking
> > > the kunit_run_lock mutex.
> > >
> > > Fixes: c72a870926c2 ("kunit: add ability to run tests after boot using debugfs")
> > > Reported-by: Nico Pache <npache@redhat.com>
> > > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > > ---
> >
> > Thanks, this works well here, and is a good idea anyway.
> >
> > Reviewed-by: David Gow <davidgow@google.com>
> >
>
> Brendan, David,
>
> Is there a reason this patch hasn't been merged?
>
> -Scott
>

Sorry: it totally slipped through the net. Thanks for the reminder,
it's merged now:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=2168e528f8679881df7487309f3444a121b2b544

Cheers,
-- David

--0000000000009d122806176d4e93
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
hvcNAQkEMSIEIAC+5TSB3xvJALNtjeVg81pmlAsPik8lUciEzUEOHvqzMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUwMjAwMDEzOFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAZsrjG
LJwsnbUgJxcdDO2PR002/Efj/vyEj4Pci8odwxW1et+7a+V9J2g6rE9ecimNZt2xf6ZpmfKtAl0H
/rAAlzBf5Qe0ynfQ2NnkKaphkm4sL+LDqEfqJh5LOcJFpoX0jbtwbid60RHWkaIZEud/iP0XPP4E
UwMIpPJAhEdz2VMhadxMbS7qnDN8WYEySqZ/3G5OwnzJhYre1+U0AOlJp76jGpMoEximJgbNW2Yw
xrXDMopl01JXWNZ1KvbDDbnT42rzL/kEm5UAyvLX3Z7p523ITw927oz3chA7RoYQqAQfGXZrqIoL
lzguiGxMrlzaCCEqAUBpqM4++3Qpq1FW
--0000000000009d122806176d4e93--

