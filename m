Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9234F547DCB
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 05:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiFMDCs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Jun 2022 23:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiFMDCr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Jun 2022 23:02:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBF67E02
        for <linux-kselftest@vger.kernel.org>; Sun, 12 Jun 2022 20:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655089365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F58ZoXbX4GWpAIzK3fVF2XxLcUUEcOzj0SgrznA2bos=;
        b=ahCP0UcKpkXX5GOufmmHwnSPk8LKEkMcaBLEdyahRmAKNEtYZi1Chk4SNvw3TRNFY5QoYh
        jH+c46hj7SCNPxkZk93uJn3k8nhS3WHOU9d2rmUAPM3GrMhWs+1B16ZV7HNIr9bkPp0Ey9
        2YAhlJFihcW3Xu9FancXqtVvVmCwM70=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-AnmAdcG4NcW4gv-b48OK-w-1; Sun, 12 Jun 2022 23:02:40 -0400
X-MC-Unique: AnmAdcG4NcW4gv-b48OK-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BFED185A7A4;
        Mon, 13 Jun 2022 03:02:39 +0000 (UTC)
Received: from [10.22.16.100] (unknown [10.22.16.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CF9D2166B26;
        Mon, 13 Jun 2022 03:02:38 +0000 (UTC)
Message-ID: <404171dc-0da3-21f2-5003-9718f875e967@redhat.com>
Date:   Sun, 12 Jun 2022 23:02:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v11 7/8] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
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
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20220510153413.400020-1-longman@redhat.com>
 <20220510153413.400020-8-longman@redhat.com>
 <YqYnQ4U4t6j/3UaL@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YqYnQ4U4t6j/3UaL@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/12/22 13:49, Tejun Heo wrote:
> Hello,
>
> On Tue, May 10, 2022 at 11:34:12AM -0400, Waiman Long wrote:
>> +	External events like hotplug or changes to "cpuset.cpus" can
>> +	cause a valid partition root to become invalid and vice versa.
>> +	Note that a task cannot be moved to a cgroup with empty
>> +	"cpuset.cpus.effective".
>> +
>> +	For a valid partition root or an invalid partition root with
>> +	the exclusivity rule enabled, changes made to "cpuset.cpus"
>> +	that violate the exclusivity rule will not be allowed.
> My memory is failing but this is the same thing that we were discussing
> before, right? The point was that the different behaviors re. system events
> and config actions seemed unncessary and IIRC Michal was of the same opinion
> (please correct me if I'm misremembering).

That is the behavior enforced by setting the CPU_EXCLUSIVE bit in cgroup 
v1. I haven't explicitly change it to make it different in cgroup v2. 
The major reason is that I don't want change to one cpuset to affect a 
sibling partition as it may make the code more complicate to validate if 
a partition is valid.

>
>> +	A valid non-root parent partition may distribute out all its CPUs
>> +	to its child partitions when there is no task associated with it.
> I'm probably forgetting something. Was this necessary because of threaded
> cgroup support because otherwise the above condition is superflous?

The top cpuset cannot have empty cpus.effective whereas the non-root 
partition roots can. Maybe I should reword it to make it more clear.

Thanks,
Longman

