Return-Path: <linux-kselftest+bounces-855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E215E7FE5E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 02:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A5A5B21411
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 01:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF3C4C7E;
	Thu, 30 Nov 2023 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBy9JBlx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7DB8E;
	Wed, 29 Nov 2023 17:17:22 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7b37405f64aso8344139f.2;
        Wed, 29 Nov 2023 17:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701307042; x=1701911842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eWb4cpMSDpOhY83scp3GXSiLGlssYt4cGYuWNn8dfc=;
        b=EBy9JBlxub0+T3KolCI5RgHQJ0LJbqVC5ICQJf9+sd+vMmLcF+OxNicGiX/BYJRLYJ
         EMOb/DshTqCnd80IL0mRifVoxz7ahMBynfxHz16k2ZiA5Ujs77iiFY6Q3FAPtYNYXSZ3
         hxdqlK/IizLV+l2fHyjoLA1e4jQtkkR0Wk5dhnw851kS3gDbuo+ROn8+8cmhNBJDaYzx
         GQCfuw8chQdwwWyCnT29rQdNpMt44UhTaLoAzh9rCKri201vJf5YCzWCs9AF3Q349Jbj
         aPfY2gz8H3tZCyTY6Z7dJ0eyA8Hxhlc9XfNZfzM6bxS/MBeQ1xb27/JB4Njfxp/uRFFj
         r9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701307042; x=1701911842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eWb4cpMSDpOhY83scp3GXSiLGlssYt4cGYuWNn8dfc=;
        b=e4VRPYlxVXT3BO5MZF6TqzlaRrNVCMyI83JATdUjPrujPm46TA26hPee0DkepaTTgy
         d7uXkyHJvfBH1CBYuUNMEZ5vLMFn9JepsvRH7CCpE70qg717HZ3JMNLulCF2+nuzW5Gg
         CPefnEYpqfuMeW8NKxByLBNAu7Z8KL8SykxX73IU96a0hp8wkznM5bEOGywCl6PWJIjl
         wksB+tXwkLE0hkwKY5p7f165RfrbNdPaj1y+kZCy4vCYlpFW2E1VyXhAHQzvwtjb/AQb
         0Rub3aLg0yF66qTp8/3JRRMBU0X/6S2vAHUx4XlRdWfyfTkZR5fwgHvpWh6lqMTW3yyV
         4zKA==
X-Gm-Message-State: AOJu0Yw+D8PDzgQPU0h1qN2dIjbFkWkifkKO6vXF4ZuxONox7vPQNU51
	YudgOUpupe2c0KF7q3+LUdwWRG3YS2ns7JBe4DE=
X-Google-Smtp-Source: AGHT+IE5YuiZlN60NP+PTEYxX011dseeYtEXDZDUfubnFiHW22/wCFNaxyqnolgJzwpz4/cQjyTG35wtqDaax6dmI8Y=
X-Received: by 2002:a05:6e02:811:b0:35c:e1fc:8b83 with SMTP id
 u17-20020a056e02081100b0035ce1fc8b83mr12988531ilm.16.1701307041738; Wed, 29
 Nov 2023 17:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127234600.2971029-1-nphamcs@gmail.com> <20231127234600.2971029-4-nphamcs@gmail.com>
 <20231129151721.GC135852@cmpxchg.org> <CAKEwX=M=iFGS6PQyF7FiV2JDhN0uLzSiJ3TK30nGiV1mM1wZ+A@mail.gmail.com>
In-Reply-To: <CAKEwX=M=iFGS6PQyF7FiV2JDhN0uLzSiJ3TK30nGiV1mM1wZ+A@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 29 Nov 2023 17:17:10 -0800
Message-ID: <CAKEwX=MPkFfVp6vupje0cjePa9Uxh3orPubiDkrtewtj3N=RXA@mail.gmail.com>
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

On Wed, Nov 29, 2023 at 4:21=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Wed, Nov 29, 2023 at 7:17=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Mon, Nov 27, 2023 at 03:45:57PM -0800, Nhat Pham wrote:
> > >  static void shrink_worker(struct work_struct *w)
> > >  {
> > >       struct zswap_pool *pool =3D container_of(w, typeof(*pool),
> > >                                               shrink_work);
> > > +     struct mem_cgroup *memcg;
> > >       int ret, failures =3D 0;
> > >
> > > +     /* global reclaim will select cgroup in a round-robin fashion. =
*/
> > >       do {
> > > -             ret =3D zswap_reclaim_entry(pool);
> > > -             if (ret) {
> > > -                     zswap_reject_reclaim_fail++;
> > > -                     if (ret !=3D -EAGAIN)
> > > -                             break;
> > > +             spin_lock(&zswap_pools_lock);
> > > +             memcg =3D pool->next_shrink =3D
> > > +                     mem_cgroup_iter_online(NULL, pool->next_shrink,=
 NULL, true);
> > > +
> > > +             /* full round trip */
> > > +             if (!memcg) {
> > > +                     spin_unlock(&zswap_pools_lock);
> > >                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> > >                               break;
> > > +
> > > +                     goto resched;
> > >               }
> > > +
> > > +             /*
> > > +              * Acquire an extra reference to the iterated memcg in =
case the
> > > +              * original reference is dropped by the zswap offlining=
 callback.
> > > +              */
> > > +             css_get(&memcg->css);
> >
> > struct mem_cgroup isn't defined when !CONFIG_MEMCG. This needs a
> > mem_cgroup_get() wrapper and a dummy function for no-memcg builds.
>
> I got this exact same issue a couple of versions ago, but it was
> hidden behind another helper function which can be implemented as a
> no-op in the case of !CONFIG_MEMCG, so I forgot about it until now. It
> always strikes me a bit weird that we have mem_cgroup_put() but not an
> equivalent get - let me correct that.

Actually, I'll instead implement mem_cgroup_tryget_online(), as we
have to check for the cgroup's onlineness as well anyway! If it's
online, then keep the extra reference - all good. If it's not, then
drop the original reference before releasing the lock.


>
> >
> > With that fixed, though, everything else looks good to me:
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Thanks for the review, Johannes!

