Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB2E50CDD0
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Apr 2022 23:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbiDWVr4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 23 Apr 2022 17:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiDWVrz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 23 Apr 2022 17:47:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BBADE8
        for <linux-kselftest@vger.kernel.org>; Sat, 23 Apr 2022 14:44:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c1so4766907pfo.0
        for <linux-kselftest@vger.kernel.org>; Sat, 23 Apr 2022 14:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yx8y7goVHBTlGvdtFFuNwwMCsekJcpP9yvzgyjH/bp8=;
        b=qUkkGk/bpw8J14YdHOTb4OZuCmi63QvteZvtb9Aamaxo0h8F/x9cxEHz27DzgjZcfU
         lO2ufp6jXpfprhMFOAKOY0UomKf+5C5Xba3QJ9Lf4mg0l10Kw819Itq5Awrey6+53cOg
         vVA2sH9g5lqyk8SDJcuqUYgRvr+O2I7vjscVtPkcSJ79na68KphWwZX4Zw31RRzsMgD7
         y6Ij35PmRo1cbbPNwwgB/xc3XBmk7Tqx6kzpyXUyoRCj61jI4z4UfkEhCCrywL3K5adi
         c6eVmKQZxrrOxtFX4Rt9FfNl5dyK0cMSNPoPJHPpsL/X1CTkqgnoWbDbiWbbx0VP5xpa
         NR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yx8y7goVHBTlGvdtFFuNwwMCsekJcpP9yvzgyjH/bp8=;
        b=0cwyhCjSeqPYYffT5GZLkwq7la659f0Qnxgsw+v2Hw+aXqQp9NRSIqZ/LzOKxvaNtR
         Ji5wuha2dZIUKrwMncRa4+6vgVp9e8VIWSwalmX2ygkh7OiTTLedsseOgwG8J2asqk0h
         O/LKfsRu3KfAvm7q7VJsPqWmtckoU0EyZ+iLi+EpNxwneaLWqgQkti4xzBel2+PFgDXT
         d8yCiYj0MvDlX043lR23R3irv71RWyMQcFR/6Rp7w3qqQT0g+cqgNddmP5ikCI/y6YyT
         eZKrYvVVA9zVI6HHfnnmTs+kF5ZyV8rx2G2NZ+q+zNcQ5Pk4Frv0/DOkor+fbuKwwLT9
         4SOg==
X-Gm-Message-State: AOAM530zLzIj4rrJMV/t4gNBfnUT6nBl4piMXOr5/iitOjOU4CAXuq7f
        DHD5SmfO/BcuAq6L/3UgPrZCyiTBx5bAX2o5DOMjMQ==
X-Google-Smtp-Source: ABdhPJzaJKGRsqP2YIPaQzlAHHJckJcXVF1PrkoWTCqe4FPh8eOX9DRoOw850DV2KiuelxmOzUr1GvKvl2LEvWTIfHI=
X-Received: by 2002:a05:6a00:1695:b0:4f7:decc:506b with SMTP id
 k21-20020a056a00169500b004f7decc506bmr11503134pfc.7.1650750296183; Sat, 23
 Apr 2022 14:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220421234426.3494842-1-yosryahmed@google.com>
 <20220421234426.3494842-2-yosryahmed@google.com> <20220423133035.b6iz6vzhzlym3m4w@google.com>
In-Reply-To: <20220423133035.b6iz6vzhzlym3m4w@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sat, 23 Apr 2022 14:44:20 -0700
Message-ID: <CAJD7tkaAKPLCrZmZc0FDHj3s40rbZ5gp5gGpQEtiRvsE6vdWPg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] memcg: introduce per-memcg reclaim interface
To:     Shakeel Butt <shakeelb@google.com>
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
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
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

On Sat, Apr 23, 2022 at 6:30 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Apr 21, 2022 at 11:44:23PM +0000, Yosry Ahmed wrote:
> > From: Shakeel Butt <shakeelb@google.com>
> [...]
> >
> > [yosryahmed@google.com: refreshed to current master, updated commit
> > message based on recent discussions and use cases]
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> You should add "Co-developed-by" tag for yourself here.
>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Acked-by: Wei Xu <weixugc@google.com>
> > Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> > ---
> >
> [...]
> > +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > +                           size_t nbytes, loff_t off)
> > +{
> > +     struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > +     unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> > +     unsigned long nr_to_reclaim, nr_reclaimed = 0;
> > +     int err;
> > +
> > +     buf = strstrip(buf);
> > +     err = page_counter_memparse(buf, "", &nr_to_reclaim);
> > +     if (err)
> > +             return err;
> > +
> > +     while (nr_reclaimed < nr_to_reclaim) {
> > +             unsigned long reclaimed;
> > +
> > +             if (signal_pending(current))
> > +                     return -EINTR;
> > +
> > +             /* This is the final attempt, drain percpu lru caches in the
>
> Fix the comment format. "/*" should be on its own line.
>
> > +              * hope of introducing more evictable pages for
> > +              * try_to_free_mem_cgroup_pages().
> > +              */
>
> No need to send a new version if Andrew can fix these in the mm tree.

I will be sending v5 anyway to address your review comments on the
last patch. I will fix these as well. Thanks!
