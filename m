Return-Path: <linux-kselftest+bounces-32110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0712AA666B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 00:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BD41BC6922
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 22:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F90253326;
	Thu,  1 May 2025 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rzr9WJ31"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59EC2517BE
	for <linux-kselftest@vger.kernel.org>; Thu,  1 May 2025 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140045; cv=none; b=rjOg3ttUy8kIHK58Zs4kFlGU8sZB/tw9TUz8uJPoR19Cs/uTEkIkDmJhI52qqOiMEZyQ4IU/LIKPFmAjVUhqt60SPpKv6h1goy9HwXOhbfeQHu6iTL/GkklseNNbOHrVSp4LVolpcyN6sH3tIU9vPS+20bMIICAr7PdUyUdJCKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140045; c=relaxed/simple;
	bh=7EqN3p0cTkX1ZI/wbSjgHj4rbRQELoTOTq2bsNwW5k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTJnov0f0mE60HnOcZdiyZEglGvNVebmu3lAk11BjGoqrqUZa1YH7Is1Y3kFkO55GZlw69X0WevhA/JhdfxzrmHf0lh7JSoQqMbghn/WXl09jxBDGp3xiPdkmN5rYl6ZmaECTNwNA8ceQ21pRNsSjdbvdni3aWeRPWzi14Sl2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rzr9WJ31; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746140042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtLg0B1vrzZBeuo/C7fy1HGxDtxIeRaGRM5T8fcaxh0=;
	b=Rzr9WJ31vCRyHJCBM9qqcQM3QQui2ALwJSkGfjuo7N6g5l+SZ8ZMr+LDwejWoD0TZrL1FF
	G3Q2vUzExePy0TvBt6PIVSzHlkCmeixiTze4B1vdpcxA0nEJGZXk1UWoXm5rBuv22EJqQL
	GKMOOsj5RM9Su03HrX9hkmilip+iYVw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-8aCfhnMWOD2QaoPc9jKaFg-1; Thu, 01 May 2025 18:54:01 -0400
X-MC-Unique: 8aCfhnMWOD2QaoPc9jKaFg-1
X-Mimecast-MFC-AGG-ID: 8aCfhnMWOD2QaoPc9jKaFg_1746140041
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-708af1dc9easo20492467b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 01 May 2025 15:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746140041; x=1746744841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtLg0B1vrzZBeuo/C7fy1HGxDtxIeRaGRM5T8fcaxh0=;
        b=HBKP+czadIWAbuKey1e4BJMY39uvmOtXsJETb/6Gxoc44ZPUG3dqJbdIrU/y/KcCo0
         X9dE/n69hDuv35Z+K34pC+Api2kSyy/8519MGsqXnb+lKcOR8c3BdnBWa/pc2JDAJkyK
         p5bayMmTeZJlEzOxrMk5r7lW7jnrPQkBLrDH0NGvaaXGqdFp+uZJOTh1vCHEuZs9KYkl
         +/WYJXm+uJUfSpmCBveJPpP47yHi+PhoeFHxd9fK93KSnKenMoHpZM2Vv7GkTXiDs5qB
         fopc3eFoyR/TonOrDdKipFH+9pk/pIUUKLu7eqXEuUquEyf0wIOd0y8UpveAm700gLZ0
         TwMg==
X-Forwarded-Encrypted: i=1; AJvYcCXz4P85jv9W2XdGwt8quumk6utDlWWsGU8eCfK8fJtAn25xP9180LzfOsyWtpHsyTgN/1yaH8MImcatFXa40tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMyD68x2pte0e7R3OLbY/wi9n1/+GodXkDP1St9lFOa6mjfiVJ
	fZ5JqCWvSWUsZxk/zJBKCSTm6AxMcSqaeaNc7bSif1bo2dOz9aFni9utp4KCU8tHrZbcFxUjlt3
	uMhkgYwThOMCAZBmO6Ql9mIL5bc4kHQgVFkXQKEOcfants4n0gYnf7gGrq3MNkH3hb1pr4jAVBg
	//J3xtubqvatYtaKS1e4/yZZbchDOxtf9mgTrAfUTg
X-Gm-Gg: ASbGncvEkMrEsdpbGJC7VKosfayw7EBBOZJ167YJDZNLh6mMzvxJuJsuVNKpRZHORPM
	MH6YIgctxfECfkRqeGlVKrEjJBGYuylcNsYwOPrlSxkC1WAZbgxpqvB3GFswvh+KJqDg8dKIwPT
	TH0V4KyRQ=
X-Received: by 2002:a05:690c:6892:b0:708:15dd:712 with SMTP id 00721157ae682-708cee0d4e0mr15576667b3.32.1746140040876;
        Thu, 01 May 2025 15:54:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGPElw1UZQRMg/NB24PlPPnaQvolOetsYL1qWqN2H/DAHnfrkNvMouRvuxZDqL6cOU1L++ooR/hLBGonde+Go=
X-Received: by 2002:a05:690c:6892:b0:708:15dd:712 with SMTP id
 00721157ae682-708cee0d4e0mr15576337b3.32.1746140040523; Thu, 01 May 2025
 15:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428182904.93989-1-npache@redhat.com> <20250428182904.93989-4-npache@redhat.com>
 <BE08D7F9-716B-4EE8-AC4E-2D9F4C5D4A05@nvidia.com>
In-Reply-To: <BE08D7F9-716B-4EE8-AC4E-2D9F4C5D4A05@nvidia.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 1 May 2025 16:53:34 -0600
X-Gm-Features: ATxdqUG3EUSAuZQcIBHamAtOStWW2NfUYwlhaLO5OYc6mM0jjaysT4fqAsR4EYU
Message-ID: <CAA1CXcBM5210TqVn_bE0yAxo0SR=_g4GAgZoopwSDbyFYL+pqw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] khugepaged: add defer option to mTHP options
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, 
	willy@infradead.org, peterx@redhat.com, shuah@kernel.org, 
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
	vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, 
	yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com, 
	aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 2:34=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 28 Apr 2025, at 14:29, Nico Pache wrote:
>
> > Now that we have defer to globally disable THPs at fault time, lets add
> > a defer setting to the mTHP options. This will allow khugepaged to
> > operate at that order, while avoiding it at PF time.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  include/linux/huge_mm.h |  5 +++++
> >  mm/huge_memory.c        | 38 +++++++++++++++++++++++++++++++++-----
> >  mm/khugepaged.c         |  8 ++++----
> >  3 files changed, 42 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 57e6c962afb1..a877c59bea67 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -96,6 +96,7 @@ extern struct kobj_attribute thpsize_shmem_enabled_at=
tr;
> >  #define TVA_SMAPS            (1 << 0)        /* Will be used for procf=
s */
> >  #define TVA_IN_PF            (1 << 1)        /* Page fault handler */
> >  #define TVA_ENFORCE_SYSFS    (1 << 2)        /* Obey sysfs configurati=
on */
> > +#define TVA_IN_KHUGEPAGE     ((1 << 2) | (1 << 3)) /* Khugepaged defer=
 support */
>
> Why is TVA_IN_KHUGEPAGE a superset of TVA_ENFORCE_SYSFS? Because khugepag=
ed
> also obeys sysfs configuration?
Correct! The need for a TVA_IN_KHUGEPAGED is to isolate the "deferred"
mTHPs from being "allowed" unless we are in khugepaged.
>
> I wonder if explicitly coding the behavior is better. For example,
> in __thp_vma_allowable_orders(), enforce_sysfs =3D tva_flags & (TVA_ENFOR=
CE_SYSFS | TVA_IN_KHUGEPAGE).
I'm rather indifferent about either approach. If you (or any others)
have a strong preference for an explicit (none-supersetted) TVA flag I
can make the change.
>
> >
> >  #define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
> >       (!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order))=
)
> > @@ -182,6 +183,7 @@ extern unsigned long transparent_hugepage_flags;
> >  extern unsigned long huge_anon_orders_always;
> >  extern unsigned long huge_anon_orders_madvise;
> >  extern unsigned long huge_anon_orders_inherit;
> > +extern unsigned long huge_anon_orders_defer;
> >
> >  static inline bool hugepage_global_enabled(void)
> >  {
> > @@ -306,6 +308,9 @@ unsigned long thp_vma_allowable_orders(struct vm_ar=
ea_struct *vma,
> >       /* Optimization to check if required orders are enabled early. */
> >       if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
>
> And code here becomes tva_flags & (TVA_ENFORCE_SYSFS | TVA_IN_KHUGEPAGE).
or just (enforce_sysfs & vma_is_anon)  like you mentioned. Then we
check for the TVA_IN_KHUGEPAGED before appending the defer bits.
>
> Otherwise, LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>
Thanks !
>
> --
> Best Regards,
> Yan, Zi
>


