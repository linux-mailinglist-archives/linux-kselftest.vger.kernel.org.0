Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DE57CD0CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 01:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjJQXe5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 19:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjJQXe4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 19:34:56 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E997892;
        Tue, 17 Oct 2023 16:34:54 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7a25040faffso266991339f.1;
        Tue, 17 Oct 2023 16:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697585694; x=1698190494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RUVRQvIEB8Ness9Y/D/FOyjF48X8zrSw0Y9Wp3BIKk=;
        b=RrQZJlXuJuvvxEmql7X5ypEXu4AO2BNyLCdl4Fu3w/pl2aAZY3WZzTZ6AC+bcg00Hl
         zvSvKIEnKZYwyEk4IRJcZ3kg+I9XCa+jhrmDF9arvuPwz+XPGBquFWM8erzEZmBR0GNC
         DHRSzxHBL0zkx33O4kfJw0TO+7bCUdbwLEAWVCKbqQZgi/yJNoaKZLsgXPgPnp9870ub
         zByP8gvx6NVbhiRcd0r7lkjV93k7pzHcg77q2VDarffHUueeEUeweA44FU+4rzqwY464
         Eb8/SNdZzux0mDDkpM0VXvN3wNDeZcJwinnV05aIxaQUPQ6TJNRW4VA7jBA/m7x5gxql
         Evew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697585694; x=1698190494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RUVRQvIEB8Ness9Y/D/FOyjF48X8zrSw0Y9Wp3BIKk=;
        b=w9epMkKfrN+rwBzqUPcqmH2N6W63+jPFkhItv7+q5yYvl5G9H1r1l3Q1I1tpvJIIA+
         iANPzRO3yuFRet6z9/oRBZSE2VubTJY8Lgs0tu1PLln6/gZteSoPv6iKgH7PWELZY/io
         pFKUXkrsQLAY+oU5nGQm0gTKRMOv5SoNDFECIKiJjXBoQwoYg/pupSBqkIn26pLoFfJ7
         Va0P8rhtDUnalk1VdP6Tc9ldT7Mz9bkQQgnR9VUhyMMLplQLgaKmMZgLkcwlWwWbJKE2
         knE0BbyxTRlveJYz/oird2Un14/XIJwU3MXNYtKkzKZu+z/0vUJdjSdwB95y/CqXF7J/
         Ui+Q==
X-Gm-Message-State: AOJu0YwSwug7Rd14EIxOnulqQFlMsJVqx9oJWseKpKW3NKUasHUjK329
        2L4qhrDCFU2YKuE9lMr1uHCj43u0gAud0ooau+6Ah9Bq4TZq2GEB
X-Google-Smtp-Source: AGHT+IHNpjwYivjfLnBuHyeXolttmsdPz2+T48nLOGhSe/Xrd/3V5FFzq9IYPm46z13Xje7ZyST4TBhWn+nExI6QDOU=
X-Received: by 2002:a05:6602:2dcd:b0:791:16ba:d764 with SMTP id
 l13-20020a0566022dcd00b0079116bad764mr5165267iow.16.1697585694198; Tue, 17
 Oct 2023 16:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231017232152.2605440-1-nphamcs@gmail.com> <20231017232152.2605440-5-nphamcs@gmail.com>
In-Reply-To: <20231017232152.2605440-5-nphamcs@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 17 Oct 2023 16:34:41 -0700
Message-ID: <CAKEwX=N+z779m2mdniiccs=+24XRBDZjqZbE7FAUm6vfnjG+qQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selftests: cgroup: update per-memcg zswap
 writeback selftest
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
> The memcg-zswap self test is updated to adjust to the behavior change
> implemented by commit 87730b165089 ("zswap: make shrinking memcg-aware"),
> where zswap performs writeback for specific memcg.
>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

/s/Signed-off/Acked
This is Domenico's work :) I used the wrong tag here. Should be:
Acked-by: Nhat Pham <nphamcs@gmail.com>

> ---
>  tools/testing/selftests/cgroup/test_zswap.c | 74 ++++++++++++++-------
>  1 file changed, 50 insertions(+), 24 deletions(-)
>
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/=
selftests/cgroup/test_zswap.c
> index 49def87a909b..11271fabeffc 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -50,9 +50,9 @@ static int get_zswap_stored_pages(size_t *value)
>         return read_int("/sys/kernel/debug/zswap/stored_pages", value);
>  }
>
> -static int get_zswap_written_back_pages(size_t *value)
> +static int get_cg_wb_count(const char *cg)
>  {
> -       return read_int("/sys/kernel/debug/zswap/written_back_pages", val=
ue);
> +       return cg_read_key_long(cg, "memory.stat", "zswap_wb");
>  }
>
>  static int allocate_bytes(const char *cgroup, void *arg)
> @@ -68,45 +68,71 @@ static int allocate_bytes(const char *cgroup, void *a=
rg)
>         return 0;
>  }
>
> +static char *setup_test_group_1M(const char *root, const char *name)
> +{
> +       char *group_name =3D cg_name(root, name);
> +
> +       if (!group_name)
> +               return NULL;
> +       if (cg_create(group_name))
> +               goto fail;
> +       if (cg_write(group_name, "memory.max", "1M")) {
> +               cg_destroy(group_name);
> +               goto fail;
> +       }
> +       return group_name;
> +fail:
> +       free(group_name);
> +       return NULL;
> +}
> +
>  /*
>   * When trying to store a memcg page in zswap, if the memcg hits its mem=
ory
> - * limit in zswap, writeback should not be triggered.
> - *
> - * This was fixed with commit 0bdf0efa180a("zswap: do not shrink if cgro=
up may
> - * not zswap"). Needs to be revised when a per memcg writeback mechanism=
 is
> - * implemented.
> + * limit in zswap, writeback should affect only the zswapped pages of th=
at
> + * memcg.
>   */
>  static int test_no_invasive_cgroup_shrink(const char *root)
>  {
> -       size_t written_back_before, written_back_after;
>         int ret =3D KSFT_FAIL;
> -       char *test_group;
> +       size_t control_allocation_size =3D MB(10);
> +       char *control_allocation, *wb_group =3D NULL, *control_group =3D =
NULL;
>
>         /* Set up */
> -       test_group =3D cg_name(root, "no_shrink_test");
> -       if (!test_group)
> -               goto out;
> -       if (cg_create(test_group))
> +       wb_group =3D setup_test_group_1M(root, "per_memcg_wb_test1");
> +       if (!wb_group)
> +               return KSFT_FAIL;
> +       if (cg_write(wb_group, "memory.zswap.max", "10K"))
>                 goto out;
> -       if (cg_write(test_group, "memory.max", "1M"))
> +       control_group =3D setup_test_group_1M(root, "per_memcg_wb_test2")=
;
> +       if (!control_group)
>                 goto out;
> -       if (cg_write(test_group, "memory.zswap.max", "10K"))
> +
> +       /* Push some test_group2 memory into zswap */
> +       if (cg_enter_current(control_group))
>                 goto out;
> -       if (get_zswap_written_back_pages(&written_back_before))
> +       control_allocation =3D malloc(control_allocation_size);
> +       for (int i =3D 0; i < control_allocation_size; i +=3D 4095)
> +               control_allocation[i] =3D 'a';
> +       if (cg_read_key_long(control_group, "memory.stat", "zswapped") < =
1)
>                 goto out;
>
> -       /* Allocate 10x memory.max to push memory into zswap */
> -       if (cg_run(test_group, allocate_bytes, (void *)MB(10)))
> +       /* Allocate 10x memory.max to push wb_group memory into zswap and=
 trigger wb */
> +       if (cg_run(wb_group, allocate_bytes, (void *)MB(10)))
>                 goto out;
>
> -       /* Verify that no writeback happened because of the memcg allocat=
ion */
> -       if (get_zswap_written_back_pages(&written_back_after))
> -               goto out;
> -       if (written_back_after =3D=3D written_back_before)
> +       /* Verify that only zswapped memory from gwb_group has been writt=
en back */
> +       if (get_cg_wb_count(wb_group) > 0 && get_cg_wb_count(control_grou=
p) =3D=3D 0)
>                 ret =3D KSFT_PASS;
>  out:
> -       cg_destroy(test_group);
> -       free(test_group);
> +       cg_enter_current(root);
> +       if (control_group) {
> +               cg_destroy(control_group);
> +               free(control_group);
> +       }
> +       cg_destroy(wb_group);
> +       free(wb_group);
> +       if (control_allocation)
> +               free(control_allocation);
>         return ret;
>  }
>
> --
> 2.34.1
