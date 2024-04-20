Return-Path: <linux-kselftest+bounces-8517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A378AB84F
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 03:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AED1F21A02
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEE1EC4;
	Sat, 20 Apr 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EaL9YBDT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B607F9
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Apr 2024 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713576200; cv=none; b=dTEt8BGrgGCtuLackNuxqyPrKfDgmpVHD+9HfETZsF6NEccwM7ZAr+gqfod4swYbwUce3jFGCL98FsnOFXqvj7djtQRfGi/7xQYBdJTZM5g4Xs2MAecyP6iMffIjWH0ZxeQfM+JEcIE5DvpGKnEuia+OgDeIqVRKIQusxqlTMpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713576200; c=relaxed/simple;
	bh=J0MfJFQe8As9lwuUV4B9Kw4FNsDQePKIb9SHbW9KuQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDA+INxyqy7ovU3P3kghOlxMX4uFetb85hAFRiUPInSkqEegyocJUqMGutkEPo/vePgnlhwo28zIS5E+nxLYTZ+zzPeWgdaCjzDgcJ5luDQxBqevLPhNbsi7JnGKXYmSiSctkNFkY1vkcgeO/sxyfEm0Iy6bixJl3vOuuQ1NSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EaL9YBDT; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23489b56559so1437807fac.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 18:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713576198; x=1714180998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkYkipVaIPOoc32m8NtP1VEOzkVOrOXqd3GXQCTqvPI=;
        b=EaL9YBDTa2Go555gL23jstEDsQlUjsFNwIV3UTjJD8t5hHP6lBzwzInZxZLr4/q5oU
         gwS+Od7XHYTIrsRZrCKD7HzUyjgYgPofo6ZRPPaf+bVy/lLeMaEepLhlaz3WuSb77sTo
         5HaN7M1moweoXo2Uz7w+T/SPcHnRC/Y2GCVfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713576198; x=1714180998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkYkipVaIPOoc32m8NtP1VEOzkVOrOXqd3GXQCTqvPI=;
        b=GU81E3SwgDrcf/FzLakkrYJ+gUJQdWCbhp2W3JuyOTBK17LOWQJwUSRS1IXoaqfM5k
         5BOlNmLM7GNnvQpm9tP1+CS1tjgc/BogBh7PZ+6uYbeAl6tm1z5ZeZG53RnERz+AqXWS
         pLk54hIb/UZCkQENXCIiEy9TSQzN5pgTqcE8z5uxEzb7Q0jUa9X2WAmqNL1YU9DiqlsA
         J2GvVqbiQrs3IB9Rp8p3C5iHyZjsKHaYjmeeGsbBlj6uhq6T+n49GJfbypdMI9GYB69n
         6H/4eMHBQDpuyNt2CsXb2iXmB1n1GWY14NGh00woeTg8OxElH7Y0qU08Wn/PQtHi9h4W
         yl2A==
X-Forwarded-Encrypted: i=1; AJvYcCXnELN68Wd02Oybd1A1e3BHgSvwsUnBEurDUJYRgD/Pww+qtpOog4fvaQmnyRM9V9rfBn49rlmeoyqci3TOSiePS98rqEyBkZVpCpYsfIYP
X-Gm-Message-State: AOJu0YwHO9KVLbn4Qh3RQ/4vjcgWOX/hay9D51K63Z7BAi73/2unRZw8
	wNv8PwtPcV4pnd6TrVglcRG2/x1DUVVOlVgAFt30TK3GRRAjMhyer6DczaqAYe/gbDvGIO+nBxW
	CMusGa6Ltvrjrtxm8Q8VJF6liemTg91FUmcwf
X-Google-Smtp-Source: AGHT+IHBc4Rb3dg8R081whzPxTVTeU9l1xcO4/ULPqot8pzPW2t3I7MBZbBmk6o1jIf7EVB1Xx8ui0lQ4Bl/rq650XU=
X-Received: by 2002:a05:6871:203:b0:22e:d541:7eb5 with SMTP id
 t3-20020a056871020300b0022ed5417eb5mr4612272oad.38.1713576197982; Fri, 19 Apr
 2024 18:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <znrbeb744774vre5dkeg7kjnnt7uuifs6xw63udcyupwj3veqh@rpcqs7dmoxi6>
 <CABi2SkU8B27O28jjTDajFpENgUHhntuRAMKFUMXr6A6AxZeyiQ@mail.gmail.com>
 <CAJuCfpFLwJg4n7wPpT+u9vC4XHoLE_BPPZ0tDKf7W45hGky4_Q@mail.gmail.com>
 <CABi2SkXCC8tvuHTiZ=tYcZw0sQ2SswQqDuFuQi5bKArW9+Nbaw@mail.gmail.com> <CAKbZUD1ZLfAPznGg-j2xmC7O2a-b8jRRQjSgRLRUrP8DQ6Lntg@mail.gmail.com>
In-Reply-To: <CAKbZUD1ZLfAPznGg-j2xmC7O2a-b8jRRQjSgRLRUrP8DQ6Lntg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 19 Apr 2024 18:23:06 -0700
Message-ID: <CABi2SkVJejGvOiSUapTJiEOcRz-c20EqE_txzUDxwWgKG0cb7A@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 10:59=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
>
> On Fri, Apr 19, 2024 at 2:22=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wro=
te:
> > The overhead is likely to grow linearly with the number of VMA, since
> > it takes time to retrieve VMA's metadata.
> >
> > Let's use one data sample to look at impact:
> >
> > Test: munmap 1000 memory range, each memory range has 1 VMA
> >
> > syscall__       vmas    t       t_mseal delta_ns        per_vma %
> > munmap__        1       909     944     35      35      104%
> >
> > For those 1000 munmap calls, sealing adds 35000 ns in total, or 35 ns p=
er call.
>
> Have you tried to spray around some likely() and unlikely()s? Does
> that make a difference? I'm thinking that sealing VMAs will be very
> rare, and mprotect/munmapping them is probably a programming error
> anyway, so the extra branches in the mprotect/munmap/madvice (etc)
> should be a nice target for some branch annotation.
>
Most cost will be in locating the node in the maple tree that stores
the VMAs, branch annotation is not possible there.

We could put unlikely() in the can_modify_mm check,  I suspect it
won't make a measurable difference in the real-world. On the other
hand, this also causes no harm, and existing mm code uses
unlikely/likely in a lot of places, so why not.

I will send a follow-up patch in the next few days.

Thanks
-Jeff
> --
> Pedro

