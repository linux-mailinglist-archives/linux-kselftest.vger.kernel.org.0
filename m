Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C126BF057
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 19:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCQSGX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 14:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjCQSGW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 14:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E91D206AD
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Mar 2023 11:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679076335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UIc+3uJLQO2epi9c5c7YBS9m+h9LmNMS++rx41y2Zn0=;
        b=NMv1AMPJSPkewjPbruq/EENxrv6IVB0QH5S57VFvKGldR7PNS0Cz83KPbLVbTzjM10BHMo
        tTGP5i5ckJFa0dvZmmbeBqIsYYL1RQzdBfkb0h6z6Z4maG2wWB5r+3YmuspEP2xfZ+iWHH
        BsXTBsFConJtRtV8rxqCxNORAbQhlck=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-gD9KEK47O7-cDd1-m1Er1g-1; Fri, 17 Mar 2023 14:05:34 -0400
X-MC-Unique: gD9KEK47O7-cDd1-m1Er1g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1E0C96DC8C;
        Fri, 17 Mar 2023 18:05:32 +0000 (UTC)
Received: from [10.22.10.238] (unknown [10.22.10.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 436EC2027046;
        Fri, 17 Mar 2023 18:05:32 +0000 (UTC)
Message-ID: <11b5454b-42c7-fb0d-f071-c46712f76f3b@redhat.com>
Date:   Fri, 17 Mar 2023 14:05:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/4] cgroup/cpuset: Include offline CPUs when tasks'
 cpumasks in top_cpuset are updated
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20230317151508.1225282-1-longman@redhat.com>
 <20230317151508.1225282-4-longman@redhat.com>
 <20230317180157.uqlleobldg53pgj6@blackpad>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230317180157.uqlleobldg53pgj6@blackpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 3/17/23 14:01, Michal Koutný wrote:
> Hello.
>
> On Fri, Mar 17, 2023 at 11:15:07AM -0400, Waiman Long <longman@redhat.com> wrote:
>>    * Iterate through each task of @cs updating its cpus_allowed to the
>>    * effective cpuset's.  As this function is called with cpuset_rwsem held,
>> - * cpuset membership stays stable.
>> + * cpuset membership stays stable. For top_cpuset, task_cpu_possible_mask()
>> + * is used instead of effective_cpus to make sure all offline CPUs are also
>> + * included as hotplug code won't update cpumasks for tasks in top_cpuset.
>>    */
> On Wed, Mar 15, 2023 at 11:06:20AM +0100, Michal Koutný <mkoutny@suse.com> wrote:
>> I see now that it returns offlined cpus to top cpuset's tasks.
> I considered only the "base" set change cs->effective_cpus ->
> possible_mask. (Apologies for that mistake.)
>
> However, I now read the note about subparts_cpus
>
>>          * effective_cpus contains only onlined CPUs, but subparts_cpus
>>          * may have offlined ones.
> So if subpart_cpus keeps offlined CPUs, they will be subtracted from
> possible_mask and absent in the resulting new_cpus, i.e. undesirable for
> the tasks in that cpuset :-/

A cpu will be in the subparts_cpus only if it has been given to the 
child partition. So when it becomes online, it will become part of the 
scheduling domain that child partition. Only the tasks in that child 
partition will get their cpumasks updated to use it, not those in the 
top cpuset.

Cheers,
Longman

