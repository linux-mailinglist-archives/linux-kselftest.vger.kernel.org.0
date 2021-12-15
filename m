Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D57475156
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 04:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239558AbhLODYp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 22:24:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230073AbhLODYo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 22:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639538683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHvqWA9pCAW9hO772UCEPBtSbiKtXLn9xS2Zet02foU=;
        b=DkHg/lnu1qsKehXEmj6iuMLAgg58wwCh7Rr86ffIL8o5bwIO3OZ86eJaNy8lbaeYO/knRE
        26/WSYjPImX7bR9oei4w+d9VPyKKweQbGvbk+afCBC9LH6B+HxEWmvLucOT2yKAtmfik/E
        wsVfy9l+3MuCem99UWS+9SIdRNptBbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-9OCunupRPaCWWCdihpXOZA-1; Tue, 14 Dec 2021 22:24:38 -0500
X-MC-Unique: 9OCunupRPaCWWCdihpXOZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E277581CCB7;
        Wed, 15 Dec 2021 03:24:35 +0000 (UTC)
Received: from [10.22.16.35] (unknown [10.22.16.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B73C18276C;
        Wed, 15 Dec 2021 03:24:22 +0000 (UTC)
Message-ID: <810204ce-7967-e470-1267-7c3cfb521c89@redhat.com>
Date:   Tue, 14 Dec 2021 22:24:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 2/7] cgroup/cpuset: Allow no-task partition to have
 empty cpuset.cpus.effective
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
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
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20211205183220.818872-1-longman@redhat.com>
 <20211205183220.818872-3-longman@redhat.com>
 <Ybew7d2oE2gLcLNO@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Ybew7d2oE2gLcLNO@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/13/21 15:45, Tejun Heo wrote:
> On Sun, Dec 05, 2021 at 01:32:15PM -0500, Waiman Long wrote:
>>   	adding = deleting = false;
>>   	old_prs = new_prs = cpuset->partition_root_state;
>>   	if (cmd == partcmd_enable) {
>> +		/*
>> +		 * Enabling partition root is not allowed if not all the CPUs
>> +		 * can be granted from parent's effective_cpus.
>> +		 */
>> +		if (!cpumask_subset(cpuset->cpus_allowed, parent->effective_cpus))
>> +			return -EINVAL;
>> +
>> +		/*
>> +		 * A parent can be left with no CPU as long as there is no
>> +		 * task directly associated with the parent partition. For
>> +		 * such a parent, no new task can be moved into it.
>> +		 */
>> +		if (partition_is_populated(parent, cpuset) &&
>> +		    cpumask_equal(cpuset->cpus_allowed, parent->effective_cpus))
>> +			return -EINVAL;
> So, given that this only happens with threaded domains, can we just not
> allow partitions within threaded domains? The combination doesn't make whole
> lot of sense to me anyway.
AFAICS, there are code in cpuset.c that disallows the an non-child node 
to hold tasks, but the check doesn't cover all the possible cases. I 
remembered that I was able to create such a scenario without using 
threaded domains. That is why I put in this conditional check. It has 
nothing to do with the use of threaded domains.
>> +	/*
>> +	 * On default hierarchy, task cannot be moved to a cpuset with empty
>> +	 * effective cpus.
>> +	 */
>> +	if (is_in_v2_mode() && cpumask_empty(cs->effective_cpus))
>> +		goto out_unlock;
> And then we can avoid this extra restriction too, right?

This check is supposed to prevent a task to be moved to a leaf cpuset 
partition with just offlined cpus and hence no effective cpu. A possible 
alternative is to force the partition to become invalid, but I think not 
allowing the move is easier until one or more offlined cpus are onlined.

Cheers,
Longman

