Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF297442AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 21:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjF3TUj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 15:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjF3TUg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 15:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C023E3C39
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Jun 2023 12:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688152785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQeupD5Hvtw3+gqmqjD4kEWekm8is74wkIjoamnYm2Y=;
        b=Maifri/iYq1aKIKgDjOciFee9K0VCkKq85yPzuDvQ6TrT1Xa9F/fpgIy/hEGxnTsU20sjx
        KeFvXVQ7vh39fWCeZUkL040Mu+OlvMNz45hVqk69xp/TJD869P8Q0YZNcelgeOIlm6iwaU
        5sRwsHuEs+QMRuwUIlpePPVYgkgovUo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-jbEUAcsePYaj9T_UJrn6kw-1; Fri, 30 Jun 2023 15:19:38 -0400
X-MC-Unique: jbEUAcsePYaj9T_UJrn6kw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 378A98030AC;
        Fri, 30 Jun 2023 19:19:38 +0000 (UTC)
Received: from [10.22.18.163] (unknown [10.22.18.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B38302166B2D;
        Fri, 30 Jun 2023 19:19:37 +0000 (UTC)
Message-ID: <34ca9855-b38e-74e8-8c82-e0dc3fc5b485@redhat.com>
Date:   Fri, 30 Jun 2023 15:19:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/3] cpuset: Allow setscheduler regardless of
 manipulated task
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
References: <20230630183908.32148-1-mkoutny@suse.com>
 <20230630183908.32148-2-mkoutny@suse.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230630183908.32148-2-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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


On 6/30/23 14:39, Michal Koutný wrote:
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
> hierarchy (or in v2 mode). This is in accordance with unified hierarchy
> attachment behavior when permissions of the source to target cgroups are
> decisive whereas the migrated task is opaque (as opposed to more
> restrictive check in __cgroup1_procs_write()).
>
> [1] https://github.com/systemd/systemd/issues/18293#issuecomment-831205649
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 58e6f18f01c1..41d3ed14b0f4 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2505,9 +2505,16 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   		ret = task_can_attach(task);
>   		if (ret)
>   			goto out_unlock;
> -		ret = security_task_setscheduler(task);
> -		if (ret)
> -			goto out_unlock;
> +
> +		/*
> +		 * Skip rights over task check in v2, migration permission derives
> +		 * from hierarchy ownership in cgroup_procs_write_permission()).
> +		 */
> +		if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys)) {
> +			ret = security_task_setscheduler(task);
> +			if (ret)
> +				goto out_unlock;
> +		}

I am somewhat hesitant to skip the security_task_setscheduler() check 
for all cgroup v2 task migrations. The check is controlled by SElinux 
which is a different subsystem. I believe the scheduler property here 
refer's to the task cpu affinity and node mask. If you look at 
cpuset_attach(), we have actually skipped the task iteration process to 
change them if cpu affinity and node mask aren't changed at all.

I don't want to introduce a possible security vulnerability because of 
this relaxation. I would suggest you skip it under the same condition of 
no change to cpu affinity and node mask for cgroup v2.

Thanks,
Longman

