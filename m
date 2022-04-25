Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B821E50E425
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242604AbiDYPTW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 11:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbiDYPTV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 11:19:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906B09F392
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 08:16:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso13370680ybs.20
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VgCwJNrSWLamwr26sf8FxhD/HG4cXOd5kOE1NHtb3Lc=;
        b=n+3K4I/06qyEIawpbSiGFoxmIG2WckzHJniuNA3IrWYHIDmrQJPps1fZCv8oZNwSmM
         djRwqb8qKIJdhL5flEOwoWrVf3bgw6r6rtBL6CiLjfJjgVeHt9rbRyZvi2iSQtcSgL0m
         65ns45Ge3Iq2HNetZYhGnHOJBhbwo86ueRNoo7CPPkWaqJ5XyjXrA6fYqELFFEZSjet5
         0OWyA1mggzBwOWq2YcP+eq1e9fceZkTFP0kFcxB7g7bqxE3NHOKo/3QkDrmhQK19CILR
         xTvPRmKD1wfvVAMuwJG6R7P9g1gkSn/gsfhl21Nj9xXHYQ1wxqgQ0MMJhY0uXSFekZE/
         Z5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VgCwJNrSWLamwr26sf8FxhD/HG4cXOd5kOE1NHtb3Lc=;
        b=BHe4B5h+Edm1ve9X/j+5h9QHmBTWmOQdP4EbFkKYROZzGmGvwAFF2lU6tP86MGelsT
         x2fNJRWvyhbmfqz2ZEx93Q62lmJ+QItrMvc8qq8Y+paF+RCoOgH3fgTiTdVWpt+0ptLA
         R8JAKqeLYYbr/pBxm41aG/J40gUY5LxVZd3Q8NgA2mKf8AMGdaiTSUdTveazIpv5cx/v
         O2AHWq+mF8mBgn8FyItTinxltTea2WtSEwsO1H3f4p7xheDYsVyvPkAvkWUqJcZwRmRz
         YX2NKJLUXsshIIdD3/WPHYBtoG4OOKQp0mQqfZ0kKTcuD2OZ/lgE/czgeV8AiytSiXEq
         bScA==
X-Gm-Message-State: AOAM531wF9EDyga9jWGEYQdqkdrOxZRdfT5AMeKc/iYNDWJvN7z16d6W
        wHB6W5IjVd0moDuadRbK9jK57mq4Zg2hoQ==
X-Google-Smtp-Source: ABdhPJwU4K+YuD6yyf2aAdrpYnOWuj48hDCtiv+bO71qwNSDnOZ34f4eBzdf+Yw8LRMOIjCH7Y8ILNnSfkLjmA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a81:a4e:0:b0:2f7:d86c:e565 with SMTP id
 75-20020a810a4e000000b002f7d86ce565mr6895908ywk.374.1650899775751; Mon, 25
 Apr 2022 08:16:15 -0700 (PDT)
Date:   Mon, 25 Apr 2022 15:16:12 +0000
In-Reply-To: <CAJD7tkbhjJDNXcAmiAkGT8RCvBSz=SAfh7JR3AJysSz29hcEgw@mail.gmail.com>
Message-Id: <20220425151612.izmxhkgugq6isyz3@google.com>
Mime-Version: 1.0
References: <20220421234426.3494842-1-yosryahmed@google.com>
 <20220421234426.3494842-5-yosryahmed@google.com> <20220423142801.gnvd42cdcsz4hpon@google.com>
 <CAJD7tkbhjJDNXcAmiAkGT8RCvBSz=SAfh7JR3AJysSz29hcEgw@mail.gmail.com>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 23, 2022 at 02:43:13PM -0700, Yosry Ahmed wrote:
[...]
> > > +     cg_run_nowait(memcg, alloc_pagecache_50M_noexit, (void *)(long)fd);
> > > +     sleep(1);
> >
> > These sleep(1)s do not seem robust. Since kernel keeps the page cache
> > around, you can convert anon to use tmpfs and use simple cg_run to
> > trigger the allocations of anon (tmpfs) and file which will remain in
> > memory even after return from cg_run.
> 
> Other tests in the file are also using sleep approach (see
> test_memcg_min, although it retries for multiple times until
> memory.current reaches an expected amount). In my experience it hasn't
> been flaky running for multiple times on different machines, but I
> agree it can be flaky (false negative).
> 

If other tests are doing the same then ignore this comment for now.
There should be a separate effort to move towards more deterministic
approach for the tests instead of sleep().

> I am not sure about the allocating file pages with cg_run, is it
> guaranteed that the page cache will remain in memory until the test
> ends? If it doesn't, it can also flake, but it would produce false
> positives (the test could pass because the kernel drained page cache
> for some other reason although the interface is not working
> correctly).
> 
> In my personal opinion, false negative flakes are better than false
> positives. At least currently the test explicitly and clearly fails if
> the allocations are not successful. If we rely on the page cache
> remaining until the test finishes then it could silently pass if the
> interface is not working correctly.
> 
> There are a few ways we can go forward with this:
> 1) Keep everything as-is, but print a message if the test fails due to
> memory.current not reaching 100MB to make it clear that it didn't fail
> due to a problem with the interface.
> 2) Add a sleep/retry loop similar to test_memcg_min instead of sleeping once.
> 3) Send a signal from forked children when they are done with the
> allocation, and wait to receive this signal in the test to make sure
> the allocation is completed.
> 
> In my opinion we should do (1) (and maybe (2)) for now as (3) could be
> an overkill if the test is normal passing. Maybe add a comment about
> (3) being an option in the future if the test flakes. Let me know what
> you think?

I am ok with (1).
