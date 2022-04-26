Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C6250F3A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 10:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344603AbiDZI0E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 04:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiDZI0A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 04:26:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BB33A5E9;
        Tue, 26 Apr 2022 01:22:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 357091F380;
        Tue, 26 Apr 2022 08:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650961366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NKbpFjMDPqd7TQ514NLGknGrSkR1xvTuZ+twvGBw1Ds=;
        b=Ku8RBnA0Rf9zQsz4S8BTrgHF20lahZ8buxMT5bsutog3s+qQEzlQpjXalln29/WK/9rWTe
        y/9DNr88hxHzQwcPkYA9KVTaL8FZ7DTVb/ZbTuzWAufvvhtv6te6DXO8ZUj85HjsIehW/n
        qbSDE3xjlsTQgKOtmALRZ+WjV1K1F3E=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2BB612C146;
        Tue, 26 Apr 2022 08:22:45 +0000 (UTC)
Date:   Tue, 26 Apr 2022 10:22:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 1/4] memcg: introduce per-memcg reclaim interface
Message-ID: <Ymer0qeaJlRY1Ju6@dhcp22.suse.cz>
References: <20220425190040.2475377-1-yosryahmed@google.com>
 <20220425190040.2475377-2-yosryahmed@google.com>
 <a4c3d067-d08d-409d-e7b-b6e0b1d2dfda@google.com>
 <CAJD7tka_96du2UUx0xuseR62wu005-KPf7fSyDTAuXOWsgUQDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tka_96du2UUx0xuseR62wu005-KPf7fSyDTAuXOWsgUQDg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 25-04-22 12:31:51, Yosry Ahmed wrote:
> On Mon, Apr 25, 2022 at 12:15 PM David Rientjes <rientjes@google.com> wrote:
[...]
> > "can over or under reclaim from the target cgroup" begs the question of
> > how much more memory the kernel can decide to reclaim :)  I think it's
> > assumed that it's minimal and that matches the current implementation that
> > rounds up to SWAP_CLUSTER_MAX, though, so looks good.
> >
> > Thanks Yosry!
> 
> I think it could be more complex than this. Some functions that get
> called during reclaim only use the nr_to_reclaim parameter to check if
> they need one more iteration, but not to limit the actual reclaimed
> pages per say. For example, nr_to_reclaim is not even passed to
> shrink_slab() or mem_cgroup_soft_limit_reclaim(), so they have no way
> to know that they should stop if nr_to_reclaim was already satisfied.
> I think the general assumption is that each of these calls normally
> does not reclaim a huge number of pages, so like you said, the kernel
> should not over-reclaim too much. However, I don't think there are
> guarantees about this.

There are no guarantees indeed and it si definitely good to be explicit
about that so that userspace tools expect that and consider that in
the imeplementation. Sure we do not want to go overboard and huge excess
should be considered a bug. I am not sure we do agree on the notion of
"huge" so let's see.
-- 
Michal Hocko
SUSE Labs
