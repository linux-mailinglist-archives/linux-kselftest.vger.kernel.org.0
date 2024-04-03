Return-Path: <linux-kselftest+bounces-7093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D7489714B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 15:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247181C20D7E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730CB148303;
	Wed,  3 Apr 2024 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCmb1PiA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB9C143863
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151496; cv=none; b=ADDyZKSWE654dKGfr1mCLt79WFdTTX8/1IeBaGpyY0wko715uJx4d9LPBOtNoQsk3ZYKPzq0D2lr2FgLgF0iCOjy0ZkcgPZRYqp6E317KcN9EcAKfuIAiYgjWLW4vxMua5l5sDZ9/jU9wOKz/tASxoqDAYhKY4HQfalZF19f0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151496; c=relaxed/simple;
	bh=fc44alx6ixMvABvuzSw1H/vxeKtpLRA87cm9053YDi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3mc1V9JWZRWqaqGbbacepmrPLvO766yiiKIP+ecUE8boGUtK+Ru411x58a2oGNgLOU+Ajc8no0nO8VofQmir43B4wQehoypcGQEl8o384xUppgHW+vsQAmxz9N6VpznEPPjbe+eolf74RAEH6Vw6wotF3KoOJyD6V7v6GVVLJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZCmb1PiA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712151493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHyJRjgVmTGCMo07LoD/tMuHI6RHWzQ+RhCuYOZGrSo=;
	b=ZCmb1PiA08aBnpXP2Yefgk3jXdUjM2LSmQNMKu9HBVZYMhLx3289lpG31/zrlScY1sd68W
	4jwM7hCstljNr+1zuEQEJdyR/qhp5EOU5tPVV+C5vRxpA4TNdCgS9PHOeGPKqfp9mkfeNR
	CY1aT15KbKetCDAmH3o4UloHnuRVy7c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-kH5gHBtEONuE9qsgCBskLQ-1; Wed, 03 Apr 2024 09:38:10 -0400
X-MC-Unique: kH5gHBtEONuE9qsgCBskLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB0EB8828C0;
	Wed,  3 Apr 2024 13:38:08 +0000 (UTC)
Received: from [10.22.33.218] (unknown [10.22.33.218])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4D9E21074E;
	Wed,  3 Apr 2024 13:38:07 +0000 (UTC)
Message-ID: <7e62b37d-6c9c-4e55-a01a-175695475cb5@redhat.com>
Date: Wed, 3 Apr 2024 09:38:07 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup/cpuset: Make cpuset hotplug processing
 synchronous
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Alex Shi <alexs@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Barry Song <song.bao.hua@hisilicon.com>
References: <20240401145858.2656598-1-longman@redhat.com>
 <20240401145858.2656598-2-longman@redhat.com>
 <kce74bx6aafxfuw5yovaschym4ze4kommfk74eq5totojytest@mdxnfvl2kdol>
 <548efd52-e45f-41fa-a477-bc5112d7b00c@redhat.com>
 <u3naomgv34t5rnc7pmyy4zjppgf36skeo45orss2xnqcvtrcez@m74tsl2ws76f>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <u3naomgv34t5rnc7pmyy4zjppgf36skeo45orss2xnqcvtrcez@m74tsl2ws76f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 4/3/24 08:02, Michal Koutný wrote:
> On Tue, Apr 02, 2024 at 11:30:11AM -0400, Waiman Long <longman@redhat.com> wrote:
>> Yes, there is a potential that a cpus_read_lock() may be called leading to
>> deadlock. So unless we reverse the current cgroup_mutex --> cpu_hotplug_lock
>> ordering, it is not safe to call cgroup_transfer_tasks() directly.
> I see that cgroup_transfer_tasks() has the only user -- cpuset. What
> about bending it for the specific use like:
>
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 34aaf0e87def..64deb7212c5c 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -109,7 +109,7 @@ struct cgroup *cgroup_get_from_fd(int fd);
>   struct cgroup *cgroup_v1v2_get_from_fd(int fd);
>   
>   int cgroup_attach_task_all(struct task_struct *from, struct task_struct *);
> -int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from);
> +int cgroup_transfer_tasks_locked(struct cgroup *to, struct cgroup *from);
>   
>   int cgroup_add_dfl_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
>   int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index 520a11cb12f4..f97025858c7a 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -91,7 +91,8 @@ EXPORT_SYMBOL_GPL(cgroup_attach_task_all);
>    *
>    * Return: %0 on success or a negative errno code on failure
>    */
> -int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
> +int cgroup_transfer_tasks_locked(struct cgroup *to, struct cgroup *from)
>   {
>   	DEFINE_CGROUP_MGCTX(mgctx);
>   	struct cgrp_cset_link *link;
> @@ -106,9 +106,11 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
>   	if (ret)
>   		return ret;
>   
> -	cgroup_lock();
> -
> -	cgroup_attach_lock(true);
> +	/* The locking rules serve specific purpose of v1 cpuset hotplug
> +	 * migration, see hotplug_update_tasks_legacy() and
> +	 * cgroup_attach_lock() */
> +	lockdep_assert_held(&cgroup_mutex);
> +	lockdep_assert_cpus_held();
> +	percpu_down_write(&cgroup_threadgroup_rwsem);
>   
>   	/* all tasks in @from are being moved, all csets are source */
>   	spin_lock_irq(&css_set_lock);
> @@ -144,8 +146,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
>   	} while (task && !ret);
>   out_err:
>   	cgroup_migrate_finish(&mgctx);
> -	cgroup_attach_unlock(true);
> -	cgroup_unlock();
> +	percpu_up_write(&cgroup_threadgroup_rwsem);
>   	return ret;
>   }
>   
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 13d27b17c889..94fb8b26f038 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4331,7 +4331,7 @@ static void remove_tasks_in_empty_cpuset(struct cpuset *cs)
>   			nodes_empty(parent->mems_allowed))
>   		parent = parent_cs(parent);
>   
> -	if (cgroup_transfer_tasks(parent->css.cgroup, cs->css.cgroup)) {
> +	if (cgroup_transfer_tasks_locked(parent->css.cgroup, cs->css.cgroup)) {
>   		pr_err("cpuset: failed to transfer tasks out of empty cpuset ");
>   		pr_cont_cgroup_name(cs->css.cgroup);
>   		pr_cont("\n");
> @@ -4376,21 +4376,9 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
>   
>   	/*
>   	 * Move tasks to the nearest ancestor with execution resources,
> -	 * This is full cgroup operation which will also call back into
> -	 * cpuset. Execute it asynchronously using workqueue.
>   	 */
> -	if (is_empty && css_tryget_online(&cs->css)) {
> -		struct cpuset_remove_tasks_struct *s;
> -
> -		s = kzalloc(sizeof(*s), GFP_KERNEL);
> -		if (WARN_ON_ONCE(!s)) {
> -			css_put(&cs->css);
> -			return;
> -		}
> -
> -		s->cs = cs;
> -		INIT_WORK(&s->work, cpuset_migrate_tasks_workfn);
> -		schedule_work(&s->work);
> +	if (is_empty)
> +		remove_tasks_in_empty_cpuset(cs);
>   	}
>   }
>   

It still won't work because of the possibility of mutiple tasks 
involving in a circular locking dependency. The hotplug thread always 
acquire the cpu_hotplug_lock first before acquiring cpuset_mutex or 
cgroup_mtuex in this case (cpu_hotplug_lock --> cgroup_mutex). Other 
tasks calling into cgroup code will acquire the pair in the order 
cgroup_mutex --> cpu_hotplug_lock. This may lead to a deadlock if these 
2 locking sequences happen at the same time. Lockdep will certainly 
spill out a splat because of this. So unless we change all the relevant 
cgroup code to the new cpu_hotplug_lock --> cgroup_mutex locking order, 
the hotplug code can't call cgroup_transfer_tasks() directly.

Cheers,
Longman


