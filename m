Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2527B6BAC
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Oct 2023 16:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbjJCOcv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Oct 2023 10:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbjJCOcu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Oct 2023 10:32:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EA5DD
        for <linux-kselftest@vger.kernel.org>; Tue,  3 Oct 2023 07:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696343518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VkFkREvMpIFY75MsS4WugWdjffEi9yEFVFPUdYjBa9M=;
        b=PZPp9Eslffj4JgfZ7FkmWpjqM4AlJ/PHtZEqWeAaO3jDYut8ADaT5kHQ8zDXZJTTnqDm1X
        +b4MvI3uMRqrxg4nSPrwWCFJYFRes8CJkrZNLRuJoMmPt4YfDQNkwZh/xMcAk1ZlqVaQ5O
        qDBzf89f+HaR9jJAI+SFRvwfQkVfQoU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-k8wuuBU_NECoJpRWcOW2pQ-1; Tue, 03 Oct 2023 10:31:45 -0400
X-MC-Unique: k8wuuBU_NECoJpRWcOW2pQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1FF28893CD;
        Tue,  3 Oct 2023 14:31:43 +0000 (UTC)
Received: from [10.22.10.176] (unknown [10.22.10.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 042B840C2013;
        Tue,  3 Oct 2023 14:31:42 +0000 (UTC)
Message-ID: <de67d8f5-b830-7546-94d7-396e3ed30ac8@redhat.com>
Date:   Tue, 3 Oct 2023 10:31:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH-cgroup] cgroup/cpuset: Enable invalid to valid local
 partition transition
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20230930034402.2776278-1-longman@redhat.com>
 <ed8e013a-ece2-4a9c-142f-e9f62883e7b1@arm.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ed8e013a-ece2-4a9c-142f-e9f62883e7b1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 10/2/23 06:06, Pierre Gondois wrote:
> Hello Waiman,
>
> I could test the patch using the for-next branch in your tree.
> Just a NIT, it seemed that the message indicating the reason
> the isolated configuration was invalid is not printed anymore:
>
> Commands:
> # mkdir cgroup
> # mount -t cgroup2 none cgroup/
> # mkdir cgroup/A1 cgroup/B1
> # echo "+cpuset" > cgroup/cgroup.subtree_control
> # echo 0-3 > cgroup/A1/cpuset.cpus
> # echo isolated > cgroup/A1/cpuset.cpus.partition
> # echo 4-6 > cgroup/B1/cpuset.cpus
> # cat cgroup/A1/cpuset.cpus.partition
> isolated
> # echo 0-4 > cgroup/A1/cpuset.cpus
> # cat cgroup/A1/cpuset.cpus.partition
> isolated invalid                      <--- used to have '(Cpu list in 
> cpuset.cpus not exclusive)'
> # echo 0-3 > cgroup/A1/cpuset.cpus
> # cat cgroup/A1/cpuset.cpus.partition
> isolated                              <--- now working!
>
>
> But when creating an isolated partition from overlapping cpusets,
> the message is printed:
> # mkdir cgroup
> # mount -t cgroup2 none cgroup/
> # mkdir cgroup/A1 cgroup/B1
> # echo "+cpuset" > cgroup/cgroup.subtree_control
> # echo 0-4 > cgroup/A1/cpuset.cpus
> # echo 4-6 > cgroup/B1/cpuset.cpus
> # echo isolated > cgroup/B1/cpuset.cpus.partition
>
> # cat cgroup/A1/cpuset.cpus.partition
> member
> # cat cgroup/B1/cpuset.cpus.partition
> isolated invalid (Cpu list in cpuset.cpus not exclusive) <--- Complete 
> message printed

I might have misread it yesterday. The current behavior is correct. A 
valid partition requires exclusive access to the CPUs among the 
siblings. So it won't allow the cpuset to become valid partition if that 
is the not case. This behavior is the same as cgroup v1's  
"cpuset.cpu_exclusive".

As soon as the cpu list is adjusted in B1 to avoid cpu list overlap, it 
will become a valid partition. However, change to A1 to avoid cpu 
overlap won't affect the state of B1. You will have to echo "root" to 
B1's cpuset.cpus.partition to make it valid again.

>
>
> On 9/30/23 05:44, Waiman Long wrote:
>> When a local partition becomes invalid, it won't transition back to
>> valid partition automatically if a proper "cpuset.cpus.exclusive" or
>> "cpuset.cpus" change is made. Instead, system administrators have to
>> explicitly echo "root" or "isolated" into the "cpuset.cpus.partition"
>> file at the partition root.
>>
>> This patch now enables the automatic transition of an invalid local
>> partition back to valid when there is a proper "cpuset.cpus.exclusive"
>> or "cpuset.cpus" change.
>>
>> Automatic transition of an invalid remote partition to a valid one,
>> however, is not covered by this patch. They still need an explicit
>> write to "cpuset.cpus.partition" to become valid again.
>
> I'm not sure I understand what is meant by 'remote partition',
> is it possible to explain ? Or is the following illustrating what you
> mean ?
Remote partition is a newly added feature where the parent of a 
partition root needs not be a partition root at all. In this case, we 
will have to use the new cpuset.cpus.exclusive control file to pass down 
the hierarchy exclusive CPUs that can be used to form a partition. It is 
a feature request from Red Hat's OpenShift team to create containers 
with isolated CPUs which is at least 2 layers down from the root.
>
>>
>> The test_cpuset_prs.sh test script is updated to add new test cases to
>> test this automatic state transition.
>>
>> Reported-by: Pierre Gondois <pierre.gondois@arm.com>
>> Link: 
>> https://lore.kernel.org/lkml/9777f0d2-2fdf-41cb-bd01-19c52939ef42@arm.com
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c                        | 79 +++++++++++--------
>>   .../selftests/cgroup/test_cpuset_prs.sh       | 17 ++--
>>   2 files changed, 59 insertions(+), 37 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 15f399153a2e..93facdab513c 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1806,17 +1806,28 @@ static int 
>> update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>            *
>>            * Compute add/delete mask to/from effective_cpus
>>            *
>> -         * addmask = effective_xcpus & ~newmask & 
>> parent->effective_xcpus
>> -         * delmask = newmask & ~cs->effective_xcpus
>> -         *             & parent->effective_xcpus
>> +         * For valid partition:
>> +         *   addmask = exclusive_cpus & ~newmask
>> +         *                  & parent->effective_xcpus
>> +         *   delmask = newmask & ~exclusive_cpus
>> +         *               & parent->effective_xcpus
>> +         *
>> +         * For invalid partition:
>> +         *   delmask = newmask & parent->effective_xcpus
>>            */
>> -        cpumask_andnot(tmp->addmask, xcpus, newmask);
>> -        adding = cpumask_and(tmp->addmask, tmp->addmask,
>> -                     parent->effective_xcpus);
>> +        if (is_prs_invalid(old_prs)) {
>> +            adding = false;
>> +            deleting = cpumask_and(tmp->delmask,
>> +                    newmask, parent->effective_xcpus);
>> +        } else {
>> +            cpumask_andnot(tmp->addmask, xcpus, newmask);
>> +            adding = cpumask_and(tmp->addmask, tmp->addmask,
>> +                         parent->effective_xcpus);
>>   -        cpumask_andnot(tmp->delmask, newmask, xcpus);
>> -        deleting = cpumask_and(tmp->delmask, tmp->delmask,
>> -                       parent->effective_xcpus);
>> +            cpumask_andnot(tmp->delmask, newmask, xcpus);
>> +            deleting = cpumask_and(tmp->delmask, tmp->delmask,
>> +                           parent->effective_xcpus);
>> +        }
>>           /*
>>            * Make partition invalid if parent's effective_cpus could
>>            * become empty and there are tasks in the parent.
>> @@ -1910,9 +1921,11 @@ static int 
>> update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>         /*
>>        * Transitioning between invalid to valid or vice versa may 
>> require
>> -     * changing CS_CPU_EXCLUSIVE.
>> +     * changing CS_CPU_EXCLUSIVE. In the case of partcmd_update,
>> +     * validate_change() has already been successfully called and
>> +     * CPU lists in cs haven't been updated yet. So defer it to later.
>>        */
>> -    if (old_prs != new_prs) {
>> +    if ((old_prs != new_prs) && (cmd != partcmd_update))  {
>>           int err = update_partition_exclusive(cs, new_prs);
>>             if (err)
>> @@ -1960,6 +1973,9 @@ static int 
>> update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>         spin_unlock_irq(&callback_lock);
>>   +    if ((old_prs != new_prs) && (cmd == partcmd_update))
>> +        update_partition_exclusive(cs, new_prs);
>> +
>>       if (adding || deleting) {
>>           update_tasks_cpumask(parent, tmp->addmask);
>>           update_sibling_cpumasks(parent, cs, tmp);
>> @@ -2356,8 +2372,9 @@ static int update_cpumask(struct cpuset *cs, 
>> struct cpuset *trialcs,
>>       if (alloc_cpumasks(NULL, &tmp))
>>           return -ENOMEM;
>>   -    if (is_partition_valid(cs)) {
>> -        if (cpumask_empty(trialcs->effective_xcpus)) {
>> +    if (old_prs) {
>> +        if (is_partition_valid(cs) &&
>> +            cpumask_empty(trialcs->effective_xcpus)) {
>>               invalidate = true;
>>               cs->prs_err = PERR_INVCPUS;
>>           } else if (prstate_housekeeping_conflict(old_prs, 
>> trialcs->effective_xcpus)) {
>> @@ -2391,13 +2408,16 @@ static int update_cpumask(struct cpuset *cs, 
>> struct cpuset *trialcs,
>>            */
>>           invalidate = true;
>>           rcu_read_lock();
>> -        cpuset_for_each_child(cp, css, parent)
>> +        cpuset_for_each_child(cp, css, parent) {
>> +            struct cpumask *xcpus = fetch_xcpus(trialcs);
>> +
>>               if (is_partition_valid(cp) &&
>> -                cpumask_intersects(trialcs->effective_xcpus, 
>> cp->effective_xcpus)) {
>> +                cpumask_intersects(xcpus, cp->effective_xcpus)) {
>>                   rcu_read_unlock();
>>                   update_parent_effective_cpumask(cp, 
>> partcmd_invalidate, NULL, &tmp);
>>                   rcu_read_lock();
>>               }
>> +        }
>>           rcu_read_unlock();
>>           retval = 0;
>>       }
>> @@ -2405,18 +2425,24 @@ static int update_cpumask(struct cpuset *cs, 
>> struct cpuset *trialcs,
>>       if (retval < 0)
>>           goto out_free;
>>   -    if (is_partition_valid(cs)) {
>> +    if (is_partition_valid(cs) ||
>> +       (is_partition_invalid(cs) && !invalidate)) {
>> +        struct cpumask *xcpus = trialcs->effective_xcpus;
>> +
>> +        if (cpumask_empty(xcpus) && is_partition_invalid(cs))
>> +            xcpus = trialcs->cpus_allowed;
>> +
>>           /*
>>            * Call remote_cpus_update() to handle valid remote partition
>>            */
>>           if (is_remote_partition(cs))
>> -            remote_cpus_update(cs, trialcs->effective_xcpus, &tmp);
>> +            remote_cpus_update(cs, xcpus, &tmp);
>>           else if (invalidate)
>>               update_parent_effective_cpumask(cs, partcmd_invalidate,
>>                               NULL, &tmp);
>>           else
>>               update_parent_effective_cpumask(cs, partcmd_update,
>> -                        trialcs->effective_xcpus, &tmp);
>> +                            xcpus, &tmp);
>>       } else if (!cpumask_empty(cs->exclusive_cpus)) {
>>           /*
>>            * Use trialcs->effective_cpus as a temp cpumask
>> @@ -2493,7 +2519,7 @@ static int update_exclusive_cpumask(struct 
>> cpuset *cs, struct cpuset *trialcs,
>>       if (retval)
>>           return retval;
>>   -    if (is_partition_valid(cs)) {
>> +    if (old_prs) {
>>           if (cpumask_empty(trialcs->effective_xcpus)) {
>>               invalidate = true;
>>               cs->prs_err = PERR_INVCPUS;
>> @@ -2927,19 +2953,10 @@ static int update_prstate(struct cpuset *cs, 
>> int new_prs)
>>           return 0;
>>         /*
>> -     * For a previously invalid partition root with valid partition 
>> root
>> -     * parent, treat it as if it is a "member". Otherwise, reject it as
>> -     * remote partition cannot currently self-recover from an invalid
>> -     * state.
>> +     * Treat a previously invalid partition root as if it is a 
>> "member".
>>        */
>> -    if (new_prs && is_prs_invalid(old_prs)) {
>> -        if (is_partition_valid(parent)) {
>> -            old_prs = PRS_MEMBER;
>> -        } else {
>> -            cs->partition_root_state = -new_prs;
>> -            return 0;
>> -        }
>> -    }
>> +    if (new_prs && is_prs_invalid(old_prs))
>> +        old_prs = PRS_MEMBER;
>>         if (alloc_cpumasks(NULL, &tmpmask))
>>           return -ENOMEM;
>> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh 
>> b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
>> index 0f4f4a57ae12..243c4c926964 100755
>> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
>> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
>> @@ -318,16 +318,18 @@ TEST_MATRIX=(
>
> NIT (and not related to this patch):
> I think the usage of X... is not documented in the test matrix, cf.
>
> #  P<v> = set cpus.partition (0:member, 1:root, 2:isolated)
> #  C<l> = add cpu-list
> [...]
>
Thanks for catching that. Will add the description in the new version.

-Longman

