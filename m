Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7B650E949
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 21:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244874AbiDYTS5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 15:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242986AbiDYTS4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 15:18:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E7335A9D
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:15:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so281639pjm.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ecsUxmyFwe8I77x+9cA1HTTii6mLSDL9ggSg8/7/5Lo=;
        b=lSv3D+xXudt8kuycOWKphR/+PTAKkjLYPnzKliiGicQEjNUPwftnMMBs2cG9pNFHPV
         Rx5m56PnLtd6rUJslmzMmG0HpEdKW4PPVfBjF3VEMO4+y8q8bkRuqgB6GFRLiMtUC//+
         dIID5FA51QMkhLndJJnDP4lfVmsSD3tZw1djRdoRfaC+JPv8o1fwE6rkxfTqwELj3BHr
         mXgDscQMSgJLeW+ALlwLXot4+PkLBbSajgNXMds+bAuLTm3k9Vn2cCn7eblMwAcCVs5g
         1aPwVBuFa8VfQ32WIX08L2Ouzo2vqpTVIC81Gj14Rz1jpg4RvV3la7P2rAGcA5/ySaJV
         hj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ecsUxmyFwe8I77x+9cA1HTTii6mLSDL9ggSg8/7/5Lo=;
        b=0q0D9Uu9gtJSQsQ8whVjmsDaLXmBKVRuAgb1GI+b1xf3c8YWQIbAVvA12+6BKubIHP
         /UO/1SbzVN9/8vb8hpS2KZH+6N9WFMyyV27xu/DtV8R/eAbAvPeIEDfUoJjvz4izxzri
         FfDJQgSIUDJkBOhtkSpd6/mJmB969O/PM11WEhq2ILA+1CLvix1aDAkxV++sDFz9tfiL
         7JLnwuSeWjhAIYRqLll2zh7vglQVG9jBEUuZzxSQqDZon3w4S/Y9qVb/Fsm6ROZe3k2P
         2tWQw9XuqDj+bBgm07a5x7dVsEDVDioGjKbFU8UARWnlhYA35Fn214cpvhM0HmxSsgsh
         bzNg==
X-Gm-Message-State: AOAM530ggvzDoD0t13Awg5XkS0+QO/CCOQlnjhoVXp1MSzutMMM+Sy1u
        6BNdBH1/q91aYeuIRQok+k4w3g==
X-Google-Smtp-Source: ABdhPJxVDk2aBeKX93y2/cNj0dtdmux5xztwRbAL9FG9GNAcURiUqYol+3kkAIs0S0BKpuya0KJacA==
X-Received: by 2002:a17:90a:b10c:b0:1d9:49de:81c5 with SMTP id z12-20020a17090ab10c00b001d949de81c5mr12523263pjq.120.1650914149899;
        Mon, 25 Apr 2022 12:15:49 -0700 (PDT)
Received: from [2620:15c:29:204:185b:8dcc:84d4:fb71] ([2620:15c:29:204:185b:8dcc:84d4:fb71])
        by smtp.gmail.com with ESMTPSA id i11-20020a654d0b000000b0039d82c3e68csm10711275pgt.55.2022.04.25.12.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 12:15:49 -0700 (PDT)
Date:   Mon, 25 Apr 2022 12:15:48 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v5 1/4] memcg: introduce per-memcg reclaim interface
In-Reply-To: <20220425190040.2475377-2-yosryahmed@google.com>
Message-ID: <a4c3d067-d08d-409d-e7b-b6e0b1d2dfda@google.com>
References: <20220425190040.2475377-1-yosryahmed@google.com> <20220425190040.2475377-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 25 Apr 2022, Yosry Ahmed wrote:

> From: Shakeel Butt <shakeelb@google.com>
> 
> Introduce a memcg interface to trigger memory reclaim on a memory cgroup.
> 
> Use case: Proactive Reclaim
> ---------------------------
> 
> A userspace proactive reclaimer can continuously probe the memcg to
> reclaim a small amount of memory. This gives more accurate and
> up-to-date workingset estimation as the LRUs are continuously
> sorted and can potentially provide more deterministic memory
> overcommit behavior. The memory overcommit controller can provide
> more proactive response to the changing behavior of the running
> applications instead of being reactive.
> 
> A userspace reclaimer's purpose in this case is not a complete replacement
> for kswapd or direct reclaim, it is to proactively identify memory savings
> opportunities and reclaim some amount of cold pages set by the policy
> to free up the memory for more demanding jobs or scheduling new jobs.
> 
> A user space proactive reclaimer is used in Google data centers.
> Additionally, Meta's TMO paper recently referenced a very similar
> interface used for user space proactive reclaim:
> https://dl.acm.org/doi/pdf/10.1145/3503222.3507731
> 
> Benefits of a user space reclaimer:
> -----------------------------------
> 
> 1) More flexible on who should be charged for the cpu of the memory
> reclaim. For proactive reclaim, it makes more sense to be centralized.
> 
> 2) More flexible on dedicating the resources (like cpu). The memory
> overcommit controller can balance the cost between the cpu usage and
> the memory reclaimed.
> 
> 3) Provides a way to the applications to keep their LRUs sorted, so,
> under memory pressure better reclaim candidates are selected. This also
> gives more accurate and uptodate notion of working set for an
> application.
> 
> Why memory.high is not enough?
> ------------------------------
> 
> - memory.high can be used to trigger reclaim in a memcg and can
>   potentially be used for proactive reclaim.
>   However there is a big downside in using memory.high. It can potentially
>   introduce high reclaim stalls in the target application as the
>   allocations from the processes or the threads of the application can hit
>   the temporary memory.high limit.
> 
> - Userspace proactive reclaimers usually use feedback loops to decide
>   how much memory to proactively reclaim from a workload. The metrics
>   used for this are usually either refaults or PSI, and these metrics
>   will become messy if the application gets throttled by hitting the
>   high limit.
> 
> - memory.high is a stateful interface, if the userspace proactive
>   reclaimer crashes for any reason while triggering reclaim it can leave
>   the application in a bad state.
> 
> - If a workload is rapidly expanding, setting memory.high to proactively
>   reclaim memory can result in actually reclaiming more memory than
>   intended.
> 
> The benefits of such interface and shortcomings of existing interface
> were further discussed in this RFC thread:
> https://lore.kernel.org/linux-mm/5df21376-7dd1-bf81-8414-32a73cea45dd@google.com/
> 
> Interface:
> ----------
> 
> Introducing a very simple memcg interface 'echo 10M > memory.reclaim' to
> trigger reclaim in the target memory cgroup.
> 
> The interface is introduced as a nested-keyed file to allow for future
> optional arguments to be easily added to configure the behavior of
> reclaim.
> 
> Possible Extensions:
> --------------------
> 
> - This interface can be extended with an additional parameter or flags
>   to allow specifying one or more types of memory to reclaim from (e.g.
>   file, anon, ..).
> 
> - The interface can also be extended with a node mask to reclaim from
>   specific nodes. This has use cases for reclaim-based demotion in memory
>   tiering systens.
> 
> - A similar per-node interface can also be added to support proactive
>   reclaim and reclaim-based demotion in systems without memcg.
> 
> - Add a timeout parameter to make it easier for user space to call the
>   interface without worrying about being blocked for an undefined amount
>   of time.
> 
> For now, let's keep things simple by adding the basic functionality.
> 
> [yosryahmed@google.com: worked on versions v2 onwards, refreshed to
> current master, updated commit message based on recent
> discussions and use cases]
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Co-developed-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Wei Xu <weixugc@google.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: David Rientjes <rientjes@google.com>

"can over or under reclaim from the target cgroup" begs the question of 
how much more memory the kernel can decide to reclaim :)  I think it's 
assumed that it's minimal and that matches the current implementation that 
rounds up to SWAP_CLUSTER_MAX, though, so looks good.

Thanks Yosry!
