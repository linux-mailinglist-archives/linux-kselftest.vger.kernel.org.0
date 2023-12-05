Return-Path: <linux-kselftest+bounces-1104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A9A80442D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 02:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB39281338
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 01:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED28D184E;
	Tue,  5 Dec 2023 01:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrNgvUi1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504CCF0;
	Mon,  4 Dec 2023 17:39:16 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7b395a9b893so127362139f.0;
        Mon, 04 Dec 2023 17:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701740355; x=1702345155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiX6pc1dDK4xTX1Ckg3uh00q7u3Eog+NFUBy9p3mvq0=;
        b=LrNgvUi14Cu033eqEHvh0Ax5CLgUT00oCKAapb4PfwgKC5likwVSAAcSZ/HJkYQHmu
         6vr6t4s2KQ6cLtBrmwvu4g58FmyDaErgEWOQN9mT+AL41Z575/dYwz+XiN8IyI6/rOzY
         17wt19A7JMO+sLN7a5aS+r1UthkSIw/6FsLf5vH3EKr7iLXEouRgtyBiSWNTdJNKEiXl
         g1ic/eZJXAmL+dClBBLdK+rByh41ijWPqwkhF0cxacVgX2esYJauNAzr4gHE4ODPgqr2
         fZhrIHZ3jfOqK135MY+J//He9B2+VoQyE12EkdWanuh8Y/tg7ez5BJAcInk/ZYR2hZH0
         8qBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701740355; x=1702345155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiX6pc1dDK4xTX1Ckg3uh00q7u3Eog+NFUBy9p3mvq0=;
        b=PsYyEysyPQ1q2ulLq742HQI/s44FctYo5nHDKhn+zdX+lsS2H4H87VLH+bxbDP9dt+
         qaBPCYPORWUGnpVt0p8oCsXP4m8lcmcVv5GZAJhghDqACOrKyCeRku1gImyXspOmxlkw
         l+3n3Ka1CmeV1RzvAY+t+kMRpu+SKUjKqii9ASUnFsdIJD1WsZH6RZUGdpuhj8g+ffu7
         nPT3kR/gWy76shZIt4uwrPoorIMfnB2UIzGTnTSfk5EtxGP0oHDs+eH2FR6N6kbY7u16
         PWCe5jGCSbrK654zBoN6QzYfQCVd9PsjVo2B+iKFPuKgC5pnp1Lm9EbCT5UKJPMKvqUb
         6V/g==
X-Gm-Message-State: AOJu0Yw7nmQFdvMeBIQidwTL6Om+U+MixSEHUEcD14Cc3J6AlnI54xDq
	YClXvMfCzoZjNQntdjecDNXvezFeOj82OeJ315U=
X-Google-Smtp-Source: AGHT+IGjYybIQy0SdRCNIM4PRKhqx7NFwqnHKtzhUBlzwyV7Cwnjp8EjR6D5SShloHX5XFY7hhjfJ4gzf+RhnVLgGjg=
X-Received: by 2002:a5d:88d5:0:b0:7b4:2909:73b with SMTP id
 i21-20020a5d88d5000000b007b42909073bmr586181iol.18.1701740355574; Mon, 04 Dec
 2023 17:39:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-3-nphamcs@gmail.com>
 <CAF8kJuOsaX15w3gF7eUN8u7LAKhC7m2we91simoPH7S=MZJZCg@mail.gmail.com>
In-Reply-To: <CAF8kJuOsaX15w3gF7eUN8u7LAKhC7m2we91simoPH7S=MZJZCg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 4 Dec 2023 17:39:04 -0800
Message-ID: <CAKEwX=PX0bR5orAsgYtXfOSarRobf1xnkSyXx+z6g_VHFVonQw@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] memcontrol: implement mem_cgroup_tryget_online()
To: Chris Li <chrisl@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, cerasuolodomenico@gmail.com, 
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeelb@google.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 4:36=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Nhat,
>
> Very minor nitpick. This patch can fold with the later patch that uses
> it. That makes the review easier, no need to cross reference different
> patches. It will also make it harder to introduce API that nobody
> uses.
>
> Chris
>
> On Thu, Nov 30, 2023 at 11:40=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> >
> > This patch implements a helper function that try to get a reference to
> > an memcg's css, as well as checking if it is online. This new function
> > is almost exactly the same as the existing mem_cgroup_tryget(), except
> > for the onlineness check. In the !CONFIG_MEMCG case, it always returns
> > true, analogous to mem_cgroup_tryget(). This is useful for e.g to the
> > new zswap writeback scheme, where we need to select the next online
> > memcg as a candidate for the global limit reclaim.
>
> Very minor nitpick. This patch can fold with the later patch that uses
> it. That makes the review easier, no need to cross reference different
> patches. It will also make it harder to introduce API that nobody
> uses.

I don't have a strong preference one way or the other :) Probably not
worth the churn tho.

>
> Chris
>
> >
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  include/linux/memcontrol.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 7bdcf3020d7a..2bd7d14ace78 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -821,6 +821,11 @@ static inline bool mem_cgroup_tryget(struct mem_cg=
roup *memcg)
> >         return !memcg || css_tryget(&memcg->css);
> >  }
> >
> > +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg)
> > +{
> > +       return !memcg || css_tryget_online(&memcg->css);
> > +}
> > +
> >  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> >  {
> >         if (memcg)
> > @@ -1349,6 +1354,11 @@ static inline bool mem_cgroup_tryget(struct mem_=
cgroup *memcg)
> >         return true;
> >  }
> >
> > +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg)
> > +{
> > +       return true;
> > +}
> > +
> >  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> >  {
> >  }
> > --
> > 2.34.1
> >

