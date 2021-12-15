Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8300D476085
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 19:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343644AbhLOSRN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 13:17:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343667AbhLOSRB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 13:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639592220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDOmbSgSfH5oVZVfeOYCn0yzGNbmiacT1UQDjK4tWws=;
        b=aSaz4JWWNfCR86/ybUOOK7ijOBa0ZQz2DMEMSLqOA1pd2PLiOk8uFZO38unCct8SLa1GSl
        I6LbsSJJuJTxbVn9t0elQLVDgoh9tpoGWLpuT2i/xW0uEdC60AS6yXBB0k5BB8g5uiWSWk
        GNJqw36mwy87pNHlJlbcv/BPQqrgyB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-O0RuXf4FP2WllEUrZTzsIw-1; Wed, 15 Dec 2021 13:16:56 -0500
X-MC-Unique: O0RuXf4FP2WllEUrZTzsIw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1E32593AE;
        Wed, 15 Dec 2021 18:16:54 +0000 (UTC)
Received: from [10.22.10.54] (unknown [10.22.10.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 342EC60BD8;
        Wed, 15 Dec 2021 18:16:44 +0000 (UTC)
Message-ID: <96018978-6b7f-1e7f-1012-9df7f7996ec5@redhat.com>
Date:   Wed, 15 Dec 2021 13:16:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 6/7] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
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
 <20211205183220.818872-7-longman@redhat.com>
 <Ybe0YWEo7Wp7wib9@slm.duckdns.org> <20211215144450.GC25459@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211215144450.GC25459@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/15/21 09:44, Michal Koutný wrote:
> On Mon, Dec 13, 2021 at 11:00:17AM -1000, Tejun Heo <tj@kernel.org> wrote:
>> * When a valid partition turns invalid, now we have a reliable way of
>>    discovering what exactly caused the transition. However, when a user now
>>    fails to turn a member into partition, all they get is -EINVAL and there's
>>    no way to discover why it failed and the failure conditions that -EINVAL
>>    represents aren't simple.
>>
>> * In an automated configuration scenarios, this operation mode may be
>>    difficult to make reliable and lead to sporadic failures which can be
>>    tricky to track down. The core problem is that whether a given operation
>>    succeeds or not may depend on external states (CPU on/offline) which may
>>    change asynchronously in a way that the configuring entity doesn't have
>>    any control over.
>>
>> It's true that both are existing problems with the current partition
>> interface and given that this is a pretty spcialized feature, this can be
>> okay. Michal, what are your thoughts?
> Because of asynchronous changes, the return value should not be that
> important and the user should watch cpuset.partitions for the result
> (end state) anyway.
> Furthermore, the reasons should be IMO just informative (i.e. I like
> they're not explicitly documented) and not API.
>
> But I see there could be a distinction between -EINVAL (the supplied
> input makes no sense) and -EAGAIN(?) denoting that the switch to
> partition root could not happen (due to outer constraints).
>
> You seem to propose to replace the -EAGAIN above with a success code and
> allow the switch to an invalid root.
> The action of the configuring entity would be different: retry (when?)
> vs wait till transition happens (notification) (although the immediate
> effect (the change did not happen) is same).
> I considered the two variants equal but the clear information about when
> the change can happen I'd favor the variant allowing the switch to
> invalid root now.

Allowing direct transition from member to invalid partition doesn't feel 
right for me. A casual user may assume a partition is correctly formed 
without double checking the "cpuset.partition" value. Returning an error 
will prevent this kind of issue. If returning more information about the 
failure is the main reason for allowing the invalid partition 
transition, we can extend the "cpuset.partition" read syntax to also 
show the reason for the previous failure.

Cheers,
Longman

