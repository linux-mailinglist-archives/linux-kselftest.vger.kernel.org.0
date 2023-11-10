Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021967E7685
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Nov 2023 02:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345603AbjKJBZv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 20:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345592AbjKJBZu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 20:25:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED24144A6
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 17:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699579499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOeaU4ehAGD9H3QjwT3Yo8UQTF0ixUxWvh3B6xsGYO0=;
        b=dxLjbgKfK8uh200dOsarlPQ+BDacZvMMq9WD+Ix68TF4vio3ExRpZRHM67clx6R+rJdPi+
        5jJuV2VuFMAWKubVv9AZPzWfdEZEzKSA2CZd/mK5+8fx1MfjpXajTspOpz1HW9SVjehBTq
        eVEe71mCYesj7z1mLUJeSqU1xzf+xVk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-lbsk-TDLMKGmNmB1vvx0GQ-1; Thu, 09 Nov 2023 20:24:56 -0500
X-MC-Unique: lbsk-TDLMKGmNmB1vvx0GQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D7FB185A780;
        Fri, 10 Nov 2023 01:24:55 +0000 (UTC)
Received: from [10.22.10.178] (unknown [10.22.10.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F3362166B26;
        Fri, 10 Nov 2023 01:24:54 +0000 (UTC)
Message-ID: <21ebd168-8b3f-0efc-20f1-89173e79eaed@redhat.com>
Date:   Thu, 9 Nov 2023 20:24:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 0/4] cgroup/cpuset: Improve CPU isolation in isolated
 partitions
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "tj@kernel.org" <tj@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>
Cc:     "pehunt@redhat.com" <pehunt@redhat.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20231025182555.4155614-1-longman@redhat.com>
 <98bea19ca5eb5c19ef0ea55f5167237cc841fe9b.camel@intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <98bea19ca5eb5c19ef0ea55f5167237cc841fe9b.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/9/23 04:02, Zhang, Rui wrote:
> Hi, Waiman,
>
> May I know which kernel this patch series is based on?
>
> I'd like to test this feature, but cannot apply it cleanly on top of
> v6.6.

It was originally based on the cgroup/for-6.7 branch. It should be 
applicable to v6.7 kernel now.

Cheers,
Longman

> thanks,
> rui
>
> On Wed, 2023-10-25 at 14:25 -0400, Waiman Long wrote:
>> v2:
>>   - Add 2 read-only workqueue sysfs files to expose the user requested
>>     cpumask as well as the isolated CPUs to be excluded from
>>     wq_unbound_cpumask.
>>   - Ensure that caller of the new workqueue_unbound_exclude_cpumask()
>>     hold cpus_read_lock.
>>   - Update the cpuset code to make sure the cpus_read_lock is held
>>     whenever workqueue_unbound_exclude_cpumask() may be called.
>>
>> Isolated cpuset partition can currently be created to contain an
>> exclusive set of CPUs not used in other cgroups and with load
>> balancing
>> disabled to reduce interference from the scheduler.
>>
>> The main purpose of this isolated partition type is to dynamically
>> emulate what can be done via the "isolcpus" boot command line option,
>> specifically the default domain flag. One effect of the "isolcpus"
>> option
>> is to remove the isolated CPUs from the cpumasks of unbound
>> workqueues
>> since running work functions in an isolated CPU can be a major source
>> of interference. Changing the unbound workqueue cpumasks can be done
>> at
>> run time by writing an appropriate cpumask without the isolated CPUs
>> to
>> /sys/devices/virtual/workqueue/cpumask. So one can set up an isolated
>> cpuset partition and then write to the cpumask sysfs file to achieve
>> similar level of CPU isolation. However, this manual process can be
>> error prone.
>>
>> This patch series implements automatic exclusion of isolated CPUs
>> from
>> unbound workqueue cpumasks when an isolated cpuset partition is
>> created
>> and then adds those CPUs back when the isolated partition is
>> destroyed.
>>
>> There are also other places in the kernel that look at the
>> HK_FLAG_DOMAIN
>> cpumask or other HK_FLAG_* cpumasks and exclude the isolated CPUs
>> from
>> certain actions to further reduce interference. CPUs in an isolated
>> cpuset partition will not be able to avoid those interferences yet.
>> That
>> may change in the future as the need arises.
>>
>> Waiman Long (4):
>>    workqueue: Add workqueue_unbound_exclude_cpumask() to exclude CPUs
>>      from wq_unbound_cpumask
>>    selftests/cgroup: Minor code cleanup and reorganization of
>>      test_cpuset_prs.sh
>>    cgroup/cpuset: Keep track of CPUs in isolated partitions
>>    cgroup/cpuset: Take isolated CPUs out of workqueue unbound cpumask
>>
>>   Documentation/admin-guide/cgroup-v2.rst       |  10 +-
>>   include/linux/workqueue.h                     |   2 +-
>>   kernel/cgroup/cpuset.c                        | 286 +++++++++++++---
>> --
>>   kernel/workqueue.c                            |  91 +++++-
>>   .../selftests/cgroup/test_cpuset_prs.sh       | 216 ++++++++-----
>>   5 files changed, 438 insertions(+), 167 deletions(-)
>>

