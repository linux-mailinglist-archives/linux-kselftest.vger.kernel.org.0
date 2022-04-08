Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8667D4F8DB8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 08:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiDHDwR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 23:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiDHDwQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 23:52:16 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C340554F9B
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 20:50:13 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p135so3346909iod.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Apr 2022 20:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QmAYw2YLFK+N9yPKn4RBghklNnQzBJleL0zBPtPDBI=;
        b=sOPdU5+aYTOb3Ha6VI8yahXVwXAUfRMGetQTs3UZXodIXilTGhISQ2xWnnoNYFbOCE
         4w+P0CMEgeaKhwhopVLt3fTsdUJlIZNCRx7v92BnBuDFo5Mw1CwLwOQxMmEhwzt907Km
         LdWcsGOQJKeuBQVG93y+qP0RiTyTIyA7knvtBivZPWiU1Gxx7CCgXsSvltU5XbPnjtGQ
         P6WeuYF0IvSYvCLNs4Q5a52B0sleld017mpp59YWGetE+8TzuKF0HHhoWxu+sbpSTu4u
         L+CvAT5Tu9iaTyZIuG7s5g4HvzoX4UP4FFvzjnL7pwc9+KYaBDn6MuWY1m52qTpiJoiJ
         P4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QmAYw2YLFK+N9yPKn4RBghklNnQzBJleL0zBPtPDBI=;
        b=02ZDvF7dm/cUg7eiHhbn0PiiUBPFzkXt7OPUeKuHuWGR3JMc1h9AK/aVES49rGhlnq
         7SWeFmB4zenLq/ylnXwwJ2jHryS6zdWsu0YvIPErTMYbqH/Dsa86smsV5va/Vw9M60gY
         vpnxIm1HXMkiNRYYz9yGeEUG3Q4gHczSKw4buwACgOPPxQcL2BgYyYsdApbBXqyKJSmN
         jgQF6zHS/w3y90NdQLOPnW33Z0J7SiXCjLyb8WBRAvTvqYnYTXbbbZL376A24uICLLzc
         OCmFjBH8FV+taJ0qzz3Phv7xwEhMAanpCFXVbvD5gmc1vmxDgGQOvkYTOwaj1n4esSDV
         Gu+g==
X-Gm-Message-State: AOAM530n9UyRgJQp4y9bT1vGx3mJCT2FR5eLV2YMS1JMseqoU6P1SdVN
        bTVhCQIdfyOYqg+yEAQT7Vf6CQCgVkRgozLeV6YIog==
X-Google-Smtp-Source: ABdhPJzeT70Fqcqyx7XHXPZZxZDNBK20yshrycJGbTgJzysj9k7U5NM5HhN6z5qbokPS0PHvCzK70AY7/1z/cbI4/V0=
X-Received: by 2002:a05:6602:2c52:b0:646:2488:a9a0 with SMTP id
 x18-20020a0566022c5200b006462488a9a0mr7651188iov.130.1649389812360; Thu, 07
 Apr 2022 20:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220407224244.1374102-1-yosryahmed@google.com> <20220407224244.1374102-2-yosryahmed@google.com>
In-Reply-To: <20220407224244.1374102-2-yosryahmed@google.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 7 Apr 2022 20:50:01 -0700
Message-ID: <CAAPL-u_rUqOV4FTy3NKjFw4X4Nnm+eoG46jiN3Qa7TJbogcZ=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] memcg: introduce per-memcg reclaim interface
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>, Huang@google.com,
        Ying <ying.huang@intel.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 7, 2022 at 3:43 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
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
> [yosryahmed@google.com: refreshed to current master, updated commit
> message based on recent discussions and use cases]
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 21 ++++++++++++++
>  mm/memcontrol.c                         | 37 +++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 69d7a6983f78..19bcd73cad03 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1208,6 +1208,27 @@ PAGE_SIZE multiple when read back.
>         high limit is used and monitored properly, this limit's
>         utility is limited to providing the final safety net.
>
> +  memory.reclaim
> +       A write-only nested-keyed file which exists for all cgroups.
> +
> +       This is a simple interface to trigger memory reclaim in the
> +       target cgroup.
> +
> +       This file accepts a single key, the number of bytes to reclaim.
> +       No nested keys are currently supported.
> +
> +       Example::
> +
> +         echo "1G" > memory.reclaim
> +
> +       The interface can be later extended with nested keys to
> +       configure the reclaim behavior. For example, specify the
> +       type of memory to reclaim from (anon, file, ..).
> +
> +       Please note that the kernel can over or under reclaim from
> +       the target cgroup. If less bytes are reclaimed than the
> +       specified amount, -EAGAIN is returned.
> +
>    memory.oom.group
>         A read-write single value file which exists on non-root
>         cgroups.  The default value is "0".
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 725f76723220..2b214b66d333 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6355,6 +6355,38 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
>         return nbytes;
>  }
>
> +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> +                             size_t nbytes, loff_t off)
> +{
> +       struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +       unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> +       unsigned long nr_to_reclaim, nr_reclaimed = 0;
> +       int err;
> +
> +       buf = strstrip(buf);
> +       err = page_counter_memparse(buf, "", &nr_to_reclaim);
> +       if (err)
> +               return err;
> +
> +       while (nr_reclaimed < nr_to_reclaim) {
> +               unsigned long reclaimed;
> +
> +               if (signal_pending(current))
> +                       break;
> +
> +               reclaimed = try_to_free_mem_cgroup_pages(memcg,
> +                                               nr_to_reclaim - nr_reclaimed,
> +                                               GFP_KERNEL, true);
> +
> +               if (!reclaimed && !nr_retries--)
> +                       break;
> +
> +               nr_reclaimed += reclaimed;
> +       }
> +
> +       return nr_reclaimed < nr_to_reclaim ? -EAGAIN : nbytes;
> +}
> +
>  static struct cftype memory_files[] = {
>         {
>                 .name = "current",
> @@ -6413,6 +6445,11 @@ static struct cftype memory_files[] = {
>                 .seq_show = memory_oom_group_show,
>                 .write = memory_oom_group_write,
>         },
> +       {
> +               .name = "reclaim",
> +               .flags = CFTYPE_NS_DELEGATABLE,
> +               .write = memory_reclaim,
> +       },
>         { }     /* terminate */
>  };
>
> --
> 2.35.1.1178.g4f1659d476-goog
>

Acked-by: Wei Xu <weixugc@google.com>
