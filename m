Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B14F6E1995
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 03:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDNBXQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 21:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDNBXP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 21:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853E730FE
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 18:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681435346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhMvhm7mcviP5pv7MPTwxWQbVy7/SnaH+sAFoMwChHM=;
        b=hOg2DoeniQerEjSHDo+CgNiN7SN18MpCgM6D8BQ2VGWYxD6tGhPnRsSnEUjjypq0W3AWFu
        aDlmkjLhM4yU3sZW21djeoXUVa9mC820e76oiOdAx77iTYw2GIj+VhrxfLOo0qvF0FkLsx
        MIBdb70LuIKgt1qWui+EIkNQegO6UcE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-EdtV2y9BN7CoAou49pTNkg-1; Thu, 13 Apr 2023 21:22:21 -0400
X-MC-Unique: EdtV2y9BN7CoAou49pTNkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19503101A531;
        Fri, 14 Apr 2023 01:22:21 +0000 (UTC)
Received: from [10.22.32.61] (unknown [10.22.32.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C943140C6E70;
        Fri, 14 Apr 2023 01:22:19 +0000 (UTC)
Message-ID: <226cb2da-e800-6531-4e57-cbf991022477@redhat.com>
Date:   Thu, 13 Apr 2023 21:22:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20230412153758.3088111-1-longman@redhat.com>
 <ZDcGVebCpyktxyWh@slm.duckdns.org>
 <1ce6a073-e573-0c32-c3d8-f67f3d389a28@redhat.com>
 <ZDcS_yVCgh6g1LoM@slm.duckdns.org>
 <e38f72aa-9705-cf0c-a565-fb790f16c53e@redhat.com>
 <ZDdG1K0kTETZMTCu@slm.duckdns.org>
 <cd4c3f92-4a01-e636-7390-8c6a3d0cfe6c@redhat.com>
 <ZDdNy2NAfj2_1CbW@slm.duckdns.org>
 <1b8d9128-d076-7d37-767d-11d6af314662@redhat.com>
 <ZDdYOI9LB87ra2t_@slm.duckdns.org>
 <9862da55-5f41-24c3-f3bb-4045ccf24b2e@redhat.com>
In-Reply-To: <9862da55-5f41-24c3-f3bb-4045ccf24b2e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/12/23 21:55, Waiman Long wrote:
> On 4/12/23 21:17, Tejun Heo wrote:
>> Hello, Waiman.
>>
>> On Wed, Apr 12, 2023 at 08:55:55PM -0400, Waiman Long wrote:
>>>> Sounds a bit contrived. Does it need to be something defined in the 
>>>> root
>>>> cgroup?
>>> Yes, because we need to take away the isolated CPUs from the 
>>> effective cpus
>>> of the root cgroup. So it needs to start from the root. That is also 
>>> why we
>>> have the partition rule that the parent of a partition has to be a 
>>> partition
>>> root itself. With the new scheme, we don't need a special cgroup to 
>>> hold the
>> I'm following. The root is already a partition root and the cgroupfs 
>> control
>> knobs are owned by the parent, so the root cgroup would own the first 
>> level
>> cgroups' cpuset.cpus.reserve knobs. If the root cgroup wants to 
>> assign some
>> CPUs exclusively to a first level cgroup, it can then set that cgroup's
>> reserve knob accordingly (or maybe the better name is
>> cpuset.cpus.exclusive), which will take those CPUs out of the root 
>> cgroup's
>> partition and give them to the first level cgroup. The first level 
>> cgroup
>> then is free to do whatever with those CPUs that now belong 
>> exclusively to
>> the cgroup subtree.
>
> I am OK with the cpuset.cpus.reserve name, but not that much with the 
> cpuset.cpus.exclusive name as it can get confused with cgroup v1's 
> cpuset.cpu_exclusive. Of course, I prefer the cpuset.cpus.isolated 
> name a bit more. Once an isolated CPU gets used in an isolated 
> partition, it is exclusive and it can't be used in another isolated 
> partition.
>
> Since we will allow users to set cpuset.cpus.reserve to whatever value 
> they want. The distribution of isolated CPUs is only valid if the cpus 
> are present in its parent's cpuset.cpus.reserve and all the way up to 
> the root. It is a bit expensive, but it should be a relatively rare 
> operation.

I now have a slightly different idea of how to do that. We already have 
an internal cpumask for partitioning - subparts_cpus. I am thinking 
about exposing it as cpuset.cpus.reserve. The current way of creating 
subpartitions will be called automatic reservation and require a direct 
parent/child partition relationship. But as soon as a user write 
anything to it, it will break automatic reservation and require manual 
reservation going forward.

In that way, we can keep the old behavior, but also support new use 
cases. I am going to work on that.

Cheers,
Longman

