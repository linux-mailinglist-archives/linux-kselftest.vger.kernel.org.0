Return-Path: <linux-kselftest+bounces-7904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 820D58A3A40
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 03:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DAF9283C31
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2CDD272;
	Sat, 13 Apr 2024 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk9/sFzc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EBE8C1A;
	Sat, 13 Apr 2024 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712973059; cv=none; b=O2J1eMl+KPt9TvScmEfH27FO7k9uD1IkQpN+Cfj7uCs5UOwgkViLJDDbzxrYDoy7dknHChwelBFg/G1+bc1XuZQuJEyNEI6wqeJmBQQ+Kv7lz+xLTgkLBgnSvZGmXw5nrdvf+OgWmb+kGBgjzIjiF+I1va4Rsl0OFapwi0e3k2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712973059; c=relaxed/simple;
	bh=wA/RPdttBexHgU+bBZVYr/ZfCaV8CxDw9/T2dT+Y+HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MA7ys4TnlRlAXfUei7MKED/8K9VtbWGMh5lSr2Gb5q9N5omIsTYRuFgaYxjEXL+QUssWHMw0T3q2jyvqQ+vcHVR+9qxr/D9lPtdzVCmGjzyYH4TChL5h4h0XfpU59oJna+OWjt1CS60OwEWBdq9M0GQHJlwuJP7F+yxtjH5xujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jk9/sFzc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a4df5d83c7so917358a91.0;
        Fri, 12 Apr 2024 18:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712973057; x=1713577857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/jYHLvRaUJ+lBVWUfhvMvFS8ppGNLYChc1nBTlFCR4=;
        b=jk9/sFzcUoDfOMKrRupnYhasbcJ1hb4YVuksONO530sOB9AToOVWnmPSi55VuhxY6o
         ykFKc1XShOynkXFCH7LTOMaZmByIaZCr6TLISY8qx48Eyn3gcrU+plJIuHJrz0X8NkBB
         SFyFALyjHHIDZgPzwhAQjDWzLiAQrMTLRdMuUozo36h+Jy00/As+LPk3RlZBUGHsm5fV
         IefbuGBLuO+GjFKYSoequn56WdjOEArMpab4w9G/WWdsBrGPDvlmmzXUURQyVLqjwpOa
         JnxVpwtDztCg0b3EKdi2WycUGKNq4MP/ZGUq9e0zHSCcB0HcvL/nEPDDWCjyWHMTdC51
         r9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712973057; x=1713577857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/jYHLvRaUJ+lBVWUfhvMvFS8ppGNLYChc1nBTlFCR4=;
        b=hdf+snM2p6GVscayJKrxrl8Gm/uuge2kZkjebNVHbBgoUVyrsSVAuNBqQMVHV2k6oF
         q9K/HsAXnq8mOlVFYBgq7FyoGaHxA2yZ4xCXc4WjTufEHggcS84G76sHmunjaCyF/BMm
         /xi0HVudM84ILFNFQ35FwcEuLDihqokOfG7zH0OqXrM0oWrUEC0yyxyiy95Xg/lz2xUq
         tka8/eBWVd1Prlqj9NGwxVSKV/cygMhSxNz0MTufkXfBf7Xew2mb/WH12H7c1NNUYyVz
         tWDNnCxQism5Z1JUfa6LAj3PfwRQ0CFRD33vyRa5CPytLrbaAyMTOFGAFZk0casBsEAu
         Z51Q==
X-Forwarded-Encrypted: i=1; AJvYcCUa5ofFvFEguW3SlFglYGsYlSQL6Oq10tLfdIsSM9Bg6he26T7UpyNEhSMd4nrXVeOsbbBLbCRUVYXR198WPSJdoVwB+AxLLPqjyLom8M/Humz36LKN05QcP48IdJnusvJ2n2tzLTvrxu5jn7ckOmbD4imgRxU6q3dQF7SeUioWof4sVQ+e
X-Gm-Message-State: AOJu0YzZpdvzb2vMOtyYNJWoMFSsqXaRW9dZqPa1XYhW7iH+jGLuXRfx
	1pwOh/Ev/C6o+VQdb8skY+WQ8pVhh7pgSVvNMCtT8mY6ikjoDK7zxulhNTkBhyXwIbVDAybcMXN
	7kvtfOv7FRr0zdFweKNDnzW6xgMo=
X-Google-Smtp-Source: AGHT+IEnA2gF8Fop3YlgII3fFzng5P/PNmy1T4aHT3kJcllvkCoJFI+g7ex3/xElJrGaG4o+QWSsiVsCLRo41rcNmMI=
X-Received: by 2002:a17:90a:e015:b0:2a2:f35f:f13c with SMTP id
 u21-20020a17090ae01500b002a2f35ff13cmr4040677pjy.46.1712973057271; Fri, 12
 Apr 2024 18:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com> <20240413-tcp-ao-selftests-fixes-v1-4-f9c41c96949d@gmail.com>
In-Reply-To: <20240413-tcp-ao-selftests-fixes-v1-4-f9c41c96949d@gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Sat, 13 Apr 2024 02:50:46 +0100
Message-ID: <CAJwJo6bjzgL7Y_EPOL1rYqSz5MNO60iKtCFF-_guq48FwxwKKg@mail.gmail.com>
Subject: Re: [PATCH net 4/4] selftests/tcp_ao: Printing fixes to confirm with format-security
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Apr 2024 at 02:43, Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> On my new laptop with packages from nixos-unstable, gcc 12.3.0 produces
> > lib/setup.c: In function =E2=80=98__test_msg=E2=80=99:
> > lib/setup.c:20:9: error: format not a string literal and no format argu=
ments [-Werror=3Dformat-security]
> >    20 |         ksft_print_msg(buf);
> >       |         ^~~~~~~~~~~~~~
> > lib/setup.c: In function =E2=80=98__test_ok=E2=80=99:
> > lib/setup.c:26:9: error: format not a string literal and no format argu=
ments [-Werror=3Dformat-security]
> >    26 |         ksft_test_result_pass(buf);
> >       |         ^~~~~~~~~~~~~~~~~~~~~
> > lib/setup.c: In function =E2=80=98__test_fail=E2=80=99:
> > lib/setup.c:32:9: error: format not a string literal and no format argu=
ments [-Werror=3Dformat-security]
> >    32 |         ksft_test_result_fail(buf);
> >       |         ^~~~~~~~~~~~~~~~~~~~~
> > lib/setup.c: In function =E2=80=98__test_xfail=E2=80=99:
> > lib/setup.c:38:9: error: format not a string literal and no format argu=
ments [-Werror=3Dformat-security]
> >    38 |         ksft_test_result_xfail(buf);
> >       |         ^~~~~~~~~~~~~~~~~~~~~~
> > lib/setup.c: In function =E2=80=98__test_error=E2=80=99:
> > lib/setup.c:44:9: error: format not a string literal and no format argu=
ments [-Werror=3Dformat-security]
> >    44 |         ksft_test_result_error(buf);
> >       |         ^~~~~~~~~~~~~~~~~~~~~~
> > lib/setup.c: In function =E2=80=98__test_skip=E2=80=99:
> > lib/setup.c:50:9: error: format not a string literal and no format argu=
ments [-Werror=3Dformat-security]
> >    50 |         ksft_test_result_skip(buf);
> >       |         ^~~~~~~~~~~~~~~~~~~~~
> > cc1: some warnings being treated as errors
>
> As the buffer was already pre-printed into, print it as a string
> rather than a format-string.
>
> Fixes: cfbab37b3da0 ("selftests/net: Add TCP-AO library")
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

And this one as well,

Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/all/0c6d4f0d-2064-4444-986b-1d1ed782135f@coll=
abora.com/

--=20
             Dmitry

