Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A84474256F
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 14:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjF2MMe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 08:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjF2MMa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 08:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430CEBC
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 05:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688040698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUMXrX97pfVEXgUti557n3bGMAKPy8ETXJCsvtuqbtI=;
        b=SBp6twnSHIe2Q7ZX0f0i458vecsA7Mvcsur3mU/FFzBaSvfDX4YBmBcrV7uqThK5R311IT
        +d2DwIk/EpC/BnknOuyoZtO3RYstllSmKL/BHor6pXk8v7Qb5F6/XcEZoGLv69SafgIN/M
        vB4296Z4zL1JSULIfl5/lw+I0Zs4zzY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-52FwC_WsONapQf4jsyqsrw-1; Thu, 29 Jun 2023 08:11:35 -0400
X-MC-Unique: 52FwC_WsONapQf4jsyqsrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71F2D3C00120;
        Thu, 29 Jun 2023 12:11:34 +0000 (UTC)
Received: from [10.22.16.224] (unknown [10.22.16.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6726C00049;
        Thu, 29 Jun 2023 12:11:33 +0000 (UTC)
Message-ID: <15c607d9-c1fa-ca11-d675-8f2b3a6fd15b@redhat.com>
Date:   Thu, 29 Jun 2023 08:11:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] cpuset: Allow setscheduler regardless of manipulated
 task
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
References: <20230629091146.28801-1-mkoutny@suse.com>
 <20230629091146.28801-2-mkoutny@suse.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230629091146.28801-2-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 6/29/23 05:11, Michal Koutný wrote:
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

The is_in_v2_mode() check is for supporting the v2 mode in cgroup v1. 
However, there is no controller enabling in v1. So I think you should 
just use cgroup_subsys_on_dfl(cpuset_cgrp_subsys) as the v2 check if 
your focus is just to prevent problem when enabling cpuset controller.


>
> [1] https://github.com/systemd/systemd/issues/18293#issuecomment-831205649
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e4ca2dd2b764..3b5f87a9a150 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2495,6 +2495,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   		ret = task_can_attach(task, cs->effective_cpus);
>   		if (ret)
>   			goto out_unlock;
> +
> +		/*
> +		 * Skip rights over task check in v2, migration permission derives
> +		 * from hierarchy ownership in cgroup_procs_write_permission()).
> +		 */
> +		if (is_in_v2_mode())
> +			continue;
>   		ret = security_task_setscheduler(task);
>   		if (ret)
>   			goto out_unlock;

This change will likely conflict with the latest cpuset change on 
tracking # of dl tasks in a cpuset. You will have to, at least, move the 
dl task check before the security_task_setscheduler() check.

Another fact about cpuset controller enabling is that both cpus_allowed 
and mems_allowed are empty at that point. You may also add these checks 
as a preconditions for disabling the security_task_setscheduler check.

Cheers,
Longman

