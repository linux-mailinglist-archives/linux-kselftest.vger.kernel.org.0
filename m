Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6CD50E983
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 21:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244948AbiDYTfe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 15:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244916AbiDYTfe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 15:35:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CF0111146
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:32:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u5so3435789pjr.5
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeezvirplzSzLTVDs1gNBFptZE26wQUimqKa8jXdb5Y=;
        b=DcMgm0ZRPmqLuBXlvrG+IVaxdGyMozez0lMkhgiAsb1rFFrlAo+EiFEygQczk2veU/
         7euIG+J6TVNbCDHuF4nqQFoK3KT4a9Twwi6a0+Wah2zlGh++9DZhr4YHujmaQohx4b7Y
         ybdpbndSZU44IcsvIka3R6/pX8/viZpL4iDaxUjLkvInRZPIy5k70JBb+UP3lqySnk4/
         a+/1FhiFA6Fsfb6auI8STl+On8SCg2NwjOdFlfWKiKRxSHLeCsiQpzGlNdqHHKeA/isL
         ab/slbL6gSK0hJmVa29T0+E1vT8wPqQn5ErKEp91yxreT8k3VnuwN4wD5AdgjcZLd8dK
         Cu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeezvirplzSzLTVDs1gNBFptZE26wQUimqKa8jXdb5Y=;
        b=YQR8ejqwc9PCo7Bh9Ts7fTqYJy7WvjrzrEe0ktsjKrhUpAXIebgmaBSURBhGz7Py28
         NzCfogrJTYhQFh1dWyP6bmiBok8OLfIIl9x0fVWz8HZc6wKBP/vkpoF4E47k2C2ixKnQ
         zf7D7oaJK3NnvmjJnHCwVnBKrKovIi4zD3QGMGmobMQ6J3yNkhrCmVxRlIgCPhvv32hF
         imP0LpMpb9iBpSRuw3NODZ3QAJIMGDBTKOtk/m0sGoS2NlWwfO54v9uaZY8TyGN25Gvb
         b9DJHjDSsHLg8TrXzlUkq8fuxjWv19n8cTxH64GI7qYO2HdvGpRqROWFNYJTe6KQEEWS
         Qv3A==
X-Gm-Message-State: AOAM5306ZV3tgu2vD+MnGrcj0yWJ3rCZ9f2pv46vJQ5cnY2yU3NbjSpv
        uWt0epjZ9ZX0hMhsF+A/3UNbIVFNhVSwyItYhK905w==
X-Google-Smtp-Source: ABdhPJwBvZDhhnZuuA7aqKCzlJsXI5si0z0hDX8ibOaKh3XVtbZVtAyVMNXVBMw5HvPVjbtnUEUD9Yz4KTFz6sonyfM=
X-Received: by 2002:a17:902:8b88:b0:156:2b14:cb6e with SMTP id
 ay8-20020a1709028b8800b001562b14cb6emr19882747plb.14.1650915147597; Mon, 25
 Apr 2022 12:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220425190040.2475377-1-yosryahmed@google.com>
 <20220425190040.2475377-2-yosryahmed@google.com> <a4c3d067-d08d-409d-e7b-b6e0b1d2dfda@google.com>
In-Reply-To: <a4c3d067-d08d-409d-e7b-b6e0b1d2dfda@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 25 Apr 2022 12:31:51 -0700
Message-ID: <CAJD7tka_96du2UUx0xuseR62wu005-KPf7fSyDTAuXOWsgUQDg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] memcg: introduce per-memcg reclaim interface
To:     David Rientjes <rientjes@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
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

On Mon, Apr 25, 2022 at 12:15 PM David Rientjes <rientjes@google.com> wrote:
>
> On Mon, 25 Apr 2022, Yosry Ahmed wrote:
>
> > From: Shakeel Butt <shakeelb@google.com>
> >
> > Introduce a memcg interface to trigger memory reclaim on a memory cgroup.
> >
> > Use case: Proactive Reclaim
> > ---------------------------
> >
> > A userspace proactive reclaimer can continuously probe the memcg to
> > reclaim a small amount of memory. This gives more accurate and
> > up-to-date workingset estimation as the LRUs are continuously
> > sorted and can potentially provide more deterministic memory
> > overcommit behavior. The memory overcommit controller can provide
> > more proactive response to the changing behavior of the running
> > applications instead of being reactive.
> >
> > A userspace reclaimer's purpose in this case is not a complete replacement
> > for kswapd or direct reclaim, it is to proactively identify memory savings
> > opportunities and reclaim some amount of cold pages set by the policy
> > to free up the memory for more demanding jobs or scheduling new jobs.
> >
> > A user space proactive reclaimer is used in Google data centers.
> > Additionally, Meta's TMO paper recently referenced a very similar
> > interface used for user space proactive reclaim:
> > https://dl.acm.org/doi/pdf/10.1145/3503222.3507731
> >
> > Benefits of a user space reclaimer:
> > -----------------------------------
> >
> > 1) More flexible on who should be charged for the cpu of the memory
> > reclaim. For proactive reclaim, it makes more sense to be centralized.
> >
> > 2) More flexible on dedicating the resources (like cpu). The memory
> > overcommit controller can balance the cost between the cpu usage and
> > the memory reclaimed.
> >
> > 3) Provides a way to the applications to keep their LRUs sorted, so,
> > under memory pressure better reclaim candidates are selected. This also
> > gives more accurate and uptodate notion of working set for an
> > application.
> >
> > Why memory.high is not enough?
> > ------------------------------
> >
> > - memory.high can be used to trigger reclaim in a memcg and can
> >   potentially be used for proactive reclaim.
> >   However there is a big downside in using memory.high. It can potentially
> >   introduce high reclaim stalls in the target application as the
> >   allocations from the processes or the threads of the application can hit
> >   the temporary memory.high limit.
> >
> > - Userspace proactive reclaimers usually use feedback loops to decide
> >   how much memory to proactively reclaim from a workload. The metrics
> >   used for this are usually either refaults or PSI, and these metrics
> >   will become messy if the application gets throttled by hitting the
> >   high limit.
> >
> > - memory.high is a stateful interface, if the userspace proactive
> >   reclaimer crashes for any reason while triggering reclaim it can leave
> >   the application in a bad state.
> >
> > - If a workload is rapidly expanding, setting memory.high to proactively
> >   reclaim memory can result in actually reclaiming more memory than
> >   intended.
> >
> > The benefits of such interface and shortcomings of existing interface
> > were further discussed in this RFC thread:
> > https://lore.kernel.org/linux-mm/5df21376-7dd1-bf81-8414-32a73cea45dd@google.com/
> >
> > Interface:
> > ----------
> >
> > Introducing a very simple memcg interface 'echo 10M > memory.reclaim' to
> > trigger reclaim in the target memory cgroup.
> >
> > The interface is introduced as a nested-keyed file to allow for future
> > optional arguments to be easily added to configure the behavior of
> > reclaim.
> >
> > Possible Extensions:
> > --------------------
> >
> > - This interface can be extended with an additional parameter or flags
> >   to allow specifying one or more types of memory to reclaim from (e.g.
> >   file, anon, ..).
> >
> > - The interface can also be extended with a node mask to reclaim from
> >   specific nodes. This has use cases for reclaim-based demotion in memory
> >   tiering systens.
> >
> > - A similar per-node interface can also be added to support proactive
> >   reclaim and reclaim-based demotion in systems without memcg.
> >
> > - Add a timeout parameter to make it easier for user space to call the
> >   interface without worrying about being blocked for an undefined amount
> >   of time.
> >
> > For now, let's keep things simple by adding the basic functionality.
> >
> > [yosryahmed@google.com: worked on versions v2 onwards, refreshed to
> > current master, updated commit message based on recent
> > discussions and use cases]
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > Co-developed-by: Yosry Ahmed <yosryahmed@google.com>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Acked-by: Wei Xu <weixugc@google.com>
> > Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
>
> Acked-by: David Rientjes <rientjes@google.com>
>
> "can over or under reclaim from the target cgroup" begs the question of
> how much more memory the kernel can decide to reclaim :)  I think it's
> assumed that it's minimal and that matches the current implementation that
> rounds up to SWAP_CLUSTER_MAX, though, so looks good.
>
> Thanks Yosry!

I think it could be more complex than this. Some functions that get
called during reclaim only use the nr_to_reclaim parameter to check if
they need one more iteration, but not to limit the actual reclaimed
pages per say. For example, nr_to_reclaim is not even passed to
shrink_slab() or mem_cgroup_soft_limit_reclaim(), so they have no way
to know that they should stop if nr_to_reclaim was already satisfied.
I think the general assumption is that each of these calls normally
does not reclaim a huge number of pages, so like you said, the kernel
should not over-reclaim too much. However, I don't think there are
guarantees about this.
