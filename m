Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782CC734B4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 07:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjFSFTf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 01:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFSFTe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 01:19:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABBDA4
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jun 2023 22:19:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-988a2715b8cso118389766b.0
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jun 2023 22:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687151971; x=1689743971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkIBRh1CRI7l1b26sTYaQ/9/gUUFxPZU0t2NyWKWH7Q=;
        b=eUeNwGRZOej+JmaNNUaJ6OPJIgJYdwORyCeMfKZTOjdOO76BnXQtHBcPlqW8xlMFQY
         s1nvqNLfu7R+DtrblqmhCcyNv9raxlOUrGUkijSYF2DLN/Fx1lHmAyyGItjJsLQKZ9SB
         GPfMkm2H1dEBHmBvUMD1gOtZO1fVM3k/h0NmiHlxO9RkzW6RQBtin+wJYQW/lxXbrH2y
         2jT67uQLUKUbBewiI+qS3az+zA4/Ja0YIqT9Cp1VvKdGyGO7ldm1/RKTqK5ZdG6UMaPi
         c/6Ert/O4bIexYOn5ii9geuHAbjF/UjC8Wjr754r+o8/7VgLwsDMrXGWCp8mWr05623N
         VqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687151971; x=1689743971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkIBRh1CRI7l1b26sTYaQ/9/gUUFxPZU0t2NyWKWH7Q=;
        b=MO3qKLYhAhN4FJ73R3znQcgOW4NLLKzxygpN6swexk6TapvdJgzfFfBM+RiRVnDtle
         KYxOEespZyQD1PauMf53Ji7wXhDz3kistzrPSQtBabW+iXGMUKSAtbAom8beNThVlwZj
         X3Z+S317N8gwB3hEI+l0C8NkaNbF9v4K+dYaZwU11UQVQvPxWMGStoCwLNystaGMBEp3
         QPqSXeXLHumJtv3NQ8NjXSFTpyNS7VBrKP3vsA04srvohHnmj6DkVaQZqgWr26iAoSka
         oIql5e7VzEVGEuO7uy40n3xwYTJaKXz5XyHGFiiSIay0MoLg49+fr2gn59PWe8qM9nUB
         Nzpw==
X-Gm-Message-State: AC+VfDxBzcdxKOHxAK70usWOdxWBTX4wJwD0R05XqelI+XpRbZ/iI5YI
        Xp+UjSLi56MRrkcTnzEt86F0gVt7KC9jKI2CAk0Euw==
X-Google-Smtp-Source: ACHHUZ71H1JCg8qVnIn2avxbwYZAfCJAhaV/i8QHAcldJFca6caRKDrrFVg7SKgaFiydxOgLaPuVe+XBQIA36QYs2Qk=
X-Received: by 2002:a17:907:2d10:b0:988:7209:f42 with SMTP id
 gs16-20020a1709072d1000b0098872090f42mr2344570ejc.7.1687151971080; Sun, 18
 Jun 2023 22:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230619051715.2306134-1-yosryahmed@google.com>
In-Reply-To: <20230619051715.2306134-1-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sun, 18 Jun 2023 22:18:54 -0700
Message-ID: <CAJD7tkYspn8LwCDh2fjfGePWbRB405M3d1tgtax_4dGFSk3jBg@mail.gmail.com>
Subject: Re: [PATCH] selftests/cgroup: allow running a specific test with test_memcontrol
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 18, 2023 at 10:17=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> It is handy during testing and/or debugging to be able to run a single
> test from test_memcontrol. Allow passing in a test name through a
> command line argument (e.g. ./test_memcontrol -t test_memcg_recharge).
>
> Change-Id: I0e0d74d81fdd9d997987389085a816715160467f

I missed removing this gerrit tag, sorry. Will fix it if/when I respin.

> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  .../selftests/cgroup/test_memcontrol.c        | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/tes=
ting/selftests/cgroup/test_memcontrol.c
> index a2a90f4bfe9f..d8f8a13bc6c4 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -1308,9 +1308,36 @@ struct memcg_test {
>
>  int main(int argc, char **argv)
>  {
> +       int opt;
>         char root[PATH_MAX];
> +       int selected_test =3D -1;
>         int i, proc_status, ret =3D EXIT_SUCCESS;
>
> +       while ((opt =3D getopt(argc, argv, "ht:")) !=3D -1) {
> +               switch (opt) {
> +               case 't':
> +                       for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
> +                               if (!strcmp(tests[i].name, optarg)) {
> +                                       selected_test =3D i;
> +                                       break;
> +                               }
> +                       }
> +                       if (selected_test >=3D 0)
> +                               break;
> +                       fprintf(stderr, "test %s not found\n", optarg);
> +                       return EXIT_FAILURE;
> +               case 'h':
> +                       fprintf(stderr,
> +                               "Usage: %s [-h] [-t name]\n"
> +                               "\t-h       print help\n"
> +                               "\t-t name  run specific test\n"
> +                               , argv[0]);
> +                       return ret;
> +               default:
> +                       break;
> +               }
> +       }
> +
>         if (cg_find_unified_root(root, sizeof(root)))
>                 ksft_exit_skip("cgroup v2 isn't mounted\n");
>
> @@ -1336,6 +1363,9 @@ int main(int argc, char **argv)
>         has_localevents =3D proc_status;
>
>         for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
> +               if (selected_test >=3D 0 && selected_test !=3D i)
> +                       continue;
> +
>                 switch (tests[i].fn(root)) {
>                 case KSFT_PASS:
>                         ksft_test_result_pass("%s\n", tests[i].name);
> --
> 2.41.0.162.gfafddb0af9-goog
>
