Return-Path: <linux-kselftest+bounces-3751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30049842BEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 19:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48E21F21954
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 18:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6F778B76;
	Tue, 30 Jan 2024 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggc7RK4A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1878B49;
	Tue, 30 Jan 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639848; cv=none; b=WkCqo+dc7TgPXYUZG9UeV6+VjARwib6tVKjHiiOSjp7yFNbspu33M9xwTp/ymSSxVy+3LGM3px/3SpDywoTuOPf8rix4dXhW2DxBBGSEDghlKYuDTuVkaZFYKonctVlh+XKrV5gXX0u61s56pSQsyBPaa4+8oi7S95qdkhZ4hcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639848; c=relaxed/simple;
	bh=ZsZ4CSEEReHodm5XT1/IpDGk1NZ+OdsfN9HrhiTiSkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFoT6acVVwpqEEX3/u9zIWaOMOycDPp+Te+p8Fv8mpCtkc9ezeCXLHnePKvi2z5tnGo0GheIbUq0Utp+AO+zwDAEdGLGMfrdK7E5OPUXqigO4oTWKB3oESilSruMUuRXZdreyZkfAzF3zapz17MDCpe273xyMs4r7sH4Y6LRYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggc7RK4A; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bfd5eeffefso150577139f.1;
        Tue, 30 Jan 2024 10:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706639846; x=1707244646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hM9ej9K+8Z1VJp/yGHaHZXuJOYSDyYzm2GNeYFRuOio=;
        b=ggc7RK4AzqB5CGmU6/v/l+uga4A8OixXr4IPje5DIXtqGR4DabhEGv1oSaJ/SwJQW+
         x7rbBxvOyUhcn02AKFVSKOOa8ODXZN8cj0rkBkMvHYD2N1bw9XLhdUBi8ZspUUYzY09f
         y0KsekUgj13Y+SLvV2KJ8vMcTARndIdv15EiPv6tLDtfV11SlQR5HDMMXMWQ9KNlD5yR
         /k2Zb/o9/gbkbsKRSRYSokkdgVAeimi21INEiKTNtQTlXts2P1eB9GAq3M7QvpEw/Dx4
         Ffhh2Ke+TLg7/ZZ/pMLx4/NgwQUoftOgO2HTcJ5ep3usOf3VBYc0noIleJii4VbgBCGT
         naWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706639846; x=1707244646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hM9ej9K+8Z1VJp/yGHaHZXuJOYSDyYzm2GNeYFRuOio=;
        b=S7aCRfhvUMcGbeA/V7bsrjxUcxXNWGQQvyKDUVsjnMIDMgX63Nhj5t1roYZb47fb9G
         qqPD5gfpYAdAvB0wPLtLdiHNlVkwIk2eUaR8xUb6ROdkPEBcyh/Sb91xh+uUw9bl6iDr
         fa1ihUbmH5aX8pddtkw9TB5filyxsKEVaCXMYcSTGKDvWRfnwcWmdHn24ZyHPJ/E9mQ7
         KY7WXySS1WNz0Wyh0e81xoy5K5l/mxPgZM3U2T6Enn4puz5Z9zjZbRlebew4+0OsXNzT
         gOpI7NaQrEcGja35XS6iimtwEpzwr0d0DCuSkMcs7qon6kDr0sdm4HIwBu4p3xRfgeOB
         R7dg==
X-Gm-Message-State: AOJu0YyZYpOAdKj1pDk6zsPabdWvLTRid3aWtd8+mp6E1vkNbpAz5dzi
	roXS9Cd/jkU+iwIb/CGYGX8Wn1rd//mzJglNc2LG8Vi1vs607/p/Oo95ymr4okXT6FgNtICZvum
	bRQQzegD+BvGWUIA/ocVtq2dkSAo=
X-Google-Smtp-Source: AGHT+IERoa1G5FtsZFo/vtPsaqg2DfIVxKvUU5JLdo3L/X1OxY9spoX0SrOT+0nfO/bBF0zz61CYZCV1tV831AGsjD0=
X-Received: by 2002:a92:d5c8:0:b0:363:900b:fa50 with SMTP id
 d8-20020a92d5c8000000b00363900bfa50mr1933229ilq.2.1706639845877; Tue, 30 Jan
 2024 10:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129224542.162599-1-nphamcs@gmail.com> <20240129224542.162599-2-nphamcs@gmail.com>
 <ZbhKoJ5BcP_RhMt4@google.com>
In-Reply-To: <ZbhKoJ5BcP_RhMt4@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 10:37:15 -0800
Message-ID: <CAKEwX=OwsEcSnw5V_zivdFzGLLVA_PC+Acv+5sozkCJU1NHpeg@mail.gmail.com>
Subject: Re: [PATCH 1/3] selftests: zswap: add zswap selftest file to zswap
 maintainer entry
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, hannes@cmpxchg.org, 
	tj@kernel.org, lizefan.x@bytedance.com, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:02=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Jan 29, 2024 at 02:45:40PM -0800, Nhat Pham wrote:
> > Make it easier for contributors to find the zswap maintainers when they
> > update the zswap tests.
> >
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>
> I guess I had to check the zswap tests at some point :)

We sorely need more zswap tests :)

I'm one of the offenders of adding new features without including
tests, so no judging anyone of course, and admittedly zswap is quite
intertwined with other parts of MM, so it's kinda hard to write
unit-ish tests for zswap only. I often had to resort to scripting
stress tests to iron out bugs.

But there are still tests that we can write to verify public API
(cgroup's zswap options come to mind), simple tests that cover crucial
code paths, etc. that we should probably add in. At the very least
this can be a quick/sanity check for developing and backporting
patches into the production system.

>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fecebfc4c0dc..5f60faaefaf2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -24396,6 +24396,7 @@ F:    include/linux/zpool.h
> >  F:   include/linux/zswap.h
> >  F:   mm/zpool.c
> >  F:   mm/zswap.c
> > +F:   tools/testing/selftests/cgroup/test_zswap.c
> >
> >  THE REST
> >  M:   Linus Torvalds <torvalds@linux-foundation.org>
> > --
> > 2.39.3
> >

