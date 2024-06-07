Return-Path: <linux-kselftest+bounces-11455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DC4900E05
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 00:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C91B2190E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 22:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8250C155353;
	Fri,  7 Jun 2024 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Go7BKEZV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118C145341
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Jun 2024 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717799191; cv=none; b=uQQNaXX4ooujBJJan1IX0/TgMwdUfVdagoSfo0fVZavPX8Yk4uOg/XD35Cm9GXy/0h1tKb14ANx3kTn0qj/w6agrrV1Ed3pxmuPoF7TdeU7Cxdm0u3gWq48qSWVjn47dFzmZC7QJszpwfBJnLgO8oYQyXBcEW/2ntFq/gkfa5fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717799191; c=relaxed/simple;
	bh=8auu4zOjxSnRgN+53PqBdb3ZnnLuj5/n6TY1C6BVbhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1TdK+JuRScJV1yNKhiaRu/E65ZBIVuRjuxHnLoMFStul6cQZMeFnj7ZGTM0w0kAzA4k5ZqcwlhTuI9WlWY7UQ8QfZZwEY1LzdLVrT04AxritLn5RCxZkwTaHEQu06gQAxn8EmwOAa/Ezz0D+KXeDYh5wrGJPUHDwzIKQsP6q4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Go7BKEZV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35ef1e928c9so3011659f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2024 15:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717799188; x=1718403988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJ3OQQW+eHyCePm6E/J3FwFPQTGkY7d0el0lDRbI3xQ=;
        b=Go7BKEZVPwr8B8/aMdgxQEt5PUJ6nmXMA0W8w8eusVxLPoqT60kBx9q54ZMrWrKqfh
         2VrDV/TptjLTEn71R6a/NHXW2tJHDsdvJixoLQgX+7ozmsPp/1+R1X+GsgB/Ir/Hqkmg
         s7mcJ4sc6aaZ1HWzcToVzE3lirNG0RSTmSvCbNb/V4uIgWfaWc6cR1SGBeZSywsfH2/H
         UbimdRrAeowZUdW2m1pT3WbAKMrf4b+jlz2KNldsUzabamSV7iLYlACnWzV3PIUQe6ZU
         qTLBRWH7+CR9Jw4gVK1FMYJajcFcq4ZLgZL17AC61riwpH69YLHbPCv7wqLI1oJjP3Mc
         fMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717799188; x=1718403988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJ3OQQW+eHyCePm6E/J3FwFPQTGkY7d0el0lDRbI3xQ=;
        b=WNsjzeH6oxPxvlyJas4XI7HUtdG0/SZBo4QcdMbKg0e5pFeMwAbGBnF6oxMBLP8Ipm
         Kb9paNvmQgHJ00PaIXxImn2h04a1iH0zh/v66V5mV9AP2Qn30bmayD9ro9H1rshLwOM6
         1Ilm0NYpZsWjJEoKEMpIlC29rr4vniLbkshTpKW1yKNSG7Dg9/LG+U7rNUJi8rUtUhzU
         ySEulE2SV7+I9YhPUtOwlEAcuOnKmFuVmSrHvcXPAucY1FyYBLxiXf7Dzpv/aDDR2tgA
         h8aUWKze1Rh09GUpccwzFvcqHRLA/s6vGKndwvUocqpKLO52quHxEJ0Mma3eQ4xPvnpm
         hSnw==
X-Forwarded-Encrypted: i=1; AJvYcCWdrDFrh9stTEz3f6/R/Eyrja7k6gtUSXMu/OJ2en+ct/luqRh2Atd2Va4oKygS/jj3EDpvit+8pWvGbPMkmDx7P0fwCi7h8Rj2jy5PzBht
X-Gm-Message-State: AOJu0YznYQv4kEFMnaKn6ry9ZIOcoXSmXyA+2oBBxYyznj+PGAXV8ylf
	puY0yJQaWWiBSkHsiZnB+x0eVsM14RORcfT4TWVfv5h48Bjoi8Lq5MXA+EyToxAaptx/9bQAM7p
	x2i9KpzDEoddVdVmYV4Rw1S0VddBbz+Zbx4aE
X-Google-Smtp-Source: AGHT+IG4fiWf2whywWOKYTELPDvRzqNwtYRFuyl5M1j+OGyfWA/hmL+B/m3tm3AJoZasegTNzzDHy4gCozES5Oz25vM=
X-Received: by 2002:a5d:5744:0:b0:35f:e4d:f3dc with SMTP id
 ffacd0b85a97d-35f0e4df6e3mr1309708f8f.9.1717799187682; Fri, 07 Jun 2024
 15:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531213439.2958891-1-jiaqiyan@google.com> <20240531213439.2958891-2-jiaqiyan@google.com>
In-Reply-To: <20240531213439.2958891-2-jiaqiyan@google.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 7 Jun 2024 15:26:16 -0700
Message-ID: <CACw3F50+ZhetCbeym3fDzKQr8d+HY7WXNRYUD5jh4_gTUWWEig@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mm/memory-failure: userspace controls
 soft-offlining hugetlb pages
To: naoya.horiguchi@nec.com, muchun.song@linux.dev, linmiaohe@huawei.com
Cc: akpm@linux-foundation.org, shuah@kernel.org, corbet@lwn.net, 
	osalvador@suse.de, rientjes@google.com, duenwen@google.com, fvdl@google.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jane Chu <jane.chu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+CC Jane.

On Fri, May 31, 2024 at 2:34=E2=80=AFPM Jiaqi Yan <jiaqiyan@google.com> wro=
te:
>
> Correctable memory errors are very common on servers with large
> amount of memory, and are corrected by ECC. Soft offline is kernel's
> additional recovery handling for memory pages having (excessive)
> corrected memory errors. Impacted page is migrated to a healthy page
> if mapped/inuse; the original page is discarded for any future use.
>
> The actual policy on whether (and when) to soft offline should be
> maintained by userspace, especially in case of HugeTLB hugepages.
> Soft-offline dissolves a hugepage, either in-use or free, into
> chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
> If userspace has not acknowledged such behavior, it may be surprised
> when later mmap hugepages MAP_FAILED due to lack of hugepages.
> In addition, discarding the entire 1G memory page only because of
> corrected memory errors sounds very costly and kernel better not
> doing under the hood. But today there are at least 2 such cases:
> 1. GHES driver sees both GHES_SEV_CORRECTED and
>    CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
> 2. RAS Correctable Errors Collector counts correctable errors per
>    PFN and when the counter for a PFN reaches threshold
> In both cases, userspace has no control of the soft offline performed
> by kernel's memory failure recovery.
>
> This commit gives userspace the control of soft-offlining HugeTLB
> pages: kernel only soft offlines hugepage if userspace has opt-ed in
> in for that specific hugepage size. The interface to userspace is a
> new sysfs entry called softoffline_corrected_errors under the
> /sys/kernel/mm/hugepages/hugepages-${size}kB directory:
> * When softoffline_corrected_errors=3D0, skip soft offlining for all
>   hugepages of size ${size}kB.
> * When softoffline_corrected_errors=3D1, soft offline as before this
>   patch series.
>
> So the granularity of the control is per hugepage size, and is kept
> in corresponding hstate. By default softoffline_corrected_errors is
> 1 to preserve existing behavior in kernel.
>
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  include/linux/hugetlb.h | 17 +++++++++++++++++
>  mm/hugetlb.c            | 34 ++++++++++++++++++++++++++++++++++
>  mm/memory-failure.c     |  7 +++++++
>  3 files changed, 58 insertions(+)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 2b3c3a404769..55f9e9593cce 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -685,6 +685,7 @@ struct hstate {
>         int next_nid_to_free;
>         unsigned int order;
>         unsigned int demote_order;
> +       unsigned int softoffline_corrected_errors;
>         unsigned long mask;
>         unsigned long max_huge_pages;
>         unsigned long nr_huge_pages;
> @@ -1029,6 +1030,16 @@ void hugetlb_unregister_node(struct node *node);
>   */
>  bool is_raw_hwpoison_page_in_hugepage(struct page *page);
>
> +/*
> + * For certain hugepage size, when a hugepage has corrected memory error=
(s):
> + * - Return 0 if userspace wants to disable soft offlining the hugepage.
> + * - Return > 0 if userspace allows soft offlining the hugepage.
> + */
> +static inline int hugetlb_softoffline_corrected_errors(struct folio *fol=
io)
> +{
> +       return folio_hstate(folio)->softoffline_corrected_errors;
> +}
> +
>  #else  /* CONFIG_HUGETLB_PAGE */
>  struct hstate {};
>
> @@ -1226,6 +1237,12 @@ static inline bool hugetlbfs_pagecache_present(
>  {
>         return false;
>  }
> +
> +static inline int hugetlb_softoffline_corrected_errors(struct folio *fol=
io)
> +{
> +       return 1;
> +}
> +
>  #endif /* CONFIG_HUGETLB_PAGE */
>
>  static inline spinlock_t *huge_pte_lock(struct hstate *h,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6be78e7d4f6e..a184e28ce592 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4325,6 +4325,38 @@ static ssize_t demote_size_store(struct kobject *k=
obj,
>  }
>  HSTATE_ATTR(demote_size);
>
> +static ssize_t softoffline_corrected_errors_show(struct kobject *kobj,
> +                                                struct kobj_attribute *a=
ttr,
> +                                                char *buf)
> +{
> +       struct hstate *h =3D kobj_to_hstate(kobj, NULL);
> +
> +       return sysfs_emit(buf, "%d\n", h->softoffline_corrected_errors);
> +}
> +
> +static ssize_t softoffline_corrected_errors_store(struct kobject *kobj,
> +                                                 struct kobj_attribute *=
attr,
> +                                                 const char *buf,
> +                                                 size_t count)
> +{
> +       int err;
> +       unsigned long input;
> +       struct hstate *h =3D kobj_to_hstate(kobj, NULL);
> +
> +       err =3D kstrtoul(buf, 10, &input);
> +       if (err)
> +               return err;
> +
> +       /* softoffline_corrected_errors is either 0 or 1. */
> +       if (input > 1)
> +               return -EINVAL;
> +
> +       h->softoffline_corrected_errors =3D input;
> +
> +       return count;
> +}
> +HSTATE_ATTR(softoffline_corrected_errors);
> +
>  static struct attribute *hstate_attrs[] =3D {
>         &nr_hugepages_attr.attr,
>         &nr_overcommit_hugepages_attr.attr,
> @@ -4334,6 +4366,7 @@ static struct attribute *hstate_attrs[] =3D {
>  #ifdef CONFIG_NUMA
>         &nr_hugepages_mempolicy_attr.attr,
>  #endif
> +       &softoffline_corrected_errors_attr.attr,
>         NULL,
>  };
>
> @@ -4655,6 +4688,7 @@ void __init hugetlb_add_hstate(unsigned int order)
>         h =3D &hstates[hugetlb_max_hstate++];
>         mutex_init(&h->resize_lock);
>         h->order =3D order;
> +       h->softoffline_corrected_errors =3D 1;
>         h->mask =3D ~(huge_page_size(h) - 1);
>         for (i =3D 0; i < MAX_NUMNODES; ++i)
>                 INIT_LIST_HEAD(&h->hugepage_freelists[i]);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 16ada4fb02b7..7094fc4c62e2 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2776,6 +2776,13 @@ int soft_offline_page(unsigned long pfn, int flags=
)
>                 return -EIO;
>         }
>
> +       if (PageHuge(page) &&
> +           !hugetlb_softoffline_corrected_errors(page_folio(page))) {
> +               pr_info("soft offline: %#lx: hugetlb page is ignored\n", =
pfn);
> +               put_ref_page(pfn, flags);
> +               return -EINVAL;
> +       }
> +
>         mutex_lock(&mf_mutex);
>
>         if (PageHWPoison(page)) {
> --
> 2.45.1.288.g0e0cd299f1-goog
>

