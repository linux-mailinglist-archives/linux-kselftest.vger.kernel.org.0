Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ED651A4DD
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 18:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353047AbiEDQGC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 12:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353029AbiEDQGB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 12:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBC9215728
        for <linux-kselftest@vger.kernel.org>; Wed,  4 May 2022 09:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651680144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kx7MkkZT+Yq+fM3GfswobHpHpBTfL9nTvycJqnYKSP8=;
        b=g64HKG3q7K9kl0OdgE3bVx0t56mL25HfPcdeYHdrnZG95Gt95xSWwL3EWg2VMMvjGH/6IU
        G/YZ2Xg/1Apbh17i2zs+e3ofB+tM9ShMxCQaqEtlrEw5zbFUbGp24Fird2Rk7fP1pdF7sz
        eelDZJqopjQ7GRxGKAZBsAJ5ITqW7RY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-MzJLmzJiNoatZxsrxTXkGw-1; Wed, 04 May 2022 12:02:23 -0400
X-MC-Unique: MzJLmzJiNoatZxsrxTXkGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35937805F46;
        Wed,  4 May 2022 16:02:22 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77B9540CF8EF;
        Wed,  4 May 2022 16:02:20 +0000 (UTC)
Message-ID: <379138a0-1721-d6fa-4d1d-cb8d79f28474@redhat.com>
Date:   Wed, 4 May 2022 12:02:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 7/8] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
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
References: <20220503162149.1764245-1-longman@redhat.com>
 <20220503162149.1764245-8-longman@redhat.com>
 <20220504112552.GA15266@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220504112552.GA15266@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/4/22 07:25, Michal Koutný wrote:
> Hello.
>
> On Tue, May 03, 2022 at 12:21:48PM -0400, Waiman Long <longman@redhat.com> wrote:
>>   Documentation/admin-guide/cgroup-v2.rst | 145 +++++++++++++-----------
>>   1 file changed, 79 insertions(+), 66 deletions(-)
> A note across various lines -- it seems your new text accidentally mixes
> both spaces and tabs for indentation.

You are right. I will fix that.

>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 69d7a6983f78..94e1e3771830 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> [...]
>> +	The value shown in "cpuset.cpus.effective" of a partition root is
>> +	the CPUs that the parent partition root can dedicate to the new
>> +	partition root.  They are subtracted from "cpuset.cpus.effective"
>> +	of the parent and may be different from "cpuset.cpus"
> I find this paragraph a bit hard to comprehend (I read it as it talks
> about three levels of cgroups (parent, child, grandparent). It is
> correct but I'd suggect following formulation (where I additionally
> simplifed it by talking about "available" cpus):
>
>> The value shown in "cpuset.cpus.effective" of a partition root is
>> the CPUs that the partition root can dedicate to a potential new child
>> partition root. The new child subtracts available CPUs from its parent
>> "cpuset.cpus.effective".


Thanks for the suggestion, will modify the text as suggested.


>
>> +	For a partition root to become valid, the following conditions
>> +	must be met.
>> +
>> +	1) The "cpuset.cpus" is exclusive, i.e. they are not shared by
>> +	   any of its siblings (exclusivity rule).
>> +	2) The parent cgroup is a valid partition root.
>> +	3) The "cpuset.cpus" is not empty and must contain at least
>> +	   one of the CPUs from parent's "cpuset.cpus", i.e. they overlap.
>> +        4) The "cpuset.cpus.effective" must be a subset of "cpuset.cpus"
>> +           and cannot be empty unless there is no task associated with
>> +           this partition.
> This sounds good to me.
>
>> +        Care must be taken to change a valid partition root to "member"
>> +        as all its child partitions, if present, will become invalid.
> This does not talk about recovering. Is it intentional? (I.e. to left
> implementation defined)

This new patch series does have the ability to recover now.  I am just 
not emphasizing the recovery aspect of it in the doc file. I will add a 
sentence about it.

>
> Except the remarks above, I find the concepts described here good. I'll
> reply to implementation separately & later.

Thanks,
Longman

