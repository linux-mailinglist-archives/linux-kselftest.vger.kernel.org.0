Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C44142A76C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Oct 2021 16:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbhJLOlS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Oct 2021 10:41:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34144 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbhJLOlS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Oct 2021 10:41:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3999D220B0;
        Tue, 12 Oct 2021 14:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634049555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XU/0uGfOl2ynUsla9eoZ3FW3nLryazaxQqK6ENWJUQ0=;
        b=fJoHljkl2jbF1HPvtdzcv7yYel+n7lwsY82K2WwEUKxlQybhUzs9iJvt12zgD5VSWFOakO
        pCOlQqGZeLsViMQg7qcTtNEyZf3kRUPyWpLjutrBZdqAahpQKwLiE8TCklhU6Hkp8JjmNG
        sIGnKWNUHOsI/l32VId0aiVdBc7J5fU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 096FA13BEC;
        Tue, 12 Oct 2021 14:39:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BPu1AROeZWHGDAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 12 Oct 2021 14:39:15 +0000
Date:   Tue, 12 Oct 2021 16:39:13 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Waiman Long <llong@redhat.com>
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
Subject: Re: [PATCH v7 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Message-ID: <20211012143913.GA22036@blackbody.suse.cz>
References: <20210825213750.6933-1-longman@redhat.com>
 <20210825213750.6933-6-longman@redhat.com>
 <YSfQ0mYWs2zUyqGY@mtj.duckdns.org>
 <32e27fcc-32f1-b26c-ae91-9e03f7e433af@redhat.com>
 <YShjb2WwvuB4s4gX@slm.duckdns.org>
 <d22ea3be-2429-5923-a80c-5af3b384def9@redhat.com>
 <YSlY0H/qeXQIGOfk@slm.duckdns.org>
 <392c3724-f583-c7fc-cfa1-a3f1665114c9@redhat.com>
 <YSl2yxEvnDrPxzUV@slm.duckdns.org>
 <3533e4f9-169c-d13c-9c4e-d9ec6bdc78f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3533e4f9-169c-d13c-9c4e-d9ec6bdc78f0@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 06, 2021 at 02:21:03PM -0400, Waiman Long <llong@redhat.com> wrote:
> Sorry for not following up with this patchset sooner as I was busy on other
> tasks.

Thanks for continuing with this.

> 	1) The "cpuset.cpus" is not empty and the list of CPUs are
> 	   exclusive, i.e. they are not shared by any of its siblings.
> 	2) The parent cgroup is a partition root.
> 	3) The "cpuset.cpus" is a subset of the union of parent's
> 	   "cpuset.cpus.effective" and offlined CPUs in parent's
> 	   "cpuset.cpus".
> 	4) There is no child cgroups with cpuset enabled.  This avoids
> 	   cpu migrations of multiple cgroups simultaneously which can
> 	   be problematic.
> 
>         A partition, when enabled, can be in an invalid state. An example
>         is when its parent is also an invalid partition.

You say:
"it can only be enabled in a cgroup if all the following conditions are met.",
"2) The parent cgroup is a partition root."

and then the example:
"A partition, when enabled, can be in an invalid state. An example is
when its parent is also an invalid partition."

But the first two statements imply you can't have enabled the partition
in such a case.

I think there is still mixup of partition validity conditions and
transition conditions, yours would roughly divide into (not precisely,
just to share my understanding):

Validity conditions
 	1) The "cpuset.cpus" is not empty and the list of CPUs are
 	   exclusive, i.e. they are not shared by any of its siblings.
 	2) The parent cgroup is a partition root.

Transition conditions:
 	3) The "cpuset.cpus" is a subset of the union of parent's
 	   "cpuset.cpus.effective" and offlined CPUs in parent's
 	   "cpuset.cpus".
 	4) There is no child cgroups with cpuset enabled.  This avoids
 	   cpu migrations of multiple cgroups simultaneously which can
 	   be problematic.

(I've put no. 3 into transition conditions because _after_ the
transition parent's cpuset.cpus.effective are subtracted the new root's
cpuset.cpus but I'd like to have something similar as a validity
condition but I haven't come up with that yet.)

I consider the following situation:

r		// all cpus 0-7
`- part1	cpus=0-3	root >partition
   ` subpart1	cpus=0-1	root >partition
   ` subpart2	cpus=2-3	root >partition
`- other	cpus=4-7	// member by default

Both subpart1 and subpart2 are valid partition roots.
Look at actions listed below (as alternatives, not a sequence):

a) hotplug offlines cpu 3
  - would part1 still be considered a valid root? 
    - perhaps not
  - would subpart1 still be considered a valid root? 
    - it could be, but its parent is invalid so no?
  - would subpart2 still be considered a valid root? 
    - perhaps not
    
b) administrative change writes 0-2 into part1 cpus
  - would part1 still be considered a valid root? 
    - yes
  - would subpart1 still be considered a valid root? 
    - yes
  - would subpart2 still be considered a valid root? 
    - perhaps not

c) administrative change writes 3-7 into `other` cpus
  - should this fail or invalidate a root partition part1?
    - perhaps fail since the same "owner" manages all siblings and
      should reduce part1 first

The answers above are just my "natural" responses, the ideal may be
different. The issue I want to illustrate is that if all the conditions
are formed as transition conditions only, they can't be used to reason
about hotplug or config changes (except for cpuset.cpus.partitions
writes).

What would help me with the understanding -- the invalid root partition is defined as
1) such a cgroup where no cpus are granted from the top (and thus has to fall back to ancestors)
or
2) such a cgroup where cpus requested in cpuset.cpus can't be fulfilled (i.e. any missing invalidates)?

Furthermore, another example (motivated by the patch 4/6)

r		// all cpus 0-7
`- part1	cpus=0-4	root >partition
   ` subpart1	cpus=0-1	root >partition
   ` subpart2	cpus=2-3	root >partition
   ` task
`- other	cpus=5-7	// member by default

It's a valid and achievable state (even on v2 since cpuset is a threaded
controller). 

a) cpu 4 is offlined
  - this should invalidate part1 (and propagate invalidation into
    subpart1 and subpart2).
b) administrative write 0-3 into part1 cpus
  - should this invalidate part1 or be rejected?


In conclusion, it'd be good to have validity conditions separate from
transition conditions (since hotplug transition can't be rejected) and
perhaps treat administrative changes from an ancestor equally as a
hotplug.

Thanks,
Michal
