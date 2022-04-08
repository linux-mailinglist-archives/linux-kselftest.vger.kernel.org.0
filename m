Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F8E4F97BC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 16:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiDHONQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 10:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbiDHONO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 10:13:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659C334B914;
        Fri,  8 Apr 2022 07:11:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 19956210EE;
        Fri,  8 Apr 2022 14:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649427069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gNPsT3NKhlXnfi2F2vg55Kv/xhOi4VGOL+j6MMtTFeQ=;
        b=cfXqbCqyXyBa9orgccUoy4424ix9hLjiTcErReYj3EGVeVskbNNPsd6jezIUyblN1T6VI/
        /PKqJNKcV+Av8NjuXjYKDNOPjnnWzy0/mCCms8pAaSht4wSV42B5hoL2fPkU54vQzpRJeZ
        ikVj76De+BwGGpCsVa7bGeTVBr4jiS0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4364AA3B83;
        Fri,  8 Apr 2022 14:11:08 +0000 (UTC)
Date:   Fri, 8 Apr 2022 16:11:05 +0200
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
Message-ID: <YlBCeadBqbeVvALK@dhcp22.suse.cz>
References: <20220408045743.1432968-1-yosryahmed@google.com>
 <20220408045743.1432968-2-yosryahmed@google.com>
 <YlA754XNFAmWQcm6@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlA754XNFAmWQcm6@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri 08-04-22 09:43:03, Dan Schatzberg wrote:
> On Fri, Apr 08, 2022 at 04:57:40AM +0000, Yosry Ahmed wrote:
> > +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > +			      size_t nbytes, loff_t off)
> > +{
> > +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > +	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> > +	unsigned long nr_to_reclaim, nr_reclaimed = 0;
> > +	int err;
> > +
> > +	buf = strstrip(buf);
> > +	err = page_counter_memparse(buf, "", &nr_to_reclaim);
> 
> Is there a reason not to support "max"? Empty string seems odd to me
> here.

I have to say I have missed the special meaning of the empty string here
and I agree this would indeed really weird. Does cgroup core even call
here? cgroup_file_write seems to drop !nbytes input.

Regarding "max" as a possible input. I am not really sure to be honest.
I can imagine that it could be legit to simply reclaim all the charges
(e.g. before removing the memcg) which should be achieveable by
reclaiming the reported consumption. Or what exactly should be the
semantic?
-- 
Michal Hocko
SUSE Labs
