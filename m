Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2CD4F8E16
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 08:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiDHFDk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 01:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbiDHFDC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 01:03:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534B11ACA78
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 22:00:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m30so11153443wrb.1
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Apr 2022 22:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEUIEi9adSNdoXW8KXtclgU3RetFXDHu8Pw4dW2isbA=;
        b=o7RXxtZ1cDCZRue0sRrHz1TVue0enjTGqt1HjvEk+IA8raVTONQrvfvX0FeTXqSKvX
         FtSzfFjcRFZtxjtFHjiRKr9z2um3s99f3Jn4Jsb9WAydhWNJHdtJM7igBo8PjX7H3Rjf
         mqqkKxr+7KexBHf3vNHS9f0qPUmgY37p2YUyp6/AflZqY2NsKxUitAvgrFQyRqvJQyc5
         KmKCzAK9duyoWb5HnTL7/rqzXKXmJFmeqhaGPBh4Z/8PXETA2bYyWEL3YDL6NLNSN2z3
         kMv5ynQ4wZtEKiYYloH6n1Z8y/rIw4HEW4YYgpLXpX24QberMRKQ3RVbD3QPsFyyd6Ym
         K6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEUIEi9adSNdoXW8KXtclgU3RetFXDHu8Pw4dW2isbA=;
        b=ajZOdNJlbez15JNd46l5aBAmjvGFJSR27F7xJF5FahW+w7ccHi2oWjfvYSEoTj0fKF
         EeJYyrrvZnu4nF0pq+SliXjSg0cFRjgpp+jv81AN+zump0glicIU2YEcQavTTLeBHnVy
         MYoqkKjSRLAVYfd/Xa2eXeG/c7qJrZdFVXJBne1TzhvV9rmd3t1fkbiXQ4DjhSwkfC0x
         nQMgGBYfEACRosDZLDUDrKY7nh1fA8ZDRXUsjOyh0aarhypNOXrFeVRFlMt4V28e5xzq
         /zZvul70V04lkifszPMFyTD+NKGTzYYgA4RHzg+RT9bSTYm7Vl4ZchKrcPpNjynYa5No
         Fq9Q==
X-Gm-Message-State: AOAM532kJ+y+BRVju3wjns08mkIGNlZSrIK3aQ/VYHWMBOP+eCOox91P
        D0kaY5uzjtEieuYMUyCaiHwvYm/11MKhtAgHRDECBA==
X-Google-Smtp-Source: ABdhPJx8gwwFGKo9JHFub9Glw4ixcEqLNimwl5VmXqky+27dSQgR/DF9ZrdodFvPPP+gdnMxF2HiStZfvRzIoAASGEo=
X-Received: by 2002:adf:8066:0:b0:206:1563:8b2b with SMTP id
 93-20020adf8066000000b0020615638b2bmr13333325wrk.582.1649394055492; Thu, 07
 Apr 2022 22:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220407224244.1374102-1-yosryahmed@google.com>
 <20220407224244.1374102-4-yosryahmed@google.com> <CAJD7tkaPaXQ4M_w-YxJizD2DG8co-3Q2bVDfd7_FaG2ivgT6UA@mail.gmail.com>
In-Reply-To: <CAJD7tkaPaXQ4M_w-YxJizD2DG8co-3Q2bVDfd7_FaG2ivgT6UA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 7 Apr 2022 22:00:07 -0700
Message-ID: <CAJD7tkZNAts_4M9TZx02L1y24hp5ty4H5vgrzryZk4a_uFR=6Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] selftests: cgroup: fix alloc_anon_noexit()
 instantly freeing memory
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Huang@google.com,
        Ying <ying.huang@intel.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Apr 7, 2022 at 4:04 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Thu, Apr 7, 2022 at 3:43 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > Currently, alloc_anon_noexit() calls alloc_anon() which instantly frees
> > the allocated memory. alloc_anon_noexit() is usually used with
> > cg_run_nowait() to run a process in the background that allocates
> > memory. It makes sense for the background process to keep the memory
> > allocated and not instantly free it (otherwise there is no point of
> > running it in the background).
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  tools/testing/selftests/cgroup/test_memcontrol.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> > index 36ccf2322e21..c1ec71d83af7 100644
> > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > @@ -211,13 +211,18 @@ static int alloc_pagecache_50M_noexit(const char *cgroup, void *arg)
> >  static int alloc_anon_noexit(const char *cgroup, void *arg)
> >  {
> >         int ppid = getppid();
> > +       size_t size = (unsigned long)arg;
> > +       char *buf, *ptr;
> >
> > -       if (alloc_anon(cgroup, arg))
> > -               return -1;
> > +       buf = malloc(size);
> > +       for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
> > +               *ptr = 0;
> >
> >         while (getppid() == ppid)
> >                 sleep(1);
> >
> > +       printf("Freeing buffer");
>
> Hey Andew,
>
> I am very sorry but I left a debugging printf there by mistake. If
> it's no hassle, do you mind removing it from the patch (assuming I
> won't need to send a v3 anyway)?

Never mind I already sent v3 and removed it with other fixes.
>
> Thanks!
>
> > +       free(buf);
> >         return 0;
> >  }
> >
> > --
> > 2.35.1.1178.g4f1659d476-goog
> >
