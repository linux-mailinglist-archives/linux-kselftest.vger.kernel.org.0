Return-Path: <linux-kselftest+bounces-44368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA194C1DFB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 02:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37D3034C08A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 01:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D5F23D28C;
	Thu, 30 Oct 2025 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OiDXEoao"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70AA23A9B0
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786370; cv=none; b=A4qOBKrukhWRGfnD/LUrsn62//B0qdDiXrWbFeDACqCstgH5Z0Cz3p5+60cuBFuJik/mWVEaCob9RkrmW24DM0HdV7T5g5G2FZEkq8dJnYHoz1L9vXCBhSrLRZKkNEiiyFOnF9Ug7DswfcV2GI6zulPOhg9eLtRgJeHD2GQjHmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786370; c=relaxed/simple;
	bh=adiu93DlzwcW02RQQQEztmqHCSRUMOCuSZmyc7Gnwl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzpFTcFKQwPIIJSyKady7m8I0SIbScPjkLS99yh45xHW8GorEYm5OoZYigRBW+blS331a/2HqgXcqVf2Nx86uPbR7MxRY/m4I7AwumTc+tVQ4iPxi+R1UmtSt+pORwZsjsk8dtxzVE9iNqBojenRli8/ynfV+HujfoUEDS+dbGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OiDXEoao; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ecfafb92bcso93251cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 18:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761786366; x=1762391166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeisVXfwZ0KrQFCLeQpidsEhsQ07SALEwA1Kf0DOiTM=;
        b=OiDXEoaonjoGJBDJoWeeDFCs+MtiNfuycoVOgA9ir0+Vk822TS+TQuK0Hrxje4EJ8q
         mumRov7VBe2W2hNJmQ+kqdQUsoxPzFbTVTD5Q/N+mNb6cpJeyqXwjOndqvLv7z7lScOO
         FJg281QPUdQ0+Jb7UHqnrK6xoZZhulgXfR6eowbNDyJqmEHgSt9EsKM9Rsix8mjyhIHn
         yetMKF9PxhvR6s8r5tfuPepy/nxaUJhj28Up6ocGDin1GYYHywV/HQVc5gvmlUItqNz/
         fs2ILuyvNr5s7K3XfjJjuyPqm8mztFLDwz3hpW3EmShg2XF0OeYNMo6VTBzQTc6JBf8x
         bMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761786366; x=1762391166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeisVXfwZ0KrQFCLeQpidsEhsQ07SALEwA1Kf0DOiTM=;
        b=kpj8ruIwBDviVBr3QtzEwyUcoU7tAt369y/fILfa1hsNGZFDwhJ7lHw3ijNw4OAXEY
         LNd11eIicPEVFSjid/RPkzr5q1P00iPnXLZJcneYFgx1wqaTX9JmHxWWvvYzy6yEpc76
         LptImuHTr3ak5hkbRuAJ7D6Nt2lS5u6g3nkY8iNkSlIlvC8yti1zfYlvX7f5lJSlxb2H
         cFkaJu8gpHhwTP26y2TBQE01mJHz6sgL1FRMNtdXBzgCx7HOsxIpgsA+/a+9M3wYJs3E
         NUtnI1JuQJnSuYfybnN0ltAc6q1FHry3bnn8TC5clKWfBZnTwJdl6h1s+/EDSYgaaYCY
         CDwg==
X-Forwarded-Encrypted: i=1; AJvYcCWq35RLRxMJ7taMCoyxbpvCl/UzqeftL6bdBbMsJrDDs6t83biLSEbi/JJhsU9kE2AeewFeXYK2Q5Kq1XnVRlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3nygxEmSZjSoF+wLigA1bGHG0mAnP/+96cWRcb+vgDu1p+9xn
	ZU4+aD1UPVk26W/YEdIGVxihPpX5yujSEzdWF0WD6fTvSndB+s4WhTBY1jhoaLVdl665Vy9HqTv
	o6uCJYLgldBkLa9RiqYBNugULAcpxMBMtDB5VwdxE
X-Gm-Gg: ASbGncuZ6FHgg/4LLsFJbEJ6G/toaPNJMC9UPHruMEEatbxql1Lpdpl5oIKVXiTkY/S
	cO14Dmt/69Fd6Ij/wREeiPvJ8UH27nwhdsusL7drIaYJroCYXk+eSiHHFlmfySg+Olcp9HedIi7
	5LF9OqlMMtOMqlKo2XJuq3R/4cXPt+oipAwVpeT8YCs0JuPrMMRx57a/I5EwR6a8cbBI78pTr4N
	7u9estVpu1GR6VOBYKOsB/lNHNOoqREID6vlNqdls4EUx6gjgcNksHjxLc=
X-Google-Smtp-Source: AGHT+IEXE/t7QfqvUm8ZaTuQf2esMJpzDPElyDqBGV0RGdjV360thSADyS4N9hyRQjOYV3uhrbmzYlXY5QHiRxHN85o=
X-Received: by 2002:ac8:59cd:0:b0:4e8:85ac:f7a7 with SMTP id
 d75a77b69052e-4ed23bf1436mr1717491cf.9.1761786365282; Wed, 29 Oct 2025
 18:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com> <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Oct 2025 18:05:54 -0700
X-Gm-Features: AWmQ_blocebJr4y0y6DBwQJ-I85ZwTlE3oPMzhX8CLpjz_qVxCW5kze5g7B-HN8
Message-ID: <CAJuCfpEefC1nAQ6TgKcq7osX4Zyr_dLhiR5W0So=CReed+LSuw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: introduce VM_MAYBE_GUARD and make visible for
 guard regions
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:51=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Currently, if a user needs to determine if guard regions are present in a
> range, they have to scan all VMAs (or have knowledge of which ones might
> have guard regions).
>
> Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> operation at a virtual address level.
>
> This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> that guard regions exist in ranges.
>
> This patch remedies the situation by establishing a new VMA flag,
> VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> uncertain because we cannot reasonably determine whether a
> MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> additionally VMAs may change across merge/split).

nit: I know I suck at naming but I think VM_MAY_HAVE_GUARDS would
better represent the meaning.

>
> We utilise 0x800 for this flag which makes it available to 32-bit
> architectures also, a flag that was previously used by VM_DENYWRITE, whic=
h
> was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> bee reused yet.

s/bee/been
but I'm not even sure the above paragraph has to be included in the
changelog. It's a technical detail IMHO.

>
> The MADV_GUARD_INSTALL madvise() operation now must take an mmap write
> lock (and also VMA write lock) whereas previously it did not, but this
> seems a reasonable overhead.

I guess this is because it is modifying vm_flags now?

>
> We also update the smaps logic and documentation to identify these VMAs.
>
> Another major use of this functionality is that we can use it to identify
> that we ought to copy page tables on fork.
>
> For anonymous mappings this is inherent, however since commit f807123d578=
d
>  ("mm: allow guard regions in file-backed and read-only mappings") which
>  allowed file-backed guard regions, we have unfortunately had to enforce
> this behaviour by settings vma->anon_vma to force page table copying.
>
> The existence of this flag removes the need for this, so we simply update
> vma_needs_copy() to check for this flag instead.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Overall, makes sense to me and I think we could use it.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

It would be nice to have a way for userspace to reset this flag if it
confirms that the VMA does not really have any guards (using say
PAGEMAP_SCAN) but I think such an API can be abused.

> ---
>  Documentation/filesystems/proc.rst |  1 +
>  fs/proc/task_mmu.c                 |  1 +
>  include/linux/mm.h                 |  1 +
>  include/trace/events/mmflags.h     |  1 +
>  mm/madvise.c                       | 22 ++++++++++++++--------
>  mm/memory.c                        |  4 ++++
>  tools/testing/vma/vma_internal.h   |  1 +
>  7 files changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
> index 0b86a8022fa1..b8a423ca590a 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -591,6 +591,7 @@ encoded manner. The codes are the following:
>      sl    sealed
>      lf    lock on fault pages
>      dp    always lazily freeable mapping
> +    gu    maybe contains guard regions (if not set, definitely doesn't)
>      =3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  Note that there is no guarantee that every flag and associated mnemonic =
will
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index fc35a0543f01..db16ed91c269 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1146,6 +1146,7 @@ static void show_smap_vma_flags(struct seq_file *m,=
 struct vm_area_struct *vma)
>                 [ilog2(VM_MAYSHARE)]    =3D "ms",
>                 [ilog2(VM_GROWSDOWN)]   =3D "gd",
>                 [ilog2(VM_PFNMAP)]      =3D "pf",
> +               [ilog2(VM_MAYBE_GUARD)] =3D "gu",
>                 [ilog2(VM_LOCKED)]      =3D "lo",
>                 [ilog2(VM_IO)]          =3D "io",
>                 [ilog2(VM_SEQ_READ)]    =3D "sr",
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index aada935c4950..f963afa1b9de 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -296,6 +296,7 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_UFFD_MISSING        0
>  #endif /* CONFIG_MMU */
>  #define VM_PFNMAP      0x00000400      /* Page-ranges managed without "s=
truct page", just pure PFN */
> +#define VM_MAYBE_GUARD 0x00000800      /* The VMA maybe contains guard r=
egions. */
>  #define VM_UFFD_WP     0x00001000      /* wrprotect pages tracking */
>
>  #define VM_LOCKED      0x00002000
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflag=
s.h
> index aa441f593e9a..a6e5a44c9b42 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -213,6 +213,7 @@ IF_HAVE_PG_ARCH_3(arch_3)
>         {VM_UFFD_MISSING,               "uffd_missing"  },              \
>  IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,      "uffd_minor"    )               \
>         {VM_PFNMAP,                     "pfnmap"        },              \
> +       {VM_MAYBE_GUARD,                "maybe_guard"   },              \
>         {VM_UFFD_WP,                    "uffd_wp"       },              \
>         {VM_LOCKED,                     "locked"        },              \
>         {VM_IO,                         "io"            },              \
> diff --git a/mm/madvise.c b/mm/madvise.c
> index fb1c86e630b6..216ae6ed344e 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1141,15 +1141,22 @@ static long madvise_guard_install(struct madvise_=
behavior *madv_behavior)
>                 return -EINVAL;
>
>         /*
> -        * If we install guard markers, then the range is no longer
> -        * empty from a page table perspective and therefore it's
> -        * appropriate to have an anon_vma.
> +        * It would be confusing for anonymous mappings to have page tabl=
e
> +        * entries but no anon_vma established, so ensure that it is.
> +        */
> +       if (vma_is_anonymous(vma))
> +               anon_vma_prepare(vma);
> +
> +       /*
> +        * Indicate that the VMA may contain guard regions, making it vis=
ible to
> +        * the user that a VMA may contain these, narrowing down the rang=
e which
> +        * must be scanned in order to detect them.
>          *
> -        * This ensures that on fork, we copy page tables correctly.
> +        * This additionally causes page tables to be copied on fork rega=
rdless
> +        * of whether the VMA is anonymous or not, correctly preserving t=
he
> +        * guard region page table entries.
>          */
> -       err =3D anon_vma_prepare(vma);
> -       if (err)
> -               return err;
> +       vm_flags_set(vma, VM_MAYBE_GUARD);
>
>         /*
>          * Optimistically try to install the guard marker pages first. If=
 any
> @@ -1709,7 +1716,6 @@ static enum madvise_lock_mode get_lock_mode(struct =
madvise_behavior *madv_behavi
>         case MADV_POPULATE_READ:
>         case MADV_POPULATE_WRITE:
>         case MADV_COLLAPSE:
> -       case MADV_GUARD_INSTALL:
>         case MADV_GUARD_REMOVE:
>                 return MADVISE_MMAP_READ_LOCK;
>         case MADV_DONTNEED:
> diff --git a/mm/memory.c b/mm/memory.c
> index 4c3a7e09a159..a2c79ee43d68 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1478,6 +1478,10 @@ vma_needs_copy(struct vm_area_struct *dst_vma, str=
uct vm_area_struct *src_vma)
>         if (src_vma->anon_vma)
>                 return true;
>
> +       /* Guard regions have momdified page tables that require copying.=
 */
> +       if (src_vma->vm_flags & VM_MAYBE_GUARD)
> +               return true;
> +
>         /*
>          * Don't copy ptes where a page fault will fill them correctly.  =
Fork
>          * becomes much lighter when there are big shared or private read=
only
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_int=
ernal.h
> index d873667704e8..e40c93edc5a7 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -56,6 +56,7 @@ extern unsigned long dac_mmap_min_addr;
>  #define VM_MAYEXEC     0x00000040
>  #define VM_GROWSDOWN   0x00000100
>  #define VM_PFNMAP      0x00000400
> +#define VM_MAYBE_GUARD 0x00000800
>  #define VM_LOCKED      0x00002000
>  #define VM_IO           0x00004000
>  #define VM_SEQ_READ    0x00008000      /* App will access data sequentia=
lly */
> --
> 2.51.0
>

