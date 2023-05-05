Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173406F7D53
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 May 2023 08:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjEEG62 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 May 2023 02:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEEG61 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 May 2023 02:58:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B037EE8
        for <linux-kselftest@vger.kernel.org>; Thu,  4 May 2023 23:58:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24de3a8bfcfso1369781a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 May 2023 23:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683269906; x=1685861906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZDZ1+PjAiEZQtoPwEy9pwtEVxFqufFD3zBczSh3kD0=;
        b=StEakw9a6lVCtkkEDv+4BvHR6Wxf2jL87YZFGjZTg8SLV7DE4N46KkWbEKPf4uwZAt
         HCa1BPcXKaZhaEW8+73m04vnLkvuSEl6BXzAph2jE7xGC727EywReRr63soA21KEw9P7
         PzCf1n51YIDbT3i0eLwu/sJxZYDOxqFr1fjg0IRUxqJF8bz8aipGOqkA6gzuKx88fh4r
         vcyb5VL/BJBJWkbyPfgMLVpQ3VL7I2FGfaQKslLoJd1UXiCW2xOsHUgA9afEBOtWRnvY
         oujpFKRrLeopu4RIEJONocyherWKTyiUh/+G/pvjPnl31dBJTRRWGgiQSHt+ENpuX+DW
         xqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683269906; x=1685861906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZDZ1+PjAiEZQtoPwEy9pwtEVxFqufFD3zBczSh3kD0=;
        b=A+tF8PnqoIzWdPNinUCgYagUqBSPbcAHNP563vDCTiqEkfYuJCGJkTclrtT6bexdR6
         2gWO6l29C05eIfWcZyGlvcKNEf4jZLTrDaZhfwMvYFsvFrU13SP8hM1OKl4Np8UiaETe
         1sqDaRl7XKXg6oC1R1U2dEqrZEzwM5g5FEq6urqJgS3rq5iHKWPHV0i5boPUdcVpsuT2
         NAUHV8GdGWQV44kYXBRjh77dzcWs7kKipaM4HY1RplLrYoDDbvtSFDP8fy0FsmplB7vX
         ebQcHvR34CxPSb0YjoQYdE4bg6DH3mL4fkCF3qo3aL/AINvQaHRtDoqcSyK1rNpFzBPg
         fwMw==
X-Gm-Message-State: AC+VfDwzp9G21aruUantKY7VBHhtFoQmLpXr93FY7cSVHjLtdJlpK0q6
        3DEge0GXKK4e9acaTBOpZ3S74+/PbAYrmE2R3p0pvg==
X-Google-Smtp-Source: ACHHUZ4SWTqEC3IZtUTnvtU12URfI9P+BglBCPYWIN5VCnI4J1XVYn4ycqypNKlFeDZEtmxQ2wltXFiQol+b2xk4IO8=
X-Received: by 2002:a17:90b:390e:b0:24e:3254:5d94 with SMTP id
 ob14-20020a17090b390e00b0024e32545d94mr426092pjb.40.1683269905994; Thu, 04
 May 2023 23:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230505060818.60037-1-zhoufeng.zf@bytedance.com> <20230505060818.60037-2-zhoufeng.zf@bytedance.com>
In-Reply-To: <20230505060818.60037-2-zhoufeng.zf@bytedance.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 4 May 2023 23:58:14 -0700
Message-ID: <CA+khW7g_gq1N=cNHC-5WG2nZ8a-wHSpwg_fc5=dQpkweGvROqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Add bpf_task_under_cgroup() kfunc
To:     Feng zhou <zhoufeng.zf@bytedance.com>
Cc:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, yangzhenze@bytedance.com,
        wangdongdong.6@bytedance.com
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

On Thu, May 4, 2023 at 11:08=E2=80=AFPM Feng zhou <zhoufeng.zf@bytedance.co=
m> wrote:
>
<...>
> ---
>  kernel/bpf/helpers.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index bb6b4637ebf2..453cbd312366 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2149,6 +2149,25 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 =
cgid)
>                 return NULL;
>         return cgrp;
>  }
> +
> +/**
> + * bpf_task_under_cgroup - wrap task_under_cgroup_hierarchy() as a kfunc=
, test
> + * task's membership of cgroup ancestry.
> + * @task: the task to be tested
> + * @ancestor: possible ancestor of @task's cgroup
> + *
> + * Tests whether @task's default cgroup hierarchy is a descendant of @an=
cestor.
> + * It follows all the same rules as cgroup_is_descendant, and only appli=
es
> + * to the default hierarchy.
> + */
> +__bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
> +                                      struct cgroup *ancestor)
> +{
> +       if (unlikely(!ancestor || !task))
> +               return -EINVAL;
> +
> +       return task_under_cgroup_hierarchy(task, ancestor);
> +}
>  #endif /* CONFIG_CGROUPS */
>

I wonder in what situation a null 'task' or 'ancestor' can be passed.
Please call out in the comment that the returned value can be a
negative error, so that writing if(bpf_task_under_cgroup()) may cause
surprising results.

Hao
