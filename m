Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401856E03E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 03:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjDMB4h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 21:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjDMB4h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 21:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C0E61A1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 18:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681350953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QUAJoa4WsPFgOaywimIxgJmb0m1Gj0LU/rbMc/oiFgM=;
        b=DQln5leQkin0vOWp4eR/gYPBbs87nsQoIGmXEma3KPYR/lLrM1fGpqM3cyfI303cGCS2Rv
        x8JJiJuhrpoQ2+wRuc0Ptu+WSdfkNyw8YoH/ihJMA06iSPvFrHUaX5BfEXF+KGhbdX20Pg
        0mQ44QEec+1nKsI+tr8DloYvRRkf9uw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-SMq2uPKiO0excjeVA5Pqsw-1; Wed, 12 Apr 2023 21:55:47 -0400
X-MC-Unique: SMq2uPKiO0excjeVA5Pqsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C9473810B1C;
        Thu, 13 Apr 2023 01:55:47 +0000 (UTC)
Received: from [10.22.32.168] (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 668CDC15BB8;
        Thu, 13 Apr 2023 01:55:46 +0000 (UTC)
Message-ID: <9862da55-5f41-24c3-f3bb-4045ccf24b2e@redhat.com>
Date:   Wed, 12 Apr 2023 21:55:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Content-Language: en-US
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZDdYOI9LB87ra2t_@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/12/23 21:17, Tejun Heo wrote:
> Hello, Waiman.
>
> On Wed, Apr 12, 2023 at 08:55:55PM -0400, Waiman Long wrote:
>>> Sounds a bit contrived. Does it need to be something defined in the root
>>> cgroup?
>> Yes, because we need to take away the isolated CPUs from the effective cpus
>> of the root cgroup. So it needs to start from the root. That is also why we
>> have the partition rule that the parent of a partition has to be a partition
>> root itself. With the new scheme, we don't need a special cgroup to hold the
> I'm following. The root is already a partition root and the cgroupfs control
> knobs are owned by the parent, so the root cgroup would own the first level
> cgroups' cpuset.cpus.reserve knobs. If the root cgroup wants to assign some
> CPUs exclusively to a first level cgroup, it can then set that cgroup's
> reserve knob accordingly (or maybe the better name is
> cpuset.cpus.exclusive), which will take those CPUs out of the root cgroup's
> partition and give them to the first level cgroup. The first level cgroup
> then is free to do whatever with those CPUs that now belong exclusively to
> the cgroup subtree.

I am OK with the cpuset.cpus.reserve name, but not that much with the 
cpuset.cpus.exclusive name as it can get confused with cgroup v1's 
cpuset.cpu_exclusive. Of course, I prefer the cpuset.cpus.isolated name 
a bit more. Once an isolated CPU gets used in an isolated partition, it 
is exclusive and it can't be used in another isolated partition.

Since we will allow users to set cpuset.cpus.reserve to whatever value 
they want. The distribution of isolated CPUs is only valid if the cpus 
are present in its parent's cpuset.cpus.reserve and all the way up to 
the root. It is a bit expensive, but it should be a relatively rare 
operation.

>
>> isolated CPUs. The new root cgroup file will be enough to inform the system
>> what CPUs will have to be isolated.
>>
>> My current thinking is that the root's "cpuset.cpus.isolated" will start
>> with whatever have been set in the "isolcpus" or "nohz_full" boot command
>> line and can be extended from there but not shrank below that as there can
>> be additional isolation attributes with those isolated CPUs.
> I'm not sure we wanna tie with those automatically. I think it'd be
> confusing than helpful.

Yes, I am fine with taking this off for now.

Cheers,
Longman

