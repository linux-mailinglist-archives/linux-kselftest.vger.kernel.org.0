Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ABC50CB2C
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Apr 2022 16:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiDWObG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 23 Apr 2022 10:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiDWObG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 23 Apr 2022 10:31:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B71727FF7
        for <linux-kselftest@vger.kernel.org>; Sat, 23 Apr 2022 07:28:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d11b6259adso94075967b3.19
        for <linux-kselftest@vger.kernel.org>; Sat, 23 Apr 2022 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DXAXkVZYPHcetFXE1oISHIeSMz1Xot5LLxB15W3LMjk=;
        b=tQibwGA8uz8Ue+E3pvs+c8ZLtax4gGb4dFOV3dy8bzYAyRQotxBRYtX3oExAAr/e5W
         lcJykMgKZDqXuCRcUTWrpgdKqNqa7SDK7R5LQ1iWkeMFOMj4/GvkIliYrru0Fcz3ot5h
         cvD+hIJBFRnHqnE3eBGsznogk3ef/KiPrus6ZbeRLGrGf+/GlLHeLPEohW773ai5NpM2
         pXrvOgHb8VQuBDo7BbJ8vcpHd3CLD6msHLW5xjWZJUln3dl7h6R0dYjUMivzqyXucYGI
         E+67TMHQeiyQW5PXgSo8AKsLGTtBzdyQAAlPZ+C99mPyDJfjZvDTgswF9XlojwtZrxoc
         qXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DXAXkVZYPHcetFXE1oISHIeSMz1Xot5LLxB15W3LMjk=;
        b=XCv9aPJjLYvl0/lLZM49R75KExVBnmS6m746CzawW1ZrXtMRBiCOqHyG12dp0oKhBs
         sx2BDvh0bJb9VOqoLocYu1Gm7eEQVPwTAjBpVA/yRD9Zzwl9GFxcWd5ZmAVb2Cm2WHGU
         xE9+JBQkWxRfmCxF4OMvl0T7LMlF5qhtqYRdFLMfRFMm0iEQuxI70wleyxwqRFVNyrKP
         NUzguXg7vTs0TeelfNhZGnT4Aw+zBZ2T4J3Y00jXqfrXgZ6AFnk2TkZyMHJAIk+IMIP6
         BYOJUzg/yX3kjxQFlUrk7rX38YF3qDaYV6rkcFVkEI73IBh5eCkOUM2XqSlHBd+w9Vzz
         fPCA==
X-Gm-Message-State: AOAM531cI0GYgvcQHZGvJwXqDFjiu+4DTg84Ntx595GUeX80gJhT9MlO
        ORhPDU/S3aNeF0E1lVTlDt7Q9oNNUHbxGA==
X-Google-Smtp-Source: ABdhPJymwLMUEIWwXLSUSEFl1hrUHDozuSw0iJLPBiMCTcvECf3BdD1JzQSLUMCkewcVDkKmZFBQ5OvW5vc+iw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a05:6902:124b:b0:644:c3bf:fa2d with SMTP
 id t11-20020a056902124b00b00644c3bffa2dmr9159316ybu.462.1650724084357; Sat,
 23 Apr 2022 07:28:04 -0700 (PDT)
Date:   Sat, 23 Apr 2022 14:28:01 +0000
In-Reply-To: <20220421234426.3494842-5-yosryahmed@google.com>
Message-Id: <20220423142801.gnvd42cdcsz4hpon@google.com>
Mime-Version: 1.0
References: <20220421234426.3494842-1-yosryahmed@google.com> <20220421234426.3494842-5-yosryahmed@google.com>
Subject: Re: [PATCH v4 4/4] selftests: cgroup: add a selftest for memory.reclaim
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 21, 2022 at 11:44:26PM +0000, Yosry Ahmed wrote:
> Add a new test for memory.reclaim that verifies that the interface
> correctly reclaims memory as intended, from both anon and file pages.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  .../selftests/cgroup/test_memcontrol.c        | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index f2ffb3a30194..5f7c20de2426 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -760,6 +760,91 @@ static int test_memcg_max(const char *root)
>  	return ret;
>  }
>  
> +/*
> + * This test checks that memory.reclaim reclaims the given
> + * amount of memory (from both anon and file).
> + */
> +static int test_memcg_reclaim(const char *root)
> +{
> +	int ret = KSFT_FAIL, fd, retries;
> +	char *memcg;
> +	long current, to_reclaim;
> +	char buf[64];
> +
> +	memcg = cg_name(root, "memcg_test");
> +	if (!memcg)
> +		goto cleanup;
> +
> +	if (cg_create(memcg))
> +		goto cleanup;
> +
> +	current = cg_read_long(memcg, "memory.current");
> +	if (current != 0)
> +		goto cleanup;
> +
> +	cg_run_nowait(memcg, alloc_anon_noexit, (void *) MB(50));

Don't you need is_swap_enabled() check before deciding to do the anon
allocations?

> +	sleep(1);
> +
> +	fd = get_temp_fd();
> +	if (fd < 0)
> +		goto cleanup;
> +
> +	cg_run_nowait(memcg, alloc_pagecache_50M_noexit, (void *)(long)fd);
> +	sleep(1);

These sleep(1)s do not seem robust. Since kernel keeps the page cache
around, you can convert anon to use tmpfs and use simple cg_run to
trigger the allocations of anon (tmpfs) and file which will remain in
memory even after return from cg_run.
