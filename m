Return-Path: <linux-kselftest+bounces-43177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04477BDE55E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 13:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBBFA4F2DFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84713323405;
	Wed, 15 Oct 2025 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jK3Er7r9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EED201017
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529101; cv=none; b=jvYuEAM2YcP4uNQRoa/wQPDxjgHK9Qu2XwiRONzYqOcpXONhjvxfuXlvSYHbec7e2fA0WrEKkhuMYXrVmNbcevpJEY97RWNZioX+ngHSvCq8IGwPw5uruQ6BfVqQlC63gOWZqxLsivEHfFl3EG38XzOD3fiUv9tURcO3WM4yRM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529101; c=relaxed/simple;
	bh=J81S+quz2D6SJ+jZJSz2ptY54689YKnXpDm6RHFcwoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juUK+PRC3cfbFJtuD/jp1bKlunmcGw4nz2EaSV5C82zCvCFsIks/M67t4eXN3mhrT/YXqlSpHuMSbixzVB0JkAcHxrwzWKNrlSYyQk93HTAjKjaDTthJdTpciimbCUB45InTEKbrurWTZ2vT2Bh4befDEe6LVRNraLnXPNj/o4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=jK3Er7r9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso2059378a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 04:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760529097; x=1761133897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeT3Illh7u1oVcNtRdXPfMtGGKxc45UajEsrHq4K7Pk=;
        b=jK3Er7r9G6ILbG3ybxLEW3V9ISVF+c1MF2skz8HCBUCOxrBIqvEL5J7EtdyXUUgkTY
         m4Y0p55wf9WfVYaxLtBqhG8qmBKBYK8ebLZyEpdHfnaAmkAay4XB9Lm5/EBTCV/vJeZi
         vWcoNJiLHlHVTqTzhuuZZYixPJBHyzb4mVK6JWy5osIn4KQiowhL3S/t7qFgES0D6CpQ
         HapU07RYHqx9hcKOjWQxMr5OTg6CLqjo2BNIXi+Bknhe+OwRLZ1PsTSjeySo8p0BLC7N
         Bd/ndTR1KDdNl5+VszuWnnuFmbCSeoxv2HoepGtie3c+YwzyF+lIn2LMZcQ4nrcd9j9O
         HCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760529097; x=1761133897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeT3Illh7u1oVcNtRdXPfMtGGKxc45UajEsrHq4K7Pk=;
        b=swzZpXGbhlqeuIOCjSN0cGyjoh0oLGMKdS3c1cTNQLkAkeX7YQIEf5Hlyl5MT+6v+Y
         kCFV9cgZA0Np16B7V142pnssklgaL88iIe0Pb7Z3DA+NA57VV8FqqDsqqNYd6jOywNhU
         EiC5vJXouPD5fqGAtEiji8KQ32Sz4FYv1Yxka2ude+VnVGO+6em4jX+fMqK7A94YvMHu
         lQ0WollSow12YQ/Q2r6Dwe1jfbz7mewiL/QLWesPEapmHPzTpBjrY/PIWY7KEJFIZu9p
         8TAjwi5NqH+nkL7U/ONKQz4XA+ORqaYcCcpw8h+KLoJ/FUYEG9L3tts2PsHFazRmdgVy
         myaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNH4I/t/5B/luYLg+YZk+w/23Ll4NRCDu62sqD6oW+E5j91E5CBBC1CGBvK7mAEWdHu5/OwzPsrsI41Ie7OCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx54lOP+Y6zI56poDnScg4fTIxHZEUOCqkI2VBMwuDA2fDuABeq
	KeL394xIJGDKTMpm8q+bfmlx3kDZSWV6z0eFYsOJUpjWC0AbXvHYi8+DL26Sd4ROag6YyR7DGdK
	KIWKEWw9ILjL7LdzrGuKjbTJ1VSrwRaKrSxM7USqm3A==
X-Gm-Gg: ASbGncvq2T5fhb+IlEo0cxh8TLFB5uMbmBJS3xZ8kO50WkZJtjoJO5e29HllNcDcJBw
	/xAc7uON9EVDZ4mlzaYgiRs1OKugmJU41cHuozr64Pqp35Mi0hkakfALbQtbpxvQ5VsbCZzLD8W
	hJrYJtFNaWCM9YMZpHjrYRphETGMLuGYm8yHBicTnTYhS5CxT9UT1pUoAcU64s7sTEQQqomfn68
	A1rPlMPEXPzwFRv4fSMkzgxPPy4HwUA7A==
X-Google-Smtp-Source: AGHT+IG/8dhCCsOd0/KwUpvcxHFj4YxlARVqbw0ANuFg1sGtZK/6OGHoBYZjRNBVqY4UCZqH6zcoIDOBKlsppXGYtBU=
X-Received: by 2002:a05:6402:22ab:b0:631:6acd:fa3a with SMTP id
 4fb4d7f45d1cf-639ba74e058mr23000947a12.4.1760529096051; Wed, 15 Oct 2025
 04:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007033100.836886-1-pasha.tatashin@soleen.com>
 <20251007033100.836886-7-pasha.tatashin@soleen.com> <aO9WvF_WMkKKqYo5@kernel.org>
In-Reply-To: <aO9WvF_WMkKKqYo5@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 15 Oct 2025 07:50:59 -0400
X-Gm-Features: AS18NWBZnQJDAjctj-jgfCdfyiQeHYUPte3YsSfp-LkOjGf7p4zdP8W9aeP6Pbk
Message-ID: <CA+CK2bBC57v_CYdpT-Jcu4LX4MxZZ5CyAJBVTZVXdMnCXR-AmA@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] liveupdate: kho: move to kernel/liveupdate
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 4:09=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Oct 07, 2025 at 03:30:59AM +0000, Pasha Tatashin wrote:
> > Move KHO to kernel/liveupdate/ in preparation of placing all Live Updat=
e
> > core kernel related files to the same place.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thank you.

>
> One comment below.
>
> > ---
> >  Documentation/core-api/kho/concepts.rst       |  2 +-
> >  MAINTAINERS                                   |  2 +-
> >  init/Kconfig                                  |  2 ++
> >  kernel/Kconfig.kexec                          | 25 ----------------
> >  kernel/Makefile                               |  3 +-
> >  kernel/liveupdate/Kconfig                     | 30 +++++++++++++++++++
> >  kernel/liveupdate/Makefile                    |  4 +++
> >  kernel/{ =3D> liveupdate}/kexec_handover.c      |  6 ++--
> >  .../{ =3D> liveupdate}/kexec_handover_debug.c   |  0
> >  .../kexec_handover_internal.h                 |  0
> >  10 files changed, 42 insertions(+), 32 deletions(-)
> >  create mode 100644 kernel/liveupdate/Kconfig
> >  create mode 100644 kernel/liveupdate/Makefile
> >  rename kernel/{ =3D> liveupdate}/kexec_handover.c (99%)
> >  rename kernel/{ =3D> liveupdate}/kexec_handover_debug.c (100%)
> >  rename kernel/{ =3D> liveupdate}/kexec_handover_internal.h (100%)
> >
> > diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> > new file mode 100644
> > index 000000000000..522b9f74d605
> > --- /dev/null
> > +++ b/kernel/liveupdate/Kconfig
> > @@ -0,0 +1,30 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +menu "Live Update"
>
> KHO can be used without Live Update, let's make this "Kexec HandOver and
> Live Update"

IMO the current menu name is OK, as it is an option presented only to
users configuring the kernel, my rational for that thinking is that
KHO is an independent module, but it should be enabled as a dependency
by other kernel features that require it.

