Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB7A518C89
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 May 2022 20:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241605AbiECSq5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 14:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241585AbiECSqy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 14:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93CA93191E
        for <linux-kselftest@vger.kernel.org>; Tue,  3 May 2022 11:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651603309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wAjZbwqar/ddmAXQ+agT5r7ZgOk1RQOfgtbGHsbQLps=;
        b=TJk96OSNg/kNx/2+nc0GBo8YcdOqKlnEAU9zCx63lqBQ79nVizO8ykYTmRQreyerV6Ea0V
        H+dsJG95zYJUuknL8VHwmtuZCOBsGpQPBI0YRQ38H8Z7uG3ld44iZPhNsNaRY5aXnw5XvV
        IxjOo1xHS7E5b1Uft8HY66tTx4sY6gg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-baiEU2_JMEaKQJhAkf0UPA-1; Tue, 03 May 2022 14:39:36 -0400
X-MC-Unique: baiEU2_JMEaKQJhAkf0UPA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2D7A3806703;
        Tue,  3 May 2022 18:39:23 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A13B54CB17;
        Tue,  3 May 2022 18:39:23 +0000 (UTC)
Message-ID: <66910f2d-a8c0-6c04-cca0-62a00fbad6cf@redhat.com>
Date:   Tue, 3 May 2022 14:39:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 3/8] cgroup/cpuset: Allow no-task partition to have
 empty cpuset.cpus.effective
Content-Language: en-US
To:     Phil Auld <pauld@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20220503162149.1764245-1-longman@redhat.com>
 <20220503162149.1764245-4-longman@redhat.com>
 <20220503175454.GA20433@pauld.bos.csb>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220503175454.GA20433@pauld.bos.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/3/22 13:54, Phil Auld wrote:
> Hi Waiman
>
> On Tue, May 03, 2022 at 12:21:44PM -0400 Waiman Long wrote:
>> Currently, a partition root cannot have empty "cpuset.cpus.effective".
>> As a result, a parent partition root cannot distribute out all its CPUs
>>   to child partitions with no CPUs left. However in most cases, there
>> shouldn't be any tasks associated with intermediate nodes of the default
>>   hierarchy. So the current rule is too restrictive and can waste valuable
>>   CPU resource.
>>
>> To address this issue, we are now allowing a partition to have empty
>> "cpuset.cpus.effective" as long as it has no task. Therefore, a parent
>> partition with no task can now have all its CPUs distributed out to its
>> child partitions. The top cpuset always have some house-keeping tasks
>> running and so its list of effective cpu can't never be empty.
> s/never/ever/
It is a double negative. I think I will just remove "never".
>> Once a partition with empty "cpuset.cpus.effective" is formed, no
>> new task can be moved into it until "cpuset.cpus.effective" becomes
>> non-empty.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 111 +++++++++++++++++++++++++++++++----------
>>   1 file changed, 84 insertions(+), 27 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index d156a39d7a08..7d9abd50a1b9 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -412,6 +412,41 @@ static inline bool is_in_v2_mode(void)
>>   	      (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
>>   }
>>   
>> +/**
>> + * partition_is_populated - check if partition has tasks
>> + * @cs: partition root to be checked
>> + * @excluded_child: a child cpuset to be excluded in task checking
>> + * Return: true if there are tasks, false otherwise
>> + *
>> + * It is assumed that @cs is a valid partition root. @excluded_child should
>> + * be non-NULL when this cpuset is going to become a partition itself.
>> + */
>> +static inline bool partition_is_populated(struct cpuset *cs,
>> +					  struct cpuset *excluded_child)
>> +{
>> +	struct cgroup_subsys_state *css;
>> +	struct cpuset *child;
>> +
>> +	if (cs->css.cgroup->nr_populated_csets)
>> +		return true;
>> +	if (!excluded_child && !cs->nr_subparts_cpus)
>> +		return cgroup_is_populated(cs->css.cgroup);
>> +
>> +	rcu_read_lock();
>> +	cpuset_for_each_child(child, css, cs) {
>> +		if (child == excluded_child)
>> +			continue;
>> +		if (is_partition_valid(child))
>> +			continue;
>> +		if (cgroup_is_populated(child->css.cgroup)) {
>> +			rcu_read_unlock();
>> +			return true;
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +	return false;
>> +}
>> +
>>   /*
>>    * Return in pmask the portion of a task's cpusets's cpus_allowed that
>>    * are online and are capable of running the task.  If none are found,
>> @@ -1252,22 +1287,25 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
>>   	if ((cmd != partcmd_update) && css_has_online_children(&cs->css))
>>   		return -EBUSY;
>>   
>> -	/*
>> -	 * Enabling partition root is not allowed if not all the CPUs
>> -	 * can be granted from parent's effective_cpus or at least one
>> -	 * CPU will be left after that.
>> -	 */
>> -	if ((cmd == partcmd_enable) &&
>> -	   (!cpumask_subset(cs->cpus_allowed, parent->effective_cpus) ||
>> -	     cpumask_equal(cs->cpus_allowed, parent->effective_cpus)))
>> -		return -EINVAL;
>> -
>> -	/*
>> -	 * A cpumask update cannot make parent's effective_cpus become empty.
>> -	 */
>>   	adding = deleting = false;
>>   	old_prs = new_prs = cs->partition_root_state;
>>   	if (cmd == partcmd_enable) {
>> +		/*
>> +		 * Enabling partition root is not allowed if not all the CPUs
>> +		 * can be granted from parent's effective_cpus.
>> +		 */
>> +		if (!cpumask_subset(cs->cpus_allowed, parent->effective_cpus))
>> +			return -EINVAL;
>> +
>> +		/*
>> +		 * A parent can be left with no CPU as long as there is no
>> +		 * task directly associated with the parent partition. For
>> +		 * such a parent, no new task can be moved into it.
>> +		 */
>> +		if (partition_is_populated(parent, cs) &&
>> +		    cpumask_equal(cs->cpus_allowed, parent->effective_cpus))
>> +			return -EINVAL;
>> +
> You might consider switching these around to check the cpumasks first.
Good point, partition_is_populated() is more expensive.
>
>
>>   		cpumask_copy(tmp->addmask, cs->cpus_allowed);
>>   		adding = true;
>>   	} else if (cmd == partcmd_disable) {
>> @@ -1289,9 +1327,10 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
>>   		adding = cpumask_andnot(tmp->addmask, tmp->addmask,
>>   					parent->subparts_cpus);
>>   		/*
>> -		 * Return error if the new effective_cpus could become empty.
>> +		 * Return error if the new effective_cpus could become empty
>> +		 * and there are tasks in the parent.
>>   		 */
>> -		if (adding &&
>> +		if (adding && partition_is_populated(parent, cs) &&
>>   		    cpumask_equal(parent->effective_cpus, tmp->addmask)) {
> Same.
Thanks,
Longman

