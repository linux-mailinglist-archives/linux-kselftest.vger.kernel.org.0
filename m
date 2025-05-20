Return-Path: <linux-kselftest+bounces-33365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371F4ABD0B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 09:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6D13A516C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 07:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B16F25DAFF;
	Tue, 20 May 2025 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO8c8ad3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DBCEEC8;
	Tue, 20 May 2025 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747727041; cv=none; b=KYu86dcYrMcsOnZqckU4+MDe7QfiJVQXGY5Tardm+H7K66q7GeEsPoVK3pNHq3Rzlgef9JlC5w7MH1js4TfdCBfugX3vnG3VldRxodN7Sl8ppFWlvclgc2oCKxD0UW87crXOZReu7bKqEJD7nJZLQ5/jsODX8HxmJX+/MHG2r/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747727041; c=relaxed/simple;
	bh=zIL2YBPH1fTre1k7ZCpC3okZ8sjc/bzzUxupO/yQ9jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABdsd7w7kmpYkDlSyEtoIv6gOrli5TST+e8hdkR1bfEB/yN7VZc8Hr8IogWI5mZ/TLjiYPdO75a/ZBv0ZeNWo9CgbFPqTHuuyVIsmDtID+niWIULnvaUyIg+02GnffRKpBKr1bkNgWsto7UW8gGLgv45E9blh/wiszFUHcwRtt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mO8c8ad3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c46611b6so3178993b3a.1;
        Tue, 20 May 2025 00:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747727039; x=1748331839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uo8wrvNhdGkpDaupALM2V4X4G0GERtYOC9S6Rbd7JE=;
        b=mO8c8ad3TQkXvGNdx4kaZSrIM4zaUAN+RJUY3jv/XzJBUNQym7YOqpAsO0HGgHAzjb
         1BryM9JvF2h5sVJ8NSNIbWmds/aa6W04EwMKE1TceIPM/Jt11Twe1e1l1j0qA418Y2w5
         VUQ8DrXtFxKwfvA9Tsb4pDilvMsq+z2ioRTTmkKg+ZgIxZZ3bO0bpsLFYE6e1jIZcrB4
         jA+EQST7BLyKE2VzfB9LMv75iikS4X/uUdwoUeIr5r5u7J+hgwO2O4yIurUfqWl/d9bf
         zruCyKSwRnKxsh5s6aAA2sul6iRYDd5mbxTRUsiZ+WLFzMvSsQOiu+d1qGSFYF98rfl+
         8EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747727039; x=1748331839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uo8wrvNhdGkpDaupALM2V4X4G0GERtYOC9S6Rbd7JE=;
        b=OM2oc2J7Gl6k4OY9BH2nigp1zWPlGsN9kAyUBogkYCF3ZuldU9DLN+lnJF1DRbG3Kq
         iOjwD1DB9VA94b6BKDkvULPs0+F4fazg8wcRFKm5svluWL7X01fwBDfkSQ8v9wX6voJI
         ZmrWkDBo3nGrheczSjhxj51srBYeoT9dpa5TieYLxbVwq3i6ZMVJ5W+0HoRhkHOhPk5+
         Oyp8w9Cg/aWVgdnlhewPzv372oYMP5vPY/+agg63UmrsnzjZedCt3p5nlH0imIUX+NQA
         MxUwmz+PUOA2o7hhplbs3uJw6O1QWMlprXuhkqJlVTrgnkC32KilfnXiApIJi+qvNQYK
         lMUg==
X-Forwarded-Encrypted: i=1; AJvYcCVJQG98KYU6Vrp5MUXn/GOjifIPL2wkeVB9KIU04477razE5VI3ty8x2VkpDa86teY7GZFWQU0NhRizvhHLU2gw@vger.kernel.org, AJvYcCVbaoj3Wz/tHxBCbC+2eEfYpCP7SpUgkoMNwvIx4QYRTnlhhNRizooAs3NycVNqEdwXeBoMZTKOu/I=@vger.kernel.org, AJvYcCVzYnmJ/AenULUd0KqcZ1HUjT/3BpnDccQ16I6VjCYPXTF0KJt6FknrzJkLR2kDnNhaqrxDzRpg1HenY+Ah@vger.kernel.org
X-Gm-Message-State: AOJu0YxCoCi9WBdL6B8iBDO0gVaQiu/oEHRs20zyriB4BdLXfar60Dsy
	6S4FRmLyekTUJ6PbAdpazu8n6d4I1BMsYrDPp5wGrPRfXpJTc44eYr+0xPlpd25d6Az7KusVNQn
	KlJrFUqOe66x4FXb1lP3Z2Y/KJqzVjxiQxfiFYM8=
X-Gm-Gg: ASbGncvSlZuoEzr0oIwwfu/2/lWnIqj1XUyuVNIoUJhzouWkVaO0QSZHWCcX1nAepbI
	wLY7OSyrDW4IdM+9Wv5OFrrgCC6zeHYJfZDStzV4xDKLa+ZlLpyeUDqRsxUIBoiXbIP8c0LYemG
	tTdszUdIgDzEaDb3zVu1plqODxSwS3ezp2Og==
X-Google-Smtp-Source: AGHT+IH2XeVratNvJ8FEJrrphJj/JDteq0tJv39Wdwj//5c4Z8WnAee6xYifV9WTkK9RBrjweCf0CdsRboWOvSrgV9Y=
X-Received: by 2002:ad4:5caa:0:b0:6f8:9a8c:9d83 with SMTP id
 6a1803df08f44-6f8b2d0d149mr244508426d6.35.1747727028940; Tue, 20 May 2025
 00:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515033857.132535-1-npache@redhat.com> <20250515033857.132535-2-npache@redhat.com>
In-Reply-To: <20250515033857.132535-2-npache@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 20 May 2025 15:43:12 +0800
X-Gm-Features: AX0GCFvt6zLLvpZVET4ZwVYJYj9_BSwEJPuE1M1fe9g1tsw5I4FK7vP9A1HV5ug
Message-ID: <CALOAHbCkhakdoD=HtM7=XwkHvsWu5BA6dLVofO7oFY_Os168uw@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mm: defer THP insertion to khugepaged
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	rientjes@google.com, hannes@cmpxchg.org, lorenzo.stoakes@oracle.com, 
	rdunlap@infradead.org, mhocko@suse.com, Liam.Howlett@oracle.com, 
	zokeefe@google.com, surenb@google.com, jglisse@google.com, cl@gentwo.org, 
	jack@suse.cz, dave.hansen@linux.intel.com, will@kernel.org, tiwai@suse.de, 
	catalin.marinas@arm.com, anshuman.khandual@arm.com, dev.jain@arm.com, 
	raquini@redhat.com, aarcange@redhat.com, kirill.shutemov@linux.intel.com, 
	yang@os.amperecomputing.com, thomas.hellstrom@linux.intel.com, 
	vishal.moola@gmail.com, sunnanyong@huawei.com, usamaarif642@gmail.com, 
	wangkefeng.wang@huawei.com, ziy@nvidia.com, shuah@kernel.org, 
	peterx@redhat.com, willy@infradead.org, ryan.roberts@arm.com, 
	baolin.wang@linux.alibaba.com, baohua@kernel.org, david@redhat.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	corbet@lwn.net, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 12:39=E2=80=AFPM Nico Pache <npache@redhat.com> wro=
te:
>
> setting /transparent_hugepages/enabled=3Dalways allows applications
> to benefit from THPs without having to madvise. However, the page fault
> handler takes very few considerations to decide weather or not to actuall=
y
> use a THP. This can lead to a lot of wasted memory. khugepaged only
> operates on memory that was either allocated with enabled=3Dalways or
> MADV_HUGEPAGE.
>
> Introduce the ability to set enabled=3Ddefer, which will prevent THPs fro=
m
> being allocated by the page fault handler unless madvise is set,
> leaving it up to khugepaged to decide which allocations will collapse to =
a
> THP. This should allow applications to benefits from THPs, while curbing
> some of the memory waste.
>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Co-developed-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  include/linux/huge_mm.h | 15 +++++++++++++--
>  mm/huge_memory.c        | 31 +++++++++++++++++++++++++++----
>  2 files changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index e3d15c737008..02038e3db829 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -48,6 +48,7 @@ enum transparent_hugepage_flag {
>         TRANSPARENT_HUGEPAGE_UNSUPPORTED,
>         TRANSPARENT_HUGEPAGE_FLAG,
>         TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
> +       TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG,
>         TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
>         TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
>         TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG,
> @@ -186,6 +187,7 @@ static inline bool hugepage_global_enabled(void)
>  {
>         return transparent_hugepage_flags &
>                         ((1<<TRANSPARENT_HUGEPAGE_FLAG) |
> +                       (1<<TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG) |
>                         (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG));
>  }
>
> @@ -195,6 +197,12 @@ static inline bool hugepage_global_always(void)
>                         (1<<TRANSPARENT_HUGEPAGE_FLAG);
>  }
>
> +static inline bool hugepage_global_defer(void)
> +{
> +       return transparent_hugepage_flags &
> +                       (1<<TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG);
> +}
> +
>  static inline int highest_order(unsigned long orders)
>  {
>         return fls_long(orders) - 1;
> @@ -291,13 +299,16 @@ unsigned long thp_vma_allowable_orders(struct vm_ar=
ea_struct *vma,
>                                        unsigned long tva_flags,
>                                        unsigned long orders)
>  {
> +       if ((tva_flags & TVA_IN_PF) && hugepage_global_defer() &&
> +                       !(vm_flags & VM_HUGEPAGE))
> +               return 0;
> +
>         /* Optimization to check if required orders are enabled early. */
>         if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
>                 unsigned long mask =3D READ_ONCE(huge_anon_orders_always)=
;
> -
>                 if (vm_flags & VM_HUGEPAGE)
>                         mask |=3D READ_ONCE(huge_anon_orders_madvise);
> -               if (hugepage_global_always() ||
> +               if (hugepage_global_always() || hugepage_global_defer() |=
|
>                     ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled(=
)))
>                         mask |=3D READ_ONCE(huge_anon_orders_inherit);
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 700988a0d5cf..ce0ee74753af 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -297,12 +297,15 @@ static ssize_t enabled_show(struct kobject *kobj,
>         const char *output;
>
>         if (test_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_fla=
gs))
> -               output =3D "[always] madvise never";
> +               output =3D "[always] madvise defer never";

a small nit: alphabetical ordering might improve readability here.

--=20
Regards
Yafang

