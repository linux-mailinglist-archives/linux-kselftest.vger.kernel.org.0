Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DCF475AF0
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 15:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhLOOoy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 09:44:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41970 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhLOOox (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 09:44:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 868EF1F3CB;
        Wed, 15 Dec 2021 14:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639579492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L+FwlFr7sookecjc9+Z4KJH3P8puADKn4avrNKuh3fg=;
        b=V2YNGn1ryxEnaOg+uqD0czIqum5A+yvyyOQF3/o+zFpawFNR+AbAXZhquxTqZxu3w7E5n2
        F0ottN2Pw6JXwcZNGP9VFmAgQ2j6z7rsoVTVmkKucdC1IAv+nbmrE/aj9oaCO4INsLri9u
        /mi/m484fVNsR3E1xOvslXFMEQJcp6I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FE231330B;
        Wed, 15 Dec 2021 14:44:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JkXhEmT/uWHWcAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 15 Dec 2021 14:44:52 +0000
Date:   Wed, 15 Dec 2021 15:44:51 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v9 6/7] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <20211215144450.GC25459@blackbody.suse.cz>
References: <20211205183220.818872-1-longman@redhat.com>
 <20211205183220.818872-7-longman@redhat.com>
 <Ybe0YWEo7Wp7wib9@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybe0YWEo7Wp7wib9@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 13, 2021 at 11:00:17AM -1000, Tejun Heo <tj@kernel.org> wrote:
> * When a valid partition turns invalid, now we have a reliable way of
>   discovering what exactly caused the transition. However, when a user now
>   fails to turn a member into partition, all they get is -EINVAL and there's
>   no way to discover why it failed and the failure conditions that -EINVAL
>   represents aren't simple.
> 
> * In an automated configuration scenarios, this operation mode may be
>   difficult to make reliable and lead to sporadic failures which can be
>   tricky to track down. The core problem is that whether a given operation
>   succeeds or not may depend on external states (CPU on/offline) which may
>   change asynchronously in a way that the configuring entity doesn't have
>   any control over.
> 
> It's true that both are existing problems with the current partition
> interface and given that this is a pretty spcialized feature, this can be
> okay. Michal, what are your thoughts?

Because of asynchronous changes, the return value should not be that
important and the user should watch cpuset.partitions for the result
(end state) anyway.
Furthermore, the reasons should be IMO just informative (i.e. I like
they're not explicitly documented) and not API.

But I see there could be a distinction between -EINVAL (the supplied
input makes no sense) and -EAGAIN(?) denoting that the switch to
partition root could not happen (due to outer constraints).

You seem to propose to replace the -EAGAIN above with a success code and
allow the switch to an invalid root.
The action of the configuring entity would be different: retry (when?)
vs wait till transition happens (notification) (although the immediate
effect (the change did not happen) is same).
I considered the two variants equal but the clear information about when
the change can happen I'd favor the variant allowing the switch to
invalid root now.


Michal
