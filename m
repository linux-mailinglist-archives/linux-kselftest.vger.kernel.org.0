Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D770508870
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 14:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353832AbiDTMuA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 08:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348748AbiDTMt7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 08:49:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA72B3C73F;
        Wed, 20 Apr 2022 05:47:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0A1F1210F1;
        Wed, 20 Apr 2022 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650458832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fE2JVFjVSECX2xSom7dha9uadrw2m4rx6MxVgcht3TU=;
        b=ls08cpYNS6BsFKbzep+CNbq8sfVdl2ellBWBujxnccydNYGlZusiruxwRBWAGNdG+LbEjN
        jBIdNmHiFta1RBcAXwfZU0dmIdTZsOgoaKPo4njd2eiadAdPKoabYOFObP16BYeeo/IWJ6
        6qVYRksrngynbRG+maQ3Tkc4EqFNkn0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 261B62C142;
        Wed, 20 Apr 2022 12:47:11 +0000 (UTC)
Date:   Wed, 20 Apr 2022 14:47:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/4] memcg: introduce per-memcg reclaim interface
Message-ID: <YmAAzkwGg6GspCiu@dhcp22.suse.cz>
References: <20220408045743.1432968-1-yosryahmed@google.com>
 <20220408045743.1432968-2-yosryahmed@google.com>
 <YlA754XNFAmWQcm6@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
 <YlBCeadBqbeVvALK@dhcp22.suse.cz>
 <YlBM/HlPyPUZew5N@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
 <CAJD7tkbFjbGJ7CnNogpGq5enh_uhP8T5c0U+ku9PfwMoVLf2gg@mail.gmail.com>
 <CAJD7tkYJj2O-zaux9BZxJxG+JBjPrwRYKXPAAAh7i9GVE53VGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYJj2O-zaux9BZxJxG+JBjPrwRYKXPAAAh7i9GVE53VGQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 14-04-22 10:25:29, Yosry Ahmed wrote:
> On Fri, Apr 8, 2022 at 1:08 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Fri, Apr 8, 2022 at 7:55 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> > >
> > > On Fri, Apr 08, 2022 at 04:11:05PM +0200, Michal Hocko wrote:
> > > > Regarding "max" as a possible input. I am not really sure to be honest.
> > > > I can imagine that it could be legit to simply reclaim all the charges
> > > > (e.g. before removing the memcg) which should be achieveable by
> > > > reclaiming the reported consumption. Or what exactly should be the
> > > > semantic?
> > >
> > > Yeah, it just allows you to avoid reading memory.current to just
> > > reclaim everything if you can specify "max" - you're still protected
> > > by nretries to eventually bail out. Mostly, though I just feel like
> > > supporting "max" makes memory.reclaim semetric with a lot of the
> > > cgroup memory control files which tend to support "max".
> >
> > One possible approach here is to have force_empty behavior when we
> > write "max" to memory.reclaim. From Google's perspective we don't have
> > a preference, but it seems to me like logical behavior. We can do this
> > either by directly calling mem_cgroup_force_empty() or just draining
> > stock and lrus in memory_reclaim().
> >
> > This actually brings up another interesting point. Do you think we
> > should drain lrus if try_to_free_mem_cgroup_pages() fails to reclaim
> > the request amount? We can do this after the first call or before the
> > last one. It could introduce more evictable pages for
> > try_to_free_mem_cgroup_pages() to free.
> 
> Hey Michal, any thoughts on this? I am looking for feedback on this
> before I send out v4.

As I've already said I do not have strong preferences for the "max"
value to be accepted by the interface. Maybe you can add a support for
max in a separate patch so the discussion would not delay the rest of
the work.

For the LRU draining I do not see any problem for that to be added. The
overhead of the operation would increase, especially on larger machines,
which could be a concern. So the real question is whether not doing so
is a big problem. Our force_empty implementation optimistically drains
pcp caches but please note that this is not really guranteeing anything
as charges can happen at any time. 

-- 
Michal Hocko
SUSE Labs
