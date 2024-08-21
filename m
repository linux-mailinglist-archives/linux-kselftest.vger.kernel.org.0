Return-Path: <linux-kselftest+bounces-15875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06FE95A2BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 18:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A310F2821C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 16:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C40F14F9DB;
	Wed, 21 Aug 2024 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDeOYV7o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967C914F138;
	Wed, 21 Aug 2024 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257453; cv=none; b=L888uRFHE6HNfL5mlVUm/mkxRycz/26pFc0xrJSmU+ZE5Bjyx2imoCfv/wliGKjROqIf1eNqoPQkGyjr9K5ff4U/GzJN6VqR9Wgm8h+vzX0EtRdMOkQozZ/D4rgZpe1JTqkMvxQdVYwYBcYJrZLTRtZaQnnj96cjdDTv/13d6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257453; c=relaxed/simple;
	bh=AIU0iIMj1Ajd2whoULAysBb2XQEyT0fu4neXgwYSksk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhh0qNRHlLONeelyONvqsJn4I+ND4MnQJysgVNecJDEk0KT+QiJLRmNF05P/fBdOT0dAkBrKJK4QeaI/RBjrT/mb/vDQbUQN/DmLPT3eOyP4WjYUwNRUrRbicSeyHTQPvJn/sSDsqlaaSWxE9Xv4uRlX+3LT8LFQcmL10wKIljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDeOYV7o; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-498d2645902so485724137.1;
        Wed, 21 Aug 2024 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724257450; x=1724862250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4rw0kESlG57Y5Fdr7JdXFUPwDZdnWPiwRkEaByWok0=;
        b=TDeOYV7oOv18E7816F7Oe7ebmgCdicl42RZ04xOAVbeQqgIhyjSG6xCo5e5iN7PJ9G
         kBICGKYfGxQfN2mxzACieLr3qwIPH8Bk0R8gThByT+OTis8Y5EItXqB785ToZE7HD0PO
         z05wU/7j97MwT8/eaxEZyj27lyowmDHgiCXL4EGfgbo2FzJ0iA8ygi90iU52C1bGhQUX
         bq1phvjNBdPOwhhiNv4umqNaeeF51XY/tmhMjmbe3bZ8YHlMridz9FkpO5Erud3Q0L98
         ShvoEUFGF32lNB/3VtpLL0PURMuoT8JrYE9sJSCiAhgtZEZhy55TMuOlu1MPITAfjbe9
         eLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724257450; x=1724862250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4rw0kESlG57Y5Fdr7JdXFUPwDZdnWPiwRkEaByWok0=;
        b=CT8fAH88zsJrlnkeUKzFszApXRPnvXYspkVXqh5F9pr/3ViVbdX5caa5du+AIY3rGC
         Vni3P4XkviLyZeLTXx+Jghep1UWMQhZFVWbRELIqJsP4uDo9Y8pWFrA0U/VRKU3oBWUO
         PrO6bjv5Qf+TKoVqe3UKBtt90Of5jwgLRFdXBC8MGrH/5SmFYE7LavRlsb8cjDrUhBDF
         LP5Kr9fD6/SDsTVpFJT7v1pIEJzE9YIs9S/aQq3SwAh0Mfzp8jMYq0jDJQ1q/cnWlJU2
         U5eIWCG1ks2GMR/o/NIpFPUjQw5LuOMKVE8sTdNp35AkEXdHUysYb1aRc+x5gLHFmCkJ
         63sA==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZjCdD/m7CfcOpqurTJlUi4L2GhOkNfGLMazT4Xl4aWsXVASxWcR9mEfUjuR1bJnfR4QD0p5bpRXR3mU=@vger.kernel.org, AJvYcCUVhgQogO0CeWwCQAwOOhUzC/TDI4QA20w1WoDpiqt4iyU7I4XQY4MV4a4B82dP2SwYI4yJPIUHdogiLEX74dwx@vger.kernel.org
X-Gm-Message-State: AOJu0YxXGm0tGZrFbyo7QwhdGDKXwRcyWBqDMOwZP89Wl7xiTPehVM0H
	IduObnEBse91mf+pt78OmCPI0ZP/eboxwoPHB3vySJQy2xFRbXmHoK5DZTScYHKA9DHhVyJjJqh
	XCZyETGRydWwz4HVj+GN5FBIC0Zw=
X-Google-Smtp-Source: AGHT+IEy45XbJAJubTJbbB0aZf//WXCj+R+q0+ltxOLZhaiEHiR0kKdfXVuxqBHWiBz4U+YtUqyXR2YPlBdE2+5JrZY=
X-Received: by 2002:a05:6102:cce:b0:498:9c57:7442 with SMTP id
 ada2fe7eead31-498e2235acamr255336137.9.1724257450099; Wed, 21 Aug 2024
 09:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-2-d8d2e037df30@gmail.com> <CABi2SkUBH+utreVMTd1qEBSvXTPM7Qc1GiwNKjVa9+EeZK8WWA@mail.gmail.com>
In-Reply-To: <CABi2SkUBH+utreVMTd1qEBSvXTPM7Qc1GiwNKjVa9+EeZK8WWA@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Wed, 21 Aug 2024 17:23:59 +0100
Message-ID: <CAKbZUD1d5hXWUPVpUzPo=M33_eo9_sdMq6nVg-jd=-O-CpFjsg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] mm/munmap: Replace can_modify_mm with can_modify_vma
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 5:16=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Fri, Aug 16, 2024 at 5:18=E2=80=AFPM Pedro Falcato <pedro.falcato@gmai=
l.com> wrote:
> >
> > We were doing an extra mmap tree traversal just to check if the entire
> > range is modifiable. This can be done when we iterate through the VMAs
> > instead.
> >
> > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > ---
> >  mm/mmap.c | 11 +----------
> >  mm/vma.c  | 19 ++++++++++++-------
> >  2 files changed, 13 insertions(+), 17 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 3af256bacef3..30ae4cb5cec9 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1740,16 +1740,7 @@ int do_vma_munmap(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
> >                 unsigned long start, unsigned long end, struct list_hea=
d *uf,
> >                 bool unlock)
> >  {
> > -       struct mm_struct *mm =3D vma->vm_mm;
> > -
> > -       /*
> > -        * Check if memory is sealed, prevent unmapping a sealed VMA.
> > -        * can_modify_mm assumes we have acquired the lock on MM.
> > -        */
> > -       if (unlikely(!can_modify_mm(mm, start, end)))
> > -               return -EPERM;
> Another approach to improve perf  is to clone the vmi (since it
> already point to the first vma), and pass the cloned vmi/vma into
> can_modify_mm check, that will remove the cost of re-finding the first
> VMA.
>
> The can_modify_mm then continues from cloned VMI/vma till the end of
> address range, there will be some perf cost there.  However,  most
> address ranges in the real world are within a single VMA,  in
> practice, the perf cost is the same as checking the single VMA, 99.9%
> case.
>
> This will help preserve the nice sealing feature (if one of the vma is
> sealed, the entire address range is not modified)

Please drop it. No one wants to preserve this. Everyone is in sync
when it comes to the solution except you.

--=20
Pedro

