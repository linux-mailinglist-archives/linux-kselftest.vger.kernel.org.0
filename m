Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF20475D67
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 17:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244805AbhLOQ3v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 11:29:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244804AbhLOQ3u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 11:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639585790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yxhcniv4Juf9tUgebwGdqHHxd7keYoCASjyNhDtoduY=;
        b=gI8ESY4cyiR0X5xovd+kC+eahAE9gNGGgKypPnjGw/X97357HLoNhD9zIeEqcUDVKmD7o/
        DxjAbPE7sMkmdS4nuZvuMOkGAZ4fQ5u8bM9tCeF07r6hGn5MfLDNQSV30yJ8/23s0JFM2V
        55CBFUnAmP6GkLLH/PEJ0UXLqXT2pn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-uDIz6gbyNhGd3lqcz7KQxQ-1; Wed, 15 Dec 2021 11:29:46 -0500
X-MC-Unique: uDIz6gbyNhGd3lqcz7KQxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CAD4185302B;
        Wed, 15 Dec 2021 16:29:44 +0000 (UTC)
Received: from [10.22.10.54] (unknown [10.22.10.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2AE15BE0B;
        Wed, 15 Dec 2021 16:29:41 +0000 (UTC)
Message-ID: <98887e63-51de-f5ad-8fb8-56269aaf4bcf@redhat.com>
Date:   Wed, 15 Dec 2021 11:29:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 3/7] cgroup/cpuset: Refining features and constraints
 of a partition
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
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
 <20211205183220.818872-4-longman@redhat.com>
 <20211215144944.GE16798@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211215144944.GE16798@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 12/15/21 09:49, Michal Koutný wrote:
> On Sun, Dec 05, 2021 at 01:32:16PM -0500, Waiman Long <longman@redhat.com> wrote:
>> @@ -1455,34 +1450,16 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
>>   			switch (parent->partition_root_state) {
>> [...]
>> -
>>   			case PRS_ENABLED:
>> -				if (update_parent_subparts_cpumask(cp, partcmd_update, NULL, tmp))
>> -					update_tasks_cpumask(parent);
>> +				update_parent = true;
>> [...]
>> +		if (update_parent) {
>> +			if (update_parent_subparts_cpumask(cp, partcmd_update, NULL, tmp))
>> +				update_tasks_cpumask(parent);
>> +			/*
>> +			 * The cpuset partition_root_state may be changed
>> +			 * to PRS_ERROR. Capture it.
>> +			 */
>> +			new_prs = cp->partition_root_state;
>> +		}
> IIUC, this ensures that when a parent becomes partition root again, this
> would propagate downwards to invalidated children.
>
> However, the documentation says:
>
>> +       Changing a partition root (valid or invalid) to "member" is
>> +       always allowed.  If there are child partition roots underneath
>> +       it, they will become invalid and unrecoverable.  So care must
>> +       be taken to double check for this condition before disabling
>> +       a partition root.
> I.e. it suggests a child can be trapped in the unrecoverable state (i.e.
> not fixable by writing into cpuset.cpus.partition).
> But this does not happen, right?

There are additional checks for the member to partition transition which 
requires that the target cpuset shouldn't have child cpuset. That 
prevents the recovering of a invalid partition root under a member 
cpuset. We could certainly remove that restriction by adding additional 
code as well as additional tests to verify it works. I haven't done that 
simply to avoid adding more complexity to the current code.

Cheers,
Longman

