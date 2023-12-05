Return-Path: <linux-kselftest+bounces-1103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D76280437C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 01:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831C41C20C46
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 00:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBB3EC7;
	Tue,  5 Dec 2023 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6zhY/03"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA6BA5A
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 00:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBB5C433B8
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 00:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701736569;
	bh=nh5OvhQxlRfLMDVGUATaUP5xmIGHhybcttjxqWDsn3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c6zhY/03sYoUPxFSOAzcqpJZNdgcpIlguB8F8Ya6QtatTsdz1qTJrxroGNpHDCz+k
	 63siMOOcIga85eiVqw+IX/X812bDb4yBSEqrDk9+o5uVWH/9ctrNBM23BfhFgLPrsT
	 I4nqhdNFK8iX8f1eHUSVJvzq8t9Do5uJJCXj7TPuI5lJpjHGDiiRrOhXElPMv17s9y
	 6KIy8W6mYttmVmJm3RacrZOIa2pvOM3aPhO1Zfjf3mfBReG/qxdPROL1ds0WTuQwEH
	 KQTj/QzUOPlguiUi08443cGHf6c0PFubwpXdFlPzxWgELpwCX6rG5Gf394rdIFTzJJ
	 xdbZJUcVlK+wA==
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c21e185df5so2785004a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Dec 2023 16:36:09 -0800 (PST)
X-Gm-Message-State: AOJu0YxtSInADmgxY70gB7KWE3GhM5Cven/To21ch3Bs6/NyMBiVKhQ5
	8rnX1ehgxaClNpXA09ji7bdbfu14/pqLIzoe9y8JOg==
X-Google-Smtp-Source: AGHT+IFEGHhgC5vm9lb6tIiaRJZgs/RHNtib/ITvbq5Wlcj1rLMMGwqG+hEI5SF0R/fth38EIgqoS5P+F/X0FUD92DU=
X-Received: by 2002:a05:6a21:6215:b0:18c:1248:bb17 with SMTP id
 wm21-20020a056a21621500b0018c1248bb17mr4976625pzb.21.1701736568967; Mon, 04
 Dec 2023 16:36:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-3-nphamcs@gmail.com>
In-Reply-To: <20231130194023.4102148-3-nphamcs@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 4 Dec 2023 16:35:57 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOsaX15w3gF7eUN8u7LAKhC7m2we91simoPH7S=MZJZCg@mail.gmail.com>
Message-ID: <CAF8kJuOsaX15w3gF7eUN8u7LAKhC7m2we91simoPH7S=MZJZCg@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] memcontrol: implement mem_cgroup_tryget_online()
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, cerasuolodomenico@gmail.com, 
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeelb@google.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nhat,

Very minor nitpick. This patch can fold with the later patch that uses
it. That makes the review easier, no need to cross reference different
patches. It will also make it harder to introduce API that nobody
uses.

Chris

On Thu, Nov 30, 2023 at 11:40=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> This patch implements a helper function that try to get a reference to
> an memcg's css, as well as checking if it is online. This new function
> is almost exactly the same as the existing mem_cgroup_tryget(), except
> for the onlineness check. In the !CONFIG_MEMCG case, it always returns
> true, analogous to mem_cgroup_tryget(). This is useful for e.g to the
> new zswap writeback scheme, where we need to select the next online
> memcg as a candidate for the global limit reclaim.

Very minor nitpick. This patch can fold with the later patch that uses
it. That makes the review easier, no need to cross reference different
patches. It will also make it harder to introduce API that nobody
uses.

Chris

>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/memcontrol.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7bdcf3020d7a..2bd7d14ace78 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -821,6 +821,11 @@ static inline bool mem_cgroup_tryget(struct mem_cgro=
up *memcg)
>         return !memcg || css_tryget(&memcg->css);
>  }
>
> +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg)
> +{
> +       return !memcg || css_tryget_online(&memcg->css);
> +}
> +
>  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>         if (memcg)
> @@ -1349,6 +1354,11 @@ static inline bool mem_cgroup_tryget(struct mem_cg=
roup *memcg)
>         return true;
>  }
>
> +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg)
> +{
> +       return true;
> +}
> +
>  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>  }
> --
> 2.34.1
>

