Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308097461B8
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 20:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjGCSBC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 14:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjGCSBB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 14:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31F4E5F
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Jul 2023 11:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688407218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjXD9hgua/WyFNkzAf/5dqsBFSxFdg110zmVMs5EXro=;
        b=CXKK+GrR9O1JOVx9Jx1GJpEg6ir62KukUC3WqCgz1XQdfrM681apKKaYMcoPCVzfC2ibQC
        DFz14kxOZQ/NPST8GZ3C4p7p7N/Wue/kMTVHk9i/qZH7Vf8GTruVjjwOqlGs8lNGALX75p
        6H2x4yfijkYRx9j5C7iF0w/52fL/bxg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-6aNQgaaQNrOw4rSs3Du5HQ-1; Mon, 03 Jul 2023 14:00:14 -0400
X-MC-Unique: 6aNQgaaQNrOw4rSs3Du5HQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23377858EED;
        Mon,  3 Jul 2023 18:00:14 +0000 (UTC)
Received: from [10.22.17.92] (unknown [10.22.17.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A78615230AE;
        Mon,  3 Jul 2023 18:00:13 +0000 (UTC)
Message-ID: <f54ae464-6684-5640-4b1e-90af0cb769cd@redhat.com>
Date:   Mon, 3 Jul 2023 14:00:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/3] cpuset: Allow setscheduler regardless of
 manipulated task
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
References: <20230703172741.25392-1-mkoutny@suse.com>
 <20230703172741.25392-2-mkoutny@suse.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230703172741.25392-2-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/3/23 13:27, Michal Koutný wrote:
> When we migrate a task between two cgroups, one of the checks is a
> verification whether we can modify task's scheduler settings
> (cap_task_setscheduler()).
>
> An implicit migration occurs also when enabling a controller on the
> unified hierarchy (think of parent to child migration). The
> aforementioned check may be problematic if the caller of the migration
> (enabling a controller) has no permissions over migrated tasks.
> For instance, a user's cgroup that ends up running a process of a
> different user. Although cgroup permissions are configured favorably,
> the enablement fails due to the foreign process [1].
>
> Change the behavior by relaxing the permissions check on the unified
> hierarchy when no effective change would happen.
> This is in accordance with unified hierarchy attachment behavior when
> permissions of the source to target cgroups are decisive whereas the
> migrated task is opaque (as opposed to more restrictive check in
> __cgroup1_procs_write()).
>
> Notice that foreign task's affinity may still be modified if the user
> can modify destination cgroup's cpuset attributes
> (update_tasks_cpumask() does no permissions check). The permissions
> check could thus be skipped on v2 even when affinity changes. Stay
> conservative in this patch though.
>
> [1] https://github.com/systemd/systemd/issues/18293#issuecomment-831205649
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 58e6f18f01c1..0a9b860844ca 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2487,6 +2487,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	struct cgroup_subsys_state *css;
>   	struct cpuset *cs, *oldcs;
>   	struct task_struct *task;
> +	bool cpus_updated, mems_updated;
>   	int ret;
>   
>   	/* used later by cpuset_attach() */
> @@ -2501,13 +2502,25 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	if (ret)
>   		goto out_unlock;
>   
> +	cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
> +	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
> +
>   	cgroup_taskset_for_each(task, css, tset) {
>   		ret = task_can_attach(task);
>   		if (ret)
>   			goto out_unlock;
> -		ret = security_task_setscheduler(task);
> -		if (ret)
> -			goto out_unlock;
> +
> +		/*
> +		 * Skip rights over task check in v2 when nothing changes,
> +		 * migration permission derives from hierarchy ownership in
> +		 * cgroup_procs_write_permission()).
> +		 */
> +		if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
> +		    (cpus_updated || mems_updated)) {
> +			ret = security_task_setscheduler(task);
> +			if (ret)
> +				goto out_unlock;
> +		}
>   
>   		if (dl_task(task)) {
>   			cs->nr_migrate_dl_tasks++;
Reviewed-by: Waiman Long <longman@redhat.com>

Thanks,
Longman

