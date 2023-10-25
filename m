Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFDA7D7384
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 20:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjJYSq7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 14:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYSq4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 14:46:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3921F123
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Oct 2023 11:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698259568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SgBMxtkVhUoG7t1CWbN6Lm5UPuU4BbKMP/ha4PbuoVQ=;
        b=VF9BYnOCK3E5uJ6+G7cakUutOhr4kmL5Rh8glnWqeqJxi9/KpvdeQKAVzREHl6YQIBnBpk
        Ri13dGt1sGXn8keWH2S5f80Oakz/s1rf2LUB/Ft+c+Z1ALnHtYTfeBOG4gYoQxV8tZfdbR
        8FOC2VWV320qLvfnqDO5LeQpxb0/a7E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-gNb3Di8KMZ-8dTWtY98GKQ-1; Wed, 25 Oct 2023 14:46:04 -0400
X-MC-Unique: gNb3Di8KMZ-8dTWtY98GKQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B36558925C4;
        Wed, 25 Oct 2023 18:46:02 +0000 (UTC)
Received: from [10.22.32.140] (unknown [10.22.32.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA456492BE7;
        Wed, 25 Oct 2023 18:46:01 +0000 (UTC)
Message-ID: <fd3d0d3b-a58c-890e-8a41-841a1d0a149d@redhat.com>
Date:   Wed, 25 Oct 2023 14:46:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH-cgroup 3/4] cgroup/cpuset: Keep track of CPUs in isolated
 partitions
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20231013181122.3518610-1-longman@redhat.com>
 <20231013181122.3518610-4-longman@redhat.com>
 <ZS-kt6X5Dd1lktAw@slm.duckdns.org>
 <9e2772e3-f615-5e80-6922-5a2dd06a8b07@redhat.com>
 <ZTAfM0msp8Cg-qLy@slm.duckdns.org>
 <59448803-ac86-0762-d828-c3eba431ceb4@redhat.com>
 <ZTc5RXWemIhfrAlS@mtj.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZTc5RXWemIhfrAlS@mtj.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 10/23/23 23:25, Tejun Heo wrote:
> Hello, Waiman.
>
> On Wed, Oct 18, 2023 at 02:24:00PM -0400, Waiman Long wrote:
>> If you mean saving the exclusion cpumask no matter who the caller is, we can
>> add another exclusion cpumask to save it and expose it to sysfs. This should
>> be done in the first workqueue patch, not as part of this patch. I expose
>> this isolated cpumask for testing purpose to be checked by the
>> test_cpuset_prs.sh script for correctness. As said, I can expose it without
>> cgroup_debug if you think the information is useful in general.
> I don't really care where the cpumask is in the source tree. I just want all
> the workqueue cpumasks presented to the userspace in a single place. Also, I
> think it makes sense to publish it to userspace in an easily accessible
> manner as what the eventual configuration ends up being can be confusing and
> the effect it has on the system subtle.

I have added 2 more read-only cpumask sysfs files in v2 to expose the 
information.

Cheers,
Longman

