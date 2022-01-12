Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C312C48C767
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jan 2022 16:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354706AbiALPkj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jan 2022 10:40:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354750AbiALPki (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jan 2022 10:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642002038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJmHbv9SCbjdwt82aanZM10+dOvSdHukj6nnuz8zRSw=;
        b=LqYiApDT8+43yLKtRzfAhpnQNXV5rZXemz8jYlRG3Zx2wb4kJWTl2o2UKK1n7OnIL8bSHf
        yhUpXjOOQjZgG+64JipHjn9h9Cov/5eNdb4ZoIVdzX8b4GTj+soACLxyM0b9Nx0d8hK4uF
        9G+2qX48gYwvT6s3SoEF33UviWt0ikg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-2_ciwF2DNHmPaaptMl4MsQ-1; Wed, 12 Jan 2022 10:40:34 -0500
X-MC-Unique: 2_ciwF2DNHmPaaptMl4MsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA38710168C0;
        Wed, 12 Jan 2022 15:40:31 +0000 (UTC)
Received: from [10.22.10.195] (unknown [10.22.10.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3420E87942;
        Wed, 12 Jan 2022 15:40:02 +0000 (UTC)
Message-ID: <0cf37ac0-69c7-2da4-22a6-58e78dc35cef@redhat.com>
Date:   Wed, 12 Jan 2022 10:40:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 4/7] cgroup/cpuset: Add a new isolated cpus.partition
 type
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20211205183220.818872-1-longman@redhat.com>
 <20211205183220.818872-5-longman@redhat.com>
 <Yd7x3P+wGCVfYtza@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yd7x3P+wGCVfYtza@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 1/12/22 10:21, Peter Zijlstra wrote:
> On Sun, Dec 05, 2021 at 01:32:17PM -0500, Waiman Long wrote:
>> Cpuset v1 uses the sched_load_balance control file to determine if load
>> balancing should be enabled.  Cpuset v2 gets rid of sched_load_balance
>> as its use may require disabling load balancing at cgroup root.
>>
>> For workloads that require very low latency like DPDK, the latency
>> jitters caused by periodic load balancing may exceed the desired
>> latency limit.
>>
>> When cpuset v2 is in use, the only way to avoid this latency cost is to
>> use the "isolcpus=" kernel boot option to isolate a set of CPUs. After
>> the kernel boot, however, there is no way to add or remove CPUs from
>> this isolated set. For workloads that are more dynamic in nature, that
>> means users have to provision enough CPUs for the worst case situation
>> resulting in excess idle CPUs.
>>
>> To address this issue for cpuset v2, a new cpuset.cpus.partition type
>> "isolated" is added which allows the creation of a cpuset partition
>> without load balancing. This will allow system administrators to
>> dynamically adjust the size of isolated partition to the current need
>> of the workload without rebooting the system.
> you can, ofcourse, create lots of 1 cpu partitions, which is effectively
> what you're doing, except there was a problem with that which you also
> forgot to mention.

Yes, that is a possible workaround. However, it makes cgroup management 
much harder especially in the cgroup v2 environment where multiple 
controllers are likely to be enabled in the same cgroup.

Cheers,
Longman

