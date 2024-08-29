Return-Path: <linux-kselftest+bounces-16685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115A0964890
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 16:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD39B281D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 14:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6811AED4A;
	Thu, 29 Aug 2024 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HHMoWu3m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB341591E8
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941994; cv=none; b=hzLipZtyZEboPTS3dci4cfd0vcCTy2aNuBFw2qxPwTXZW8aYQNdJbQoUUCRkf6bpbfucx7J3GUYQ/YrckqOM6KUWW66rCktHoYT9u4kVdE4OUBE5VretdDuAfuZRhDTSKvMiKnwZCB4vsq8ptOypl4i3Ds7EifKOYLSnoQrI9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941994; c=relaxed/simple;
	bh=QCvqAFnGFMNbSVCxX5lIIRujCTMnziArQz+X1SNf3gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpQmiPLYcJJ2q+0974k5u1DRyz3GFGvSmxpjaDhqwZf7dxsnz4vF0/4kzVxifNhfBbxBLe5z3AaiNUd6y5xWpwHCDJ3Or7cc55Tgsz6J60D9m9Np/bYQAgSNZdL2fbpMAOzGPkWJLBc0AcOxj/2F3o377608bZH6PAyGgHNbURU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HHMoWu3m; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2777cbbcedeso92462fac.3
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724941991; x=1725546791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbjfLJ2fqDDhqtUpB4c2guraSJR6Tgu7wwzcqEJUoY0=;
        b=HHMoWu3m+2932ShGnBrz27f35dpBlXeGlWvS7K6orNHtFeszLxMCkJgbvZJHaMDyo8
         cLXTIo5piZdpkTY8ghXGeU8e6f2m7uTwgZhYPHU1jesiqh+iTFT/y1leXDUl45P0p6tQ
         OBrGr0sAdRRNPGQ6fDra3ZkOr0afIoxAwGF8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941991; x=1725546791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbjfLJ2fqDDhqtUpB4c2guraSJR6Tgu7wwzcqEJUoY0=;
        b=s/J3UYQTLwOmjzB+h5MUHm2kn6uLFc9flZTDeqAnlgVkJ2L6mGxzdHmI5BGxtZllbA
         0ZHkqkCJwzLZayUpbBjAkx4c9rWNP4YcRQEKWBlpRC1mp4NhK1tWphJSa9PoE3W6Vyq3
         kRP8VaXGHvSdOcBO3dOWtFOjuhbNZD5XIDAeH4yJ8uCx7qtniCSmBoXozK+HAqHLt2Ag
         2dJVyI0xlK1yi9yL9OqEGOCU/6jTHRVcL3UAcPKdFTh/zGZ5Sai7dxXz1SllKugK/e53
         Uxsry25z9bALY5plOhKRRau0yMjUcVQPO0oCf7k3rB5xbCANe7KfYTO2Ym5k9tjmI6he
         s1AQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0XeU9uc7UYQ/VE0NBg3hF3BhZiwvVNVanA8ZXr7E7Y4O85YUQyIk+8sPV7dTCjO0SpHb0Tkp/Xl8RUXimLzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUL9TMpTMXzm61GKZCCLJWWkDPfkys2yu1AYPxKJ7kxY9ECdH
	9JmYa7pcpgWQFsgpvOzHt/Lks0JskBBCQh2zSFUYMNZk8O9/DrVdEXV0EJ9X3woUP2oheT8FmCQ
	8sB34oig8bl7tJ3GUdjBLY9uWSgMU5Msiu79N
X-Google-Smtp-Source: AGHT+IF7hEs4r13r9Gs1wT8QNsV78DzGrCss8ANs+XXz5eK3kud3soytApHKrEVu7yGI7fuxaztQAt7RmbjOdNAlsjA=
X-Received: by 2002:a05:6870:a70b:b0:260:23bb:1087 with SMTP id
 586e51a60fabf-2778fd5b726mr1752368fac.0.1724941991020; Thu, 29 Aug 2024
 07:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828225522.684774-1-jeffxu@chromium.org> <jxov546uro5lffibw5asff3m25pfnondbp3nrqc3fde322h3on@ypkdkju4xaho>
In-Reply-To: <jxov546uro5lffibw5asff3m25pfnondbp3nrqc3fde322h3on@ypkdkju4xaho>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 29 Aug 2024 07:32:58 -0700
Message-ID: <CABi2SkXxkzypPiXpjk+fuXBpdgkpCWD=z-Rzk=zFbSkY7xON1g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mseal: fix mmap(FIXED) error code.
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, rientjes@google.com, 
	keescook@chromium.org, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 4:38=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> +CC vma reviewers
> On Wed, Aug 28, 2024 at 10:55:21PM GMT, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > mmap(MAP_FIXED) should return EPERM when memory is sealed.
> >
> > Fixes: 4205a39e06da ("mm/munmap: replace can_modify_mm with can_modify_=
vma")
>
> Thank you for the patch!
> This Fixes: is wrong, the bug was added during Liam's rebasing of his mun=
map patch
> set on mine.
>
ok.

> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  mm/mmap.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 80d70ed099cf..0cd0c0ef03c7 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1386,7 +1386,10 @@ unsigned long mmap_region(struct file *file, uns=
igned long addr,
> >               mt_on_stack(mt_detach);
> >               mas_init(&mas_detach, &mt_detach, /* addr =3D */ 0);
> >               /* Prepare to unmap any existing mapping in the area */
> > -             if (vms_gather_munmap_vmas(&vms, &mas_detach))
> > +             error =3D vms_gather_munmap_vmas(&vms, &mas_detach);
> > +             if (error =3D=3D -EPERM)
> > +                     return -EPERM;
>
> Not sure if it makes sense to special case this. We should probably deal =
with this inside
> vms_gather_munmap_vmas and just pass through the error we get.
>
> Otherwise LGTM. Liam?
>
> (we should also squash this into the offending commit)
>
> --
> Pedro

