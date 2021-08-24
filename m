Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C443F57A2
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 07:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhHXFg1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 01:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229885AbhHXFg1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 01:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629783343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hMA9he3KzhIpa9VL4u2RVLcuo/UfXEbjSwWCQUOA21E=;
        b=jHd+MPDFYvOFIYm2C3T8rThgu+yJ5knQ38+pJymkIZyTwVErnTnVZNZaHH36pZBtpGtArp
        fdtezMoY8cS21yfkbTaoA3dYzqkiJO96kv8BXGg6tKvbG8ZftIFImVKFPfz6prF8+iCjbn
        QJcGtoaLHiB+PqB2bZHpqOrK1Cty924=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-OK9vq344Mu-BzA1YvVr9Bw-1; Tue, 24 Aug 2021 01:35:39 -0400
X-MC-Unique: OK9vq344Mu-BzA1YvVr9Bw-1
Received: by mail-qv1-f69.google.com with SMTP id u8-20020a0cec880000b029035825559ec4so14015057qvo.22
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Aug 2021 22:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hMA9he3KzhIpa9VL4u2RVLcuo/UfXEbjSwWCQUOA21E=;
        b=cDqtKbK0kXHedZpXfuDWsihHUnNAw9w6QAA2+0zEcST16YFaqzyhuCQsxuYWOrfKwi
         ypzLS0MU+trtvcnjEnpq+KW71IAkddmOptid8ENmiNBwxLSMCKUEQsKyqWQXAE6E8AeW
         HWhxFWKZ/ALGE4Bf/P3CQU+L8UKQmmkU4tj59A6AQu+lkGrWVdk0WhA29altVR0HO6Jn
         yaIuVJyKCG0so1a2ZAA2qUSyz9M6tLLWR0a5eCNgXoYXTU9wiao2flx8EfKcKoYqgV+1
         j5ShqGnT+LLgfhhgx9/7EWAh9lScEneX7uJgc7s7FJfiu7f8p4z92C7TXm21VOFm+Oc/
         1NKw==
X-Gm-Message-State: AOAM530sWOdL+t9mlv5+pOeIZYCT8HVXgUO5iGpcQxg7/ozLl+lqO/7p
        f3lGU7NZ/jNJYkXQkx4KhvqjD+Xyaf0GuOH0riSp011kOiboAQdzfLnNFZYtEVLnnXfJ6e7k/UF
        83AX6KPSTsYwIFcDuhbhAyZ/Lqy6T
X-Received: by 2002:a05:6214:e4e:: with SMTP id o14mr36773988qvc.46.1629783339521;
        Mon, 23 Aug 2021 22:35:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ9TFAqJK2UKypiZesdV4PFhcJDxgpVfPI6c6pKAqWdkuSgCxObkN174DkWv55S9WMaRJNvQ==
X-Received: by 2002:a05:6214:e4e:: with SMTP id o14mr36773974qvc.46.1629783339316;
        Mon, 23 Aug 2021 22:35:39 -0700 (PDT)
Received: from llong.remote.csb ([50.238.61.194])
        by smtp.gmail.com with ESMTPSA id i67sm10155762qkd.90.2021.08.23.22.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 22:35:38 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
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
References: <20210814205743.3039-1-longman@redhat.com>
 <20210814205743.3039-6-longman@redhat.com> <YRqbj5+ZdS+7k0Fn@slm.duckdns.org>
Message-ID: <95b72d36-32a9-8356-05b7-2829e4cc29ad@redhat.com>
Date:   Tue, 24 Aug 2021 01:35:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRqbj5+ZdS+7k0Fn@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/16/21 1:08 PM, Tejun Heo wrote:
> On Sat, Aug 14, 2021 at 04:57:42PM -0400, Waiman Long wrote:
>> +	A parent partition may distribute all its CPUs to its child
>> +	partitions as long as it is not the root cgroup and there is no
>> +	task directly associated with that parent partition.  Otherwise,
> "there is not task directly associated with the parent partition" isn't
> necessary, right? That's already enforced by the cgroup hierarchy itself.

Sorry for the late reply as I was on vacation last week.

Yes, that is true. I should have de-emphasized that the fact that parent 
partition must have no task.

>
>> +	there must be at least one cpu left in the parent partition.
>> +	A new task cannot be moved to a partition root with no effective
>> +	cpu.
>> +
>> +	Once becoming a partition root, changes to "cpuset.cpus"
>> +	is generally allowed as long as the first condition above
>> +	(cpu exclusivity rule) is true.
> All the above ultimately says is that "a new task cannot be moved to a
> partition root with no effective cpu", but I don't understand why this would
> be a separate rule. Shouldn't the partition just stop being a partition when
> it doesn't have any exclusive cpu? What's the benefit of having multiple its
> own failure mode?
A partition with 0 cpu can be considered as a special partition type for 
spawning child partitions. This can be temporary as the cpus will be 
given back when a child partition is destroyed.
>
>> +	Sometimes, changes to "cpuset.cpus" or cpu hotplug may cause
>> +	the state of the partition root to become invalid when the
>> +	other constraints of partition root are violated.  Therefore,
>> +	it is recommended that users should always set "cpuset.cpus"
>> +	to the proper value first before enabling partition.  In case
>> +	"cpuset.cpus" has to be modified after partition is enabled,
>> +	users should check the state of "cpuset.cpus.partition" after
>> +	making change to it to make sure that the partition is still
>> +	valid.
> So, idk why the this doesn't cover the one above it. Also, this really
> should be worded a lot stronger. It's not just recommended - confirming and
> monitoring the transitions is an integral and essential part of using
> cpuset.
Sure, I will reword it to remove any mention of recommendation
> ...
>> +	An invalid partition is not a real partition even though the
>> +	restriction of the cpu exclusivity rule will still apply.
> Is there a reason we can't bring this in line with other failure behaviors?
The internal flags are kept so that we can easily recover and become a 
valid partition again when the cpus become available. Otherwise, we can 
guarantee that the partition status can be restored even when the cpus 
become available.
>
>> +	In the special case of a parent partition competing with a child
>> +	partition for the only CPU left, the parent partition wins and
>> +	the child partition becomes invalid.
> Given that parent partitions are *always* empty, this rule doesn't seem to
> make sense.
You are right. I will update the wording.
>
> So, I think this definitely is a step in the right direction but still seems
> to be neither here or there. Before, we pretended that we could police the
> input when we couldn't. Now, we're changing the interface so that it
> includes configuration failures as an integral part; however, we're still
> policing some particular inputs while letting other inputs pass through and
> trigger failures and why one is handled one way while the other differently
> seems rather arbitrary.
>
The cpu_exclusive and load_balance flags are attributes associated 
directly with the partition type. They are not affected by cpu 
availability or changing of cpu list. That is why they are kept even 
when the partition become invalid. If we have to remove them, it will be 
equivalent to changing partition back to member and we may not need an 
invalid partition type at all. Also, we will not be able to revert back 
to partition again when the cpus becomes available.

Cheers,
Longman

