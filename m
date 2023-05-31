Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7031718EF4
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 01:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjEaXLo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 19:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjEaXLn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 19:11:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FEC12C;
        Wed, 31 May 2023 16:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=nmte9E9sXVloF6HUJV4QBiAwzkNA1xzyrniH4jntggs=; b=a/Su64r/VzsuH3nHvF5cXQ/zgX
        mnKbP/aBaq+ZKi1XzrsK5gORPxNLqYyEbzM/22/x3NWQBBvc2x40ocTn6gG995iRZqKuiP8SjxXxj
        qLVIkE3AiIGnpz3HntG6+qWplO3b1BaoYoWEKEVozzHNKgZ5TAVm7jab3w5HLtNGRwY08V+jgmAU/
        k0hbkbFKP9kq3T5KpJy1RGUHwunKj6Dv7TC50cVxWnnpJN/nhMuSb5swDMrYOCFfTZYnaZImZAHiP
        QhVxkXXjmuFY/4cOkVVCQu1y+RQ7Z0GRaPI9305VKIbvEkg9ugWQtn2c1yKEYPVCyB5S7xBUdjQD9
        +3vYiCvw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Uyb-001RVl-2n;
        Wed, 31 May 2023 23:11:33 +0000
Message-ID: <c26c2a9e-13af-2b7c-d3dd-8455a10d84c6@infradead.org>
Date:   Wed, 31 May 2023 16:11:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/6] cgroup/cpuset: Documentation update for partition
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>
References: <20230531163405.2200292-6-longman@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230531163405.2200292-6-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Just a few small nits below:

On 5/31/23 09:34, Waiman Long wrote:
> This patch updates the cgroup-v2.rst file to include information about
> the new "cpuset.cpus.reserve" control file as well as the new remote
> partition.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 92 +++++++++++++++++++++----
>  1 file changed, 79 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index f67c0829350b..3e9351c2cd27 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2215,6 +2215,38 @@ Cpuset Interface Files
>  
>  	Its value will be affected by memory nodes hotplug events.
>  
> +  cpuset.cpus.reserve
> +	A read-write multiple values file which exists only on root
> +	cgroup.
> +
> +	It lists all the CPUs that are reserved for adjacent and remote
> +	partitions created in the system.  See the next section for
> +	more information on what an adjacent or remote partitions is.
> +
> +	Creation of adjacent partition does not require touching this
> +	control file as CPU reservation will be done automatically.
> +	In order to create a remote partition, the CPUs needed by the
> +	remote partition has to be written to this file first.
> +
> +	Due to the fact that "cpuset.cpus.reserve" holds reserve CPUs
> +	that can be used by multiple partitions and automatic reservation
> +	may also race with manual reservation, an extension prefixes of
> +	"+" and "-" are allowed for this file to reduce race.
> +
> +	A "+" prefix can be used to indicate a list of additional
> +	CPUs that are to be added without disturbing the CPUs that are
> +	originally there.  For example, if its current value is "3-4",
> +	echoing ""+5" to it will change it to "3-5".

	        "+5"

> +
> +	Once a remote partition is destroyed, its CPUs have to be
> +	removed from this file or no other process can use them.  A "-"
> +	prefix can be used to remove a list of CPUs from it.  However,
> +	removing CPUs that are currently used in existing partitions
> +	may cause those partitions to become invalid.  A single "-"
> +	character without any number can be used to indicate removal
> +	of all the free CPUs not yet allocated to any partitions to
> +	avoid accidental partition invalidation.
> +
>    cpuset.cpus.partition
>  	A read-write single value file which exists on non-root
>  	cpuset-enabled cgroups.  This flag is owned by the parent cgroup
> @@ -2228,25 +2260,49 @@ Cpuset Interface Files
>  	  "isolated"	Partition root without load balancing
>  	  ==========	=====================================
>  
> -	The root cgroup is always a partition root and its state
> -	cannot be changed.  All other non-root cgroups start out as
> -	"member".
> +	A cpuset partition is a collection of cgroups with a partition
> +	root at the top of the hierarchy and its descendants except
> +	those that are separate partition roots themselves and their
> +	descendants.  A partition has exclusive access to the set of
> +	CPUs allocated to it.  Other cgroups outside of that partition
> +	cannot use any CPUs in that set.
> +
> +	There are two types of partitions - adjacent and remote.  The
> +	parent of an adjacent partition must be a valid partition root.
> +	Partition roots of adjacent partitions are all clustered around
> +	the root cgroup.  Creation of adjacent partition is done by
> +	writing the desired partition type into "cpuset.cpus.partition".
> +
> +	A remote partition does not require a partition root parent.
> +	So a remote partition can be formed far from the root cgroup.
> +	However, its creation is a 2-step process.  The CPUs needed
> +	by a remote partition ("cpuset.cpus" of the partition root)
> +	has to be written into "cpuset.cpus.reserve" of the root
> +	cgroup first.  After that, "isolated" can be written into
> +	"cpuset.cpus.partition" of the partition root to form a remote
> +	isolated partition which is the only supported remote partition
> +	type for now.
> +
> +	All remote partitions are terminal as adjacent partition cannot
> +	be created underneath it.  With the way remote partition is
> +	formed, it is not possible to create another valid remote
> +	partition underneath it.
> +
> +	The root cgroup is always a partition root and its state cannot
> +	be changed.  All other non-root cgroups start out as "member".
>  
>  	When set to "root", the current cgroup is the root of a new
> -	partition or scheduling domain that comprises itself and all
> -	its descendants except those that are separate partition roots
> -	themselves and their descendants.
> +	partition or scheduling domain.
>  
> -	When set to "isolated", the CPUs in that partition root will
> +	When set to "isolated", the CPUs in that partition will
>  	be in an isolated state without any load balancing from the
>  	scheduler.  Tasks placed in such a partition with multiple
>  	CPUs should be carefully distributed and bound to each of the
>  	individual CPUs for optimal performance.
>  
> -	The value shown in "cpuset.cpus.effective" of a partition root
> -	is the CPUs that the partition root can dedicate to a potential
> -	new child partition root. The new child subtracts available
> -	CPUs from its parent "cpuset.cpus.effective".
> +	The value shown in "cpuset.cpus.effective" of a partition root is
> +	the CPUs that are dedicated to that partition and not available
> +	to cgroups outside of that partittion.

	                           partition.

>  
>  	A partition root ("root" or "isolated") can be in one of the
>  	two possible states - valid or invalid.  An invalid partition
> @@ -2270,8 +2326,8 @@ Cpuset Interface Files
>  	In the case of an invalid partition root, a descriptive string on
>  	why the partition is invalid is included within parentheses.
>  
> -	For a partition root to become valid, the following conditions
> -	must be met.
> +	For an adjacent partition root to be valid, the following
> +	conditions must be met.
>  
>  	1) The "cpuset.cpus" is exclusive with its siblings , i.e. they
>  	   are not shared by any of its siblings (exclusivity rule).
> @@ -2281,6 +2337,16 @@ Cpuset Interface Files
>  	4) The "cpuset.cpus.effective" cannot be empty unless there is
>  	   no task associated with this partition.
>  
> +	For a remote partition root to be valid, the following conditions
> +	must be met.
> +
> +	1) The same exclusivity rule as adjacent partition root.
> +	2) The "cpuset.cpus" is not empty and all the CPUs must be
> +	   present in "cpuset.cpus.reserve" of the root cgroup and none
> +	   of them are allocated to another partition.
> +	3) The "cpuset.cpus" value must be present in all its ancestors
> +	   to ensure proper hierarchical cpu distribution.

	                                 CPU

> +
>  	External events like hotplug or changes to "cpuset.cpus" can
>  	cause a valid partition root to become invalid and vice versa.
>  	Note that a task cannot be moved to a cgroup with empty

-- 
~Randy
