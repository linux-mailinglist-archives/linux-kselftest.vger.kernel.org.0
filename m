Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C05557A542
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbiGSR2d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 13:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbiGSR21 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 13:28:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A2A5A2D5
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 10:28:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j1so18186205wrs.4
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGWTrJ/A2ihWU/Ug7aQjRrDit++Zh+gpJdGLbqVf1ag=;
        b=aQcLJHLSmAz57vMuBvrLAMuiJ9nsj6bTyOPDKgofJNdmDLyZvDjGqvPFf8eyewoclH
         l1l5WETYZVlZ8uJmvS1H1ti0C5X06q29fxB0wCYYKPJxZfRH94Xb1Mn5EMR6/0o1UY8j
         145zovNXLJSR4DnmMp+8wX78v/m524bvc3tJ+FzQf0nT7yT7yXfSyHDUUj3Hy0aaa4lA
         2P6GzyXXUlsVQ6hDfqddxLzfkhz8yvCLArXMHBH3qtEjNqAPGY+Meno0NzZjndBqiLbZ
         KocO65DubKojur00kb9JuLMzyBK5C5SHKSqew69Pcn4b2KCT1iox6ILhl/V1vBrI7fDX
         yCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGWTrJ/A2ihWU/Ug7aQjRrDit++Zh+gpJdGLbqVf1ag=;
        b=ApSG2ApUWvxYp3ieM7SyO+2CCXVXGVCjRbZCP4X7gkXYybwXhaHau+pmvo6uRm75jc
         atVhM/r6dGvNH+oUbPsjYD/klC+yYdDdvWTA2lBULevDhVlznsFSSNxa/5oLMiDpLFqZ
         KfdHT0R2C6WrlaBxmT0F1+8gDkIXcTJpgPMYqYNo5yJwYFKl8DrEgbr/8iHyb1Ti4QHJ
         9WHCOwhSupa7urxp/erk/MpMc/kWRZ//3iKXiUlvTiUS7g1AxkRHx3Hw7DGU5FsALEWL
         0zbxT4SIav9pDW5XrQfRASFYzYuL5kVlu/FMrkNNCDre/0GtFLoyQ4NlCyRizNcCLcaX
         G0wg==
X-Gm-Message-State: AJIora+HJMXHs0oSLYOwXMd8htB0LyMNbIzSMYLgnU2pkrpQItiR99v+
        lJyvlKv7zr8a1SkggJ/V22njTbKiEWja1pCFhE0w9g==
X-Google-Smtp-Source: AGRyM1tBJsBbqZfOaPheraq2qdKwFMuN2cYbU2/3gDb2ExcHHWknED0R67mCoawJmgennwfCC5j2IF55QsfrJAGvaF0=
X-Received: by 2002:a5d:5a82:0:b0:21e:2899:60bd with SMTP id
 bp2-20020a5d5a82000000b0021e289960bdmr5795825wrb.80.1658251692855; Tue, 19
 Jul 2022 10:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <YtZ9Yu6HSQ2sT+O/@kili>
In-Reply-To: <YtZ9Yu6HSQ2sT+O/@kili>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 19 Jul 2022 10:27:36 -0700
Message-ID: <CAJD7tkYCSY1C_iif4dxF9O3dAgZV4u8o9DFGsqeTyaq_FTT+mQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: memcg: uninitialized variable in test_memcg_reclaim()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dan!

On Tue, Jul 19, 2022 at 2:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The "fd" is used on the clean up path without ever being initialized.
>
> Fixes: eae3cb2e87ff ("selftests: cgroup: add a selftest for memory.reclaim")

Thanks for fixing this :)

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I kind of went over kill on fixing this as if it were real code which
> matters.  :P
>
>  .../selftests/cgroup/test_memcontrol.c        | 23 +++++++++++--------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 8833359556f3..08681699c2f9 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -658,18 +658,18 @@ static int test_memcg_reclaim(const char *root)
>
>         memcg = cg_name(root, "memcg_test");
>         if (!memcg)
> -               goto cleanup;
> +               return KSFT_FAIL;

Nit: Just goto free here as well, free ignores NULLs anyway. It's
easier to have fewer return paths and more consistent with other
tests.

>
>         if (cg_create(memcg))
> -               goto cleanup;
> +               goto free_memcg;
>
>         current = cg_read_long(memcg, "memory.current");
>         if (current != 0)
> -               goto cleanup;
> +               goto destroy_memcg;
>
>         fd = get_temp_fd();
>         if (fd < 0)
> -               goto cleanup;
> +               goto destroy_memcg;
>
>         cg_run_nowait(memcg, alloc_pagecache_50M_noexit, (void *)(long)fd);
>
> @@ -697,7 +697,7 @@ static int test_memcg_reclaim(const char *root)
>                         fprintf(stderr,
>                                 "failed to allocate %ld for memcg reclaim test\n",
>                                 expected_usage);
> -                       goto cleanup;
> +                       goto close;
>                 }
>         }
>
> @@ -717,7 +717,7 @@ static int test_memcg_reclaim(const char *root)
>                  * not reclaim the full amount.
>                  */
>                 if (to_reclaim <= 0)
> -                       goto cleanup;
> +                       goto close;
>
>
>                 snprintf(buf, sizeof(buf), "%ld", to_reclaim);
> @@ -729,7 +729,7 @@ static int test_memcg_reclaim(const char *root)
>                          */
>                         current = cg_read_long(memcg, "memory.current");
>                         if (!values_close(current, MB(30), 3) && current > MB(30))
> -                               goto cleanup;
> +                               goto close;
>                         break;
>                 }
>
> @@ -738,14 +738,17 @@ static int test_memcg_reclaim(const char *root)
>                         continue;
>
>                 /* We got an unexpected error or ran out of retries. */
> -               goto cleanup;
> +               goto close;
>         }
>
>         ret = KSFT_PASS;
> -cleanup:
> +
> +close:
> +       close(fd);
> +destroy_memcg:
>         cg_destroy(memcg);
> +free_memcg:
>         free(memcg);
> -       close(fd);
>
>         return ret;
>  }

Nit: keep the cleanup_* naming for labels to make it obvious and to be
consistent with the rest of the file (e.g. cleanup_free,
cleanup_memcg, cleanup_file/cleanup_all). See
test_memcg_subtree_control().

I would honestly have one label to cleanup the memcg. Calling
cg_destroy() on a non-existent memcg should be fine. rmdir() will just
fail silently. All other tests do this and it's easier to read when we
have fewer return paths. My advice would be cleanup_file and
cleanup_memcg labels.

Thanks!

With these nits:
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> --
> 2.35.1
>
