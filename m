Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECD57CD0D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 01:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjJQXf3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 19:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbjJQXf2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 19:35:28 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD1F92;
        Tue, 17 Oct 2023 16:35:26 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-357a354e616so459015ab.1;
        Tue, 17 Oct 2023 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697585726; x=1698190526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdTkOsSZlVefGaBdezW5bHhWJDivZZTWywSdxQVCUN4=;
        b=ClogTTP278oipxTPG9O7Cg50jfqHyHDmJ539pX7Qpn8I1sJ+za8PStycD9RJZ0ZxTt
         S+xgXkPak20IVtZs5+8uQTbQZTZalCkNnK8XlN9Ama67Dtnx+ArUeVFijxtpKwmnCzT/
         nqhqVfEfg80t5r1Lze4rdsIjDd30W+d2GTI4Gy7rhB3r4C2VPc2k5XugMy1HmuuXk2fu
         VZiBWrhFoV/VKZ1w4KnXOG7Ens4kXORVM9vRdaPM0E3ka8OC7UZrlQGuRQHzPTiujj97
         6e6uV8bdN4ksFkpRSQ0S733DKpttHGr1zRCnff02xW0TYLrmwa3kVqpXik3QCngoA/HB
         Njng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697585726; x=1698190526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdTkOsSZlVefGaBdezW5bHhWJDivZZTWywSdxQVCUN4=;
        b=Ib8+16QNMpQE4JDexPBPuebZKtFXOLRImLSTzn4QK6wM3pbClmjcJh0bdilXogsUcE
         /72Xsfkz9NuAvLrWRkmBLvkvJhAziwwayjCaDqW0Uqf8C7Ma34glISrzaLJBVelNUpK5
         WJd8A33hVrd43mOnK5j+cbXPQ5txugwBMc4y3SP0NNCEkjgxBpnTPltuvB4+NYZy5flw
         XBsvQfG8k17WBKQFkgxKwsPkRAO+v25643zTyuNWN1EWmdHY7qAvU0d6l063pmuX7bgg
         dvUc32duGRUpxufex0rlS8k1TKOC9t2ZUMnN3lKfXeEhT3YYXvouzNM2w1Xgu9qbgLfJ
         SC8Q==
X-Gm-Message-State: AOJu0YzVc77N3kg23Ua2RNLrxQ32GB6esbKJOSYfFCFrfylMmcqyB62J
        vvzxuAULZ+HtWzx8kaifs/esKHKdW74rs8UYUeo=
X-Google-Smtp-Source: AGHT+IGNULEr1VCr1CogtesXNMKtN++yHXc6oz2Eu5RJNdWzMlS7JszuvVJ5xImYIQMrxF4YcuRnvOv4uLbYQJgZsbg=
X-Received: by 2002:a05:6e02:3205:b0:351:375f:2a31 with SMTP id
 cd5-20020a056e02320500b00351375f2a31mr3101949ilb.6.1697585726148; Tue, 17 Oct
 2023 16:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231017232152.2605440-1-nphamcs@gmail.com> <20231017232152.2605440-4-nphamcs@gmail.com>
In-Reply-To: <20231017232152.2605440-4-nphamcs@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 17 Oct 2023 16:35:13 -0700
Message-ID: <CAKEwX=NgsbJ6MQJdJoOTDiGyhjhRA8KJdYe5GzV5iK1bRADfuQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm: memcg: add per-memcg zswap writeback stat
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 17, 2023 at 4:21=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>
> Since zswap now writes back pages from memcg-specific LRUs, we now need a
> new stat to show writebacks count for each memcg.
>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

/s/Signed-off/Acked
This is Domenico's work :) I used the wrong tag here. Should be:
Acked-by: Nhat Pham <nphamcs@gmail.com>

> ---
>  include/linux/memcontrol.h |  2 ++
>  mm/memcontrol.c            | 15 +++++++++++++++
>  mm/zswap.c                 |  3 +++
>  3 files changed, 20 insertions(+)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 3de10fabea0f..7868b1e00bf5 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -38,6 +38,7 @@ enum memcg_stat_item {
>         MEMCG_KMEM,
>         MEMCG_ZSWAP_B,
>         MEMCG_ZSWAPPED,
> +       MEMCG_ZSWAP_WB,
>         MEMCG_NR_STAT,
>  };
>
> @@ -1884,6 +1885,7 @@ static inline void count_objcg_event(struct obj_cgr=
oup *objcg,
>  bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
>  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
>  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
> +void obj_cgroup_report_zswap_wb(struct obj_cgroup *objcg);
>  #else
>  static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1bde67b29287..a9118871e5a6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1505,6 +1505,7 @@ static const struct memory_stat memory_stats[] =3D =
{
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>         { "zswap",                      MEMCG_ZSWAP_B                   }=
,
>         { "zswapped",                   MEMCG_ZSWAPPED                  }=
,
> +       { "zswap_wb",                   MEMCG_ZSWAP_WB                  }=
,
>  #endif
>         { "file_mapped",                NR_FILE_MAPPED                  }=
,
>         { "file_dirty",                 NR_FILE_DIRTY                   }=
,
> @@ -1541,6 +1542,7 @@ static int memcg_page_state_unit(int item)
>         switch (item) {
>         case MEMCG_PERCPU_B:
>         case MEMCG_ZSWAP_B:
> +       case MEMCG_ZSWAP_WB:
>         case NR_SLAB_RECLAIMABLE_B:
>         case NR_SLAB_UNRECLAIMABLE_B:
>         case WORKINGSET_REFAULT_ANON:
> @@ -7861,6 +7863,19 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *=
objcg, size_t size)
>         rcu_read_unlock();
>  }
>
> +void obj_cgroup_report_zswap_wb(struct obj_cgroup *objcg)
> +{
> +       struct mem_cgroup *memcg;
> +
> +       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +               return;
> +
> +       rcu_read_lock();
> +       memcg =3D obj_cgroup_memcg(objcg);
> +       mod_memcg_state(memcg, MEMCG_ZSWAP_WB, 1);
> +       rcu_read_unlock();
> +}
> +
>  static u64 zswap_current_read(struct cgroup_subsys_state *css,
>                               struct cftype *cft)
>  {
> diff --git a/mm/zswap.c b/mm/zswap.c
> index d2989ad11814..15485427e3fa 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -704,6 +704,9 @@ static enum lru_status shrink_memcg_cb(struct list_he=
ad *item, struct list_lru_o
>         }
>         zswap_written_back_pages++;
>
> +       if (entry->objcg)
> +               obj_cgroup_report_zswap_wb(entry->objcg);
> +
>         /*
>          * Writeback started successfully, the page now belongs to the
>          * swapcache. Drop the entry from zswap - unless invalidate alrea=
dy
> --
> 2.34.1
