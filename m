Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBB46F86AD
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 May 2023 18:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjEEQ0i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 May 2023 12:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjEEQ0h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 May 2023 12:26:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D8F18153
        for <linux-kselftest@vger.kernel.org>; Fri,  5 May 2023 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683303949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ttq1OS4Xt/+1PhRFtnRIzajv6W4m8JyhFIEC4N9Qslw=;
        b=AMTgW6f8JQwWKi0V++eQlfE0ILV7gKfwkgqn97xRGkpbcIcTIUAEQqsctNkMODUGj5PuSP
        ve2zTajPsyji70J5HHyw6UJjcrfzggyA4okKq/g+mSXFqwS6TVqL7gGjLusPmjO0iCmT7S
        9MFqPwxUOVdhhYQ8KdIKgTqosWqEU6M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-OwwySg5LOY2dWxksbxreWQ-1; Fri, 05 May 2023 12:25:43 -0400
X-MC-Unique: OwwySg5LOY2dWxksbxreWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8443100F650;
        Fri,  5 May 2023 16:25:42 +0000 (UTC)
Received: from [10.22.32.149] (unknown [10.22.32.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B65971410F23;
        Fri,  5 May 2023 16:25:41 +0000 (UTC)
Message-ID: <759603dd-7538-54ad-e63d-bb827b618ae3@redhat.com>
Date:   Fri, 5 May 2023 12:25:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <226cb2da-e800-6531-4e57-cbf991022477@redhat.com>
 <ZDmFLfII8EUX_ocY@slm.duckdns.org>
 <c61ca9d0-c514-fb07-c2f2-3629e8898984@redhat.com>
 <ZDmOjeBVsIcgSLIV@slm.duckdns.org>
 <60ec12dc-943c-b8f0-8b6f-97c5d332144c@redhat.com>
 <46d26abf-a725-b924-47fa-4419b20bbc02@redhat.com>
 <jqkf7jkuyxqiupmxmdbmpnbpojub2pjsz3oogwncmwqdghlsgk@phsqzirmmlyl>
 <f2bd7b1e-190e-1d08-f085-b4cae36fb5be@redhat.com>
 <ZFGOTHQj3k5rzmyR@blackbook>
 <deb7b684-3d7c-b3ae-7b36-5b7ba2dd8001@redhat.com>
 <ZFUo5IYAIwTEKR4_@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZFUo5IYAIwTEKR4_@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 5/5/23 12:03, Tejun Heo wrote:
> On Wed, May 03, 2023 at 11:01:36PM -0400, Waiman Long wrote:
>> On 5/2/23 18:27, Michal Koutný wrote:
>>> On Tue, May 02, 2023 at 05:26:17PM -0400, Waiman Long <longman@redhat.com> wrote:
>>>> In the new scheme, the available cpus are still directly passed down to a
>>>> descendant cgroup. However, isolated CPUs (or more generally CPUs dedicated
>>>> to a partition) have to be exclusive. So what the cpuset.cpus.reserve does
>>>> is to identify those exclusive CPUs that can be excluded from the
>>>> effective_cpus of the parent cgroups before they are claimed by a child
>>>> partition. Currently this is done automatically when a child partition is
>>>> created off a parent partition root. The new scheme will break it into 2
>>>> separate steps without the requirement that the parent of a partition has to
>>>> be a partition root itself.
>>> new scheme
>>>     1st step:
>>>     echo C >p/cpuset.cpus.reserve
>>>     # p/cpuset.cpus.effective == A-C (1)
>>>     2nd step (claim):
>>>     echo C' >p/c/cpuset.cpus # C'⊆C
>>>     echo root >p/c/cpuset.cpus.partition
>> It is something like that. However, the current scheme of automatic
>> reservation is also supported, i.e. cpuset.cpus.reserve will be set
>> automatically when the child cgroup becomes a valid partition as long as the
>> cpuset.cpus.reserve file is not written to. This is for backward
>> compatibility.
>>
>> Once it is written to, automatic mode will end and users have to manually
>> set it afterward.
> I really don't like the implicit switching behavior. This is interface
> behavior modifying internal state that userspace can't view or control
> directly. Regardless of how the rest of the discussion develops, this part
> should be improved (e.g. would it work to always try to auto-reserve if the
> cpu isn't already reserved?).

After some more thought yesterday, I have a slight change in my design 
that auto-reserve as it is now will stay for partitions that have a 
partition root parent. For remote partition that doesn't have a 
partition root parent, its creation will require pre-allocating 
additional CPUs into top_cpuset's cpuset.cpus.reserve first. So there 
will be no change in behavior for existing use cases whether a remote 
partition is created or not.

Cheers,
Longman

