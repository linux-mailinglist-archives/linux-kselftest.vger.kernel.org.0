Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C986D3A33CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 21:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFJTSa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 15:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230353AbhFJTS3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 15:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623352592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=liO0eMHLLQxFJzTbME5X4nacHbq/D6xkCgBqqSco7f0=;
        b=UKN+VJFnPT1Qyo3v1npa3BNUZAI5MynuwJj6j1bhiY7PgYNDadnJiKxiSqCfqlg+CR+/Dc
        +a2PtBDDqQNbbPd+VasXaEE0uJ7hI2W9T773WubC+23Di5HiXGq+fjZj3RznfOg8b2brr1
        U58N3WY9z3khNJP/ah9cLwXYoHprR48=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-c0n_emlWOwayIgiZhPkdOQ-1; Thu, 10 Jun 2021 15:16:31 -0400
X-MC-Unique: c0n_emlWOwayIgiZhPkdOQ-1
Received: by mail-qk1-f197.google.com with SMTP id u6-20020ae9c0060000b02903ab0c9eea47so2757229qkk.16
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jun 2021 12:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=liO0eMHLLQxFJzTbME5X4nacHbq/D6xkCgBqqSco7f0=;
        b=oiBqds/5XeUhYdYFc2In5Ko/6jsKj/QuwG4i9G3x1Bw86t8TKGkVa/nhRKfoJg+sXB
         hiwnfDaxU8HnveQDk48ad6lD1h+60sglBJeyvXLxjNYdd7kBzKmbh2elTdxnij4wG75e
         CvNF99YOxz/KrFfp87zmUbXBGsd4HUDXFFDMxsF1sxqTMOa1cJNzMntwVNelZAcHW2Sq
         RNiiHYuhMxFCDVkVx0N7VsTJPAyOrZaQHRnbqrWGyBT2Z6F9shxVePdkdlLBgU229H6n
         4n1qOe5L5v88jBzuuu4ZR5Ia1J51WVhdtXh2zDaGrqoWgIewTtDoSPUSOPO6fKkA6dD/
         XNWg==
X-Gm-Message-State: AOAM531QBHK93rUbeSXYHQJPDdFobQzNhwW4u2zsNSV9fcL1MoRdp4p4
        qBU2dhSDxKUkco1j2m45YyecmpAcX2UEO5LUC94xGyZyoxmkFP6ZiY6+9YrfE3KqOzllyjhIrOe
        uw8tFnWdIMfzxlyhKlVeVpyRNv33I
X-Received: by 2002:a37:5507:: with SMTP id j7mr104024qkb.309.1623352591110;
        Thu, 10 Jun 2021 12:16:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAuBlSzvmN6H5oSpFj7wzJ2WHLurIlPNKFIgsipjYWbH5Grt8CtLeVfMxQOG6UnUOcx7CMDw==
X-Received: by 2002:a37:5507:: with SMTP id j7mr104009qkb.309.1623352590931;
        Thu, 10 Jun 2021 12:16:30 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id 7sm2906484qkb.86.2021.06.10.12.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 12:16:30 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/5] cgroup/cpuset: Add new cpus.partition type with no
 load balancing
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20210603212416.25934-1-longman@redhat.com>
 <20210603212416.25934-3-longman@redhat.com>
 <YMJfDHr1+xxm6SBi@hirez.programming.kicks-ass.net>
Message-ID: <820aff72-fce2-ac2f-88e6-787249e04308@redhat.com>
Date:   Thu, 10 Jun 2021 15:16:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YMJfDHr1+xxm6SBi@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/10/21 2:50 PM, Peter Zijlstra wrote:
> On Thu, Jun 03, 2021 at 05:24:13PM -0400, Waiman Long wrote:
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
>> "root-nolb" is added which allows the creation of a cpuset partition with
>> no load balancing. This will allow system administrators to dynamically
>> adjust the size of the no load balancing partition to the current need
>> of the workload without rebooting the system.
> I'm confused, why do you need this? Just create a parition for each cpu.
>
 From a management point of view, it is more cumbersome to do one cpu 
per partition. I have suggested this idea of 1 cpu per partition to the 
container developers, but they don't seem to like it.

Cheers,
Longman

