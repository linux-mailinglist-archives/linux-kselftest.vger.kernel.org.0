Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022DD7B58F0
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 19:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjJBRlo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 13:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjJBRlo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 13:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE6AAD
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Oct 2023 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696268457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4f3o6Dy0aKfMhbFfem3eSrFYgmkRkeAED7I//e1+Hvw=;
        b=f++GDCc9Dh+wEXNleBc35ffr840YmIeod9BkjLxaEAYVq2hcmeuzPdN6vTZnjclORZ0BrK
        d4yNEyN+PR6qmLvBIdqoNPuEjOUbLYaxoJhJ5mdtpF6ta7YYNKtvwSKS72oQ8kwAYHCZ3Q
        PuxOQB/dHd4L5hns9ECE1M0vpHruFW8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-daL--MNsPvSgVE23VMIfuA-1; Mon, 02 Oct 2023 13:40:53 -0400
X-MC-Unique: daL--MNsPvSgVE23VMIfuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E0583C23641;
        Mon,  2 Oct 2023 17:40:52 +0000 (UTC)
Received: from [10.22.34.33] (unknown [10.22.34.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A1BF2026D4B;
        Mon,  2 Oct 2023 17:40:52 +0000 (UTC)
Message-ID: <a284696f-6c73-02b6-1ce5-1017eb257bb1@redhat.com>
Date:   Mon, 2 Oct 2023 13:40:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH-cgroup] cgroup/cpuset: Enable invalid to valid local
 partition transition
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20230930034402.2776278-1-longman@redhat.com>
 <ed8e013a-ece2-4a9c-142f-e9f62883e7b1@arm.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ed8e013a-ece2-4a9c-142f-e9f62883e7b1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/2/23 06:06, Pierre Gondois wrote:
> Hello Waiman,
>
> I could test the patch using the for-next branch in your tree.
> Just a NIT, it seemed that the message indicating the reason
> the isolated configuration was invalid is not printed anymore:
>
> Commands:
> # mkdir cgroup
> # mount -t cgroup2 none cgroup/
> # mkdir cgroup/A1 cgroup/B1
> # echo "+cpuset" > cgroup/cgroup.subtree_control
> # echo 0-3 > cgroup/A1/cpuset.cpus
> # echo isolated > cgroup/A1/cpuset.cpus.partition
> # echo 4-6 > cgroup/B1/cpuset.cpus
> # cat cgroup/A1/cpuset.cpus.partition
> isolated
> # echo 0-4 > cgroup/A1/cpuset.cpus
> # cat cgroup/A1/cpuset.cpus.partition
> isolated invalid                      <--- used to have '(Cpu list in 
> cpuset.cpus not exclusive)'
> # echo 0-3 > cgroup/A1/cpuset.cpus
> # cat cgroup/A1/cpuset.cpus.partition
> isolated                              <--- now working!
>
>
> But when creating an isolated partition from overlapping cpusets,
> the message is printed:
> # mkdir cgroup
> # mount -t cgroup2 none cgroup/
> # mkdir cgroup/A1 cgroup/B1
> # echo "+cpuset" > cgroup/cgroup.subtree_control
> # echo 0-4 > cgroup/A1/cpuset.cpus
> # echo 4-6 > cgroup/B1/cpuset.cpus
> # echo isolated > cgroup/B1/cpuset.cpus.partition
>
> # cat cgroup/A1/cpuset.cpus.partition
> member
> # cat cgroup/B1/cpuset.cpus.partition
> isolated invalid (Cpu list in cpuset.cpus not exclusive) <--- Complete 
> message printed
>
>
> On 9/30/23 05:44, Waiman Long wrote:
>> When a local partition becomes invalid, it won't transition back to
>> valid partition automatically if a proper "cpuset.cpus.exclusive" or
>> "cpuset.cpus" change is made. Instead, system administrators have to
>> explicitly echo "root" or "isolated" into the "cpuset.cpus.partition"
>> file at the partition root.
>>
>> This patch now enables the automatic transition of an invalid local
>> partition back to valid when there is a proper "cpuset.cpus.exclusive"
>> or "cpuset.cpus" change.
>>
>> Automatic transition of an invalid remote partition to a valid one,
>> however, is not covered by this patch. They still need an explicit
>> write to "cpuset.cpus.partition" to become valid again.
>
> I'm not sure I understand what is meant by 'remote partition',
> is it possible to explain ? Or is the following illustrating what you
> mean ?
>
> # mkdir cgroup
> # mount -t cgroup2 none cgroup/
> # mkdir cgroup/A1 cgroup/B1
> # echo "+cpuset" > cgroup/cgroup.subtree_control
> # echo 0-3 > cgroup/A1/cpuset.cpus
> # echo isolated > cgroup/A1/cpuset.cpus.partition
> # echo 4-6 > cgroup/B1/cpuset.cpus
> # echo isolated > cgroup/B1/cpuset.cpus.partition
>
> # echo 0-4 > cgroup/A1/cpuset.cpus
> # cat cgroup/A1/cpuset.cpus.partition
> isolated invalid
> # cat cgroup/B1/cpuset.cpus.partition
> isolated invalid
>
> # echo 0-3 > cgroup/A1/cpuset.cpus
> # cat cgroup/A1/cpuset.cpus.partition
> isolated
> # cat cgroup/B1/cpuset.cpus.partition
> isolated invalid        <--- The remote CPU is not updated

It is probably another corner case that has not been handled. I will 
look into that.

Thanks for the test.

-Longman


