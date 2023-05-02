Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D96F6F4C2B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 23:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjEBV1S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 17:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEBV1L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 17:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E1110F3
        for <linux-kselftest@vger.kernel.org>; Tue,  2 May 2023 14:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683062782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1zc7E43mDugyj5NEnd93trnYdgLQsKcvQy7NWFtl2VU=;
        b=KG2lhN2AgtHVgEv322yBE61gVbiyM/zDFhmt+Frp7/B8/jAXkUT6MVBgv8RUxZJk0mEVds
        Fpb2GS58C68EEO44yLHx3LYaEqHpsU0SrSTLEcAtTLp/7xT3bxEFIKIuXhaZffxusC/XT2
        Dlo+4bKflZourDkEFrmMGqnPCzeBeu8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-h9qpYmFjMQu-UNgu6fOiTA-1; Tue, 02 May 2023 17:26:18 -0400
X-MC-Unique: h9qpYmFjMQu-UNgu6fOiTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33D3C811E7E;
        Tue,  2 May 2023 21:26:18 +0000 (UTC)
Received: from [10.22.10.239] (unknown [10.22.10.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A78C112132E;
        Tue,  2 May 2023 21:26:17 +0000 (UTC)
Message-ID: <f2bd7b1e-190e-1d08-f085-b4cae36fb5be@redhat.com>
Date:   Tue, 2 May 2023 17:26:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <ZDdNy2NAfj2_1CbW@slm.duckdns.org>
 <1b8d9128-d076-7d37-767d-11d6af314662@redhat.com>
 <ZDdYOI9LB87ra2t_@slm.duckdns.org>
 <9862da55-5f41-24c3-f3bb-4045ccf24b2e@redhat.com>
 <226cb2da-e800-6531-4e57-cbf991022477@redhat.com>
 <ZDmFLfII8EUX_ocY@slm.duckdns.org>
 <c61ca9d0-c514-fb07-c2f2-3629e8898984@redhat.com>
 <ZDmOjeBVsIcgSLIV@slm.duckdns.org>
 <60ec12dc-943c-b8f0-8b6f-97c5d332144c@redhat.com>
 <46d26abf-a725-b924-47fa-4419b20bbc02@redhat.com>
 <jqkf7jkuyxqiupmxmdbmpnbpojub2pjsz3oogwncmwqdghlsgk@phsqzirmmlyl>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <jqkf7jkuyxqiupmxmdbmpnbpojub2pjsz3oogwncmwqdghlsgk@phsqzirmmlyl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/2/23 14:01, Michal Koutný wrote:
> Hello.
>
> The previous thread arrived incomplete to me, so I respond to the last
> message only. Point me to a message URL if it was covered.
>
> On Fri, Apr 14, 2023 at 03:06:27PM -0400, Waiman Long <longman@redhat.com> wrote:
>> Below is a draft of the new cpuset.cpus.reserve cgroupfs file:
>>
>>    cpuset.cpus.reserve
>>          A read-write multiple values file which exists on all
>>          cpuset-enabled cgroups.
>>
>>          It lists the reserved CPUs to be used for the creation of
>>          child partitions.  See the section on "cpuset.cpus.partition"
>>          below for more information on cpuset partition.  These reserved
>>          CPUs should be a subset of "cpuset.cpus" and will be mutually
>>          exclusive of "cpuset.cpus.effective" when used since these
>>          reserved CPUs cannot be used by tasks in the current cgroup.
>>
>>          There are two modes for partition CPUs reservation -
>>          auto or manual.  The system starts up in auto mode where
>>          "cpuset.cpus.reserve" will be set automatically when valid
>>          child partitions are created and users don't need to touch the
>>          file at all.  This mode has the limitation that the parent of a
>>          partition must be a partition root itself.  So child partition
>>          has to be created one-by-one from the cgroup root down.
>>
>>          To enable the creation of a partition down in the hierarchy
>>          without the intermediate cgroups to be partition roots,
> Why would be this needed? Owning a CPU (a resource) must logically be
> passed all the way from root to the target cgroup, i.e. this is
> expressed by valid partitioning down to given level.
>
>>          one
>>          has to turn on the manual reservation mode by writing directly
>>          to "cpuset.cpus.reserve" with a value different from its
>>          current value.  By distributing the reserve CPUs down the cgroup
>>          hierarchy to the parent of the target cgroup, this target cgroup
>>          can be switched to become a partition root if its "cpuset.cpus"
>>          is a subset of the set of valid reserve CPUs in its parent.
> level n
> `- level n+1
>     cpuset.cpus	// these are actually configured by "owner" of level n
>     cpuset.cpus.partition // similrly here, level n decides if child is a partition
>
> I.e. what would be level n/cpuset.cpus.reserve good for when it can
> directly control level n+1/cpuset.cpus?

In the new scheme, the available cpus are still directly passed down to 
a descendant cgroup. However, isolated CPUs (or more generally CPUs 
dedicated to a partition) have to be exclusive. So what the 
cpuset.cpus.reserve does is to identify those exclusive CPUs that can be 
excluded from the effective_cpus of the parent cgroups before they are 
claimed by a child partition. Currently this is done automatically when 
a child partition is created off a parent partition root. The new scheme 
will break it into 2 separate steps without the requirement that the 
parent of a partition has to be a partition root itself.

Cheers,
Longman

claimed by a partition and will be excluded from the effective_cpus of 
the parent

