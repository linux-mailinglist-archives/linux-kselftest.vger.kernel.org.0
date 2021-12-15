Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE0D476007
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 18:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbhLOR7p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 12:59:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233039AbhLOR7p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 12:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639591184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7T9baihxbZOtsdtJTZ7JWcmVJu0+eN6bqcVUWyieaoA=;
        b=dOTUmmac0K6To55+DjDP8R+fSkNFCxkVZOGg2BqGNWmeSTGeFYYBLS+6HjcCWjGF6UZhl7
        VgLN8niVzH/QHwqrPzT6LTt2X1QXa/HnZFsvT1ck/PFSYugwpSL/wPvWzRt8+nKeEGGJXx
        OyC/z+wbzV0sldcRSEodQMRX8hB0ugg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-eoxD2mjwOxWsfYcVfNC3hA-1; Wed, 15 Dec 2021 12:59:41 -0500
X-MC-Unique: eoxD2mjwOxWsfYcVfNC3hA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45CEA2F4B;
        Wed, 15 Dec 2021 17:59:39 +0000 (UTC)
Received: from [10.22.10.54] (unknown [10.22.10.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53BC578C26;
        Wed, 15 Dec 2021 17:59:20 +0000 (UTC)
Message-ID: <8d73dc26-74e1-d763-d897-6e03cdac3c8c@redhat.com>
Date:   Wed, 15 Dec 2021 12:59:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 1/7] cgroup/cpuset: Don't let child cpusets restrict
 parent in default hierarchy
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
References: <20211205183220.818872-1-longman@redhat.com>
 <20211205183220.818872-2-longman@redhat.com>
 <Ybev80+h4JArgMDz@slm.duckdns.org> <20211215122336.GB25459@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211215122336.GB25459@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 12/15/21 07:23, Michal Koutný wrote:
> On Mon, Dec 13, 2021 at 10:41:23AM -1000, Tejun Heo <tj@kernel.org> wrote:
>>> To address this issue, the check is now removed for the default hierarchy
>>> to free parent cpusets from being restricted by child cpusets. The
>>> check will still apply for legacy hierarchy.
> I'm trying to find whether something in update_cpumasks_hier() ensures
> the constraint is checkd on the legacy hierarchy but it seems to me this
> baby was thrown out with the bathwater. How is the legacy check still
> applied?
Yes, you are right. I did remove the check for legacy hierarchy too.
>> Applied to cgroup/for-5.17.
> It comes out a bit more complex if I want to achieve both variants in
> the below followup:
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 0dd7d853ed17..8b6e06f504f6 100644
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

I think you still need to guard it with "!is_in_v2_mode()".

         if (!is_in_v2_mode()) {
                 ret = validate_change_legacy(cur, trial);
                 if (ret)
                         goto out;
         }

> +	ret = validate_change_legacy(cur, trial);
> +	if (ret)
> +		goto out;
> +
> +	/* Remaining checks don't apply to root cpuset */
> +	ret = 0;
> +	if (cur == &top_cpuset)
>   		goto out;
>   
> +	par = parent_cs(cur);
> +
>   	/*
>   	 * If either I or some sibling (!= me) is exclusive, we can't
>   	 * overlap
Cheers,
Longman

