Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D2C7CDD4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 15:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjJRNbB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 09:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjJRNbA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 09:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E6395
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697635812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9epjmP7Kty1ssiIsSZ+S+PJfjuUvradkqmdI0cYa72M=;
        b=UaCarB08r4tgFYod22SAXVdZ34LGXxn0kHbYDY9x+FsBbSbq+2OLdlK/hD3uKE2uH5MyjM
        ft87id7IjWr8i3fqdS4mooHIAdWJXOiizO49HsdbbqTRlBEDKNfetMF5oURTPFTSTlmmrP
        pTtAFU5fcXDtqVUAPqfOUEcxSTHAmw0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-EsgyIkjGO8qqt7LQPxb3yg-1; Wed, 18 Oct 2023 09:30:06 -0400
X-MC-Unique: EsgyIkjGO8qqt7LQPxb3yg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DF0310201E4;
        Wed, 18 Oct 2023 13:30:05 +0000 (UTC)
Received: from [10.22.17.22] (unknown [10.22.17.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8900968;
        Wed, 18 Oct 2023 13:30:04 +0000 (UTC)
Message-ID: <9e2772e3-f615-5e80-6922-5a2dd06a8b07@redhat.com>
Date:   Wed, 18 Oct 2023 09:30:04 -0400
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZS-kt6X5Dd1lktAw@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/18/23 05:26, Tejun Heo wrote:
> On Fri, Oct 13, 2023 at 02:11:21PM -0400, Waiman Long wrote:
> ...
>> @@ -3875,6 +3931,13 @@ static struct cftype dfl_files[] = {
>>   		.flags = CFTYPE_ONLY_ON_ROOT | CFTYPE_DEBUG,
>>   	},
>>   
>> +	{
>> +		.name = "cpus.isolated",
>> +		.seq_show = cpuset_common_seq_show,
>> +		.private = FILE_ISOLATED_CPULIST,
>> +		.flags = CFTYPE_ONLY_ON_ROOT | CFTYPE_DEBUG,
>> +	},
> I'd much rather show this in a wq sysfs file along with other related masks,
> and not in a DEBUG file.

It can certainly be exposed as a permanent addition to the cgroup 
control files instead of a debug only file. However this set of isolated 
CPUs may be used by others not just by workqueue. So I doubt if it 
should be a sysfs file in the workqueue directory. I can see if it is 
possible to put a symlink there point back to the cgroupfs.

Thanks,
Longman

