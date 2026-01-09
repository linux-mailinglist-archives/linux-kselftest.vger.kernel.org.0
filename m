Return-Path: <linux-kselftest+bounces-48581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5F1D06CA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 03:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C28C8303EB5A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 02:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83064261B8F;
	Fri,  9 Jan 2026 02:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTE1pDt0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E890259C92
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 02:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924515; cv=none; b=VNniuZMI5p6y6zOQor/Yj2ZUQLFfeBfH9sBBedYcxOOZM5OFPi7UOKhZsWS25NYQcC5mzsY0q1rr75ZgFwqhJeT/bQSC6LoZhonO8huVSGliIUY4iZHjzx0ExHuJ6+VjKwoYu+Uo7qSJSE/H9eVq86EbzF2Pf9Ur9F19plvcFeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924515; c=relaxed/simple;
	bh=xgoVtk4jMSob77ruYZEQ6lJPBHmk6jz9x8HlWBDYD30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLUB0ztTlIUmpZ32K/79ud9Zkq8ReQkubakY30GkhQypqrioDih3CSWqxaejDc0FupSvB557sTJjXzJjH2zfgAdTkveI5zk/FetMAhNKrWuvgQT++SbRgjoj7stVKn+XG/ZaLgt/ckFqteWE9v7TqhsvxfJC0ogEKzPWs8EfGU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTE1pDt0; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6455a60c11fso3186567d50.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 18:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767924511; x=1768529311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHx+c8KcdYuhPzaBZwkqSYHqGog6hASf2z7O5RA56LI=;
        b=LTE1pDt0X0VM0/vO1MCH9cMHyDe0gHJdaXAZxSWChaM0Zuo1oNokcmMEqOUVPgP31s
         d3Z50MnOaNoQEAtGLVkbA/g5yTVCujumy2MgcooWVQ2xIXe9c1v2yv15eLfEU7ewFxrj
         7KFd+6RumvDdH3sscljq2O29M/JXvqTY/5wtkpu/hZUarhxB/CSXa+hDip/bxyMPi3V+
         l9Yy8vAjPtP0VLoUvMWXlOR+iLiDRt2cWT5GaM7cFIIBRFfTiih+IJ8XpJyhPe4eLfdQ
         A0oeWZiXpwrCABLE/ClSpl1TBeoHauHhoUAMvpnNmSOwqLN2M+Eq3lDY1uK8RI3nWLO8
         NgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767924511; x=1768529311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHx+c8KcdYuhPzaBZwkqSYHqGog6hASf2z7O5RA56LI=;
        b=kIwics9jg3pvab2XP6g72x/JzIV5O0sqKd5pPjuBAastNdsABw7+SyBTEZXxe+aaLx
         cyHu37woe9+6mfNHkI2UcLOQ3bX7rmrmO+zvu8IVLH5XuF2OadINAUoyKxVSYeM2XdYv
         KtYPEx0Ch3EceEDIKM4asGZu0gkjcm7IygF6uvruFCdkEdpMCZZ+Dui9b4yKJfFGeGcx
         Z7UXvd+AW+vWQeF/VkLzQF99VV3sDgolAtj/xA1i2Iv8veSbFBjAIGWARFWZ0SpA+epk
         TKTOBD/r4Xp9uyIx2r97SbwJgR6vEP9L+a7k2AVqq36+j89GCbwfei9isabdYy55PY06
         sQDw==
X-Forwarded-Encrypted: i=1; AJvYcCVuhKQbVW/1euxy+g426I4W4lYpFevZHEX6Y+U6mhdzWiB8AyK+j9lK0ZDvpqL2Z+/7pqvq+KR+T9DjpcGuYho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEY66DgRgqYJ/3420hUp7AWsIdLVzjIv1FzxkWgUcSHKnGeKqf
	KVp5v1acl0kBdJPA/heEs6VNCqemYWv4RAk4h0Pstz3aH2p7Jv53dP7OPQZkcOKWu8VVWIcDH1d
	SfNV2ecxiI2jgcEYta5Dt/Q9hYLkvLgo=
X-Gm-Gg: AY/fxX7U8CtkCOnv/GGEgxQS5HeqhIFg/iwHLPputulxK+r/Gjkxg7hAgAOPilKCt6E
	COHLbdzY4XDG21uS0ctxqAteVnk5jPEQrJYlp4JuyNOIcWEJxWRamSgYeWLXTOiTFh/7Soq8r7o
	KPcXgx7HFwMMmHHGkD7sWVtBTP4UtBEpppV8nNM15RVjMDAVQwHifx2+E3R2SJPJRLcZC98xiCQ
	ZGdBLsuzmEHQL+G50pswB1Vu8lwNR3vlQNRJUlnjZAN8rf+INF8YRQV/YAXs3uwoO7Mcb1UBluW
	Oi0P1/M=
X-Google-Smtp-Source: AGHT+IEJQ0fMk367IuiUcJa+C9gVXUq3sIfJ7z62OpfaArexsG4BAb7+MZ+Y1aG40K4QceJTCiYn6MGa8a6noT6QHe8=
X-Received: by 2002:a05:690e:1516:b0:63f:ba88:e8ee with SMTP id
 956f58d0204a3-64716b6fa72mr7912980d50.21.1767924511358; Thu, 08 Jan 2026
 18:08:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108031604.12379-1-sun.jian.kdev@gmail.com> <20260108132851.bb6b7813277a5b40ba3aec8f@linux-foundation.org>
In-Reply-To: <20260108132851.bb6b7813277a5b40ba3aec8f@linux-foundation.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Fri, 9 Jan 2026 10:08:20 +0800
X-Gm-Features: AZwV_QhDj8oetBdJVKSBgN1xg1eqVAcBhY3KQPbVpkF2GBJK3i2pqNm1v6345dk
Message-ID: <CABFUUZGinC04zPEtwq3+maN-iNVNdc1p_BFnTdPNTsLXcQ1hnA@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: fix relative path handling
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> hm, why?  Is that a thing people actually do?
>
> Is anyone going to actually test this feature?

Yes =E2=80=94 invoking selftests directly from the kernel root can easily h=
appen in
practice, for example::

  sudo tools/testing/selftests/mm/run_vmtests.sh

This currently results in false failures because relative paths being resol=
ved
against the caller's cwd instead of the script directory.
>
> Alternatively we could check that we're in the correct directory and
> error out if not.

That would also be reasonable, but I slightly prefer auto-cd because it
avoids an easy invocation pitfall and makes the runner more robust for
wrappers/CI
where the cwd is  not stable. That said, I'm happy to switch to a fail-fast=
 cwd
check if you prefer the behavior.

Regards,
Sun

