Return-Path: <linux-kselftest+bounces-16686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72D964892
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 16:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAEB1F280FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CE11AD3F1;
	Thu, 29 Aug 2024 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q3FLonyK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6435433B1
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942089; cv=none; b=jPZCu+fQX7LyhKXsUPDbJGFnkDbNmrK+s3YQ5wogF80g2ubTA9YLFSuVlaslF34wRp04QqJqi+sdB0S91xfg1tkhfnlGQSRua6TAfdMjViJkkIDjoac1MG9fu89rd1MHAjfu8B7K424fih8f9ReMnuxCQL+7AgQvhPRzPeJ/tqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942089; c=relaxed/simple;
	bh=2e9dxxABc/1erTn/e2ryhI0NWvYiQdiajCEV5LoHNZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=is5iPAH0KF/K+PJB+q91lKWU1U0FGLbeEurSD5vbOH2BE7oshxL7FIVhFrZODj0ZN7ddtXd8teNsGspXchh+NXcxlUPQZ6ilw7Ba0NP+c/QwfwwYvTaYROT7EddH68yuxOFOw7JeAHn+ugb+vXmFjUsAqtYYq3QJ+91TvpZOl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q3FLonyK; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2777cbbcedeso92551fac.3
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 07:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724942086; x=1725546886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJvOS0jrrStCn1p3egyXOQWxbnH6JNr9A1VShqqaYTk=;
        b=Q3FLonyKQ3S/vr/g77Ih6pxFT6s3WObQxmFCq3vMdw1o7UpCllr6bfGjX489/k02+S
         zocQZC1Ubm7BTLjNdG9C8QPiOlZBYEqv2LvNUPxhvt6giHIvit0dq/kc5dohAllcnSWY
         +P7PUGcpAAqM/q3PvbMwxIK7ycFs43UJZj1/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942086; x=1725546886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJvOS0jrrStCn1p3egyXOQWxbnH6JNr9A1VShqqaYTk=;
        b=lEv//9UOt0zVDLuQBtr/t5Oo7GYiSQyNTVpLEVRbNxf9zsWCSSbDlolVdADRmVkG16
         iP38IljAx3QVSTcRCL9u+d37PHb/RqwIGnCzF3ycSQCLOwOEvZ3rp/6Lp+AnIq9ApbS4
         vU2O2Rf98JntqAViVjWfh7PHCdMqS1MM5qWKzr1jcCOYgLg2kFOCNKCQucUAMmEOBYfs
         /cunVA3FKEXYmGK5If5gI78E1uxPUej6zFnZCvBsszX9mDM6XMYqiBw5Rfkra8nJ4aUU
         I3Nqhs6LKFRnfvgGkYOX6eH+vpbiZlmezs39Yri26Ajjvj85eJrqzz2OvOEEeAk2J6UI
         Apqg==
X-Forwarded-Encrypted: i=1; AJvYcCVgZ/b/j9ctKljL4CzJA0A43v0RqujiwCvVOI32/4blFRCnUpmGZFri/vWo1ZF5yLRHTNSofWJj3lQPWPmVXhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAFlL9vsWEuHDwszCJYRJ9rR/DXF+Z3qJdheoD5fDsZxXWNicO
	bW1DEPq1xa8F+mh3PR8YSwmzuMknTmgrg2Kk64m7i3TSvC3Vem7vKOywVIZ0BO110DtnBD81xd+
	PayfUgpIahVgKEpjyjbU8tdc24dBewAvF76fh
X-Google-Smtp-Source: AGHT+IF9LGbiJFVqc1DMjTkah3A1+IPMe1eJBsBwTEaX1TwXJ7fiM5f3el5JFuGiTRRorOR2mHIY3H7LZkeJi5v8rJM=
X-Received: by 2002:a05:6870:d623:b0:260:23eb:5669 with SMTP id
 586e51a60fabf-2779007fb72mr1759062fac.2.1724942085649; Thu, 29 Aug 2024
 07:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828225522.684774-1-jeffxu@chromium.org> <58e47a2e-6556-4a41-9fe5-1378f5257534@lucifer.local>
In-Reply-To: <58e47a2e-6556-4a41-9fe5-1378f5257534@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 29 Aug 2024 07:34:33 -0700
Message-ID: <CABi2SkWkdHErmp3Fjx+_aZXr=V3gBKfE8Nk9ESfB32N+FMCpog@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mseal: fix mmap(FIXED) error code.
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, pedro.falcato@gmail.com, 
	rientjes@google.com, keescook@chromium.org, 
	Liam Howlett <liam.howlett@oracle.com>, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 5:09=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Jeff... come on now.
>
> Please cc- the reviewers of mm/mmap.c on these patches - that's me,
> Vlastimil and Liam. Same for mm/vma.c, mm/vma.h, mm/vma_internal.h.
>
sure, that was a small fix and I thought introduced by Pedro's commit
(which was wrong)

> And it seems like it should be pretty obvious you should cc- Liam when it=
's
> quite literally his code you're changing!
>
> Relevant section from MAINTAINERS:
>
> MEMORY MAPPING
> M:      Andrew Morton <akpm@linux-foundation.org>
> R:      Liam R. Howlett <Liam.Howlett@oracle.com>
> R:      Vlastimil Babka <vbabka@suse.cz>
> R:      Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> L:      linux-mm@kvack.org
> S:      Maintained
> W:      http://www.linux-mm.org
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> F:      mm/mmap.c
>
> On Wed, Aug 28, 2024 at 10:55:21PM GMT, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > mmap(MAP_FIXED) should return EPERM when memory is sealed.
> >
> > Fixes: 4205a39e06da ("mm/munmap: replace can_modify_mm with can_modify_=
vma")
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
> > +             if (error)
> >                       return -ENOMEM;
>
> Can't we just return the error here?
>
> This is one for Liam, but I'm ostensibly in favour, this does seem valid!
>
> >
> >               vmg.next =3D vms.next;
> > --
> > 2.46.0.295.g3b9ea8a38a-goog
> >

