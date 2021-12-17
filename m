Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751BB479188
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 17:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbhLQQeg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 11:34:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239150AbhLQQef (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 11:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639758875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iHsgYvtM2VbxZhXYtiIDslv8uvAy3OgBfsyPMPqyKfY=;
        b=HHGDPMO8Ws2pvIFJBbV0rJxZec5XFD2w3PyG/tTncoxRMuL4g27/lzynPwhcJN/CjBj4aZ
        yIxhu/6eE6cRlL0U/pkAk/HPC12TkMvhyfQFiPXKGbOx+pX1HQP+b45hbIM7JaAKClxA56
        KlvrRv0qxdT6ZY2Q6l2T7+f1ohoZJBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-JQdpYZzfMw-6gjsTIJXbyQ-1; Fri, 17 Dec 2021 11:34:31 -0500
X-MC-Unique: JQdpYZzfMw-6gjsTIJXbyQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74C6910168C6;
        Fri, 17 Dec 2021 16:34:29 +0000 (UTC)
Received: from [10.22.10.138] (unknown [10.22.10.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F4BD4E2A2;
        Fri, 17 Dec 2021 16:34:10 +0000 (UTC)
Message-ID: <a7c9aaa1-b813-fccc-6623-0c6409642b6b@redhat.com>
Date:   Fri, 17 Dec 2021 11:34:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] cgroup/cpuset: Make child cpusets restrict parents on v1
 hierarchy
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>, tj@kernel.org
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org, corbet@lwn.net,
        frederic@kernel.org, guro@fb.com, hannes@cmpxchg.org,
        juri.lelli@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lizefan.x@bytedance.com, mtosatti@redhat.com, pauld@redhat.com,
        peterz@infradead.org, shuah@kernel.org
References: <8d73dc26-74e1-d763-d897-6e03cdac3c8c@redhat.com>
 <20211217154854.41409-1-mkoutny@suse.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211217154854.41409-1-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/17/21 10:48, Michal Koutný wrote:
> The commit 1f1562fcd04a ("cgroup/cpuset: Don't let child cpusets
> restrict parent in default hierarchy") inteded to relax the check only
> on the default hierarchy (or v2 mode) but it dropped the check in v1
> too.
>
> This patch returns and separates the legacy-only validations so that
> they can be considered only in the v1 mode, which should enforce the old
> constraints for the sake of compatibility.
>
> Fixes: 1f1562fcd04a ("cgroup/cpuset: Don't let child cpusets restrict parent in default hierarchy")
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset.c | 52 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 40 insertions(+), 12 deletions(-)
>
> This is formatted as a separate patch fixing the already queued change in
> for-5.17 but it can be eventually squashed into the referenced commit AFAIAC.
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 0dd7d853ed17..ce6929ddc0b0 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -590,6 +590,35 @@ static inline void free_cpuset(struct cpuset *cs)
>   	kfree(cs);
>   }
>   
> +/*
> + * validate_change_legacy() - Validate conditions specific to legacy (v1)
> + *                            behavior.
> + */
> +static int validate_change_legacy(struct cpuset *cur, struct cpuset *trial)
> +{
> +	struct cgroup_subsys_state *css;
> +	struct cpuset *c, *par;
> +	int ret;
> +
> +	WARN_ON_ONCE(!rcu_read_lock_held());
> +
> +	/* Each of our child cpusets must be a subset of us */
> +	ret = -EBUSY;
> +	cpuset_for_each_child(c, css, cur)
> +		if (!is_cpuset_subset(c, trial))
> +			goto out;
> +
> +	/* On legacy hierarchy, we must be a subset of our parent cpuset. */
> +	ret = -EACCES;
> +	par = parent_cs(cur);
> +	if (par && !is_cpuset_subset(trial, par))
> +		goto out;
> +
> +	ret = 0;
> +out:
> +	return ret;
> +}
> +
>   /*
>    * validate_change() - Used to validate that any proposed cpuset change
>    *		       follows the structural rules for cpusets.
> @@ -614,20 +643,21 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>   {
>   	struct cgroup_subsys_state *css;
>   	struct cpuset *c, *par;
> -	int ret;
> -
> -	/* The checks don't apply to root cpuset */
> -	if (cur == &top_cpuset)
> -		return 0;
> +	int ret = 0;
>   
>   	rcu_read_lock();
> -	par = parent_cs(cur);
>   
> -	/* On legacy hierarchy, we must be a subset of our parent cpuset. */
> -	ret = -EACCES;
> -	if (!is_in_v2_mode() && !is_cpuset_subset(trial, par))
> +	if (!is_in_v2_mode())
> +		ret = validate_change_legacy(cur, trial);
> +	if (ret)
> +		goto out;
> +
> +	/* Remaining checks don't apply to root cpuset */
> +	if (cur == &top_cpuset)
>   		goto out;
>   
> +	par = parent_cs(cur);
> +
>   	/*
>   	 * If either I or some sibling (!= me) is exclusive, we can't
>   	 * overlap
> @@ -1175,9 +1205,7 @@ enum subparts_cmd {
>    *
>    * Because of the implicit cpu exclusive nature of a partition root,
>    * cpumask changes that violates the cpu exclusivity rule will not be
> - * permitted when checked by validate_change(). The validate_change()
> - * function will also prevent any changes to the cpu list if it is not
> - * a superset of children's cpu lists.
> + * permitted when checked by validate_change().
>    */
>   static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
>   					  struct cpumask *newmask,

Thanks for addressing this issue.

Reviewed-by: Waiman Long <longman@redhat.com>

