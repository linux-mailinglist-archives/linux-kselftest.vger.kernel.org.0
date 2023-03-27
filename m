Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E06C9F1E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 11:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjC0JNf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 05:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjC0JNd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 05:13:33 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFBC133;
        Mon, 27 Mar 2023 02:13:31 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id qh28so6218224qvb.7;
        Mon, 27 Mar 2023 02:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679908411;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Umb9hUbfu4RXL6KlGkF01LiyDptRngvjLvFGabW/70w=;
        b=y1UaIbGx+4wKJ2wk2Hub37TFJ1cq0ubQFNw7MbfK5zJo7kamFg9kcUFo1bo6vX85GD
         0NgtVXOjl3gB5GET1x1dEO1BbQ/CH9FmGeccEnci2nA2VVURepTTpTkSsoT8qaM4GJ3q
         4ilX+X0FYhgvrI9fuHm3YDqUmmAPk+hEP0/bqbJ/2kdD4Wvj75zofWirmTv8jRSHgSF5
         A3BuMEiadcNudFab+MhENmM2Liv1zZs473N+ffl8rb+t0sMIGsQJCz40ogT55jy66QKw
         14hAnbjtRLZRQywLCBdnkCWOruVVgUNI6VVzsf0oaGpQ+gGMv1aVcDs1GOvdShvP2+CK
         zXxg==
X-Gm-Message-State: AAQBX9empRtKgnBzrEQiW2cufujT9sU1OJzbDNH4fokqny65V0xpg/3C
        1s4HHHBMj8kT4Q8aU/J5Bi8=
X-Google-Smtp-Source: AKy350Y06rMs/401uxhflhl8CYmN7DqjbNmD9t0V5jGwKE6OwXPeDLRcEQJJWCwLvw2M9hVJch4zPw==
X-Received: by 2002:ad4:5dc1:0:b0:5ad:e777:1fc2 with SMTP id m1-20020ad45dc1000000b005ade7771fc2mr14569629qvh.15.1679908410637;
        Mon, 27 Mar 2023 02:13:30 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id t2-20020a374602000000b00746ac14e29asm6562753qka.5.2023.03.27.02.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 02:13:30 -0700 (PDT)
Date:   Mon, 27 Mar 2023 04:13:27 -0500
From:   David Vernet <void@manifault.com>
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
        Zefan Li <lizefan.x@bytedance.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests: cgroup: Fix exception handling in
 test_memcg_oom_group_score_events()
Message-ID: <20230327091327.GK363182@maniforge>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <c383bdca-6f0d-4a75-e788-e1920faa0a62@web.de>
 <fffcd98a-bb73-41cd-8545-0f2c55dd38f9@lucifer.local>
 <5b7921c9-ee5d-c372-b19b-2701bcf33148@web.de>
 <20230326213900.GJ363182@maniforge>
 <c46dbb48-259b-1de9-2364-9bfaf1061944@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c46dbb48-259b-1de9-2364-9bfaf1061944@web.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 27, 2023 at 07:56:03AM +0200, Markus Elfring wrote:
> >> 2. Can a cg_destroy() call ever work as expected if a cg_create() call failed?
> >
> > Perhaps next time you can answer your own question by spending 30
> > seconds actually reading the code you're "fixing":
> >
> > int cg_destroy(const char *cgroup)
> > {
> …
> >         ret = rmdir(cgroup);
> …
> >         if (ret && errno == ENOENT) <<< that case is explicitly handled here
> >                 ret = 0;
> >
> >         return ret;
> > }
> 
> Is it interesting somehow that a non-existing directory (which would occasionally
> not be found) is tolerated so far?
> https://elixir.bootlin.com/linux/v6.3-rc3/source/tools/testing/selftests/cgroup/cgroup_util.c#L285
> 
> Should such a function call be avoided because of a failed cg_create() call?

The point is that (a) you were wrong that this is fixing anything, and
(b) this patch is functionally useless. Sure, we could move some goto's
around and subjectively improve "something". Why?  What's the point?
It's highly debatable that what you're doing is even an improvement, and
I'm not interested in wasting time pontificating about the merits of a
trivial "fix" for a test cleanup function that isn't even broken.

Several people have already either advised or directly asked you to stop
sending these patches. I'm not sure why you're choosing to ignore them,
but I'll throw my hat in the ring regardless and do the same. Please
stop sending these fake cleanup patches.
