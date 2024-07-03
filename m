Return-Path: <linux-kselftest+bounces-13127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1934692544A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 09:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A8AB212F1
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 07:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7D81353FF;
	Wed,  3 Jul 2024 06:59:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9A8C1F;
	Wed,  3 Jul 2024 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719989990; cv=none; b=C8Dd5Dl/XM6kYcRBWGkCErkT0E7T2Eibo/1vffZOzn6YEYL/3LzYJ3Vkbm8+id5MC1Z+j+JKReZ2nXgbfnTDpp34csdLIujMN79lLUrRJjxy+qwqOtos1OnzEuXSCtUFjm5RqvIWOnsR7Kjbdey82t8RROaKIyqIIpPNnoPJj6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719989990; c=relaxed/simple;
	bh=tjyRyXbufFPhr/lFjnNJDv2W/ycWAuiK315JZC9AUJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=epzInP0A5nbUsW6cM/YLpo/SIWgK9HmBHeWQGLEZm8EdVfC3GdSd/1BULn3eqlXObULANq2u2NwlQizamWfE8a2jxQKmNntCgEh3PCtwymish+3002JhZD1CqfhCoSRy9Tb28wjBN3V6xtfYKTxrh1uPnzgOV3RZbslRjnRC6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WDVs40pyCzZhDG;
	Wed,  3 Jul 2024 14:55:04 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 64494140156;
	Wed,  3 Jul 2024 14:59:37 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 14:59:37 +0800
Message-ID: <f124ce60-196e-2392-c4a9-11cdcacf9927@huawei.com>
Date: Wed, 3 Jul 2024 14:59:36 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 2/5] cgroup/pids: Make event counters hierarchical
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
	<cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<shuah@kernel.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20240521092130.7883-1-mkoutny@suse.com>
 <20240521092130.7883-3-mkoutny@suse.com>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20240521092130.7883-3-mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/5/21 17:21, Michal Koutný wrote:
> The pids.events file should honor the hierarchy, so make the events
> propagate from their origin up to the root on the unified hierarchy. The
> legacy behavior remains non-hierarchical.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> --
[...]
> diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
> index a557f5c8300b..c09b744d548c 100644
> --- a/kernel/cgroup/pids.c
> +++ b/kernel/cgroup/pids.c
> @@ -238,6 +238,34 @@ static void pids_cancel_attach(struct cgroup_taskset *tset)
>  	}
>  }
>  
> +static void pids_event(struct pids_cgroup *pids_forking,
> +		       struct pids_cgroup *pids_over_limit)
> +{
> +	struct pids_cgroup *p = pids_forking;
> +	bool limit = false;
> +
> +	for (; parent_pids(p); p = parent_pids(p)) {
> +		/* Only log the first time limit is hit. */
> +		if (atomic64_inc_return(&p->events[PIDCG_FORKFAIL]) == 1) {
> +			pr_info("cgroup: fork rejected by pids controller in ");
> +			pr_cont_cgroup_path(p->css.cgroup);
> +			pr_cont("\n");
> +		}
> +		cgroup_file_notify(&p->events_file);
> +
> +		if (!cgroup_subsys_on_dfl(pids_cgrp_subsys) ||
> +		    cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
> +			break;
> +
> +		if (p == pids_over_limit)
> +			limit = true;
> +		if (limit)
> +			atomic64_inc(&p->events[PIDCG_MAX]);
> +
> +		cgroup_file_notify(&p->events_file);

Hi Michal,

I have doubts about this code. To better illustrate the problem, I am
posting the final code here.

static void pids_event(struct pids_cgroup *pids_forking,
                       struct pids_cgroup *pids_over_limit)
{
...
        cgroup_file_notify(&p->events_local_file);
        if (!cgroup_subsys_on_dfl(pids_cgrp_subsys) ||
            cgrp_dfl_root.flags & CGRP_ROOT_PIDS_LOCAL_EVENTS)
                return;

        for (; parent_pids(p); p = parent_pids(p)) {
                if (p == pids_over_limit) {
                        limit = true;
                        atomic64_inc(&p->events_local[PIDCG_MAX]);
                        cgroup_file_notify(&p->events_local_file);
                }
                if (limit)
                        atomic64_inc(&p->events[PIDCG_MAX]);

                cgroup_file_notify(&p->events_file);
        }
}

Consider this scenario: there are 4 groups A, B, C,and D. The
relationships are as follows, the latter is the child of the former:

root->A->B->C->D

Then the user is polling on C.pids.events. When a process in D forks and
fails due to B.max restrictions(pids_forking is D, and pids_over_limit
is B), the user is awakened. However, when the user reads C.pids.events,
he will find that the content has not changed. because the 'limit' is
set to true started from B, and C.pids.events shows as below:

seq_printf(sf, "max %lld\n", (s64)atomic64_read(&events[PIDCG_MAX]));

Wouldn't this behavior confuse the user? Should the code to be changed
to this?

if (limit) {
      atomic64_inc(&p->events[PIDCG_MAX]);
      cgroup_file_notify(&p->events_file);
}

