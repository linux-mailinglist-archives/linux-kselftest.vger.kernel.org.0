Return-Path: <linux-kselftest+bounces-1221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B19B806423
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 02:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CD51F21769
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 01:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C804EEC4;
	Wed,  6 Dec 2023 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1oqSVr/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F648196;
	Tue,  5 Dec 2023 17:30:16 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35d6c8d83dbso11819435ab.1;
        Tue, 05 Dec 2023 17:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701826216; x=1702431016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOFBk06V0iPHoZN7l9Hfj2HO9+qghCOI4wCxtS6Vf3U=;
        b=P1oqSVr/UqYYmyE82nUi+vZ/YoFMHjrtfXpbdOORjjeXs/UFO6pzy7G1f/H20yeUZn
         MHqcDe0yBP8BQycJuUYCZheRO4fAaqCscDZxbf8FxS8kPdMRJ4pDbjcNrGlw6RaLNr0K
         dHOA9KpHlI4nMPkklewvoKSRh2ZKlhJWBPGxGJB0pyQQqM6plPH0Ide5LWGF9sT5s/Wd
         OETSFJ3vJXR+ruUbJ1nwYjscrspIGLktPnhbUtQEUb2I9RA93OQNMJ7qXqvh1crsM+Gm
         vJc6SHtz1axK/m9EiPPYqJDTi7IcsYjtXUVy5R87LWfYlCUh+PWsli64oOOAjicm6Shy
         y3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701826216; x=1702431016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOFBk06V0iPHoZN7l9Hfj2HO9+qghCOI4wCxtS6Vf3U=;
        b=OBBfT8g/F28mDBQZS1TOn1A2p181uzYgz5KP9KUFFK8M3IOpNrh/+AqSYQv10+jkYt
         /QH2b81mQowiMXdF8q+xu9ax9y97DyZc4Yrtf2QmQpnqm7vfPvyCHXCrmxKbHh4Q7tYm
         xwRUoadAnmFAqemV+eB575OSPWuJCv8ZMMkq8UuRUoEPwW4t4X9x2pTGs5fboFlAy/dh
         6LQGb/DuGeNQssYno3+Iq3lr12DoRjqpQrKqEu+RncyUuGfFQmtvcjXo1oGJCZH19PNU
         rT3uis8r2NiP8RGgJmtSaqUI4oF1S+Y9MRrG0LqkVlvBrAFuPzUOpdqHilmIX4LWE4mO
         BohA==
X-Gm-Message-State: AOJu0Yzw96ClXA+3ozcxr0LAmmHPfJ+2R3n40AE4ffSW1f7zXbPhODeR
	tXcxGcAiuChrkcXT01E/UOWYpledbCfNC3MvfHtQSvaJagcezQ==
X-Google-Smtp-Source: AGHT+IF2PzzcXijWvJLhFkxW0lUiLKOLnKj88t1aot7T1boed55yc6mphki+baIkOQ/o0Za8IiIsvrgTw5HjllN1YhY=
X-Received: by 2002:a92:d604:0:b0:35c:f8bc:ce0b with SMTP id
 w4-20020a92d604000000b0035cf8bcce0bmr244781ilm.18.1701826215722; Tue, 05 Dec
 2023 17:30:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-3-nphamcs@gmail.com>
 <CAF8kJuOsaX15w3gF7eUN8u7LAKhC7m2we91simoPH7S=MZJZCg@mail.gmail.com>
 <CAKEwX=PX0bR5orAsgYtXfOSarRobf1xnkSyXx+z6g_VHFVonQw@mail.gmail.com> <CAF8kJuO8xmhxpCSzof9cDAqOheZgpz5Z-xyCHUQUGenCmzmdhA@mail.gmail.com>
In-Reply-To: <CAF8kJuO8xmhxpCSzof9cDAqOheZgpz5Z-xyCHUQUGenCmzmdhA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 5 Dec 2023 17:30:04 -0800
Message-ID: <CAKEwX=NijPzqo3DXhfZ2HjYjOVHN=W__zQSJ24a-3P0egUYi3g@mail.gmail.com>
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

On Tue, Dec 5, 2023 at 4:16=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Mon, Dec 4, 2023 at 5:39=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > > > memcg as a candidate for the global limit reclaim.
> > >
> > > Very minor nitpick. This patch can fold with the later patch that use=
s
> > > it. That makes the review easier, no need to cross reference differen=
t
> > > patches. It will also make it harder to introduce API that nobody
> > > uses.
> >
> > I don't have a strong preference one way or the other :) Probably not
> > worth the churn tho.
>
> Squashing a patch is very easy. If you are refreshing a new series, it
> is worthwhile to do it. I notice on the other thread Yosry pointed out
> you did  not use the function "mem_cgroup_tryget_online" in patch 3,
> that is exactly the situation my suggestion is trying to prevent.

I doubt squashing it would solve the issue - in fact, I think Yosry
noticed it precisely because he had to stare at a separate patch
detailing the adding of the new function in the first place :P

In general though, I'm hesitant to extend this API silently in a patch
that uses it. Is it not better to have a separate patch announcing
this API extension? list_lru_add() was originally part of the original
series too - we separate that out to its own thing because it gets
confusing. Another benefit is that there will be less work in the
future if we want to revert the per-cgroup zswap LRU patch, and
there's already another mem_cgroup_tryget_online() user - we can keep
this patch.

But yeah we'll see - I'll think about it if I actually have to send
v9. If not, let's not add unnecessary churning.

>
> If you don't have a strong preference, it sounds like you should squash i=
t.
>
> Chris
>
> >
> > >
> > > Chris
> > >
> > > >
> > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > ---
> > > >  include/linux/memcontrol.h | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.=
h
> > > > index 7bdcf3020d7a..2bd7d14ace78 100644
> > > > --- a/include/linux/memcontrol.h
> > > > +++ b/include/linux/memcontrol.h
> > > > @@ -821,6 +821,11 @@ static inline bool mem_cgroup_tryget(struct me=
m_cgroup *memcg)
> > > >         return !memcg || css_tryget(&memcg->css);
> > > >  }
> > > >
> > > > +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *mem=
cg)
> > > > +{
> > > > +       return !memcg || css_tryget_online(&memcg->css);
> > > > +}
> > > > +
> > > >  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> > > >  {
> > > >         if (memcg)
> > > > @@ -1349,6 +1354,11 @@ static inline bool mem_cgroup_tryget(struct =
mem_cgroup *memcg)
> > > >         return true;
> > > >  }
> > > >
> > > > +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *mem=
cg)
> > > > +{
> > > > +       return true;
> > > > +}
> > > > +
> > > >  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> > > >  {
> > > >  }
> > > > --
> > > > 2.34.1
> > > >
> >

