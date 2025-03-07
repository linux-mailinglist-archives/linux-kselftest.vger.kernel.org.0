Return-Path: <linux-kselftest+bounces-28517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CD0A56F73
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D9A7AACDD
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE9B2417CF;
	Fri,  7 Mar 2025 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn4uxx+8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775DB241114;
	Fri,  7 Mar 2025 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369398; cv=none; b=FeODeu2Jx5An6d21/vhozXvFAVHEpuNt5uSWHcMguJ+AKOsZ+tKC/ALJ5vQ1p1rJCUE1JRs4abgpZlZGM2rasI/ievCAX5bhJFkPkpsnRuqleBMtRj2QG2exOXvb9Uf2Y1yAVtvLjRRHZau2ITQ2aYZ3ouPwVeIsVhSb+ThOLSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369398; c=relaxed/simple;
	bh=Lw1nmb2v0Yj3bxOV+QZJBEEVt/+s6xuWrvoi0UoUrXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LY9GrkJE+FGX/2u+FAYPuX93WxuT3TPdkUsaQ9C8zPHx5zF6DOBXfNFjymcYtleDPFLfZoMLw+NRPQxi8uY6zF2zHvU+JZ/TD2ZF7B3lfNcrNAP9pUjIOl7BG2f1qInL2hA3oZdSipwPFZ5xIlV8K2tD3mxnHrTyLiYpYQmm43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kn4uxx+8; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307325f2436so20985631fa.0;
        Fri, 07 Mar 2025 09:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741369394; x=1741974194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpmu3Gvgb/KEU4Sda/9nJtOsIbbAseer/tFW7MRAm30=;
        b=kn4uxx+84EQrkr/KR5bEZw8T+d9RBZSQZZzRMuC4fx/HeiWyCy2naCmVlOzugal3vf
         n70WkQCOF5pN3iVIhIyaLKJcQ4TqytqkJftDswhjDyAjnq7uyG0pL7gJo8Zs20Hl2jt1
         /WW4u5kM4ZqGmAppK6Ev09D3E+bZW8JH4TlAiFB5K0nOiXFJrO72h+RqnQVnAeUtEesI
         4CxIKpM3U1QdC0CXUqqzPdPIMPLUB/LUkLnbyPvoMu00U92BlMdHndMDBXUwD+n1wKkR
         wBIxV0i7gr1Y389z2J9MgAyZBDjR7h6HNGdNUjq6EOBd7gXZV6GlubK0ZDYOiQZzHKhF
         1y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741369394; x=1741974194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpmu3Gvgb/KEU4Sda/9nJtOsIbbAseer/tFW7MRAm30=;
        b=aWxByVppdc51Ve/Xt1iIljG9iFTN8yG0MW8iBv+xMVhYaI7o7GpwUi9pGxu97qcDbs
         hcTh/gxBAY8JgA3RtfVzzrhNP2b52cRvfeRg2m2UTvIx2zUy78p/IGWvBjrtiGdH6oFl
         lFPLOQV6Fa7sWKcmjUVHnq9zU0Io6I1flHV+8ws9pI6NSuE6DDrfnIaCDhlzDnFBmDPt
         bJamWtpJf04JyAlMRH198JyGhlfjRbv76zJY/f8n8jkSWiQzigrghh0Ejm5iVCGcDoWn
         Fj9PNtAq1QfHWYWhoc9AZ+RQyFRz7OBhHGLG8MtFa/3LPSKxIXvAY4bdHzSn5Ua88bp9
         pgSw==
X-Forwarded-Encrypted: i=1; AJvYcCUeon+w1GcLHSCzNdSlg6GJaT0YYYTdBWuu0bTILEYOzYX6b9zNCNBUiRweMmBZc0jedHkoMnBfRJAlT8TjbmhL@vger.kernel.org, AJvYcCUoZNh1/GyhIostk2ITA0LoBwlKUm0pqtqaDMyYfKDb8RXQj35I3mvt0Iwm2EIAp+9cVtLj/sH3t7wjSVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCNw+kYX8w+wMWzkYsdMMlAM0IMEhwbGQYGmf8kxwwstEQciaT
	6yePOXaAP+ZD7CU0z+S09QTlv8ldE7OanIRhtuSdsruy/WjrcPMIbJdKnEMNY4pULn5Vwvf0Eb6
	c8ebAeoC2Z9ZnP6x9PhO25fcMdJU=
X-Gm-Gg: ASbGnctsfT4dw/w+DVdrO86KvveYJFsYXZrpl8IhI9nh6FHbSoakbcn86VU4jyG8acs
	vgM1XRlDqJZdrKXaFBJC4xGD1Z5BA9KK3ja3Y2kEtGOT0ai7sbp41XCG3ViypP6rCpJRPYvMbAa
	LfxKfIhnzE2du4PNGYNYqmNvNZ6ec5Nv6+Grt79deX/KNp9dh4690Zt5ytJbUv
X-Google-Smtp-Source: AGHT+IGNE+s/WfCFPmFb4azPDrp6Ep6m4DzvtThcdQnGQ8oYJv4In1m3Li/HSQtD0h1GwQ0dx6rOpSPlli/LEIWCFUk=
X-Received: by 2002:a05:651c:19a4:b0:30b:abe6:4bb0 with SMTP id
 38308e7fff4ca-30bf451abf5mr17878641fa.13.1741369394123; Fri, 07 Mar 2025
 09:43:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
 <20250307-scanf-kunit-convert-v9-5-b98820fa39ff@gmail.com>
 <Z8suJdZsLYPYF34t@smile.fi.intel.com> <Z8svbdT779qxfXuk@smile.fi.intel.com>
In-Reply-To: <Z8svbdT779qxfXuk@smile.fi.intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Mar 2025 12:42:35 -0500
X-Gm-Features: AQ5f1Jp7RU2gmPYms0G_AXDCTB9f6fphgxlud1fG4O9DYc1x04owURciYIdEq5s
Message-ID: <CAJ-ks9=QPkYX1HN6g1g=_F+a2B5+NHyE-ybtVaveK4JvtgFhVQ@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] scanf: tidy header `#include`s
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 12:40=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Mar 07, 2025 at 07:34:29PM +0200, Andy Shevchenko wrote:
> > On Fri, Mar 07, 2025 at 06:27:38AM -0500, Tamir Duberstein wrote:
>
> ...
>
> > >  #include <kunit/test.h>
> >
> > + array_size.h
> >
> > >  #include <linux/bitops.h>
>
> > + bug.h // BUILD_BUG_ON()
>
> Actually if it's only BUILD_BUG_ON(), then we better use build_bug.h.
>
> > + errno.h // actually asm/errno.h, but in C code the linux/* will suffi=
ce
> >
> > > -#include <linux/kernel.h>
> >
> > This was used like a "proxy" header to a lot, see around.
> >
> > >  #include <linux/module.h>
> > >  #include <linux/overflow.h>
> > >  #include <linux/prandom.h>
> > >  #include <linux/slab.h>
> > > -#include <linux/string.h>
> > > +#include <linux/sprintf.h>
> >
> > + types.h // u32, __scanf, ...
>
> ...
>
> > Note,the above I made based on the context of your changes, I haven't c=
hecked
> > the resulting file in full, please do it yourself.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

If it's easier to take this series without this patch, please do so --
my tools aren't giving me any help with IWYU and I'm not familiar
enough with the kernel to do a thorough manual job. As this is not
core to the goals of this series, I'd prefer not to hold it up over
it.

Thanks.

Tamir

