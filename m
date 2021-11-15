Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F713451D60
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Nov 2021 01:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346983AbhKPA3W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 19:29:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46814 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346560AbhKOTee (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 14:34:34 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1243E218D6;
        Mon, 15 Nov 2021 19:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637004684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b4ZiiwEnz5XGSlWeT8O+jkCefoPIbeg8p3rHgDHkvM8=;
        b=hfo7k3ahAq+4WiayhhOAps8Zu5wAe5DwJIiHDlPpeCzNbkiWPbAOOnNXVL2YcbwxT3z+aT
        8eO9nE9fZ/TfsPOuBb0fxmigq974glS7V22iBaPiyrHPEh5gmiV+m2TBjRM/BtzH8uwgqZ
        IkmYD5pRuYyF6FOldCIXVATt7yLJuiM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C18F613A90;
        Mon, 15 Nov 2021 19:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nwj7LYu1kmF3dwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 15 Nov 2021 19:31:23 +0000
Date:   Mon, 15 Nov 2021 20:31:22 +0100
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
Message-ID: <20211115193122.GA16798@blackbody.suse.cz>
References: <20211018143619.205065-1-longman@redhat.com>
 <20211018143619.205065-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211018143619.205065-6-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Hello.

On Mon, Oct 18, 2021 at 10:36:18AM -0400, Waiman Long <longman@redhat.com> wrote:
> +	When set to "isolated", the CPUs in that partition root will
> +	be in an isolated state without any load balancing from the
> +	scheduler.  Tasks in such a partition must be explicitly bound
> +	to each individual CPU.

This sounds reasonable but it seems to have some usability issues as was
raised in another thread [1]. (I could only think of the workaround of
single-cpu cgroup leaves + CLONE_INTO_CGROUP.)

TL;DR Do whatever you find suitable but (re)consider sticking to the
delegation principle (making hotplug and ancestor changes equal).

Now to the constraints and partition setups. I think it's useful to have
a model with which the implementation can be compared with.
I tried to condense some "simple rules" from the descriptions you posted
in v8 plus your response to my remarks in v7 [2]. These should only be
the "validity conditions", not "transition conditions".

## Validity conditions

For simplification, there's a condition called 'degraded' that tells
whether a cpuset can host tasks (with the given config) that expands to
two predicates:

	degraded := cpus.internal_effective == ø && has_tasks
	valid_root := !degraded && cpus_exclusive && parent.valid_root
	(valid_member := !degraded)

with a helping predicate
	cpus_exclusive := cpus not shared by a sibling

The effective CPUs basically combine configured+available CPUs

	cpus.internal_effective := (cpus ∩ parent.cpus ∩ online_cpus) - passed

where
	passed := union of children cpus whose partition is not member

Finally, to handle the degraded cpusets gracefully, we define

	if (!degraded)
		cpus.effective := cpus.internal_effective 
	else
		cpus.effective := parent.cpus.effective

(In cases when there's no parent, we replace its cpus with online_cpus.)

---

I'll try applying these conditions to your description.

> +
> +	"cpuset.cpus" must always be set up first before enabling
> +	partition.

This is just a transition condition.

>       Unlike "member" whose "cpuset.cpus.effective" can
> +	contain CPUs not in "cpuset.cpus", this can never happen with a
> +	valid partition root. In other words, "cpuset.cpus.effective"
> +	is always a subset of "cpuset.cpus" for a valid partition root.

IIUC this refers to the cgroup that is 'degraded'. (The consequences for
a valid partition root follow from valid_root definition above.)

> +
> +	When a parent partition root cannot exclusively grant any of
> +	the CPUs specified in "cpuset.cpus", "cpuset.cpus.effective"
> +	becomes empty.

This sounds too strict to me, perhaps you meant 'cannot grant _all_ of
the CPUs'?

>       If there are tasks in the partition root, the
> +	partition root becomes invalid and "cpuset.cpus.effective"
> +	is reset to that of the nearest non-empty ancestor.

This is captured in the definition of 'degraded'.

> +
> +        Note that a task cannot be moved to a croup with empty
> +        "cpuset.cpus.effective".

A transition condition. (Makes sense.)

[With the validity conditions above, it's possible to have 'valid_root'
with empty cpus (hence also empty cpus.internal_effective) if there are
no tasks in there. The transition conditions so far prevented this
corner case.]

> +	There are additional constraints on where a partition root can
> +	be enabled ("root" or "isolated").  It can only be enabled in
> +	a cgroup if all the following conditions are met.

I think the enablement (aka rewriting cpuset.cpus.partition) could be
always possible but it'd result in "root invalid (...)" if the resulting
config doesn't meet the validity condition.

> +
> +	1) The "cpuset.cpus" is non-empty and exclusive, i.e. they are
> +	   not shared by any of its siblings.

The emptiness here is a judgement call (in my formulation of the
conditions it seemed simpler to allow empty cpus.internal_effective with
no tasks).

> +	2) The parent cgroup is a valid partition root.

Captured in the valid_root definition.

> +	3) The "cpuset.cpus" is a subset of parent's "cpuset.cpus".

This is unnecessary strictness. Allow such config,
cpus.internal_effective still can't be more than parent's cpuset.cpus.
(Or do you have a reason to discard such configs?)

> +	4) There is no child cgroups with cpuset enabled.  This avoids
> +	   cpu migrations of multiple cgroups simultaneously which can
> +	   be problematic.

A transition condition (i.e. not relevant to validity conditions).

> +	Once becoming a partition root, changes to "cpuset.cpus"
> +	is generally allowed as long as the cpu list is exclusive,
> +	non-empty and is a superset of children's cpu lists.

Any changes should be allowed otherwise it denies the delegation
principle of v2 (IOW a parent should be able to preempt CPUs given to
chilren previously and not be denied because of them).

(If the change results in failed validity condition the cgroup of course
cannot be be a valid_root anymore.)

> +        The constraints of a valid partition root are as follows:
> +
> +        1) The parent cgroup is a valid partition root.
> +        2) "cpuset.cpus.effective" is a subset of "cpuset.cpus"
> +        3) "cpuset.cpus.effective" is non-empty when there are tasks
> +           in the partition.

(This seem to miss the sibling exclusivity condition.)
Here I'd simply paste the "Validity conditions" specified above instead.

> +        Changing a partition root to "member" is always allowed.
> +        If there are child partition roots underneath it, however,
> +        they will be forced to be switched back to "member" too and
> +        lose their partitions. So care must be taken to double check
> +        for this condition before disabling a partition root.

(Or is this how delegation is intended?) However, AFAICS, parent still
can't remove cpuset.cpus even when the child is a "member". Otherwise,
I agree with the back-switch.


> +	Setting a cgroup to a valid partition root will take the CPUs
> +	away from the effective CPUs of the parent partition.

Captured in the definition of cpus.internal_effective.

> +	A valid parent partition may distribute out all its CPUs to
> +	its child partitions as long as it is not the root cgroup as
> +	we need some house-keeping CPUs in the root cgroup.

This actually applies to any root partition that's supposed to host
tasks. (IOW, 'valid_root' cannot be 'degraded'.)

> +	An invalid partition is not a real partition even though some
> +	internal states may still be kept.

Tautology? (Or new definition of "real".)

> +
> +	An invalid partition root can be reverted back to a real
> +	partition root if none of the constraints of a valid partition
> +        root are violated.

Yes. (Also tautological.)

Anyway, as I said above, I just tried to formulate the model for clearer
understanding and the implementation may introduce transition
constraints but it'd be good to always have the simple rules to tell
what's a valid root in the tree and what's not.

Regards,
Michal

[1] https://lore.kernel.org/r/AM9PR10MB4869C14EAE01B87C0037BF6A89939@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM/
[2] https://lore.kernel.org/lkml/5eacfdcc-148b-b599-3111-4f2971e7ddc0@redhat.com/

