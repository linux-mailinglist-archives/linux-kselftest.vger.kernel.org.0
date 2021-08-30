Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38D93FBB57
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Aug 2021 19:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbhH3SAk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Aug 2021 14:00:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51556 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbhH3SAk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Aug 2021 14:00:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4B61222121;
        Mon, 30 Aug 2021 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630346385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fjtm8tVefXUCT0rdTzMn/o5zpc91NrF6pXy1z50nDUM=;
        b=TyI+3u+QEneileBnDmwJhe/7GU/cZ4f+Sj8PsvZ9ugakdDVaT8ur0+WioUJKotS8fyURo0
        Mm12eWM1b0hCFWGb0F0M+ECUj56MCl6ARx+3TzD2Y8ZHaqgpxOq8DgRVIyvlvXxef349Py
        dUMXeDS74InyxljMGcbhds/MtAMoLJk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6D6F13A98;
        Mon, 30 Aug 2021 17:59:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 74kZM5AcLWEBdAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 30 Aug 2021 17:59:44 +0000
Date:   Mon, 30 Aug 2021 19:59:43 +0200
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
Message-ID: <YS0cj+0thCHmXw/M@blackbook>
References: <20210825213750.6933-1-longman@redhat.com>
 <20210825213750.6933-6-longman@redhat.com>
 <YSfQ0mYWs2zUyqGY@mtj.duckdns.org>
 <32e27fcc-32f1-b26c-ae91-9e03f7e433af@redhat.com>
 <YShjb2WwvuB4s4gX@slm.duckdns.org>
 <d22ea3be-2429-5923-a80c-5af3b384def9@redhat.com>
 <YSlY0H/qeXQIGOfk@slm.duckdns.org>
 <392c3724-f583-c7fc-cfa1-a3f1665114c9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <392c3724-f583-c7fc-cfa1-a3f1665114c9@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello.

On Fri, Aug 27, 2021 at 06:50:10PM -0400, Waiman Long <llong@redhat.com> wrote:
> So the new rules will be:

When I followed the thread, it seemed to me you're talking past each
other a bit. I'd suggest the following terminology:

- config space: what's written by the user and saved,

- reality space: what's currently available (primarily subject to
  on-/offlinng but I think it'd be helpful to consider here also what's
  given by the parent),

- effect space: what's actually possible and happening.

Not all elements of config_space x reality_space (Cartesian product) can
be represented in the effect_space (e.g. root partition with no
(effective) cpus).

IIUC, Waiman's "high bar" is supposed to be defined over transitions in
the config_space. However, there can be independent changes in the
reality_space so the rules should be actually formulated in the
effect_space:

The conditions for being a valid partition root rewritten into the effect
space:

> 1) The "cpuset.cpus" is not empty and the list of CPUs are exclusive.
- effective CPUs are non-empty and exclusive wrt siblings
- (E.g. setting empty cpuset.cpus might be possible but it invalidates
  the partition root, same as offlining or removal by an ancestor.)

> 2) The parent cgroup is a partition root (can be an invalid one).
- parent cgroup is a (valid) partition
- (Being valid partition means owning "stolen" cpus from the parent, if
  the parent is not valid partition itself, you can't steal what is not
  owned.)
- (And I think it's OK that: "the child partitions will stay invalid
  forever unless the parent become a valid partition again" [1].)

> 3) The "cpuset.cpus" is a subset of the parent's cpuset.cpus.allowed.
- I'm not sure what is the use of this condition (together with the
  rewrite of the 1st condition which covers effective cpus). I think it
  would make sense if being a valid parition root guaranteed that all
  configured cpuset.cpus will be available, however, that's not the case
  IIUC (e.g. due to offlining).

> 4) No child cgroup with cpuset enabled.
- A child cgroup with cpuset enabled is OK in the effect space
  (achievable by switching first and creating children later).
- For technical reasons this may be a condition on the transitions in
  the config_space.

Generally, most config changes should succeed and user should check (or
watch) how they landed in combination with the reality_space.

Regards,
Michal

[1] This follows the general model where ancestors can "preempt"
resources from their subtree.
