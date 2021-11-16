Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1174538E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Nov 2021 18:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbhKPR5O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Nov 2021 12:57:14 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49476 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239144AbhKPR5M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Nov 2021 12:57:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E4F61212C3;
        Tue, 16 Nov 2021 17:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637085252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQ4Vs3Ue9V/rPlPCCX2Ku26e9rOXlRcNGXZau4L0nns=;
        b=WWKIaz/W38nsYFEg/zCDoNaH0kIwA0H6XZ/FTs4KYO6YXn8PB48U92vHHzY8eCaYtbXNAw
        0bDRV5xqAZCLG+pNMxZJqK3emAMALV9Jw4J7trsryDzNOGA1ZVp1riAEmChz92M0DHw1cB
        L/4UkS3yo+5VogH9yJjdHpqz3Sx7RAE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B374513BA0;
        Tue, 16 Nov 2021 17:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JaE7K0Twk2G0cQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 16 Nov 2021 17:54:12 +0000
Date:   Tue, 16 Nov 2021 18:54:11 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
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
Subject: Re: [PATCH v8 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <20211116175411.GA50019@blackbody.suse.cz>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211018143619.205065-6-longman@redhat.com>
 <20211115193122.GA16798@blackbody.suse.cz>
 <8f68692b-bd8f-33fd-44ae-f6f83bf2dc00@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f68692b-bd8f-33fd-44ae-f6f83bf2dc00@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 15, 2021 at 04:10:29PM -0500, Waiman Long <longman@redhat.com> wrote:
> > On Mon, Oct 18, 2021 at 10:36:18AM -0400, Waiman Long <longman@redhat.com> wrote:
> > > +	scheduler.  Tasks in such a partition must be explicitly bound
> > > +	to each individual CPU.
> [...]
> 
> It can be a problem when one is trying to move from one cgroup to another
> cgroup with non-overlapping cpus laterally. However, if a task is initially
> from a parent cgroup with affinity mask that include cpus in the isolated
> child cgroup, I believe it should be able to move to the isolated child
> cgroup without problem. Otherwise, it is a bug that needs to be fixed.

app_root	cpuset.cpus=0-3
`- non_rt	cpuset.cpus=0-1	cpuset.cpus.partition=member
`- rt		cpuset.cpus=2-3	cpuset.cpus.partition=isolated

The app_root would have cpuset.cpus.effective=0-1 so even the task in
app_root can't sched_setaffinity() to cpus 2-3.
But AFAICS, the migration calls set_cpus_allowed_ptr() anyway, so the
task in the isolated partition needn't to bind explicitly with
sched_setaffinity(). (It'd have two cpus available, so one more
sched_setaffinity() or migration into a single-cpu list is desirable.)

All in all, I think the behavior is OK and the explicit binding of tasks
in an isolated cpuset is optional (not a must as worded currently).


> I think the wording may be confusing. What I meant is none of the requested
> cpu can be granted. So if there is at least one granted, the effective cpus
> won't be empty.

Ack.

> You currently cannot make change to cpuset.cpus that violates the cpu
> exclusivity rule. The above constraints will not disallow you to make the
> change. They just affect the validity of the partition root.

Sibling exclusivity should be a validity condition regardless of whether
transition is allowed or not. (At least it looks simpler to me.)


> > > +        Changing a partition root to "member" is always allowed.
> > > +        If there are child partition roots underneath it, however,
> > > +        they will be forced to be switched back to "member" too and
> > > +        lose their partitions. So care must be taken to double check
> > > +        for this condition before disabling a partition root.
> > (Or is this how delegation is intended?) However, AFAICS, parent still
> > can't remove cpuset.cpus even when the child is a "member". Otherwise,
> > I agree with the back-switch.
> There are only 2 possibilities here. Either we force the child partitions to
> be become members or invalid partition root.

My point here was mostly about preempting the cpus (as a v2 specific
feature). (I'm rather indifferent whether children turn into invalid
roots or members.)

Thanks,
Michal
