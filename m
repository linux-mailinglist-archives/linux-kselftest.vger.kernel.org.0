Return-Path: <linux-kselftest+bounces-36828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08823AFEC70
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 16:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BD81893682
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C402E6104;
	Wed,  9 Jul 2025 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNGaTJ7E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8A2BEFF0
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Jul 2025 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072236; cv=none; b=bdkfo9s5pfIjqqoKqemtubm4/nCGA64U8tfhAqrLlxQCyReZStat7EHihpEePu4dezGbuI6n4YpBW/ZXEB95vspetkDH0GeavS2mkuLuHGCT9JmXkL/uNHOCcki+p0fiosBxRASn2c7WKyKLbYI0dqdM9W7v8FHF+V/RFmieAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072236; c=relaxed/simple;
	bh=l2EoRIEOm1tWa3RQ3yXDYhhzRpdZ5cCSLcCdICp+VvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t595LwYc6dTQXZZx58Flj8zG57OubFTqf/hQv3WfOd2Ts/JeH/zZexSwz9vlScY9q9HG8La1C3R6pFEi9zAtPCy98gaoHELuNM2DkXAT6UFlKXbYbaeGo08Vz/sYd69V9xy0Ijbc2Wk8EIRCw3Wze/j96uVCMW4PsXhI/h1I/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNGaTJ7E; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a58197794eso169031cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Jul 2025 07:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752072233; x=1752677033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9h4iNrqmrgYRYNHEm412mE4N8zc3N+lVl0+OkSxU5fQ=;
        b=CNGaTJ7ECtSUZ6aDEjfcDf2OdjGYEzyklc/2IqPTv5LRrUvofj/l9imWgLNi8rFMWf
         2Uo1KsEn2hl1R5hGIqb6Web4HXcsmah4XA7qiSsvvmpqAVvl6hO+4UExlQZ3Mye8VQlA
         gvpw1CpvGjKu705LBOYLqizos3XOFgWScAGYH6nQ9hRmNNj/nBGwkIWcyxmH9ATGeQz/
         R9fSc2ui2azxcoD0GJaQeJrHJnv5tAnIkiWUWMivAS9NYL9XqqtmWiayryynAprSYnE7
         By+iu5knp/1fFZbxvHbXSHqrWxXmTApIIYO/98R29g6GQJ6+O7XvgozBj7WCm2b8MGTj
         7l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072233; x=1752677033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h4iNrqmrgYRYNHEm412mE4N8zc3N+lVl0+OkSxU5fQ=;
        b=UpsWpnP5GkQV0P2+iARhiD393+ZL7kGfJBWZ0JL8WeJBmiOXUuFPOze3itpPahPQw4
         1PaPQqR7Rpy5njfooZ7f0m4WYg9tpIZ2Zeo0bDgsL6Ltm1XaNjFDd6jMBN2qcPHp5VfS
         LaGYrxSULyvIjWYq4pKS3/mtdKXNU1gWxY6EWYToXWNvXQl3p0tc4SCGeIu6JFr7qfsV
         WBHC4qmyirWh9Xd5kLgSjt3mOpDyaZWZp2NwdSnJgiTlc+KVNO2qhFG9UhkW4lfgD+ic
         glLLGyc0aA/HpM6eXQnsJuJvO2nw76RHjEnHJ6RBnSyexyA7unqfM0Ft/pLgmx8s062f
         HRQw==
X-Forwarded-Encrypted: i=1; AJvYcCVB+KHZbO3qge53qCMvtjsuIDokV/0OhP5w1bwDPqnhYVy2B7i8flxPafhbRe4242mqdDKeHqc1Tq/lA78B/rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZUBOr9wlcslZu7nlihkGKalhk6Quf1o4nHPymxP6bhqddO/8
	cawcFO3HuJXFkETP66S/dM94/RB1GqBQhJ/Or1q+Qm/adUP38Y5Z1OowPyH9E2K+QfSUYNYHHc1
	+jSi5HaqUkldFddMVHfN0l0AZQV3VbxLm7ElxWf73
X-Gm-Gg: ASbGncuNI8LmVGItunbhoWEFP63so19LC6yKSEIiWvFbqRE0bdVJhZ3qDm12Jkmkblz
	MK8n+ACX82OkO2rLiKYSD0iVHP99RHXWPuzbNCc+NsEgYiIKTcitYVAC6rYFm5ZHw/JhYh0NhFt
	BVa/Mwqe6NTkf1XlYFzkirbJB5edHI98t8mfOWf0a1OLvBNJ8wFxvPzWrJysDZZ47rFVTWNpjxa
	g==
X-Google-Smtp-Source: AGHT+IEU/TvuWoEbQ4te2ysqypswU5dT7NndQazyOFRc4vkSO/Fq1Wv/2Ic2ztMR6HHz0WqYXvto3hPD9kQ7BwMTx3U=
X-Received: by 2002:a05:622a:306:b0:48d:8f6e:ece7 with SMTP id
 d75a77b69052e-4a9de07279bmr3534091cf.3.1752072232239; Wed, 09 Jul 2025
 07:43:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com> <20250704060727.724817-8-surenb@google.com>
 <bcba384b-0161-4d3c-b632-67e25dcd1efd@suse.cz>
In-Reply-To: <bcba384b-0161-4d3c-b632-67e25dcd1efd@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Jul 2025 07:43:40 -0700
X-Gm-Features: Ac12FXxjAN0XIip7JsJyjMywVS_OrT44fU8TqxqHaIiIlNUJxwEx3Zvd-AP4Q2Q
Message-ID: <CAJuCfpELdDi0G5Tdf0GQRNVvLxFW6HzKN-gfTLW4Yiw0jNRHQQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 3:03=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 7/4/25 08:07, Suren Baghdasaryan wrote:
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -178,6 +178,94 @@ struct vm_area_struct *lock_vma_under_rcu(struct m=
m_struct *mm,
> >       count_vm_vma_lock_event(VMA_LOCK_ABORT);
> >       return NULL;
> >  }
> > +
> > +static struct vm_area_struct *lock_vma_under_mmap_lock(struct mm_struc=
t *mm,
> > +                                                    struct vma_iterato=
r *iter,
> > +                                                    unsigned long addr=
ess)
> > +{
> > +     struct vm_area_struct *vma;
> > +     int ret;
> > +
> > +     ret =3D mmap_read_lock_killable(mm);
> > +     if (ret)
> > +             return ERR_PTR(ret);
> > +
> > +     /* Lookup the vma at the last position again under mmap_read_lock=
 */
> > +     vma_iter_init(iter, mm, address);
> > +     vma =3D vma_next(iter);
> > +     if (vma)
> > +             vma_start_read_locked(vma);
>
> This can in theory return false (refcount overflow?) so it should be hand=
led?

Yes, I should handle it by falling back to mmap_lock. Thanks!

>
> > +
> > +     mmap_read_unlock(mm);
> > +
> > +     return vma;
> > +}
> > +

