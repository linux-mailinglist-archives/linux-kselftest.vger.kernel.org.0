Return-Path: <linux-kselftest+bounces-30032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA5A797A8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 23:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DE51886AB7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 21:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEADE1F418E;
	Wed,  2 Apr 2025 21:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBixc8EO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE0715DBC1
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Apr 2025 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629183; cv=none; b=fkY2NxOPIaLjxHvD2iDPWCCP8fs0BQ+bE0qrvH98MLDGCHnwoIn6MYbZ1CQCLLPdDmRmp8OnDajtybzVO7jd2EI6Jm/83NSM7ig8t4TPbC/OGujiNFEpbfqo3xTSLeKCOtnWwdavzsLDQTlilITsogZ2FbWtNopQ3utClr6n2gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629183; c=relaxed/simple;
	bh=WrSAroPteEkIfTPk5VG63Y9jqJZdMnOd06w/KS/3d54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIVlqBbA5PuevivnIgtPxtIwGwSldJDrUT4lvyzFKbR9NRKOPgedLI+m0MU/OSmbHuIODQmTwzEq16WUhjDbLYpzcyRyWWzdqpOnnT2nAgbXKzb2QRfNhgOtUnlXId7PqP4C8wPC1TJrQmF/578tzeESYVKAvfjGxbPjaRgoBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBixc8EO; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f74b78df93so4029727b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Apr 2025 14:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743629181; x=1744233981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkq7RDB6qUQkjmvNPDbUzRwwtYEXsO/0AHJxtOGmBfQ=;
        b=lBixc8EOGwUTg4GDYqiHmVzQuXDlNaL2SywjcPQ8PVeIRUjyhhVcsIJJTlCTprQ0x0
         6P/Vt780rkXLxz97gNQnIdxuYHtPQTHV7op4zV8snJM2x1J4D2K3lutYQFsXly9xDVTY
         OIwvr6+i1EPES1C+xokEVx3o4oEfR/DsXZNEDp27vz7Z/Bsxl9PCWLiJFsRILsAdxRCP
         Uz7zOhjLq0E4Nf5Hm1XVdkxYFtMn57HVQY6mXDD/1R5w3Q/jLQLLRjRDYWEJFZdgsSXM
         ot+Dd5OC8f+uwlArRxr3t5BexD1F4RJosqKlZgrV5cZ+unuCcQYgvjBWz5RlpgnB9Su3
         yx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743629181; x=1744233981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkq7RDB6qUQkjmvNPDbUzRwwtYEXsO/0AHJxtOGmBfQ=;
        b=tTS+inV/7lia3wPm1BTcCALNp+iEUEMiwVUKZZRa1PP6pPS+YOF3r2cx4sykmr5+GX
         GQaDGGs+oCDPmCG72MwzqSnAzGiJTB+A33DRUy9mQHWuM3GAcJ3VVvfjJI7vvddq4yBO
         RsE8Rhkaz6UMszz6sX3uNBGpInNV/Bm/3pWbGOHnc78cVjhRwmKqtwpLeK8lATyvLgwU
         UlRByEWlDmQFupPBHvy3if3obKsLmfmOYpQItFvaAF75dq3WhXrz4yt3p3KFGJ7KgKMi
         wXVGy5aVPn0rMm/0zdRNT0pXrCuYUozuusIpQquH4dgtQTk+R/B+XTsHq0ROW/Zd4Efg
         7pJA==
X-Forwarded-Encrypted: i=1; AJvYcCVrMSdpWkwOaZ98wUFNohrLhMmX+NpC2M8Ro0/6A1gThbAxVWOklwKxs+MpNKubyEIBXNOU/5tnQV3NWeLwN/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeM5VZ2wREGo/DThJ1mk6aVEHzfRlZFevXEhnEh+RDBFv3JEI1
	fMWt1hLNwjh0VMQyDDQe613xjrPc0AoCl1jlDkstekwZ3Bga07ibFFssKyKJl57XqYIIDzElFhe
	7c9dXdxPhFk89AuTgT0L9S+pFPzqJHBeC3AWWqIi/i00jyQI/cw==
X-Gm-Gg: ASbGncves/8Qtb/8BB2kTc8DG6nztl008puExhcnJjDP6DKXJpVRrVSakfRVPWeFYgI
	wNoSLZx/PMnJ4O8c03KodaYkemrHgwHzaYvPxL6+3gLs27vDN5JPUZ0GnusJcJL9VTgM9GQzosn
	Y2Cxy9VBek9CRPhp60KqLdr5NEx9RA+wlldplbBAuFV7BXErHtg7UXLYQ=
X-Google-Smtp-Source: AGHT+IHC9iQyimPIf9LK2ZxOiOmyeaERAe030mPiaTlyv077TSi4Ij2X2Zh68MYzFPFo7mJNC8RXC973zmIYLF4HpwM=
X-Received: by 2002:a05:690c:f0a:b0:702:d54:5794 with SMTP id
 00721157ae682-702573625aemr252565667b3.31.1743629180815; Wed, 02 Apr 2025
 14:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402160721.97596-1-kalyazin@amazon.com> <20250402160721.97596-4-kalyazin@amazon.com>
In-Reply-To: <20250402160721.97596-4-kalyazin@amazon.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 2 Apr 2025 14:25:45 -0700
X-Gm-Features: AQ5f1JpgHKJ4oBuxUfdSQZzG2qvYTZmYOUmQV1t1d9CLWvy8fODsNbzGuiQPDsA
Message-ID: <CADrL8HVADXDKUu4mn-dHb9ih=ZnuMWtKfqL2xFxKf2yff7RJvQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: userfaultfd: allow to register continue for guest_memfd
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, ryan.roberts@arm.com, quic_eberman@quicinc.com, 
	peterx@redhat.com, graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk, 
	derekmn@amazon.com, nsaenz@amazon.es, xmarcalx@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 9:08=E2=80=AFAM Nikita Kalyazin <kalyazin@amazon.com=
> wrote:
>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  include/linux/userfaultfd_k.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.=
h
> index 75342022d144..bc184edfbb85 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -212,6 +212,10 @@ static inline bool userfaultfd_armed(struct vm_area_=
struct *vma)
>         return vma->vm_flags & __VM_UFFD_FLAGS;
>  }
>
> +#ifdef CONFIG_KVM_PRIVATE_MEM
> +bool kvm_gmem_vma_is_gmem(struct vm_area_struct *vma);
> +#endif
> +
>  static inline bool vma_can_userfault(struct vm_area_struct *vma,
>                                      unsigned long vm_flags,
>                                      bool wp_async)
> @@ -222,7 +226,11 @@ static inline bool vma_can_userfault(struct vm_area_=
struct *vma,
>                 return false;
>
>         if ((vm_flags & VM_UFFD_MINOR) &&
> -           (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
> +           (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma))
> +#ifdef CONFIG_KVM_PRIVATE_MEM
> +            && !kvm_gmem_vma_is_gmem(vma)
> +#endif

Maybe a better way to do this is to add a vm_ops->can_userfault() or
something, so we could write something like this:

if (vma->vm_ops && !vma->vm_ops->can_userfault)
  return false;
if (vma->vm_ops && !vma->vm_ops->can_userfault(vm_flags))
  return false;

And shmem/hugetlbfs can advertise support for everything they already
support that way.

> +           )
>                 return false;
>
>         /*
> @@ -244,6 +252,9 @@ static inline bool vma_can_userfault(struct vm_area_s=
truct *vma,
>
>         /* By default, allow any of anon|shmem|hugetlb */
>         return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
> +#ifdef CONFIG_KVM_PRIVATE_MEM
> +           kvm_gmem_vma_is_gmem(vma) ||
> +#endif
>             vma_is_shmem(vma);
>  }
>
> --
> 2.47.1
>

