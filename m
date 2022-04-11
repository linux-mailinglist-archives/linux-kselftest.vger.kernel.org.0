Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8574FB483
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Apr 2022 09:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245293AbiDKHWz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Apr 2022 03:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245325AbiDKHWu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Apr 2022 03:22:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B872F3AB;
        Mon, 11 Apr 2022 00:20:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 239E11F38C;
        Mon, 11 Apr 2022 07:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649661635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EKQ22xGnCAfhZWYXu0EvGb4wthBpsfoBSJ1Jf+KqZ/U=;
        b=ZyojcBVo92JmwvoAqRyuWeNWhRdm2bTVzL3tgs8ML4g9f+5OapIHmsoh8iSO3TZbUFORDW
        l7lVqpJ+JmozjlZtoMfJjR4SyYzHmgOUP3TOxtkw2i10q7qGLIWBSnvnX/BajoavEbPNJp
        v/KvnynxlBntXBl4aDgMwxDLnE8Fnlg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 68ECBA3B83;
        Mon, 11 Apr 2022 07:20:34 +0000 (UTC)
Date:   Mon, 11 Apr 2022 09:20:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
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
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/4] memcg: introduce per-memcg reclaim interface
Message-ID: <YlPWvuK5pG/CapKv@dhcp22.suse.cz>
References: <20220408045743.1432968-1-yosryahmed@google.com>
 <20220408045743.1432968-2-yosryahmed@google.com>
 <YlA754XNFAmWQcm6@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
 <YlBCeadBqbeVvALK@dhcp22.suse.cz>
 <YlBM/HlPyPUZew5N@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlBM/HlPyPUZew5N@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri 08-04-22 10:55:56, Dan Schatzberg wrote:
> On Fri, Apr 08, 2022 at 04:11:05PM +0200, Michal Hocko wrote:
> > Regarding "max" as a possible input. I am not really sure to be honest.
> > I can imagine that it could be legit to simply reclaim all the charges
> > (e.g. before removing the memcg) which should be achieveable by
> > reclaiming the reported consumption. Or what exactly should be the
> > semantic?
> 
> Yeah, it just allows you to avoid reading memory.current to just
> reclaim everything if you can specify "max"

The same could be achieved by requesting a really high number (-1Ul)

> - you're still protected
> by nretries to eventually bail out.

The number of retries is an implementation detail and nobody should
really rely on that. Bail out on signal can be still used so yeah
getting a large input or whatever alias of that should be just fine.

> Mostly, though I just feel like
> supporting "max" makes memory.reclaim semetric with a lot of the
> cgroup memory control files which tend to support "max".

max is used for limits now and this doesn't have a semantic of one.
But I have to say I do not really feel strongly about this.

-- 
Michal Hocko
SUSE Labs
