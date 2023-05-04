Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFAD6F631A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 May 2023 05:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjEDDCe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 May 2023 23:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjEDDCd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 May 2023 23:02:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BB0172D
        for <linux-kselftest@vger.kernel.org>; Wed,  3 May 2023 20:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683169303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zwXrGnlynmWthuhj861VrvHW2/WpagpsgRCBG9/mDP0=;
        b=bwipz1vmPKCNGcknb3ceVVvHulgNcnyYm/OhFGQg0zBk4lq3HMfkB1TSeF4924q4Vnm/Ka
        l8vdhIAszM/ulMYDUdBxfaBzPy8scq73qWtbPlR09ZoAkmN/LlvZ8x1d9PE3M7HzHYeOPz
        MiLJtPzi1bUsgoAEQRwmZlIxbfUGp7k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-Dc2ExmcBNOecvx6fkKjDEw-1; Wed, 03 May 2023 23:01:37 -0400
X-MC-Unique: Dc2ExmcBNOecvx6fkKjDEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F6C21C08796;
        Thu,  4 May 2023 03:01:37 +0000 (UTC)
Received: from [10.22.17.228] (unknown [10.22.17.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4186740C2064;
        Thu,  4 May 2023 03:01:36 +0000 (UTC)
Message-ID: <deb7b684-3d7c-b3ae-7b36-5b7ba2dd8001@redhat.com>
Date:   Wed, 3 May 2023 23:01:36 -0400
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
References: <ZDdYOI9LB87ra2t_@slm.duckdns.org>
 <9862da55-5f41-24c3-f3bb-4045ccf24b2e@redhat.com>
 <226cb2da-e800-6531-4e57-cbf991022477@redhat.com>
 <ZDmFLfII8EUX_ocY@slm.duckdns.org>
 <c61ca9d0-c514-fb07-c2f2-3629e8898984@redhat.com>
 <ZDmOjeBVsIcgSLIV@slm.duckdns.org>
 <60ec12dc-943c-b8f0-8b6f-97c5d332144c@redhat.com>
 <46d26abf-a725-b924-47fa-4419b20bbc02@redhat.com>
 <jqkf7jkuyxqiupmxmdbmpnbpojub2pjsz3oogwncmwqdghlsgk@phsqzirmmlyl>
 <f2bd7b1e-190e-1d08-f085-b4cae36fb5be@redhat.com>
 <ZFGOTHQj3k5rzmyR@blackbook>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZFGOTHQj3k5rzmyR@blackbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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


On 5/2/23 18:27, Michal Koutný wrote:
> On Tue, May 02, 2023 at 05:26:17PM -0400, Waiman Long <longman@redhat.com> wrote:
>> In the new scheme, the available cpus are still directly passed down to a
>> descendant cgroup. However, isolated CPUs (or more generally CPUs dedicated
>> to a partition) have to be exclusive. So what the cpuset.cpus.reserve does
>> is to identify those exclusive CPUs that can be excluded from the
>> effective_cpus of the parent cgroups before they are claimed by a child
>> partition. Currently this is done automatically when a child partition is
>> created off a parent partition root. The new scheme will break it into 2
>> separate steps without the requirement that the parent of a partition has to
>> be a partition root itself.
> new scheme
>    1st step:
>    echo C >p/cpuset.cpus.reserve
>    # p/cpuset.cpus.effective == A-C (1)
>    2nd step (claim):
>    echo C' >p/c/cpuset.cpus # C'⊆C
>    echo root >p/c/cpuset.cpus.partition

It is something like that. However, the current scheme of automatic 
reservation is also supported, i.e. cpuset.cpus.reserve will be set 
automatically when the child cgroup becomes a valid partition as long as 
the cpuset.cpus.reserve file is not written to. This is for backward 
compatibility.

Once it is written to, automatic mode will end and users have to 
manually set it afterward.


>
> current scheme
>    1st step (configure):
>    echo C >p/c/cpuset.cpus
>    2nd step (reserve & claim):
>    echo root >p/c/cpuset.cpus.partition
>    # p/cpuset.cpus.effective == A-C (2)
>
> As long as p/c is unpopulated, (1) and (2) are equal situations.
> Why is the (different) two step procedure needed?
>
> Also the relaxation of requirement of a parent being a partition
> confuses me -- if the parent is not a partition, i.e. it has no
> exclusive ownership of CPUs but it can still "give" it to children -- is
> child partition meant to be exclusive? (IOW can parent siblings reserve
> some same CPUs?)

A valid partition root has exclusive ownership of its CPUs. That is a 
rule that won't be changed. As a result, an incoming partition root 
cannot claim CPUs that have been allocated to another partition. To 
simplify thing, transition to a valid partition root is not possible if 
any of the CPUs in its cpuset.cpus are not in the cpuset.cpus.reserve of 
its ancestor or have been allocated to another partition. The partition 
root simply becomes invalid.

The parent can virtually give the reserved CPUs from the root down the 
hierarchy and a child can claim them once it becomes a partition root. 
In manual mode, we need to check all the way up the hierarchy to the 
root to figure out what CPUs in cpuset.cpus.reserve are valid. It has 
higher overhead, but enabling partition is not a fast operation anyway.

Cheers,
Longman

