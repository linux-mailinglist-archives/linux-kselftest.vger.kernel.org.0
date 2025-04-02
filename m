Return-Path: <linux-kselftest+bounces-30026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A21A79596
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 21:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE08171020
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63E1BD9D3;
	Wed,  2 Apr 2025 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wMTdBfM/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580A1C84B9
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Apr 2025 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743620727; cv=none; b=ks4+sJ3WGADS9AKgyzpAB/szvmpm6Oxu2xj7yryLx5o3XqQTE4QW1levkm83BOdtWhM3jdKp9Vldtv67FntywcD9TbqgXt9zUXSL3FpJ75DjFqFcCv5gCDXGEuDSUxZT8fdj38wcJ89YQv1lw8zzh9ev2BXKVIm97OHI04Q7Hps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743620727; c=relaxed/simple;
	bh=n/e968CMrZPXaEiYtBipQmernN8aJZpSyBnS5GuRP9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEKOBy46SiAtn3yd2uCy3fnO/Rq6uxpwFpitAiBIh/lQ8rQKpcqRutleHojc3Faxx9ihblwK2gUK6yM6qYqUBPCiVuAHoM8pbA3RGHUewvsIHKRh6TZG698PFqP9s35mFXWXm3FBK7/3UxumH5qUzFOgdiM/l1PT8f8/dgC0MYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wMTdBfM/; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e6405e4ab4dso1194960276.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Apr 2025 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743620725; x=1744225525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NawvRhJbCe+nOvQp4dfQ7SGUEZvzZ9Crvhv45c3qAgA=;
        b=wMTdBfM/d6PxpjPB9J45VVIhVGRPzIYmfxuxPPMXmIA8TR6uMC5r4Ke2yazUzBlqXN
         O7w9fm3b/9db474nCiF1FL72z6KbR/U6ji1eiY7Va0AW0INkp8UnIzbVQMUm0PWpY8sT
         7dI177E2+lL+mrOks20PsVdkl1l7k+PK8q+v4zKhcoQn5FK7+ncQ4hyiezXdKPG9WEPk
         w9EP1vC4vS0ynQ6cF1Fu0wIVR1eGPfIaVEWZ0pOy+P3wvCpE0Bc0jk2v3V4t7ibeXRNo
         +j+ExrC67G2lWG896ePYkWaOy5hMZ0rAeanl5V19/CpwGmJbu5nmEc6RiioerUSXUzml
         JqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743620725; x=1744225525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NawvRhJbCe+nOvQp4dfQ7SGUEZvzZ9Crvhv45c3qAgA=;
        b=L/GNZ2x1n96SoUvV8Ac3GmZe8TWWMwOgXDJby2+IG+zflRKZv06T44e1xkMjrqGE52
         MdziZpdcSuUYzZwfMcm3FE3cAngPg2xFzoZoLmEhvI/6aX113yXTfoKPv3mu8oN+kHe+
         syl+kdFDuaJ+4G60RrQYNeluf/HnMr+jrUu9FxwGT4AfCGSs9Gfm5DoDA2bLwK9b0cvT
         ktUIGA++JJepOg67S6wVNz7jbu1lGU90Bb5yZVwFc9yxhdXCrEeFCkeuF8ln8VZu/5Wh
         SozzO3QwhjN4yOQv4OzA6l4pkxK6zMX4ZSmMOSgco2SpJ++9aOMEhO6G7MLDWn+sIs41
         eXyg==
X-Forwarded-Encrypted: i=1; AJvYcCVBpDW0lU1H8ncS58qsdrRN6Assd9tEN3Uu95GuFd1nT5fMX4EulxPdATayL5OAMeM7I0mVQB4rJX/xSf4mR3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyD1DEJBxdqd1QYrzPw9Pv/ZMxHCxttJ+qIqc0zZ+R3T48/vBI
	yMMgvxkmV1dopEewT+y8yETQCdFwnvceoyPiAqLnDWYFnCJaAvrwUYHTJJ9WDYiMP1NKP6nBJ9m
	aflVjCctfTjGtc2mBqzvxFznguoGyulByRnDu
X-Gm-Gg: ASbGncsriZL87G/rlPNu3yV4eneighenv8pSY3yaIEr1GvAbZbxY7zOJLcuc93kI6oa
	tsAf4eACV9elH14WLRlvkmHr/12Jotu4wOUuHbIPhr4FxwY6ha32X6wV8oLBSmIJxTNFRS4D/+j
	4ygXmrJ8bxBRR/40AzS5HjlO58+ZdtEp3fEr6/aSLpomblccvHPBZusdUD
X-Google-Smtp-Source: AGHT+IE+6V/O1E03crfNrUW9VdhIk2ZpwNIs48NtJ+UG+GFect+hh5zptQm/psh3VIObZ14Z1RjRo7FP6TdMPY3C5TA=
X-Received: by 2002:a05:690c:6385:b0:6fb:9474:7b4f with SMTP id
 00721157ae682-703ce157a6bmr11804317b3.6.1743620724579; Wed, 02 Apr 2025
 12:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402160721.97596-1-kalyazin@amazon.com> <20250402160721.97596-2-kalyazin@amazon.com>
In-Reply-To: <20250402160721.97596-2-kalyazin@amazon.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 2 Apr 2025 12:04:48 -0700
X-Gm-Features: ATxdqUFxLEaaCcXEK8qWIhziTXJ419iYFObqPUE1oHuLjwZrdLmutDc4m9-xqaw
Message-ID: <CADrL8HW2bFsFqifTytY8+Fy1nH-arFZ2JqAKi44_4nMtkPksDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm: userfaultfd: generic continue for non hugetlbfs
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, ryan.roberts@arm.com, quic_eberman@quicinc.com, 
	peterx@redhat.com, graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk, 
	derekmn@amazon.com, nsaenz@amazon.es, xmarcalx@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 9:07=E2=80=AFAM Nikita Kalyazin <kalyazin@amazon.com=
> wrote:
>
> Remove shmem-specific code from UFFDIO_CONTINUE implementation for
> non-huge pages by calling vm_ops->fault().  A new VMF flag,
> FAULT_FLAG_NO_USERFAULT_MINOR, is introduced to avoid recursive call to
> handle_userfault().
>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  include/linux/mm_types.h |  3 +++
>  mm/hugetlb.c             |  2 +-
>  mm/shmem.c               |  3 ++-
>  mm/userfaultfd.c         | 25 ++++++++++++++++++-------
>  4 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 0234f14f2aa6..91a00f2cd565 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1429,6 +1429,8 @@ enum tlb_flush_reason {
>   * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cache=
d.
>   *                        We should only access orig_pte if this flag se=
t.
>   * @FAULT_FLAG_VMA_LOCK: The fault is handled under VMA lock.
> + * @FAULT_FLAG_NO_USERFAULT_MINOR: The fault handler must not call userf=
aultfd
> + *                                 minor handler.

Perhaps instead a flag that says to avoid the userfaultfd minor fault
handler, maybe we should have a flag to indicate that vm_ops->fault()
has been called by UFFDIO_CONTINUE. See below.

>   *
>   * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
>   * whether we would allow page faults to retry by specifying these two
> @@ -1467,6 +1469,7 @@ enum fault_flag {
>         FAULT_FLAG_UNSHARE =3D            1 << 10,
>         FAULT_FLAG_ORIG_PTE_VALID =3D     1 << 11,
>         FAULT_FLAG_VMA_LOCK =3D           1 << 12,
> +       FAULT_FLAG_NO_USERFAULT_MINOR =3D 1 << 13,
>  };
>
>  typedef unsigned int __bitwise zap_flags_t;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 97930d44d460..ba90d48144fc 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6228,7 +6228,7 @@ static vm_fault_t hugetlb_no_page(struct address_sp=
ace *mapping,
>                 }
>
>                 /* Check for page in userfault range. */
> -               if (userfaultfd_minor(vma)) {
> +               if (userfaultfd_minor(vma) && !(vmf->flags & FAULT_FLAG_N=
O_USERFAULT_MINOR)) {
>                         folio_unlock(folio);
>                         folio_put(folio);
>                         /* See comment in userfaultfd_missing() block abo=
ve */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 1ede0800e846..5e1911e39dec 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2467,7 +2467,8 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>         fault_mm =3D vma ? vma->vm_mm : NULL;
>
>         folio =3D filemap_get_entry(inode->i_mapping, index);
> -       if (folio && vma && userfaultfd_minor(vma)) {
> +       if (folio && vma && userfaultfd_minor(vma) &&
> +           !(vmf->flags & FAULT_FLAG_NO_USERFAULT_MINOR)) {
>                 if (!xa_is_value(folio))
>                         folio_put(folio);
>                 *fault_type =3D handle_userfault(vmf, VM_UFFD_MINOR);
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index d06453fa8aba..68a995216789 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -386,24 +386,35 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd=
,
>                                      unsigned long dst_addr,
>                                      uffd_flags_t flags)
>  {
> -       struct inode *inode =3D file_inode(dst_vma->vm_file);
> -       pgoff_t pgoff =3D linear_page_index(dst_vma, dst_addr);
>         struct folio *folio;
>         struct page *page;
>         int ret;
> +       struct vm_fault vmf =3D {
> +               .vma =3D dst_vma,
> +               .address =3D dst_addr,
> +               .flags =3D FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE |
> +                   FAULT_FLAG_NO_USERFAULT_MINOR,
> +               .pte =3D NULL,
> +               .page =3D NULL,
> +               .pgoff =3D linear_page_index(dst_vma, dst_addr),
> +       };
> +
> +       if (!dst_vma->vm_ops || !dst_vma->vm_ops->fault)
> +               return -EINVAL;
>
> -       ret =3D shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
> -       /* Our caller expects us to return -EFAULT if we failed to find f=
olio */
> -       if (ret =3D=3D -ENOENT)
> +       ret =3D dst_vma->vm_ops->fault(&vmf);

shmem_get_folio() was being called with SGP_NOALLOC, and now it is
being called with SGP_CACHE (by shmem_fault()). This will result in a
UAPI change: UFFDIO_CONTINUE for a VA without a page in the page cache
should result in EFAULT, but now the page will be allocated.
SGP_NOALLOC was carefully chosen[1], so I think a better way to do
this will be to:

1. Have a FAULT_FLAG_USERFAULT_CONTINUE (or something)
2. In shmem_fault(), if FAULT_FLAG_USERFAULT_CONTINUE, use SGP_NOALLOC
instead of SGP_CACHE (and make sure not to drop into
handle_userfault(), of course)

[1]: https://lore.kernel.org/linux-mm/20220610173812.1768919-1-axelrasmusse=
n@google.com/

> +       if (ret & VM_FAULT_ERROR) {
>                 ret =3D -EFAULT;
> -       if (ret)
>                 goto out;
> +       }
> +
> +       page =3D vmf.page;
> +       folio =3D page_folio(page);
>         if (!folio) {

What if ret =3D=3D VM_FAULT_RETRY? I think we should retry instead instead
of returning -EFAULT.

And I'm not sure how VM_FAULT_NOPAGE should be handled, like if we
need special logic for it or not.

>                 ret =3D -EFAULT;
>                 goto out;
>         }
>
> -       page =3D folio_file_page(folio, pgoff);
>         if (PageHWPoison(page)) {
>                 ret =3D -EIO;
>                 goto out_release;
> --
> 2.47.1
>

