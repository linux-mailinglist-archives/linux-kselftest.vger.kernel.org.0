Return-Path: <linux-kselftest+bounces-1213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0A9805F10
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 21:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B68281D1B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 20:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980606D1BD;
	Tue,  5 Dec 2023 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dqLoN7Le"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABD6194
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 12:06:28 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a1b68ae4104so5455866b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Dec 2023 12:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701806786; x=1702411586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlqC0mLlbsamWeTdymhvWwnQu+epiSDRN+zbg2hBOUA=;
        b=dqLoN7LeBAJ+6P2G8vDtqHEV5R6PfL2dtERshtR/hpGsyL7NvcO0Rjzq2RdvkD4m49
         7m3EdJU1nxur9N3INcj9qSvuUQ/GiDTDTrdStnjw5cGwmW6GhMd6lQIoorvbDhZ1y9op
         ASBCkSNCc/a+h1mCu4E2Ha3OyJQRmYDd3OrsZvamERV2JXeTEEU72PMYw+o/HszqTkwU
         4ec6YOG40uG3661ZnxoI+hW08D2uAbvTEVxjfoKfIs+UQ6nuPg2Q7PE90cdt8MAX6d75
         NsAFLAAi8dKoUX5irKmmn97Aqqs7eV2cO5nGmq81a4WO+NRJCuvqPjtnvYNatdL8rTf/
         Xxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701806786; x=1702411586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlqC0mLlbsamWeTdymhvWwnQu+epiSDRN+zbg2hBOUA=;
        b=h1mxqNGfcLynSHPCKwXK20IppjWzdv4cRiAsxrbH/K6DHcQCBmSUGj88GQp+QXZy/Y
         lx5xQzauWLWXW8zlIpM9DlDT/fxpRU2R26TAEikDnMn3edMrSENysYKQ19/qq468mwax
         ukpTYiQWLosGHZOUtFdahMEEEuqW6oOBNMjY+/QBtVsDbhJ022qjNc6GvxlyWsM4blHE
         oNYLdRf0r83B4olqp25i9Eog0YGrBCrqxQr9c4qM+qHMC38PIuITo9hA5qlqTvbJfDsa
         WubaPB3fCqzdUmNrPGNUMfQbHuiAIHrKtkmUJOV1Fdg+oKKtGumfoEdYjizRCsPfBBu7
         DNsg==
X-Gm-Message-State: AOJu0YwhrIML005qato4tW7mIQhaYe1guDIXxgD868k2LGQoyTyVoerI
	2thiXYVSaUy9pfMtg8mfq2offdXFZO+ZWLAA5HY3HA==
X-Google-Smtp-Source: AGHT+IGOdUeVb0c9zBSJgx9rodC7t4Ia+OxD3ogESh9JYVWU23yxaj5p6I3M/sO6DE0hSoEHtwbw4cUyG+qyicjsc1E=
X-Received: by 2002:a17:906:1c8c:b0:a18:ad93:460d with SMTP id
 g12-20020a1709061c8c00b00a18ad93460dmr818197ejh.69.1701806786537; Tue, 05 Dec
 2023 12:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130194023.4102148-5-nphamcs@gmail.com> <20231205193307.2432803-1-nphamcs@gmail.com>
In-Reply-To: <20231205193307.2432803-1-nphamcs@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 5 Dec 2023 12:05:48 -0800
Message-ID: <CAJD7tkarJydo0eYwRv+0cNHOBzBSEy-_xKMtcKBh4Kh3nXBFQQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] mm: memcg: add per-memcg zswap writeback stat (fix)
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, cerasuolodomenico@gmail.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com, 
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 11:33=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> Rename ZSWP_WB to ZSWPWB to better match the existing counters naming
> scheme.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

For the original patch + this fix:

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  include/linux/vm_event_item.h | 2 +-
>  mm/memcontrol.c               | 2 +-
>  mm/vmstat.c                   | 2 +-
>  mm/zswap.c                    | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.=
h
> index f4569ad98edf..747943bc8cc2 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -142,7 +142,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT=
,
>  #ifdef CONFIG_ZSWAP
>                 ZSWPIN,
>                 ZSWPOUT,
> -               ZSWP_WB,
> +               ZSWPWB,
>  #endif
>  #ifdef CONFIG_X86
>                 DIRECT_MAP_LEVEL2_SPLIT,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 21d79249c8b4..0286b7d38832 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -703,7 +703,7 @@ static const unsigned int memcg_vm_event_stat[] =3D {
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>         ZSWPIN,
>         ZSWPOUT,
> -       ZSWP_WB,
> +       ZSWPWB,
>  #endif
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         THP_FAULT_ALLOC,
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 2249f85e4a87..cfd8d8256f8e 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1401,7 +1401,7 @@ const char * const vmstat_text[] =3D {
>  #ifdef CONFIG_ZSWAP
>         "zswpin",
>         "zswpout",
> -       "zswp_wb",
> +       "zswpwb",
>  #endif
>  #ifdef CONFIG_X86
>         "direct_map_level2_splits",
> diff --git a/mm/zswap.c b/mm/zswap.c
> index c65b8ccc6b72..0fb0945c0031 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -761,9 +761,9 @@ static enum lru_status shrink_memcg_cb(struct list_he=
ad *item, struct list_lru_o
>         zswap_written_back_pages++;
>
>         if (entry->objcg)
> -               count_objcg_event(entry->objcg, ZSWP_WB);
> +               count_objcg_event(entry->objcg, ZSWPWB);
>
> -       count_vm_event(ZSWP_WB);
> +       count_vm_event(ZSWPWB);
>         /*
>          * Writeback started successfully, the page now belongs to the
>          * swapcache. Drop the entry from zswap - unless invalidate alrea=
dy
> --
> 2.34.1

