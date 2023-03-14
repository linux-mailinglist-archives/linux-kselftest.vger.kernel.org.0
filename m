Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E34E6BA099
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 21:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjCNUXC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 16:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjCNUXA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 16:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8634FF20
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678825332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bbs0o/I6rpn+v4ABnfsXhv4qYHU4BQjlxXMhiiFts7A=;
        b=RyvRmZAL/hJVndPZJZINswt6VkA+ZCsZZVQTmLaIlockg6DwIdmkdE+pASKiOh3UcgFzD7
        bFbxG/cJ3mtGaWFKy3Sq4EzPdl0sGdLh++8dMjDMrXGVzPfq8meUuu/7bofQZykxnRaEvi
        tyFXNE/+MUqCi4bckLC6eIwB6XnZMNE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-0wE_4SN4MY6LNcgoCxnomw-1; Tue, 14 Mar 2023 16:22:08 -0400
X-MC-Unique: 0wE_4SN4MY6LNcgoCxnomw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADD84887402;
        Tue, 14 Mar 2023 20:22:07 +0000 (UTC)
Received: from [10.22.9.226] (unknown [10.22.9.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B88540C6E67;
        Tue, 14 Mar 2023 20:22:07 +0000 (UTC)
Message-ID: <58a1a878-fa0b-285d-3e43-2b5103d3c770@redhat.com>
Date:   Tue, 14 Mar 2023 16:22:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/5] cgroup/cpuset: Find another usable CPU if none found
 in current cpuset
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230306200849.376804-1-longman@redhat.com>
 <20230306200849.376804-4-longman@redhat.com>
 <20230314181749.5b4k6selbgdhl3up@blackpad>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230314181749.5b4k6selbgdhl3up@blackpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/14/23 14:17, Michal Koutný wrote:
> Hello.
>
> On Mon, Mar 06, 2023 at 03:08:47PM -0500, Waiman Long <longman@redhat.com> wrote:
>> On a system with asymmetric CPUs, a restricted task is one that can run
>> only a selected subset of available CPUs.  When a CPU goes offline or
>> when "cpuset.cpus" is changed, it is possible that a restricted task
>> may not have any runnable CPUs left in the current cpuset even if there
>> is still some CPUs in effective_cpus. In this case, the restricted task
>> cannot be run at all.
>>
>> There are several ways we may be able to handle this situation. Treating
>> it like empty effective_cpus is probably too disruptive and is unfair to
>> the normal tasks. So it is better to have some special handling for these
>> restricted tasks. One possibility is to move the restricted tasks up the
>> cpuset hierarchy, but it is tricky to do it right. Another solution is
>> to assign other usable CPUs to these tasks. This patch implements the
>> later alternative by finding one usable CPU by walking up the cpuset
>> hierarchy and printing an informational message to let the users know
>> that these restricted tasks are running in a cpuset with no usable CPU.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 56 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 55 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index bbf57dcb2f68..aa8225daf1d3 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1202,6 +1202,38 @@ void rebuild_sched_domains(void)
>>   	cpus_read_unlock();
>>   }
>>   
>> [...]
>>   /**
>>    * update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
>>    * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
>> @@ -1218,6 +1250,7 @@ static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
>>   	struct task_struct *task;
>>   	bool top_cs = cs == &top_cpuset;
>>   
>> +	percpu_rwsem_assert_held(&cpuset_rwsem);
>>   	css_task_iter_start(&cs->css, 0, &it);
>>   	while ((task = css_task_iter_next(&it))) {
>>   		const struct cpumask *possible_mask = task_cpu_possible_mask(task);
>> @@ -1232,7 +1265,28 @@ static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
>>   		} else {
>>   			cpumask_and(new_cpus, cs->effective_cpus, possible_mask);
>>   		}
>> -		set_cpus_allowed_ptr(task, new_cpus);
>> +		/*
>> +		 * On systems with assymetric CPUs, it is possible that
>> +		 * cpumask will become empty or set_cpus_allowed_ptr() will
>> +		 * return an error even if we still have CPUs in
>> +		 * effective_cpus. In this case, we find a usable CPU walking
>> +		 * up the cpuset hierarchy and use that for this particular
>> +		 * task with an informational message about the change in the
>> +		 * hope that the users will adjust "cpuset.cpus" accordingly.
>> +		 */
>> +		if (cpumask_empty(new_cpus) ||
>> +		    set_cpus_allowed_ptr(task, new_cpus)) {
> IIUC, cpumask_empty(new_cpus) here implies
> cpumask_empty(cs->effective_cpus) but that shouldn't happen (cs should
> inherit non-empty mask from an ancestor). Do I miss/forget anything?
>
> This thus covers the case when p->user_cpus_ptr is incompatible with
> hotplug or cpuset.cpus allowance and a different affinity must be
> chosen. But doesn't that mean that the task would run _out_ of
> cs->effective_cpus?
> I guess that's unavoidable on asymmetric CPU archs but not no SMPs.
> Shouldn't the solution distinguish between the two? (I.e. never run out
> of effective_cpus on SMP.)

Some arm64 systems can have asymmetric CPUs where certain tasks are only 
runnable on a selected subset of CPUs.  This information is not captured 
in the cpuset. As a result, task_cpu_possible_mask() may return a mask 
that have no overlap with effective_cpus causing new_cpus to become 
empty. It takes me a while to understand the implication of that. I will 
elaborate this point a bit more in the patch.

Cheers,
Longman

