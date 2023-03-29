Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400DD6CCF4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 03:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjC2BQM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 21:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjC2BQL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 21:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC97D3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 18:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680052523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dKxuuTqWwWNukmjM2t0MLHI1t4BmxOvyVmCaNcAexzc=;
        b=f/BRJM3wQqCRnh2fbjd0sn2f0Zg4P8ftAaTLSSqaS+RQNIaism1AI+ZBDBugbOqK0HWLxj
        CkH1JKgwpbQXbs7Fg/2/IQaVhqPEEqkNdbAcDLI/djFYeS9v6fOrmVSvC1INnQ+6YDyWiP
        S5PMfBj6OA0c/1TamlRkpuKg8DLO/Is=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-g62aqKQVM7S-aml_uceEsg-1; Tue, 28 Mar 2023 21:15:19 -0400
X-MC-Unique: g62aqKQVM7S-aml_uceEsg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29A9C1C05AEB;
        Wed, 29 Mar 2023 01:15:19 +0000 (UTC)
Received: from [10.22.18.156] (unknown [10.22.18.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 756C8492C3E;
        Wed, 29 Mar 2023 01:15:18 +0000 (UTC)
Message-ID: <656e9f38-4204-6e3b-f0e8-b03727a5334d@redhat.com>
Date:   Tue, 28 Mar 2023 21:15:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/4] cgroup/cpuset: Miscellaneous updates
Content-Language: en-US
To:     Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20230317151508.1225282-1-longman@redhat.com>
 <20230328134000.GA1333@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230328134000.GA1333@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/28/23 09:40, Will Deacon wrote:
> Hi Waiman,
>
> On Fri, Mar 17, 2023 at 11:15:04AM -0400, Waiman Long wrote:
>>   v2:
>>    - Add a new patch 1 that fixes a bug introduced by recent v6.2 commit
>>      7a2127e66a00 ("cpuset: Call set_cpus_allowed_ptr() with appropriate
>>      mask for task").
>>    - Make a small twist and additional comment to patch 2 ("cgroup/cpuset:
>>      Skip task update if hotplug doesn't affect current cpuset") as
>>      suggested by Michal.
>>    - Remove v1 patches 3/4 for now for further discussion.
>>
>> This patch series includes miscellaneous update to the cpuset and its
>> testing code.
> FWIW, this series also passes my asymmetric 32-bit tests.

Thanks Will!

Tejun, do you have time to take a look at this series, especially the 
first patch which is a fix that may need to go to stable?

Cheers,
Longman

