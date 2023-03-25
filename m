Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CFE6C906D
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 20:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCYTYN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Mar 2023 15:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCYTYN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Mar 2023 15:24:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7AB30C0;
        Sat, 25 Mar 2023 12:24:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p12-20020a05600c468c00b003ef5e6c39cdso1832336wmo.3;
        Sat, 25 Mar 2023 12:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679772250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tcnVA78wkVzbPfXfOJ2LEcC0Y+HKxsbDQcgFdv0NWhs=;
        b=Pocj9XuByR3+O92iq2mpvWIyQvZt/GKsOhuWboG4VjE1ElKkX0M4H1lkjCsl8CpzN7
         S+ad7YC4Ka3kz9ZCYnsWJks1NnAiyglsLk+s6xRkdqAIUP00quC16G8Z9x34sQQnbVbh
         jXBzC2ksIhiCRSVP/MOIxnJmAhqk8Q6+f/7JQGHIzgfUrQe7Yv8LsVLO1lYNvzya9RKz
         U28nihqEM2vbM0F4Kt/8TRoNk0jFm74V7HhKDqzntjVTk83BhJ3v+NIHGkJYLjZJWVAS
         mLB6Ocrk+OH0cPdE/HE/QAXFeE7sILEp4687gd04apIH9gcHkTvWB1FuHftWvYlbmvPv
         vTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679772250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcnVA78wkVzbPfXfOJ2LEcC0Y+HKxsbDQcgFdv0NWhs=;
        b=4ptpIv0vGn4iEd7EkM/pvlwoWhde+wDX63r2d2+7uPsgJLQqqQw59e6A0sTJYxoJDo
         2ks1SYRH8M5zwB+Cw1ioxCwEW8JomItxROAywz+x3B3A/J7cbo5yyWHZ3mH2OhDi3hGn
         I4q2Qetvrn4tH0lTL//xu+BQHbsr0hNAruDhFB1ODv6CvQOs3YDmFp33ibq4o/r46Jeo
         fPvDlyhU2TP0DY/59H1S6M+25lpMNEaTqOpTeH2GJoSErL6aIDmPKvtgt60yq3HmTpQN
         lUCvgvFwjBJP4m09g6UGCgHM1VelyE2MFyQ5vO5ios+QoxH/AJ+VRbtP0qmXJSTmHqa0
         eC9w==
X-Gm-Message-State: AO0yUKVYFoEweWNetFcuhdmFwNssdjYFAYrOoxM7GUfjcCdcccnlRFJZ
        /JdU5iWzU+N+7WJkKmtpXoU=
X-Google-Smtp-Source: AK7set/U2CC6eWEHlcDRZJcCoHMyfxS7P7nSp0cEP3JJ0eMW68/jHSmYtAF9YnCen6KiCRPQ65XWwA==
X-Received: by 2002:a05:600c:286:b0:3ee:7f0b:387b with SMTP id 6-20020a05600c028600b003ee7f0b387bmr4567366wmk.17.1679772250121;
        Sat, 25 Mar 2023 12:24:10 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id t9-20020a1c7709000000b003ed1ff06faasm8573061wmi.19.2023.03.25.12.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 12:24:09 -0700 (PDT)
Date:   Sat, 25 Mar 2023 19:24:08 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Jay Kamat <jgkamat@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests: cgroup: Fix exception handling in
 test_memcg_oom_group_score_events()
Message-ID: <fffcd98a-bb73-41cd-8545-0f2c55dd38f9@lucifer.local>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <c383bdca-6f0d-4a75-e788-e1920faa0a62@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c383bdca-6f0d-4a75-e788-e1920faa0a62@web.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 25, 2023 at 07:30:21PM +0100, Markus Elfring wrote:
> Date: Sat, 25 Mar 2023 19:11:13 +0100
>
> The label “cleanup” was used to jump to another pointer check despite of
> the detail in the implementation of the function
> “test_memcg_oom_group_score_events” that it was determined already
> that a corresponding variable contained a null pointer.

This is poorly writte and confusing. Something like 'avoid unnecessary null
check/cg_destroy() invocation' would be far clearer.

>
> 1. Thus return directly after a call of the function “cg_name” failed.
>

This feels superfluious.

> 2. Use an additional label.

This also feels superfluious.

>
> 3. Delete a questionable check.

This seems superfluois and frankly, rude. It's not questionable, it's
readable, you should try to avoid language like 'questionable' when the
purpose of the check is obvious.

>
>
> This issue was detected by using the Coccinelle software.
>
> Fixes: a987785dcd6c8ae2915460582aebd6481c81eb67 ("Add tests for memory.oom.group")

Fixes what in the what now? This is not a bug fix, it's a 'questionable'
refactoring.

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  tools/testing/selftests/cgroup/test_memcontrol.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index f4f7c0aef702..afcd1752413e 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -1242,12 +1242,11 @@ static int test_memcg_oom_group_score_events(const char *root)
>  	int safe_pid;
>
>  	memcg = cg_name(root, "memcg_test_0");
> -
>  	if (!memcg)
> -		goto cleanup;
> +		return ret;
>
>  	if (cg_create(memcg))
> -		goto cleanup;
> +		goto free_cg;
>
>  	if (cg_write(memcg, "memory.max", "50M"))
>  		goto cleanup;
> @@ -1275,8 +1274,8 @@ static int test_memcg_oom_group_score_events(const char *root)
>  	ret = KSFT_PASS;
>
>  cleanup:
> -	if (memcg)
> -		cg_destroy(memcg);
> +	cg_destroy(memcg);
> +free_cg:
>  	free(memcg);
>
>  	return ret;
> --
> 2.40.0
>
>

I dislike this patch, it adds complexity for no discernible purpose and
actively makes the code _less_ readable and in a self-test of all places (!)

Not all pedantic Coccinelle results are actionable. Remember that it's
humans who are reading the code.

Your email client/scripting is still somehow broken, I couldn't get b4 to
pull it correctly and it seems to have a duplicate message ID. You really
need to take a look at that (git send-email should do this fine for
example).

Please try to filter the output of Coccinelle and instead of spamming
thousands of pointless patches that add no value, try to choose those that
do add value.

My advice overall would be to just stop.
