Return-Path: <linux-kselftest+bounces-853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAC27FE4C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 01:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD361F20C17
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 00:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E889D385;
	Thu, 30 Nov 2023 00:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM/jMiOM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D21A3;
	Wed, 29 Nov 2023 16:21:38 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7b35d846f36so7132539f.0;
        Wed, 29 Nov 2023 16:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701303697; x=1701908497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sEYAfmnmUKDzXdKzmpSP1T6NxdrFel4xsutg1ntZcg=;
        b=nM/jMiOM/X7yEyya+qb4zJZ2Rc/yGKBWae5hbSJUOmxi66a2zB6oS6qtpAtRF1G+ek
         mfDaZXX3wwQpMWuj5tDUqAoeL1iGUvfkUUFd2s1fbGGiku7s7VIPX+nzJx95CWdxfgTE
         1uB5yG6eRhpQWnBo957cKAqCR59B8uFpfAWcRzIWPXSXSlk0D+JlafDTVvhKPizbTlMN
         gaxAQKgxHO5CJW4Ae8bhqJPHHOGuJfbz1rUpi/rd9qwRdm9qHSgT5OMMXCdhkOJLxOjH
         kceAbVvR/Ezt8HhTlUzlu1E/uNTWc1XmFNmOkLXGmH2P33u7BHXgIMYvSyuhGKQB+d+i
         k/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701303697; x=1701908497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sEYAfmnmUKDzXdKzmpSP1T6NxdrFel4xsutg1ntZcg=;
        b=E7ucRgCYIapB0OY5VCh/D4G+idueKTGU2U4HjJyT3GDnoYfiFpLERW644VXP2bE+kM
         hSGXMHG+CStLZMdhkKJPPZxVUn64Ot2SvqAyVMi01PTDgerpyhrAfyz21BxL9HNvHFr0
         LG4Mr7k2G4hQpdrtn8u30dDMaO6BvMdE751b/f+BojOq5q/ssO2TrlwAWRTc+tHTeE3r
         JDi9bCjoggAf3Iinv6k6k/IjRm5CCG5HfT38C0O1aToqIHF6LmlkHxX2CjAQLpRKEFNd
         +JsKEjjoncgPpnJvHq+q92xp/JA/9eviKrchXod+/GKFc7XYBv7zZnj8eHmdA5gMF13w
         /5/g==
X-Gm-Message-State: AOJu0YwOMmrnzTHMVhsZbXjzvqnLxdXr30sfgTqOL6S/kExFEt/9F/Qb
	JbUzYuFnkwwvIktNZmY/gyT1blqK+8LRazROnWA=
X-Google-Smtp-Source: AGHT+IFnjon5ckFouO3ILdmOgn+ew1aPuvqBrEyBZkvxwT6MjHsyijlRuwmCEMmG8avlJLyEGPgvzflmo9ozXUtwHyo=
X-Received: by 2002:a6b:e602:0:b0:79f:d04d:ce5a with SMTP id
 g2-20020a6be602000000b0079fd04dce5amr17455738ioh.2.1701303697230; Wed, 29 Nov
 2023 16:21:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127234600.2971029-1-nphamcs@gmail.com> <20231127234600.2971029-4-nphamcs@gmail.com>
 <20231129151721.GC135852@cmpxchg.org>
In-Reply-To: <20231129151721.GC135852@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 29 Nov 2023 16:21:26 -0800
Message-ID: <CAKEwX=M=iFGS6PQyF7FiV2JDhN0uLzSiJ3TK30nGiV1mM1wZ+A@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] zswap: make shrinking memcg-aware
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, cerasuolodomenico@gmail.com, 
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeelb@google.com, muchun.song@linux.dev, chrisl@kernel.org, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 7:17=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Nov 27, 2023 at 03:45:57PM -0800, Nhat Pham wrote:
> >  static void shrink_worker(struct work_struct *w)
> >  {
> >       struct zswap_pool *pool =3D container_of(w, typeof(*pool),
> >                                               shrink_work);
> > +     struct mem_cgroup *memcg;
> >       int ret, failures =3D 0;
> >
> > +     /* global reclaim will select cgroup in a round-robin fashion. */
> >       do {
> > -             ret =3D zswap_reclaim_entry(pool);
> > -             if (ret) {
> > -                     zswap_reject_reclaim_fail++;
> > -                     if (ret !=3D -EAGAIN)
> > -                             break;
> > +             spin_lock(&zswap_pools_lock);
> > +             memcg =3D pool->next_shrink =3D
> > +                     mem_cgroup_iter_online(NULL, pool->next_shrink, N=
ULL, true);
> > +
> > +             /* full round trip */
> > +             if (!memcg) {
> > +                     spin_unlock(&zswap_pools_lock);
> >                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> >                               break;
> > +
> > +                     goto resched;
> >               }
> > +
> > +             /*
> > +              * Acquire an extra reference to the iterated memcg in ca=
se the
> > +              * original reference is dropped by the zswap offlining c=
allback.
> > +              */
> > +             css_get(&memcg->css);
>
> struct mem_cgroup isn't defined when !CONFIG_MEMCG. This needs a
> mem_cgroup_get() wrapper and a dummy function for no-memcg builds.

I got this exact same issue a couple of versions ago, but it was
hidden behind another helper function which can be implemented as a
no-op in the case of !CONFIG_MEMCG, so I forgot about it until now. It
always strikes me a bit weird that we have mem_cgroup_put() but not an
equivalent get - let me correct that.

>
> With that fixed, though, everything else looks good to me:
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks for the review, Johannes!

