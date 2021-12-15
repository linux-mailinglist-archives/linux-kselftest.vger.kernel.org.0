Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1C6475B05
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 15:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243447AbhLOOts (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 09:49:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42592 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243326AbhLOOtr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 09:49:47 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D1E6D1F3D1;
        Wed, 15 Dec 2021 14:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639579785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=euooVMEZrx6lIqaC7AMmnzXnheQmRgVNrxBqLKPSDeo=;
        b=aeZp5/6ZBT1NQPyhZwdCBE9p7ifowhSb5Hl3nbSP98JM2lL79llq1iWlF6SyW8eDoL1JAE
        ENZAWU9w2b1dAX4LN6zUnritfxHJIXjDC9LjsCUO2sl/hJRZdOntrqINvCU530pRSSnWxE
        gtvstSGrCMdd159A9k7YD3+lqDybexg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D8931330B;
        Wed, 15 Dec 2021 14:49:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M5LuJYkAumGbcwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 15 Dec 2021 14:49:45 +0000
Date:   Wed, 15 Dec 2021 15:49:44 +0100
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
Subject: Re: [PATCH v9 3/7] cgroup/cpuset: Refining features and constraints
 of a partition
Message-ID: <20211215144944.GE16798@blackbody.suse.cz>
References: <20211205183220.818872-1-longman@redhat.com>
 <20211205183220.818872-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205183220.818872-4-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 05, 2021 at 01:32:16PM -0500, Waiman Long <longman@redhat.com> wrote:
> @@ -1455,34 +1450,16 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
>  			switch (parent->partition_root_state) {
> [...]
> -
>  			case PRS_ENABLED:
> -				if (update_parent_subparts_cpumask(cp, partcmd_update, NULL, tmp))
> -					update_tasks_cpumask(parent);
> +				update_parent = true;
> [...]
> +		if (update_parent) {
> +			if (update_parent_subparts_cpumask(cp, partcmd_update, NULL, tmp))
> +				update_tasks_cpumask(parent);
> +			/*
> +			 * The cpuset partition_root_state may be changed
> +			 * to PRS_ERROR. Capture it.
> +			 */
> +			new_prs = cp->partition_root_state;
> +		}

IIUC, this ensures that when a parent becomes partition root again, this
would propagate downwards to invalidated children. 

However, the documentation says:

> +       Changing a partition root (valid or invalid) to "member" is
> +       always allowed.  If there are child partition roots underneath
> +       it, they will become invalid and unrecoverable.  So care must
> +       be taken to double check for this condition before disabling
> +       a partition root.

I.e. it suggests a child can be trapped in the unrecoverable state (i.e.
not fixable by writing into cpuset.cpus.partition).
But this does not happen, right?

Michal
